inherited frmCartaAnuencia: TfrmCartaAnuencia
  Left = 409
  Top = 277
  Width = 867
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Carta de Anu'#234'ncia'
  Position = poScreenCenter
  ExplicitWidth = 867
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 861
    ExplicitTop = 482
    ExplicitWidth = 861
    DesignSize = (
      861
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 857
      ExplicitWidth = 857
    end
  end
  inherited pgcDados: TPageControl
    Left = 430
    Top = 60
    Width = 553
    Height = 448
    Align = alCustom
    ExplicitLeft = 430
    ExplicitTop = 60
    ExplicitWidth = 553
    ExplicitHeight = 448
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 545
      ExplicitHeight = 416
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 861
    Height = 89
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object Label3: TLabel
      Left = 72
      Top = 14
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object Label4: TLabel
      Left = 8
      Top = 63
      Width = 36
      Height = 14
      Caption = 'Per'#237'odo'
    end
    object Label5: TLabel
      Left = 48
      Top = 63
      Width = 59
      Height = 14
      Caption = 'Vencimento:'
    end
    object Label6: TLabel
      Left = 206
      Top = 63
      Width = 6
      Height = 14
      Caption = #224
    end
    object Label9: TLabel
      Left = 30
      Top = 38
      Width = 81
      Height = 14
      Caption = 'Modelo de Carta:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 434
      Top = 40
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object ColorLabel1: TColorLabel
      Left = 512
      Top = 40
      Width = 144
      Height = 14
      Caption = '(A)bertos (B)aixados (T)odos'
      CorDestaque = clRed
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 112
      Top = 10
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
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
      Left = 169
      Top = 10
      Width = 262
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
    object chkExiPar: TCheckBox
      Tag = 99
      Left = 312
      Top = 61
      Width = 165
      Height = 17
      Caption = 'Imprimir Parcela da Duplicata?'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object rdgValDup: TRadioGroup
      Tag = 99
      Left = 434
      Top = 1
      Width = 155
      Height = 33
      Caption = 'Valor da Duplicata:'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Parcial'
        'Original')
      TabOrder = 2
    end
    object chkExiEsp: TCheckBox
      Tag = 99
      Left = 482
      Top = 61
      Width = 166
      Height = 17
      Caption = 'Imprimir Esp'#233'cie da Duplicata?'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object cbbModelo: TDBLookupComboBoxFocus
      Tag = 99
      Left = 112
      Top = 35
      Width = 319
      Height = 22
      KeyField = 'ANU_CODANU'
      ListField = 'ANU_NOMANU'
      ListSource = dtsModelos
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 112
      Top = 59
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
      Left = 216
      Top = 59
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
    object btnConsultar: TBitBtnLocked
      Left = 654
      Top = 58
      Width = 106
      Height = 21
      Caption = '&Carregar'
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
      TabOrder = 9
      OnClick = btnConsultarClick
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 472
      Top = 37
      Width = 31
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 8
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
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 89
    Width = 497
    Height = 395
    Align = alLeft
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 4
    ExplicitTop = 87
    object dbgDuplicatas: TDBGridCitel
      Left = 0
      Top = 0
      Width = 497
      Height = 340
      Align = alClient
      Options = [dgTitles, dgIndicator, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnDblClick = dbgDuplicatasDblClick
      OnKeyDown = dbgDuplicatasKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Caption = 'Duplicata'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Caption = 'Empresa'
          Width = 132
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_DTAVEN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vencimento'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALDUP'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_SEQBAI'
          Title.Alignment = taCenter
          Title.Caption = 'Seq. Baixa'
          Visible = True
        end>
    end
    object pnlTotais: TPanel
      Left = 0
      Top = 340
      Width = 497
      Height = 55
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      object Label1: TLabel
        Left = 40
        Top = 8
        Width = 78
        Height = 14
        Caption = 'Total Duplicatas:'
      end
      object Label2: TLabel
        Left = 31
        Top = 32
        Width = 87
        Height = 14
        Caption = 'Total Selecionado:'
      end
      object edtTotalDup: TEditFocus
        Left = 120
        Top = 4
        Width = 98
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotalSelecionado: TEditFocus
        Left = 120
        Top = 28
        Width = 98
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
  end
  object pnlDadosDup: TPanel [5]
    Left = 497
    Top = 89
    Width = 364
    Height = 395
    Align = alClient
    Color = 16770261
    TabOrder = 5
    ExplicitTop = 87
    object Label7: TLabel
      Left = 23
      Top = 31
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Nome: TLabel
      Left = 28
      Top = 54
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label8: TLabel
      Left = 14
      Top = 77
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label10: TLabel
      Left = 28
      Top = 100
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label12: TLabel
      Left = 4
      Top = 123
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso Nro:'
    end
    object Label14: TLabel
      Left = 13
      Top = 149
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object edtCodCliBai: TEditFocus
      Left = 61
      Top = 27
      Width = 290
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNomCliBai: TEditFocus
      Left = 61
      Top = 50
      Width = 290
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNomPorBai: TEditFocus
      Left = 61
      Top = 96
      Width = 290
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodPorBai: TEditFocus
      Left = 61
      Top = 73
      Width = 290
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNosNum: TEditFocus
      Left = 61
      Top = 119
      Width = 290
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtHistor: TMemoFocus
      Left = 61
      Top = 142
      Width = 290
      Height = 45
      TabStop = False
      Color = 16768952
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 484
    Width = 861
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 6
    object btnConfirma: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 111
      Height = 26
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitLeft = 6
      ExplicitTop = 4
      ExplicitHeight = 22
    end
    object btnSairAgrup: TBitBtnLocked
      Left = 749
      Top = 1
      Width = 111
      Height = 26
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairAgrupClick
      ExplicitLeft = 748
      ExplicitTop = 4
      ExplicitHeight = 22
    end
    object btnConfigurar: TBitBtnLocked
      Left = 638
      Top = 1
      Width = 111
      Height = 26
      Align = alRight
      Caption = '&Configurar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
        99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
        B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
        CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
        2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
        E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
        A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
        1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
        FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
        9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
        0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
        F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
        9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
        FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
        A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
        9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
        B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
        7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnConfigurarClick
      ExplicitLeft = 635
      ExplicitTop = 4
      ExplicitHeight = 22
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 861
    ExplicitTop = 512
    ExplicitWidth = 861
    inherited pnlNomeForm: TPanel
      Left = 690
      ExplicitLeft = 690
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 333
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 64
    Top = 152
  end
  object qryModelos: TUniQuery
    SQL.Strings = (
      'SELECT'
      '  ANU_CODANU,'
      '  ANU_NOMANU,'
      '  ANU_PATANU'
      'FROM'
      '  CARANU'
      'WHERE'
      '  ANU_CODEMP = :CODEMP'
      'ORDER BY'
      '  ANU_NOMANU')
    ReadOnly = True
    Constraints = <>
    Left = 280
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODEMP'
        Value = nil
      end>
  end
  object dtsModelos: TDataSource
    DataSet = qryModelos
    Left = 344
    Top = 152
  end
end
