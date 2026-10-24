inherited frmAlteraBoletoApi: TfrmAlteraBoletoApi
  Left = 185
  Top = 150
  Width = 797
  Height = 409
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Restaura'#231#227'o de Remessa Banc'#225'ria - Contas a Receber'
  Position = poMainFormCenter
  ExplicitWidth = 797
  ExplicitHeight = 409
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 367
    Width = 797
    TabOrder = 5
    ExplicitTop = 367
    ExplicitWidth = 797
    DesignSize = (
      797
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 793
      ExplicitWidth = 793
    end
  end
  inherited pnlStatus: TPanel
    Top = 393
    Width = 797
    TabOrder = 3
    ExplicitTop = 393
    ExplicitWidth = 797
    inherited pnlNomeForm: TPanel
      Left = 626
      ExplicitLeft = 626
    end
    inherited pnlInfo: TPanel
      Width = 626
      ExplicitWidth = 626
    end
  end
  inherited pgcDados: TPageControl
    Left = 793
    Top = 369
    Width = 4
    Height = 6
    Align = alRight
    TabOrder = 1
    TabStop = False
    ExplicitLeft = 793
    ExplicitTop = 369
    ExplicitWidth = 4
    ExplicitHeight = 6
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 22
    Width = 797
    Height = 107
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 27
      Top = 35
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 23
      Top = 58
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 158
      Top = 58
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label4: TLabel
      Left = 18
      Top = 12
      Width = 44
      Height = 14
      Caption = 'Portador:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 64
      Top = 31
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 1
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
      Left = 138
      Top = 31
      Width = 478
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 64
      Top = 54
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
      Properties.OnValidate = mskDtaIniPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 168
      Top = 54
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
      Properties.OnValidate = mskDtaIniPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      Width = 90
    end
    object btnConsultar: TBitBtnLocked
      Left = 510
      Top = 54
      Width = 106
      Height = 22
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
      TabOrder = 7
      OnClick = btnConsultarClick
    end
    object rbtDtaVen: TRadioButton
      Left = 391
      Top = 58
      Width = 113
      Height = 17
      Caption = 'Data de Vencimento'
      TabOrder = 5
    end
    object rbtDtaEnv: TRadioButton
      Left = 280
      Top = 58
      Width = 102
      Height = 17
      Caption = 'Data de Registro'
      Checked = True
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
      TabStop = True
    end
    object edtDesPortador: TEditFocus
      Left = 138
      Top = 8
      Width = 478
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 64
      Top = 8
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object grpLegendaCancelamento: TGroupBox
      Left = 647
      Top = 23
      Width = 121
      Height = 52
      Margins.Left = 800
      Caption = 'Legenda'
      TabOrder = 10
      object Shape6: TShape
        Left = 8
        Top = 16
        Width = 14
        Height = 14
      end
      object Label11: TLabel
        Left = 27
        Top = 16
        Width = 48
        Height = 14
        Caption = 'Marcados'
      end
      object Shape7: TShape
        Left = 8
        Top = 32
        Width = 14
        Height = 14
      end
      object Label12: TLabel
        Left = 28
        Top = 30
        Width = 67
        Height = 14
        Caption = 'Desmarcados'
      end
      object Label13: TLabel
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
      object Label14: TLabel
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
    end
    object pnlAlteracoes: TPanel
      Left = 1
      Top = 79
      Width = 506
      Height = 26
      BevelOuter = bvNone
      TabOrder = 6
      Visible = False
      object lblAlteracoes: TLabel
        Left = 4
        Top = 2
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Altera'#231#245'es:'
      end
      object chkcbAlteracoes: TcxCheckComboBox
        Left = 62
        Top = -1
        Properties.EmptySelectionText = 'Todas'
        Properties.EditValueFormat = cvfCaptions
        Properties.Items = <
          item
            Description = 'Vencimento'
          end
          item
            Description = 'Endere'#231'o do Pagador'
          end
          item
            Description = 'Prazo para recebimento de boleto vencido'
          end>
        Properties.OnEditValueChanged = chkcbAlteracoesPropertiesEditValueChanged
        Style.BorderStyle = ebsUltraFlat
        Style.Color = clWindow
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.ScrollbarMode = sbmClassic
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.ScrollbarMode = sbmClassic
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.ScrollbarMode = sbmClassic
        StyleHot.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.ScrollbarMode = sbmClassic
        TabOrder = 0
        Width = 440
      end
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 367
    Width = 797
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 2
    object FlwpnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 736
      Height = 22
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnMarcarTodas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Align = alLeft
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 0
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 22
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnAjuda: TBitBtnLocked
        Left = 375
        Top = 0
        Width = 27
        Height = 22
        Align = alLeft
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          499191480000000000000000000000009AECEB91000000000000000000000000
          E309F49A00000000000000000000000049E3A349000000000000000000000000
          00000000000000000000000000000000009A9949000000000000000000000000
          00A309E2480000000000000000000000009AEC09E29100000000000000005191
          49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
          EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
          A3EC09EC9A000000000000000000000000000000000000000000}
        Spacing = 2
        TabOrder = 3
        TabStop = False
        OnClick = btnAjudaClick
      end
    end
    object btnSairRotina: TBitBtnLocked
      Left = 670
      Top = 2
      Width = 125
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairRotinaClick
    end
  end
  object pnlAux2: TPanel [5]
    Left = 0
    Top = 129
    Width = 797
    Height = 232
    Align = alTop
    TabOrder = 4
    object dbgDuplicatas: TcxGrid
      Left = 1
      Top = 1
      Width = 795
      Height = 230
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = dbgDuplicatasDBTableView1CellDblClick
        OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
        DataController.DataSource = dtsCtaRec
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object dbgDuplicatasDBTableViewCTR_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'DUPLICATA'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 107
        end
        object dbgDuplicatasDBTableViewCTR_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CTR_CODEMP'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 49
        end
        object dbgDuplicatasDBTableViewCTR_CODCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          OnGetCellHint = dbgDuplicatasDBTableViewCTR_CODCLIGetCellHint
          Options.AutoWidthSizable = False
          Width = 199
        end
        object dbgDuplicatasDBTableViewCTR_CODPOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'CTR_CODPOR'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.AutoWidthSizable = False
          Width = 72
        end
        object dbgDuplicatasDBTableViewCTR_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTR_DTAVEN'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Options.AutoWidthSizable = False
          Width = 67
        end
        object dbgDuplicatasDBTableViewCTR_NOSNUM: TcxGridDBColumn
          Caption = 'Nosso N'#250'mero'
          DataBinding.FieldName = 'CTR_NOSNUM'
          HeaderAlignmentHorz = taCenter
          Options.AutoWidthSizable = False
          Width = 77
        end
        object dbgDuplicatasDBTableViewCTR_DTAENV: TcxGridDBColumn
          Caption = 'Data Registro'
          DataBinding.FieldName = 'CTR_DTAENV'
          PropertiesClassName = 'TcxDateEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 73
        end
        object dbgDuplicatasDBTableViewCTR_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MARDES'
          Visible = False
        end
        object dbgDuplicatasDBTableViewCTR_VALDUP: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CTR_VALDUP'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 107
        end
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasDBTableView1
      end
    end
  end
  object pnlLinhaSepara: TPanel [6]
    Left = 0
    Top = 361
    Width = 797
    Height = 8
    Align = alTop
    TabOrder = 6
  end
  object pnlTopo: TPanel [7]
    Left = 0
    Top = 0
    Width = 797
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Altera'#231#227'o de boleto registrados'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Font.Quality = fqClearType
    ParentBackground = False
    ParentFont = False
    TabOrder = 7
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 24
  end
  object dtsCtaRec: TDataSource
    Left = 744
    Top = 24
  end
  object frxAjuda: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44449.346708321800000000
    ReportOptions.LastChange = 45078.466467395800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 760
    Top = 80
    Datasets = <>
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
      object rlbBancoDoBrasil: TfrxChild
        FillType = ftBrush
        Height = 322.598640000000000000
        Top = 64.252010000000000000
        Width = 718.110700000000000000
        Child = frxAjuda.rlbBancoItau
        PrintChildIfInvisible = True
        object memBancoBrasilTexto01: TfrxMemoView
          Align = baLeft
          Top = 110.440940000000000000
          Width = 714.331170000000000000
          Height = 49.133890000000000000
          Memo.UTF8W = (
            
              ' 1.1 - O boleto s'#243' poder'#225' ser cancelado pela carteira de registr' +
              'o.'
            
              ' 1.2 - O boleto s'#243' poder'#225' ser cancelado ap'#243's 30 minutos de seu r' +
              'egistro.'
            
              ' 1.3 - Ao cancelar um boleto com PIX vinculado o PIX tamb'#233'm ser'#225 +
              ' cancelado.')
        end
        object memBancoBrasilItens: TfrxMemoView
          Align = baLeft
          Top = 90.984230000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '1) Regras para cancelamento de boleto.')
          ParentFont = False
        end
        object imgBancoBrasil: TfrxPictureView
          Left = 3.779530000000000000
          Top = 15.984230000000000000
          Width = 60.472480000000000000
          Height = 60.472480000000000000
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003B00
            00003B0803000000F2FB02810000001974455874536F6674776172650041646F
            626520496D616765526561647971C9653C0000032369545874584D4C3A636F6D
            2E61646F62652E786D7000000000003C3F787061636B657420626567696E3D22
            EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B6339
            64223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E
            733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F7265
            20352E352D633031342037392E3135313438312C20323031332F30332F31332D
            31323A30393A31352020202020202020223E203C7264663A52444620786D6C6E
            733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F3032
            2F32322D7264662D73796E7461782D6E7323223E203C7264663A446573637269
            7074696F6E207264663A61626F75743D222220786D6C6E733A786D703D226874
            74703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D6C6E
            733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F786170
            2F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E73
            2E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F757263
            65526566232220786D703A43726561746F72546F6F6C3D2241646F6265205068
            6F746F73686F7020434320284D6163696E746F7368292220786D704D4D3A496E
            7374616E636549443D22786D702E6969643A4634354136373739343033343131
            4534413831334241463738434143394134392220786D704D4D3A446F63756D65
            6E7449443D22786D702E6469643A463435413637374134303334313145344138
            3133424146373843414339413439223E203C786D704D4D3A4465726976656446
            726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4634
            3541363737373430333431314534413831334241463738434143394134392220
            73745265663A646F63756D656E7449443D22786D702E6469643A463435413637
            3738343033343131453441383133424146373843414339413439222F3E203C2F
            7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A
            786D706D6574613E203C3F787061636B657420656E643D2272223F3E0A5D5041
            0000019E504C5445FFED00225198F4E10A668169FCEB02325C8DB0B536EADE0E
            4E707AD9D21A275594335D8C2F5A8F25539694A249EDE00DE8DC10748B5FACB2
            39B5B933FEEC01F9E904F1E30A627E6C3B63876B8466365F8A235297F6E70647
            6B7EEFE10BFBEA03CAC8245978728C9C4F245297F3E4082D5990C2C22ADFD616
            2A57934B6E7C396189829556D5D01DF5E607285594E2D914708862D3CE1EDCD0
            1B5E7B6F416783CECB21909F4CD2CD1F567674A2AC40F8E805BABC303E6585BD
            BF2DBEBF2DE5DB122C5891A7AF3CECE00D527377879853FDEC01859754C7C527
            88995267826892A04B798E5C7B905BDCD518C3C3299EA8434469819AA546738B
            60BBBD2FF2E4094D707AD5CF1D2E5A909BA745809358D7D11B65806AA3AC3F64
            7F6B6883687D91592956933D648642688237608A305B8EA9B03BAEB4373F6584
            B4B834718962EBDF0E4A6D7DA6AE3DD0CC209FA94269836766816A839655637F
            6BB4B833537377E8DD0FA5AD3E768C5EC8C626879952A8B03CCFCB21DAD31A5F
            7C6EC9C725DED6177E9259325D8D6E8764ADB339BCBE2E809457A7AF3DE3D913
            6F8763C4C329F6FC5B7E000003D34944415478DADD977B4853511CC7CFB5B5D5
            9A6DDAA6A6A6E623B31A3E22A2CC8C220BA4FA23F10F097B89905011456F7A90
            1111141495BD280A422C89B2A2942C33ED8F509309BE4D6369BA695A7373365D
            F7EE9C73EFB98F6DB0FEAADF3FF79C73EFE77ECF7EAF734751C067A3A8E4CFBE
            91490D14454DFAC6FA39FF3B56B3BDBE4A623932F1995736707C3476D52DD172
            B6A16DC20BAB510C309720FB306F59E76FB2F8796169513898211F229697F61A
            69CC238B44A1E53CB613A2C00BCB8A429351E3AEEBB1FB46E862F7AC42834455
            163620E995006CF9D80567217DEE58B9D3010759CFE7C89AD1A272DA20084F2B
            863F68EA8034AB70A0B92AA1BF0704FD66BD1C621D01E72FF583D931D5702B22
            96150DD736B8AE85D7FAB074520D085AD135F41548B2AC68745C9D09AD450436
            E2DB899893605951B0C3F89A7B6AD698158D662F2B9566D5CB5F119BCF6CE980
            03BD01A8B75D66033F754082E5DE0E2D78661B7349FDB2A6C44EEC2841FB5EC8
            AA95DF8561DEDAD840FBE6094C0D36E6001C2CEDE0B15126AB10551C28042BCD
            30BEEB6B47885C0B56B7926CE4C277361E395D6675C40EE2E032B13DFA083900
            6528F17BA73BEDA4286503F37EF6A387771611C5B1EFAA5DE42B99D2612345E3
            5FA2D9DEEBB4AF72EFC0095791FCF862E9F9539AC0BAD07BDCC36A0B7E86E804
            82DC9029A30CAE3CD66F3E8D96523A87B9E8F1DA80289F37587B69D113953570
            9A9E71D11C517084788F0716C8C27AC2D5C3BD701235B311A475A25A880D3798
            81479606B47570101F5F63E66A30452568B76276B9B21989EE2F6BE5C2C488AE
            1EABF5C82E097B0A07FA9832873EF205DE0BBD79B933F3DB27F7AC6E717B1797
            1B873F608FD9DBCDAECA8E9EDB6274C3BA7A2F63AAB47207DF63B88E169BBBA5
            58D47B692BA86A024BF47791C702DACDEA4D0F3011AA19318AD845132D4854F7
            CBA4CB2B419B5FFAA35550D9589AABA3E066249A2FBF0272AA8D384CD60A5165
            2369964DEE43C1703918D78158143AF2D069DE9EB3DEB0F9C6104C60F50B062B
            C0C6B71601C91499D057B847D03BCD784827548AB28CE77C2C4AD92462449C01
            4C58D8A0B3FE2744C5B9C1E63D485F54CC257E729343282A66C93380CB7DCDEE
            4291A880D5C6CDAB37D0ED184B6757C0423F737E542CCA67CFDDEC06A9C66E10
            917712DF0DCABDC09D507C5192D5EA8D4C070D5D68A925222AA3FCF79C921425
            D9B3C7D1CADA72A93342244AB253E0CE70331324935854CCFAC9707F2FB831E9
            5194647715715F33D0D8934F529464038641C8909D770F7AD88D288F1DA7BF63
            8496FF70D49D28C9EEBF3D22715B937FD101BCB23ED8BFCAFECDFF23DF48C6FE
            002D79E586A80F8EA50000000049454E44AE426082}
          Stretched = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object memBancoBrasilTitulo: TfrxMemoView
          Left = 83.149660000000000000
          Top = 35.086580000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco do Brasil')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 184.299320000000000000
          Width = 714.331170000000000000
          Height = 128.504020000000000000
          Memo.UTF8W = (
            
              ' 2.1 - O boleto s'#243' poder'#225' ser alterado pela carteira de registro' +
              '.'
            
              ' 2.2 - O boleto s'#243' poder'#225' ser alterado ap'#243's 30 minutos de seu re' +
              'gistro.'
            
              ' 2.3 - As altera'#231#245'es devem acontecer em suas respectivas rotinas' +
              ' antes de executar essa, aqui vamos apenas comunicar ao banco os' +
              ' dados alterados para que la sejam atualizados tamb'#233'm.'
            
              ' 2.4 - At'#233' o momento o sistema comunica a altera'#231#227'o de venciment' +
              'o, endere'#231'o do pagador e o prazo para recebimento de boleto venc' +
              'ido.'
            
              ' 2.5 - Ao comunicar a altera'#231#227'o de vencimento de um boleto com P' +
              'IX vinculado o vencimento do PIX tamb'#233'm ser'#225' alterado.')
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 162.842610000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '2) Regras para altera'#231#227'o de boleto.')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxAjuda.rlbBancoDoBrasil
      end
      object rlbBancoItau: TfrxChild
        FillType = ftBrush
        Height = 192.000000000000000000
        Top = 408.189240000000000000
        Width = 718.110700000000000000
        Child = frxAjuda.rlbBancoSicredi
        object imgItau: TfrxPictureView
          Left = 4.000000000000000000
          Top = 8.000000000000000000
          Width = 60.472480000000000000
          Height = 60.472480000000000000
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000006500
            00006408020000001042693D000000017352474200AECE1CE90000000467414D
            410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000
            02964944415478DAEDDD3D6E13411887F131B941244A2A421A2E40418D9428A9
            68423A247A240E408128E8F2D1117181F47C49D454E9124A38011227402C8658
            F17A7766F7FDCF2CAC9DF779BAD8B393D99F23AFA5AC3C93AAAA82A1C9F69165
            D88A56BD7F6A1C39E9F6BADE4CED7AE1925EDEA4EA75A845BC3C4BD58BAA35BD
            C0AAD7265BF002AB5D836CEE0556AA3A195EFD45BCC0EAEE8A0C2F530B5E6059
            BA24C3CB1A5E5A33AFB07538F64A56A629195E427869E1A58597165E5A7869E1
            A58597165E5A7869E1A58597165E5A7869E1A58597165E5A7869E1A58597165E
            5A7869E1A58597165E5A7869E1A58597165E5A7869E1A58597165E5A7869E1A5
            8597569757F5E645F4F1C993E78583472FBA5ACB523D7A656305875E2558012F
            7585BEBC0AB1822BAF72ACE0D92B6F618EBC06A9D42B3526558ACF324F2F7DC6
            B54F7D99C7F71A4ADC85977A78F7F9E095ECFEABC79FBFDEC22B7F2A175EF519
            9E9D3E38F874CFBE8C60D35F2EAFEC5F5C3F30EFC2E7D4CB98C5022FBCB25C52
            F9F5CABB506E1DEE7FFCB2E1CBEBE7C9CBB51BBF32B0A6ED1EEFBD3DDF74E455
            F2F9CB9D97116BEFF5C3D3B3BBD1C178258FCAF6DA3EDAFF70B11112AD8CD720
            E32D5E21EB35C30BAF622FE90D61602F75FCFFF40AE637C4A5F0BA3AE4F6CD1F
            DFBEAF674C9E1A6CF76ACCDC7B691ED9AB7DACF16FA17BCE8697710D9696CE6B
            90735B6D2FCB72FFB5973AED743DD2A7DC31BDECE7B673FCE8DDF99DF6E0A897
            7DDACBC58CE9D5BBDC8CFFA775BCE5A5BC0AA7CDF42A4CBA5FA1F036A341D660
            9A90FB31A5F0D2C24BEB8F17DF876C8CEF8FD6C24B6BEE15D82FA02FF657D06A
            7A05C8D2B13F8C56DC2B40162BB95FD3EC67C86AF5EC07367B08B2BF99F69B9B
            3FE1584DDBCF70E169676AF9FB6536C75D6B38FB7EACBF013EB688667AC25FC2
            0000000049454E44AE426082}
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object memItauTitulo: TfrxMemoView
          Left = 83.370130000000000000
          Top = 23.118120000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ita'#250)
          ParentFont = False
        end
        object memJornadaItau01: TfrxMemoView
          Align = baLeft
          Top = 112.740260000000000000
          Width = 714.331170000000000000
          Height = 63.874150000000000000
          Memo.UTF8W = (
            
              ' 1.1 - O boleto s'#243' poder'#225' ser cancelado pela carteira de registr' +
              'o.'
            
              ' 1.2 - O boleto s'#243' poder'#225' ser cancelado no dia seguinte ap'#243's seu' +
              ' registro.'
            
              ' 1.3 - Ao cancelar um boleto com PIX vinculado, a cobran'#231'a PIX t' +
              'amb'#233'm ser'#225' cancelada.')
        end
        object memBancoItaulItens01: TfrxMemoView
          Align = baLeft
          Top = 88.000000000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '1) Regras para cancelamento de boleto.')
          ParentFont = False
        end
      end
      object rlbBancoSicredi: TfrxChild
        FillType = ftBrush
        Height = 388.535560000000000000
        Top = 623.622450000000000000
        Width = 718.110700000000000000
        object Picture1: TfrxPictureView
          Left = 4.000000000000000000
          Top = 8.000000000000000000
          Width = 64.252010000000000000
          Height = 68.031540000000000000
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D49484452000001C200
            0001C20802000000F37A5E12000000FE69434350696363000028916360609260
            000216030686DCBC92A22077278588C82805062490985C5CC0801B3032307CBB
            062219182EEBE251870B70A6A4162703E90F405C5204B41C68640A902D920E61
            5780D84910760F885D1412E40C642F00B235D291D84948ECF292821220FB0448
            7D724111887D07C8B6C9CD294D46B89B8127352F3418484700B10C4331431083
            3B8313197EC00B10E199BF8881C1E22B0303F3048458D24C0686EDAD0C0C12B7
            10622A403FF0B730306C3B5F9058940816620162A6B43406864FCB1918782319
            18842F3030704563DA81880B1C7E5500FBD59D211F08D31972185281229E0C79
            0CC90C7A4096118301832183190092A540B345DE25D200000006624B474400FF
            00FF00FFA0BDA7930000001F7A5458745261772070726F66696C652074797065
            20696363000078DA530000002100218EB4E7A40000A37D4944415478DAECBD77
            9C5D4596E77922E2BA67D267CA7B8410208B249C248CA4020A5350B882A228CA
            B7A9ED9EDECFCEEECCEC67773F9FDDED3F7A7776BA7B7AFAD33D3DDD35555D05
            554D551750080A8F70124E12F220EF3395FEE5B3D7466C44DCF75EBE4CA544CA
            8148CE17914A65BE77DFBD71E3FEE29C13274E10210420088220670B41194510
            0439175046110441CE099451044190730265144110E49C401945100439275046
            110441CE890B25A3D5C312423EEF6B441004F93462C53A2BB93A2719E5D52F0A
            5A391951F343A0271D7EA8B0A2C82208F2D9439450112555658D8ABF52F9137E
            F2ABE9298FA37E738E323AC2E7C532AA0E4BD46F99FC6FE48B3895809EA9B09E
            E9F9E3F1F1F878FC2FCFF14F7D1C410765B46A8A12CE477AF5F995D1113EA3E6
            03B812D0A1322A6A64B4F6544EF5B9671A0438D361008F8FC7C7E37F798E5F4B
            AC5D15A3531EC7A060947F4462A3909F4A30CFA38CF29AEFCADF8BF2373C8210
            D41FF94DA4C5348C5F4FE2131DD6765A6DF94803113DC3D1869FE16886C7C7E3
            E3F1BF3CC71FFA5931528929034B4A9309B61628A5515AC1E4F1E9881F705EAD
            51297E7E148AD0B08D50788C921022175C02512F7487508AC077C322E72EC8DF
            10755A04ECF893F8C91F3EFCF2F4277CC1473F3C3E1E1F8F7FF11CBFF68D42CA
            27A58C3103EC0434A4A1290109228C3AD2E84BFB4F707932A692D71138CFB1D1
            C00D4CC70CC1F395687A52373BDCE3BB8FEF3AD2B72F5BEAF7FC826051A994D5
            1AAAAD516289D39CC34970C147FF627511E40C0E8EC7C7E3E3F1BF54C7AF222A
            EAA88414CC3AD6DC563771E6845953DBA68D4B4C71A08E494905C352323AC229
            9DA38CF261070939E73492029A87DEA3FEC19D0736EF69DF950D7A4BBCCF4A30
            29F67EE419D25856C7E6BA99D8195DF7C5369AE1F1F1F878FC2FEEF1AB703278
            04890986B40889476C915C306DF1953396CE6A989F807A07EAA5BF3FE413F5CC
            D3F99051790A3A621001F7C1F5205F8281757B5EFA68DF072EC998F5C2839C60
            41207D7960B25DD431058DE55F35D32926BFA07272E8D4E3F1F1F878FC0B71FC
            93DECEC328E211B71DC3310D4330F099DF4FEA49CBDC290B572DB86B1C4C3721
            CDD4EC93B4FF44EC4993380F6A643E5D46A5FC71F5AA804740986914A11041F1
            38EC5BBBF15F8FF4EE258E8898CF695150E5C2D7EA7D8D7C9FA5118E200872C1
            8827C0A55A51873A7E290C5D989C9875DFB5DF9D6A5F6687F549A35ECDEDE897
            1021CD433885948D4A4643F52A6958123300BF04B976D8FD2FEB7ED22D0E8B54
            28C5554F25F9DADE1C347B871E13651441908B17CE2366189669857D741ABBFC
            BEE5DF69A3D3EAD9383D83AFF235CF5E462B59545CBBF4C4E52541490F1C7D72
            E37F3F94DDC653A580045450F98709A5DA1181A1D668CD911004412E56082551
            189A96052503FACCCB9A173DB8F27B4D30D18206A2E3A44CD9A467E5D4D7CAA8
            FCE342310FD967B7FEE6A3CEB74443C127456A0A1E1025A35C39FE28A308827C
            1109A330E138BEEF1BC20297248A0D4B26DF7CDBE2FBEA611C8324E1D25A344E
            FDEE51C9A8FA140EC100F47E32B0FD99F54F7AA98C6FE63973B93CBC3E04135C
            4DCA8B91E7B284883EEF56421004F974941D1846A69B6CF0A6DC75FD37E7355D
            6D8A94416C4379F7A79AAB3F9D8CF29A754AA107450F069EDCFCD3BDFD3B5C3B
            1B31570543098FF4125422F43416CA2882205F68949A713374C840DD65CD573D
            78DD0FEAA09509C726CEA9DFF3E9321A2FDB0F5DC81E2A7EF2B337FF2EA8CB78
            342FA8CF38952E7C44D5ECBC51C9898ACF63D88104C77AA608827C01202A0C2A
            4C610B376197DABE79E31F5E965A6840D204EBECF24607653402B7087D2F7DF2
            CC86A3AF86A95C484B404225A3206554E926D5395128A308827CA1D1324A4C6A
            F3D0F27BD9AACBBE7EF39CDBEBA0CD81149CCADD1E8D534F55BE7DBE13F6FDEC
            F5BFEF880E868E2BB5BA3A6B24744E3E3DED2412CA2882205F10A8FAA304935A
            7E7A1A9DFDD0CAEF37C38C3A682E67D08FFC964F9B62D2329ADD0F9B7FB5EE1F
            BBC589D00ED48C52C5E4ACAC40E070EA002CCA2882205F10A4935D9E94B783E4
            783EF9A11BBF3F092E4F43AB38A5C48D5A46B715DE7AE6BDC733ACCFB73CA1E2
            A1A791D1939D7AAC6F8F20C81702CA638314C0F19D06AFF5FE95DFBDC4599A82
            260AECAC655439EC2E643EEC7FE5858DBFCED919CF705146110419AB70A29C7A
            2AA815388942FDD7577CEBCABA15496831D42AFB1119858C82B246331F65D7AD
            FDF05739B31F65144190318C962BCA38954EBD994BDC75DDC38B9A6FAE83F1E7
            648DCABF3DE8DF927D23965197953E2D368A328A20C817159582A456661A76E0
            B082FDB56B1F5EDCB4A641C9283D45747414322A2092D6A894D1673FF865C11E
            28D122CA288220631312BBDAD40C2D337468D1BC5BCA68A394D189E72AA325E8
            DB9A7BEBB9F7B58CB27CED8EC965191D922B8A328A20C817939364F4AE6B1F5E
            D2B8AA0926C359CBA80011296BB47F5BFEED67DE7BDCB5B32EC9AA8A5127E7D8
            7FDE978F200872AE0C955128DA775FFB8D658DABA4350AA75C563F3A19F5A06F
            7BFE9DD3CB28A0922208F245A7464659A464F49E6B1FBEBAE1A67395D150043E
            C948197DFADD5FF809B57708CA28822063132DA35450C2CBD6A894D16B1A6EAE
            8709E72AA32EC9EC28BCF3CC0694510441C638AA448880AA8C7EED9A87AE6B5C
            759632AA7FC823353FC44BD087328A20C897818A8C1A6A8AA994BCF3EA6F5CDF
            B8BA0EC601D8A7D91EF4F4321A4919F5A07F5BE1ED67363C2165D4150384115D
            DDE9A4B77CDED78F2008724E0C3AF56519BD63D903CB9BBE727E6534EB8A1CCA
            2882206393F214133029A341B222A3B7A4A18D9C27198D9DFA1C3AF508828C4D
            6A6534B646977EE342C9A820B84B1D8220638E8A8C522DA3AC94BC7DD9032B1A
            6F3B6B198DE411E55779503796D1F54F04897C810C8041D0F0441064ECC12917
            F1E6725A46899BBC73A99451698D8E3F7F329ACC16A4358A328A20C858249651
            504E3D3583642CA3D76B1965E728A325E8DB5E780765144190B1CD7996515D61
            840B88E2F4FBB28C26F245181026CA288220639041198D069DFA73915128CB28
            0F4AB47F4761FD33EB7FA16534270C9C624210640C72416454FE09212C40CFCE
            C20694510441C636651955659BE9F997D11D524631E1094190310D2730181B0D
            93C4752A32DAA665D438D51B4F29A342448488AA8C3EF5EE2FBC64BE24729411
            0094510441C61A3532AA9DFA52F2CE65F79D67192DA5948C1A146514419031C8
            0592518820CC4337CA288220639E8A8C5662A317C01A7DA294CAA28C22083256
            39FF323A6C8A49C96852D51B45194510644C5223A3B153EF0C95D133AF7EAFF2
            4685AA7E5FA47D65A71E65144190B1CB0594D112EDDF5E588F328A20C8D846CB
            28D438F5E74946390F0AAC776BE9EDA7373CE126718A09419031CB059051F963
            114542CA68F716F74D698DFA8EEBF102E68D22083226B9B032BAD97FEDA90D4F
            84B694D112CA28822063920B23A384731EE66927CA288220639E6132CA8ACE1D
            CBEEBBAEE97CC8688E9EF8C87F1D65144190B1CD0590512E808A5A19E5B6EB46
            2562A08C2208320689139E88A0541823C9E859A4DF57647480766CF5D7A18C22
            0832E651BBC70F91D1073ECD1A559C5E46A5671F66A01D651441902F03B5326A
            149DDB2F888CF20251B15104419031C83019BD73E903D735DF923C7B1955534C
            F2AF7000DA377B6AA69E5BAE2B0AD4A03062D96671CACF401004F94250915155
            B6B92AA367B94FBD02651441902F194364B4A02A3CA18C2208829C0128A30882
            20E7C43019BD6BC903D7B7AE49A28C2208828C9658DC84A5A698CA327A8B9651
            13651441106414546534481AC5AA8CB6686BF4D46F3A6DF57BA98C7E3FB46FF1
            D63DB5E117A1EDBBBC60A08C22083256A99151AB90BC63695546CFCE1AD539F6
            3CB646FDD79EDEF044A4D3EF5146110419B37C76328A20083226215C5B848694
            51A754F7D5ABEEBDA6754D226A325902651441106414D4C8A8994FDCBEE4FE6B
            C6AD71BC46C74E9F8D8C72E0547DD5B1517FDDD31B7E113A2A366AD253963941
            1004F962734A6BF4AC0AE5A18C2208F2A5A34646EBA396DB97DC774DDD1A1B1A
            75DED2596D6907E8D42308F2A52296519D372AADD1FB573EBA3871832D1A2831
            504611044146C1A08C2AA7FEFE158F2E4EDE60F3067A4A2FFCD365544410E6E0
            C426FF5594510441C63E28A3088220E7C4F99651F9738E328A20C897881A19B5
            8B6925A3A99576D4C098758A37A08C220882D4720164340A212C40D746FF1594
            510441C63E17404605177E8E74E90A4F35A549100441C624E75B46259CF3B040
            BB367AAF0C29948720083226399D8C9ECD9A7A18414679899A1437584610646C
            52937E5F23A34D28A3088220A3A3663128CA288220C8995395D1D81A5DFE18CA
            288220C8995096513A181B4DDE88328A2008326A0665348E8D3E86328A200872
            260C9751698DDE8C328A2008326AD01A451004391FD4CAE8CD98378A20087246
            9CCAA93F2528A3088220B5A08C2208829C1328A3088220E704CA288220C83981
            328A2008724E5C1819DDE4BEF2DB7751461104F9325023A36A4DFD8DE72AA382
            8745DAF5A1ABAADF8736CA288220639B3839B4564657D9513DCA288220C828B9
            2032EA6B197D4DCAA8EF2819D59B88A08C2208325639FF4E7D55467FE1275CB5
            17133300411064CC72BEA798CA325A5AF7F4BBFFEC27B35A461DBD741F411064
            4C72616534A3653489328A20C898E6BC952651FBD4EB29A69EB28C26B225C899
            14AD510441C628E7BB50DEA08C6E2ABEF9DB777F21ADD1922898F474C62D8220
            C817980B26A37D1BF3EB5EDCF2DB01D65B12398392CFFB421104412E28E7D3A9
            17B18C6ECAAD7B61CBD3034677454631E1094190B1CAF99C62AA95D137958C4A
            6B14060C2A5046110419BB5C1019CD6CCABEF9C2562DA362C06011CA28822063
            97F329A35CFE4A4441C118D89A7BE7F75B9FCAB05E5764190D5046110419BBA0
            8C2208829C1328A3088220E704CA288220C839713E4B932819E53C2832945104
            41BE249CE742794364F4852D4F0D18BD4594510441C63228A3088220E700578B
            342988B28C3EB8FCB185D2A9E74DA75F048F328A20085266988CDEBFF2D1C589
            9B5146110441460BCA288220C839C1CB95976A4A9328196DD0327A36A5495046
            1104F972C129173AE1C9081DA7987E60F9638B12373A656B1465144110E4D318
            26A32AFDDEB9196514411064B40C97D1E5D2A9476B14411064D40CCA68902C5B
            A328A3088220A30765144110E49C38EF32AACA36731E9674D9E617B73C9D31B0
            6C3382206399B28C0AA332C5F4D8E2C44A9451044190D15223A3556B14651441
            1064D4A08C2208829C13C364F481E58F2E4AA28C2208828C1A29A320A48C5A35
            D5EF57DA28A3088220A30465144110E49CA8C8A8618649945104419033A64646
            2B159E5046110441464F5946819A41B2526FF4469451044190D13228A383F546
            514611044146CD49325A5BFD1E65144110E4D31826A30F2E7F74611265144110
            64F490939CFAE48D76D4A437584619451004F9540665B49AF084328A2008327A
            5046110441CE89F32DA358B61941902F196519ADA4DF2F7F6C716A25CA288220
            C8A8A9CA6850B1465146110441CE009451044190730265144110E49C202715CA
            431945100439035046110441CE0974EA110441CE89CF2EE1898423BC5C9CF233
            100441BE187C76E9F728A308828C49CE77691294510441BE649093EA8D266F46
            19451004193528A3088220E7C249659B1F5B983CA74D4450461104F97271DEB7
            B443194510E4CB05CA288220C839811B2C2308829C13651915464DC2D34A9451
            044190D15223A3D5F47B94510441905183328A2008724EA08C2208829C135246
            05A8427946E838C5F403CB1F5D945CE9A08C2208828C926132AAACD104CA2882
            20C8A8A9C8A861844994D1B381A88BA682C4FF1A9BD78820C869A891D1D81A7D
            EC82C9E81733FD5E058F874239D54DA0CF9C70FD4FCA096825E5F165F2585585
            111F43BD4C7C31AE17419033A52CA3408DA06A8DDE88323AA48146FC79594C2B
            DF7042D50AAEB29256DE2268FC7394510419C30CCA686C8D2E7F0C6574B06946
            BE42AD925C29236591412A2F2FB757F58AD4CBB4B08A5867078F400520083266
            182EA3D21A756E46192D37CDC8575823A3841B521389D250F54FEDC51BF145D1
            AA830F06D78629D7C20A28A30832B61826A30F2C7F6C115AA3C31A68D84F7CDF
            3718330D9B322ABF579A282555B62031283720320567945B525B29C84BE65246
            A94D0B3CE74725CB323EEF0B4210E43C53F1356B361149DC6CF30694D14A03D5
            C82821449A9C945322BFCA338F18894C429841280356E734B4D4B524EC741430
            8B25D5CB882F0F10091230EF40F7C785A8DFA5AE18B11D1004F9C2A265543AA3
            151955159E6EAEAC623A255F221985B2926A679C1B4CFF31B929BF5A61DDE553
            963527C6B7344C684C35A5CC7403D431305C0818A4E4CB59D91A2511783BB2EB
            DFDBFBFA91E25EDF2C8ED4A27C14AD11FF1673AA10E4E202657474CD446319A5
            66644DAC9B32293D7D46DBEC89E99913C96C03D2046C0A0653BAC90C357B6F72
            88DB555D6104A2007DDDD1FE3777ADDDD2FB6EC9C9C6871CDAA26A4D2EA9B4E0
            B09F57FD0222CA3FC4E02A825C3C9C77193D75D9E62FB21915C73E28702B48CE
            6EB8E2DEF9DF9E009708B04CB0D49C929A4452894D547D5573F7D5E611447008
            33C5AEFE627BBF79ECA5BDBF39EE1FE6464465134643C69572EE14E1443616F7
            DD20B06DBB9C00C02D1543209C713D73051052545204B95840191D6533C52A29
            65D41947A62C997AD38DD3BE5607E362F583782EBE7C81B10DAABFE8154E052F
            DB97E9F0794EB4782F7CFCE4FEFCAE1C1F102CB229ADDE0335DDAFE2AD527FE5
            41A4E91E5293461089D84AADC8A8B4460D81328A20171728A36706937EBD6FA7
            BCA61BE7DFB962D26D0EB498902EFBE13AEFA9DC2E6519957FF1CEBEE3B97CAF
            A0BE318E7FD8F1CEA623EB33709C25B8281BA3E51550F2B5A620F2F8843BF2A7
            3E648529D4AF405AAE4087473F782CBE08827CEEA08C9E496351B518C9019B96
            8C44D07CE3FCDB6F98F035079A09383AED49BFA6F262D9428244D2703CDA79D0
            0F8A9C7861D27753B90D7B5FDB3BB0391B762B9FBD12F78C0895222C7D76791B
            DA9C6933A7CD3C7C624F6FBEB344DD8886B1233FB8B41441908B896132AA3658
            4EDD88327A32CAA9E7D4A76A82C730228B71C3F11A6FB9E2C185939637C1640A
            36D382C87534537E17AABF8382DB7FA2E7189050BAE701F3A11EB61C7FF78343
            BF0FD3859047F285716593F8330C01965F7F59CB3577CF7F605FE193F5DB5E3B
            1AEC099D22655CBE56704688B45A436D84D2DA65519F8AC01800825C40E247B8
            628D2E7F6C716A951DD53386323ABC99948CAAEF8411CFAADB7EB2CE9B70F775
            DF9C935EEA40932D6DD24A6B82B2464544BCFE5C57DF4097A0A1F6DCC3808539
            B3E7B5DD4F75850703E2028B27DF5554541E53BECDF21AAFA85FF1D092EF7AE0
            F740C733EF3FDE4F8E67FD2E628940BE5AA7F453112F3C3D0325451945900B09
            1DE2D4AF78146574A4ABAA243C559A4CC138B5B859178CBBF7DAEFCD492C4D42
            3D8378D182123A422110F9133D478A7E5E9AA25A46396510248BAFED5BBB37B3
            3D3007808583320A3422D21A6D5E58B7F2BEC58FD990961F1941697DE78BEFEC
            7F3E4BBB3C1AC9D3908629ADAEDF1F3517B58C8E2A671619A38C91BB7FB28CDE
            68474D28A383F755AD855749AF34AE8917FFAC3CBD0EA1E5A72690CBBFB1F2FB
            9361B603F554BAE68209AE16369560E078FBC148B85A467545282967F5E1D681
            F7DFDBF77AC9EC11CC2B7F98AA0525ED4CEAB8CD0B522BBFB1E4FB363448C164
            54B89079A7E7B9F57B5ECE406F68B852A19599ABACE16162CA879D762DA792D1
            7222D7C9BF9427AAE6B73E75E9EA59F67E3298C9C04F7E90E22284F1B45BB55C
            9618FE71B245C9453D3C20DA871BFA4F45CD6DE5B5BF1A762F6B2AF996FB76B5
            DB081112725129EFC94EBD94D1062DA367B318F4D4327A31A5DF57F340E50984
            22B20C330C02CB60010F894AA467CA36D4B755DE404295835E292D1A3700AF0A
            108B2C9B272F695A74D7958F4C824B7860D82CC595832EBA0BC77B321DA69A68
            D2322A2FD627C971C6AE810F5EDFF57CC9EE0D0C575781E2E5F97AA00DD1A4DB
            663F744DDB9A04D4CBFEA2B24819F441FBC68E37DFDAFF6CBF38414DE9DDFBF2
            94E2DA28834B9BE2E655D3502334E98872A30D64AAFFE671C69550A7A174CD2F
            156CDB3688190491EC0A547D9CBC8640FEA5312A87ADAC25266712A99556B61F
            5896E5EA65B38447E5F694F7C2F79960B6A972158248D9DDD2FA56AFA7EA8F2E
            3C08A66107A1E724AC288C223ED8A9306FE16220EE119C4726B50861815B62A6
            102A89C500211F2BFDC8A8CE16C9BB2DFB403E5FA0D27A301DF9C680E97BED09
            C7B498C17818956594844A7064DF5647D78E9D94510A17E10DD732DAA8657465
            C51A1DD332AA8C1D3DF71E7A506737D6D9F5856C8148C799A8EA76F2ABCB3DD9
            02CC34E4432E1F57A9A4B4C63882D84AD5FEB814A054D07C45E3F2DBE73FD806
            53549A27B543084EE48E0EE47B542455E594AA65F824A066233F12ECF9F0D01B
            474A1F076631FEB848EA9CB45F89D9C427DF3EE7D1A5CD37D890A4C23288E1F9
            85D00C5CD2FF41CF4B6F6C7B3E4B7A48528A7D6CC60E9351392A586728A35023
            A3462CA3B28FAAE34A735A59C8424DA9519380D43BA62A5A71837365AB9AA663
            18866918CC30445463749CEA9E569A2E8E6084C4ED8BD440120F513AAF4B8E11
            A623128D46ABD4CF48B6887AE46219E5118DAF133CE17BBC101AC550F8EABD15
            50462F06B49726ED11D32169E95EC97B4A44203B959251DD33E56D32B97C5918
            58A5C87083C867068DBDB180CAFE67D5437392A60DA66434F6E128D17759F56D
            65D344CCEF2D1D0BA8A72614D4C07ED198A5849B41F2CB22A3F28649AF589765
            F28DC84A04CD574E5B7A69EB827C5F2993EBC87A7DDDA5AE014F3DE1DC88E46D
            17108522AC7816D5791DAE5DF5B8F01D6551D20A5A964CBEF1CED90F35C13829
            BF5E50E8C81D2EF859398A6A2F55F5151A0970A2ACDDBDADF3BD2D1D6FF95636
            3642FD28A0C4B00CBB0566DC33EF3BF3925753704C30546280921F6974950AD0
            F3FADEB51B4FAC1B800E618611E535321A6B3AAFA4970E6FD5533AF5347E57FC
            22036ADC7C79D9066116B18DC036C3646B6AD2C4C6E98DD63887D459B66D9AA6
            65998C19B6614AC3C120BA8BD71CF934F7557EA41F4503B4EBC9F57F9FA52722
            2336450D33B21A48C3EC962B575D7A97F410629F002ABB0CC4A19588843931B0
            E5F0FB9B0EBF199A794ACFCC0A463E03646F99D3B4F8AA59D7274973500C2DA9
            9250F636E2FE297B97671677F66FDAD1BEB128323E71992AFBC342C11CAFF1D1
            957FD8C0C759448E9C500E8529679EC696A934745CE8FBD986BF2A987DD2838C
            38370DF3F3BEE20AC364943730EA8C6919D51F2B2D1DDB4FCE4C2FFACAA27B26
            C39C7CA950E27D39AFA73B7FBCCFEFE977BB33C5DEFE7CC6E505EA480B2D1C0C
            E8C4ABDA49B5842895A3A808CC2631E9C66977DC38E3961434B8A55247EE8834
            9D0467504EA15751216E0425BBB8AB67E3C6E32F06F68034A8E4BB4BBE674971
            82E4783AE3BE853FBAD45E44D4F27C9329C78529AF067C0E410E4EBCB0EF5FB6
            B6AF2FB14C68F8505E5E159F130CD6D81FB58C42A5046A8D1CEB99349FD290D5
            5B4D8D76EB6593E74FA89FDE969EE488FA0632CE829401B2E71A1C062D41A11D
            AC619F7A2A85936F2B42A90B0EFDECBDBFE8E407B48CAA07CC0A9C4632EE6B57
            7F63917113A851842AEB04B48D2C0D1B08A56D1C80EF42E1F5E36BDF3EB0B668
            F67DF69D07F954A414DE76C54357B7AD72A08181A1AB4C0C8B90D2226476C17B
            6B3FFAF589C221697250C61891FDC04C17C7FDBB9BFFA20926191017048A4BF7
            2A3F4B0EEB6A5D1FF879E8F84FEBFF7DCE6A97321A04A15E337D715023A38B52
            2B1CDE389665545D809A9D906ACAA413FDC8F53F9EC1163061B96EB12B7B98D9
            916952C1424FC87F9E68EF39DAED757405C70B22E3069E1C0FA5831B4401A751
            394FB4B21C9E714B0A419B3365D1E4E5B74CB9BF58F48F771F376D39C6EAD708
            5E2EF04C856FFAC7FD832FEC7A3C4C6543E9F2489B8AC913324860CC4CCF7B78
            E11F8E8359523D4D29A3228EB2C7B94D4108B97DA5ADAF6D7BF688BF2B073DD4
            32FDC893DE77D54226A45A126568337FEA548C1C1222258B8C321A5269818E4F
            4CBBA2F5AA39E317CFAC9BC7C0E15AD40C5D8405864BA474D94638FEA965340C
            C1DBD8B56EEDC73FE9378E49171074351733745ACC99775FFBE8157083010E83
            40BF5C3E3CEA2D002153DFB805E87D76D7AFB6F6BF91A3BD848D6C89E0D4D3E7
            48C26DFEEA658F5C37F19684CA024C00943D399D520DBABCB15184BEF5C5B5AF
            6C7F6620EA0E44DE32E4406A50EE2C1CBFF2A1193FAE87094A49E46D2C3B64A0
            72B0B988A8F4FBA39DDE07BFDAF8D703EC581885D211FABC2F57515D5268858E
            53687C64CD1FCC664BEAD56271E3D4CFC1175C46892A1F228D1BC3E14DB75DF5
            C035A9DBE5FD96B68EE717BA068E7051529328D20F218190E39C15F5F9DDBDA2
            FD9343DB725E2EEBF64B33505AA601717D909EB87A29D151734319A9B22B58E3
            AC598F5CFBC7724CEE6CEF9143651C69D59334C0B80EBC32D1C73A5EDCF5CB0C
            3B1180A74C5A2AB198E75C5ABFE0E1853F96A331911D4850239EAE94C75661F5
            8892B008FD7B8A5BD6EE78FC5871AF1CBF9929653AAC4439650F3D5319AD8656
            958C5A8649A486BAF6F4FACB562DBA7D9631DF81564B34806091CE563560E440
            543454464F1FA68C88EF41FEDDA32FBC74E09719B39333656D985C957D19EFCC
            BDF7EAEF5E0ACB8CC856E6489C3846A4A08671E597088AFD70E4E94DFFBCA7B8
            316F665451AD51C78291CF8684DBFACDC5FF665EC3F5D21A35CA22C2CBFF9717
            A7D002F4FC6AEF7FF9A8F3ED403A552C88846F09CBE289A593D7DC37ED0F92D0
            2ABB897E3DADA4034228A44B227F58DA9C7DF3E96D7F37C0DAA5477F51C9A8AA
            ED162413A5A66FAEFEC125ECAA06183FC665D4026A95D233D30BEE5FF6BD4698
            6E2A4795FA416920D7992B66FCD027D2E404294FDC4E381104CC8652942DB1FC
            D6DDEF77FBC773514F810C0883076A7551796F3B83C77DC5B0FCFA4B1B17AC5E
            7827EFB15828EDB84829A8F6B8D59279D93C8628399957F73D73A4B43B208580
            7B82329BA58C2039B771F123F3FF8724B4541206D431995A57AA5A5097DDF3B2
            D0B1AEE7E90D7B5F0B4421925A4F424EC378D3270A6CC4063D7DC2533CDBC6D4
            6E278611D54D4DCDB9F7AA6FB5C29404345A9056AA0F24965115C31AB1496B9D
            3622C869452CA4AE0B99D7F73EFBD6F167F34E7F00AA88A21CB61C2F3D23B9E4
            FEA5DF9D04734D117B6A3AFEAB2628B8AEFC221B21DF0E3B9E7CEB1F3BC97ECF
            2E45A7E8A328A39F0DF1F2E8EA531CAB49AA38E18F6EFABFA651E9C458540D83
            EADE55DC7315E192AF2BD2EEBF79FF3F1CF4764AAF23DE958786662A6A5839EB
            ABB74C7A54EA2FAD28AF76F9F4F1A91C4DA30264369C78F1D5FDBFCCD2762935
            6A22F42260988C7E6BCD0F67D2C5635946E505ABF2221E9B9298FDD0353F9A0C
            7323489A604B634FDE39D7CDF565BA0B7E9E9AC213817434944F2D5406861B16
            49320CEC4291F66DDDFFE1C1CE3DDCF24BD40DCB2546D4FA222EFF50CB88AC94
            689CDD3CFFBA99B74603CC2006214CDDF2B28CAA3CFC52626043FB2B9FF47E14
            18799797A44ADA249588D297372D7D78DE1FA7A0ADDAD4A07A9EEA5201B0280A
            A5179FB5BAB6BA6FFEFEC3DF8021FF59206639BB00544F63549C8175C609AD1A
            CB2C04C3736636CEBF63F18333609E01491BEAD40944EA4BBC04958C4246C9A7
            25A284B49883AE9776FD7663D76B452713922852C16A29A3F59726AF7960E98F
            5A608A054E6D404DCBA81AA27CC81C82F71F7FEDEFF2564FE478E1293E0A65F4
            B3A1BA2C453B4124529D9CA60A93FE64D59F4F2557AA457D9C535D8D2CAAF83D
            5A5744113AFF76D3FF76D8DB1932E28701B34C15190FDB6EBAECAE15E3EF4DA8
            FCEBDADC0FFD95485F241880AED78E3EBBFEF0EFF2ACF3E294D1A4DBFCC8EA1F
            9CA38C9EBA6CF3679C7E4F86A7E0A8CC33E91F48C9F0590B9D70CB82BBAF4D7F
            D5D6769FBC1C3D1BA8C231C562AE3FDB5DF0069855B3B2334E58A361C47CBBCE
            7079B12FD7BBFBF8F63DFD5B43A718806F38D4F3F3EA08EA950625763A6A5A36
            F5E639ADF3A060DAC4D67997D20C65B18DE9DAD92D990F361D7947CF32150535
            E5686CFBC96B66AEBA7FE60F93D0AC3E5327AD9644C9F5B2815BF24A6EC0A56E
            0AAF31F756E7DA4FBA374BCB5480AF2205A4BC052955DB9CC068B3E2859EC051
            E94E6A4729C385BA60DC032B7E34C75A9C5695AB2AD1F1CA5CB99E2DAD366FB9
            7A40A5244BE52347215F01C977C3A15FAEFFFBE3FC13D90E728C911D4644412A
            6C9D5BBFF2DE45DF4D416B0292A07342859AB00535F669FF4E9AB11B0BCF3FB3
            E1E76122CB0D2F8241C397E0ACFD674BBC5123E8E57CAA1F485B29923FB066A7
            177E67FEFFD206D3B4092A7F37B80F4F18054C0EF4E0F7C3B1FFFAEEFFDD0907
            A5B11251E951F184483795C67FE3C61FCCA6D7DBD0A8066EF58E6A9D0AE5E448
            173007BDBFDAF8DF0E799B4B2C73F1643B556B5D9AA12365F45B6BFE60265998
            86360AC6D94D315DBC32AA9E79294D8C24A2FAC9E492EF5EFB274D304B3AAD4A
            AEA8B67594294DFCA03890EFC91732D2F88B33436130CF9C0B2618954A1CC981
            B744070EE477EE38BA311BF4AA0C50167011C4AF2496C97CCB29B6AC5E78FBF4
            E41C7059A41230A941A5AB4EB48CE677153E7A77DFBAC0E90FA9470D332C8A26
            36EED685F72E4FDDE188FA8807A1E0B942D60D4AA520073C526FA46AF3A75EA3
            E3E503BF39E11DE4A0FA9F34F3AB534C6CA8A67D0A35322A9F84949F9ADBB2E4
            8ECB1F6D83193624E8C94B9804AD9604ACCA28D47EDEE84C409F648FC08E9FBC
            F257C574772EECB1ED84F661445DD4FA95CB1F59D172BB092906665C5235D27F
            119DFCC4B58CBED3FFAF2F7EF4EBD0CA45CCE584A28C7E5E0C9351551737921D
            D459D8BAFC9B97FDB8514CD0D60921350E8CB403F45BBC76B1E7E7EFFFE72E71
            D8935E1F09A43B9214E96677D2A3ABFE780A5CA56554DBB9F1A794F350B8A05E
            071CF8C737FEBAD738E819B98B52469329B7E591353F182B325AB93C8072C578
            392A464160B1440B997CD3F4BBAE1D7F4B4A5BDD151985382221BFE6DDFEFEFE
            EE5078D267894F7AF07A89BC73422F478B4216722BEC0FBA3EEEDC78B8EFE302
            C97023E0915204558C49B014A96B215356CFFD5A5DD8CA224B8454C516B5644B
            193D1CED5EB7E3F745B34F58BEBC09C433C73B53EFBCEAC12BC9F5C233F2F982
            EB150311E8248F40EDDD0A1658D4775C6902AF3BF86CC9EAD7AB42C5E07A4A35
            537F663E8ECA1BD019F86664D5876D52C497D5DD6A418325556CD8EDAF8D15D4
            94041C5CC447F8A86534B31B36FFF4E5BFF1EBFA4B5186191651AE1FABE713EE
            BCE23BF31B57489FCE96D6A85033F591FE2CA9AA50CE94EA7BA5E3976FED79AE
            44FA646B031D3C2B94D1CF9861321A2977CF624162E5ACDBEE99F29D046F1EA6
            A1FA2D34043784FC9EFC47CFECFCA994519F074022F92A2B48B68653BF7BF39F
            B5C15C4B95A718DC7A4C772B69D28484BA8761DB4F5EF99BFEC409CF287CDE0D
            50735D4365F45B5FF9E10C58302665943383852E4F41C314E3D2EF5CF3674D30
            8D8429A93BEA46575CC39073C6841B1606B2BDF9528E2B432FCED2A8C99194E2
            15770EBD46835B8197E83FD2FFC9B6C31B7BDD4EC122E9E3AB5919A94DCC340A
            A98513562E9EBABC91B7F8D9B0F2A82BA7BE831D7C69F33305A3076C3FE07E0A
            EA2698336E9A7BE7243E9B155361E473E9ACB378059DEAB081CF232BF492994D
            C7366CEF79CF3373D515018337E60CA5849717B683E327E7345C75C7BC8726C1
            5C0352169C24C765D75E36841C5ADC480582CB9F5E595E345A5CC8EF834DBF59
            FF8B01D2299F1EE147BA2DCD7AD2F6F5AB7F30975E45C1963A2ED4EC7CDCEE72
            08615096D1CC8BC79FF870FF9B25E8175658BBEA1F65F433A6464641F90A5124
            7B8EE1266F9977EFEAB6FB12BCE96419952FF3C00D606073FF5BAFEEFD6D7774
            2410A1F4ED2C420CD76982493FB8F1CFD22A325E2F47F1C1752EFAABD45F02C5
            C3F0F1D31B7ED9C98FF86A21F5C542AC336AD2254CA6FDD64756FF60ECC8685C
            5409E2BC4EA1D6449861A2211A7FC3ECDB564FBA3701E38556805AB74027EEC8
            57AA72CBDDFD2706727DCC5233F86A3164456C69CDBCA4EC256A35118B22CBEB
            748FEC3CB6695FCFB628E10B4B44DA1FA5819D8271CB2F5B3D37B5D82838222A
            9BBD52468F917DAF6E592B65943B7E1478F5B4699239E78639B7B68453A96B85
            916EB14169A06A23E706BEB56BC37B7B5E2B3999A0DC8D86142829F75A32AAA6
            165CA89251C48838244A0D2BA6DDB67AD6BDF530D15055A8F960D0B1E61C3C75
            83BD029C38EC7E9CF533953D53F91959C1D219DF7D62FBFEF69D3918001630AE
            0B6211236934DCBCF436D91159E8A82D55B48CC6EB0B9890A39D61279C032776
            EF3CFE5EC6EBF049498E8083CB9C50463F0F6A167D281995F2273BD283377C6F
            9EB132291AC908F391D487927429DEED7AE5A51D4FBAC98180A8A245A6321348
            933561D5D5770AD7A17A030852C9011054A5BBC92782DAE268EF811D87361744
            5FA4AB565E245465D40E948C3EBCFA4733C83C2DA3F41432AA95E78B26A35CC7
            6E182B26E7A416DDB5E4E159648111D5954DAE9A2D402AD72007C028EF0E74F6
            76C831D03044287C806A6D505A9BE1A1EB723079538D46215DFB7D7D5BF7F77C
            5CB40A01F5E2515AAA5243387ECDA5774F4B5E12168956E1B28CBEB4E5596D8D
            86107909DE7869E2AAE597AD49BB4DE0992A344007E78B94644B69AE2BBEB1E7
            B94F7AB68656A9A61B9D838C4A738E184290BAA0EDCEB9DF5ED67A930D0D8C1B
            A43669A9224F721CF220D897DFB661CFDABEE0585167BC0A3D871F2FF53B75AF
            18D645021F5C3F2AF8CC2334D2FBA6C8878998C44E5B692254EEADBEAA787B6A
            D51119B302DF372D2757ECF3C840C44ACAC520507B2F50463F7B2A811DEDB171
            6687A994D7F2C8AA1F5D4A963A23C8A88AAD7BA49883CE7FD9F8933DF90F5D3B
            A3AC1012CA1E913413DC371B53E3229F106EC47D38AEA9A6675075C0CD00E9EA
            15FD2CA7BE1831F3E7F36A07AD036519F55A1F5EF383739751F97F5884DE4DD9
            B73F7719D537496FA8A9A7531CB7F9DA89B7DD3DE76147055F12F24274165BF9
            BA6A6414F4031C9EE86FCFBBFDD25C8B22B7BC07B228CB68B5985BFC30CB3B5D
            8AF2A9165B7A9D9B0FBEFB717EEB40D42D3542E911158E57BFB075F9F2D9AB45
            C62281512BA345533AA71EE741C26F5CD8B472F9256B58C1049F49FF5FDA9FD5
            5D9864BF31EBA38F0EBFF3DE89B772460F31E3211A6AB65FAEAE3E1EAD8CAAAB
            204CDADE5249DBC8F48796FE78365BA822B052D76A323FAB0F830FC52E38F4FC
            F627F7F56DCAD14CA0CB321971CD1E3D05444657E729D289A23AD6153235CCA8
            A1C5D70F0C53D2AE17BA906AB115432D15A52CF043957F26555B256C574A1B54
            D668C38594D1112B12C2A9BD357EDADF8E7823CEE0AE9D17E24E452A0574C560
            A988333E8E5E12ADD37D4CCB4D36F86DDF5DF3A793E14A071A4E7A350DBD50D8
            8194D1BF7BEB3F760A95A7A14B43709D7427FF588CDAF288E5B5D695F2E4F16A
            7A6A303F904F8AC72C16D504D92E062E948CE6A1E7A3EC3B9FB38CAAB240E5D8
            0DE5861CE59AC5949B67DCBF6AFAD798DAF3C304BD08A6BCBA42CF4293CA23A3
            276EC25094BAFADB0BEE807ACC2B85E99492EA443951DD8345236F2D31A4831F
            04E9D286C3EB0E64761678AF6081B4CD6D9E941FBD70F27597B72E85BC29FB87
            6FE50765D40C642FB44A75D78EFFCA92192B454E6A85A945496547456A968B47
            4631A8CBBCB5F3C57D855D3A5F321C5AA6939E9D8C2A6152F5958CA9CE9C0717
            FED17476B901A6FCA7A83942551C5DC87CE4BEBEF6C35FF69176EEA81EAD2C7C
            BDC855F787D3ABCA10185549D76AC2210C92CC92C789049346B1A91F0FFD5441
            A5F49F3472D592056A5891FA1CE9DE0744B90B345ED4009572DA7A3B2B3158B2
            2F5E1631E84018A4521A63E4B3D4E505E22C5A20BCD202E58A88D57A05B1DD1D
            BFE5E4C55AE5327195823523A58B0C6750C2064B70D2619FA56A8309A81DBF87
            7945F1DB2BC1CA72C51C5109B9C4D99D1C2AA520E2C2868256578554CF7CF0AC
            382DD7D3A97E73CAA6934F5918BB35B4643507937E78EBBF6986598E4A3A3EA9
            C7A9A52CC56E38FC930DFFF944B43730F3F254E369D24805DB89361DCAA744AA
            ED260CF5F9EA5108E262BB845E34E54806EFFBF99451D0099AB532DA5D820143
            8D569F75FABDEC3D55393022C3F2EDF96D57DF7DF98F5A60865AC02E9D48B577
            A7A86988726293CA7453E53222F9829257E81E389175FB403EF894C427CCAACF
            EAA005A43BAE503952DCF44AE6C01BDB9E3FEC7F221CE57A33619B2239CE9AB1
            66DED7EBC3B620EF71DB3DC877BFBEFDF99235A0D67446469318FF95B9F78E37
            A78BA2AA59572E2747ED28F443EED9E3C4DB875EFCB873B3CF72A15A5E1C0F57
            83671EF7F23372EA25263565CF6491357FC2B577CD7E6C1CCCA0DCA472801969
            39671F1C7B71FFE31FB6AF2B18D9C888E20F8E0BD985A71B2387FF8A6A43433E
            0A7A82CB90CF8DCA6C901FCAD53044463894F4FA851A0A4D1A715DA3844611D1
            BE1E0D637D51C55285B26D894AA4103C2226B5BC922B07CBD6BA7116495AB4CE
            12C98491A4FCA4442E69178BC08B5C2F2AB9D2A960BE273C3F2AF9DC532754AE
            B5AA3FA87CDFA92A2C44994AFCB02C5E2E124875C141A66A260445CA641F613A
            E8AB821EA69994D674288F1285CCB4D50A62AA93814225F4F2857EE85323AEB6
            C5E3A15ACA4AA05493F180A4ACA421CC7AABDE882C93DA164B18C4925F4158F1
            7DB72CC3E77E292C7ABC18D0C08D4A5E581C28F551239216405CA893ABDE5E2E
            E14A755DDA202ED0A38B88C5CA2B0733C734652F56EDEA91A654AB295269AB3E
            41EBC9498FAABCAE507AD8E097A81792C8F34A4E9498D3B6E8D6B9F72641BE31
            596EDD1A1F45CAA8CBB2BBA3F79F7AFFE75DE248601499AE90A81CC750DAA2B6
            1A0807878ACABBD4C6106ABA423ED1B2BB847134EA62A25646ED42E383377D67
            6E62690A5ACB55CA466074329A83EE2DD9F535321A8DFC6C5FE0554CBCB29FBB
            EC7FE9207DFDF4D5ABA77FB31E26096946E93478F5C8E9132BCBA81605152E54
            D9EF91AE85119682DC8981F65078D5AB3EF99BEA33A6269D88C712BC333CF8FC
            8E27B3A4272ED6291BCE8E1AE78DBB6ED1F465B44049023675ADDF7464839445
            C32034B42739B356CDBEAB518CE72E273A2CAAA406CC00FC742BDBD9B571FD91
            5706688F002F0CA57BAB466351A91E0D1583A52CEBA39651F50845CC0CAD8593
            AFFFDAACEF36C064834BA79E5163846EDA0BC75E38F03329A345A328855F472C
            20AE8126FBF5481D7BE4D3D04FB2FA265289D9544A809017C49D7AB3A5D96C31
            C3115649CB073BE07EE440CEEDCF05DD521A025ADD95401ECDD05245A3200C7C
            611B692B4A39345567D7B5344CB872D602F97D9236DA509786F4C925FD054491
            9A3E0E3C70A52864A381EE4CE7F1CEE3DD99F6C02CBA3C970DFAA90E56971B2D
            B25AEC89F5565D14098B197E10C43D59C5AF4DE6896267F1900F457D8F785C72
            581AD00624A4F65A2441C16E4C373AB61D06A1327F8DB0D7EBF4445E6AB7B60D
            B91E4EE415D9AA3E8B48B424C78347DBEA9B175CBE2829070348262061AB3566
            295578A17C39AAF695075E005E1F644A22EF87DEF63D9BFB739D45912BF26C20
            4F539422F0E3C6D7DB2F4A19D555669490CBDBA7F677084AC2868403C916A72D
            491A2E993467C6E4398DD09C843A36C2560852E8E53183A20A76FB79BFBF940D
            D261D3DC098B92D0C84479FF8C21A11EB50CB477ABFBC6739B7FDD0DC743C335
            94A6D320E269AB799C33C1E1495598A2327925C860FC41B6A4478B5DDEB1ACDB
            6F1A174D55A7F265C1799751899F85AE2DD9773F7F192D4FC3733374CC5CDD9D
            4B1EBEA6ED963AB5D492C4014D282F5E14B1870CDA378F232F2A134EFD91BE92
            9FF1BA8B6ECE0F03D334A368302EA3375FD2AD225F5A4E19D5D3DF2CCC1A9D2F
            EF79EA847F24223E53513F9B454E83336EDEB445B35BAEECCD74BD7F6CFDB1FC
            3E62F8CA6C091297B52D5E39F5AB29BF212C79B1B5AB4BCD9BBEE1464D032F6D
            7EEA48714FE4A8542A9D66A542EE9136B7B5AFAA6609E3997D4ECF2078224239
            5458B670164F5E71F78CEFA560BC94D1D8161627053AFBE1D8F3077FBEB17D5D
            8965050B74066DD90A5609089514CE78288A9B7DC40FD5337EF1E6544A46A934
            475D32B161D6AD0BEEBD0CAE76A0FEA41EA72A941A2006A0F78DA32FBDBBFF15
            D7CA2B47B2522C356E0110BECD125E89355B93DAF8A4657357CE6E9D0F60D741
            0B95FE83766A41570C1A7A32D5DA19F19A45A14BADAA7F0750CCC189CD03EFBC
            BDE3054F7E62E5BE274A8D8FAEFCD369C66C0B2C132C5D7D6A9063B0E7BFBDF9
            FFE4CC2E262D7D155692761D4D4A772448D71B93E6CFB8BAD5993AB17E4A0B69
            8C3F3F079D2F1C7B62CB910F02538DE84C57068412B1C3BA39AD0B174CBB7676
            F3150D304E94D756C46B0ED588A9EB28B2CA25C46507844E35113A2012EA3FF9
            3D851D9BF6AF3FD8F7B16F0C8454AA9E0E73E95D6D049465542DCF53ABE3A9EC
            878D645C833BEEA6055F9DD7BC8CAA956CD25E94436B6C760C6F3A436F121180
            AA536FEAD7780049484913A4EACF0C8D98933C74BD97F9FD2B3B7FD7473B23E6
            32551A4DBAEDD694E4A5DF5FFC3FD6416B3C3070558A24CEDA8E3B9694ECA003
            F6FFC31BFFAF9BECBFD816FB8E6D19AD0626421625A7A72FBF6BE18353E1320A
            DA6FD59348B2F395D4881AC62B250A911CC603577A4591CAC3F0FC521049BF2B
            0C236F20DBEFF9BE6DDB94554363D4B193D52D62D26955B2DB903E912EE7DEED
            75ACFB786D81F4A9BA21829B421A78D2830639EA2E987A555F267320FB4911B2
            4CE5FB481B26B978FA8A6B27ADB68BE9A054940F4CA4955D3A804132BFE9C41B
            3BDA3F28D281D00C4255A7D6E2BAF87DC4422DA04639562B9F0D169D918CF240
            3AC2568224AF9AB2F2AE69DFA983092492EEA8AD37E51B4E064EBCB4E75F361D
            7F336FF570D35351AACA248052C5EACE229F26A335DB2BE94D414CC6FCC4C4C4
            25F72C7A74162C75C4F0A909157BE53E374A03D0F9FCF62737F7BC5574B251A5
            FC6B2CA3866C459FDBBCAE253973F5D23BAE3016E8DCC3248384BCC74CAD1F1B
            8C998E3013A66FE1B029B2405526CC6C0EDE7A6DE76F8E170EE8AAD66A322D95
            1FFF2737FD9F53D915F2BC42111A950BD7E1F2A823DAF797AFFF3BBFB92F0CE2
            CB348CD06A26AD2B177F6552F2D25698D6006D06484B93493B2E0F7D5BFBD7AF
            DBF754BB7F30D423B2191956E0385E7AC515AB964CBAA10926595067402A0A3C
            D9B92295B30CE532F2B46A1E5605A71C73F03C4F76544FB81171A5055A84DE03
            7CE75B1F3D77227FC4334A3E75CBD645D960E43AFE4CD530CF5B6FB87CCDD54D
            ABA50458D018052AFA9524AA37B2936F26298F4182C7838F90E63991C761505E
            15527ED59072DE79E878BDFBB76FEE7B3E4BFAE44D9487559FE19B97D52DFED1
            55FF6B9A4F286FC2A41767D7B8385C5EC8C160DB3FAEFFF38CDD7E912C5E1A3C
            B90B27A31F0D6C7875FB730366F780DF6D99E2F3915135B1A092D528B7E64C5C
            78FDCC1BDA60424F4115632E45C5829F2F85459F06473A0FF6E53329C7968378
            BC90298E16552EF39473B3B52144CB307CDF4FD7354C9838B1B7BF2FE7E57261
            861357694D797A4A850255A97CED84EAC0BC9A0433842D1F9BEB66DDB4A86D05
            64ADC8970FBD9A8B0C49102582A3F93D1F1C7DAD9F7748B72B625C6FAD41E3D2
            FB8C5179C229A86FAA6FCAF9C56258F088CBE99924827069243BBC2096CDB8F9
            9E193F50751E55DD3AB3365C50455A67FBF3DB5EDBF6ECFED2F6289D0F99EB47
            25F9B8BA259F318B9C6C209C3EB650B9F57EE4A5A179767AF1ED0B1F9A06F31C
            3EC2D484AA6B08A563B0FBB94D4F7C5CD8E8DAF94A301AD4DC866C0D8F36D2D6
            A5336FB876DA6D2D30D9907743193572E8A2B111577B134F3FCEC44B2DE40D0A
            6463427E7DF70B2F7DF2AB9CD92DCD2D1E7106667D61F2BFBDF93FB5C18CA85C
            6DB6B6A5F8216FC7DFBEF57F6493ED6AFE2D726CBFE1AAE9D7DD35E71B0EA4A9
            F25DA4C8C8B69256B11942B113763FBDF589FDC55D399A51717C57348AB62BC7
            2DBDFBF26F39D0CCD4925C792166757AA7368322EE9CB5519DF26B2AC398506B
            F0A49D280548BAFCF95ED8FFFB0F9FDCE76DCB9BD9CAD35196518B3922B05ACD
            29ABE7DCB1A0619934098388A85D40202E702EC8A98A1F8AF2C757F6E4AA3E2D
            1C46D60F697DB7FF7AFFDF6F3EF196CFBCD85467919186F48A4B6FFB4ADB37A5
            3FA44B80D3CA8E86BCBC4C5B593C99F5875E7AE1B0BC175D67BB95E285A22AA3
            6690748A8DDFB8F13CC9680E7A3FCA6EF8FDA6DF7AF5D99E428763C1E722A33A
            CEA24A8A487BCD12F50E244D5FC5FEB911C95B28752A64B287792A2CA5BB89F2
            2FB8D0FB628662C809D39AD4A241C850A32D9EB05613ECD2D9518FB8DA6389C5
            96CE49A6198BAB88EA6DB0A6272E5D32EDBA69F65C9E356C2BE54681F4BF7832
            E8F48FBEF6D1F339AB33300AD24AD401383DA540D432491A9AB464CE68BEF4A6
            A5ABF6E6F7BEBD795D601623760669C9DAAFB3C0A50B265EF7F5393F688169A7
            9151A1BA72A93D3CB0B5FBFD9DC736F5E68F79B428CC5065504B8B5C9C948372
            D21DE7E59FD0C1CD01551D4955946461E30DB7A99DAC66DA3C71F279AA6A6BE0
            ED16EFAFDDFCAB43A55D9E99AF9C9301913084D5002D4BA7DFB87CEA6D4D30C5
            81FAF2E7946DCC617D753432AACE2F508BB5724F6DFFD987DD2F17ED1ED9670C
            C386C06A284DFB0F37FF75A38AB00FB161B5651E75C081BF7AFDDF67E80987D6
            8DB3A7DC30EFABB353F35B6172CD944B9CD5C08BD0B3D57BFDB9CDBF3EE19D00
            47588426C3FA451356DC7AC9BD75F2F5BCBE927D51EE7FFA7D4364B4E61E0D26
            7E55CEA5DCFEB1992A4D3902F97DC1A69FBEFD97034E3767F13607E535368E48
            25A3D6EB2F597DD3C4DBA486AA7D6D85535EB65CB3C6EFA496223553EA0206A7
            37AB65F146784F068EFFEDBBFFFB016F077368BC110E8BAC46685A73E5DD2BEA
            EF4E40AB9EF555898A50B549D555B81EF4BEB16FED1BC7D6E69DDECF6549E469
            88B31ED562D0F327A3F2578194D1CD03EB5FDEF63B79CD19B7EB73B146E3A2F4
            54A51A4A9F9D5A663AF042E9A819445E9DD045E5958357F48A4CFA4B86729122
            BD49659CF232D817F54B4F7FAA7183C465BBE2B6291B0BA0824B526D993E93B2
            8AC4B926E5047270FCF4E2712B974CBD3659ACE3052322466472912ACA47F1E5
            1DCFF545ED01F14C87F040E8227B5ABB49A8B6482AB52D9E71DDCA39B726C0D9
            035B7EFFC16F33616774268BE4D45EA0C234027366DDBCFB17FCC1247AA90A77
            442C9E9E3EF9C55A020217727DD0D99139B8EBE847DB3B360689A2674AC32D28
            77A99AFA03C35BA93C235C1E93E2C8816022E5B65C3BFE8EDBE63CA07A9E1861
            F6200AFCC0CA7C987D61EDA6270BD6805AC1558E6B9BA2082DAC65DEF86577CC
            792C012D8E2A904A49D9BF15352BC186A8674DA52AFDBBE1B7528D22D2FA2E41
            D7131FFEFDEE810F3D67801B01538F7EFA92E4557FB840BA9FADFAFD35CDA44E
            4974C0BEBFF8FDBFE38EBF68C23557CD58796972BE09090B6C954606FAE61155
            733304B7170E3FBEE96F0FE677F0049783A21D5AB3EA163CB2E84FEB6122D78E
            547C5EAC1C108DCD32563D6F5193A834CC54AC6E26132FA8E565633CCAC3F157
            8F3DF9EEC1574AAC186729519DF466E4134B26AEBAE3F207C7C14411E95462CB
            91878ED3A28754F5AAE90CF2CE9138E0ACAA4CE8956CA292A6760A739103EF86
            FDFFF1B5FFB9CF3CA2D23FB5D8B2D019674DBE63D1FD8B8D9B13D018AFDC16B4
            B2B1844AC2E01129E6A1E7B99DBFFEA0779DE7F4737E11E5DEC385915175D802
            F47DD0F3E686FD2F1F29ED0DEC2253AB543E0F19AD54355039136ACDA2A1F441
            67C5809E09D4A585E2C2CA4C05750455330683698350937C3D58358E541617D5
            E6DC5996E5FB6EC02346075FAF2BDB9361325AFE95AEFAAE64D46B5C3EF9F605
            E396B022535159C364F5224B4FACDBFA5C8738E4B25C180596E994E7E2E3A5BB
            C274C2A6E597DDB178E2CA4698289FC9DDB0E9A5ED4FB5E7F64446F10CDA48F5
            56E27067823DF3BE853F9C695E69A80A75861892CA5E3EEBF224837C14B82B2D
            690F7239E83990FBF878E1E0274777F416BBA492AAC90A55499A7332381AA9DA
            2F9579DE3893B7564609A309B779D5E407D7CCFABA0975261F212590F3C8337A
            DFECFFCD739BFF254AF8AA64BABE2F4C9856297965F3E2E5736EB9C4B99AF1A4
            41940B4CE26E5A96D1E161BDD36828D458793E647BE1D0DAED4FECE8F9C0B773
            7274A3DC32A1E9A63977DDD6FC508AB7E8430C91D108825E68FFC757FE72EA25
            536F9875AB344293D0A8AE3D5E04AC1787B9816B58A204FD52707FF2D65FF5F2
            76C3A0B6484E3666DC7FDD0F26C3020BD23C2E014E2A32AA7395CA3701CA15B6
            2210432FA426F4A407DBDA80946AEE889458CF51D8F2D3D7FE4BCEEE513B36EA
            87DF14CECCF4E577CEFBF61CB2503A6896F4E619ADB483FEE4D8CA844A15B4C1
            4A0E14CA53ACBEFEB97C1B2D5BCD232D0ED64518C48160EB3F6DF8F35CAA4325
            80E9694623484E3167DE73F52397C2920434286740A8484C3960A0DA8C4734DF
            0F1D4F6D7D7C5BF6BD2091E76170069DFCC273416494AB54EDE2E168C7B6AE77
            D67DFC3C6B08FD20FFB9CCD49797BA9CFCF31A99105CD46A86EA2CB4BA0F28E8
            ECBFDA303955CE6B28D4EEED1151D92C5CD0A44D188994ADEB495FDEB08D50CD
            2F0CB9B4EAA35CF9305A0993732922AB673E7079DB556EB6643A26498B03BD9F
            6C3DF66E476E3F370BD2498F37B29767E2163C83588E9AC3BD6AC98C95F31AAF
            B6A0DE042780D221F8F8D95D4F1CCC6C8D8C3C8C0EAE8D51D9054C208952E3EA
            395F5F39F9B6148C273A66306C65CBD0FB542E47AF436FBE747E7BA0A33377F8
            48E7EE8EDCE1A3FD8722D30B58082C5025FE94E1AFB2C04CA2D614842ABB40EF
            CA5A8957AA6731D778CBEC47D74CBFC782A471928CAA079940097A5FED7DE2E5
            9DCFB84641D57652C96C8621ECC668C23D8B1E9B9FBE5E97D773F41D548F2021
            E573960A16CFD30781DACB5757CB60A7EF7671782284FC01D8FCECA65F1D77F7
            B8AA2C5B640833211A565F7ECFCD4DF72544CB49ABB6D45E08A5287FB077DF84
            711392AA4E95152790556287CAD9F1A45B618439E8FAEDD69F6FED7BC7B7B28E
            30EBC3F12BA7DD79DDAC5BE5A0A8ACBCF2DC9DF669A9A8B12FA9AAF845AA2565
            624515A10E801ACAF0365506AE9AE3E155D718E269BA4884663E03077FB6FE6F
            8FF17D257340B6A01CB42CBFFE863977DC31E1615B34AA051095E12DD650D59A
            83C5BE54FABC1CB3B9DA172BD41F6A09BD8685E84951F98A04D431511B89AE0D
            7AA861E6C3AED7D77EF24F7DEC486567496EF975B3130B1F58F6ED36B824A992
            F6D990928CFA8E46347B08B6FFF7D7FEBEDF3E1ADAC5211B7A5F045C10198D94
            8C06DDB06F47EFFA17B7FDDA4F6685F81CACD1D3304C4687374ABC2747FC4A95
            614AE2E9601E70123193AA5CE874A2DE144682A980974782AEDC096A052E2FA8
            242493F0A83650382C6E5539727986973B5EF32D973E78D984459EE745CC3DD4
            B3E7E3F66D470B7B429A37D54B74668F50A546AD28C182C48299D7AF9875EB78
            98E940832AA02A2C9F158EC227BFDBF6F8C1DC4781397A1985385841F4061E97
            A4E7DDB5F89B93E10A03D2ACE6DE0FD612252347A48412D3920BD9220CB830B0
            ADFDC38EDCB1F6BEE3B9B0D7A3799F14549AA2DA784F2DBA0FD81019A53AAFAB
            299C72FBDCC7AE562BFA138C5BC38FAF9749E4A0E385E3FFBCE1C0CB2596E386
            DE9125B2CC30B978DA4D6B663CD806D36D70F44EA2834B31B55F48E34A6BDA3A
            123ADC1988F25ABB086AE6432A8FAD9A7E8E8F5384CC31D8F5ECC67F692F1E00
            270A43CF22C93ADE72FBC2FB96A5EF488AE6A1325A0EC74AA7A71878F27A4D66
            3395641A2FF48C5FA93682890814217708B6FE66FDCF7AE891929F4946C92B5B
            963DB0F0C7F530596A6CC24C414D9F8C2B1982F66C5C700D900D9AC9885E572F
            508E9334949FC285C59C5636D954FB715A6A91826E24A86891CAC733BD0274BC
            B4FF37EB8FBD5CB0FB653FB7A2D4146BF69D8BBF79295D9AE42D7AF1728D55A1
            65543EA37E509276B834CFFB796FCEED2F7803997C4FDE2B08CB8A1738C99BEB
            D8E9298D336726AF30E51D2423CCD44BA1F7A0F8DEF1975F39F0C4006B0F2A6B
            C61CAFE18AF4B27B973CD6ACD312201EE4E22CC472B2130D68E663F1E1136FFC
            43DEEAF2CC22B9F8129ECEAB8CEA1F07043C888AD0F551DFBA6736FFB464F79A
            26F982C8282DA759946F94F6AAD4041C49B054CA6A7048BADE6C3543E78AD9F3
            5864582C1144A191129BF7BE7B20B3234FFB7DB525C6B0C0CDC86B07AB326A05
            E9EB677D65EEE485035E6E7FFBEEA3BD7B7A0A1D21550FBC699AFA1E8552320C
            373D253D67FEA46BAE9B7A73029A28386E14D9446D032EA0D40E7B9FDDFECB9D
            19E97E6647DF0E7C7095972595F4EA99ABBF3AED5B296823EA39A4A4BA30363E
            F3CA9A42182EB2B1711AEA945B69A49472D0D79EDDBF79FF7B07DDBDBD5E0731
            3D2B6984AE7A6CC29A5CD738EE6C0836D1BAF4BE857F34935D21AD5176D22A23
            F9FA88843D70F877BBFF6967CFFB2592552994BACB2682715F5FF1ED45D64D06
            A4CCC19CD03892506E725EBE90D0877C090A03D0DDEF75E74BFD21F72A336943
            7AA67CECD3E9B4C3948DBFEBC4D6ED8736E678BFABD2E90D9BA75AC8E4FBAE7B
            742E5CA7B6411CDA9695F650A2ED57769C66A27C0D656521BC1484DC2CBE9DF9
            ED2BDB9F72EDBC7453AC42DD8D73EE5C35F5C1B4DACAAD6C4596F7AC16E5091E
            79004FEDA2983B147EB2B77D6B7BE6603E1A5012AD73514CE249CBB7293969F1
            8C95B3ADAB1D9126BA13963343E3D0534484E9CBA7F2B5C34FBF79706DC1E995
            43BE13D42D1D7FD3D7673F9A80361B1AE34041C5CE557101A5742AEA5D3C12EC
            DEDDF9C1D1FE031DD94E97BB9E57F0238F99667C65666425C2FA3BAF7F7869C3
            2AE91694D35D2AED197FA353AF065E3FF0DCFAE34FE5AD9E208A8D1529A34D0B
            9B56DEBBF091348C372041E2FB582D62ABBB980F99CDDE9BFFBAE167AED3E792
            2C818B6227BB9AE7E8FCCAA80E394B19F58167A1636BEF5B2FEC7C3C48F5497F
            EA0B22A3B5D7A95231A8D0797F76F3F8FA8953C7CD686B9CD0624EA06086F948
            4DC5A830BC2A03EA24A3C737FE43A77FCCA7814A69E44367F9ABDFD57C545546
            59E4B41813DA1A2716835257A6C38782602ABC18A9679C99824965B182E4FC49
            CB56CCBDB515A6D5439B2F1D65AE122EC3780B5A289D80FDCF6DF9E5B6DC7BEE
            19CB689C7D6980471BC5A4AF5C76CF8AF1B712A54A4916CF0595CD2CDDA7C908
            32AA3A83DA3740999CF2271EF81C5C13827EE8DA17EE7D67D7CBC7FBF704ACC0
            995A2F10093DB3577948A43165827349DD8207AFFCE31698164FC59CD447D412
            1D394EFCEBB6FF7AA8B05D2A9AAA0200B6E935CC4A2FB96FC977C6C30CC61DA3
            EAE542F9A274D4429E4D6051A308DD474BFBB7B56FEAF34FF4E7BAF3857E3F2A
            A9254627CDA4453CAAAFAF3798E179A55C312312021C3904F8D26A76C2BA89C6
            AC87AFF9E124989B185E7A633034194442DD9A58BF4854B9F32A06123F2103D0
            FEF31D7FB5B77F93A09E19A666A4AEBC67E9A31355398FB41C89A4E11E55023E
            2A614BAD8E92366C5082ECD6810DEFEF7BFD60F74E56C75D525035AD553E3218
            C2173E24A165E5A5777C65CA43CA5286502B20AD08B19A14880C7990EED78F3C
            F3C681674A56BFBC1D09BFE9EE2BBF7D6DCB1A53D5EA4E86D5261CCCEA97267C
            FE041C7867D7EFB777BC1B3AC512092BA5C4070B65C8AB686353EFBEE6D1B9C6
            D54ED8541B1AADCA68A036C7EE7969F7531FF4BC243FDD0F03B520984749AF79
            49EBEA7BE6CBF1BB91289782D5F4B0F2E05484BE0F4A2FFDEEBD27BCC480C70B
            17C9164C35CF519C70462DFFFCC968A4AC51BF0F8EBD77F4D597763E61B7055E
            E05DB4323AF4FC8574DE940D189949489B7EA2D9689BD976D9DCE90B69E4C4B5
            2D7C375009007AC247F81E758CD0088B89DCF35B9EEC83131E2DF25397F01A6A
            90D2EA0DD07A4D559E7FAC33546AACDE8BD9A3296868E4ADCBE6ACBC7ECA1A47
            ADC993EAE6A8590BED94AAE261D25786421F1CF9DD965F6DCBAE2F3AA395D172
            80AD5201CB002B2A9049C9A9D7CF5E754DEBADCA26158CBB52E71C7553696C8D
            8E902D34EC1646E5A74BE54B7BE0F543FB6B7B9FDA7AF47D697979A4A4B21968
            BC85138FCB5E98DCBEBC6DD9FD73FEA009A6186A6FC1E15D82135F3EB4FB60CB
            33DBFEE950E1E322CF4BBD4E901419A8BB63C177AF99F895066832CA8BFB2BC9
            37E5BDCD41674D7A25C8BC75FC85F57B5ECDB3BE6A2683B271D574626CB5517E
            5246772C40723C0B99DA3A8F10667A7513F9AC3FBAE9DFD6C144B567EAC88D4A
            6B437B82875253221555E4A1DA34581A14A50ED8F7D377FFBF01723C2C790D30
            7EE9C49BBF36F75B96B407B9B4C52295CC5E9E4D54EDCE74102480C23E77FB6F
            37FFF4B8BB875B11B141176F54E10DF9324F9E23B79261C3CAD9B7DD3EE55B52
            462B4D57B56755A0336481B4469FDDF9F8969ED7F3AC5F1E7B7AFAF24717FCC9
            38B844762AE9827075EFA88EB7121A57E7013F84DC5B9DCFAEDBF57C9EF44496
            743854153B26C272092EF5BF6106E9E9C92B1E59FAA34698E4440DACBCEF71B5
            80BD2280622F1CF9CD073FDD5DFC284C159531ABAA948A2698FCF5F9DFB9B27E
            593DB4EADA32F18048E9E07008BDD0BEBEE7D9D7773D1B98795F142F3619AD5C
            ACB246ED42E3376EFACE95CE52E95BE838F5D9946D8E9B8DFB50DC53DAF6C6AE
            DFEF1E782F4A4ACBEDE28D8D0E36839A4C6786EC992E694EB45D32E18A19AD97
            8C4B4EA45E32CC12A257B1D45EB6DAA859F66FC3776D6F67C7B6EDDDEF16486F
            48BD08227E8ACCF31165B4DA6C6ABA47259B9A4CA869161A9A4E543FAB65EE35
            7396A7C2E68975332D9134A9C3541126B3525F4A2DEC13503C3B198DB4A2E92A
            4D34F2A3A4933638D489B6EBA6DE7ACDE45549A8B720A5A62EA4BA3172AAD8E8
            F08D98AA0507D4802A7B426E008EBDB8F7A91DDD9BB2BC971BAA4E0F33D443A2
            65D43043EBAA492BEFBAE4FB8D3099C5D30B438988EFC2C047FD6FBFB8F7979D
            E1416ACBD146482F325D9CF8ADEBFFA7D9C9C5695DF3B046462BB747252DB901
            64DF3BFEFA3B475EEC8C8EA8BC5A9DF2AD27A175BD0EE2EB738FEB5A0EBF5971
            F0A15281C974BCFAB9CE55DFBCFA8729182FADF5919BB572FE6A213D3017FAE5
            077586270A91970B72A5A810F0624771DF8623AF8446DEF069533461C5D4AFAD
            98F955E956EBE9351DB7D5D10611CBA8922B69C775BDDFFDDADA2D8FE79C01A6
            5681964BC919FAB20360095AEF1453B7CCBB6779CB5D1519A53532AA62D0C208
            5CE87E7AD7CF3777BD5A625903920B262EFFC6EC3F4AC13865D1AA17C6855174
            D119F5456AA8DB0347D6EEFEC5F6AEF7A58910D148104BF799B09C86A1C3EB66
            503F95CEFDFE8A3F6D526B1F2A9B210E95515F6D8EFDC94F5EFE9BDE44074FBA
            41E82BB7241413AC9977CFFFDEDCC49204D4E9E13A8EE796A3DB7A624AD57378
            FEC04F3F3AFEB64A55A6C1E82A327EF6A8EAF74A466FFCDEB9CB28D78512B21F
            66DE79E1A36732F47889F5AB5A1F17BD8C4A93D0E6E906D676F9F8F9E39C492D
            F644D9CF54D1FC50D77153DE09D34F9EBEC1CA6F51057D82A47B20BFF3FDBD6F
            166867404B544D0D2BEF75C41A345567F6A464FEB85E912F3BB215D9D4331AAC
            F1935233E734CF9F5C3F23419D62C6778C54CAA94FA61A12565D5CE54F4D41EB
            6968A12B81AEDDFECB6D990DA377EA07A77BB5FB69EADB2A073C83DB29BF6976
            F3FC1B2E5F33C3B8D2827A224F89DA62A4CE3BA8A1A292283A28A3BA46960A98
            4A33E4D8AB079FDADEFEFE40D8C36D1EAFC402BDA0CBF4ED1597DC7ADB9447EA
            61CA88BBD146E01621F3FAE167DF38FC5BB5563D6186FF3F7BEF0164D771A569
            E6CD6B9F2B6F600ADE15BC07410BD08AA4083A8956A204512B6DABBBB53BD3DB
            33B3B3111BB1B1B13111D3331DDD6AB5BAE53D4989DE13A2271C4918C27B57B0
            85F2F5AA9EB93673D3DCFBEAA10C85C2038952F17CDD02C1E2ABFBAEFDEFC9CC
            73FEE304BA6F4D89CDFBD692FF52C59F5B5D469E85C3A1A1ED219F533B8DF6BC
            BAEDA9235DFBD572EA118F8D3788A88C5064BC15DD96032749C375AAA852805D
            FDB8577575DD4D77CE7CD0423583C8685110CA22E85ED44150EEB47BE868DBC1
            ED87B6B8A217B7C806E3FD65A961739F27D79860CDBC67C1DA99FA5276E55526
            A332139337CB44A16535FB05A5971DC58BDB7E7F24BBDF311DBEF0232CBD15DE
            444B386CB13BCE8E3568D3BE72DDE353F02283574C11E194A7CA227C244B3635
            A7079D7EEAE39F1EB5B7D82863919A9BE7DFBFBAE6FE38AA0A42CFD368225686
            AFBCD95CF660CF274FEFFD693B3AC976BED8E6557C30AC068ED9658DF1C58FAE
            F85FC50B2679A1E76A1851BAA8A729D8F1B3D77F90AF49BB7A4E4CA7F317158B
            88EF5FF09D49CA6C4B98AD44CA221F519E10C21EC17674E6899DFFD894DDE3D0
            1C7B50475A3168E1890E659445A3E68A24AA5258FC71E9324ADD40E9F938FDC1
            BADD2FB57AA75908C0466E235646313747D01462B0807CEEA445939880686312
            7E8A64548C0D8FAB42C006F9384C9A14F697E2F778567F2CDFE69F7D77DFEB19
            AD3DC0BD9472C30EF6993F2FA3A8E0B81CDE88D24297C5C29A6F4CAD9B31B56E
            4EBD3131E956699EC96E24C3301CC753B1A66A3155D3C7578DE39F150B41C228
            3C771E1D7F79EF137BBB3E1EDE1253A4A4EC90342A6C5958B0A6284CA4945EBD
            569D38BD7AEE750BBF54831A985C6B28A6F35A464DDCE2B8B01A2E5C4CFA2A58
            A2F203F101DEBB9C7D45E0A30C1382770FBEBABB752B4AB8B66F8B241E5EC1A2
            BBB19B1BEFBA75EC830934765019651165376A7EFF3893D117EC782F9F6BF331
            7BE4168FBDEEFE29DF2D436354D90D9C1665A48BB44A8D1B26B46DEA7CF1FD83
            AFB57BAD2C8CE509147C276587A7A2F3F0A9954D22D59CEF6C99577DEBE4FB6F
            187F87A8D4B4067E50BE4B3CEE14D573161D7D75D30BADD9932491EF215DBEE2
            0ABF6A82753EAD417C36EA314C1A9F51BEE8BE798F8F41D3308D29540D9308B0
            5F9051147844CD6E6C7DE5CDDD2FE563BD36B6B93E72D7465525BCE9974A9097
            0FAA8C712BA6AFBE76E26D3154C7249E57CF0A19454563200FB37870FFAFDEF8
            A79EC4690FF9096FEC57AE59BB20B6CA241551C44D8B8E9ADDC32C96CF6C6D79
            E7C5FDBF752B7A1CC7A1D4171226178170C1A43166575C33E6B63B1AEFC7412A
            A55623B9C05F34D26241A58DBA0F781F3EBFF9B71D468BABE6D969F01D5F55CC
            19158BBE3AE73BE3D14C8DDFCF6A740315D2D5F84DD58A4EFE76E7FF6CCAEE0B
            145BA4FA8F7C1995D1682932CAA3D1EE4F329B5EFDE4F92EA599AFAC6914A14F
            BB533F33FA56DEFB7E4491EBBA4C983CCF8B193116112468C5E48AC6C9D58D75
            89714C4184D987F068448548A4E00384445F501CB010B5CC6F510FBFB7E7B516
            B7859ABE8A3DB166235B160FE1D7DB67CDCB0759DC7D529555E18616C4752731
            6DCCAC2955D3CB8DDA72B3928D7679F7598A8BA602C4308DE084194F252B2DAB
            4AE365D73CC3918DBC9EDDFBABC3DD5B5DE362139E0A570B155DEA703A826A4C
            D0554F67225E65D45626EA16CDBBAA419F528BC6616E2C6419FC41350861C36B
            4F550D5534DE9301DD85569158DA09CB7E64EBDBD6BDB6FBA9B4D1CA5EABD1A4
            B015F72AEE5AF2E00D655FD66805DF91C16AF973A863DD89A7379C79C3337B7D
            DF3169CC0C2A6E9A73378BA412A139AE48174751792266B10F37856B43C79FDB
            FDD3831D5B6CDDA57AA1A842A4FD5FFCA3284CE408D2EA9489F7CF7B7C6EFC2A
            93E784F54FCC92995522766EDDD5B3F9A52DCFD8EC5A28BE284960173288EE25
            71627845866EFAB16BA7DE7AFB84AFA7E818CCCBB714B96E13602D9ADFE549A7
            69D4F2CE91E73F3EFA1E77EC467CB18BF052603566C6CB12C9A45E36A56AC684
            EAE993CB66B3B81223932F760F306366DBE9466D7B721FBCB0E9976EBC930D68
            C619F3EF59FEF5C9689E4ECBE4DB542DAAD317B543992C6A7DEDF0B35BDADEC9
            E9DDFD1663A38DF3417D0D6EB86DEA03CB6AAE6781708C7B74D1420F441426DE
            FBEC5DB82BBBFE852D4FE6AD6E1FDBECAAC53413FBE6CCD4E287E67CBF1A4DC0
            E1047CDF2D4978B6AB6328E884BBFBD7DBFEF1BCD24490CBAFDB150ABF86BE43
            2EAF8C86233B3EA86732FAFAF6673BF09595514E7F19E59390C4B212EC65C844
            930DDE1BC7CE1F1F9B5E638D23395A58298E8E51D6C3A885D22643D3D96BD948
            EA2DEEA9F5275F3E933DEE9BDC678CCF16153AAC0D617B8E515F868DE705A66A
            D220D069A2C2A89B583BB3DE9A50176F48A20A3D305020D24D064B3316969454
            D762F1544D79A2268EE279D47B161D7A79CF13C77A869137FA69674CACF0CAC9
            41610717B3D45442AD1AA7372C9F7D4DBD3E29C6FD934C4DF461E6138BD4EC73
            B246A8EF5A132C46B87CFCE6A1FCD1ECCE75C79E3ADEB3C7E52DE67934AA7989
            6AB561CDB20796993768A48257BF0C90511765BAD1D9D70E3FB3BDE57DD7E861
            C7CE5D297B620FDFFC9D05C6EA04AA46A184C9CE6A3C014751A88B78C07B061D
            FAC3C73F38E31EF6748FBDDB94A274DE8B935139F0975756ABC5D31F59F457D3
            0D366A8E0DF4DF14A178E0A0F4E69657D71F7EA34D39EFEA76D88E80FA03BF97
            2760B8F19B1ABF7CCB988712A84E092746453F542EA38A222455456A2FEDD8DD
            FA7173E6986A065857E246CA50AD989130352BAE31D962FF9F30519985CAB1C8
            872FCC8706D1EB9CF20C0ADB465DAF9EF8F5F633EF7A5AC620B1D9E5D7DD3EEF
            C17A3495699F1CFA73BF251127F087860DE9514F2B3AFADA816777777C94E79D
            68073F45EC3AD62813BFB2F03BB3AC8506DF9378BF76DC4219DD4ED4FCCED9E7
            3F38F28667F5BA28CFAEB4A9584C77E6565FFD70E3DF96A371D169EC2FA3BAE2
            1DC86EFBCDF61F7469A779283A3265949FE5828C3E5EB28C8ADB8E5D801DD9CD
            4C463B71730EF72AF8CA34580E7757EE5AD1509ABD8AB1AF27687272D5ACD963
            97D6C7C6EBAECE423F4295BE799FBE63C461719B18B4FA8E6B956B6DC1994D07
            DE399D3FE4271C470DD8984F36B0936974180D22A372324BE64EF28DF901BBE1
            0CDF9A583EB3B17EC598C4443DD0A8CB658BDDC381B897F93E0CBC63D8B09138
            ECE7313D95B4AAAAE37554F74FA37D2FED7CE244767789321A46BEB2E695DB31
            0B6356AAA80A537655F594315513CBADDA85D3964F34A6C5517982277B9B2A97
            15FDC2C896F4CD508AB6CC2ECDA695E6B7CEFEF183FD6F2809366865C13B93D1
            D494C4ECBB973E3C1DCDD749F9C0C24D2464B4051D7965CF9307BAB6D95A5AC7
            9AE927CC7CE5B76FFDDF2620EE108CC296AEC547C12229BE3C72D4DBF5D4E61F
            76EBCD9EE6FAC42BEE84311C1915975689D7A1296B57FC4736FC349089074F5D
            54CEF8877FF5C13F7499A7336A9AA7BE09512B320F2C92D1C0309DC41D8BBF7A
            43E5BD71544B43ED1399038A265EB73E9299148A9F553A029E46C67307A47915
            DB01958F0C346120A08AB40D7EB18AE3F9205A2193C56687B29F3CB7EB6769F5
            8C8F72869D5A35F5FE6B26DC5989C6E9283EA88CFAA8F708DAFEFA8E678E65F7
            3AFAE045C63C6585B017CCC46FADFC3FC6A269064F953306CA281B0176A1B37F
            D8F7933DED1F51CBB54916F3F5313316942F19BBEAC1197F9B4035D17D236BDB
            C23740C097B97A76B46F787AF74F33B156450CF53019E1322AE7462F594689B8
            1722197DF5132EA3B672E564541A58842675E17095DDBE6A10AF4F8C9B583E7D
            F6B88549524D7A515C33D88E7B815F18070D945169C16D9828A7766E39F1DEE1
            F6BD793DCBC29CAC9B8BC5129AA747ABBD7CFDB7E07854683E2C6594FDC5135A
            61301171B5325A73CD9CDBC6EB73137E999DC90917773E5AF4C52C3F6F0F3AE0
            8E11CD517CACB3F0170779948AD5D4D6979F45075ED8F5FB5399039E3E9C9AFA
            01848362D21753634DCFE7F2AAA1F3D318B07317A39E5615AB67517CAD316646
            FD9CA9958D4954C9F34C691C15F7642AE4ED0B870B9F47431DEBBB5FFED3AEE7
            5D2D1DA8FC4D60B8E5B32B57DCBDE0E1F168861AC414551B7897D8A8E734DAFD
            D28E279BB2FB6C92D655C30812E3F4190F5DFDEDF1688E89528550B4E8B2F3E6
            1936CA1CCC6F79EE935FF5682D7994E7F37AA4AF73FAB064945B9A2A897A34ED
            3B57FD7D0D9AA4898AA9011F266EE09CA3477EFCDEFF9B2B6BB369AEF0E6A694
            144D10857FD17D43CF97DDB7F26B2B53B75BA89A866E497D69F3613256A0F3EB
            81C5D48878C094301B513400101DB1F851F1414A587ADF97F18E65BE2AD3D05C
            3B3AF7D2F6A78E66B704F15ED7B32DA772CDFCB5CBABB9B5A84E2DE9631AC9A8
            68AF8D551775EE7637BEB6F39966AFC9D3869251FE40D52913BF750D93D1E96C
            80D23F6B2D92D14E74FAC97DFFB6B7FD2364FA8AE898823C2345AAAE9A78EB5D
            13BE111F20A3D1BFBA59D4FED1B9B75E3EF8443ED6C137AC8C7619E5BD887830
            46D891EFCB6E9532CAA25155B93232CACF7798FDC76BD17806354E995EF9A4C4
            F4C553AE6E484DB7BB3CEC61F17A93F7DF10A9F87C85417440347C36203ADCBA
            6347F3C61ED4E9ABC4E5F7AACAAB8082B2A45ECEEEFFBCDB9309BA64DD77F8EB
            E15943D2344FCA288F463D734C7CE2D5B36E19AFCDF63B9598C65B55F02880F2
            6C6FF6772DD064F7312496C5C4E3C293A2B18E9DC0A1DC0FC5CADB76F9D8F819
            74E0ED9DAF36E74E0DCBE16990430D07A1225F5C04D70487BDD2F83294A74669
            3498B838A9575427C68C4F4E6EAC5934B3625E95F0D90B8A8DDDC2A5A7F09F59
            D4BAC37DF7D94DBF6263735FE5FB693A55D74F5A73E3E43535682C774056F5C2
            6BACE0E369A3EE7D64E31B3B9E39973BE6905E4DD1ACA07CE5E45B574FF972AD
            18900EBCB102CFD3F4C043D9DF6DFFF7FDF98F3346BB4FD98BCD1F6E34CA9B92
            0ABB581670E92436D19AFBFDA5FF779C2F8505031F0FEED9829C43996DBFF8F8
            1FD2E61955C332AC8B2CE9FAC31EB97A63F257577C631A5A6AA10AA15E482E0D
            215A7072A2A12652A13B45BE9EB4A872A070DB16CA87F8CB1BCB253F761F7AE7
            D1C9379A9EDFDBBCC521EDAA49724EAE5A69B877EEE34BCA5719BC0ADE90F955
            AA9C1291B13356F3A87D0FD9F0D2D6DF77F8E7BDC1EE2B4D537D9BE8417C46C5
            C2C7167CBF924F9D1B7CBAA3301041722CC25374CFA363FFBEF1FF63AF19AC13
            CA13B68841E35568DCBD2B1E9B876EB0FA5785713CF678E12083CE7F70F2D5B7
            4FBC948FA5A36A9152EEF1CB8FD4191E1678714B0CEA1B2D997E7F49324AFC00
            8B696226A37B735B5FDB7EE5651445279DBDB3D99360B865336BE6AD6ABC4549
            C7552FC6468CA2D484A76223D9166310B05C2A41AAE75BF9A39DBBB6376DEAD6
            5A5CDD767DEE41A97838162467D62C583AE76AF616FD60C75B4DD903AE9A896E
            E8C81D5DC86861508F03F686C665B87C5AE59C0563AFAEB6C6724FC8802B14CF
            D616D1A81EF03C6C19CF32150D1DA9144299DEEAC4277E3EC87934D79A6B3E91
            DE7FB6F7448EF6066A491E62051995A74C5AA589642CB1CF3E7F1150E1B14678
            334F03233D492BCAEDDAEB677E69E5845B755226BA362AAA7CE4155418D73378
            7DB0F3EE739B7E639BDD52462DBBEAD6E90F5DDF706739AA2101AF441F28A379
            D4F95ECBB31F1C7E258DDA3CC551919AF2AB564EB8EDA669F7F0E65103128FA2
            DBD6EB45E77FF9E1BF1EF37665F44E8A1DD1BCA4A8AFFDC5C9A8B4055189A691
            D8ACB265DF5EF09F4C9E5E6E0CF2615133BE2FFDE1EFB7FE20133B8F55353206
            44FDBB780A988C4E88CDBE7FE96393D03C6E8F4095223F56E1098264C795709A
            50EC7441492FF01B2DB87F49FF011C56A4FB2C067750F69C777CFBC90F77777D
            9C26AD0A75D825F44990B4EB1E5AF437CB2B57B388090B1995BFDFE72685D915
            EA7CFDFCEFDF3BF48AA36706F5B1755D37A6C5752F3EAB7CC9D7177EBF1C8D11
            A59CB84F46A94C45638FBF772AD8CF64B4D338C90303E41326B75E7CBC31EDEE
            658FCE41D79A83346466810FBBD3EC7674E2DD23AF6E3EF79663F5CA487924CA
            A8AC25F1A58CAEBD6C32BA2FBFAD20A318F95752466593585F29536BE7542D5F
            39F3C6A01361CF646F448DB78EE353A2D2382F92D1706C1E564287DD657D3618
            E90C4EBFDFF44653E65060B8C8C0AE1798D8B25C6372D9CC6B66DC59A9D7B307
            E750DBBEF5A75FED56CECBA7A2782D425568A1FE32F0C5634A5102A5C6C4264E
            A99D5593189B34AA2C9C50456F4E45ACFB4ACF3495779AE4A7DDF779656497D3
            6AA37CB7DDDD9D6BEBCC9D677F3A24AB257416A20EAB89C85044FE405AA10DAF
            189F0AEFFD68E0C9C3D520F00936A965DA8929C9F9F72E593BC19C49F9BA93A6
            122594D1A2AC171BB533197D7623975116DDB06FB19C9A3573BEBBA28E0D2D53
            4AE4B019961544759D2C267AFAC8BF6D3BFDBE6FE402D5631B2FF3AAAF6BB86B
            D5D42F2751FDC0C4A3B04106CA77A1333F5BFF2F27E801C7EC62C1FF25C9A83C
            1B5C46E36AE56DF3EEBF2EB126C9A3D1414E7280DC0CEADED6B2E1953DBFB2E3
            5D840D2A44830334A48C26A7952DBA6FC16313D04C9DA48A53EEA5237228AABC
            07368AFC0D48F45A22144586B628BA45295FB613DE2B6E80722ECA9C454DC7D2
            07F61DFF44B60FE11DB4A817B09841D593F9FAB54BFFD3BCE472854F656A910F
            6C918C2A6A4E697FF2C80FB79D7997586E305857059E12A8C451465D38E6DA87
            1BBF17E7C3588C8B2C25E56C0B3B181FD987B33B7EB6E5BF6513E709F17C167F
            C474CD4D4C4FCDFFF2BC87A6A2C583CA28A581ADF49EA607DEDEF3E2BEEE2DB6
            990119BD42322A5B22070672B56B66DC78E3F8357607717A0253B7D85E799EB4
            FF10397A0A91BD5EFBAC4205B2D531521D3FD6BDEDE4C61DAD9B9D782EE7E575
            CBE42B308E5619D45DDF78DBD4D402D28B4D4D4BEB1DEF9C7EEE58EF3E167046
            26A7ECFC1A4AD88E94675F0798D89ECBC6447CA28B608369415E2D376A2BE2B5
            15B15A83FD0A9F29D054DCB762E00BD8FBDF21765BA639E3F7E6A8AD68EC7ECC
            11EC4A9736546A911CB9F05FB4BE485CBC540271DD55D1A79777DE61FFA2A91A
            3274DF6AD067DC37EFF109B13958B4BED0E52B49BD60CBD2EFFDB9F5BFB6E33D
            AE9A67321ACFD77D75E1F71756AFB2C4DA77B4BAC17FA1B0669F45AD4F1DF9D1
            CEF31B7C3DC7AB03142DE9D65CD770F74D53EEB250F5A0324A03E2ABB9343AFB
            CBCDFF72DC3FE0186951F7C96F06FCE765345A5E137B52B0DE48E2EABB163FBC
            DCBC25EE562AC620A6A822BFB5E3E3736FBF75E08F4E2CCD6554218517F9C0CF
            1B5E7256E58A7BE73D320ECDD04852C86868CA211CC795828C7A484E8CFAF239
            1273C18417CB89131B6559CA989530C1EA222D2D9D27DB7267B7357DC8FEEE1B
            79769F7881AFF31A4DE2FB3CEBB48E4CFDCECAFF3A16CF30519C977585B37BB2
            8248CE0CE00C3EFFF4F11FEF3ABF2187B3B2C4B9A05F3CE11FEBDC2D9726625E
            C59D4BEE5F9EBCDDE209E745BEF7B2A9A7E88DEDA33C8BD39FDCFD831EEB3CDB
            03DD303C25D0ECE49CCAABEE98FDC00434DB1CACAF3DE299BFDD47824FD6ED7C
            4E743DC88DDC41FD6896D1682E0907562C28BB67E5434BF455661077F2368BEA
            9824B1B762744CE17839102D10443D0FEFF429578E0D4B6701D4FEEE8D3B4F6D
            EEA11DBCF588A825643267E693CBEB6F9E577795E185EE4479ABF3EDA6E78EF7
            EE0F74CF451E1BE43295A943F5F3272F2A372B8E341D3ED973D433F28ECEE77D
            6820BA8AB28F712B3C16AD72CD2D7EEAFAE5FFC899B280A767F3FA631127FA85
            3EE3C53DEBFF0CB4B814554EEA93A26B1415F31536D597E720FECECE16091D29
            E5BCE1E4C4DC7B1ABFD560CD1C4C46C311A98DBA37743DF7C6F6A7FD78DEC6BC
            735F2257F78D6BFECF69160B462C61C351580CE4F3C05C2230E942A79F3DF893
            3D1D1FE5952C3B638666249C9A1BC6ADB969CABD1A3719B0A213553471C806B4
            B8B70335FDFCBD7F3A8B9B5C3D83847178F12DA8E0C1CE12D7594DC43B7C4A94
            DBFA89254A7E05CD89F72DFB7A23BACA7092AA6EF6158045EB392ECA75A3B3EB
            0E3FBB850F3FD3282A691F0A26A333130BEF5BF2D878344BA54999337BC10508
            BDE5832C65A29CA77CD280B780F6782365CF478E831CDBCBDA9E93CBB13F6DDB
            CEE5834C73C7999CDB9D75BAF94D624AD7473F6A16C0060998BF6FA9C2AED737
            16FEDD785E4D6F1455A0152E377B0CFC2C6EFDC3BE7FD9D5BED931F3BCFD9C2C
            170D5838C00201621931C5C338A34D4DCDB979C13D8D89A506AAE0033CE1A725
            B6223A4AF801D55C0765369C7A6DDD8927F3F10E9EC6271A14E876F992EA5BEE
            9AFD6825AA3306A90AE3BB61A3AE2DBD6FBEBCE5899CD925E6674796D368787F
            7F0164942736F26834AFDF3A77CDAD63EE2F47F53874AF098ABB25B33BC966A1
            9E9860E261082F57126D8BF9EABC76C8DEFEF2CEDFB67967145E564C7C3EF983
            59649470AA6F9DF1D0D4E41C3F233F4CF256F78633AF1DEEDAE569390FBBECC6
            8DB965D74DBE6949C37292C576E01CEF3A74F8FCFE36B7D9C70E1196E93EAF14
            E62B5878905CFD68DD5CFE1D17B988F5A5612172417D41E9328A2E2C8B969B8D
            7E517E63740FF0F513C79856B6F0D1A5DFAB4153F85C1B52E5EB270AF864DD37
            8B2BDBDE6F7EEAFDFDAF7A96EDB1309EE01A65F237AFF9CFE350A3C892513491
            7026E661A58CB2970C5F9A7876EF4F0E76EFB0958CA22A3A1B90BAB5D78F5F73
            E3E47B0C54365046C517B20B944DA353BF5EFFAF27C911DBE85184DB71713ABA
            A248F38BBE1C752A7C3BA58C8A5A752EA3812265343E3136EB2B4BBE3E052DD2
            FC94A2162F55156434D38A8EBFB8EBF7077A3EB6A322883F27A3F3998C8E45B3
            745456C857EF5B97A4B2ECDF39D6BE77CFD90FBBBC56CF70326EA6379BC9E7B3
            48133730EFC945F98D206E24596CCA462781F00A408A260BF6E40208097BE170
            4B8149F139DF58F41FC6A219BAB0B9B9F035199EC22C6EFBC3BE1F0819CD06AA
            ECE2C9FE8BE639BE665AD83353B4AC128DBD65F1DDF3534B757E2DE285025071
            6E35B91D769FE751FB5BC75EDC78E6955CACB3501A60D935578F5D73FB8C0793
            A85C1F581526323D6CDCB1A1F39537F63C63ABDDBEEAA29166351A1EEDA89651
            31C12773393564070BEAAEBA7FCE77EAD1648D1BBC2BFD2DF2443A8C28159473
            9A8A9C90628F47333AF1F2EEA7B8329A5939DA13D3055A1C251B1233AE9F7417
            1B66E240A458322D36BBB777BCBFBBF9E3BC9AA13A3F702D1BBB69FA3DF3EA97
            B85D8AA9193EE69368A7BA8F1F6B39702E7386C459D0CACB5D90B02C2C3E9D83
            9CFACB25A392A2609320545C6455D858D166A3A50C1A560D857EAC01CF405A3C
            FEDA3533BE91406359285A98BD2AC8A870ABF1585CF9C6F127769EDAE86859AA
            F23C84A965F3BFB6E03F56A006FE1451AA45311EAF75E4D67B2C58CF9EF0F63E
            B7F7272773FB3DC5653FD3B111F76AAE6FB8FBC6C977C750C5A032EAF38ED94C
            693A7EF3D18F8ED93B1CA387F62D72F60DEA95C8B0590EDEA54BB022CA2BB973
            128B4679A3799EED6432C92B5BF4C0826FF1DC0092E2F3967DD168F8179717BC
            1E78E2837F6F539BF837F244D0D05679D0A7850D5FA6A7E6DFB3E86B0D881B17
            14CBA8BCC681C8B7F55076C3D1D7DF39F29C9F4853F6C6A5D2068CE744F1E689
            E2448B571AC158CE9F0724F4EF97DF8B23A18F044E249D30197D6CD1DF09192D
            8A46A58B97F8984F5016B73C79E09FF6B46DF60D168DBAE242B2DD52756C59D8
            329CD4046BFE4D0BEF9A6C4EB7508A9B0C9042111B417D9D63D8D5B73BD0D997
            F73EB1AB6B3D7B3A7038D8A749AF7EF5E407574FB82BC69B380CB26AC78E25AB
            B4BF73FED90D875FCBE1347B3DC8499291A6A49FAD8CCA84A7BC72A564B43061
            C4C3441D2975DAA40797FDCD783433812A34622803BD3678813893482ADEA422
            B588FB4F773EB9E7277B5AB7E463595F71E4CFD9C7F4803DCF55D7CDBE6DA2D9
            683965D2468FC9996BF4EC4F7FB4F5D4C68CDAA1987C9E40CF27AF9A78DBC2F1
            2BF56C0ABB2AB7A8506D2519B4D9E78F751E3C7AF6808D7A3C610D55984D130C
            92DE703965944ABB3F398E4645DF458A365B7436095669C1B83E2C8A455C46E3
            F5DA84EB67DFB6B87A751C5523AA46D601B450442B7AFCBACDE8E82B077E7DB8
            63679EF6EAAAC6DDAF6B97DF3F9B5BE4A948E7CAD097C4C3E7551495D8A8F7B0
            B3E3F9DD3F69768F52954FB469588DBB35D74EE032CABE4E1F4446894799E072
            9FE6DF7FF4E3C3992DECD115AB3D17F42E0DE746A3F3C6BB75299AD4D0A87A82
            6BA89C5E67D7777ED5CA87E73D9E44E33494E075640364945DC4E3E8935FBDF1
            43A7BC93371D41419FD7E760A7DFF0AD69A9B9F72CFCDA7834DF4215C59160E1
            F28B29267B77C7A6570FFEB65339459153F00791EACFB3AC283BE32283823B75
            B19D179D5268D873217C432872868184013897D1798F2DFCBB3168BA21D33CC5
            448A3C41AAF88C9051168DFE90C928D1B3BECC00616F149440360F20E64F5CB9
            7CD26DE3B5A986E8D957F0A5150B6532100957FB02DE4AFAF8733B7F7D28B3DD
            D77B442A01771A4D05636F9FF9D835636EE75D0F0691513EFFDB8B5AD69DF9C3
            D693EFE4513797D1E8D84714F226E1FEEE7D32BA22C18D172E4946039F5B78B0
            90AE17B51F184132CA9F165DA5389BBC6EF29ADB273D1443551619C4E84CDEC3
            DC0D8CCB28BB68198ADD23FEAE273FFC313B10DE4C11CBDC43FEB26583B229B1
            39D737DE96F2AB684EC398AF6BB3DB94C9E819F7E0BBFB5EEFB5BAA8E9F1F424
            2731A362C9B5336E8DE72A698EE907767C8705AA948DCB342F6DB79F6C3DD8E6
            B69CEA3A41E281AF7B5EE0B1E11A4F75C24314D11675CD9365E49720A32A7BFA
            7C5DF1E543A760596210F697162DC22F68E12B17AC437B5A9E69AC1B8EED699A
            591D6BB879FEFDB3120BCA50A54A2F78188A9DCF3DDE68FEF0B3BB7E72A47BB7
            29CCF0E3A4ECFA9977DC3CF681141A239CAA50510D93B035E156A13DFB721F3E
            B1E547B6D9C9A78329B10C13F726D875BC65F23D7161C3115DBBC2DC28135BBE
            4AEE22FB143DF4C70D3F6DF74FB3F7168B30457164A49B45ED91C56B81693893
            7245F3B993978D6D26C414F9BCFB49406376E5929AD5F7CD7F2CC57303E2C567
            A638BF7597F3DE331B7EEDC4BA1C5EB9470AAD0F079A4323D158DBCA97DFB3E2
            EB2BCBEED2500A13358C5BC5EBA7689234E840A7DF3DFEC296D3EFE5D9C016E7
            E568498AA37C4871A8D6580CF1D99F2A2FB4E5B5673C3FDF410E3145D5AE221B
            3B0508AB0DE6AC6F2FFABFAAF9C82C86238B9C6219E54B4C28FD66D31F361D7C
            DDB378C293B8018C04AD9C39767EE3F8159352B32AB89F93C567B469741AB0B4
            9AD5909C18A732B1A377B7BFE989B7FF3D9F6CF7B51C960B7D546B88CFBA7BDE
            E353F5452677D11D585C4B7CE474A2B32FECFFE5DE96CD81992751B6C0889351
            B9284AD8A885A7DF3FB8FAF1926C9B8B65749FBD4D16835E391995BB2B13EBD9
            83E568B635B7FAEADBE63F300D2DB4C8202B83918C864DC4A8926F41279FD9F6
            9B23D91D8E9E0933F0A3436711CA750D77CCA95D8CF32A7114DE93564C3B797A
            AE2D68DA78E8AD16F58CA3E699BE2AB659674C5E32E19AD9E58B83340B1D303F
            51BA28F764B793EE1323DBE3B59E683F76B6F76C4BF6BC8F6D8FCFDA7A01CE23
            744113C4E268B44419D53D6B5C6C727DD978A6A079DBD5F5BEC9A9F0FA0E30E5
            520909F316A8168B2514454F25CB6BE2E367C49696F3D623BC5A4D268DC93C53
            254AD461A1A88DBAF6746F7E7EF7AF7256278FBB1D9A08AA6E9F7FDFB5D56C4C
            5723962630F72510B36F721F88EAF6A2AE75C79EDB74FA15DBEA0EDDA03D2F89
            6A968DB9F14B331E2847E3F5C83EF98225263E9C08845169EFD6D6F78FB4EDEE
            C975F4E43B6D9227BC285BE46229D2F090EF61D24C68AAC5CE80C1DE0E8AA626
            D196E31B3C23CF97FC98A652B5DCAFBB71F2BDAB1AD698A85A436671ED69717E
            EB47BDAFBDB2F549C7CA7AEC9E178D51F9684FC143C9A861A76E5D70DF0DB55F
            3151954EF8E28C4CBDA3A10087D791C9D0C1ECCEDD673F6ACE1D6DCFB6D89E8D
            35D5F5450B5B793B062470BDEACAEAC0253A36D9A0DB50D99F7A4CB3D81BAB07
            759FEC6862230011041051E24B2ABC866F2EFB4FECC20919D5A48C7A48FA7D8A
            B9EC80FAAADD4C0F7E74787D877316EB01DB9A85E2F3262FAED21BEAD0149D17
            3E0873FEC2C35348E693321AD5B039A87B9BF3F6331B7EE9C6BAD836C5222A0B
            FCB5C9A93977CFFBCE14759EF0761A28A3DC34BA05353DBFEF1707DBB652C311
            1929C5F7FF4841AEC114C96869EEF741E0629EC383B2A8638FBDF58ACB68217B
            893B8E983AC9A20AAFEEBA6977DCDAF060C121BCF8E37D7F15735F36EA78FAE0
            2F77B56DC92B5D3E760B793FF244C4F2555F6E7C78A231157B98DDB5AE1FC871
            53A0D979ADF3C3E3EF1DC9EFEBC1698C4DC5532D9A9C5D3DEF966977E31E8B45
            596CC4A4EAA6344527C853113B6F3E7772334853DB89B6DCF9D39DA7DAF2673D
            BDDB53F354CE5B16AD2C0F5F46C9859793FF6B3C5F71E3947B974EBC8E0DA93C
            BE477D8E56FD7C9694BEDFF2A3A50336B8E353842AB2746EA0C7D7D9C34694D1
            FAB248392D349070D3A865F3A937DF3FF9428FD6C6DB76BA7A32A8FAEA35DF58
            6ADEA4A34A915CC5577845CB224DAC14B333E9F4A08E27B6FDEC606EAB637487
            8B608A8F32C6346BDED7AFFD5E359AC16715C39D2C9651F9FF54248D9376D49C
            F55A7BEC2E3B70699F8C867FB2473A615530D1315443478A8EF43674EAA71FFC
            8F6CAC1DF3D458A6A466AD3AF9BEF96BE7585729A85C0B0CAA1637370EBF3787
            DADF6CF9FD07875EB7B5ACA2BB94F0C458993436A88CAA81C15B214DBAF1D6C9
            5F2F67611DB53095B3C984A0225B069EAEC05BEDB2C0BCC539DB9A3E9BEEEDE6
            734781231725F92B9F1F051E573F81BDDE4CFE3230D92841C7EC704C85FBB31C
            7E77DFABA7D2870391AB4B281B6CF9B1DE9A4717FEDDD2BA1BA3660A58941B89
            1D13DFCA6BFE143F47D37925D31BF4AA2A4E20CBE4FE09060B1E8537B3C61B2A
            4637A312B59F2222AAC55246F90042C9295D1FF6BCFCEAF6A76CB39B5D112637
            B23DCFF4CAA5F7CEFDCE386586E8C137C0AE9BCBA8730A1D7C71F7AF8E75EF26
            7A3EF288C154B92231D9907C5632DA8BDAF6391FBFBEEDF92EA5E54AAFD417F6
            5CA13E4ED1B259158B1F9DF3B7717E908622EE834280C96BD8B1B0D0E4FD7FB2
            4773BB7FBEF19FBDF25E27B029164F38E2770EBBC1546AB211FA034BBE53ED8D
            091C5713558C32C185CFE098B96DA737ED4A6FEE543A78153FD34C459F109B74
            F3B4FB2A83314C55D9A31B883C149FCF4AB1B1A617B72CE2F91EF6EAEA6B1DEE
            E3D075ACF5C089F63D1DF9F33D992E3E2326929C884CD256A4651F375E0CBDE1
            1029AE691978268ADCA77C5172AA26B2755F5BF0FDC5D53778BC1B1D1173FC58
            09BDC7E5FB27CCA02FDA881B7E037FA560A9A7725984CFCA15F5B3E6A5588A28
            2DE4F6918ACB6BBA9BD6ED7B767FFAC3ACDEED7B9EE65B654EED376FF9EB99CA
            328356044A918CCAD5641AE4D50C1B29FF7ECFCFF6776F738D1EE1F9E2B38857
            F3CCB85DFDC88DDF6DC4D75AA82A5CCE521484FAD6670A15FD814A5426DAA847
            4CF7F5CDFFCAE75F1CA926FAAD63554C46333139E6EFF9D9A6FF9636CE6B1A6F
            078B95D8046BC69A398F359ACB1189616285895C61B92BCF4765D7248B5A9F3F
            F5B3ADA7DEF3B0C3623712E485793B1E5A46352348CCAD5B71E7AC6F54A18926
            372DC685A283287142D4A3638D706B3C3636C9447B1E88639109FB489E67597B
            A4F11ECB61D1BD27DA96B4A3136F1E7C765FDBC78ED6A3898B14102FE9D63F30
            F77BCB6B6E52510247F39272325EFC329769F62C6B7C3017886904AC87579C86
            66B28ADC3F1A657A5031D98449542A2BE5988D3CB2A87D7DE70B6FEE7E8E5D44
            392D8645555863F5F27BF992EFD4BEA4FD6231E1F3E9D9E374DF0BBB7E752AB3
            8FAA1E8AC682E1618F18A48C627A997A31B15B5FB4D0A079D4BEDFDEF4C6B667
            998ED84AF6CA3A3CF50D3BF84DAD552BE3574DBCEB8671772A28C9EE5D226C40
            E4949F4F88AE32990C14C53D830EBDBEE399FD3D5B73662634DC952B062A5FAC
            B4487CC9C4EB16A4AE4B389581EBAB9A1E2D038B144E35389ADEBDFEFC4BDDB8
            9569257BB318944F022C18B36AC594555ADEF47B03CC7F05CBE6652A2F640ECF
            772A994AA52A0D14B351DE45993672E6C39D1FB467CFE6B59E1CE961E3FD9CEF
            78987B006BB8B0DC4C22571EB570912E3C037D99E71479BC6E0BE32AA7E1BB2B
            FE9F19E642B1087041B8AA2065A87359B80F6864438289505E8A0A6D758B4DF5
            D94348B1E2A09EF59DAFBCB7EF95ACD2E66BB6476C8B9695DBE31EBBE9AF6728
            0B3552265B01F30670E1C090B797C86ABDE7D1D1E777FEFE5876AFAFE5648999
            CA4DB1310B09978DBFF1DEC9DF4B78B59AA2870B0FAA747F9105CE3228C6A2DB
            A5CC18E5516E7490240AA3A4D2A9512ABBCB1EDDDDDD1B9FDEF9B38CD146FC80
            0DF659E435DE9CFED0D2EF4E501AB9E8105D2914B90A7C7E3EDD4E74F2E553BF
            DD7A663D974D1C50E2F63B1BFDE06517444FD8B537CF7964C5D89B759430505C
            417D6D4BC4AEFAD1AB81FF5B20667868986010259C896BA10C68E62252F6D973
            E7F6A2E6F78EBEBAE9ECBA9CDE61683A77C00B82985DF5E5E90F5FD3F0A5381A
            A3524D6A621035A31635A844BC02A58FB49C8615D64DB279280D5FA011349A7D
            D248C19D5CEC82CCD078A7E9992D27DF257A968F0FF8460CD54F5E3BF5F63BC7
            7F2D89EA143448D988984FCF7E787EDD6B877E9F315AC5EC2BC1C2725054FF8D
            20771211D970E775694DF2F0EAB5B3CD65A912FAD4F3978F8B021B751DB4378C
            28192D849C86979C9698F7D5256B2BD1140325655F72B5484689B09DDED8F6EA
            5B7B5ECE585D599456347E9955B976CD46501E4EA2CAABA7DD32CD5862DA2931
            16538A649447B51DCA99D70EFD26136B73782F19A2535FF3E2B5E67436889E1C
            9BA9BB56E053793710E166AA84FD8070C22A2B2FAB4DE8E52E0F25B8F7701E75
            792873969E68CB9CDB7B6C4F47A6CDD16D76565DD21B10DE24AE2FC3F482D496
            E23310CA282F3140AEC29F7294E8AEFFAF5FFA011B52890B7AC1D5512EA2D9CD
            050E5854915D3069B88613E627F269386EE1E6B7A3D32F1EFDE5FED66D1ECDF2
            EC3F1CC449E5043CEFC115DF1E8BA6694112890EE90891BED9091F3B5AFA28DA
            F1D2CE274EE78E30F195F9B32220E563D809B1D95F9DF7BD69EA7C766A75C514
            FB4D8A6CFAC2873C10FF90B1B24A8BC298E2F95FBE9C2527F5EC1CEAFCB0F9ED
            370E3D95B7BA5928CAC6C58692989C9CFDC8A2BFAA4613D8EB0D0DF019F1159F
            28F973E8E8B3877E7EA87367640A450A1EB583C2B353F930B0726ED5CADBE67F
            A50E4DD478F30FF342192DAC898511FA806B14259F15BDBB0AE9C03E0F087C07
            756D38F3A7B78EFFB1079FD7752EA32C2C4F049533638B6F9AB9665A7299CC76
            9095522894D1705641BE5D70784DB5C269437DD96C6E06F1ECAE949210B1AA56
            74FBF10C0D17391DA8E98D634FEE39F7215173A272849D184BF7CA56CF5A735B
            FD8371543BE8F909F87C7AE7FAD32FBF73E2999CD915502594519E9CA78D4019
            E5DDC2A395FAB94669322AD6D7020775EFCD6E5CB7FDD90EA5258F7B305F841C
            2932AA12A31CD72C6E587547C32326AAC0C24C410DCD1DB0285CB34FB87B9FDD
            FEB366FF789E66715CF588277E313A045BA93526DC38EFCE3A6FAA6627F1807A
            1816AFDAB1AE75879E6A214DDCA24D745264DFCBD4636272F69D73EEC7BD16E1
            B623E281A47C55BA20A33AB62A2BEB53561597753F50F9308C3D09190319BDA8
            9BF2CED59D4DCEC15D4D9B0FB57E1218792FF4FAC10507A941CF814CA11517CF
            2341A02AB1AAFC84FF72D33F56D006B1D8428BAFE93065141572122367C2C2C0
            9C7AAA93479D9BDBFEB4F1E8ABDDF4BCCBCE065F5F50626EE5E2DA5BEF687CA4
            8A4543418CDF535151791879F14AA4F47EF4C12BDB9E3CEF9EF13537B2EFF355
            3115C8A2FB95136FB979CA1ADE5294A6C23359D8F1D077BD10B5112487CC7D32
            1AFDA914D697D928D84EA396370FBFF851EB1B39DCA92243F570022767552F7A
            74CEDF88B849171E4C589C33B15D4A08E66E5227FD7DBFDBF6CF6DCA69BE3846
            3CD1BD7288DE39113EA12649542B6357CFBD6349F9EA4A6E5DCC6E093D3A9BA8
            38FC4772381D55D217263150F8D228DC841718EC10C5F7516E7BF7FB2FEFFD45
            173EC31F76425455652FF578BE66F5ECBB5637DC1D9759AB0A3B7C4C0B324A0B
            B5007EB43F9A88F2699853C18E9AE6F24AF79ED66D6D6D1D77CE7D48744BC57D
            06892213C8E68DC24EBCB4FFE7C7BA76BA6AB8DAAE0696992FFFF2A2876EA8FA
            B2C92DF2066F1E93456DEB8E3EFD71F3EB8ED5EB0572C426CA614764347A3965
            544E90E751FA4066D36B4C46B5B339EE377AA5DDEF8B64943BBAE3587930E69B
            D7FC877A34C514A9BFDCC3933DA52A8B0DD983D4F6CEB1973736BD422BECBCEF
            AABAEE7AB67C24643508CA6A63CD29B72FBD2F9EAD35DCE440D1614F9963746F
            3AFDC6A1AE5D393DCB467C2A0DDFE795DA9865F5ABA6A41A59FC1FF6551602A7
            C81E37A2596675E5D832F670A1A25A9928B872858B6D0B3AF1CEF1E7F6346FCA
            D06EA41B724081E558E753CE83B878864AF3593B69544EB3167E63D1DF579626
            A332E1BB5F5E54B415DE63B9177534D1836C5CD29C3F12983997F0953AE20509
            A7F286290FDE34EDFE7254A705FA0019E57D930235BDC35BF7EA8E3F74F8E77D
            CD2FB8A062CA3DE1D9B83EEE96DFBEECAB8B53AB936102A916E67F17F966F797
            D1C2E92CB24395D91C62EAD7EE40675EDCFDE4FE9ECD59A54367778AA724D5D4
            FCBAAB1E98F1BD048F9BB0EFBA322B23B2986151251B7EF51CB177FD72E33FD8
            A92E22D2E379787D616AEAC0DB92C9A886CC8412AFA463EE5CF8C0F4D8C2329E
            B4A047CD35FBFDA29C4821FDE6825128A3A8584951C1ED90FB1CBA7BDC8F9EDD
            FA431615129EB2E25BBA11E4B1452B168EBDFA2BB3D6265095387B467F194517
            348691A3F540EE03B229CAE750EFBB075EDF7274FDCCC9731F9AFFD716AAE99B
            9896BF82498E278D1E7D76F78F4EE6F6FB3CE9953F473A13F15CF53D573DBA32
            F52543186F0FC443DC15E1E583BFDBD1FA0189DBAE2F12C8A286D817FDF47F1E
            7C16328A84974FEFAEF60DEF1F78AD4D3D95C15D01BA9283FA81B0C3C34E7C82
            35EBB1ABBE57CB87F671617CCF64C8CCA3D61D994DAF6CFD43566B75F59C2F53
            E242CF1B3E3BCEE2112D6BCEAB5DB664F2F556BE92DD10034547C37A867636D9
            BB371D7B3B1BE3B97EE1008C3D589E596F4D5A35F78E2ABB5EB54D4DD438B3F7
            BCA2A851475F2D19AFAAAF6EC07D2525726187AF03706327D4BCF9EC8BEB0FBE
            4EE2BDB6C2EE66EED0A34A3F4AF50245EBBB68612D20128B3E1E7B6D587E624E
            E5CA87E6FC6D0A8D918E66C392512A10F6A772862CDC53D7F70C8DDB76B087CD
            47590F75307159B7EBA55399E38AE9122D70E599F46D26A3374F7F74D5E47B93
            A8562D1A06A2C2434259D0DFB9BEF39977F7BF98C6DDFD645491D1AE47CAF098
            55B3EFBAA6FA369EB51A58AACAC27C64933CD6151E4B866B5C1445EDD7FBEEE2
            A26351025152A15247C9B6A2534F6DF9F9696F9FABA5F977F92ACEE0D58D6BEE
            9EF81D83372C098D93A31137929A95475DFB7B3FFADDB61F6463ED7C3988A315
            1F94DCF3E27328EAEBC48B8D52CDB76ACDC9372FB86B81B1228E6A7CA26A0A37
            BEE119F5980D48FA7675C035C2F235A68AADBB011F36E92A9F83F23DD7544D87
            E45D8DBD1B4EAE3BF9BB9DA737229DB7CFE2B3C94443D4B09C8A9B67DE73DDF8
            DB75526EE2942C7F52655D7C918CF2AF0E780A2D4FA9E507DBABA17C1B3AFECA
            9EE79BBA4EB098745A59E33717FF5D9CD422B1E85F70EDF3B8216F6E5BDB3B2F
            EFFD4936DE2E0A4CC4ADEC2627E88D5F5EFA70A3B6C242091AF5892CC6C63D67
            D181B70F3DBFAB65B36FD93C758C86B657236A7D097D6632CA33DD4E93439B8E
            BFF5E1C9373DB31769CA883A7276A31B4ABC4CA9BD79DE9A95C93B92FC2DAA04
            84172377D0D3EB8E3FBDEDE407D4F20336AAC6A4D01744268DAAD434EDF2A563
            AF9F3376A9914BB247B79FE888E6C18A5E46D3D6F9A7DEFB6536D9E6AA5924C5
            86784C85D91876526AC63D8B1E0CDA548DEAD46567DB1073970365544E4BF137
            B0276CDE72A8FB50EFF697B6FCC24D74D84A4FCE75543D214351BE796D90D31C
            A65D2B614F2AEA070632E37ED9D553BE74DB844793A81EF51FA15F948C167D92
            DDDA811FAE83AB14F93A52D988AC0B9D3DDCBD75C3AE37BBB5AE3CCE10EAF250
            0849E92529AFFACEB9DF5C5675231B098AE02B5C9128CAE5C219D4FAEEF93F7E
            D4F44E9A76056A7F19E5A94B1AD269DCCC572F6CB8E6C6A9B756A3313A5F77D6
            49B87ECDE4440DFAD257FB3C9D6458C7A71A793A0115B9DFEC81B7F3A8BB1935
            FDF0B5FF4E2A73D4CA13DF632306CDB1AE997AEB3D13BF8D51B9B056625FABE2
            68319D7D9DCDFB3E393BD3EBFFB0E3C739AB9DBF92F9B262F1146A5F6158D18F
            C46412E59E34BCF6D4B56AF4B137CCFCD2DCAA6555683CE269249AC904877A5C
            D7C232E13E0FBAA2B9516E36C26F2DDE72546183688DEBA0C2860284DD357CA1
            BCE718D9F7CE9EE7CEA40FA9315E97C5A7EB650D85971CAF4DBD7DD9FDB3B4E5
            38BC0A9A4893C2918C12D1229B2F4205C873513E86E2EDE85C536ED7FABD6F1E
            CD1C2296AF07786ECD92C766FFEFEC051076339599BFFCC6755D94D9D9B3FE99
            EDFF6A27D2282A99B3DCE482BA6BD6CC7CB89CD701B34B36884F8C8DBA8FA39D
            EB763DD3943994A5DD96667D7164346CC71428D94E747A4BCBFBAF7CF2042DB3
            C3C6B1230691D7A8B227A40637DCBBE45BD3E20BCB5135EF488F725BCEBFF3FA
            BEDFF498ED44A581E85840FAD22C88C8D530CA49DDF553EF98149F89F2268E8A
            4A0B2F0A9EF7A0C62AEAE2819279E2939F1FC9ED748D8C88764516A2C8A952F3
            B1C6F205D7CDBA9505658A6D12F6BC0F26A3E142AD98F26383E11C4A77A0632F
            6FFDDDB1DEBD4ADCCDB93D8665FA61B6091689E514A1FEA66C7D322AEB91998C
            122B45AAD62C7F64698CB7AFE8178AA28B1ED40BF8F9E1BDA645160E532207F5
            B278F958EB81A3E7769FCD1ECFFABDC8D4B8FF2E5FC925D20E8EA98C6557FCD5
            0D7F3F114DE38D51A5D7AF38C7245C89E616407994FEEDDE1F9ECC1DCC921E69
            DD22762E8A4679AB1087FAD840656C4C30B162F2CA39D74DB4669773BB2016B9
            EB423D555EE32F2C508BEA3691D06B479E5E9FA76AD03CCAB020AB07B57F78F6
            836DC737DB6AC6535CCBD0FC5C50A9D7AF9A7BFBAAD41A8527D8F2AE1D524665
            8E042F38E0129C7DFFEC2BEF1F7F396F748BAE1E050D2D9AE7542E3479134D9B
            0BD748FA2506396D72CDCC3963964EAB6F1C8B262A22491385C22D7231A3A5A4
            A20A319E072A92D50387BD67F9B897BD0FF2BDA8AB276839D0B4E75CBA3913A4
            7B9D168F66781345DE465BD898534D0B34C3372A94BA85E357DE30E536511ACF
            DF6A0A0FE445551B72A94865F1795574AE07B51CCBEEDB756CCBD9AE638E9ACF
            E0AC1ED3F53C9A513EF7E1B9DFB350855CB02B1A5CB86C97B6776D7C7DEF9359
            B553C7967C8E4CCFBA61FA6DD78FF9528CCFC6A454B1BEDFEF06F350CF11B4ED
            F5ADCF343BA7158B5D2551575764A63372F8EC64B4F70C39FAC9B90DEF1E7C01
            95BB0E1BCC5DE9432D46D60FF11153CE9A59B664CDF2871B94D96C6879161DF9
            D3AEE70F746C728C1E4533A296A2243A5922200CF45ADCF0A5595FADC11382BC
            A8C71820A315F1EAF28A9487321F76BCF3A7C3CFF5E2362AFCECD9C0C4F33D2D
            C68646462C5371F5F455B32A171A4E2AF0D9508837C5E5194B44495995F535BC
            CC3C4A4161FAE767512E8B3ADE3CF1D4C747DEA571CF575DBE8EA172C331E105
            5D48C51FC4DB523AEFF5C9288A2569F9C3D73E3E092DE6ED2B06BCE306243C0D
            72D78A44451684B261A49341BD01F23BF2AD279B8F77E4CF67DCB6AEDCF95EB7
            DDD1F28ACE821F952BA75CB90E37A7E96E6CF1B895C9A09C7834AA8C0A7752E6
            15109FBA7AF640D72719DC49D5A0A88220ACA4E219FAA25893DD5C3C058AEA55
            665DA536BECAA89F3EBEB1A6ACAE5CAF62A38824F70396D9DD322B96B72965B2
            D0833A231975771EDF99F5D2BDB9AE5EBFB39534F792B48B5C265DC4774DC58A
            2B1513CAA6552BE391AB73EB3C1AA862314F582F20ACABDC8F8666CE741D6921
            273D3DCB150A173C063F4D4679BA1A954D59F89B4478349198924A91EA1A6B4C
            45BCBE3A3566FA84D91562328129A93816DCEF1AB193D0EE351B3A1BF2E4CE77
            361F3F7B94A88143DDACD7D9963DD3EB77B3178AE3E708F17593BD7B7CC7B3B5
            98297647B832B2BB2EAF94A3DAC6318B1AC72DAE4D8EAB52C788F9105DBCD5B8
            8C76A3CED3EDA74FB41E6BCD9D6D779ABA9CF3BCA644F36DEAB2F3905062D5B8
            766AF96226227DB7100DDDBED98DDA9E3F773CBFC755F32C7041A21686DDFF93
            1253C7C41BCCA08CF8861FF9DD141368B9343977B6F7782FEA36E39A97F7BE38
            321A1E9E8BD2C783BD3BCE6DDA74645D10CB054A30D264944551011F36EBE5B4
            7C526ACEDD0BBEA9A3D8875D7F5ABF679DAFE789E2849937511A63947AC265B4
            1E4FBE67EE6349B7D617CBE4727D9C3F578AC89D42FAF8FA2926327D943FE8EC
            F8C547FFDCA59E8BC734E2052CE2F00893319EF9A8DAC63863E2A2714B67D6CE
            A799B8E2198ACA4D7B68E0C7CDB2FAEA89A61297E9CD9A700FEA45E7DF3BFEF2
            47A7DECD189D24B2A3EF776186BABDC2C8226AA9C213DCB0D9503D7542D92C16
            C70DFCFC80EB2BB3FD45EC1975FB9136D241C02250A7CB6BCF07193B6F3BBE2D
            5DDF797F766EB3E2D3C1F74DDAE158A228B0FF21C847857D20C07EA0D9C277FD
            CF3C3672C8ABB1AD11430D8C72BD32A6C563B198A95BF158B2C8F15E2D285A4F
            4F774002262EDC33A5FB1CFF161E29FB81CA2773646AADEC02C0FBD9F1368886
            98494005419733E6726F459F15D7637BCBF3B1643AED252E83F033434CEE3CCB
            33ABB4B278B5A55BB15822A65929AD0CCB7E0482C00F6CCF0D88CD067F4C2873
            4E8EFDAB6DE7E4629D741A150D10FBAE1A95AD9E5531C31376C915FD447D3638
            B32AB4DAA451515656C1BECED02D766D5DCF7603BBA3B3995D5FB6FD7C9063F1
            2C951757091B38EB54C57C6C67C98CA8E828A24BC9CB4B7C5FB5A58DACBCC4BC
            E6819F525E128AA836446A2D0958AC805DE98410D5767CDA7D7EA5F82C9798D2
            9BB69EFAE050E727BE9195DE4557FA6043C495E5DD845824C32EB6893535135B
            39E38EE9131A5FDFFBF4E9AEE386A9851367A8DF7C56188DD66953EE9BF3582C
            5F2B2DCB447F0F22DADBA264ACBC3C5965E809BEE68E692F6AFDD127FFBD29BB
            97225ED3C20635ECFEF334BE64A4BAAA1524C69B1366D72F9A5EBB00E5629E8B
            74CDA22C1ED11363998CAA2961F0485854EBA08EADCD7FDA7CE4ADE6E0344D10
            3A4CD34555342B0B9B9A70DF0BCAF69BC9BDE6C5311DA4DBDA60D797A00BA744
            C395623ECFC6E58346B6115191E5955B4B2548F74D2CFB655E383BA1E0A27C71
            710EA53FB7AF7BFDEE4F3E0BA7E0E13EAE5CB3F8A44509325AD88DD08D90FD4F
            976677E2C5A3F1864D0A3FC92AE64B2E1E4F14F014D551344AC3B6A0C26BE642
            6192E6B0B490B1270B8C8A0B2E786B518DF768201A2FCA12F07C353628A01E7B
            8DF054E328B998E79B15392D7153C38BBD21715F603ECC5EF35F5019FDB8E59D
            F70FBCDEA59F7170CFC891D1B059A190514A4D5136C3D72ECAF43AD34874DB9D
            ECDDAB6AAAD0D0BE1D162D1B899451E2E2F1B199F7CE59ABF7CAD6BE6C8827DA
            88052866945594D5969B55A2C103BF4D72A8EBEDF6E7D71F7E3D1774A806DF6A
            144822A66406328DC0ACD2EA174DBC6E4C62B24992D8E70DF2E25A624C6D83A5
            A63052F3A8A707B5ED3CFFC196A6375AFD938EC686C872657938478DFB926394
            503E8898C3129D47075EC5E2EB5B74BBE3488608E99B4E65018ECCBA8F16EEAF
            30E23D1126A50F282B28F225904372313B39D2464B453BAC8655E4BC148BAA7D
            DDA1B98C2269C3C5DF89012F2D88FEEBC0C7537A7615EB60DF7FBAA02F5E64AA
            106D8A7B6AF16E3141747D95C1BC1DBEE87C8632FA61F39BEFEE7B2D1B6FC92B
            E99123A328CCEE116D6C79E738F666B74571BAC68DCE29EF8074E1B184A749E4
            FB8A3C4147999068BC6FEEB750678CAF0CD1401A43505FABAF1E5F16AF13AB89
            4C2255B148DAB9A3E783B776BFD083CFE7505ADEBED2F04D11CF066F4CEFC7AB
            B5864553564CAE6E5472A6E65849B57C4C4D8389633ECF40EEDCD2FCFE47C7DE
            6CA74DBE95932BA12418E62147322ABF513E4E54C6CF8351145C1486C37D31A6
            8C3EE42D2092601436FA63C36306FBB9699A57F6FAF2075F3851619E248F6951
            EB90820414DC5E54E1B92AF7FCCAEEF690C722AEB5AAE2F0E4F7F93F84B12797
            3C316C17332EBCC3C7C057E3C5C828E2FDBA7536180A7C76FE026E2C1109A794
            EF42AB88BED378A5CFCF08A19F8C3EB2AAB4625012B5A36032BAA36BC39BBB5E
            4C1B6773A89B7C6A55DCE77FCC8583C151426F58BC5844549F2E7F8514649445
            A30DF1D90F2EFA5FBC569E60C2572C783F259DC58FA69A34F4329587B87C2A4A
            E5D927D91C6AFBDD967F6FB277E78D341F4C2B24724A165B13BED966104BA1AA
            59F5F3E68C5B16CFD7985EC5C43153A9F0ACDD74E64F5B9BD677FACDD4E26EA7
            B2922A40C34B201B3898EDFB4F837D9E9281B3AEF29C0C724F0C98D81A2117FA
            E2E3E211B2C38330209AD68A0E6DF0DD5684E1D3C09F07433DB317345629BA4F
            0A4D62FAF58828DEBD2B7D7E4608A1931CEDABA99F6B4A6B12FD92DCEF0793D1
            2CEDE281D74892D1681123EA75217E5EEC3E870A321A2D1F87CEE194479DE363
            33988C066DAA6CD6A421AB2C515D91ACD19089314F92977E94BC579D6207A8F7
            EDA697369D7BBD833453753019A5C8500D92A3B12035363EE5C6C57757E2B129
            AD8285A2AFEC79FA58E7BE5E749E9ABE6C1BC91D3F11F1147A596474A8A98161
            C928EAAFA423E1420F776E6124ECF3E0D0B0D25D2681697FF6D0862A08BE0419
            1D74AC02323A9042EB4CDD8B9BB98A87573D3EDA6574E06E501C955F87E722EA
            60A3164254E9772BF36CA88FB98C2EFC2E695351E01A9A519E1A5796A8E2F6B7
            54F4F6E539A2061F6DF15425CF41E963F9DDCFEEF9451B3DED1247E64EA26871
            59BA2EF1CECB18798E6F2AF14A63DCAAE5B72087BEBFF9FDB4D693A3DDAAC92D
            74B168EB18EE321D5E55D8D0D1E810B248076E3C1C425EE9EB77D1877CD19F1C
            B95A10D921160C4A14C550FEDCCACC20237AB91CF4E9B3164A5F9D7E785A06AB
            2C92DFF01770EA3E5FA246EE051965D168094D4484392215329ADED9B5F1CDDD
            2FA67526A3E99123A34A51FF4B1A85E2D1CF43E46A6061761F4531A34C7F2996
            511CD0AAF29AF2543D6F5023973FA9C7E7FC151938882C7F6114F6CB1DFF7C32
            B7DF556CD9BE1C5D28A3220BC90F44333D1CC4E26652479AE3DB692F87D44057
            C5EEF1BC102C355F21575446077B155DE1EBDAEF7887F9F9112A070364541883
            828C8E380693D14B6D69276A7B65791CB251E7CEEEF56FEE7E29ADB58C281915
            BB5FB4278335348E8AED8AE746C3BE987C7987A8136333BE3A6F2D39AF5526EA
            CA5355861EE773C95129312AB46816E91D94380EEE7AEBDCB31F9D782F83DA3D
            351F7E263C957D03FC280B04A3B0B90E77600B2F13955926D1422A1DDEC92C96
            D18B6164AEB77CFE943280BD6C83DFA16ED721BE4BCA28B9E80B5E543B1F7281
            A994FC5AB81F3E95CB2FA37CE59A45A34AF7AEEE0F848CB68D381945D1AD39F0
            A62CFAF9057D3785B4693C8D13BB0E99189FF1D0E26F277235D5C9F171B54CBE
            B9439F3DE9692B4A4803D97F983F45D91368E72B3BFF703CB3D7D5B2E1E91AEA
            9214DDD0C55161F1801A0FF3AE0619BD3446908C7E6ABCFF19C968D12EC0FDF0
            6984DD7C0B4B4C7D73A3A35B462F823EE9A16118C85336090E5C3A3135EBAF96
            FEE718AA5668DC52522244E57397E2C3DCC824C0A299BD7454767D6AD83EEA7E
            7ADF2F76757C9033D2E15687BA2420A323861121A3C3FCAE81325AB07D1E1490
            D1D2E92FA33C6F74C56590D13C93D1F4076FEDE232DA8BD2E88AFA8D5E1A05E9
            916E0B221A25A28FB9568E6A574EBE79CEB865062D4FE032935B3928589847E0
            A8172989E658756E3264DBA8FBA3EEB7DFD8F564CEEC92852E20A3231F90D170
            FB703F7C2A0519952DED1E5ABD768E59B28CB2B3EE202EA32C1AED51FFB26594
            140DA9C25E46016F46160B92D5F13155C9FA84595599A84A99A9949EAC4BD6A7
            5019E161295F0A08F8821B21DC77271FA0ECBECCD66D27DFEB725BEC7C9E2730
            0F216DC5A769A8A5BCFEA97C224F9A0443F7AB18A68C0E97D12ABB20A3E1F647
            E9F5BD5C846E15041B1E4FBF7FE0C6C7E79438A80F108F460B32DA2D06F57FF1
            328AA20953C2E740793318A42A4453A989A9C64DEC03B5CC2AAB4A5597C72A30
            310C9CE06755F4FCC4BAD29DEBB249AEA5E764DA6F0E54AEA1EC5E1F6AF66AB8
            32CACEBAA6EBBEE761551D4ACE40462F0D90D170FBA3F4FA5E2E64118D303D08
            8B411BAD12E746F915E132BA33FDFE2890512487E7E2AFAAB0FAD5B8959B7421
            52851E8A357A4283B023226F69A932ED1466427C895F575CD755A4239AE64B19
            46B20A60B0D3385C1965FB99C9640CC3D05475A8BC4E90D14B036434DCFE28BD
            BE970B90D121194C46096F882C06EABCC524D3504D5804F9222D492BF2D39593
            00F2D779D4AA07AEEFFBC4140D3664AB86CB38A8370CBD50D2FEE9C7F2190132
            7A797FB794FD0419FDFCB99C328A44FA3DD388D121A3171C57D4140F2AE10000
            E807C828000040495C7E198D06F5E91DE9774146010018F55C4E198D9A917119
            CD3319ED79F7ED5D20A300008C720693D14BB5261928A3326F3443D30AC82800
            00A314E9B9A144E9F70FAE7EBC3126A3D1E1DB360F2AA32C1ACD119051000046
            2D424671918CAE051905000018060519D5BDB895AB78685509328A2E5C62DA0E
            320A00C01780CB2CA391BFAC8846D3EFAEDB03320A00C028E7B39551198DC212
            130000A318D9D28E29A9E1828C0200000C9F828CEA05A33C0B64140000E0A2F9
            AC64D446E94F40460100F80230749F7A90510000808B0064140000A024404601
            00004A0264140000A02440460100004A0264140000A02440460100004A026414
            0000A02478975F85CBA8266C9B1F59B576B6B92CC56554BF94262220A300007C
            D11032CAFE89354FBADF3F3ED70019050000B868082694CB654146D7CE3556A4
            2EAD8988DC20C82800005F28069351198D828C0200005C0420A3000000252164
            147119959D41573D0E320A0000300CFACB288B46F51520A3000000170BC82800
            004049C0A01E0000A0246089090000A02440460100004A0264140000A0244046
            0100004A0264140000A02440460100004AA29F8C0AA33CB026010000B868846D
            3303EB5EDCCC553CBCEA71B06D0600001806E07E0F0000501220A300000025F1
            39C928550797513CD466000000FE420019050000280990510000809200190500
            002889828C9A1E97D18756AF9D63818C0200005C34524631C5861BB772150F80
            8C0200000C0B26A34C4315CAD3EF998C3EB46A6D630C64140000E0A201190500
            002889CF494621FD1E0080D10AC82800004049808C0200009404C82800004049
            808C0200009444414665FAFD83AB0B32AA836D330000C09F47C8282A92D1C741
            460100008601C1FCFF1451532F7B31355A2B12D044040000E022194C4665347A
            596514D2EF010018AD808C02000094041351F6275352236CB0FC38C8280000C0
            3028C8A8F41BE54679E60A90510000808B0564140000A024A48CF6B9DFF7F5A9
            0719050000B808B88C522697BC8AC9CC31195D0B320A0000300C40460100004A
            E273925148BF070060B402320A0000501220A30000002501320A0000501283C9
            2858930000005C34444154B4AAD74431E823AB1E9F6D2E4B816D330000C04522
            6414B380548BAC49E61A20A3000000170DC828000040497C4E320AE9F700008C
            5640460100004A0264140000A02440460100004AA29F8C3EB26AED6792F00432
            0A00C0688588A4D13EBFD1D5852A2690510000808B0064140000A02440460100
            004AE273925148BF070060B402320A0000501220A30000002501320A00005012
            FD64F491556BE75820A3000000C323B26D96554CD6B224AA51900EB6CD000000
            174F188D3EB4EA719051000080E1A0444D44FC281A3557245195024D44000000
            2E8A41645446A397554621FD1E0080510BC828000040492842DC6841461F0719
            050000180EFD6554CE8D828C0200005C2420A30000002501837A00008092187C
            89A94EC8E8D0BF04320A00001002320A000050129F8F8C42FA3D0000A3169051
            000080920019050000280990510000809218DC9AA4066414000060580C34CA03
            19050000B85806B56D0619050000B858C0FD1E0000A0243E7B1985F47B000046
            3520A3000000252157EAADCFB01713C8280000A39A2219ED4B78BAAC0D964146
            010018ED0CCC1B0519050000B818864CBF87413D0000C0C500320A0000501217
            C8689990D19520A3000000170DC8280000404984BD980C9E379A4B424B3B0000
            806102320A00005012FD65F41BD1A0BE6419DDD6FDCEDB7B5E6632DA4BBA90A6
            808C0200300A51A4E8E1CF4A46DFF8E4F95C3CDDE5B5A9860A320A00C0284421
            BE636BBAA1E098621B4636F1C0F55F9F97585985C723645C8641FDDBFB5F6332
            DAD27B06EB1864140080518842348C7C9F30194DE032B5C7BAEFEA4717C4AF4D
            A17A84B49264348FD23B321FACDBC9A3D16EBB0DE6460100189D88685451542B
            565E6E561BD9D8ED8BEF9B6F5E6B900A03274A95D1DDF90DCFACFF2D9351DFC8
            0728001905006054427C57D7F580EA34876376F2AEE50F5C5B7B470CD5A825CE
            8D66A58C6EF8AD1DE3324AE9E0320A0000F0170F114B4C48550343EB35EEB9FA
            D1AB2A6F4DA27A5CCADC282944A320A300008C7A426D5375DFC099CB27A33994
            DE657319752D90510000463517C8A876CF358F2EAFF852199751EDD28DF24046
            0100F80211C9281BD4AB19EDDEABB98CA650BD82340C320A0000F06751B82F09
            A20A66D128EDC1F75CFDC8F2CADBCB7934AA838C020000FC7940460100004A02
            64140000A0242EB78C92806229A3DDBBF21B998C3A563A30F2513E290000C068
            0364140000A02440460100004AE2F2CB285248A08432FADCFADFE66320A30000
            8C663E1319A50AC9A2EEDDB9301AE54B4C0AC8280000A393CB2AA3EC67146414
            00802F1620A30000002501320A0000501220A30000002501320A0000501220A3
            0000002501320A0000501220A300000025A1B0FF514C1524645413327A5B391A
            2B64541BF2B74046010000248AF893A2281ABDE691E515B70B1935F1B07B3181
            8C0200F0C50364140000A02440460100004A0264140000A02440460100004AE2
            B2CA2802A33C0000BE707C26320AB6CD00007C71B8BC324AD8A09E2A089A8800
            00F0C5E1B39051C2F432873A77E5373FB3E1D742461D90510000462B9F918CF6
            8B464146010018B5808C02000094C4E723A379D0500000462B43C868BD90D1E1
            5A937019F5FACF8DC6D281EE808C0200305AF954191D76836590510000BE700C
            619477E9320A837A0000BE585C56DB6658620200E08B07C82800004049808C02
            00009404C82800004049808C0200009404C828000040497C46320AD62400007C
            5128C8A81A18A807DFBBF232C82818E50100F085426A6528A33C1AADB8BD0CD5
            6B976CDB4C3101190500E08B04D74A82B00E320A000070497C06321A2094479D
            7B729B9F5BFF5B3BDEE369398A7D905100004629582AA9EE5B34ADDD73CD23CB
            2A6F294546295590A7F836EA398FF6FD66DDBFF55A1D19D4A9995874B5030000
            186D1005638A5582998C2683DAAF5CFFB5C9DAE23254A721E3D264947759F670
            E0A14C2F3AF99B777FD4AC34E5B434D2029051000046250519B59C649D3EE9E1
            EBBE5D811A92A8E652A3D180FF4131F5945C1E75BCB1FFD94D67FE6427D2480D
            60500F00C0A88460163F3219D5E276C58AB1ABEF68BCDF4015162A5391892E51
            46A9F8EFAADB43BA8EF4EEFAF5861FB865DD4867D1A87FA50F160000E072A310
            A23021D5D4C04AE46B1E5AB67676C59218AAD0500C71EBFB4B1AD487609FA0A0
            1BB5FCEAE37F3AD4F9092E7703EC5EE9C3050000B8FCB89E9DB4AA7427D560CC
            7A74C5B7EBD0788DC7A1061ABA8308FA34192DFC58213EF57B958EBDDD9B9EDB
            FC6BB72CED69B92B7DB0000000971F1A508394D3EEE457AE7F6C45C58D099452
            C3B5FB4B93D1301EE559A20121AE92B1958E3F6EFFE581EC47B6D173A50F1600
            00E032A3508C8981B38929A9255FBBFABB2934C642968A088EB2A086FEC52164
            9414AF237119CD3B4A4F3B6AFAF19BFF3317EB0C5497283E5FB257F88C2CA544
            513EED6B0000004612FDF58A69A816188613AB561B1E5CFDBD7234BE02D5E948
            534325BC2419ED0753551FB936EA388D0E3EF1E64F33B883241C62D839274703
            F6552A52F5A2ADC2523E000023158A11954B465CA930FB5716070628155454D9
            755FBDE91B75E6F404AA5391A9060A1BE77341C33A5106D99214D78B95518987
            723DE87C3339F6EAC667DABCD339AD4BB1F8EF7BBEA7302515882F1B4246872B
            AF7498112E6C1FB60FDB87EDFFD9EDB3C13BD514C23B804A1712835A7E96D4D0
            BA47577D73727CA68EAA88AFEA3826944CC8A8AA92C102D24B915182FCB4D785
            74A73D38B579CF3B7BCF6E71AC2CB202873A0A5630E5DF196976B8C7C5124E3F
            456107E1D2660960FBB07DD83E6CFFD3B6CFC6EF7AC0A73B29C20A31A86D1A6E
            B2B161C1ED8BBE5C8FC6A841CC50ABF8223BE9FB1526B683EED9A5C9282F6EA2
            C8B151579A9C3FD6BEEF93635BCEF59ECEA15EDDA024147BFE272D52CF6261A5
            CAC57FDB704FD6A5CD24C0F661FBB0FD2FD6F69922AA84E7D8236AA87E7C72DD
            ECB9539634562CD29199A2291DC5994E799EAB1996FC45A6600A523FE5EB872D
            A354CC9362640728EFA0DE34EA3CDE7AECF0D93DA73B8FF9D8A184501464F3F9
            BE5FE9D34D327C0DBDC4D304DB87EDC3F661FB176C9DF2BA4C1563AC624D5115
            4FB150724A7DE3BC494B67D52CC4288191A121C30A0C36D867A3782E566C7C2D
            46FDBC0E09F1BF29437CFDA5C828FBA758BDF2110A5C64DB2897269D79DC95A7
            996C2EE7BAAEF8DE01BF3BBC11FD70AF41610761FBB07DD83E6CBF3F42E8882A
            751463538D95EB5595A83E812A54945090C107F8141B6CB0CF55F3B394511486
            A224721D5578C48B908B1C9FC7A77C590B855FC9257DB033341AE65660FBB07D
            D8FE5FD6F6A9902691FFA932690AF8023C55A9692A7131BA8FB6A610857F54FC
            2B9603F9CB3DA88F8E33726E16A374F695D1468882C54F68402919E27787C508
            7A9BC1F661FBB0FDBFDCED13198DB2509467B87319A53CE9C960037DE4878B3A
            5CCFE4020FBD4046F90F944B92D1A0AF1A340C68FB1D2DBE7053326696FF2EB7
            A9287DBF25FF3ED4491AEEF4097C1E3E0F9F87CF97F2F93ECB1011052A42ED8A
            528964A3BAC20F8754B05264F4824D488AB773D96494FEFFEDD4310A00200C04
            41FCFFA76D2C62214482A2305B0F2A1637AECF7E13CFF3FCA66F8B0D34A33CCF
            F3296F46799EE74BFEA1199D5E1BCE8C636A46799EFFDDC7CC28CFF3BC19E579
            9EBFEB636694E779FEE48C4A92329951492AD501DE327467DEE077A200000025
            74455874646174653A63726561746500323032342D30392D32355431393A3338
            3A33382B30303A30300DD4A1110000002574455874646174653A6D6F64696679
            00323032342D30392D32355431393A33383A33382B30303A30307C8919AD0000
            002874455874646174653A74696D657374616D7000323032342D30392D323554
            31393A33383A33382B30303A30302B9C38720000001E744558746963633A636F
            7079726967687400476F6F676C6520496E632E2032303136AC0B333800000014
            744558746963633A6465736372697074696F6E0073524742BA90730700000000
            49454E44AE426082}
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo3: TfrxMemoView
          Left = 83.370130000000000000
          Top = 23.118120000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sicredi')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 106.385900000000000000
          Width = 714.331170000000000000
          Height = 34.015770000000000000
          Memo.UTF8W = (
            
              ' 1.1 - O boleto s'#243' poder'#225' ser cancelado pela carteira de registr' +
              'o.'
            
              ' 1.2 - O boleto s'#243' poder'#225' ser cancelado ap'#243's 30 minutos de seu r' +
              'egistro.')
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 86.929190000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '1) Regras para cancelamento de boleto.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 178.244280000000000000
          Width = 714.331170000000000000
          Height = 128.504020000000000000
          Memo.UTF8W = (
            
              ' 2.1 - O boleto s'#243' poder'#225' ser alterado pela carteira de registro' +
              '.'
            
              ' 2.2 - O boleto s'#243' poder'#225' ser alterado ap'#243's 30 minutos de seu re' +
              'gistro.'
            
              ' 2.3 - As altera'#231#245'es devem acontecer em suas respectivas rotinas' +
              ' antes de executar essa, aqui vamos apenas comunicar ao banco os' +
              ' dados alterados para que la sejam atualizados tamb'#233'm.'
            
              ' 2.4 - At'#233' o momento o sistema comunica apenas altera'#231#227'o de venc' +
              'imento.')
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 156.787570000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '2) Regras para altera'#231#227'o de boleto.')
          ParentFont = False
        end
      end
    end
  end
end
