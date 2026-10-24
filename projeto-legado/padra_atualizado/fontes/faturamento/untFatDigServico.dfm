inherited frmFatDigServico: TfrmFatDigServico
  Left = 235
  Top = 232
  Width = 1012
  Height = 780
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Servi'#231'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1012
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 735
    Width = 1006
    TabOrder = 7
    ExplicitTop = 735
    ExplicitWidth = 1006
    inherited pnlNomeForm: TPanel
      Left = 835
      TabOrder = 1
      ExplicitLeft = 835
    end
    inherited pnlInfo: TPanel
      Width = 835
      TabOrder = 0
      ExplicitWidth = 835
    end
  end
  object pnlTotais: TPanel [1]
    Left = 0
    Top = 482
    Width = 1006
    Height = 215
    Align = alBottom
    Color = 16770261
    TabOrder = 5
    object pnl1: TPanel
      Left = 796
      Top = 1
      Width = 209
      Height = 117
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      DesignSize = (
        209
        117)
      object lblTotSer: TLabel
        Left = 36
        Top = 9
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Cobran'#231'a:'
      end
      object lbl8: TLabel
        Left = 35
        Top = 75
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Al'#237'quota de ISS:'
      end
      object lbl9: TLabel
        Left = 64
        Top = 97
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor ISS:'
      end
      object imgTotCob: TImage
        Left = 13
        Top = 5
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC61050000002A744558745469746C6500466F6F746572
          3B4164642047726F757020466F6F7465723B466F6F7465723B47726F7570951B
          9BC90000029A49444154384F6D92694F135114862B7BD4FF61200831288AFC01
          3F68E22735311A91486487108B2C2D8A3584BD6CB5382D252C0A944A84885B48
          25880B60A1156380E8078DD10801BADAFDF59C695108DCE49973E7CC9CE7DC3B
          7325342284C179A346BF0091A10508CCE03CEE139DCC0063829AA2AA77F615D5
          440290303C221BBB66681E1AC12DE8B21775C27BAE8AA257FE0B38C90F7B473F
          A1677411DD8F17A11BF908ADC1028DC10C8156D6AC7B27BE53A37ECB55D1DB05
          5135EA37E243E71F3F9C2E1F451F1C2E3F1C1CC57988402008856A9AAB627608
          38192483F691199A61DA3F75EC1CE2FD9B708FF6AE7A6842AD300D3F096EB74D
          ED12447392ED36870F36A717D67FF860A59CD5E1C526E1F307216F9EE4AAD81D
          02B97252B4ABC3DD3A1E98D0DEFF016D7D44EF1C5A7BE670573505AF2F808A46
          E32E410C27D9BE6EF762C3C678B04E71FD5FF4D2EABC08D0366D760F57C5ED10
          DCAC9B10EDDB3BB610CAEE593433BA19FC5A7540182B40A93A1D37DA4F1AA5AA
          3489B4234D14C44A6B5EC2438255AB1B6BCCA65B9CAF52DCA05579BC01B17B49
          FB097CFE2DA0B8F5388C5F8B2545CAD490A044F1026E4F00F2912F210C5BACE0
          27495A86B251D0740CF94DA9185FCA445EC351E4D613B529132C882BAC7E0697
          C70FD9F03264FA1554EA97C32CC146E720A73E45ECACB79CC5A0E50C06CCA7D1
          BF700A598A23E24788CBAF1A87D3ED47916E11855D84D68C02AD05791A33BEAF
          B9D0D09783CC3BC9B85A9D0CED6C3A326E2521A32A0957E4879F8A825CD913D8
          A9939D4E1B63A3FFBF85D3ED137F319FD4CBB244B44E27E052652294AF0F492E
          962770BD24264B6A98C8AE18C3F5F23065A321CAC3B16C0CDF7E6C42215CC385
          D2789C93263C3F2F8D97303CF6B184D84F1CD88383DBE0FB582222740E20F90B
          DA23AA784418B6D30000000049454E44AE426082}
      end
      object Label3: TLabel
        Left = 3
        Top = 31
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Redu'#231#227'o da Base ISS:'
      end
      object Label6: TLabel
        Left = 190
        Top = 75
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '%'
      end
      object Label5: TLabel
        Left = 190
        Top = 31
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '%'
      end
      object Label7: TLabel
        Left = 3
        Top = 53
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Dedu'#231#227'o da Base ISS:'
      end
      object edtTotSer: TEditFocus
        Tag = 99
        Left = 114
        Top = 5
        Width = 73
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPerIss: TEditFocus
        Tag = 99
        Left = 114
        Top = 71
        Width = 73
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValIss: TEditFocus
        Tag = 99
        Left = 114
        Top = 93
        Width = 73
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtRedIss: TEditFocus
        Tag = 99
        Left = 114
        Top = 27
        Width = 73
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDedIss: TEditFocus
        Tag = 99
        Left = 114
        Top = 49
        Width = 73
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 2
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
    object pnlDatas: TPanel
      Left = 1
      Top = 1
      Width = 260
      Height = 117
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 6
        Top = 9
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Agendamento:'
      end
      object Label4: TLabel
        Left = 35
        Top = 33
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Entrega:'
      end
      object edtDtAgeS: TcxDateEdit
        Tag = 99
        Left = 104
        Top = 5
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        Width = 93
      end
      object edtDtEntS: TcxDateEdit
        Tag = 99
        Left = 104
        Top = 30
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        Width = 93
      end
      object edtHrAgeS: TMaskEditFocus
        Tag = 99
        Left = 198
        Top = 5
        Width = 41
        Height = 24
        AutoSize = False
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtHrEntS: TMaskEditFocus
        Tag = 99
        Left = 198
        Top = 30
        Width = 41
        Height = 24
        AutoSize = False
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object pnlPraEnt: TPanel
      Left = 261
      Top = 1
      Width = 192
      Height = 117
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label12: TLabel
        Left = 1
        Top = 9
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prazo de Entrega:'
      end
      object Label13: TLabel
        Left = 155
        Top = 9
        Width = 20
        Height = 14
        Caption = 'dias'
      end
      object edtPraEnt: TEditFocus
        Tag = 99
        Left = 91
        Top = 5
        Width = 60
        Height = 22
        Alignment = taRightJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object Panel1: TPanel
      Left = 597
      Top = 1
      Width = 199
      Height = 117
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblNroCei: TLabel
        Left = 20
        Top = 9
        Width = 73
        Height = 14
        Caption = 'N'#250'mero do CEI:'
      end
      object lblTotIse: TLabel
        Left = 64
        Top = 31
        Width = 57
        Height = 14
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Total Isento:'
        ParentBiDiMode = False
      end
      object lblTotRat: TLabel
        Left = 63
        Top = 53
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Rateio:'
      end
      object imgTotRat: TImage
        Left = 40
        Top = 49
        Width = 23
        Height = 22
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC610500000024744558745469746C65005461626C653B
          526F773B536570657261746F723B4E65773B496E73657274E19A4FBC0000021E
          49444154384FA5524B4F534118FDA818A889FA1F58BB71E3CEC48531B271E3C6
          444D7C01D696D2726BDF0FDADBD252DB828858898A54AC405F4023AD40534A15
          91C06F115013591DBFB9AD2C8AA6317EC9B9DFDC3B73CECC3D7308C021B85A18
          C718AD8CE34D20D6B4340AB4C626B72AC3533B88BDDE46E4D516C22FBE6068E2
          3382F10DF8C7AB90C7D6E11D5D8333525C57841A04DAFC4F4A3C6C5EFDBE7941
          50370AA8DDB1A298C7FE8F03EC7DFB89BDEF07D86588F1EE3E83FB5746AF3B2D
          08271A05DA4C72A66C09E6610EE4619217949D8C0339F479B2D0BB33D039D3D0
          3A52E83225D6787D3B753A4A387773B8835F5475B4334E324EFD05A7EB5DCD50
          D125DB0AAE78CA387B2DDA214E119DDC2E455E0AF33629C4E60DC63F21305E25
          DF580503A36578464AE48CADC0F1E883308BE8A2791937467670D9AE9847EE68
          811D5E2247F83DD94279B20C2E90C93F4F922F47466F96FA3C69EA75A548E79C
          53D6D305A9884EFB2ACE5C0D2B27B0861661092E1E92FAEB24BD5B2191D63E43
          1ADB0CF558933581F38625852CFE477C90E45CC1E8CDC0E0C990DE9562D3E6A0
          B5CF0A12EE5BDFA1DB9CA4AE876F71CF345D5004C4E337B8FE3F89C1E71B95A1
          894D7047E0D947C84FAB4AF23C8FCB70C556E1882CC3162E8A2BFE7312D9381E
          36AF1E4B52108E265192B362BE6912EF480941389A448D6DBAAC73CE0AE3A061
          D3C44EDD35D370577A83DBC6046E19A670FD41BC96C406817F4C22A97E01335A
          0BDBC02F93590000000049454E44AE426082}
      end
      object imgTotIse: TImage
        Left = 40
        Top = 27
        Width = 23
        Height = 22
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC610500000020744558745469746C650052656D6F7665
          3B47726F75703B466F6F7465723B44656C6574654677D13D000002CE49444154
          384F6D926B48536118C7976E6A862114241945101185DF8A3ED48792A8A80FF5
          25E84362D1854CD450F1926DA629638A785FB3A95B9A332FD3540C4B86899979
          9BD3269862884D05CDE92ECE5DFDF7BC4733C55EF89DE7E539E7FF7BCF7BCECB
          A3E125AF19EA28ADD381A3560739A36608AF8912C63B861632AAD2CAFECF94F1
          06C063B0E19D53DE47F3F5B1F617BAFC8F2C792F4BF1E9917F02D664372B9B47
          51D1AC87B2490F45E37794A94750AA1E869CDE2C57F18D7B462CEB6129C15601
          5F2CFBCADD5C597563C5E6A2EA82D5E68695556EBE8EC7B3860C69374BF96C13
          B0E61A19CA1A86515A4FFBA7154B6AD9FEB578457B97566B219177C34D82B4C2
          AE1D02016B32BBD9EA8279C509D3262E98A867B23AB14CB8DC6B10E576B294EF
          368128AF93B3CB36562B566951543588C2B744E5000A2A069029ED82D3E5414A
          4EC70E810F6B32BBD1E2C49299E18091AA71B31226071C2448926858CA6F9B20
          294BC3D9B7AE98CF78D30F4DCF14A60C4BD08ECEC2EE74A34F6760A93D841797
          A6E19B206EE7EC0B263B7E3396EDDCDC42DFC138A8C5CF070F319D5F00ABC90C
          7DBA04BA2BD766DB2F845EA62C27F18DCBF804BBC30351E3E43AEA49A4364C62
          7CD68CD1F07BB0753561BE24072361E1982B96C0D2A6C297F3A1BF28CB6702BF
          98F436D81C6E08EBC721AC9BC0F3BA718EBE8945F4250A312D8A84ED7D21CC2D
          4A58555998880E43CDF110E5A6202AF50356EC6E3C55E811534E940D23BA6C04
          D94D3FA01B9BC1C74BD7B190F904E6A278CC25DF85EAD829C369FF807D94E5B6
          E017296C85854E9C854E1BC34CFF9F615B7560202105932F12B1941D8599D8DB
          584CBB8FB1D808541C3EA9A0AC80097C1E25A83511292D78FC6C83E4668E21BD
          01AD6742319F1983FE9B17A10C398BDEABE76088BF83BCC0E039CAFA32C12E26
          21FC09F67BB6B237F3C0D15BAAE0130BE2C083D587BC05475E060455490282E6
          E376EFBFC1E3F1F87F0061ECA094A729A7280000000049454E44AE426082}
      end
      object edtNroCei: TEditFocus
        Left = 96
        Top = 5
        Width = 101
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 15
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotIse: TEditFocus
        Tag = 99
        Left = 124
        Top = 27
        Width = 73
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotRat: TEditFocus
        Tag = 99
        Left = 124
        Top = 49
        Width = 73
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
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
    object pnlOutVen: TPanel
      Left = 1
      Top = 191
      Width = 1004
      Height = 23
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 4
      Visible = False
      object shpOutVen: TShape
        Left = 3
        Top = 5
        Width = 12
        Height = 12
        Brush.Color = cl3DLight
      end
      object Label1: TLabel
        Left = 17
        Top = 4
        Width = 268
        Height = 14
        Caption = 'Servi'#231'os de outro Vendedor (N'#227'o podem ser alterados)'
      end
    end
    object pnlMunicipioNatureza: TPanel
      Left = 1
      Top = 118
      Width = 1004
      Height = 73
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 5
      object pnlNaturezaServico: TPanel
        Left = 266
        Top = 1
        Width = 396
        Height = 67
        BevelOuter = bvNone
        TabOrder = 1
        object chkNatureza: TcxCheckGroup
          Tag = 99
          Left = 0
          Top = 0
          Align = alClient
          Caption = 'Natureza do Servi'#231'o'
          Properties.Columns = 3
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Sem Dedu'#231#227'o'
            end
            item
              Caption = 'Com Dedu'#231#227'o / Materiais'
            end
            item
              Caption = 'Imune / Isenta de ISSQN'
            end
            item
              Caption = 'Devolu'#231#227'o / Simples remessa'
            end
            item
              Caption = 'Sociedade civil'
            end
            item
              Caption = 'Intermedia'#231#227'o'
            end>
          Properties.OnChange = chkNaturezaPropertiesChange
          Properties.OnEditValueToStates = chkNaturezaPropertiesEditValueToStates
          Properties.OnStatesToEditValue = chkNaturezaPropertiesStatesToEditValue
          TabOrder = 0
          Height = 67
          Width = 396
        end
      end
      object pnlMunicipioServico: TPanel
        Left = 4
        Top = 1
        Width = 256
        Height = 67
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        object rdgMunicipioServico: TRadioGroup
          Left = 0
          Top = 0
          Width = 256
          Height = 67
          Align = alClient
          Caption = 'Munic'#237'pio de Presta'#231#227'o dos Servi'#231'os:'
          ItemIndex = 0
          Items.Strings = (
            'Munic'#237'pio da Empresa'
            'Munic'#237'pio do Cliente'
            'Munic'#237'pio do Endere'#231'o de Entrega')
          TabOrder = 0
        end
      end
    end
  end
  object pnlDadosEstatisticos: TPanel [2]
    Left = 0
    Top = 338
    Width = 1006
    Height = 144
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    DesignSize = (
      1006
      144)
    object lbl4: TLabel
      Left = 25
      Top = 7
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Profissionais:'
    end
    object lblPreVis: TLabel
      Left = 196
      Top = 7
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data In'#237'cio da Obra:'
    end
    object lbl1: TLabel
      Left = 381
      Top = 7
      Width = 108
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data T'#233'rmino da Obra:'
    end
    object lbl2: TLabel
      Left = 36
      Top = 39
      Width = 69
      Height = 70
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'#13#10'Pressione TAB para ir ao pr'#243'ximo Campo'
      WordWrap = True
    end
    object edtNroPro: TEditFocus
      Tag = 99
      Left = 109
      Top = 3
      Width = 68
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object mskSerIni: TMaskEditFocus
      Tag = 99
      Left = 292
      Top = 3
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskSerFin: TMaskEditFocus
      Tag = 99
      Left = 492
      Top = 3
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mmoSerObs: TMemoFocus
      Tag = 99
      Left = 109
      Top = 31
      Width = 888
      Height = 109
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssVertical
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object btnAdendos: TBitBtnLocked
      Left = 24
      Top = 115
      Width = 81
      Height = 25
      Caption = '[F3] Adendos'
      TabOrder = 3
      OnClick = btnAdendosClick
    end
    object pnlAlerta: TPanel
      Left = 47
      Top = 69
      Width = 832
      Height = 32
      BevelOuter = bvNone
      Caption = 
        'Jovem! Ao colocar ou retirar um controle da linha de servi'#231'os, i' +
        'ncluindo conteudo dos bot'#245'es, adequar '#224' fun'#231#227'o "pRemanejaServico' +
        's" '
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
  end
  object pnlPrisma: TPanel [3]
    Left = 0
    Top = 274
    Width = 1006
    Height = 64
    Align = alBottom
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      1006
      64)
    object lblTmpMed: TLabel
      Left = 393
      Top = 6
      Width = 238
      Height = 14
      Alignment = taRightJustify
      Caption = '(*) T.M.: Tempo M'#233'dio para Realiza'#231#227'o do Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblTmpTot: TLabel
      Left = 840
      Top = 5
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Tempo Total:'
      ExplicitLeft = 672
    end
    object edtTotTmp: TEditFocus
      Tag = 99
      Left = 901
      Top = 1
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 1
      Width = 256
      Height = 62
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Image1: TImage
        Left = 3
        Top = -2
        Width = 23
        Height = 22
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC61050000002A744558745469746C6500466F6F746572
          3B4164642047726F757020466F6F7465723B466F6F7465723B47726F7570951B
          9BC90000029A49444154384F6D92694F135114862B7BD4FF61200831288AFC01
          3F68E22735311A91486487108B2C2D8A3584BD6CB5382D252C0A944A84885B48
          25880B60A1156380E8078DD10801BADAFDF59C695108DCE49973E7CC9CE7DC3B
          7325342284C179A346BF0091A10508CCE03CEE139DCC0063829AA2AA77F615D5
          440290303C221BBB66681E1AC12DE8B21775C27BAE8AA257FE0B38C90F7B473F
          A1677411DD8F17A11BF908ADC1028DC10C8156D6AC7B27BE53A37ECB55D1DB05
          5135EA37E243E71F3F9C2E1F451F1C2E3F1C1CC57988402008856A9AAB627608
          38192483F691199A61DA3F75EC1CE2FD9B708FF6AE7A6842AD300D3F096EB74D
          ED12447392ED36870F36A717D67FF860A59CD5E1C526E1F307216F9EE4AAD81D
          02B97252B4ABC3DD3A1E98D0DEFF016D7D44EF1C5A7BE670573505AF2F808A46
          E32E410C27D9BE6EF762C3C678B04E71FD5FF4D2EABC08D0366D760F57C5ED10
          DCAC9B10EDDB3BB610CAEE593433BA19FC5A7540182B40A93A1D37DA4F1AA5AA
          3489B4234D14C44A6B5EC2438255AB1B6BCCA65B9CAF52DCA05579BC01B17B49
          FB097CFE2DA0B8F5388C5F8B2545CAD490A044F1026E4F00F2912F210C5BACE0
          27495A86B251D0740CF94DA9185FCA445EC351E4D613B529132C882BAC7E0697
          C70FD9F03264FA1554EA97C32CC146E720A73E45ECACB79CC5A0E50C06CCA7D1
          BF700A598A23E24788CBAF1A87D3ED47916E11855D84D68C02AD05791A33BEAF
          B9D0D09783CC3BC9B85A9D0CED6C3A326E2521A32A0957E4879F8A825CD913D8
          A9939D4E1B63A3FFBF85D3ED137F319FD4CBB244B44E27E052652294AF0F492E
          962770BD24264B6A98C8AE18C3F5F23065A321CAC3B16C0CDF7E6C42215CC385
          D2789C93263C3F2F8D97303CF6B184D84F1CD88383DBE0FB582222740E20F90B
          DA23AA784418B6D30000000049454E44AE426082}
      end
      object ColorLabel1: TColorLabel
        Left = 26
        Top = 3
        Width = 81
        Height = 14
        Caption = 'Cobran'#231'a em NS'
        CorDestaque = clMaroon
      end
      object ColorLabel5: TColorLabel
        Left = 123
        Top = 3
        Width = 118
        Height = 14
        Caption = '(Alt+F1) ou (Ctrl+Alt+F1)'
        CorDestaque = clTeal
      end
      object ColorLabel2: TColorLabel
        Left = 26
        Top = 22
        Width = 94
        Height = 14
        Caption = 'Isento de Cobran'#231'a'
        CorDestaque = clMaroon
      end
      object Image2: TImage
        Left = 3
        Top = 17
        Width = 23
        Height = 22
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC610500000020744558745469746C650052656D6F7665
          3B47726F75703B466F6F7465723B44656C6574654677D13D000002CE49444154
          384F6D926B48536118C7976E6A862114241945101185DF8A3ED48792A8A80FF5
          25E84362D1854CD450F1926DA629638A785FB3A95B9A332FD3540C4B86899979
          9BD3269862884D05CDE92ECE5DFDF7BC4733C55EF89DE7E539E7FF7BCF7BCECB
          A3E125AF19EA28ADD381A3560739A36608AF8912C63B861632AAD2CAFECF94F1
          06C063B0E19D53DE47F3F5B1F617BAFC8F2C792F4BF1E9917F02D664372B9B47
          51D1AC87B2490F45E37794A94750AA1E869CDE2C57F18D7B462CEB6129C15601
          5F2CFBCADD5C597563C5E6A2EA82D5E68695556EBE8EC7B3860C69374BF96C13
          B0E61A19CA1A86515A4FFBA7154B6AD9FEB578457B97566B219177C34D82B4C2
          AE1D02016B32BBD9EA8279C509D3262E98A867B23AB14CB8DC6B10E576B294EF
          368128AF93B3CB36562B566951543588C2B744E5000A2A069029ED82D3E5414A
          4EC70E810F6B32BBD1E2C49299E18091AA71B31226071C2448926858CA6F9B20
          294BC3D9B7AE98CF78D30F4DCF14A60C4BD08ECEC2EE74A34F6760A93D841797
          A6E19B206EE7EC0B263B7E3396EDDCDC42DFC138A8C5CF070F319D5F00ABC90C
          7DBA04BA2BD766DB2F845EA62C27F18DCBF804BBC30351E3E43AEA49A4364C62
          7CD68CD1F07BB0753561BE24072361E1982B96C0D2A6C297F3A1BF28CB6702BF
          98F436D81C6E08EBC721AC9BC0F3BA718EBE8945F4250A312D8A84ED7D21CC2D
          4A58555998880E43CDF110E5A6202AF50356EC6E3C55E811534E940D23BA6C04
          D94D3FA01B9BC1C74BD7B190F904E6A278CC25DF85EAD829C369FF807D94E5B6
          E017296C85854E9C854E1BC34CFF9F615B7560202105932F12B1941D8599D8DB
          584CBB8FB1D808541C3EA9A0AC80097C1E25A83511292D78FC6C83E4668E21BD
          01AD6742319F1983FE9B17A10C398BDEABE76088BF83BCC0E039CAFA32C12E26
          21FC09F67BB6B237F3C0D15BAAE0130BE2C083D587BC05475E060455490282E6
          E376EFBFC1E3F1F87F0061ECA094A729A7280000000049454E44AE426082}
      end
      object Image3: TImage
        Left = 3
        Top = 36
        Width = 23
        Height = 22
        Center = True
        Picture.Data = {
          0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
          00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
          67414D410000B18F0BFC610500000024744558745469746C65005461626C653B
          526F773B536570657261746F723B4E65773B496E73657274E19A4FBC0000021E
          49444154384FA5524B4F534118FDA818A889FA1F58BB71E3CEC48531B271E3C6
          444D7C01D696D2726BDF0FDADBD252DB828858898A54AC405F4023AD40534A15
          91C06F115013591DBFB9AD2C8AA6317EC9B9DFDC3B73CECC3D7308C021B85A18
          C718AD8CE34D20D6B4340AB4C626B72AC3533B88BDDE46E4D516C22FBE6068E2
          3382F10DF8C7AB90C7D6E11D5D8333525C57841A04DAFC4F4A3C6C5EFDBE7941
          50370AA8DDB1A298C7FE8F03EC7DFB89BDEF07D86588F1EE3E83FB5746AF3B2D
          08271A05DA4C72A66C09E6610EE4619217949D8C0339F479B2D0BB33D039D3D0
          3A52E83225D6787D3B753A4A387773B8835F5475B4334E324EFD05A7EB5DCD50
          D125DB0AAE78CA387B2DDA214E119DDC2E455E0AF33629C4E60DC63F21305E25
          DF580503A36578464AE48CADC0F1E883308BE8A2791937467670D9AE9847EE68
          811D5E2247F83DD94279B20C2E90C93F4F922F47466F96FA3C69EA75A548E79C
          53D6D305A9884EFB2ACE5C0D2B27B0861661092E1E92FAEB24BD5B2191D63E43
          1ADB0CF558933581F38625852CFE477C90E45CC1E8CDC0E0C990DE9562D3E6A0
          B5CF0A12EE5BDFA1DB9CA4AE876F71CF345D5004C4E337B8FE3F89C1E71B95A1
          894D7047E0D947C84FAB4AF23C8FCB70C556E1882CC3162E8A2BFE7312D9381E
          36AF1E4B52108E265192B362BE6912EF480941389A448D6DBAAC73CE0AE3A061
          D3C44EDD35D370577A83DBC6046E19A670FD41BC96C406817F4C22A97E01335A
          0BDBC02F93590000000049454E44AE426082}
      end
      object ColorLabel3: TColorLabel
        Left = 26
        Top = 41
        Width = 79
        Height = 14
        Caption = 'Ratear nos Itens'
        CorDestaque = clMaroon
      end
      object ColorLabel6: TColorLabel
        Left = 123
        Top = 41
        Width = 118
        Height = 14
        Caption = '(Alt+F3) ou (Ctrl+Alt+F3)'
        CorDestaque = clTeal
      end
      object ColorLabel4: TColorLabel
        Left = 123
        Top = 22
        Width = 118
        Height = 14
        Caption = '(Alt+F2) ou (Ctrl+Alt+F2)'
        CorDestaque = clTeal
      end
    end
  end
  inherited pnlBotoes: TPanel [4]
    Top = 697
    Width = 1006
    Height = 38
    TabOrder = 6
    ExplicitTop = 697
    ExplicitWidth = 1006
    ExplicitHeight = 38
    inherited FlwBotoes: TFlowPanel
      Left = 822
      Width = 119
      Height = 34
      TabOrder = 8
      ExplicitLeft = 822
      ExplicitWidth = 119
      ExplicitHeight = 34
      object btnMecPadrao: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 34
        Align = alLeft
        Caption = 'Definir Mec'#226'nico Padr'#227'o'
        TabOrder = 0
        WordWrap = True
        OnClick = btnMecPadraoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 941
      Top = 2
      Width = 63
      Height = 34
      Align = alRight
      TabOrder = 7
      ExplicitLeft = 941
      ExplicitTop = 2
      ExplicitWidth = 63
      ExplicitHeight = 34
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 70
      Height = 34
      Align = alLeft
      Caption = '&Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAcompanhaServ: TBitBtnLocked
      Left = 72
      Top = 2
      Width = 150
      Height = 34
      Align = alLeft
      Caption = '[F5] Acompanhamento de Servi'#231'os'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000010000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D120D000F180F00111E1000122412001429
        1300152E140016331500173C160018451700194F18001A5718001B5C19001B62
        19001B6619001B6919001B6C19001B6E19001B7119001A7419001A7619001A78
        19001A7A19001A7D1900197F1900198019001980190019811900198019001980
        19001E801B0025801D002C802000338122003B82260044842A0057873200708C
        3B00869144009B944C00B2995600C19D5D00CCA06200D1A26300D5A46600D5A3
        6400D6A26200D69E5E00D69B5A00D5975500D3914E00D0894400D1843E00D181
        3800D3803300D47F2F00D27E3100CF7C3200CD7A3300C9763300C7743200C270
        3200BE6D3400BA6A3200B5653100B1612E00AF5E2D00AC5C2C00A95A2C00A658
        2C00A2552C009E522C009B4F2B00974C2A00954A290093492800934927009248
        2700904826008F4725008E4723008D4722008B4622008A452200884422008643
        22008542220085422300864224008743250088442B008846310087483B00854B
        4600834E54007F5161007B59740076608600726797006C6CA5006770AF006373
        B8005F75C0005977C9005577D1005377D5005277D800527CDC005280DE005283
        DF005182DD004F80DB004C7BD8004B7BD800497AD7004779D6004172D2003B6C
        CF003665CB003160C8002D5BC4002956C1002552BD00224FB800204FB5001F50
        B3001D4EB0001A4AAE001D50AB002156A6002556A4002957A3002E58A200335B
        A0003D5F9D0047649A0050689700586C9400627191006B768E00747A8B007C7E
        8800828186008483850085848500868584008785840087858400878684008886
        84008886840089878500898785008A8886008B8987008C8B89008F8D8B00918F
        8E009392900096949300989796009B9A99009E9D9C00A2A1A000A4A4A300A7A7
        A600AAAAA900ADADAD00B1B1B100B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500CCCBCA00D3D1CF00D9D6D300E2C1
        DB00EBA1E300F185EA00F56DEE00F85AF200FA49F500FC37F700FD27FA00FD1C
        FB00FE13FC00FE0CFD00FE06FE00FE03FE00FE01FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE01FE00FE07FE00FE16FD00FE2AFC00FE51
        F900FE84F400FEA6F100FECAEF00FEE1ED00FEEBED00FEF1ED00FEF4EE00FEF6
        EE00FEF5EC00FEF5EA00FDF3E700FDF1E400FDF0E100FDEFDE00FDECD900FEE9
        D300FEE7CE00FEE5CA00FDE4C800FDE3C600FDE2C400FDE2C400DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDD5356585858585858585858585858555362F1F4A1F8F9
        A1FBFBA1FEFEA1FEFE5A62F5A1A1A1A1A1A1A1A1A1A1A1A1A15C62A1A1F3768B
        F7271AF93569FC798D5C62F1A1F1768BF7271AF93569FC798D5C62A1A1F1768B
        F7271AF9FDFDFC798D5C62F1A1F1768BF72A1AF9FDFDFC798D5C62A1A1F1768B
        F7271AF9FAFBFCFEFE5C62F1A1F1F1F3F72A1AF8F9FAFCFEFE5C63A1A1F1F1F3
        F7F7F7F7F8F9FBFDFE564B3A3939393939393939383A3838364A4F4343434343
        4343434338433834754EDD5050505050505050504E504D5253DDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
      TabOrder = 1
      WordWrap = True
      OnClick = btnAcompanhaServClick
    end
    object btnAgendamentosProg: TBitBtnLocked
      Left = 222
      Top = 2
      Width = 120
      Height = 34
      Align = alLeft
      Caption = '[F6] Agendamentos Programados'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000010000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D120D000F180F00111E1000122412001429
        1300152E140016331500173C160018451700194F18001A5718001B5C19001B62
        19001B6619001B6919001B6C19001B6E19001B7119001A7419001A7619001A78
        19001A7A19001A7D1900197F1900198019001980190019811900198019001980
        19001E801B0025801D002C802000338122003B82260044842A0057873200708C
        3B00869144009B944C00B2995600C19D5D00CCA06200D1A26300D5A46600D5A3
        6400D6A26200D69E5E00D69B5A00D5975500D3914E00D0894400D1843E00D181
        3800D3803300D47F2F00D27E3100CF7C3200CD7A3300C9763300C7743200C270
        3200BE6D3400BA6A3200B5653100B1612E00AF5E2D00AC5C2C00A95A2C00A658
        2C00A2552C009E522C009B4F2B00974C2A00954A290093492800934927009248
        2700904826008F4725008E4723008D4722008B4622008A452200884422008643
        22008542220085422300864224008743250088442B008846310087483B00854B
        4600834E54007F5161007B59740076608600726797006C6CA5006770AF006373
        B8005F75C0005977C9005577D1005377D5005277D800527CDC005280DE005283
        DF005182DD004F80DB004C7BD8004B7BD800497AD7004779D6004172D2003B6C
        CF003665CB003160C8002D5BC4002956C1002552BD00224FB800204FB5001F50
        B3001D4EB0001A4AAE001D50AB002156A6002556A4002957A3002E58A200335B
        A0003D5F9D0047649A0050689700586C9400627191006B768E00747A8B007C7E
        8800828186008483850085848500868584008785840087858400878684008886
        84008886840089878500898785008A8886008B8987008C8B89008F8D8B00918F
        8E009392900096949300989796009B9A99009E9D9C00A2A1A000A4A4A300A7A7
        A600AAAAA900ADADAD00B1B1B100B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500CCCBCA00D3D1CF00D9D6D300E2C1
        DB00EBA1E300F185EA00F56DEE00F85AF200FA49F500FC37F700FD27FA00FD1C
        FB00FE13FC00FE0CFD00FE06FE00FE03FE00FE01FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE01FE00FE07FE00FE16FD00FE2AFC00FE51
        F900FE84F400FEA6F100FECAEF00FEE1ED00FEEBED00FEF1ED00FEF4EE00FEF6
        EE00FEF5EC00FEF5EA00FDF3E700FDF1E400FDF0E100FDEFDE00FDECD900FEE9
        D300FEE7CE00FEE5CA00FDE4C800FDE3C600FDE2C400FDE2C400DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDD5356585858585858585858585858555362F1F4A1F8F9
        A1FBFBA1FEFEA1FEFE5A62F5A1A1A1A1A1A1A1A1A1A1A1A1A15C62A1A1F3768B
        F7271AF93569FC798D5C62F1A1F1768BF7271AF93569FC798D5C62A1A1F1768B
        F7271AF9FDFDFC798D5C62F1A1F1768BF72A1AF9FDFDFC798D5C62A1A1F1768B
        F7271AF9FAFBFCFEFE5C62F1A1F1F1F3F72A1AF8F9FAFCFEFE5C63A1A1F1F1F3
        F7F7F7F7F8F9FBFDFE564B3A3939393939393939383A3838364A4F4343434343
        4343434338433834754EDD5050505050505050504E504D5253DDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
      TabOrder = 2
      WordWrap = True
      OnClick = btnAgendamentosProgClick
    end
    object btnIdentTodos: TBitBtnLocked
      Left = 342
      Top = 2
      Width = 140
      Height = 34
      Align = alLeft
      Caption = '[F7] Identificar Todos os Servi'#231'os'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000060000
        000A0000000A0000000A0000000A0000000B0000000B0000000B0000000B0000
        000B0000000B0000000B0000000B0000000B00000007000000027E5D52BDAF82
        72FFAF8272FFAE8172FFAE8072FFAE8071FFAE8071FFAE8070FFAD8070FFAD7F
        70FFAD7F70FFAC7F6FFFAC7F6FFFAD7E6FFF7C5B4FBE00000007B28577FFFCF8
        F6FFFCF8F5FFFBF7F6FFFBF7F5FFFBF7F5FFFBF7F5FFFBF6F4FFFBF6F4FFFBF6
        F3FFFBF6F3FFFBF6F3FFFAF5F2FFFAF5F2FFAE8072FF0000000AB5897AFFFCF9
        F7FF2672CBFF256EC8FF236BC5FFF8EEEAFFF7EFEAFFFCF7F5FFFBF7F4FFFBF7
        F5FFFBF7F5FFFBF7F4FFF7EFEAFFFBF6F3FFB18475FF0000000AB68C7EFFFDFA
        F8FF3186DAFF4F9DE1FF2875CDFFF8EFEAFFF7EEEAFF966555FFB18475FFB084
        75FFB08475FFB18474FFF7EEE9FFFBF7F5FFB28778FF00000009B98F81FFFDFB
        F9FF3592E2FF338FDEFF2A7FD6FFF7EFEBFFF7EFEBFFF7EFEAFFF7EFEAFFF8EF
        EAFFF8EFEAFFF7EFEAFFF7EFEAFFFBF7F6FFB58A7CFF00000009BB9385FFFDFB
        FAFFF7F0EBFFF8EFEBFFF8F0EBFFF7EFEBFFF7EFEBFFF7F0EBFFF8EFEBFFF7EF
        EAFFF8EFEAFFF7EFEAFFF8EFEBFFFCF9F7FFB88E7FFF00000008BE9688FFFEFC
        FBFFD18D51FFCE874EFFCC844BFFF8EFEBFFF8F0EBFFFBF7F5FFFBF7F5FFFBF7
        F5FFFBF7F5FFFCF7F5FFF8EFEBFFFCF9F8FFBA9183FF00000007C0998BFFFEFC
        FCFFDEA164FFE3B380FFD49053FFF8F0ECFFF8F0ECFF9C6B5DFFB68B7DFFB58B
        7CFFB68A7CFFB58A7CFFF8EFEBFFFDFAF9FFBD9587FF00000007C29C8EFFFEFD
        FCFFE3A86DFFE1A66AFFDA985CFFF8F0ECFFF8F0ECFFF8F0ECFFF8F0ECFFF8F0
        ECFFF8EFECFFF8EFEBFFF8F0ECFFFDFBFAFFC0978AFF00000006C49E91FFFEFE
        FDFFF9F0EDFFF8F1EDFFF9F0EDFFF9F0EDFFF8F1EDFFF8F0EDFFF8F1ECFFF8F0
        EDFFF8F0ECFFF8F0ECFFF8F0ECFFFDFCFBFFC29B8DFF00000006C6A093FFFFFE
        FEFF5865CCFF5661C9FF535DC6FFF8F1EDFFF8F0EDFFFCF8F6FFFCF8F6FFFCF8
        F6FFFCF8F6FFFCF8F6FFF8F0EDFFFEFCFBFFC49E90FF00000005C7A396FFFFFE
        FEFF6A7CDAFF8694E2FF5968CEFFF9F1EDFFF9F1EEFFA27164FFBA9184FFBA91
        83FFB99083FFB99082FFF8F1EDFFFEFDFCFFC5A093FF00000005C8A497FFFFFF
        FFFF6E86E0FF6D82DEFF5F73D6FFF9F2EEFFF9F1EEFFF9F2EEFFF8F1EEFFF8F1
        EEFFF9F1EDFFF8F1EDFFF8F1EDFFFEFDFDFFC7A295FF00000004CAA699FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFEFEFFC8A497FF00000003967C72BECAA7
        9AFFCAA79AFFCAA79AFFCAA79AFFCAA79AFFCAA699FFCAA699FFCAA699FFCAA6
        99FFCAA699FFCAA699FFCAA699FFCAA699FF967B70BF00000002}
      TabOrder = 3
      WordWrap = True
      OnClick = btnIdentTodosClick
    end
    object btnDisSer: TBitBtnLocked
      Left = 482
      Top = 2
      Width = 140
      Height = 34
      Align = alLeft
      Caption = '[F8] Discrimina'#231#227'o dos Servi'#231'os'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000060000
        000A0000000A0000000A0000000A0000000B0000000B0000000B0000000B0000
        000B0000000B0000000B0000000B0000000B00000007000000027E5D52BDAF82
        72FFAF8272FFAE8172FFAE8072FFAE8071FFAE8071FFAE8070FFAD8070FFAD7F
        70FFAD7F70FFAC7F6FFFAC7F6FFFAD7E6FFF7C5B4FBE00000007B28577FFFCF8
        F6FFFCF8F5FFFBF7F6FFFBF7F5FFFBF7F5FFFBF7F5FFFBF6F4FFFBF6F4FFFBF6
        F3FFFBF6F3FFFBF6F3FFFAF5F2FFFAF5F2FFAE8072FF0000000AB5897AFFFCF9
        F7FF2672CBFF256EC8FF236BC5FFF8EEEAFFF7EFEAFFFCF7F5FFFBF7F4FFFBF7
        F5FFFBF7F5FFFBF7F4FFF7EFEAFFFBF6F3FFB18475FF0000000AB68C7EFFFDFA
        F8FF3186DAFF4F9DE1FF2875CDFFF8EFEAFFF7EEEAFF966555FFB18475FFB084
        75FFB08475FFB18474FFF7EEE9FFFBF7F5FFB28778FF00000009B98F81FFFDFB
        F9FF3592E2FF338FDEFF2A7FD6FFF7EFEBFFF7EFEBFFF7EFEAFFF7EFEAFFF8EF
        EAFFF8EFEAFFF7EFEAFFF7EFEAFFFBF7F6FFB58A7CFF00000009BB9385FFFDFB
        FAFFF7F0EBFFF8EFEBFFF8F0EBFFF7EFEBFFF7EFEBFFF7F0EBFFF8EFEBFFF7EF
        EAFFF8EFEAFFF7EFEAFFF8EFEBFFFCF9F7FFB88E7FFF00000008BE9688FFFEFC
        FBFFD18D51FFCE874EFFCC844BFFF8EFEBFFF8F0EBFFFBF7F5FFFBF7F5FFFBF7
        F5FFFBF7F5FFFCF7F5FFF8EFEBFFFCF9F8FFBA9183FF00000007C0998BFFFEFC
        FCFFDEA164FFE3B380FFD49053FFF8F0ECFFF8F0ECFF9C6B5DFFB68B7DFFB58B
        7CFFB68A7CFFB58A7CFFF8EFEBFFFDFAF9FFBD9587FF00000007C29C8EFFFEFD
        FCFFE3A86DFFE1A66AFFDA985CFFF8F0ECFFF8F0ECFFF8F0ECFFF8F0ECFFF8F0
        ECFFF8EFECFFF8EFEBFFF8F0ECFFFDFBFAFFC0978AFF00000006C49E91FFFEFE
        FDFFF9F0EDFFF8F1EDFFF9F0EDFFF9F0EDFFF8F1EDFFF8F0EDFFF8F1ECFFF8F0
        EDFFF8F0ECFFF8F0ECFFF8F0ECFFFDFCFBFFC29B8DFF00000006C6A093FFFFFE
        FEFF5865CCFF5661C9FF535DC6FFF8F1EDFFF8F0EDFFFCF8F6FFFCF8F6FFFCF8
        F6FFFCF8F6FFFCF8F6FFF8F0EDFFFEFCFBFFC49E90FF00000005C7A396FFFFFE
        FEFF6A7CDAFF8694E2FF5968CEFFF9F1EDFFF9F1EEFFA27164FFBA9184FFBA91
        83FFB99083FFB99082FFF8F1EDFFFEFDFCFFC5A093FF00000005C8A497FFFFFF
        FFFF6E86E0FF6D82DEFF5F73D6FFF9F2EEFFF9F1EEFFF9F2EEFFF8F1EEFFF8F1
        EEFFF9F1EDFFF8F1EDFFF8F1EDFFFEFDFDFFC7A295FF00000004CAA699FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFEFEFFC8A497FF00000003967C72BECAA7
        9AFFCAA79AFFCAA79AFFCAA79AFFCAA79AFFCAA699FFCAA699FFCAA699FFCAA6
        99FFCAA699FFCAA699FFCAA699FFCAA699FF967B70BF00000002}
      TabOrder = 4
      WordWrap = True
      OnClick = btnDisSerClick
    end
    object btnProxPagServ: TBitBtnLocked
      Left = 722
      Top = 2
      Width = 100
      Height = 34
      Align = alLeft
      Caption = '[F12] Pr'#243'x. P'#225'g.'#13#10'Servi'#231'os'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00040000000F0000000F00000007000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000EB0683FFF834324E131190D6A000000110000000600000001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0011B37045FFDEAF77FFB47247FF773C20D2201009500000000F000000050000
        0001000000000000000000000000000000000000000000000000000000000000
        0010B6764BFFECC38FFFE8BA7DFFD8A66FFFAD693FFF6A371CBE170C06400000
        000D000000040000000100000000000000000000000000000000000000000000
        000FBB7C51FFEFCD9CFFE9BB7FFFE8BC80FFEABE83FFD39D6CFFA7623BFD5B30
        1AA90D07032C0000000B00000003000000010000000000000000000000000000
        000EBE8257FFF1D5ACFFEBC087FFE9BF85FFE8BD81FFE9BF82FFE9C087FFCD97
        65FF9F5933F74E29169408040221000000090000000200000000000000000000
        000DC0855EFFF5DEBBFFEDC68FFFEDC58DFFEBC289FFEAC084FFE8BC80FFE9BD
        82FFE8BB87FFC78E60FF965430EE4223137E0000000900000000000000000000
        000CC59067FFF9E9CFFFF3D4A3FFF2D09FFFF0CC98FFEEC890FFEBC088FFE9BE
        83FFEAC38AFFECC693FFE3B889FFA65B33FF0000000D00000000000000000000
        000BC9956EFFFAEFDAFFF4DAAEFFF5D8AAFFF2D5A6FFF1D1A1FFF1D0A2FFF1D2
        A8FFEDCDA1FFCC956BFF9A5D39E33A2314680000000700000000000000000000
        000ACC9B73FFFCF4E3FFF8E0B7FFF6DDB4FFF6DEB4FFF7E2C0FFF6E1C1FFD9B2
        8CFFB0754EF14D301F7E04030216000000060000000100000000000000000000
        0009CDA077FFFEF7E9FFFBE7C2FFFBEBCCFFFBEFD6FFE3C5A7FFC08B65F96544
        2E960B07051E0000000600000002000000000000000000000000000000000000
        0008D0A47CFFFEFBEFFFFDF4E0FFEEDAC1FFD1A07DFF78553CA717100B2C0000
        0007000000020000000000000000000000000000000000000000000000000000
        0007D2A77FFFF5EADBFFD8B291FF916D50BE261C143C00000007000000020000
        0000000000000000000000000000000000000000000000000000000000000000
        0005D5AA83FFA98462D3372B204F000000070000000200000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000040000000500000002000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 6
      WordWrap = True
      OnClick = btnProxPagServClick
    end
    object btnPagAntServ: TBitBtnLocked
      Left = 622
      Top = 2
      Width = 100
      Height = 34
      Align = alLeft
      Caption = '[F11] P'#225'g. Ant.'#13#10'Servi'#231'os'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0002000000080000001200000012000000050000000000000000000000000000
        0000000000000000000000000000000000000000000000000002000000060000
        001332180C6E813C1CE0AC5A2DFF000000130000000000000000000000000000
        000000000000000000000000000000000001000000050000000F231209527E40
        20D4B67042FFDAA66DFFAE5E30FF000000170000000000000000000000000000
        00000000000000000001000000030000000C180E083C733E24BFB66F42FFD6A4
        6DFFE4B77BFFE4B77BFFB06034FF000000160000000000000000000000000000
        000100000002000000090F090529673E25A8B57548FDD7A674FFE7BF89FFE6BB
        80FFE5B87CFFE6B97FFFB26537FF000000150000000000000000000000010000
        00070906041C5B3B2590B4774EF7D8A87CFFECCA9AFFEAC38EFFE9C089FFE8BD
        84FFE7BA81FFE7BE86FFB4693AFF000000140000000000000000000000065139
        2978B17B54ECD7AA82FFEFD1A9FFEFCFA0FFEDC996FFECC793FFEBC490FFE9C1
        8AFFE7BE86FFE9C38FFFB56B3FFF00000013000000000000000000000009CB97
        6FFFF1DCC1FFF3DCB8FFF3D8AEFFF0D2A4FFF0CFA0FFEFD0A1FFEFCF9FFFEDCC
        9BFFEDC996FFEECDA0FFB87043FF000000120000000000000000000000044433
        2661AF815BE1DDB693FFF5E0C3FFF8E3C3FFF6DFB9FFF4DAAFFFF2D5AAFFF0D2
        A4FFEECE9DFFF1D5ABFFBA7648FF000000110000000000000000000000010000
        000405040311533D2B78BF8D67F1E3C2A2FFF8EACEFFF8E6C5FFF5DDB6FFF2D6
        ABFFF0D2A4FFF3DBB5FFBD784CFF000000100000000000000000000000000000
        000000000001000000050C09061B6B4E3894C79772F8E6C9AAFFFAEBCEFFF6E2
        BEFFF2D7ACFFF5E0BCFFBF7C52FF0000000F0000000000000000000000000000
        00000000000000000000000000010000000618120C2B7C583FA7D2A17BFFEBD2
        B4FFF8E6C8FFF8E7C9FFC18456FF0000000E0000000000000000000000000000
        0000000000000000000000000000000000000000000200000007261C133E9167
        4AC0D5A881FFEFDABDFFC3875BFF0000000E0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        000936281C54A37453D5C68C63FF0000000A0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000030000000800000008000000020000000000000000}
      TabOrder = 5
      WordWrap = True
      OnClick = btnPagAntServClick
    end
  end
  object pnlServicos3: TPanel [5]
    Left = 0
    Top = 0
    Width = 1006
    Height = 274
    Align = alClient
    Color = 16770261
    TabOrder = 2
    Visible = False
    DesignSize = (
      1006
      274)
    object lblServico3: TLabel
      Left = 21
      Top = 10
      Width = 49
      Height = 17
      Caption = 'Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe21: TLabel
      Left = 1
      Top = 34
      Width = 21
      Height = 17
      Caption = '21)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblValSer3: TLabel
      Left = 542
      Top = 10
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe22: TLabel
      Left = 1
      Top = 56
      Width = 21
      Height = 17
      Caption = '22)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe23: TLabel
      Left = 1
      Top = 77
      Width = 21
      Height = 17
      Caption = '23)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe24: TLabel
      Left = 1
      Top = 100
      Width = 21
      Height = 17
      Caption = '24)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe25: TLabel
      Left = 1
      Top = 122
      Width = 21
      Height = 17
      Caption = '25)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe26: TLabel
      Left = 1
      Top = 144
      Width = 21
      Height = 17
      Caption = '26)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblUniSer3: TLabel
      Left = 485
      Top = 10
      Width = 39
      Height = 17
      Alignment = taRightJustify
      Caption = 'Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdSer3: TLabel
      Left = 424
      Top = 10
      Width = 36
      Height = 17
      Alignment = taRightJustify
      Caption = 'Qtde.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblStaSer3: TLabel
      Left = 795
      Top = 10
      Width = 95
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Status Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 678
    end
    object lblTmpSer3: TLabel
      Left = 905
      Top = 10
      Width = 36
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'T. M.*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 788
    end
    object btnMecSe21: TSpeedButton
      Left = 346
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe22: TSpeedButton
      Left = 346
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe23: TSpeedButton
      Left = 346
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe24: TSpeedButton
      Left = 346
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe25: TSpeedButton
      Left = 346
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe26: TSpeedButton
      Left = 346
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe21: TSpeedButton
      Left = 370
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe22: TSpeedButton
      Left = 370
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe24: TSpeedButton
      Left = 370
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe23: TSpeedButton
      Left = 370
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe26: TSpeedButton
      Left = 370
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe25: TSpeedButton
      Left = 370
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblPrisma3: TLabel
      Left = 955
      Top = 10
      Width = 47
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'Prisma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 838
    end
    object lblNumSe27: TLabel
      Left = 1
      Top = 166
      Width = 21
      Height = 17
      Caption = '27)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe27: TSpeedButton
      Left = 346
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe27: TSpeedButton
      Left = 370
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe28: TLabel
      Left = 1
      Top = 188
      Width = 21
      Height = 17
      Caption = '28)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe28: TSpeedButton
      Left = 346
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe28: TSpeedButton
      Left = 370
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe29: TLabel
      Left = 1
      Top = 210
      Width = 21
      Height = 17
      Caption = '29)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe29: TSpeedButton
      Left = 346
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe29: TSpeedButton
      Left = 370
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe30: TLabel
      Left = 1
      Top = 232
      Width = 21
      Height = 17
      Caption = '30)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe30: TSpeedButton
      Left = 346
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe30: TSpeedButton
      Left = 370
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblDecSer3: TLabel
      Left = 174
      Top = 10
      Width = 56
      Height = 17
      Alignment = taRightJustify
      Caption = 'Desc. %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblLiqSer3: TLabel
      Left = 244
      Top = 10
      Width = 54
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. L'#237'qui.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnIdent21: TSpeedButton
      Left = 592
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent22: TSpeedButton
      Left = 592
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent23: TSpeedButton
      Left = 592
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent24: TSpeedButton
      Left = 592
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent28: TSpeedButton
      Left = 592
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent27: TSpeedButton
      Left = 592
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent26: TSpeedButton
      Left = 592
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent25: TSpeedButton
      Left = 592
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent29: TSpeedButton
      Left = 592
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent30: TSpeedButton
      Left = 592
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object lblBrinde3: TLabel
      Left = 738
      Top = 10
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Brinde?'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 621
    end
    object btnParSe21: TSpeedButton
      Left = 654
      Top = 30
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe22: TSpeedButton
      Left = 654
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe23: TSpeedButton
      Left = 654
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe24: TSpeedButton
      Left = 654
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe25: TSpeedButton
      Left = 654
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe26: TSpeedButton
      Left = 654
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe27: TSpeedButton
      Left = 654
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe28: TSpeedButton
      Left = 654
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe29: TSpeedButton
      Left = 654
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe30: TSpeedButton
      Left = 654
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object edtDesSe21: TEditFocus
      Tag = 99
      Left = 70
      Top = 32
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe21: TEditFocus
      Tag = 99
      Left = 25
      Top = 32
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe21: TEditFocus
      Tag = 99
      Left = 525
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 4
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
    object edtDesSe22: TEditFocus
      Tag = 99
      Left = 70
      Top = 54
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 95
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe22: TEditFocus
      Tag = 99
      Left = 25
      Top = 54
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 11
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe22: TEditFocus
      Tag = 99
      Left = 525
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 15
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
    object edtDesSe23: TEditFocus
      Tag = 99
      Left = 70
      Top = 76
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 23
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe23: TEditFocus
      Tag = 99
      Left = 25
      Top = 76
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 22
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe23: TEditFocus
      Tag = 99
      Left = 525
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 26
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
    object edtDesSe24: TEditFocus
      Tag = 99
      Left = 70
      Top = 98
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 34
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe24: TEditFocus
      Tag = 99
      Left = 25
      Top = 98
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 33
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe24: TEditFocus
      Tag = 99
      Left = 525
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 37
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
    object edtDesSe25: TEditFocus
      Tag = 99
      Left = 70
      Top = 120
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 45
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe25: TEditFocus
      Tag = 99
      Left = 25
      Top = 120
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 44
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe25: TEditFocus
      Tag = 99
      Left = 525
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 48
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
    object edtDesSe26: TEditFocus
      Tag = 99
      Left = 70
      Top = 142
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 56
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe26: TEditFocus
      Tag = 99
      Left = 25
      Top = 142
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 55
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe26: TEditFocus
      Tag = 99
      Left = 525
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 59
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
    object edtUniSe26: TEditFocus
      Tag = 99
      Left = 461
      Top = 142
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 58
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
    object edtUniSe25: TEditFocus
      Tag = 99
      Left = 461
      Top = 120
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 47
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
    object edtUniSe24: TEditFocus
      Tag = 99
      Left = 461
      Top = 98
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 36
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
    object edtUniSe23: TEditFocus
      Tag = 99
      Left = 461
      Top = 76
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 25
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
    object edtUniSe22: TEditFocus
      Tag = 99
      Left = 461
      Top = 54
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 14
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
    object edtUniSe21: TEditFocus
      Tag = 99
      Left = 461
      Top = 32
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 3
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
    object edtQtdSe26: TEditFocus
      Tag = 99
      Left = 393
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 57
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
    object edtQtdSe25: TEditFocus
      Tag = 99
      Left = 393
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 46
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
    object edtQtdSe24: TEditFocus
      Tag = 99
      Left = 393
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 35
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
    object edtQtdSe23: TEditFocus
      Tag = 99
      Left = 393
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 24
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
    object edtQtdSe22: TEditFocus
      Tag = 99
      Left = 393
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 13
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
    object edtQtdSe21: TEditFocus
      Tag = 99
      Left = 393
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 2
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
    object cmbStaSe21: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 32
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe22: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 54
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe23: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 76
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe24: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 98
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 41
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe25: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 120
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 52
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe26: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 142
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 63
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe21: TEditFocus
      Tag = 99
      Left = 905
      Top = 32
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 9
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe22: TEditFocus
      Tag = 99
      Left = 905
      Top = 54
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 20
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe23: TEditFocus
      Tag = 99
      Left = 905
      Top = 76
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 31
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe24: TEditFocus
      Tag = 99
      Left = 905
      Top = 98
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 42
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe25: TEditFocus
      Tag = 99
      Left = 905
      Top = 120
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 53
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe26: TEditFocus
      Tag = 99
      Left = 905
      Top = 142
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 64
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe21: TEditFocus
      Tag = 99
      Left = 955
      Top = 32
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 10
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe22: TEditFocus
      Tag = 99
      Left = 955
      Top = 54
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 21
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe23: TEditFocus
      Tag = 99
      Left = 955
      Top = 76
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 32
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe24: TEditFocus
      Tag = 99
      Left = 955
      Top = 98
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 43
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe25: TEditFocus
      Tag = 99
      Left = 955
      Top = 120
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 54
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe26: TEditFocus
      Tag = 99
      Left = 955
      Top = 142
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 65
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe27: TEditFocus
      Tag = 99
      Left = 70
      Top = 164
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 67
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe27: TEditFocus
      Tag = 99
      Left = 25
      Top = 164
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 66
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe27: TEditFocus
      Tag = 99
      Left = 525
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 70
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
    object edtUniSe27: TEditFocus
      Tag = 99
      Left = 461
      Top = 164
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 69
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
    object edtQtdSe27: TEditFocus
      Tag = 99
      Left = 393
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 68
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
    object cmbStaSe27: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 164
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 74
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe27: TEditFocus
      Tag = 99
      Left = 905
      Top = 164
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 75
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe27: TEditFocus
      Tag = 99
      Left = 955
      Top = 164
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 76
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe28: TEditFocus
      Tag = 99
      Left = 70
      Top = 186
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 78
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe28: TEditFocus
      Tag = 99
      Left = 25
      Top = 186
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 77
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe28: TEditFocus
      Tag = 99
      Left = 525
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 81
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
    object edtUniSe28: TEditFocus
      Tag = 99
      Left = 461
      Top = 186
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 80
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
    object edtQtdSe28: TEditFocus
      Tag = 99
      Left = 393
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 79
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
    object cmbStaSe28: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 186
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 85
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe28: TEditFocus
      Tag = 99
      Left = 905
      Top = 186
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 86
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe28: TEditFocus
      Tag = 99
      Left = 955
      Top = 186
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 87
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe29: TEditFocus
      Tag = 99
      Left = 70
      Top = 208
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 89
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe29: TEditFocus
      Tag = 99
      Left = 25
      Top = 208
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 88
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe29: TEditFocus
      Tag = 99
      Left = 525
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 92
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
    object edtUniSe29: TEditFocus
      Tag = 99
      Left = 461
      Top = 208
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 91
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
    object edtQtdSe29: TEditFocus
      Tag = 99
      Left = 393
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 90
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
    object cmbStaSe29: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 208
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 96
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe29: TEditFocus
      Tag = 99
      Left = 905
      Top = 208
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 97
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe29: TEditFocus
      Tag = 99
      Left = 955
      Top = 208
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 98
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe30: TEditFocus
      Tag = 99
      Left = 70
      Top = 230
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 100
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe30: TEditFocus
      Tag = 99
      Left = 25
      Top = 230
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 99
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe30: TEditFocus
      Tag = 99
      Left = 525
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 103
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
    object edtUniSe30: TEditFocus
      Tag = 99
      Left = 461
      Top = 230
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 102
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
    object edtQtdSe30: TEditFocus
      Tag = 99
      Left = 393
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 101
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
    object cmbStaSe30: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 230
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 107
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe30: TEditFocus
      Tag = 99
      Left = 905
      Top = 230
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 108
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe30: TEditFocus
      Tag = 99
      Left = 955
      Top = 230
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 109
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDecSe21: TEditFocus
      Tag = 99
      Left = 167
      Top = 32
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 6
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe22: TEditFocus
      Tag = 99
      Left = 167
      Top = 54
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 17
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe23: TEditFocus
      Tag = 99
      Left = 167
      Top = 76
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 28
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe25: TEditFocus
      Tag = 99
      Left = 167
      Top = 120
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 50
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe24: TEditFocus
      Tag = 99
      Left = 167
      Top = 98
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 39
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe26: TEditFocus
      Tag = 99
      Left = 167
      Top = 142
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 61
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe27: TEditFocus
      Tag = 99
      Left = 167
      Top = 164
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 72
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe28: TEditFocus
      Tag = 99
      Left = 167
      Top = 186
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 83
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe29: TEditFocus
      Tag = 99
      Left = 167
      Top = 208
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 94
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe30: TEditFocus
      Tag = 99
      Left = 167
      Top = 230
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 105
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe30: TEditFocus
      Tag = 99
      Left = 231
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 106
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe29: TEditFocus
      Tag = 99
      Left = 231
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 95
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe28: TEditFocus
      Tag = 99
      Left = 231
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 84
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe27: TEditFocus
      Tag = 99
      Left = 231
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 73
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe26: TEditFocus
      Tag = 99
      Left = 231
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 62
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe25: TEditFocus
      Tag = 99
      Left = 231
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 51
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe24: TEditFocus
      Tag = 99
      Left = 231
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 40
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe23: TEditFocus
      Tag = 99
      Left = 231
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 29
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe22: TEditFocus
      Tag = 99
      Left = 231
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 18
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe21: TEditFocus
      Tag = 99
      Left = 231
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 7
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object chkBriSe21: TCheckBox
      Tag = 99
      Left = 733
      Top = 34
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      OnClick = chkBrindeClick
    end
    object chkBriSe22: TCheckBox
      Tag = 99
      Left = 733
      Top = 56
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnClick = chkBrindeClick
    end
    object chkBriSe23: TCheckBox
      Tag = 99
      Left = 733
      Top = 78
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 27
      OnClick = chkBrindeClick
    end
    object chkBriSe24: TCheckBox
      Tag = 99
      Left = 733
      Top = 100
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 38
      OnClick = chkBrindeClick
    end
    object chkBriSe25: TCheckBox
      Tag = 99
      Left = 733
      Top = 122
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 49
      OnClick = chkBrindeClick
    end
    object chkBriSe26: TCheckBox
      Tag = 99
      Left = 733
      Top = 144
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 60
      OnClick = chkBrindeClick
    end
    object chkBriSe27: TCheckBox
      Tag = 99
      Left = 733
      Top = 166
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 71
      OnClick = chkBrindeClick
    end
    object chkBriSe28: TCheckBox
      Tag = 99
      Left = 733
      Top = 188
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 82
      OnClick = chkBrindeClick
    end
    object chkBriSe29: TCheckBox
      Tag = 99
      Left = 733
      Top = 210
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 93
      OnClick = chkBrindeClick
    end
    object chkBriSe30: TCheckBox
      Tag = 99
      Left = 733
      Top = 232
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 104
      OnClick = chkBrindeClick
    end
  end
  object pnlServicos2: TPanel [6]
    Left = 0
    Top = 0
    Width = 1006
    Height = 274
    Align = alClient
    Color = 16770261
    TabOrder = 1
    Visible = False
    DesignSize = (
      1006
      274)
    object lblServico2: TLabel
      Left = 21
      Top = 10
      Width = 49
      Height = 17
      Caption = 'Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe11: TLabel
      Left = 1
      Top = 34
      Width = 20
      Height = 17
      Caption = '11)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblValSer2: TLabel
      Left = 542
      Top = 10
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe12: TLabel
      Left = 1
      Top = 56
      Width = 21
      Height = 17
      Caption = '12)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe13: TLabel
      Left = 1
      Top = 77
      Width = 21
      Height = 17
      Caption = '13)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe14: TLabel
      Left = 1
      Top = 100
      Width = 21
      Height = 17
      Caption = '14)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe15: TLabel
      Left = 1
      Top = 122
      Width = 21
      Height = 17
      Caption = '15)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe16: TLabel
      Left = 1
      Top = 144
      Width = 21
      Height = 17
      Caption = '16)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblUniSer2: TLabel
      Left = 485
      Top = 10
      Width = 39
      Height = 17
      Alignment = taRightJustify
      Caption = 'Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdSer2: TLabel
      Left = 424
      Top = 10
      Width = 36
      Height = 17
      Alignment = taRightJustify
      Caption = 'Qtde.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblStaSer2: TLabel
      Left = 795
      Top = 10
      Width = 95
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Status Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 678
    end
    object lblTmpSer2: TLabel
      Left = 905
      Top = 10
      Width = 36
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'T. M.*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 788
    end
    object btnMecSe11: TSpeedButton
      Left = 346
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe12: TSpeedButton
      Left = 346
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe13: TSpeedButton
      Left = 346
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe14: TSpeedButton
      Left = 346
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe15: TSpeedButton
      Left = 346
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe16: TSpeedButton
      Left = 346
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe11: TSpeedButton
      Left = 370
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe12: TSpeedButton
      Left = 370
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe14: TSpeedButton
      Left = 370
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe13: TSpeedButton
      Left = 370
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe16: TSpeedButton
      Left = 370
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe15: TSpeedButton
      Left = 370
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblPrisma2: TLabel
      Left = 955
      Top = 10
      Width = 47
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'Prisma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 838
    end
    object lblNumSe17: TLabel
      Left = 1
      Top = 166
      Width = 21
      Height = 17
      Caption = '17)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe17: TSpeedButton
      Left = 346
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe17: TSpeedButton
      Left = 370
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe18: TLabel
      Left = 1
      Top = 188
      Width = 21
      Height = 17
      Caption = '18)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe18: TSpeedButton
      Left = 346
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe18: TSpeedButton
      Left = 370
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe19: TLabel
      Left = 1
      Top = 210
      Width = 21
      Height = 17
      Caption = '19)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe19: TSpeedButton
      Left = 346
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe19: TSpeedButton
      Left = 370
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe20: TLabel
      Left = 1
      Top = 232
      Width = 21
      Height = 17
      Caption = '20)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe20: TSpeedButton
      Left = 346
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe20: TSpeedButton
      Left = 370
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblDecSer2: TLabel
      Left = 174
      Top = 10
      Width = 56
      Height = 17
      Alignment = taRightJustify
      Caption = 'Desc. %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblLiqSer2: TLabel
      Left = 244
      Top = 10
      Width = 54
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. L'#237'qui.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnIdent11: TSpeedButton
      Left = 592
      Top = 32
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent12: TSpeedButton
      Left = 592
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent13: TSpeedButton
      Left = 592
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent14: TSpeedButton
      Left = 592
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent18: TSpeedButton
      Left = 592
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent17: TSpeedButton
      Left = 592
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent16: TSpeedButton
      Left = 592
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent15: TSpeedButton
      Left = 592
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent19: TSpeedButton
      Left = 592
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent20: TSpeedButton
      Left = 592
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object lblBrinde2: TLabel
      Left = 738
      Top = 10
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Brinde?'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 621
    end
    object btnParSe11: TSpeedButton
      Left = 654
      Top = 30
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe12: TSpeedButton
      Left = 654
      Top = 54
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe13: TSpeedButton
      Left = 654
      Top = 76
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe14: TSpeedButton
      Left = 654
      Top = 98
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe15: TSpeedButton
      Left = 654
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe16: TSpeedButton
      Left = 654
      Top = 142
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe17: TSpeedButton
      Left = 654
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe18: TSpeedButton
      Left = 654
      Top = 186
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe19: TSpeedButton
      Left = 654
      Top = 208
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe20: TSpeedButton
      Left = 654
      Top = 230
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object edtDesSe11: TEditFocus
      Tag = 99
      Left = 70
      Top = 32
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe11: TEditFocus
      Tag = 99
      Left = 25
      Top = 32
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe11: TEditFocus
      Tag = 99
      Left = 525
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 4
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
    object edtDesSe12: TEditFocus
      Tag = 99
      Left = 70
      Top = 54
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 95
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe12: TEditFocus
      Tag = 99
      Left = 25
      Top = 54
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 11
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe12: TEditFocus
      Tag = 99
      Left = 525
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 15
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
    object edtDesSe13: TEditFocus
      Tag = 99
      Left = 70
      Top = 76
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 23
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe13: TEditFocus
      Tag = 99
      Left = 25
      Top = 76
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 22
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe13: TEditFocus
      Tag = 99
      Left = 525
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 26
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
    object edtDesSe14: TEditFocus
      Tag = 99
      Left = 70
      Top = 98
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 34
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe14: TEditFocus
      Tag = 99
      Left = 25
      Top = 98
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 33
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe14: TEditFocus
      Tag = 99
      Left = 525
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 37
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
    object edtDesSe15: TEditFocus
      Tag = 99
      Left = 70
      Top = 120
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 45
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe15: TEditFocus
      Tag = 99
      Left = 25
      Top = 120
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 44
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe15: TEditFocus
      Tag = 99
      Left = 525
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 48
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
    object edtDesSe16: TEditFocus
      Tag = 99
      Left = 70
      Top = 142
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 56
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe16: TEditFocus
      Tag = 99
      Left = 25
      Top = 142
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 55
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe16: TEditFocus
      Tag = 99
      Left = 525
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 59
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
    object edtUniSe16: TEditFocus
      Tag = 99
      Left = 461
      Top = 142
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 58
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
    object edtUniSe15: TEditFocus
      Tag = 99
      Left = 461
      Top = 120
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 47
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
    object edtUniSe14: TEditFocus
      Tag = 99
      Left = 461
      Top = 98
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 36
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
    object edtUniSe13: TEditFocus
      Tag = 99
      Left = 461
      Top = 76
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 25
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
    object edtUniSe12: TEditFocus
      Tag = 99
      Left = 461
      Top = 54
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 14
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
    object edtUniSe11: TEditFocus
      Tag = 99
      Left = 461
      Top = 32
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 3
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
    object edtQtdSe16: TEditFocus
      Tag = 99
      Left = 393
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 57
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
    object edtQtdSe15: TEditFocus
      Tag = 99
      Left = 393
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 46
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
    object edtQtdSe14: TEditFocus
      Tag = 99
      Left = 393
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 35
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
    object edtQtdSe13: TEditFocus
      Tag = 99
      Left = 393
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 24
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
    object edtQtdSe12: TEditFocus
      Tag = 99
      Left = 393
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 13
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
    object edtQtdSe11: TEditFocus
      Tag = 99
      Left = 393
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 2
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
    object cmbStaSe11: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 32
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe12: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 54
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe13: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 76
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe14: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 98
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 41
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe15: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 120
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 52
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe16: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 142
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 63
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe11: TEditFocus
      Tag = 99
      Left = 905
      Top = 32
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 9
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe12: TEditFocus
      Tag = 99
      Left = 905
      Top = 54
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 20
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe13: TEditFocus
      Tag = 99
      Left = 905
      Top = 76
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 31
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe14: TEditFocus
      Tag = 99
      Left = 905
      Top = 98
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 42
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe15: TEditFocus
      Tag = 99
      Left = 905
      Top = 120
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 53
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe16: TEditFocus
      Tag = 99
      Left = 905
      Top = 142
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 64
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe11: TEditFocus
      Tag = 99
      Left = 955
      Top = 32
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 10
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe12: TEditFocus
      Tag = 99
      Left = 955
      Top = 54
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 21
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe13: TEditFocus
      Tag = 99
      Left = 955
      Top = 76
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 32
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe14: TEditFocus
      Tag = 99
      Left = 955
      Top = 98
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 43
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe15: TEditFocus
      Tag = 99
      Left = 955
      Top = 120
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 54
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe16: TEditFocus
      Tag = 99
      Left = 955
      Top = 142
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 65
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe17: TEditFocus
      Tag = 99
      Left = 70
      Top = 164
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 67
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe17: TEditFocus
      Tag = 99
      Left = 25
      Top = 164
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 66
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe17: TEditFocus
      Tag = 99
      Left = 525
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 70
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
    object edtUniSe17: TEditFocus
      Tag = 99
      Left = 461
      Top = 164
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 69
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
    object edtQtdSe17: TEditFocus
      Tag = 99
      Left = 393
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 68
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
    object cmbStaSe17: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 164
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 74
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe17: TEditFocus
      Tag = 99
      Left = 905
      Top = 164
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 75
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe17: TEditFocus
      Tag = 99
      Left = 955
      Top = 164
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 76
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe18: TEditFocus
      Tag = 99
      Left = 70
      Top = 186
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 78
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe18: TEditFocus
      Tag = 99
      Left = 25
      Top = 186
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 77
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe18: TEditFocus
      Tag = 99
      Left = 525
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 81
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
    object edtUniSe18: TEditFocus
      Tag = 99
      Left = 461
      Top = 186
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 80
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
    object edtQtdSe18: TEditFocus
      Tag = 99
      Left = 393
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 79
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
    object cmbStaSe18: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 186
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 85
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe18: TEditFocus
      Tag = 99
      Left = 905
      Top = 186
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 86
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe18: TEditFocus
      Tag = 99
      Left = 955
      Top = 186
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 87
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe19: TEditFocus
      Tag = 99
      Left = 70
      Top = 208
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 89
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe19: TEditFocus
      Tag = 99
      Left = 25
      Top = 208
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 88
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe19: TEditFocus
      Tag = 99
      Left = 525
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 92
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
    object edtUniSe19: TEditFocus
      Tag = 99
      Left = 461
      Top = 208
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 91
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
    object edtQtdSe19: TEditFocus
      Tag = 99
      Left = 393
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 90
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
    object cmbStaSe19: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 208
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 96
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe19: TEditFocus
      Tag = 99
      Left = 905
      Top = 208
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 97
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe19: TEditFocus
      Tag = 99
      Left = 955
      Top = 208
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 98
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe20: TEditFocus
      Tag = 99
      Left = 70
      Top = 230
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 95
      ReadOnly = True
      TabOrder = 100
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe20: TEditFocus
      Tag = 99
      Left = 25
      Top = 230
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 99
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe20: TEditFocus
      Tag = 99
      Left = 525
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 103
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
    object edtUniSe20: TEditFocus
      Tag = 99
      Left = 461
      Top = 230
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 102
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
    object edtQtdSe20: TEditFocus
      Tag = 99
      Left = 393
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 101
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
    object cmbStaSe20: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 230
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 107
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe20: TEditFocus
      Tag = 99
      Left = 905
      Top = 230
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 108
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe20: TEditFocus
      Tag = 99
      Left = 955
      Top = 230
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 109
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDecSe11: TEditFocus
      Tag = 99
      Left = 167
      Top = 32
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 6
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe12: TEditFocus
      Tag = 99
      Left = 167
      Top = 54
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 17
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe13: TEditFocus
      Tag = 99
      Left = 167
      Top = 76
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 28
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe15: TEditFocus
      Tag = 99
      Left = 167
      Top = 120
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 50
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe14: TEditFocus
      Tag = 99
      Left = 167
      Top = 98
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 39
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe16: TEditFocus
      Tag = 99
      Left = 167
      Top = 142
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 61
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe17: TEditFocus
      Tag = 99
      Left = 167
      Top = 164
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 72
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe18: TEditFocus
      Tag = 99
      Left = 167
      Top = 186
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 83
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe19: TEditFocus
      Tag = 99
      Left = 167
      Top = 208
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 94
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe20: TEditFocus
      Tag = 99
      Left = 167
      Top = 230
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 105
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe20: TEditFocus
      Tag = 99
      Left = 231
      Top = 230
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 106
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe19: TEditFocus
      Tag = 99
      Left = 231
      Top = 208
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 95
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe18: TEditFocus
      Tag = 99
      Left = 231
      Top = 186
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 84
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe17: TEditFocus
      Tag = 99
      Left = 231
      Top = 164
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 73
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe16: TEditFocus
      Tag = 99
      Left = 231
      Top = 142
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 62
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe15: TEditFocus
      Tag = 99
      Left = 231
      Top = 120
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 51
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe14: TEditFocus
      Tag = 99
      Left = 231
      Top = 98
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 40
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe13: TEditFocus
      Tag = 99
      Left = 231
      Top = 76
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 29
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe12: TEditFocus
      Tag = 99
      Left = 231
      Top = 54
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 18
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe11: TEditFocus
      Tag = 99
      Left = 231
      Top = 32
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 7
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object chkBriSe11: TCheckBox
      Tag = 99
      Left = 733
      Top = 34
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      OnClick = chkBrindeClick
    end
    object chkBriSe12: TCheckBox
      Tag = 99
      Left = 733
      Top = 56
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnClick = chkBrindeClick
    end
    object chkBriSe13: TCheckBox
      Tag = 99
      Left = 733
      Top = 78
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 27
      OnClick = chkBrindeClick
    end
    object chkBriSe14: TCheckBox
      Tag = 99
      Left = 733
      Top = 100
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 38
      OnClick = chkBrindeClick
    end
    object chkBriSe15: TCheckBox
      Tag = 99
      Left = 733
      Top = 122
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 49
      OnClick = chkBrindeClick
    end
    object chkBriSe16: TCheckBox
      Tag = 99
      Left = 733
      Top = 144
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 60
      OnClick = chkBrindeClick
    end
    object chkBriSe17: TCheckBox
      Tag = 99
      Left = 733
      Top = 166
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 71
      OnClick = chkBrindeClick
    end
    object chkBriSe18: TCheckBox
      Tag = 99
      Left = 733
      Top = 188
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 82
      OnClick = chkBrindeClick
    end
    object chkBriSe19: TCheckBox
      Tag = 99
      Left = 733
      Top = 210
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 93
      OnClick = chkBrindeClick
    end
    object chkBriSe20: TCheckBox
      Tag = 99
      Left = 733
      Top = 232
      Width = 40
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 104
      OnClick = chkBrindeClick
    end
  end
  object pnlServicos1: TPanel [7]
    Left = 0
    Top = 0
    Width = 1006
    Height = 274
    Align = alClient
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      1006
      274)
    object lblServico1: TLabel
      Left = 21
      Top = 2
      Width = 49
      Height = 17
      Caption = 'Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe1: TLabel
      Left = 5
      Top = 24
      Width = 13
      Height = 17
      Caption = '1)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblValSer1: TLabel
      Left = 542
      Top = 2
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe2: TLabel
      Left = 5
      Top = 46
      Width = 13
      Height = 17
      Caption = '2)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe3: TLabel
      Left = 5
      Top = 68
      Width = 13
      Height = 17
      Caption = '3)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe4: TLabel
      Left = 5
      Top = 90
      Width = 13
      Height = 17
      Caption = '4)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe5: TLabel
      Left = 5
      Top = 112
      Width = 13
      Height = 17
      Caption = '5)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumSe6: TLabel
      Left = 5
      Top = 134
      Width = 13
      Height = 17
      Caption = '6)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblUniSer1: TLabel
      Left = 485
      Top = 2
      Width = 39
      Height = 17
      Alignment = taRightJustify
      Caption = 'Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdSer1: TLabel
      Left = 424
      Top = 2
      Width = 36
      Height = 17
      Alignment = taRightJustify
      Caption = 'Qtde.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblStaSer1: TLabel
      Left = 795
      Top = 2
      Width = 95
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Status Servi'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 683
    end
    object lblTmpSer1: TLabel
      Left = 905
      Top = 2
      Width = 36
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'T. M.*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 793
    end
    object btnMecSe1: TSpeedButton
      Left = 346
      Top = 24
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe2: TSpeedButton
      Left = 346
      Top = 44
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe3: TSpeedButton
      Left = 346
      Top = 66
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe4: TSpeedButton
      Left = 346
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe5: TSpeedButton
      Left = 346
      Top = 110
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnMecSe6: TSpeedButton
      Left = 346
      Top = 132
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe1: TSpeedButton
      Left = 370
      Top = 22
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe2: TSpeedButton
      Left = 370
      Top = 44
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe4: TSpeedButton
      Left = 370
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe3: TSpeedButton
      Left = 370
      Top = 66
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe6: TSpeedButton
      Left = 370
      Top = 132
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object btnObsSe5: TSpeedButton
      Left = 370
      Top = 110
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblPrisma1: TLabel
      Left = 955
      Top = 2
      Width = 47
      Height = 17
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = 'Prisma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 843
    end
    object lblNumSe7: TLabel
      Left = 5
      Top = 156
      Width = 13
      Height = 17
      Caption = '7)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe7: TSpeedButton
      Left = 346
      Top = 154
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe7: TSpeedButton
      Left = 370
      Top = 154
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe8: TLabel
      Left = 5
      Top = 178
      Width = 13
      Height = 17
      Caption = '8)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe8: TSpeedButton
      Left = 346
      Top = 176
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe8: TSpeedButton
      Left = 370
      Top = 176
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe9: TLabel
      Left = 5
      Top = 200
      Width = 13
      Height = 17
      Caption = '9)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe9: TSpeedButton
      Left = 346
      Top = 198
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe9: TSpeedButton
      Left = 370
      Top = 198
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblNumSe10: TLabel
      Left = 1
      Top = 222
      Width = 21
      Height = 17
      Caption = '10)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnMecSe10: TSpeedButton
      Left = 346
      Top = 220
      Width = 23
      Height = 22
      Hint = 'Mec'#226'nicos'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMecSe1Click
    end
    object btnObsSe10: TSpeedButton
      Left = 370
      Top = 220
      Width = 23
      Height = 22
      Hint = 'Observa'#231#245'es do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnObsSe1Click
    end
    object lblDecSer1: TLabel
      Left = 174
      Top = 2
      Width = 56
      Height = 17
      Alignment = taRightJustify
      Caption = 'Desc. %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblLiqSer1: TLabel
      Left = 244
      Top = 2
      Width = 54
      Height = 17
      Alignment = taRightJustify
      Caption = 'Vr. L'#237'qui.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnIdent1: TSpeedButton
      Left = 592
      Top = 22
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent2: TSpeedButton
      Left = 592
      Top = 44
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent3: TSpeedButton
      Left = 592
      Top = 66
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent4: TSpeedButton
      Left = 592
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent8: TSpeedButton
      Left = 592
      Top = 176
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent7: TSpeedButton
      Left = 592
      Top = 154
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent6: TSpeedButton
      Left = 592
      Top = 132
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent5: TSpeedButton
      Left = 592
      Top = 110
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent9: TSpeedButton
      Left = 592
      Top = 198
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object btnIdent10: TSpeedButton
      Left = 592
      Top = 220
      Width = 23
      Height = 22
      Hint = 'Isentar Cobran'#231'a do Servi'#231'o'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
        000C0000000C0000000B00000007000000020000000000000000000000068057
        4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
        68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
        6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
        FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
        6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
        8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
        6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
        6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
        73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
        91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
        76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
        F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
        78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
        8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
        7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
        EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
        7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
        92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
        81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
        F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
        84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
        96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
        87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
        F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
        8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
        9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
        8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
        FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
        74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
        99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnIdent1Click
    end
    object lblBrinde1: TLabel
      Left = 738
      Top = 2
      Width = 50
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Brinde?'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 626
    end
    object btnParSe1: TSpeedButton
      Left = 654
      Top = 20
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe2: TSpeedButton
      Left = 654
      Top = 44
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe3: TSpeedButton
      Left = 654
      Top = 66
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe4: TSpeedButton
      Left = 654
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe5: TSpeedButton
      Left = 654
      Top = 110
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe6: TSpeedButton
      Left = 654
      Top = 132
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe7: TSpeedButton
      Left = 654
      Top = 154
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe8: TSpeedButton
      Left = 654
      Top = 176
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe9: TSpeedButton
      Left = 654
      Top = 198
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object btnParSe10: TSpeedButton
      Left = 654
      Top = 220
      Width = 23
      Height = 22
      Hint = 'Parceiro do brinde'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000040000000C0000000A0000000400000004000000070000000A0000
        000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
        00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
        76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
        000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
        D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
        41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
        EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
        C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
        E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
        E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
        99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
        5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
        88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
        0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
        ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
        B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000100000001000000000000000000000006205090F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000030000000300000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = chkBrindeClick
    end
    object edtDesSe1: TEditFocus
      Tag = 99
      Left = 70
      Top = 22
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe1: TEditFocus
      Tag = 99
      Left = 25
      Top = 22
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe1: TEditFocus
      Tag = 99
      Left = 525
      Top = 22
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 6
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
    object edtDesSe2: TEditFocus
      Tag = 99
      Left = 70
      Top = 44
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 80
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe2: TEditFocus
      Tag = 99
      Left = 25
      Top = 44
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 11
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe2: TEditFocus
      Tag = 99
      Left = 525
      Top = 44
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 17
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
    object edtDesSe3: TEditFocus
      Tag = 99
      Left = 70
      Top = 66
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 23
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe3: TEditFocus
      Tag = 99
      Left = 25
      Top = 66
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 22
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe3: TEditFocus
      Tag = 99
      Left = 525
      Top = 66
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 28
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
    object edtDesSe4: TEditFocus
      Tag = 99
      Left = 70
      Top = 88
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 34
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe4: TEditFocus
      Tag = 99
      Left = 25
      Top = 88
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 33
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe4: TEditFocus
      Tag = 99
      Left = 525
      Top = 88
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 39
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
    object edtDesSe5: TEditFocus
      Tag = 99
      Left = 70
      Top = 110
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 45
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe5: TEditFocus
      Tag = 99
      Left = 25
      Top = 110
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 44
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe5: TEditFocus
      Tag = 99
      Left = 525
      Top = 110
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 50
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
    object edtDesSe6: TEditFocus
      Tag = 99
      Left = 70
      Top = 132
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 56
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe6: TEditFocus
      Tag = 99
      Left = 25
      Top = 132
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 55
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe6: TEditFocus
      Tag = 99
      Left = 525
      Top = 132
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 60
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
    object edtUniSe6: TEditFocus
      Tag = 99
      Left = 461
      Top = 132
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 59
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
    object edtUniSe5: TEditFocus
      Tag = 99
      Left = 461
      Top = 110
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 49
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
    object edtUniSe4: TEditFocus
      Tag = 99
      Left = 461
      Top = 88
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 38
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
    object edtUniSe3: TEditFocus
      Tag = 99
      Left = 461
      Top = 66
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 27
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
    object edtUniSe2: TEditFocus
      Tag = 99
      Left = 461
      Top = 44
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 16
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
    object edtUniSe1: TEditFocus
      Tag = 99
      Left = 461
      Top = 22
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 5
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
    object edtQtdSe6: TEditFocus
      Tag = 99
      Left = 393
      Top = 132
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 58
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
    object edtQtdSe5: TEditFocus
      Tag = 99
      Left = 393
      Top = 110
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 48
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
    object edtQtdSe4: TEditFocus
      Tag = 99
      Left = 393
      Top = 88
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 37
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
    object edtQtdSe3: TEditFocus
      Tag = 99
      Left = 393
      Top = 66
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 26
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
    object edtQtdSe2: TEditFocus
      Tag = 99
      Left = 393
      Top = 44
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 15
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
    object edtQtdSe1: TEditFocus
      Tag = 99
      Left = 393
      Top = 22
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 4
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
    object cmbStaSe1: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 22
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe2: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 44
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe3: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 66
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe4: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 88
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 41
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe5: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 110
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 52
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStaSe6: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 132
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 62
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe1: TEditFocus
      Tag = 99
      Left = 905
      Top = 22
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 9
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe2: TEditFocus
      Tag = 99
      Left = 905
      Top = 44
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 20
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe3: TEditFocus
      Tag = 99
      Left = 905
      Top = 66
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 31
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe4: TEditFocus
      Tag = 99
      Left = 905
      Top = 88
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 42
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe5: TEditFocus
      Tag = 99
      Left = 905
      Top = 110
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 53
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTmpSe6: TEditFocus
      Tag = 99
      Left = 905
      Top = 132
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 63
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe1: TEditFocus
      Tag = 99
      Left = 955
      Top = 22
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 10
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe2: TEditFocus
      Tag = 99
      Left = 955
      Top = 44
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 21
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe3: TEditFocus
      Tag = 99
      Left = 955
      Top = 66
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 32
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe4: TEditFocus
      Tag = 99
      Left = 955
      Top = 88
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 43
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe5: TEditFocus
      Tag = 99
      Left = 955
      Top = 110
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 54
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe6: TEditFocus
      Tag = 99
      Left = 955
      Top = 132
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 64
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe7: TEditFocus
      Tag = 99
      Left = 70
      Top = 154
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 66
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe7: TEditFocus
      Tag = 99
      Left = 25
      Top = 154
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 65
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe7: TEditFocus
      Tag = 99
      Left = 525
      Top = 154
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 71
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
    object edtUniSe7: TEditFocus
      Tag = 99
      Left = 461
      Top = 154
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 70
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
    object edtQtdSe7: TEditFocus
      Tag = 99
      Left = 393
      Top = 154
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 69
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
    object cmbStaSe7: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 154
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 73
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe7: TEditFocus
      Tag = 99
      Left = 905
      Top = 154
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 74
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe7: TEditFocus
      Tag = 99
      Left = 955
      Top = 154
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 75
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe8: TEditFocus
      Tag = 99
      Left = 70
      Top = 176
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 77
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe8: TEditFocus
      Tag = 99
      Left = 25
      Top = 176
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 76
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe8: TEditFocus
      Tag = 99
      Left = 525
      Top = 176
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 82
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
    object edtUniSe8: TEditFocus
      Tag = 99
      Left = 461
      Top = 176
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 80
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
    object edtQtdSe8: TEditFocus
      Tag = 99
      Left = 393
      Top = 176
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 79
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
    object cmbStaSe8: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 176
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 83
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe8: TEditFocus
      Tag = 99
      Left = 905
      Top = 176
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 84
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe8: TEditFocus
      Tag = 99
      Left = 955
      Top = 176
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 85
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe9: TEditFocus
      Tag = 99
      Left = 70
      Top = 198
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 87
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe9: TEditFocus
      Tag = 99
      Left = 25
      Top = 198
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 86
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe9: TEditFocus
      Tag = 99
      Left = 525
      Top = 198
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 92
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
    object edtUniSe9: TEditFocus
      Tag = 99
      Left = 461
      Top = 198
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 91
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
    object edtQtdSe9: TEditFocus
      Tag = 99
      Left = 393
      Top = 198
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 90
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
    object cmbStaSe9: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 198
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 94
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe9: TEditFocus
      Tag = 99
      Left = 905
      Top = 198
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 95
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe9: TEditFocus
      Tag = 99
      Left = 955
      Top = 198
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 96
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSe10: TEditFocus
      Tag = 99
      Left = 70
      Top = 220
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      MaxLength = 80
      ReadOnly = True
      TabOrder = 98
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtCodSe10: TEditFocus
      Tag = 99
      Left = 25
      Top = 220
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 97
      OnEnter = edtCodSe1Enter
      OnKeyPress = edtCodSe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValSe10: TEditFocus
      Tag = 99
      Left = 525
      Top = 220
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 103
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
    object edtUniSe10: TEditFocus
      Tag = 99
      Left = 461
      Top = 220
      Width = 63
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 102
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
    object edtQtdSe10: TEditFocus
      Tag = 99
      Left = 393
      Top = 220
      Width = 67
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 101
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
    object cmbStaSe10: TComboBoxFocus
      Tag = 99
      Left = 795
      Top = 220
      Width = 108
      Height = 22
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 105
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtTmpSe10: TEditFocus
      Tag = 99
      Left = 905
      Top = 220
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 106
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPriSe10: TEditFocus
      Tag = 99
      Left = 955
      Top = 220
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 95
      ReadOnly = True
      TabOrder = 107
      OnKeyPress = edtDesSe1KeyPress
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDecSe1: TEditFocus
      Tag = 99
      Left = 167
      Top = 22
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 2
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe2: TEditFocus
      Tag = 99
      Left = 167
      Top = 44
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 13
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe3: TEditFocus
      Tag = 99
      Left = 167
      Top = 66
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 24
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe5: TEditFocus
      Tag = 99
      Left = 167
      Top = 110
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 46
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe4: TEditFocus
      Tag = 99
      Left = 167
      Top = 88
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 35
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe6: TEditFocus
      Tag = 99
      Left = 167
      Top = 132
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 108
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe7: TEditFocus
      Tag = 99
      Left = 167
      Top = 154
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 67
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe8: TEditFocus
      Tag = 99
      Left = 167
      Top = 176
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 109
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe9: TEditFocus
      Tag = 99
      Left = 167
      Top = 198
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 88
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDecSe10: TEditFocus
      Tag = 99
      Left = 167
      Top = 220
      Width = 63
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      TabOrder = 99
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe10: TEditFocus
      Tag = 99
      Left = 231
      Top = 220
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 100
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe9: TEditFocus
      Tag = 99
      Left = 231
      Top = 198
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 89
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe8: TEditFocus
      Tag = 99
      Left = 231
      Top = 176
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 78
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe7: TEditFocus
      Tag = 99
      Left = 231
      Top = 154
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 68
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe6: TEditFocus
      Tag = 99
      Left = 231
      Top = 132
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 57
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe5: TEditFocus
      Tag = 99
      Left = 231
      Top = 110
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 47
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe4: TEditFocus
      Tag = 99
      Left = 231
      Top = 88
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 36
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe3: TEditFocus
      Tag = 99
      Left = 231
      Top = 66
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 25
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe2: TEditFocus
      Tag = 99
      Left = 231
      Top = 44
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 14
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLiqSe1: TEditFocus
      Tag = 99
      Left = 231
      Top = 22
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 12
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object chkBriSe1: TCheckBox
      Tag = 99
      Left = 732
      Top = 24
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 7
      OnClick = chkBrindeClick
    end
    object chkBriSe2: TCheckBox
      Tag = 99
      Left = 732
      Top = 46
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      OnClick = chkBrindeClick
    end
    object chkBriSe3: TCheckBox
      Tag = 99
      Left = 732
      Top = 68
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 29
      OnClick = chkBrindeClick
    end
    object chkBriSe4: TCheckBox
      Tag = 99
      Left = 732
      Top = 90
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 40
      OnClick = chkBrindeClick
    end
    object chkBriSe5: TCheckBox
      Tag = 99
      Left = 732
      Top = 112
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 51
      OnClick = chkBrindeClick
    end
    object chkBriSe6: TCheckBox
      Tag = 99
      Left = 732
      Top = 134
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 61
      OnClick = chkBrindeClick
    end
    object chkBriSe7: TCheckBox
      Tag = 99
      Left = 732
      Top = 156
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 72
      OnClick = chkBrindeClick
    end
    object chkBriSe8: TCheckBox
      Tag = 99
      Left = 732
      Top = 178
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 81
      OnClick = chkBrindeClick
    end
    object chkBriSe9: TCheckBox
      Tag = 99
      Left = 732
      Top = 200
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 93
      OnClick = chkBrindeClick
    end
    object chkBriSe10: TCheckBox
      Tag = 99
      Left = 732
      Top = 222
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'N'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 104
      OnClick = chkBrindeClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 848
    Top = 246
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 816
    Top = 246
  end
  object imgIdent: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 20972128
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000010000
          00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
          000C0000000C0000000B00000007000000020000000000000000000000068057
          4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
          68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
          6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
          FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
          6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
          8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
          6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
          6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
          73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
          91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
          76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
          F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
          78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
          8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
          7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
          EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
          7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
          92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
          81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
          F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
          84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
          96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
          87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
          F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
          8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
          9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
          8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
          74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
          99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000010000
          00060000000A0000000B0000000B0000000B0000000B0000000E0B082C552519
          99EB110A58A70100031F100855A5160C7EEA0603244F00000004000000068057
          4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFE4D4CFFF4235B5FF6F85
          EAFF4150CBFF372DA0FF3B48C9FF5C74E4FF180E82E70000000700000008B57D
          6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFF9F7F6FF7B76CCFF7780
          DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F0000000500000008B67F
          6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD9B18BFFE5D8D0FF4B44
          B9FF6A85EBFF7494F2FF6079E7FF262094E4010104130000000200000008B882
          6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFEDDBCAFF7D77CAFF6B7E
          E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA00000000400000007BA84
          73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAE7FFFF2E6DAFF615FD5FFB1C3
          F6FF8D99EAFF5F5DD2FF8995E7FFA6B8F3FF3B35AEE30000000400000007BB87
          76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFFAF5F3FFCECDEEFF6564
          DEFF9291E2FFF2F1F4FF8982D4FF4340BCE6121233460000000200000006BD8A
          78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA191FFE0C7BDFFEFE4
          E0FFE6D5CEFFFCFAF8FFE4D0CAFF0000000B000000020000000000000006BF8D
          7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
          EEFFF9F1EEFFFDFBF9FFBD8978FF00000008000000000000000000000005C190
          7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
          92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
          81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
          F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
          84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
          96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
          87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
          F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
          8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
          9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
          8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
          74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
          99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000080000000D0000000E0000000E0000000E0000
          000E0000000E0000000E0000000F0000000E0000000900000002000000000000
          000000000000000000077B5B4FBFA97C6CFFA97A6BFFA77869FFA67767FFA575
          66FFA47464FFA37363FFA27161FFA17060FF725045C000000008000000000000
          00000000000000000009AE8373FFFFFFFFFFF9F5F2FFF8F3F1FFF9F4F1FFF9F4
          F0FFF8F3F1FFF8F2F0FFF8F3F0FFF8F3EFFFA27362FF0000000A000000000000
          00000000000000000007B38879FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA67767FF00000009000000000000
          00000000000000000004967466C1C89A89FFC69987FFC49785FFC39583FFC092
          81FFBF917FFFBC8E7DFFBA8C7BFFB88A79FF876458C200000005000000000000
          0000000000000000000100000003000000040000000500000005000000050000
          0005000000050000000500000005000000050000000400000001B6703DFF120B
          062200000002000000007E5E53B7AD8171FF00000000AB7D6EFFAA7C6CFF0000
          0000A87969FFA77868FF00000000A57565FF765348B700000000B87340FFBC7A
          49FF120B062200000000B28878FF000000000000000000000000000000000000
          000000000000000000000000000000000000A67867FF00000000BA7644FFCD90
          5CFFBD7A48FF00000000B78D7EFF000000000000000000000000000000000000
          000000000000000000000000000000000000AA7C6CFF00000000BB7946FFBF7F
          4EFF130C072200000000977669BDCA9D8CFF00000000C79A88FFC59886FF0000
          0000C19482FFBF9280FF00000000BB8E7CFF89675BBD00000000BD7B49FF130C
          07220000000200000002000000080000000D0000000E0000000E0000000E0000
          000E0000000E0000000E0000000F0000000E0000000900000002000000000000
          00000000000000000007826257BFB38777FFB38576FFB18374FFB08272FFAF80
          71FFAE7F6FFFAD7E6EFFAC7C6CFFAB7B6BFF7A574CC000000008000000000000
          00000000000000000009B88E7EFFFFFFFFFFF9F5F2FFF8F3F1FFF9F4F1FFF9F4
          F0FFF8F3F1FFF8F2F0FFF8F3F0FFF8F3EFFFAC7E6DFF0000000A000000000000
          00000000000000000007BD9384FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB08272FF00000009000000000000
          0000000000000000000499786BC1CDA18FFFCCA08EFFCA9E8CFFC99C8AFFC79A
          89FFC69887FFC39684FFC29483FFC09281FF8C6B5EC200000005000000000000
          0000000000000000000100000003000000040000000500000005000000050000
          0005000000050000000500000005000000050000000400000001}
      end>
  end
end
