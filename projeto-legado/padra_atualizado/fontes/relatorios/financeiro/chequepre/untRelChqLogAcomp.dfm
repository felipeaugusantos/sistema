inherited frmRelChqLogAcomp: TfrmRelChqLogAcomp
  Width = 807
  Height = 576
  Caption = 'Relat'#243'rio de Log de Acompanhamento de Cheques'
  Position = poDesigned
  OnDestroy = FormDestroy
  ExplicitWidth = 807
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 504
    Width = 801
    Height = 27
    TabOrder = 2
    ExplicitTop = 504
    ExplicitWidth = 801
    ExplicitHeight = 27
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
      Left = 136
      Top = 6
      Width = 25
      Height = 14
      Brush.Color = 8417535
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 127
      Height = 23
      Align = alNone
      ExplicitWidth = 127
      ExplicitHeight = 23
      object btnGeraCSV: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 115
        Height = 22
        Caption = 'Gerar Arquivo CSV'
        TabOrder = 0
        OnClick = btnGeraCSVClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 721
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ExplicitLeft = 721
    end
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 801
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 801
    inherited pnlNomeForm: TPanel
      Left = 630
      ExplicitLeft = 630
    end
    inherited pnlInfo: TPanel
      Width = 630
      ExplicitWidth = 630
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 801
    Height = 233
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      801
      233)
    object Label11: TLabel
      Left = 57
      Top = 14
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object Label12: TLabel
      Left = 56
      Top = 59
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
      Left = 46
      Top = 83
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
      Left = 37
      Top = 165
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
      Left = 193
      Top = 165
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
      Left = 36
      Top = 196
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
      Left = 193
      Top = 196
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
      Left = 346
      Top = 165
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
      Left = 346
      Top = 196
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
      Left = 483
      Top = 14
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Agencia:'
    end
    object Label6: TLabel
      Left = 15
      Top = 37
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta Corrente:'
    end
    object Label10: TLabel
      Left = 330
      Top = 37
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Cheque:'
    end
    object Label13: TLabel
      Left = 30
      Top = 107
      Width = 61
      Height = 14
      Caption = '1-Cnpj/2-Cpf'
    end
    object Label14: TLabel
      Left = 50
      Top = 130
      Width = 40
      Height = 14
      Caption = 'Emitente'
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 96
      Top = 9
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomBco: TEditFocus
      Left = 160
      Top = 9
      Width = 319
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 96
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
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
      Left = 160
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
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 96
      Top = 55
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
      TabOrder = 5
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCliente: TEditFocus
      Left = 160
      Top = 55
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
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAgencia: TEditFocus
      Tag = 99
      Left = 532
      Top = 9
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConCor: TEditFocus
      Tag = 99
      Left = 96
      Top = 32
      Width = 160
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumChq: TEditFocus
      Tag = 99
      Left = 432
      Top = 32
      Width = 185
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnExit = edtNumChqExit
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValidaCnpjCpf: TEditFocus
      Tag = 99
      Left = 96
      Top = 103
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object mskCnpjCpf: TMaskEditC_G_C_
      Tag = 99
      Left = 160
      Top = 103
      Width = 457
      Height = 22
      Color = 16768952
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 10
      Text = ''
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomEmit: TEditFocus
      Tag = 99
      Left = 96
      Top = 127
      Width = 521
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIniCad: TcxDateEdit
      Left = 96
      Top = 159
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
    object mskDtaFinCad: TcxDateEdit
      Left = 248
      Top = 159
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
    object mskDtaIniVen: TcxDateEdit
      Left = 96
      Top = 191
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
    object mskDtaFinVen: TcxDateEdit
      Left = 248
      Top = 191
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
      TabOrder = 15
      Width = 90
    end
    object btnConsultar: TBitBtnLocked
      Left = 656
      Top = 161
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
      TabOrder = 17
      OnClick = btnConsultarClick
    end
    object GroupBox1: TGroupBox
      Left = 643
      Top = 9
      Width = 152
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'Legenda de cores'
      TabOrder = 18
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
    object gpbRegcomAlteracao: TGroupBox
      Left = 432
      Top = 153
      Width = 218
      Height = 73
      Caption = 'Somente Registros com Altera'#231#227'o'
      TabOrder = 16
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
          'Data de Dep'#243'sito'
          'Data de Devolu'#231#227'o')
      end
    end
  end
  object dbgConsulta: TcxGrid [3]
    Left = 0
    Top = 233
    Width = 801
    Height = 271
    Align = alClient
    TabOrder = 1
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
      object dbgConsultaDBTableView1Column1: TcxGridDBColumn
        Caption = 'Data Log.'
        DataBinding.FieldName = 'CHQ_DTALOG'
        Width = 58
      end
      object dbgConsultaDBTableView1Column2: TcxGridDBColumn
        Caption = 'Hora Log.'
        DataBinding.FieldName = 'CHQ_HORLOG'
        Width = 67
      end
      object dbgConsultaDBTableView1Column3: TcxGridDBColumn
        Caption = 'Ope. Log.'
        DataBinding.FieldName = 'CHQ_OPELOG'
        Width = 53
      end
      object dbgConsultaDBTableView1Column4: TcxGridDBColumn
        Caption = 'Hist'#243'rico Log.'
        DataBinding.FieldName = 'CHQ_HISLOG'
        Width = 225
      end
      object dbgConsultaDBTableView1Column5: TcxGridDBColumn
        Caption = 'C'#243'd. Banco'
        DataBinding.FieldName = 'CHQ_CODBCO'
        Width = 84
      end
      object dbgConsultaDBTableView1Column6: TcxGridDBColumn
        Caption = 'N'#250'm. Agencia'
        DataBinding.FieldName = 'CHQ_NUMAGE'
        Width = 92
      end
      object dbgConsultaDBTableView1Column7: TcxGridDBColumn
        Caption = 'Conta Corrente'
        DataBinding.FieldName = 'CHQ_CONCOR'
        Width = 95
      end
      object dbgConsultaDBTableView1Column8: TcxGridDBColumn
        Caption = 'N'#250'm. Cheque'
        DataBinding.FieldName = 'CHQ_NUMCHQ'
        Width = 101
      end
      object dbgConsultaDBTableView1Column9: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CHQ_CODCLI'
        Width = 95
      end
      object dbgConsultaDBTableView1Column10: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'CHQ_NOMEMI'
        Width = 192
      end
      object dbgConsultaDBTableView1Column11: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'CHQ_ENDERE'
        Width = 147
      end
      object dbgConsultaDBTableView1Column12: TcxGridDBColumn
        Caption = 'Telefone'
        DataBinding.FieldName = 'CHQ_TELEMI'
        Width = 119
      end
      object dbgConsultaDBTableView1Column14: TcxGridDBColumn
        Caption = 'CNPJ/CPF'
        DataBinding.FieldName = 'CHQ_C_G_C_'
        Width = 106
      end
      object dbgConsultaDBTableView1Column15: TcxGridDBColumn
        Caption = 'Data Cadastro'
        DataBinding.FieldName = 'CHQ_DTACAD'
        Width = 91
      end
      object dbgConsultaDBTableView1Column16: TcxGridDBColumn
        Caption = 'Data Vencimento'
        DataBinding.FieldName = 'CHQ_DTAVEN'
        Width = 95
      end
      object dbgConsultaDBTableView1Column17: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CHQ_VALCHQ'
        Width = 75
      end
      object dbgConsultaDBTableView1Column18: TcxGridDBColumn
        Caption = 'Hist'#243'rico 1'
        DataBinding.FieldName = 'CHQ_HIST01'
        Width = 215
      end
      object dbgConsultaDBTableView1Column19: TcxGridDBColumn
        Caption = 'Hist'#243'rico 2'
        DataBinding.FieldName = 'CHQ_HIST02'
        Width = 175
      end
      object dbgConsultaDBTableView1Column20: TcxGridDBColumn
        Caption = 'Pl. Contas Dep'#243'sito'
        DataBinding.FieldName = 'CHQ_CTADEP'
        Width = 100
      end
      object dbgConsultaDBTableView1Column21: TcxGridDBColumn
        Caption = 'Data Dep'#243'sito'
        DataBinding.FieldName = 'CHQ_DTADEP'
        Width = 82
      end
      object dbgConsultaDBTableView1Column22: TcxGridDBColumn
        Caption = 'Doc. Dep'#243'sito'
        DataBinding.FieldName = 'CHQ_DOCDEP'
        Width = 106
      end
      object dbgConsultaDBTableView1Column23: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'CHQ_CODPOR'
        Width = 73
      end
      object dbgConsultaDBTableView1Column24: TcxGridDBColumn
        Caption = 'Pl. Contas'
        DataBinding.FieldName = 'CHQ_CODCTA'
        Width = 72
      end
      object dbgConsultaDBTableView1Column25: TcxGridDBColumn
        Caption = 'Data Devolu'#231#227'o'
        DataBinding.FieldName = 'CHQ_DTADEV'
        Width = 84
      end
      object dbgConsultaDBTableView1Column26: TcxGridDBColumn
        Caption = 'Motivo Devolu'#231#227'o'
        DataBinding.FieldName = 'CHQ_MOTDEV'
        Width = 122
      end
      object dbgConsultaDBTableView1Column27: TcxGridDBColumn
        Caption = 'Data Redep'#243'sito'
        DataBinding.FieldName = 'CHQ_DTARDP'
        Width = 100
      end
      object dbgConsultaDBTableView1Column28: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CHQ_CODEMP'
        Width = 50
      end
      object dbgConsultaDBTableView1CHQ_DTADV2: TcxGridDBColumn
        Caption = 'Data 2'#170' Devolu'#231#227'o'
        DataBinding.FieldName = 'CHQ_DTADV2'
        Width = 95
      end
      object dbgConsultaDBTableView1CHQ_MOTDV2: TcxGridDBColumn
        Caption = 'Motivo 2'#170' Devolu'#231#227'o'
        DataBinding.FieldName = 'CHQ_MOTDV2'
        Width = 147
      end
      object dbgConsultaDBTableView1Column32: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'CHQ_CODOPE'
        Width = 94
      end
      object dbgConsultaDBTableView1Column33: TcxGridDBColumn
        Caption = 'Cheque'
        DataBinding.FieldName = 'CHEQUE'
        Visible = False
        GroupIndex = 0
        SortIndex = 0
        SortOrder = soAscending
      end
      object dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn
        DataBinding.FieldName = 'ALTERACOES'
        Visible = False
      end
      object dbgConsultaDBTableView1CHQ_NOMEXE: TcxGridDBColumn
        Caption = 'Nome EXE'
        DataBinding.FieldName = 'CHQ_NOMEXE'
        Width = 130
      end
      object dbgConsultaDBTableView1CHQ_DTAEXE: TcxGridDBColumn
        Caption = 'Data EXE'
        DataBinding.FieldName = 'CHQ_DTAEXE'
        Width = 65
      end
      object dbgConsultaDBTableView1CHQ_HOREXE: TcxGridDBColumn
        Caption = 'Hora EXE'
        DataBinding.FieldName = 'CHQ_HOREXE'
      end
      object dbgConsultaDBTableView1CHQ_VEREXE: TcxGridDBColumn
        Caption = 'Vers'#227'o EXE'
        DataBinding.FieldName = 'CHQ_VEREXE'
        Width = 95
      end
    end
    object dbgConsultaLevel1: TcxGridLevel
      GridView = dbgConsultaDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 344
  end
  object cxsrConsulta: TcxStyleRepository
    Left = 198
    Top = 349
    PixelsPerInch = 96
  end
  object dspConsulta: TUniDataSetProvider
    Options = []
    Left = 160
    Top = 408
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 288
    Top = 416
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 216
    Top = 408
  end
end
