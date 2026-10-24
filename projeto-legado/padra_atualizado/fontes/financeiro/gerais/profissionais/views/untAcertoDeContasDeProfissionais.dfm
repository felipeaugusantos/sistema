inherited frmAcertoDeContasDeProfissionais: TfrmAcertoDeContasDeProfissionais
  Width = 1042
  Height = 698
  Caption = 'Acerto de Contas de Profissionais'
  Position = poMainFormCenter
  ExplicitWidth = 1042
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 622
    Width = 1036
    ExplicitTop = 622
    ExplicitWidth = 1036
    inherited FlwBotoes: TFlowPanel
      Width = 1032
      ExplicitWidth = 1032
    end
  end
  inherited pnlStatus: TPanel
    Top = 653
    Width = 1036
    ExplicitTop = 653
    ExplicitWidth = 1036
    inherited pnlNomeForm: TPanel
      Left = 823
      Width = 213
      ExplicitLeft = 823
      ExplicitWidth = 213
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  inherited pgcDados: TPageControl
    Left = 968
    Top = 424
    Width = 369
    Height = 145
    Align = alNone
    Visible = False
    ExplicitLeft = 968
    ExplicitTop = 424
    ExplicitWidth = 369
    ExplicitHeight = 145
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 361
      ExplicitHeight = 113
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1036
    Height = 206
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grpDadosDaComissao: TGroupBox
      Left = 16
      Top = 8
      Width = 637
      Height = 97
      Caption = 'Dados da Comiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblProfissional: TLabel
        Left = 66
        Top = 42
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profissional:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPeriodoFaturamento: TLabel
        Left = 26
        Top = 67
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo Faturamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPeriodoFaturamentoA: TLabel
        Left = 224
        Top = 67
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = 'a'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 80
        Top = 18
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblProfCartao: TLabel
        Left = 363
        Top = 67
        Width = 123
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profissionais com Cart'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblProfCartaoValores: TColorLabel
        Left = 516
        Top = 67
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtCodigoProfissional: TEditFocus
        Tag = 99
        Left = 131
        Top = 39
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtCodigoProfissionalKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomeProfissional: TEditFocus
        Left = 204
        Top = 39
        Width = 409
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
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
      object edtDataInicial: TcxDateEdit
        Tag = 99
        Left = 131
        Top = 63
        ParentFont = False
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
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.LookAndFeel.SkinName = ''
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.Color = clInfoBk
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 4
        Width = 90
      end
      object edtDataFinal: TcxDateEdit
        Tag = 99
        Left = 233
        Top = 63
        ParentFont = False
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
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.LookAndFeel.SkinName = ''
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.Color = clInfoBk
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 5
        Width = 90
      end
      object edtCodigoEmpresa: TEditFocus
        Tag = 99
        Left = 131
        Top = 15
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodigoEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomeEmpresa: TEditFocus
        Left = 204
        Top = 15
        Width = 409
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
      object edtProfissionaisCartao: TEditFocus
        Tag = 99
        Left = 492
        Top = 63
        Width = 20
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 1
        ParentFont = False
        TabOrder = 6
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object btnCarregar: TBitBtnLocked
      Left = 668
      Top = 178
      Width = 189
      Height = 23
      Caption = '&Carregar '
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
      TabOrder = 3
      OnClick = btnCarregarClick
    end
    object grpDadosDoContasAPagar: TGroupBox
      Left = 16
      Top = 105
      Width = 637
      Height = 45
      Caption = 'Dados do Contas a Pagar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblComissaoAPagar: TLabel
        Left = 26
        Top = 18
        Width = 328
        Height = 14
        Alignment = taRightJustify
        Caption = 
          'Exibir apenas profissionais que tenha "Comiss'#227'o a Pagar" acima d' +
          'e:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtComissaoAPagar: TCurrencyEditFocus
        Tag = 99
        Left = 361
        Top = 15
        Margins.Left = 4
        Margins.Top = 1
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.Nullable = False
        Properties.Nullstring = '0,00'
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.HotTrack = True
        Style.IsFontAssigned = True
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 81
      end
    end
    object grpDadosDoContasAReceber: TGroupBox
      Left = 16
      Top = 156
      Width = 637
      Height = 45
      Caption = 'Dados do Contas a Receber'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object lblTitulos: TLabel
        Left = 26
        Top = 19
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'T'#237'tulos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTitulosValores: TColorLabel
        Left = 92
        Top = 19
        Width = 151
        Height = 14
        Caption = '(V)encidos (A) vencer (T)odos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtTitulos: TEditFocus
        Tag = 99
        Left = 66
        Top = 16
        Width = 20
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 1
        ParentFont = False
        TabOrder = 0
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 622
    Width = 1036
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    DesignSize = (
      1036
      31)
    object FlwPnlBotoesbaixa: TFlowPanel
      Left = 2
      Top = 5
      Width = 1032
      Height = 24
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnMarcarTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 166
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F8 ] Desmarcar Todos'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnDesmarcarTodosClick
      end
      object btnConfirmar: TBitBtnLocked
        Left = 332
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F10 ] Confirmar'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnRecalcularJuros: TBitBtnLocked
        Left = 498
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F11 ] Recalcular Juros'
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnRecalcularJurosClick
      end
      object btnManutencaoDiversos: TBitBtnLocked
        Left = 664
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F12 ] Manuten'#231#227'o de Diversos'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnManutencaoDiversosClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 866
      Top = 5
      Width = 166
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '[Esc] Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
  end
  object pnlDadosGrid: TPanel [5]
    Left = 0
    Top = 206
    Width = 1036
    Height = 416
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object grdProfissionais: TcxGridCitel
      Left = 0
      Top = 0
      Width = 1036
      Height = 346
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdProfissionaisDados: TcxGridDBTableViewCitel
        OnKeyDown = grdProfissionaisDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdProfissionaisDadosCustomDrawCell
        DataController.DataSource = dtsComissoes
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            FieldName = 'DIV_CODDIV'
            Column = grdProfissionaisDadosDIV_CODDIV
          end
          item
            Format = ',0.00;-0.00'
            Kind = skSum
            FieldName = 'TOTALCOMISSOES'
            Column = grdProfissionaisDadosTOTALCOMISSOES
          end
          item
            Format = ',0.00;-0.00'
            Kind = skSum
            FieldName = 'TOTALCTR'
            Column = grdProfissionaisDadosTOTALCTR
          end
          item
            Format = ',0.00;-0.00'
            Kind = skSum
            FieldName = 'COMISSAOAPAGAR'
            Column = grdProfissionaisDadosCOMISSAOAPAGAR
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdProfissionaisDadosDIV_CODDIV: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'DIV_CODDIV'
          Options.Editing = False
          Width = 74
        end
        object grdProfissionaisDadosDIV_NOMDIV: TcxGridDBColumn
          Caption = 'Nome do Profissional'
          DataBinding.FieldName = 'DIV_NOMDIV'
          Options.Editing = False
          Width = 241
        end
        object grdProfissionaisDadosTOTALCOMISSOES: TcxGridDBColumn
          Caption = 'Valor Total (Comiss'#227'o em Aberto)'
          DataBinding.FieldName = 'TOTALCOMISSOES'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.ReadOnly = True
          RepositoryItem = btnListaComissoes
          HeaderAlignmentHorz = taRightJustify
          Options.ShowEditButtons = isebAlways
          Width = 173
        end
        object grdProfissionaisDadosQTDECOMISSOES: TcxGridDBColumn
          Caption = 'Nro. Comiss'#245'es'
          DataBinding.FieldName = 'QTDECOMISSOES'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 91
        end
        object grdProfissionaisDadosQTDECLIENTES: TcxGridDBColumn
          Caption = 'Qtde. Clientes'
          DataBinding.FieldName = 'QTDECLIENTES'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 83
        end
        object grdProfissionaisDadosTOTALCTR: TcxGridDBColumn
          Caption = 'Valor Total CTR'
          DataBinding.FieldName = 'TOTALCTR'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          RepositoryItem = btnTotalCtr
          HeaderAlignmentHorz = taRightJustify
          Options.ShowEditButtons = isebAlways
          Width = 127
        end
        object grdProfissionaisDadosSALDOFINAL: TcxGridDBColumn
          Caption = 'Saldo Final'
          DataBinding.FieldName = 'SALDOFINAL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 111
        end
        object grdProfissionaisDadosCOMISSAOAPAGAR: TcxGridDBColumn
          Caption = 'Comiss'#227'o a Pagar'
          DataBinding.FieldName = 'COMISSAOAPAGAR'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.MinValue = 0.010000000000000000
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 106
        end
        object grdProfissionaisDadosMARCADO: TcxGridDBColumn
          DataBinding.FieldName = 'MARCADO'
          Visible = False
          VisibleForCustomization = False
        end
        object grdProfissionaisDadosDIV_CODFOR: TcxGridDBColumn
          DataBinding.FieldName = 'DIV_CODFOR'
          Visible = False
          VisibleForCustomization = False
        end
        object grdProfissionaisDadosDIV_CODCLI: TcxGridDBColumn
          DataBinding.FieldName = 'DIV_CODCLI'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object grdProfissionaisNivel: TcxGridLevel
        GridView = grdProfissionaisDados
      end
    end
    object pnlTotais: TPanel
      Left = 0
      Top = 346
      Width = 1036
      Height = 70
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        1036
        70)
      object lblTotalComissoes: TLabel
        Left = 421
        Top = 15
        Width = 109
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total Comiss'#245'es:'
      end
      object lblQtdeProfissionais: TLabel
        Left = 233
        Top = 15
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Qtde. Profissionais:'
      end
      object lblTotalCTR: TLabel
        Left = 454
        Top = 38
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total CTR:'
      end
      object lblTotalComissaoAPagar: TLabel
        Left = 642
        Top = 15
        Width = 143
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total Comiss'#227'o a Pagar:'
      end
      object edtQtdProfissionais: TEditFocus
        Left = 333
        Top = 12
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorTotal: TEditFocus
        Left = 536
        Top = 12
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
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
      object edtValorTotalCTR: TEditFocus
        Left = 536
        Top = 35
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
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
      object edtValorTotalComissaoAPagar: TEditFocus
        Left = 791
        Top = 12
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
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
      object pnlLegendas: TPanel
        Left = 906
        Top = 2
        Width = 128
        Height = 66
        Align = alRight
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object grpLegenda: TGroupBox
          Left = 0
          Top = 0
          Width = 128
          Height = 66
          Align = alClient
          Caption = 'Legenda'
          TabOrder = 0
          object shpMarcados: TShape
            Left = 8
            Top = 16
            Width = 14
            Height = 14
          end
          object lblMarcadosTexto: TLabel
            Left = 27
            Top = 16
            Width = 48
            Height = 14
            Caption = 'Marcados'
          end
          object shpDesmarcados: TShape
            Left = 8
            Top = 32
            Width = 14
            Height = 14
          end
          object lblDesmarcadosTexto: TLabel
            Left = 27
            Top = 32
            Width = 67
            Height = 14
            Caption = 'Desmarcados'
          end
          object lblMarcadosLetra: TLabel
            Left = 11
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblDesmarcadosLetra: TLabel
            Left = 11
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object shpCadastro: TShape
            Left = 8
            Top = 48
            Width = 14
            Height = 14
          end
          object lblCadastroTexto: TLabel
            Left = 27
            Top = 48
            Width = 98
            Height = 14
            Caption = 'Cadastro Incompleto'
          end
          object lblCadastroLetra: TLabel
            Left = 11
            Top = 48
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1164
    Top = 340
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1132
    Top = 340
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1060
    Top = 364
  end
  object dtsComissoes: TDataSource
    AutoEdit = False
    Left = 736
    Top = 72
  end
  object cxrEstilosCamposGrid: TcxEditRepository
    Left = 816
    Top = 76
    PixelsPerInch = 96
    object btnListaComissoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = '...'
          Default = True
          Kind = bkEllipsis
        end>
      Properties.HideSelection = False
      Properties.ReadOnly = True
      Properties.OnButtonClick = btnListaComissoesPropertiesButtonClick
    end
    object btnTotalCtr: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = '...'
          Default = True
          Kind = bkEllipsis
          Stretchable = False
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = btnTotalCtrPropertiesButtonClick
    end
  end
end
