inherited frmRelChqDevolvidos: TfrmRelChqDevolvidos
  Left = 342
  Top = 127
  Width = 378
  Height = 677
  Caption = 'Relat'#243'rio de Cheques Devolvidos Por Per'#237'odo'
  OnDestroy = FormDestroy
  OnResize = nil
  ExplicitTop = -66
  ExplicitWidth = 378
  ExplicitHeight = 677
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 605
    Width = 372
    ExplicitTop = 573
    ExplicitWidth = 372
    inherited btnSair: TBitBtnLocked
      Left = 291
      ExplicitLeft = 291
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 83
      Width = 84
      ExplicitLeft = 83
      ExplicitWidth = 84
    end
  end
  inherited pnlDados: TPanel
    Width = 372
    Height = 605
    ExplicitWidth = 372
    ExplicitHeight = 573
    object Label11: TLabel [0]
      Left = 7
      Top = 213
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [1]
      Left = 98
      Top = 191
      Width = 122
      Height = 14
      Caption = '(DATA DE DEVOLU'#199#195'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 98
      Top = 232
      Width = 122
      Height = 14
      Caption = '(DATA DE DEVOLU'#199#195'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 7
      Top = 170
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [4]
      Left = 6
      Top = 7
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [5]
      Left = 7
      Top = 251
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [6]
      Left = 6
      Top = 132
      Width = 83
      Height = 14
      Caption = 'Pra'#231'a do Cheque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCnpjCpf: TLabel [7]
      Left = 7
      Top = 49
      Width = 61
      Height = 14
      Caption = '1-Cnpj/2-Cpf'
    end
    object lblEmit: TLabel [8]
      Left = 7
      Top = 90
      Width = 40
      Height = 14
      Caption = 'Emitente'
    end
    inherited gpbDestino: TGroupBox
      Top = 543
      Width = 176
      Height = 43
      TabOrder = 12
      ExplicitTop = 543
      ExplicitWidth = 176
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Left = 35
        Top = 19
        ExplicitLeft = 35
        ExplicitTop = 19
      end
    end
    object edtCliente: TEditFocus
      Left = 7
      Top = 23
      Width = 57
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnExit = edtClienteExit
      OnKeyPress = edtClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 64
      Top = 23
      Width = 297
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgEstado: TRadioGroup
      Left = 7
      Top = 402
      Width = 354
      Height = 41
      Caption = 'Cheques:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Abertos'
        'Liquidados'
        'Todos')
      TabOrder = 8
    end
    object gpbOpcao: TGroupBox
      Left = 7
      Top = 293
      Width = 354
      Height = 104
      Caption = 'Considerar apenas...'
      TabOrder = 7
      object lbl1: TColorLabel
        Left = 30
        Top = 19
        Width = 109
        Height = 14
        Caption = '(1) Primeira Devolu'#231#227'o'
        CorDestaque = clRed
      end
      object lbl2: TColorLabel
        Left = 30
        Top = 35
        Width = 114
        Height = 14
        Caption = '(2) Segunda Devolu'#231#227'o'
        CorDestaque = clRed
      end
      object lbl3: TColorLabel
        Left = 30
        Top = 51
        Width = 164
        Height = 14
        Caption = '(3) Primeira e Segunda Devolu'#231#227'o'
        CorDestaque = clRed
      end
      object lbl4: TColorLabel
        Left = 30
        Top = 67
        Width = 243
        Height = 14
        Caption = '(4) Primeira e Segunda e Terceira Devolu'#231#227'o'
        CorDestaque = clRed
      end
      object lbl5: TColorLabel
        Left = 30
        Top = 84
        Width = 243
        Height = 14
        Caption = '(5) Primeira ou Segunda ou Terceira Devolu'#231#227'o'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        NumbersOnly = True
        TabOrder = 0
        Text = '5'
        OnChange = edtOpcaoChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttNumerico
      end
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 265
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 6
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
      Left = 38
      Top = 265
      Width = 323
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTelecheque: TGroupBox
      Left = 189
      Top = 495
      Width = 172
      Height = 43
      Caption = 'Telecheque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      object ColorLabel4: TColorLabel
        Left = 35
        Top = 19
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtTelecheque: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
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
    object gpbIncCtr: TGroupBox
      Left = 7
      Top = 495
      Width = 176
      Height = 43
      Caption = 'Inc pelo Contas a Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object ColorLabel2: TColorLabel
        Left = 35
        Top = 19
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtIncCtr: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
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
    object edtDesCid: TEditFocus
      Left = 64
      Top = 148
      Width = 297
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Left = 7
      Top = 148
      Width = 57
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
      MaxLength = 5
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object rdgOrdem: TRadioGroup
      Left = 7
      Top = 447
      Width = 354
      Height = 41
      Caption = 'Ordem:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Data da Devolu'#231#227'o'
        'Nome do Emitente')
      TabOrder = 9
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 7
      Top = 185
      Properties.ButtonGlyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A000000100000001100000011000000110000001200000012000000120000
        0012000000120000001300000013000000120000000C000000030000000A8159
        4CC2B47C69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB279
        68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F
        6EFFFBF8F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7ED
        E6FFF6EDE6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB984
        72FFFBF8F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDC
        D4FFBA9283FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC89
        78FFFCFAF8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EF
        EAFFEBDDD5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E
        7DFFFCFAF9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1
        ECFFBE9786FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC394
        82FFFCFAFAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2
        EEFFEDDFD9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC798
        87FFFDFBFAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5
        F1FFC19B8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D
        8CFFFDFCFCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6
        F3FFEEE2DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA1
        90FFFEFCFCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7
        F6FFC49F91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA5
        94FFFEFCFCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
        F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53
        C3FF8D9EECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69
        DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55
        C4FF93A4EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6F
        DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56
        C6FF96A7EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595
        EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A40
        93C14D55C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046
        B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000010000
        0004000000060000000600000006000000070000000700000007000000070000
        0007000000070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnValidate = mskDtaIniPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 7
      Top = 226
      Properties.ButtonGlyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A000000100000001100000011000000110000001200000012000000120000
        0012000000120000001300000013000000120000000C000000030000000A8159
        4CC2B47C69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB279
        68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F
        6EFFFBF8F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7ED
        E6FFF6EDE6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB984
        72FFFBF8F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDC
        D4FFBA9283FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC89
        78FFFCFAF8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EF
        EAFFEBDDD5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E
        7DFFFCFAF9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1
        ECFFBE9786FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC394
        82FFFCFAFAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2
        EEFFEDDFD9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC798
        87FFFDFBFAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5
        F1FFC19B8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D
        8CFFFDFCFCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6
        F3FFEEE2DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA1
        90FFFEFCFCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7
        F6FFC49F91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA5
        94FFFEFCFCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
        F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53
        C3FF8D9EECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69
        DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55
        C4FF93A4EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6F
        DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56
        C6FF96A7EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595
        EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A40
        93C14D55C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046
        B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000010000
        0004000000060000000600000006000000070000000700000007000000070000
        0007000000070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnValidate = mskDtaFinPropertiesValidate
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      Width = 90
    end
    object edtValidaCnpjCpf: TEditFocus
      Tag = 99
      Left = 6
      Top = 64
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttNumerico
    end
    object mskCnpjCpf: TMaskEditC_G_C_
      Tag = 99
      Left = 70
      Top = 64
      Width = 291
      Height = 22
      Color = 16768952
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 2
      Text = ''
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomEmit: TEditFocus
      Tag = 99
      Left = 6
      Top = 104
      Width = 355
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 633
    Width = 372
    ExplicitTop = 601
    ExplicitWidth = 372
    inherited pnlNomeForm: TPanel
      Left = 201
      ExplicitLeft = 201
    end
    inherited pnlInfo: TPanel
      Width = 201
      ExplicitWidth = 201
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 48
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 224
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 512
    Top = 16
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 480
    Top = 16
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 448
    Top = 16
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 416
    Top = 16
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 384
    Top = 16
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 320
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 352
    Top = 16
  end
  inherited frxDesigner: TfrxDesigner
    Left = 576
    Top = 16
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 608
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 48
  end
end
