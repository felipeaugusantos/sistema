inherited frmTransfCheqEmpresa: TfrmTransfCheqEmpresa
  Left = 313
  Top = 166
  Width = 800
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Transfer'#234'ncia de Cheques entre Empresas'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 794
    Height = 1
    ExplicitTop = 483
    ExplicitWidth = 794
    ExplicitHeight = 1
    DesignSize = (
      794
      1)
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 675
      Top = -23
      Width = 111
      ExplicitLeft = 675
      ExplicitTop = -23
      ExplicitWidth = 111
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 794
    ExplicitTop = 512
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 647
      Width = 147
      ExplicitLeft = 647
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 647
      ExplicitWidth = 647
    end
  end
  inherited pgcDados: TPageControl
    Left = 433
    Top = 82
    Width = 361
    Height = 401
    Visible = False
    ExplicitLeft = 433
    ExplicitTop = 82
    ExplicitWidth = 361
    ExplicitHeight = 401
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 353
      ExplicitHeight = 369
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 82
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 256
      Top = 58
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 389
      Top = 59
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label6: TLabel
      Left = 59
      Top = 58
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem:'
    end
    object ColorLabel1: TColorLabel
      Left = 127
      Top = 58
      Width = 120
      Height = 14
      Caption = '(C)adastro (V)encimento'
      CorDestaque = clRed
    end
    object Label20: TLabel
      Left = 12
      Top = 11
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Origem:'
    end
    object Label21: TLabel
      Left = 10
      Top = 34
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
    end
    object edtOrdem: TEditFocus
      Tag = 99
      Left = 96
      Top = 52
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 4
      Text = 'C'
      OnExit = edtOrdemExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtNomEmpOri: TEditFocus
      Left = 144
      Top = 5
      Width = 343
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpOri: TEditFocus
      Tag = 99
      Left = 97
      Top = 5
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpDest: TEditFocus
      Left = 144
      Top = 28
      Width = 343
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
    object edtCodEmpDest: TEditFocus
      Tag = 99
      Left = 96
      Top = 28
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpDestKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 296
      Top = 53
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
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 397
      Top = 53
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
    object btnCarrCheques: TBitBtnLocked
      Left = 493
      Top = 55
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
      TabOrder = 7
      OnClick = btnCarrChequesClick
    end
  end
  object pnlAux1: TPanel [4]
    Left = 433
    Top = 82
    Width = 361
    Height = 401
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object pnlDadosCheque: TPanel
      Left = 0
      Top = 0
      Width = 361
      Height = 313
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label5: TLabel
        Left = 40
        Top = 41
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object Nome: TLabel
        Left = 44
        Top = 64
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label7: TLabel
        Left = 31
        Top = 86
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
      end
      object Label10: TLabel
        Left = 7
        Top = 107
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cta. Corrente:'
      end
      object Label12: TLabel
        Left = 11
        Top = 130
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheque:'
      end
      object Label14: TLabel
        Left = 31
        Top = 152
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Emitente:'
      end
      object Label1: TLabel
        Left = 25
        Top = 174
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object Label8: TLabel
        Left = 30
        Top = 196
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
      end
      object Label13: TLabel
        Left = 26
        Top = 218
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Nota:'
      end
      object Label18: TLabel
        Left = 15
        Top = 240
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vencimento:'
      end
      object Label22: TLabel
        Left = 46
        Top = 262
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object edtBanco: TEditFocus
        Left = 76
        Top = 35
        Width = 269
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
      object edtNome: TEditFocus
        Left = 76
        Top = 57
        Width = 269
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
      object edtAgencia: TEditFocus
        Left = 76
        Top = 79
        Width = 269
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
      object edtCtaCorrente: TEditFocus
        Left = 76
        Top = 101
        Width = 269
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
      object edtNroCheque: TEditFocus
        Left = 76
        Top = 123
        Width = 269
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
      object edtEmitente: TEditFocus
        Left = 76
        Top = 145
        Width = 269
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
      object edtEndereco: TEditFocus
        Left = 76
        Top = 167
        Width = 269
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
      object edtTelefone: TEditFocus
        Left = 76
        Top = 189
        Width = 269
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
      object edtNroNota: TEditFocus
        Left = 76
        Top = 211
        Width = 269
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
      object edtVencimento: TEditFocus
        Left = 76
        Top = 233
        Width = 269
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
      object edtValor: TEditFocus
        Left = 76
        Top = 255
        Width = 269
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
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 313
      Width = 361
      Height = 88
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label16: TLabel
        Left = 192
        Top = 2
        Width = 165
        Height = 12
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 190
        Top = 43
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheques:'
      end
      object Label19: TLabel
        Left = 206
        Top = 65
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label26: TLabel
        Left = 6
        Top = 6
        Width = 175
        Height = 12
        Alignment = taCenter
        AutoSize = False
        Caption = 'EXIBIDOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 10
        Top = 43
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheques:'
      end
      object Label23: TLabel
        Left = 54
        Top = 65
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object edtChqSelecionados: TEditFocus
        Left = 262
        Top = 36
        Width = 83
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
      object edtTotalSelecionado: TEditFocus
        Left = 262
        Top = 59
        Width = 83
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
      object edtTotalCheques: TEditFocus
        Left = 83
        Top = 36
        Width = 83
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
      object edtValorTotal: TEditFocus
        Left = 83
        Top = 59
        Width = 83
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
  end
  object pnlAux2: TPanel [5]
    Left = 0
    Top = 82
    Width = 433
    Height = 401
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    object Panel1: TPanel
      Left = 0
      Top = 384
      Width = 433
      Height = 17
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lblIndices: TLabel
        Left = 136
        Top = 17
        Width = 174
        Height = 14
        Caption = '[ F3 ] - Muda a Ordem dos Registros'
      end
      object lstIndices: TListBox
        Left = 9
        Top = 19
        Width = 121
        Height = 80
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
      end
    end
    object dbgCheques: TcxGrid
      Left = 0
      Top = 0
      Width = 433
      Height = 384
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgChequesDBTableView1: TcxGridDBTableView
        OnDblClick = dbgChequesDBTableView1DblClick
        OnKeyDown = dbgChequesDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgChequesDBTableView1CustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsData.Editing = False
        OptionsSelection.CellSelect = False
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Content = cxStyle1
        Styles.Header = cxStyle2
        Styles.Indicator = cxStyle2
        object dbgChequesDBTableView1CHQ_NUMCHQ: TcxGridDBColumn
          Caption = 'Nro. Cheque'
          DataBinding.FieldName = 'CHQ_NUMCHQ'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Styles.Content = cxStyle3
          Width = 71
        end
        object dbgChequesDBTableView1CHQ_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CHQ_CODEMP'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Styles.Content = cxStyle4
          Width = 41
        end
        object dbgChequesDBTableView1CHQ_DTACAD: TcxGridDBColumn
          Caption = 'Dta. Cad.'
          DataBinding.FieldName = 'CHQ_DTACAD'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Styles.Content = cxStyle5
          Width = 73
        end
        object dbgChequesDBTableView1CHQ_DTAVEN: TcxGridDBColumn
          Caption = 'Dta. Ven'
          DataBinding.FieldName = 'CHQ_DTAVEN'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Styles.Content = cxStyle6
          Width = 68
        end
        object dbgChequesDBTableView1CHQ_DTATRF: TcxGridDBColumn
          Caption = 'Transf.'
          DataBinding.FieldName = 'CHQ_DTATRF'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Styles.Content = cxStyle7
          Width = 63
        end
        object dbgChequesDBTableView1CHQ_VALCHQ: TcxGridDBColumn
          Caption = 'Valor Cheque'
          DataBinding.FieldName = 'CHQ_VALCHQ'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Styles.Content = cxStyle8
          Width = 82
        end
      end
      object dbgChequesLevel1: TcxGridLevel
        GridView = dbgChequesDBTableView1
      end
    end
  end
  object pnlBotoesTransf: TPanel [6]
    Left = 0
    Top = 484
    Width = 794
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 6
    DesignSize = (
      794
      28)
    object FlwPnlBotoesTransf: TFlowPanel
      Left = 2
      Top = 4
      Width = 790
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 21
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
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnDesmTodos: TBitBtnLocked
        Left = 363
        Top = 0
        Width = 121
        Height = 21
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 3
        OnClick = btnDesmTodosClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 484
        Top = 0
        Width = 121
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 4
        OnClick = btnConfirmaClick
      end
    end
    object btnSairTransf: TBitBtnLocked
      Left = 679
      Top = 4
      Width = 111
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairTransfClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 48
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      TextColor = clBlack
    end
  end
  object frxTransfChequeEmpresa: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45126.445761875000000000
    ReportOptions.LastChange = 45126.445761875000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 528
    Top = 8
    Datasets = <
      item
        DataSet = frxDBCheques
        DataSetName = 'frxDBCheques'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 136.063080000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 84.897650000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA ORIGEM.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 100.574830000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA DESTINO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baWidth
          Left = 124.724490000000000000
          Top = 85.456710000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESAORIGEM]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baWidth
          Left = 124.724490000000000000
          Top = 100.913420000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESADESTINO]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Align = baRight
          Left = 677.367410000000000000
          Top = 69.692950000000000000
          Width = 40.743290000000000000
          Height = 13.228344020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Align = baRight
          Left = 518.551640000000000000
          Top = 69.692950000000000000
          Width = 158.815770000000000000
          Height = 13.228344020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Align = baRight
          Left = 628.233520000000000000
          Top = 54.692950000000000000
          Width = 89.877180000000000000
          Height = 13.228344020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [PAGE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 22.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE CHEQUES TRANSFERIDOS ENTRE EMPRESAS')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        object Memo6: TfrxMemoView
          Align = baWidth
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baWidth
          Left = 41.574830000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baWidth
          Left = 90.708720000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Cta. Corrente')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baWidth
          Left = 166.299320000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#176' Cheque')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baWidth
          Left = 230.551330000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baWidth
          Left = 279.685220000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          Memo.UTF8W = (
            'Emitente')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baWidth
          Left = 404.409710000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baWidth
          Left = 480.000310000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Nr NF')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          Left = 563.149970000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haCenter
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baWidth
          Left = 638.740570000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
      end
      object MasterDataTransfChequeEmpresa: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 257.008040000000000000
        Width = 718.110700000000000000
        DataSet = frxDBCheques
        DataSetName = 'frxDBCheques'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODBCO'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_CODBCO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 41.574830000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_NUMAGE"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 90.708720000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CONCOR'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_CONCOR"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 166.299320000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_NUMCHQ"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 230.551330000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODCLI'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_CODCLI"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 279.685220000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NOMEMI'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_NOMEMI"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 404.409710000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_TELEMI'
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_TELEMI"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 480.000310000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_NUMNOT"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 563.149970000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_DTACAD"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCheques
          DataSetName = 'frxDBCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCheques."CHQ_VALCHQ"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 5.559060000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Geral')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 22.677180000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo29: TfrxMemoView
          Align = baRight
          Left = 642.520148820000000000
          Top = 5.669291340000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBCheques."CHQ_VALCHQ">,MasterDataTransfChequeEmpresa)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baRight
          Left = 548.031898820000000000
          Top = 5.669291340000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cheque(s) [COUNT(MasterDataTransfChequeEmpresa)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Align = baRight
          Left = 279.685220000000000000
          Top = 26.456710000000000000
          Width = 438.425480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterDataTransfChequeEmpresa)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Top = 26.456710000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmTransfCheqEmpresa')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDBCheques: TfrxDBDataset
    UserName = 'frxDBCheques'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 616
  end
end
