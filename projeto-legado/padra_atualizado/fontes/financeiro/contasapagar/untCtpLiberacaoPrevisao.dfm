inherited frmCtpLiberacaoPrevisao: TfrmCtpLiberacaoPrevisao
  Width = 1031
  Height = 683
  Caption = 'Libera'#231#227'o de Lan'#231'amentos Previsionados'
  Position = poScreenCenter
  ExplicitWidth = 1031
  ExplicitHeight = 683
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 589
    Width = 1025
    TabOrder = 5
    ExplicitTop = 589
    ExplicitWidth = 1025
    inherited FlwBotoes: TFlowPanel
      Width = 1021
      ExplicitWidth = 1021
    end
    inherited btnSair: TBitBtnLocked
      TabStop = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 638
    Width = 1025
    TabOrder = 3
    ExplicitTop = 638
    ExplicitWidth = 1025
    inherited pnlNomeForm: TPanel
      Left = 854
      ExplicitLeft = 854
    end
    inherited pnlInfo: TPanel
      Width = 854
      ExplicitWidth = 854
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 4
    TabStop = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlBotoesBaixa: TPanel [3]
    Left = 0
    Top = 589
    Width = 1025
    Height = 49
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 4
      Width = 1021
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 112
        Top = 0
        Width = 116
        Height = 21
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 228
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 2
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 340
        Top = 0
        Width = 122
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 3
        OnClick = btnDesmarcarTodasClick
      end
      object btnAprovar: TBitBtnLocked
        Left = 462
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ F10 ] Aprovar'
        TabOrder = 4
        OnClick = btnAprovarClick
      end
      object btnReprovar: TBitBtnLocked
        Left = 574
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ F11 ] Reprovar'
        TabOrder = 5
        OnClick = btnReprovarClick
      end
      object btnManutencao: TBitBtnLocked
        Left = 686
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ F12 ] C. Pagar'
        TabOrder = 6
        OnClick = btnManutencaoClick
      end
      object btnAnexos: TBitBtnLocked
        Left = 798
        Top = 0
        Width = 112
        Height = 21
        Caption = '[ Alt+F12 ] Anexos'
        TabOrder = 7
        OnClick = btnAnexosClick
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 1021
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 909
      Top = 26
      Width = 112
      Height = 20
      Align = alCustom
      Anchors = [akRight, akBottom]
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairBaixaClick
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1025
    Height = 171
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 53
      Top = 10
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 320
      Top = 121
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vencimento:'
    end
    object lblCodEmp: TLabel
      Left = 66
      Top = 76
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label24: TLabel
      Left = 68
      Top = 98
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label11: TLabel
      Left = 478
      Top = 121
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label3: TLabel
      Left = 20
      Top = 121
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:  Cadastro:'
    end
    object Label25: TLabel
      Left = 211
      Top = 121
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label26: TLabel
      Left = 77
      Top = 145
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object ColorLabel2: TColorLabel
      Left = 695
      Top = 10
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label10: TLabel
      Left = 602
      Top = 10
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio Boleto?:'
    end
    object Label12: TLabel
      Left = 619
      Top = 32
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque?:'
    end
    object Label15: TLabel
      Left = 619
      Top = 54
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio NF?:'
    end
    object Label17: TLabel
      Left = 614
      Top = 76
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dep'#243'sito?:'
    end
    object ColorLabel1: TColorLabel
      Left = 695
      Top = 32
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object ColorLabel3: TColorLabel
      Left = 695
      Top = 54
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object ColorLabel4: TColorLabel
      Left = 695
      Top = 76
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 117
      Top = 7
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodForExit
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
      Left = 190
      Top = 7
      Width = 389
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomEmp: TEditFocus
      Left = 190
      Top = 73
      Width = 389
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 117
      Top = 73
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkLimFil: TCheckBox
      Left = 424
      Top = 144
      Width = 155
      Height = 19
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object edtDesPor: TEditFocus
      Left = 190
      Top = 95
      Width = 389
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
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 117
      Top = 95
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object btnConsultar: TBitBtnLocked
      Left = 821
      Top = 143
      Width = 106
      Height = 21
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 16
      OnClick = btnConsultarClick
    end
    object mskDtaVenIni: TcxDateEdit
      Tag = 99
      Left = 384
      Top = 117
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
      TabOrder = 8
      Width = 90
    end
    object mskDtaVenFin: TcxDateEdit
      Tag = 99
      Left = 489
      Top = 117
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
      TabOrder = 9
      Width = 90
    end
    object mskDtaCadIni: TcxDateEdit
      Tag = 99
      Left = 117
      Top = 117
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
      TabOrder = 6
      Width = 90
    end
    object mskDtaCadFin: TcxDateEdit
      Tag = 99
      Left = 222
      Top = 117
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
      TabOrder = 7
      Width = 90
    end
    object cmbStatus: TComboBoxFocus
      Left = 117
      Top = 142
      Width = 195
      Height = 22
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 10
      Text = 'Todos'
      Items.Strings = (
        'Aguardando Libera'#231#227'o'
        'Reprovados'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 23
      Top = 51
      Width = 556
      Height = 22
      TabOrder = 2
      ExplicitLeft = 23
      ExplicitTop = 51
      ExplicitWidth = 556
      inherited lblEventos: TLabel
        Left = 3
        Top = 3
        Width = 87
        Height = 14
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 72
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 167
        Width = 389
        Height = 22
        Enabled = True
        ExplicitLeft = 167
        ExplicitWidth = 389
        ExplicitHeight = 22
      end
    end
    object edtUsaChq: TEditFocus
      Tag = 99
      Left = 667
      Top = 29
      Width = 23
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 13
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtVeioNF: TEditFocus
      Tag = 99
      Left = 667
      Top = 51
      Width = 23
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 14
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtVeiobo: TEditFocus
      Tag = 99
      Left = 667
      Top = 7
      Width = 23
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 12
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtDeposi: TEditFocus
      Tag = 99
      Left = 667
      Top = 73
      Width = 23
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 15
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 31
      Top = 29
      Width = 552
      Height = 22
      TabOrder = 1
      ExplicitLeft = 31
      ExplicitTop = 29
      ExplicitWidth = 552
      inherited lblPlaContas: TLabel
        Left = 0
        Width = 81
        Height = 14
        ExplicitLeft = 0
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 159
        Width = 389
        Height = 22
        ExplicitLeft = 159
        ExplicitWidth = 389
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 86
        Width = 72
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 86
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
    end
  end
  object pnlAux1: TPanel [5]
    Left = 0
    Top = 171
    Width = 1025
    Height = 418
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlTotais: TPanel
      Left = 0
      Top = 294
      Width = 1025
      Height = 124
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label21: TLabel
        Left = 234
        Top = 9
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label23: TLabel
        Left = 208
        Top = 32
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Liberando:'
      end
      object Label6: TLabel
        Left = 17
        Top = 9
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Duplicatas:'
      end
      object Label9: TLabel
        Left = 2
        Top = 32
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Selecionadas:'
      end
      object Label14: TLabel
        Left = 383
        Top = 9
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label4: TLabel
        Left = 23
        Top = 77
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Veio Cheque?:'
      end
      object Label13: TLabel
        Left = 27
        Top = 54
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Respons'#225'vel:'
      end
      object Label5: TLabel
        Left = 274
        Top = 77
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Veio NF?:'
      end
      object Label8: TLabel
        Left = 150
        Top = 77
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Veio boleto?:'
      end
      object Label7: TLabel
        Left = 42
        Top = 100
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dep'#243'sito?:'
      end
      object edtQtdDuplicatas: TEditFocus
        Left = 96
        Top = 5
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtQtdSelecionadas: TEditFocus
        Left = 96
        Top = 28
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValorTotal: TEditFocus
        Left = 265
        Top = 5
        Width = 107
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotalPago: TEditFocus
        Left = 265
        Top = 28
        Width = 107
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtCheque: TEditFocus
        Left = 96
        Top = 74
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodigoResponsavel: TEditFocus
        Left = 96
        Top = 51
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDescricaoResponsavel: TEditFocus
        Left = 146
        Top = 51
        Width = 226
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtNF: TEditFocus
        Left = 323
        Top = 74
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtVeioBoleto: TEditFocus
        Left = 215
        Top = 74
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtHistor: TMemoFocus
        Left = 434
        Top = 5
        Width = 287
        Height = 114
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object edtDeposito: TEditFocus
        Left = 96
        Top = 97
        Width = 49
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object dbgDuplicatas: TcxGrid
      Left = 0
      Top = 0
      Width = 1025
      Height = 294
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasView: TcxGridDBTableView
        OnDblClick = dbgDuplicatasViewDblClick
        OnKeyDown = dbgDuplicatasViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDuplicatasViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        object dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'CTP_NUMDUP'
          Width = 92
        end
        object dbgDuplicatasCTP_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTP_CODEMP'
          Width = 37
        end
        object dbgDuplicatasCTP_SERIE_: TcxGridDBColumn
          Caption = 'S'#233'rie'
          DataBinding.FieldName = 'CTP_SERIE_'
          Width = 37
        end
        object dbgDuplicatasCTP_CODFOR: TcxGridDBColumn
          Caption = 'Cod. Forn.'
          DataBinding.FieldName = 'CTP_CODFOR'
          Width = 55
        end
        object dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn
          Caption = 'Nom. Forn.'
          DataBinding.FieldName = 'FOR_NOMFOR'
          Width = 202
        end
        object dbgDuplicatasCTP_DTACAD: TcxGridDBColumn
          Caption = 'Dta. cadastro'
          DataBinding.FieldName = 'CTP_DTACAD'
          Width = 76
        end
        object dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTP_DTAVEN'
          Width = 68
        end
        object dbgDuplicatasViewCTP_VALDUP: TcxGridDBColumn
          Caption = 'Valor Duplicata'
          DataBinding.FieldName = 'CTP_VALDUP'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 81
        end
        object dbgDuplicatasViewCTP_MULSUJ: TcxGridDBColumn
          Caption = 'Juros'
          DataBinding.FieldName = 'CTP_JURSUJ'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
        end
        object dbgDuplicatasViewCTP_JURSUJ: TcxGridDBColumn
          Caption = 'Multa'
          DataBinding.FieldName = 'CTP_MULSUJ'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
        end
        object dbgDuplicatasViewCTP_DESSUJ: TcxGridDBColumn
          Caption = 'Desconto'
          DataBinding.FieldName = 'CTP_DESSUJ'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
        end
        object dbgDuplicatasTOTDUP: TcxGridDBColumn
          Caption = 'Valor Corrigido'
          DataBinding.FieldName = 'TOTDUP'
          Width = 107
        end
        object dbgDuplicatasCTP_NOMPOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'CTP_NOMPOR'
          Width = 143
        end
        object dbgDuplicatasViewCTP_NOMEVE: TcxGridDBColumn
          Caption = 'Centro de Custos'
          DataBinding.FieldName = 'CTP_NOMEVE'
          Width = 148
        end
        object dbgDuplicatasViewCTP_NOMCTA: TcxGridDBColumn
          Caption = 'Plano de Contas'
          DataBinding.FieldName = 'CTP_NOMCTA'
          Width = 128
        end
        object dbgDuplicatasCTP_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTP_MARDES'
          Visible = False
        end
        object dbgDuplicatasViewSTATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'STATUS'
          Width = 158
        end
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasView
      end
    end
  end
end
