inherited frmBaixaChequesRepasse: TfrmBaixaChequesRepasse
  Left = 178
  Top = 90
  Width = 946
  Height = 609
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Cheques para Repasse'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 946
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 538
    Width = 940
    ExplicitTop = 538
    ExplicitWidth = 940
    DesignSize = (
      940
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 936
      ExplicitWidth = 936
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      TabStop = False
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 564
    Width = 940
    TabOrder = 3
    ExplicitTop = 564
    ExplicitWidth = 940
    inherited pnlNomeForm: TPanel
      Left = 786
      Width = 154
      ExplicitLeft = 786
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 786
      ExplicitWidth = 786
    end
  end
  inherited pgcDados: TPageControl
    Left = 418
    Top = 105
    Width = 522
    Height = 433
    TabOrder = 1
    TabStop = False
    Visible = False
    ExplicitLeft = 418
    ExplicitTop = 105
    ExplicitWidth = 522
    ExplicitHeight = 433
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 514
      ExplicitHeight = 401
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 940
    Height = 105
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 40
      Top = 40
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vencimento:'
    end
    object Label3: TLabel
      Left = 201
      Top = 40
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object lblEmpresa: TLabel
      Left = 309
      Top = 17
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 10
      Top = 14
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Cadastro:'
    end
    object lbl2: TLabel
      Left = 201
      Top = 14
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 355
      Top = 10
      Width = 39
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 395
      Top = 10
      Width = 377
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
    object mskDtaCadIni: TcxDateEdit
      Tag = 99
      Left = 105
      Top = 10
      AutoSize = False
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
      Height = 24
      Width = 90
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 105
      Top = 37
      AutoSize = False
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
      Height = 24
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 213
      Top = 37
      AutoSize = False
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
      TabOrder = 3
      Height = 24
      Width = 90
    end
    object mskDtaCadFin: TcxDateEdit
      Tag = 99
      Left = 213
      Top = 10
      AutoSize = False
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
      TabOrder = 1
      Height = 24
      Width = 90
    end
    object btnCarrCheques: TBitBtnLocked
      Left = 812
      Top = 71
      Width = 121
      Height = 21
      Align = alCustom
      Caption = '&Carregar Cheques'
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
      TabOrder = 6
      OnClick = btnCarrChequesClick
    end
    object grbCMC7: TGroupBox
      Left = 309
      Top = 40
      Width = 387
      Height = 57
      Caption = 'C'#243'digo CMC7'
      TabOrder = 5
      object lblCMC7: TLabel
        Left = 147
        Top = 13
        Width = 101
        Height = 14
        Caption = 'Digite o c'#243'digo CMC7'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkLeitor: TCheckBox
        Left = 9
        Top = 17
        Width = 130
        Height = 17
        Caption = 'Leitor de Cheque'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkLeitorClick
      end
      object chkInfMan: TCheckBox
        Left = 9
        Top = 33
        Width = 130
        Height = 17
        Caption = 'Informar manualmente'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
        OnClick = chkInfManClick
      end
      object edtCMC7: TEditFocus
        Tag = 99
        Left = 147
        Top = 30
        Width = 225
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlAux1: TPanel [4]
    Left = 418
    Top = 105
    Width = 522
    Height = 433
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 522
      Height = 259
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label5: TLabel
        Left = 97
        Top = 13
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object Nome: TLabel
        Left = 101
        Top = 35
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label7: TLabel
        Left = 88
        Top = 57
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
      end
      object Label10: TLabel
        Left = 64
        Top = 79
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cta. Corrente:'
      end
      object Label12: TLabel
        Left = 68
        Top = 101
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheque:'
      end
      object Label14: TLabel
        Left = 88
        Top = 123
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Emitente:'
      end
      object Label1: TLabel
        Left = 82
        Top = 145
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object Label6: TLabel
        Left = 87
        Top = 167
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
      end
      object Label11: TLabel
        Left = 83
        Top = 189
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Nota:'
      end
      object Label15: TLabel
        Left = 72
        Top = 211
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vencimento:'
      end
      object Label20: TLabel
        Left = 103
        Top = 233
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object edtCodBco: TEditFocus
        Left = 135
        Top = 9
        Width = 274
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtNomBco: TEditFocus
        Left = 135
        Top = 31
        Width = 274
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtNumAge: TEditFocus
        Left = 135
        Top = 53
        Width = 274
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtConCor: TEditFocus
        Left = 135
        Top = 75
        Width = 274
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
      object edtNumChq: TEditFocus
        Left = 135
        Top = 97
        Width = 274
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
      object edtNomEmi: TEditFocus
        Left = 135
        Top = 119
        Width = 274
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
      object edtEndere: TEditFocus
        Left = 135
        Top = 141
        Width = 274
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
      object edtFone01: TEditFocus
        Left = 135
        Top = 163
        Width = 274
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
      object edtNumNot: TEditFocus
        Left = 135
        Top = 185
        Width = 274
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
      object edtDtaVen: TEditFocus
        Left = 135
        Top = 207
        Width = 274
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtValChq: TEditFocus
        Left = 135
        Top = 229
        Width = 274
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
    object pnlInformativos: TPanel
      Left = 0
      Top = 259
      Width = 298
      Height = 131
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 294
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'CHEQUES SELECIONADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 370
      end
      object Label17: TLabel
        Left = 24
        Top = 24
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheques:'
      end
      object Label19: TLabel
        Left = 40
        Top = 46
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object lblTotRep: TLabel
        Left = 9
        Top = 69
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total a Repassar:'
        Visible = False
      end
      object Label31: TLabel
        Left = 3
        Top = 92
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prz. M'#233'dio Vencto:'
      end
      object edtChqSelecionados: TEditFocus
        Left = 96
        Top = 19
        Width = 83
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
      object edtTotalSelecionado: TEditFocus
        Left = 96
        Top = 42
        Width = 83
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
      object edtTotRep: TEditFocus
        Left = 96
        Top = 65
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gpbLegenda: TGroupBox
        Left = 180
        Top = 18
        Width = 111
        Height = 67
        Caption = 'Legenda'
        TabOrder = 4
        object Shape1: TShape
          Left = 4
          Top = 16
          Width = 14
          Height = 14
        end
        object Label21: TLabel
          Left = 23
          Top = 16
          Width = 65
          Height = 14
          Caption = 'Selecionados'
        end
        object Shape2: TShape
          Left = 4
          Top = 32
          Width = 14
          Height = 14
        end
        object Label24: TLabel
          Left = 23
          Top = 32
          Width = 62
          Height = 14
          Caption = 'Transferidos'
        end
        object Label25: TLabel
          Left = 7
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
          StyleElements = [seClient, seBorder]
        end
        object Label26: TLabel
          Left = 7
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
          StyleElements = [seClient, seBorder]
        end
        object Shape3: TShape
          Left = 4
          Top = 48
          Width = 14
          Height = 14
        end
        object Label4: TLabel
          Left = 23
          Top = 48
          Width = 84
          Height = 14
          Caption = 'N'#227'o Transferidos'
        end
        object Label8: TLabel
          Left = 7
          Top = 48
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
      end
      object edtChqPrzMedVen: TEditFocus
        Left = 96
        Top = 88
        Width = 83
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
    end
    object pnlModalidades: TPanel
      Left = 0
      Top = 390
      Width = 522
      Height = 43
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object Label13: TLabel
        Left = 2
        Top = 2
        Width = 518
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'DEMAIS MODALIDADES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 370
      end
      object Label18: TLabel
        Left = 6
        Top = 22
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dinheiro:'
      end
      object Label22: TLabel
        Left = 160
        Top = 22
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cheque Emitido:'
      end
      object Label27: TLabel
        Left = 338
        Top = 22
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dep'#243'sito Banc'#225'rio:'
      end
      object edtDinheiro: TEditFocus
        Left = 51
        Top = 17
        Width = 83
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
      object edtChqVista: TEditFocus
        Left = 239
        Top = 17
        Width = 83
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
      object edtOrdPag: TEditFocus
        Left = 432
        Top = 17
        Width = 83
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
    end
    object pnlTitulos: TPanel
      Left = 298
      Top = 259
      Width = 224
      Height = 131
      Align = alRight
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      Visible = False
      object Label28: TLabel
        Left = 48
        Top = 24
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label29: TLabel
        Left = 2
        Top = 2
        Width = 220
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'T'#205'TULOS SELECIONADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 370
      end
      object Label30: TLabel
        Left = 11
        Top = 46
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prz. M'#233'dio Vencto:'
      end
      object edtTitSel: TEditFocus
        Left = 107
        Top = 19
        Width = 83
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
      object edtTitPrzMedVen: TEditFocus
        Left = 107
        Top = 42
        Width = 83
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
    end
  end
  object pnlAux2: TPanel [5]
    Left = 0
    Top = 105
    Width = 418
    Height = 433
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object pnlTotais: TPanel
      Left = 0
      Top = 398
      Width = 418
      Height = 35
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label23: TLabel
        Left = 301
        Top = 10
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object label9: TLabel
        Left = 7
        Top = 10
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. de Cheques:'
      end
      object edtValorTotal: TEditFocus
        Left = 328
        Top = 6
        Width = 83
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
      object edtTotalCheques: TEditFocus
        Left = 92
        Top = 6
        Width = 83
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
    end
    object dbgCheques2: TDBGridCitel
      Left = 0
      Top = 0
      Width = 418
      Height = 398
      TabStop = False
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgCheques2DrawColumnCell
      OnDblClick = dbgCheques2DblClick
      OnKeyDown = dbgCheques2KeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CHQ_CODBCO'
          Title.Caption = 'Banco'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_NUMCHQ'
          Title.Caption = 'Cheque'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_CODEMP'
          Title.Caption = 'Emp.'
          Width = 33
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_DTACAD'
          Title.Caption = 'Dta. Cad.'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_DTAVEN'
          Title.Caption = 'Dta. Ven.'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CHQ_VALCHQ'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Cheque'
          Width = 85
          Visible = True
        end>
    end
    object dbgCheques: TcxGrid
      Left = 0
      Top = 0
      Width = 418
      Height = 398
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgChequesDados: TcxGridDBTableView
        OnKeyDown = dbgChequesDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgChequesDadosCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideSelection = True
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        Preview.AutoHeight = False
        object dbgChequesDadosCHQ_CODBCO: TcxGridDBColumn
          Caption = 'Banco'
          DataBinding.FieldName = 'CHQ_CODBCO'
          Width = 61
        end
        object dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn
          Caption = 'Nro. Cheque'
          DataBinding.FieldName = 'CHQ_NUMCHQ'
          Width = 80
        end
        object dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CHQ_CODEMP'
          Width = 42
        end
        object dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn
          Caption = 'Dta. Cad.'
          DataBinding.FieldName = 'CHQ_DTACAD'
          Width = 61
        end
        object dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn
          Caption = 'Dta. Ven.'
          DataBinding.FieldName = 'CHQ_DTAVEN'
        end
        object dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn
          Caption = 'Valor Cheque'
          DataBinding.FieldName = 'CHQ_VALCHQ'
          Width = 76
        end
        object dbgChequesDadosCHQ_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CHQ_MARDES'
          Visible = False
          Options.AutoWidthSizable = False
        end
        object dbgChequesDadosCHQ_RESCAI: TcxGridDBColumn
          DataBinding.FieldName = 'CHQ_RESCAI'
          Visible = False
        end
        object dbgChequesDadosCHQ_DTATRA: TcxGridDBColumn
          DataBinding.FieldName = 'CHQ_DTATRA'
          Visible = False
        end
        object dbgChequesDadosCHQ_TRFLIB: TcxGridDBColumn
          DataBinding.FieldName = 'CHQ_TRFLIB'
          Visible = False
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object dbgChequesNivel: TcxGridLevel
        GridView = dbgChequesDados
      end
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 538
    Width = 940
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 942
      Height = 22
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 21
        Align = alLeft
        Caption = '[F5] Inicia Busca'
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 121
        Height = 21
        Caption = '[F6] Localiza Pr'#243'xima'
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 242
        Top = 0
        Width = 121
        Height = 21
        Align = alLeft
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnDesmTodos: TBitBtnLocked
        Left = 363
        Top = 0
        Width = 121
        Height = 21
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 3
        OnClick = btnDesmTodosClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 484
        Top = 0
        Width = 111
        Height = 21
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        TabOrder = 4
        OnClick = btnConfirmaClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 827
      Top = 2
      Width = 111
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 32
  end
end
