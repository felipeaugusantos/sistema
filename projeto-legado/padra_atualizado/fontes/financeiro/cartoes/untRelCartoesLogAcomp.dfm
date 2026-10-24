inherited frmRelCartoesLogAcomp: TfrmRelCartoesLogAcomp
  Width = 806
  Height = 578
  Caption = 'Relat'#243'rio de Log de Acompanhamento de Cart'#245'es'
  ExplicitWidth = 806
  ExplicitHeight = 578
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 505
    Width = 800
    ExplicitTop = 505
    ExplicitWidth = 800
    object lblCampoAlterados2: TLabel [0]
      Left = 165
      Top = 6
      Width = 87
      Height = 14
      Caption = 'Campos alterados'
      Color = clBtnFace
      ParentColor = False
      Visible = False
    end
    object Shp_inferior: TShape [1]
      Left = 134
      Top = 6
      Width = 25
      Height = 14
      Brush.Color = 8417535
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 127
      Align = alLeft
      ExplicitWidth = 127
      object btnGeraCSV: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 115
        Height = 24
        Align = alBottom
        Caption = 'Gerar Arquivo CSV'
        TabOrder = 0
        OnClick = btnGeraCSVClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 721
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 721
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 800
    ExplicitTop = 533
    ExplicitWidth = 800
    inherited pnlNomeForm: TPanel
      Left = 629
      ExplicitLeft = 629
    end
    inherited pnlInfo: TPanel
      Width = 629
      ExplicitWidth = 629
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 800
    Height = 206
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      800
      206)
    object Label11: TLabel
      Left = 18
      Top = 12
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label12: TLabel
      Left = 40
      Top = 83
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 30
      Top = 107
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 21
      Top = 136
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 182
      Top = 136
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 21
      Top = 160
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 181
      Top = 160
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 338
      Top = 136
      Width = 64
      Height = 14
      Caption = '( Cadastro )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 338
      Top = 160
      Width = 80
      Height = 14
      Caption = '( Vencimento )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 312
      Top = 12
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Libera'#231#227'o N'#186':'
    end
    object Label6: TLabel
      Left = 339
      Top = 36
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' NSU:'
    end
    object Label10: TLabel
      Left = 40
      Top = 60
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label13: TLabel
      Left = 175
      Top = 12
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object Label14: TLabel
      Left = 8
      Top = 36
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor s/ Taxa:'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 80
      Top = 103
      Width = 62
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
      TabOrder = 9
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
      Left = 144
      Top = 103
      Width = 457
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
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 80
      Top = 79
      Width = 62
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 7
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 144
      Top = 79
      Width = 457
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
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumCCD: TEditFocus
      Tag = 99
      Left = 384
      Top = 7
      Width = 217
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumNSU: TEditFocus
      Tag = 99
      Left = 384
      Top = 31
      Width = 217
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCar: TEditFocus
      Tag = 99
      Left = 80
      Top = 55
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnExit = edtCodCarExit
      OnKeyPress = edtCodCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesCar: TEditFocus
      Left = 144
      Top = 55
      Width = 457
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
    object edtParcel: TEditFocus
      Tag = 99
      Left = 217
      Top = 7
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 80
      Top = 7
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumDupExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object btnConfirmar: TBitBtnLocked
      Left = 649
      Top = 135
      Width = 111
      Height = 22
      Align = alCustom
      Caption = '&Confirmar'
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
      OnClick = btnConfirmarClick
    end
    object edtValSta: TEditFocus
      Tag = 99
      Left = 80
      Top = 31
      Width = 90
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
      EditFormat = '##,#0.00'
    end
    object GroupBox1: TGroupBox
      Left = 638
      Top = 7
      Width = 151
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'Legenda de cores'
      TabOrder = 17
      object Shape1: TShape
        Left = 16
        Top = 24
        Width = 25
        Height = 14
        Brush.Color = 8417535
      end
      object Label15: TLabel
        Left = 47
        Top = 24
        Width = 87
        Height = 14
        Caption = 'Campos alterados'
      end
    end
    object mskDtaIniCad: TcxDateEdit
      Tag = 99
      Left = 80
      Top = 132
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
      TabOrder = 11
      Width = 90
    end
    object mskDtaIniVen: TcxDateEdit
      Tag = 99
      Left = 80
      Top = 158
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
      TabOrder = 13
      Width = 90
    end
    object mskDtaFinVen: TcxDateEdit
      Tag = 99
      Left = 241
      Top = 158
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
      TabOrder = 14
      Width = 90
    end
    object mskDtaFinCad: TcxDateEdit
      Tag = 99
      Left = 241
      Top = 132
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
      TabOrder = 12
      Width = 90
    end
    object gpbRegcomAlteracao: TGroupBox
      Left = 425
      Top = 128
      Width = 218
      Height = 73
      Caption = 'Somente Registros com Altera'#231#227'o'
      TabOrder = 15
      object Label16: TLabel
        Left = 6
        Top = 33
        Width = 54
        Height = 14
        Caption = 'Informa'#231#227'o'
      end
      object chkRegComAlteracao: TCheckBox
        Left = 6
        Top = 16
        Width = 206
        Height = 17
        Caption = 'Mostrar somente registros c/ altera'#231#227'o'
        TabOrder = 0
        OnClick = chkRegComAlteracaoClick
      end
      object cmbInfRegAlterado: TComboBox
        Left = 6
        Top = 47
        Width = 205
        Height = 22
        TabOrder = 1
        Items.Strings = (
          'Data de Vencimento'
          'Portador'
          'Valor Documento'
          'Num. NSU'
          'Cart'#227'o')
      end
    end
  end
  object dbgConsulta: TcxGrid [3]
    Left = 0
    Top = 206
    Width = 800
    Height = 299
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgConsultaDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgConsultaDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para adicionar um filtro'
      FilterRow.SeparatorColor = clActiveBorder
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OnCustomDrawGroupCell = dbgConsultaDBTableView1CustomDrawGroupCell
      object dbgConsultaDBTableView1MCA_DTALOG: TcxGridDBColumn
        Caption = 'Data Log.'
        DataBinding.FieldName = 'MCA_DTALOG'
        Width = 60
      end
      object dbgConsultaDBTableView1MCA_HORLOG: TcxGridDBColumn
        Caption = 'Hora Log.'
        DataBinding.FieldName = 'MCA_HORLOG'
        Width = 67
      end
      object dbgConsultaDBTableView1MCA_OPELOG: TcxGridDBColumn
        Caption = 'Oper. Log.'
        DataBinding.FieldName = 'MCA_OPELOG'
        Width = 53
      end
      object dbgConsultaDBTableView1MCA_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Log.'
        DataBinding.FieldName = 'MCA_DESCRI'
        Width = 239
      end
      object dbgConsultaDBTableView1MCA_DTACAD: TcxGridDBColumn
        Caption = 'Data Cadastro'
        DataBinding.FieldName = 'MCA_DTACAD'
        Width = 91
      end
      object dbgConsultaDBTableView1MCA_DTAVEN: TcxGridDBColumn
        Caption = 'Data Vencimento'
        DataBinding.FieldName = 'MCA_DTAVEN'
        Width = 95
      end
      object dbgConsultaDBTableView1MCA_DTACUP: TcxGridDBColumn
        Caption = 'Data Transa'#231#227'o'
        DataBinding.FieldName = 'MCA_DTACUP'
        Width = 93
      end
      object dbgConsultaDBTableView1MCA_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'MCA_CODEMP'
        Width = 50
      end
      object dbgConsultaDBTableView1MCA_CODOPE: TcxGridDBColumn
        Caption = 'Oper. Doc.'
        DataBinding.FieldName = 'MCA_CODOPE'
        Width = 72
      end
      object dbgConsultaDBTableView1DUPLICATA: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'DUPLICATA'
        Visible = False
        GroupIndex = 0
        SortIndex = 0
        SortOrder = soAscending
      end
      object dbgConsultaDBTableView1MCA_DESCAR: TcxGridDBColumn
        Caption = 'Cart'#227'o'
        DataBinding.FieldName = 'CAR_DESCAR'
        Width = 164
      end
      object dbgConsultaDBTableView1MCA_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'MCA_NUMDUP'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_PARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'MCA_PARCEL'
        Width = 62
      end
      object dbgConsultaDBTableView1MCA_NUMCCD: TcxGridDBColumn
        Caption = 'Libera'#231#227'o'
        DataBinding.FieldName = 'MCA_NUMCCD'
        Width = 115
      end
      object dbgConsultaDBTableView1MCA_NUMNSU: TcxGridDBColumn
        Caption = 'Num. NSU'
        DataBinding.FieldName = 'MCA_NUMNSU'
        Width = 141
      end
      object dbgConsultaDBTableView1MCA_NOMFRM: TcxGridDBColumn
        Caption = 'Formul'#225'rio'
        DataBinding.FieldName = 'MCA_NOMFRM'
        Width = 153
      end
      object dbgConsultaDBTableView1MCA_VALORI: TcxGridDBColumn
        Caption = 'Vr. Original'
        DataBinding.FieldName = 'MCA_VALORI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_VALDUP: TcxGridDBColumn
        Caption = 'Vr. Dup.'
        DataBinding.FieldName = 'MCA_VALDUP'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico 1'
        DataBinding.FieldName = 'MCA_HIST01'
        Width = 166
      end
      object dbgConsultaDBTableView1MCA_HIST02: TcxGridDBColumn
        Caption = 'Hist'#243'rico 2'
        DataBinding.FieldName = 'MCA_HIST02'
        Width = 169
      end
      object dbgConsultaDBTableView1MCA_CONPAG: TcxGridDBColumn
        Caption = 'Cond. Pag.'
        DataBinding.FieldName = 'MCA_CONPAG'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_DTAREC: TcxGridDBColumn
        Caption = 'Data Receb.'
        DataBinding.FieldName = 'MCA_DTAREC'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_VALREC: TcxGridDBColumn
        Caption = 'Val. Receb.'
        DataBinding.FieldName = 'MCA_VALREC'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_DTABAI: TcxGridDBColumn
        Caption = 'Data Baixa'
        DataBinding.FieldName = 'MCA_DTABAI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_OPEBAI: TcxGridDBColumn
        Caption = 'Oper. Bai.'
        DataBinding.FieldName = 'MCA_OPEBAI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_HISBAI: TcxGridDBColumn
        Caption = 'Hist. Bai.'
        DataBinding.FieldName = 'MCA_HISBAI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_PORBAI: TcxGridDBColumn
        Caption = 'Port. Bai.'
        DataBinding.FieldName = 'MCA_PORBAI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_CTABAI: TcxGridDBColumn
        Caption = 'Cta. Bai.'
        DataBinding.FieldName = 'MCA_CTABAI'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_DOCBAN: TcxGridDBColumn
        Caption = 'Doc. Ban.'
        DataBinding.FieldName = 'MCA_DOCBAN'
      end
      object dbgConsultaDBTableView1MCA_PERCAR: TcxGridDBColumn
        Caption = 'Tx. Adm.'
        DataBinding.FieldName = 'MCA_PERCAR'
      end
      object dbgConsultaDBTableView1MCA_VALSTA: TcxGridDBColumn
        Caption = 'Vl. s/ Taxa'
        DataBinding.FieldName = 'MCA_VALSTA'
      end
      object dbgConsultaDBTableView1MCA_VALTAX: TcxGridDBColumn
        Caption = 'Val. Tax.'
        DataBinding.FieldName = 'MCA_VALTAX'
      end
      object dbgConsultaDBTableView1MCA_DOCUME: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'MCA_DOCUME'
      end
      object dbgConsultaDBTableView1MCA_TIPCAR: TcxGridDBColumn
        Caption = 'Tip Car'
        DataBinding.FieldName = 'MCA_TIPCAR'
        Width = 100
      end
      object dbgConsultaDBTableView1MCA_DTATRA: TcxGridDBColumn
        Caption = 'Data Transf.'
        DataBinding.FieldName = 'MCA_DTATRA'
        Width = 94
      end
      object dbgConsultaDBTableView1MCA_SEQTRF: TcxGridDBColumn
        Caption = 'Seq. Trf.'
        DataBinding.FieldName = 'MCA_SEQTRF'
      end
      object dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn
        DataBinding.FieldName = 'Alteracoes'
        Visible = False
      end
      object dbgConsultaDBTableView1MCA_NOMEXE: TcxGridDBColumn
        Caption = 'Nome EXE'
        DataBinding.FieldName = 'MCA_NOMEXE'
        Width = 130
      end
      object dbgConsultaDBTableView1MCA_DTAEXE: TcxGridDBColumn
        Caption = 'Data EXE'
        DataBinding.FieldName = 'MCA_DTAEXE'
        Width = 65
      end
      object dbgConsultaDBTableView1MCA_HOREXE: TcxGridDBColumn
        Caption = 'Hora EXE'
        DataBinding.FieldName = 'MCA_HOREXE'
      end
      object dbgConsultaDBTableView1MCA_VEREXE: TcxGridDBColumn
        Caption = 'Vers'#227'o EXE'
        DataBinding.FieldName = 'MCA_VEREXE'
        Width = 95
      end
    end
    object dbgConsultaLevel1: TcxGridLevel
      GridView = dbgConsultaDBTableView1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 64
  end
end
