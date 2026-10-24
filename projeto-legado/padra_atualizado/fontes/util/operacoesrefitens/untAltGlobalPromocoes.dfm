inherited frmAltGlobalPromocoes: TfrmAltGlobalPromocoes
  Width = 583
  Height = 518
  Caption = 'Altera'#231#227'o Global de Promo'#231#245'es'
  ExplicitWidth = 583
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 577
    TabOrder = 1
    ExplicitTop = 447
    ExplicitWidth = 577
    inherited FlwBotoes: TFlowPanel
      Width = 465
      inherited btnConfirma: TBitBtnLocked
        Width = 108
        Align = alLeft
        Caption = '[F10] &Confirma'
        ModalResult = 0
        ExplicitWidth = 108
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      Top = 2
      Width = 108
      Align = alRight
      Caption = '[ESC] C&ancela'
      ExplicitLeft = 467
      ExplicitTop = 2
      ExplicitWidth = 108
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 577
    Height = 447
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label9: TLabel
      Left = 20
      Top = 85
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 11
      Top = 109
      Width = 77
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label11: TLabel
      Left = 55
      Top = 133
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 29
      Top = 157
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDescricao: TLabel
      Left = 7
      Top = 205
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 11
      Top = 229
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 32
      Top = 254
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 49
      Top = 181
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 37
      Top = 9
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Promo'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 222
      Top = 43
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Validade Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 401
      Top = 43
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Validade Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 4
      Top = 75
      Width = 563
      Height = 2
    end
    object Bevel2: TBevel
      Left = 4
      Top = 280
      Width = 563
      Height = 2
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 93
      Top = 82
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 5
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 164
      Top = 82
      Width = 402
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 164
      Top = 106
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 93
      Top = 106
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 7
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtMarca: TEditFocus
      Tag = 99
      Left = 93
      Top = 130
      Width = 70
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
      TabOrder = 9
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 164
      Top = 130
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 164
      Top = 154
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 93
      Top = 154
      Width = 70
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
      TabOrder = 11
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDescriIni: TEditFocus
      Left = 93
      Top = 202
      Width = 473
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnExit = edtDescriIniExit
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescriFin: TEditFocus
      Left = 93
      Top = 226
      Width = 473
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 93
      Top = 251
      Width = 473
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 93
      Top = 178
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 13
      OnExit = edtCodUniExit
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object rdgTipAlt: TRadioGroup
      Left = 9
      Top = 287
      Width = 84
      Height = 80
      Caption = 'Altera'#231#227'o por'
      ItemIndex = 1
      Items.Strings = (
        'Fator'
        'Valor Fixo')
      TabOrder = 18
      OnClick = rdgTipAltClick
    end
    object rdgPreDes: TRadioGroup
      Left = 9
      Top = 29
      Width = 204
      Height = 38
      Caption = 'Promo'#231#227'o por:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o'
        '% Desconto')
      TabOrder = 2
      OnClick = rdgPreDesClick
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 93
      Top = 6
      Width = 70
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
      OnExit = edtCodProExit
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 300
      Top = 38
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
      StyleFocused.Color = clMoneyGreen
      TabOrder = 3
      Width = 93
    end
    object mskDtaFim: TcxDateEdit
      Tag = 99
      Left = 473
      Top = 38
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
      StyleFocused.Color = clMoneyGreen
      TabOrder = 4
      Width = 93
    end
    object chkPreCus: TCheckBox
      Tag = 99
      Left = 95
      Top = 298
      Width = 102
      Height = 17
      Caption = 'Pre'#231'o de Custo:'
      TabOrder = 19
      OnClick = chkPreCusClick
    end
    object chkPreVen: TCheckBox
      Tag = 99
      Left = 95
      Top = 323
      Width = 102
      Height = 17
      Caption = 'Pre'#231'o de Venda:'
      TabOrder = 21
      OnClick = chkPreVenClick
    end
    object chkPerDes: TCheckBox
      Tag = 99
      Left = 95
      Top = 348
      Width = 102
      Height = 17
      Caption = '% Desconto:'
      TabOrder = 23
      OnClick = chkPerDesClick
    end
    object chkComInt: TCheckBox
      Tag = 99
      Left = 278
      Top = 298
      Width = 209
      Height = 17
      Caption = '% Comiss'#227'o Vend. Interno:'
      TabOrder = 25
      OnClick = chkComIntClick
    end
    object chkComLoj: TCheckBox
      Tag = 99
      Left = 278
      Top = 323
      Width = 209
      Height = 17
      Caption = '% Comiss'#227'o Vend. Externo Loja:'
      TabOrder = 27
      OnClick = chkComLojClick
    end
    object edtPreCus: TCurrencyEditFocus
      Tag = 99
      Left = 199
      Top = 295
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object edtPreVen: TCurrencyEditFocus
      Tag = 99
      Left = 199
      Top = 320
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object edtPerDes: TCurrencyEditFocus
      Tag = 99
      Left = 199
      Top = 345
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object chkComDis: TCheckBox
      Tag = 99
      Left = 278
      Top = 348
      Width = 215
      Height = 17
      Caption = '% Comiss'#227'o Vend. Externo Distribui'#231#227'o:'
      TabOrder = 29
      OnClick = chkComDisClick
    end
    object edtComInt: TCurrencyEditFocus
      Tag = 99
      Left = 495
      Top = 295
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object edtComLoj: TCurrencyEditFocus
      Tag = 99
      Left = 495
      Top = 320
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 28
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object edtComDis: TCurrencyEditFocus
      Tag = 99
      Left = 495
      Top = 345
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 30
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = 8421631
      Requerido = False
      Width = 71
    end
    object edtDesPro: TEditFocus
      Left = 164
      Top = 6
      Width = 402
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object edtDesUni: TEditFocus
      Left = 164
      Top = 178
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkPromocao: TCheckBox
      Tag = 99
      Left = 9
      Top = 371
      Width = 260
      Height = 17
      Caption = 'Tabelas de pre'#231'o que ir'#227'o compor as promo'#231#245'es:'
      TabOrder = 31
      OnClick = chkPromocaoClick
    end
    object clbTabPre: TCheckListBox
      Left = 9
      Top = 390
      Width = 557
      Height = 48
      OnClickCheck = clbTabPreClickCheck
      Columns = 3
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      Items.Strings = (
        'Tabela de Pre'#231'o 1'
        'Tabela de Pre'#231'o 2'
        'Tabela de Pre'#231'o 3'
        'Tabela de Pre'#231'o 4'
        'Tabela de Pre'#231'o 5'
        'Tabela de Pre'#231'o 6'
        'Tabela de Pre'#231'o 7')
      Style = lbOwnerDrawFixed
      TabOrder = 32
      OnDrawItem = clbTabPreDrawItem
      OnEnter = clbTabPreEnter
      OnExit = clbTabPreExit
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 577
    TabOrder = 2
    ExplicitTop = 473
    ExplicitWidth = 577
    inherited pnlNomeForm: TPanel
      Left = 406
      ExplicitLeft = 406
    end
    inherited pnlInfo: TPanel
      Width = 406
      ExplicitWidth = 406
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 696
    Top = 160
  end
end
