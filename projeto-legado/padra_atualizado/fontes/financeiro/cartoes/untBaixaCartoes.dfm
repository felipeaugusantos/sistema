inherited frmBaixaCartoes: TfrmBaixaCartoes
  Left = 293
  Top = 161
  Width = 1369
  Height = 841
  Caption = 'Baixa de Cart'#245'es - Manual'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1369
  ExplicitHeight = 841
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 771
    Width = 1363
    TabOrder = 6
    ExplicitTop = 771
    ExplicitWidth = 1363
    DesignSize = (
      1363
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1359
      ExplicitWidth = 1359
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 796
    Width = 1363
    TabOrder = 2
    ExplicitTop = 796
    ExplicitWidth = 1363
    inherited pnlNomeForm: TPanel
      Left = 1195
      Width = 168
      ExplicitLeft = 1195
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 1195
      ExplicitWidth = 1195
      object shpMultSel: TShape
        Left = 610
        Top = 2
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
  inherited pgcDados: TPageControl
    Top = 151
    Width = 995
    Height = 620
    TabOrder = 1
    Visible = False
    ExplicitTop = 151
    ExplicitWidth = 995
    ExplicitHeight = 620
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 987
      ExplicitHeight = 588
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1363
    Height = 151
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 82
      Top = 39
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label2: TLabel
      Left = 16
      Top = 68
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de Cadastro:'
    end
    object Label3: TLabel
      Left = 211
      Top = 69
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label8: TLabel
      Left = 317
      Top = 68
      Width = 113
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de Vencimento:'
    end
    object Label11: TLabel
      Left = 72
      Top = 125
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label17: TLabel
      Left = 71
      Top = 10
      Width = 46
      Height = 14
      Caption = 'Bandeira:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 82
      Top = 96
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label19: TLabel
      Left = 526
      Top = 69
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object rdgEmpresa: TRadioGroup
      Left = 449
      Top = 113
      Width = 177
      Height = 33
      Caption = 'Empresa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 12
    end
    object edtCodCar: TEditFocus
      Tag = 99
      Left = 119
      Top = 35
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      OnKeyPress = edtCodCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCar: TEditFocus
      Left = 187
      Top = 35
      Width = 439
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 119
      Top = 122
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 10
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
    object edtDesEmp: TEditFocus
      Left = 187
      Top = 122
      Width = 257
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodBan: TEditFocus
      Tag = 99
      Left = 119
      Top = 7
      Width = 67
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
      TabOrder = 0
      OnKeyPress = edtCodBanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesBan: TEditFocus
      Left = 187
      Top = 7
      Width = 439
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
    object edtCodCli2: TEditFocus
      Tag = 99
      Left = 119
      Top = 93
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 8
      OnExit = edtCodCli2Exit
      OnKeyPress = edtCodCli2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli2: TEditFocus
      Left = 187
      Top = 93
      Width = 439
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object btnCarrCartoes: TBitBtnLocked
      Left = 632
      Top = 122
      Width = 111
      Height = 22
      Align = alCustom
      Caption = '&Carregar Cart'#245'es'
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
      TabOrder = 13
      OnClick = btnCarrCartoesClick
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 119
      Top = 63
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
      TabOrder = 4
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 223
      Top = 63
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
      TabOrder = 5
      Width = 90
    end
    object mskDtaIniVenc: TcxDateEdit
      Tag = 99
      Left = 434
      Top = 63
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
    object mskDtaFinVenc: TcxDateEdit
      Tag = 99
      Left = 536
      Top = 63
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
  end
  object pnlAux1: TPanel [4]
    Left = 995
    Top = 151
    Width = 368
    Height = 620
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 5
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 368
      Height = 620
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label5: TLabel
        Left = 63
        Top = 14
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Operadora: TLabel
        Left = 44
        Top = 60
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operadora:'
      end
      object Label7: TLabel
        Left = 56
        Top = 106
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tx. Adm:'
      end
      object Label10: TLabel
        Left = 31
        Top = 129
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Sem Taxa:'
      end
      object Label14: TLabel
        Left = 53
        Top = 198
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label4: TLabel
        Left = 195
        Top = 106
        Width = 10
        Height = 14
        Caption = '%'
      end
      object Label6: TLabel
        Left = 55
        Top = 152
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Taxa:'
      end
      object Label12: TLabel
        Left = 68
        Top = 37
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label20: TLabel
        Left = 27
        Top = 83
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dt. Transa'#231#227'o:'
      end
      object flbConciliacao: TFileListBox
        Left = 6
        Top = 331
        Width = 275
        Height = 112
        ItemHeight = 14
        TabOrder = 9
        Visible = False
      end
      object edtCodCli: TEditFocus
        Left = 99
        Top = 11
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtNomCli: TEditFocus
        Left = 99
        Top = 34
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtPerCar: TEditFocus
        Left = 99
        Top = 103
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtValOri: TEditFocus
        Left = 99
        Top = 126
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValTax: TEditFocus
        Left = 99
        Top = 149
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtHist01: TEditFocus
        Left = 99
        Top = 195
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtHist02: TEditFocus
        Left = 99
        Top = 218
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtOperad: TEditFocus
        Left = 99
        Top = 57
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object pnlInformativos: TPanel
        Left = 2
        Top = 548
        Width = 364
        Height = 70
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 8
        object GroupBox1: TGroupBox
          Left = 16
          Top = 1
          Width = 336
          Height = 65
          Caption = 'Legenda'
          TabOrder = 0
          object Shape1: TShape
            Left = 8
            Top = 16
            Width = 14
            Height = 14
          end
          object Label21: TLabel
            Left = 27
            Top = 16
            Width = 65
            Height = 14
            Caption = 'Selecionados'
          end
          object Shape2: TShape
            Left = 8
            Top = 32
            Width = 14
            Height = 14
          end
          object Label24: TLabel
            Left = 27
            Top = 32
            Width = 62
            Height = 14
            Caption = 'Transferidos'
          end
          object Label25: TLabel
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
            StyleElements = [seClient, seBorder]
          end
          object Label26: TLabel
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
            StyleElements = [seClient, seBorder]
          end
          object Shape3: TShape
            Left = 8
            Top = 48
            Width = 14
            Height = 14
          end
          object lblNaoTransferidos: TLabel
            Left = 27
            Top = 48
            Width = 84
            Height = 14
            Caption = 'N'#227'o Transferidos'
          end
          object Label27: TLabel
            Left = 11
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
          object Shape4: TShape
            Left = 120
            Top = 16
            Width = 14
            Height = 14
          end
          object Label29: TLabel
            Left = 139
            Top = 16
            Width = 114
            Height = 14
            Caption = 'Cancelamentos/Ajustes'
          end
          object Label30: TLabel
            Left = 123
            Top = 16
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
            StyleElements = [seClient, seBorder]
          end
          object shpNegociado: TShape
            Left = 120
            Top = 32
            Width = 14
            Height = 14
            Brush.Color = clMoneyGreen
          end
          object lblNegociado: TLabel
            Left = 139
            Top = 32
            Width = 120
            Height = 14
            Caption = 'Negociado anteriormente'
          end
          object lblNegociadoA: TLabel
            Left = 123
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clMoneyGreen
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
          object shpDefinirEmpresaAjuste: TShape
            Left = 120
            Top = 48
            Width = 14
            Height = 14
            Brush.Color = clYellow
          end
          object lblDefinirEmpresaAjuste: TLabel
            Left = 139
            Top = 48
            Width = 188
            Height = 14
            Caption = 'Cancelamento/Ajuste - Definir empresa'
          end
          object lblDefinirEmpresaAjusteA: TLabel
            Left = 123
            Top = 48
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clRed
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
      object edtDtaCup: TEditFocus
        Left = 99
        Top = 80
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object pnlDadosConcil: TPanel
        Left = 4
        Top = 263
        Width = 354
        Height = 283
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 11
        Visible = False
        object Label31: TLabel
          Left = 13
          Top = 5
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ponto de Venda:'
        end
        object Label32: TLabel
          Left = 18
          Top = 28
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador Baixa:'
        end
        object Label33: TLabel
          Left = 31
          Top = 51
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Baixa:'
        end
        object Label34: TLabel
          Left = 22
          Top = 97
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador Taxa:'
        end
        object Label35: TLabel
          Left = 7
          Top = 119
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor Taxa:'
        end
        object Label36: TLabel
          Left = 35
          Top = 143
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Taxa:'
        end
        object Label37: TLabel
          Left = 15
          Top = 189
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador D'#233'bito:'
        end
        object Label38: TLabel
          Left = 28
          Top = 212
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta D'#233'bito:'
        end
        object Label39: TLabel
          Left = 9
          Top = 235
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo D'#233'bito:'
        end
        object Label40: TLabel
          Left = 7
          Top = 258
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cta. Antecipa'#231#227'o:'
        end
        object Label41: TLabel
          Left = 12
          Top = 74
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo Baixa:'
        end
        object Label42: TLabel
          Left = 17
          Top = 166
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo Taxa:'
        end
        object edtPonVen: TEditFocus
          Left = 93
          Top = 2
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtPorBai: TEditFocus
          Left = 93
          Top = 25
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtCtaBai: TEditFocus
          Left = 93
          Top = 48
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtPorTax: TEditFocus
          Left = 93
          Top = 94
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtForTax: TEditFocus
          Left = 93
          Top = 117
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaTax: TEditFocus
          Left = 93
          Top = 140
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorDeb: TEditFocus
          Left = 93
          Top = 186
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaDeb: TEditFocus
          Left = 93
          Top = 209
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEveDeb: TEditFocus
          Left = 93
          Top = 232
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaAnt: TEditFocus
          Left = 93
          Top = 255
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEventoBaixa: TEditFocus
          Left = 93
          Top = 71
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEventoTaxaBaixa: TEditFocus
          Left = 93
          Top = 163
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      end
      object pnlAntecipacao: TPanel
        Left = 195
        Top = 149
        Width = 162
        Height = 22
        BevelOuter = bvNone
        Caption = 'pnlAntecipacao'
        ShowCaption = False
        TabOrder = 13
        Visible = False
        object lblAntTax: TLabel
          Left = 1
          Top = 3
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Taxa Ant.:'
        end
        object edtAntTax: TEditFocus
          Left = 68
          Top = 0
          Width = 88
          Height = 22
          Hint = 'Valor da taxa de Antecipa'#231#227'o.'
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlMarketPlace: TPanel
        Left = 0
        Top = 172
        Width = 358
        Height = 22
        BevelOuter = bvNone
        Color = 16770261
        Constraints.MinWidth = 358
        ParentBackground = False
        TabOrder = 12
        Visible = False
        object Label43: TLabel
          Left = 53
          Top = 3
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Frete:'
        end
        object Label44: TLabel
          Left = 203
          Top = 3
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Ajustes:'
        end
        object edtValorFrete: TEditFocus
          Left = 99
          Top = 0
          Width = 94
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtValorAjuste: TEditFocus
          Left = 263
          Top = 0
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
      end
      object pnlCupomMarketPlace: TPanel
        Left = 195
        Top = 126
        Width = 162
        Height = 22
        BevelOuter = bvNone
        Caption = 'pnlAntecipacao'
        ShowCaption = False
        TabOrder = 14
        Visible = False
        object lblCupomMarketPlace: TLabel
          Left = 13
          Top = 3
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Cupom:'
        end
        object edtCupomMarketPlace: TEditFocus
          Left = 68
          Top = 0
          Width = 88
          Height = 22
          Hint = 'Valor do Cupom de Desconto.'
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlPorcenTaxaAntecipacao: TPanel
        Left = 211
        Top = 84
        Width = 149
        Height = 42
        BevelOuter = bvNone
        TabOrder = 15
        Visible = False
        object lblPorcenTaxaAnt: TLabel
          Left = 13
          Top = 23
          Width = 37
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tx. Ant:'
        end
        object edtPorcentagemTaxaAntecipacao: TEditFocus
          Left = 52
          Top = 19
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
      end
    end
  end
  object pnlAux2: TPanel [5]
    Left = 0
    Top = 151
    Width = 995
    Height = 620
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlTotais: TPanel
      Left = 0
      Top = 548
      Width = 995
      Height = 72
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object pnlAjustaTotal1: TPanel
        Left = 2
        Top = 2
        Width = 418
        Height = 68
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label23: TLabel
          Left = 202
          Top = 43
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Recebendo:'
        end
        object Label9: TLabel
          Left = 235
          Top = 22
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total:'
        end
        object Label13: TLabel
          Left = 264
          Top = 4
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade'
        end
        object Label16: TLabel
          Left = 338
          Top = 4
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Sem Taxa'
        end
        object edtQtdDup: TEditFocus
          Left = 262
          Top = 18
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtQtdSel: TEditFocus
          Left = 262
          Top = 39
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtTotDup: TEditFocus
          Left = 336
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtTotSel: TEditFocus
          Left = 336
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
      end
      object pnlAjustaTotal2: TPanel
        Left = 420
        Top = 2
        Width = 80
        Height = 68
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        Visible = False
        object Label28: TLabel
          Left = 3
          Top = 4
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Ajustes'
        end
        object edtAjuTot: TEditFocus
          Left = -1
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtAjuSel: TEditFocus
          Left = -1
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
      end
      object pnlAjustaTotal3: TPanel
        Left = 500
        Top = 2
        Width = 493
        Height = 68
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label15: TLabel
          Left = 3
          Top = 4
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr.L'#237'quido'
        end
        object edtTotDupLiq: TEditFocus
          Left = 0
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
        object edtTotSelLiq: TEditFocus
          Left = 0
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
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
      end
    end
    object grdDuplic: TcxGridCitel
      Left = 0
      Top = 0
      Width = 995
      Height = 548
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdDuplicDados: TcxGridDBTableViewCitel
        OnDblClick = grdDuplicDadosDblClick
        OnKeyDown = grdDuplicDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdDuplicDadosCustomDrawCell
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
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn
          Caption = 'N'#250'm. Libera'#231#227'o'
          DataBinding.FieldName = 'MCA_NUMCCD'
          Width = 81
        end
        object grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn
          Caption = 'NSU'
          DataBinding.FieldName = 'MCA_NUMNSU'
          Width = 118
        end
        object grdDuplicDadosMCA_NUMPOK: TcxGridDBColumn
          Caption = 'N'#250'm. Pedido'
          DataBinding.FieldName = 'MCA_NUMPOK'
          Width = 90
        end
        object grdDuplicDadosMCA_CODEMP: TcxGridDBColumn
          Caption = 'Emp.Fat.'
          DataBinding.FieldName = 'MCA_CODEMP'
          Width = 42
        end
        object grdDuplicDadosMCA_EMPRCX: TcxGridDBColumn
          Caption = 'Emp.Ori.'
          DataBinding.FieldName = 'MCA_EMPRCX'
          Width = 42
        end
        object grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'MCA_DTAVEN'
          Width = 63
        end
        object grdDuplicDadosMCA_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'MCA_DTACAD'
          Width = 67
        end
        object grdDuplicDadosMCA_VALTOT: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'MCA_VALTOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.EditFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 76
        end
        object grdDuplicDadosMCA_VALSTA: TcxGridDBColumn
          Caption = 'Vl. s/ Taxa'
          DataBinding.FieldName = 'MCA_VALSTA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.EditFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 57
        end
        object grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn
          Caption = 'N'#250'm. Nota'
          DataBinding.FieldName = 'MCA_NUMNOT'
          Width = 120
        end
        object grdDuplicDadosPARDUP: TcxGridDBColumn
          Caption = 'Parc.'
          DataBinding.FieldName = 'PARDUP'
          Width = 37
        end
        object grdDuplicDadosMCA_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_MARDES'
          Visible = False
          Width = 20
        end
        object grdDuplicDadosMCA_RESCAI: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_RESCAI'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
        end
        object grdDuplicDadosMCA_DTATRA: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_DTATRA'
          Visible = False
        end
        object grdDuplicDadosMCA_AJUSTE: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_AJUSTE'
          Visible = False
        end
        object grdDuplicDadosSIT_CAD: TcxGridDBColumn
          Caption = 'Sit. Cadastro'
          DataBinding.FieldName = 'SIT_CAD'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = imgSitCad
          Properties.Items = <
            item
              Description = 'Incompleto'
              ImageIndex = 1
              Value = 'INCOMPLETO'
            end
            item
              Description = 'Completo'
              ImageIndex = 2
              Value = 'COMPLETO'
            end>
          Properties.ShowDescriptions = False
          Width = 76
        end
        object grdDuplicDadosMCA_TRFLIB: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_TRFLIB'
          Visible = False
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosNEGOCIACAO: TcxGridDBColumn
          DataBinding.FieldName = 'NEGOCIACAO'
          Visible = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosNEGOCIADO_ANTERIORMENTE: TcxGridDBColumn
          Caption = 'NEGOCIACAO_ANT'
          DataBinding.FieldName = 'NEGOCIADO_ANTERIORMENTE'
          Visible = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosBAN_NOMBAN: TcxGridDBColumn
          Caption = 'Bandeira'
          DataBinding.FieldName = 'BAN_NOMBAN'
          HeaderAlignmentHorz = taCenter
          Width = 57
        end
        object grdDuplicDadosCARTAO: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'CARTAO'
          HeaderAlignmentHorz = taCenter
        end
        object grdDuplicDadosESTABE: TcxGridDBColumn
          Caption = 'N'#186' Estabelecimento'
          DataBinding.FieldName = 'MCA_ESTABE'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
        end
        object grdDuplicDadosREGISTROTRANSFERENCIA: TcxGridDBColumn
          DataBinding.FieldName = 'REGISTROTRANSFERENCIA'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
        end
      end
      object grdDuplicNivel: TcxGridLevel
        GridView = grdDuplicDados
      end
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 771
    Width = 1363
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 4
    object FlwBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 1262
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 103
        Height = 21
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 103
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object BtnMarcarTodas: TBitBtnLocked
        Left = 222
        Top = 0
        Width = 105
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 2
        OnClick = BtnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 327
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 3
        OnClick = btnDesmarcarTodasClick
      end
      object btnConcilia: TBitBtnLocked
        Left = 447
        Top = 0
        Width = 95
        Height = 21
        Caption = '[ F9 ] Concilia'#231#227'o'
        TabOrder = 4
        OnClick = btnConciliaClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 542
        Top = 0
        Width = 90
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 5
        OnClick = btnConfirmaClick
      end
      object btnMovimentoCartoes: TBitBtnLocked
        Left = 632
        Top = 0
        Width = 137
        Height = 21
        Caption = '[ F11 ] Movimento Cart'#245'es'
        TabOrder = 6
        OnClick = btnMovimentoCartoesClick
      end
      object btnAjuVal: TBitBtnLocked
        Left = 769
        Top = 0
        Width = 104
        Height = 21
        Caption = '[ F2 ] Ajustar Valor'
        TabOrder = 7
        Visible = False
        OnClick = btnAjuValClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 873
        Top = 0
        Width = 80
        Height = 21
        Caption = '[F3] Relat'#243'rio'
        TabOrder = 8
        Visible = False
        OnClick = btnRelatorioClick
      end
      object btnPreviaCartoesConc: TBitBtnLocked
        Left = 953
        Top = 0
        Width = 138
        Height = 21
        Caption = 'Pr'#233'via Cart'#245'es Conciliados'
        TabOrder = 9
        Visible = False
        OnClick = btnPreviaCartoesConcClick
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 1091
        Top = 0
        Width = 142
        Height = 21
        Align = alLeft
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
        TabOrder = 10
        OnClick = btnConfigurarGridClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 1264
      Top = 2
      Width = 97
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 304
  end
  object imgSitCad: TImageList
    Left = 644
    Top = 204
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFEFF7FFFF0000
      FFFFC7E3C1FF0000FFFF83C1C0FF0000FFFFC183C07F0000FFFFE007803F0000
      FFFFF00F801F0000FFFFF81F800F0000FFFFF81F04070000FFFFF00F06030000
      FFFFE0078F000000FFFFC183FFC00000FFFF83C1FFE00000FFFFC7E3FFF10000
      FFFFEFF7FFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object dtsPreviaCartoesConc: TDataSource
    Left = 810
    Top = 88
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 880
    Top = 88
  end
  object frxDBPreviaCartoesConc: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxDBPreviaCartoesConc'
    CloseDataSource = False
    DataSource = dtsPreviaCartoesConc
    BCDToCurrency = False
    Left = 982
    Top = 88
  end
  object frxPreviaCartoesConc: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44392.665772627300000000
    ReportOptions.LastChange = 44397.656919838000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MDataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  picNot.Visible := (<frxDBPreviaCartoesConc."SIT_CAD"> = '#39'INCOM' +
        'PLETO'#39');'
      
        '  picYes.Visible := (<frxDBPreviaCartoesConc."SIT_CAD"> = '#39'COMPL' +
        'ETO'#39');  '
      'end;'
      ''
      'procedure rllTipoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxDBPreviaCartoesConc."MCA_AJUSTE"> = '#39'S'#39') Then'
      
        '    rllTipo.Text := '#39'AJUSTES'#39';                                  ' +
        '               '
      'end;'
      ''
      'procedure rllQtdeGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  rllQtdeGeral.Text :=  IntToStr(MData.Dataset.RecordCount);'
      'end;'
      ''
      
        'begin                                                           ' +
        '                      '
      'end.')
    OnUserFunction = frxPreviaCartoesConcUserFunction
    Left = 1106
    Top = 88
    Datasets = <
      item
        DataSet = frxDBPreviaCartoesConc
        DataSetName = 'frxDBPreviaCartoesConc'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 71.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 965.745580000000000000
          Top = 0.425170000000000000
          Width = 81.184230000000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 869.217010000000000000
          Top = 12.747990000000000000
          Width = 177.712800000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [(<Date>)]  [fTime(False)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 327.194095000000000000
          Top = 14.059060000000000000
          Width = 392.541620000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PR'#201'VIA CART'#213'ES CONCILIADOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 279.194095000000000000
          Top = 32.133890000000000000
          Width = 488.541620000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMCONC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Align = baCenter
          Left = 279.194095000000000000
          Top = 51.133890000000000000
          Width = 488.541620000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MData: TfrxMasterData
        FillType = ftBrush
        Height = 19.007874020000000000
        Top = 219.212740000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MDataOnBeforePrint'
        DataSet = frxDBPreviaCartoesConc
        DataSetName = 'frxDBPreviaCartoesConc'
        RowCount = 0
        object picYes: TfrxPictureView
          Left = 1025.007874020000000000
          Top = 0.000002439999999992
          Width = 18.897650000000000000
          Height = 15.118110240000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000017352474200AECE1CE90000000467414D
            410000B18F0BFC610500000021744558745469746C65004170706C793B4F4B3B
            436865636B3B426172733B526962626F6E3B6463C868000003B94944415478DA
            4D937B4C5B6518C69FEF9C53E8053014C6A5086D296C15C836C025B21960B08E
            6E0B863054E296691C0E916D2A892673CE7889B745438C269B71C16C13D8A213
            50373618A8B89BAE021B75A38C94B620B7AEE3D296D2D39E733C0763E29B3CF9
            FE78DFEF79BEE4FBBD64DCDB0E391D8B55CA2202807AA9D158A88A6676474492
            3C46466921084E8E139CFE05AEA5B1FE4EBB3813F604AEF12CBF008E5F0699F2
            5D4472949954BEAA4F48D1CB4F6A9253CA1E5DB31929F106AC8A4985C73F8999
            393B6ED9FB3039EBB4B86C4BBB5B3EB48FCE2EFDCCB1DC3CA454B2639F36519B
            A5EA2BCCDD9AB929D784003F0E96F380E5E72167E21049C74349A5C162EBC595
            C10B6ED7886F4BEBC776AB6BF11C2F19307B3F30766C2FAED89E634CC754E026
            684A000D1928428110718408F0DCF7429F588089C93974F4360FB57DEED8F8F7
            A8DF4F2A1BD2CB1EC9D25FDC55518909EF55D034038AA257C4403A81CE4BB761
            B14C4293A6C06B35AFE0C79EF3B8757BF8E0E977EF1D23D56F647E5BFD446555
            54921B21CE27A6D32B22623A4D11B49CF91D0F519BB16FE711D41FCDC5810366
            28B80C34B77F73BDE9B0AD943C75C830FAE2734F1ABC64044E871B6D6D166CC8
            5F8D921223BABBEF40C56D455DD511BCDFF42CD6E6ABA03510C43019F8AAF96C
            B0E9D0703CA97ADDB058B3B7347A9E75E0CB2FAEE268FD757CD7731C96D1566C
            CA7E1E2F54BE85335DEF8065ACD85090043FFB00710A2D9A4E5DC6CDCE590DA9
            68D08D555567EB187910B34E15860704BC597B0A03238330EAD621C08EE1F0F1
            72D4D59AE00B4F83E70550BC12DF9FB5065BDEBB9740CAF7EB2F14953DBC2D4E
            138652AE86AD7F19F0ADC6FE671A45AC085EFEE4716C31E91119EB41980F4174
            C0825B86DE4E47FFB94FC70A49C99ED43D1939B1271F2B8D4690F343AD48C18D
            BE19E4687622439785AFBB1B60DE968E40784134E0446A55F8F38A1777073D6F
            5F3AE1FA48E240B9A35E772D7763CCBAD44C998867086A651A7EEAB0626CC281
            5D4F9B4047DF87200143684C393958FAE6AD3DA7278A7D0F427392019D6F4E58
            ABC98CBABC667DA43A3D3B62059C0495118A0835A6BD430886FDA0C56F758C04
            611B580E3A86164DFD5DEE1BBFB90E86C8AFCE3A14698FC9F2CC09EB93F4CA56
            75226348CF91213E598488261078C033CDC17137849971F6AF69FB52DD4097FB
            0F319815EF0AE417470D8A7527565E12A596C5E49525D6CA5574B92C922A8054
            62271CE48796FDFC0F96F3D39FF91742F3D2468AF78495B664F05F894622B8E2
            12FC2B465A6F51D22027254A12E779FCAFFE016E74869FCF650ED90000000049
            454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo17: TfrxMemoView
          Left = 2.952733940000000000
          Width = 81.259840080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_NUMCCD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 87.047310000000000000
          Width = 96.377960080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_NUMNSU"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 185.535560000000000000
          Width = 22.677165350000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_CODEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 211.669450000000000000
          Width = 22.677165350000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_EMPRCX"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 237.803340000000000000
          Width = 58.582660080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_DTAVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 299.614410000000000000
          Width = 58.582674720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_DTACAD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 360.748300000000000000
          Width = 62.362190080000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_VALTOT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 425.000310000000000000
          Width = 62.362190080000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_VALSTA"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 491.338900000000000000
          Width = 160.629970080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."MCA_NUMNOT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 653.858690000000000000
          Width = 20.787360080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."PARDUP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object picNot: TfrxPictureView
          Left = 1025.032160000000000000
          Width = 18.897650000000000000
          Height = 18.141732283464600000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000017352474200AECE1CE90000000467414D
            410000B18F0BFC610500000023744558745469746C650043616E63656C3B5374
            6F703B457869743B426172733B526962626F6E3B4C9696B2000003B349444154
            78DA1D936D50545518C7FFE7DEBDF772F785DD651728165840C3A2124644370D
            D360740AA9709C62AA69B4102B89AC71AAE94B9FFCC44CF9C68C9642E38C0E4E
            E208CC34161896689A4D4CA2622EB8ECB240E4C2DD5DD897BBF7DEBDDDBBE7CC
            9C73E6799EFF739EF33BE790A5A11F00DA004253306F7A951EF9604F45AEC9D8
            CAD074AD81A29E81D6E474FA4E5292AFF9C3E1EF5EEA3A7D4733294B43E75555
            5140B4052CF53B896634DC6EFFF080C562FECA545AC831395618EC56E80E4988
            22254490F005C590103EB8B6F34487664E457F3A97D6FDA4DDB3DEB4776DF545
            8B2BAFCEBE6E35D2620CAA98423A9504542D806141580E346F44F8AF718403B3
            BF7D3978F9B5817F1E44323BFFD9F2DE514749C1FB396B9E84EF971BB8D57B05
            C5552B51DD549B4930DA3782A9512F6A9A36A164CB7A84C71EE2DF497F8FE754
            F76E727147534D597EFEEFAEBA75B4FFEA1F181B5F846BFF6708F55F4076E036
            082188143D0B676313660E77E0E9553694D5D6207875347DCBFBF04532B4BDF1
            78E973957B4D0E13060E9E46DDE521589C7608910446BF39A63344E5276DB05A
            38C4162218AEAFC7F6CFDF427C218E0737FEEE2583DB5E9E70975857D01C8549
            DF326CCF6F46C5476DD0A863211CCF1CC16E33228BA171FF5827849161AC28E2
            A14880DF1F0D904B9BB7A6DCF92A9316E360AC764C0613B06D7D0565ADAD9A58
            85AA53D2584F7E7B02D1C17E94BA38C8421860594C2FB212E9F3BC9072DB120C
            4D1150061ABED924988666ACD6AA50F5AE2501288C1D390AF9C773703FC64295
            958C7D2A6A92C8D92ACFD413398A9B35A808CE2791DCB213E5FBF6C16EE5C167
            D1D04B8825658D491CDECE4EF0C3E7E1CA6321C92ABC02374B8E975775AFCCE5
            76393911777D716CBB7E1D49030F234763BAFB640662E1AE162D89045E11F1F3
            C60DA828CE8220B1B8F748EA23070ACA6A2BADD62B4F39242AC59A9170ADC2C6
            435FE3DEC92E3CBAD0A3BF33E4EE7803152DEFE2DAFE4FC107EF83139731BEC8
            E0A6106ED011F11DAEF22EB7D9D05C5EC0200116C19928EC7623F21D9CAEC77C
            488420C45158900D1E2226E6244C44E5FE2FE6BC6FEB09A80ACEE8D86D7DFC92
            CB4CAD29776581CB366BCF5882BC1C837E8FB4C90483465D8C2EC33B97C4D492
            32762632DF3026C666C9F4C76FA2E8F059BA9A35E735F2F6430ED6F0BACB46E0
            3451E01992F94C0949452896C64C58C57F923CD01B0BB5DD9512B381F6669968
            430654F1911E4A9B8CEF189D1B0A29768F91A23C0C48A15E81A69F89A9E99B01
            45FCFE4C62E1572D2EA6E9145DF73F2B91898E5FE860A30000000049454E44AE
            426082}
          Stretched = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 679.874460000000000000
          Width = 77.480310080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."BAN_NOMBAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 759.906000000000000000
          Width = 258.897750080000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBPreviaCartoesConc."CARTAO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 26.677180000000000000
        Top = 464.882190000000000000
        Width = 1046.929810000000000000
        object Line4: TfrxLineView
          Top = 22.897650000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 97.708720000000000000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        object Line3: TfrxLineView
          Left = -3.779530000000000000
          Top = 91.708720000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line1: TfrxLineView
          Top = 3.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 100.535433070866100000
          Top = 71.189005670000000000
          Width = 71.811023622047240000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VRLIQUIDO]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 100.535433070866100000
          Top = 27.834645670000000000
          Width = 71.811023622047240000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VRSEMTAXA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 7.661410000000000000
          Top = 27.456705120000000000
          Width = 88.818914720000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor sem Taxa:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdeGeral: TfrxMemoView
          Left = 100.535433070866100000
          Top = 7.881880000000000000
          Width = 71.811023622047240000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllQtdeGeralOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[QUANTIDADE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 7.574830000000000000
          Top = 7.559055120000000000
          Width = 88.818900080000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 100.535433070866100000
          Top = 49.133858270000000000
          Width = 71.811023622047240000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VRAJUSTES]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 7.559060000000000000
          Top = 49.133885120000000000
          Width = 88.818914720000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Ajustes:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 7.559060000000000000
          Top = 71.031535120000000000
          Width = 88.818900080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 151.181200000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBPreviaCartoesConc."MCA_AJUSTE"'
        object Memo13: TfrxMemoView
          Top = 26.456710000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTipo: TfrxMemoView
          Left = 1.000000000000000000
          Top = 2.755905510000000000
          Width = 137.952790080000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CART'#213'ES DE CR'#201'DITO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.023622050000000000
          Top = 30.236240000000000000
          Width = 81.259840080000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'm. Libera'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 88.488250000000000000
          Top = 30.236240000000000000
          Width = 85.039362760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'm. NSU')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 182.417440000000000000
          Top = 30.236240000000000000
          Width = 24.566882760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Fat.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 209.874150000000000000
          Top = 30.236240000000000000
          Width = 24.566882760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Ori.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 238.110390000000000000
          Top = 30.236240000000000000
          Width = 58.582652760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencto.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 298.582870000000000000
          Top = 30.236240000000000000
          Width = 58.582652760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 359.055350000000000000
          Top = 30.236240000000000000
          Width = 58.582652760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 419.527830000000000000
          Top = 30.236240000000000000
          Width = 62.362204720000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. s/ Taxa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 491.338900000000000000
          Top = 30.236240000000000000
          Width = 160.629962760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'm. Nota')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 651.858690000000000000
          Top = 30.236240000000000000
          Width = 24.566882760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Par.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 679.535870000000000000
          Top = 30.236240000000000000
          Width = 73.700794720000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bandeira')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 755.906000000000000000
          Top = 30.236240000000000000
          Width = 73.700794720000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cart'#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 1020.473100000000000000
          Top = 30.236240000000000000
          Width = 24.566882760000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Sit.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 260.787570000000000000
        Width = 1046.929810000000000000
        object Memo31: TfrxMemoView
          Left = 359.055350000000000000
          Top = 0.755905510000000000
          Width = 62.362190080000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBPreviaCartoesConc."MCA_VALTOT">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 424.307360000000000000
          Top = 0.755905510000000000
          Width = 62.362190080000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBPreviaCartoesConc."MCA_VALSTA">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 304.141930000000000000
          Top = 0.755905510000000000
          Width = 51.023600080000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 139.299320000000000000
          Top = 2.000000000000000000
          Width = 156.850440080000000000
          Height = 15.118095590000000000
          OnBeforePrint = 'rllTipoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade: ( [COUNT(MData)] )')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
end
