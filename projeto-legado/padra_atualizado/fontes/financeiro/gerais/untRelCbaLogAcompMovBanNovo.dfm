inherited frmRelCbaLogAcompMovBanNovo: TfrmRelCbaLogAcompMovBanNovo
  Width = 1024
  Height = 768
  Caption = 
    'Relat'#243'rio de Log de Acompanhamento das  Movimenta'#231#227'o de Conta Ba' +
    'nco.'
  Position = poDesigned
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    TabOrder = 2
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Left = 117
      Width = 822
      TabOrder = 1
      ExplicitLeft = 244
      ExplicitWidth = 695
      object Shp_inferior: TShape
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 25
        Height = 17
        Brush.Color = 8417535
        Visible = False
      end
      object lblCampoAlterados2: TLabel
        AlignWithMargins = True
        Left = 34
        Top = 3
        Width = 87
        Height = 14
        Alignment = taCenter
        Anchors = [akRight, akBottom]
        AutoSize = False
        Caption = 'Campos alterados'
        Color = clBtnFace
        ParentColor = False
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 24
      Align = alRight
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
      TabOrder = 0
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGeraCSV: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 115
      Height = 24
      Align = alLeft
      Caption = 'Gerar Arquivo CSV'
      TabOrder = 2
      OnClick = btnGeraCSVClick
      ExplicitLeft = 129
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 3
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 215
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      1018
      215)
    object Label12: TLabel
      Left = 102
      Top = 41
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 101
      Top = 89
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
    object Label27: TLabel
      Left = 13
      Top = 17
      Width = 133
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sequencial do Lan'#231'amento:'
    end
    object Label4: TLabel
      Left = 92
      Top = 138
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
      Left = 96
      Top = 164
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
    object Label6: TLabel
      Left = 5
      Top = 114
      Width = 141
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Arquivo de Importa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 148
      Top = 86
      Width = 90
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
      Left = 241
      Top = 86
      Width = 557
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
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPortador: TEditFocus
      Tag = 99
      Left = 148
      Top = 38
      Width = 90
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
      TabOrder = 1
      OnKeyPress = edtCodPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPortador: TEditFocus
      Left = 241
      Top = 38
      Width = 557
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
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumSeq: TEditFocus
      Tag = 99
      Left = 148
      Top = 14
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumSeqExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 858
      Top = 4
      Width = 158
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'Legenda de cores'
      TabOrder = 13
      object Shape1: TShape
        Left = 16
        Top = 24
        Width = 25
        Height = 14
        Brush.Color = 8417535
      end
      object Label2: TLabel
        Left = 47
        Top = 24
        Width = 87
        Height = 14
        Caption = 'Campos alterados'
      end
    end
    object btnConsultar: TBitBtnLocked
      Left = 803
      Top = 143
      Width = 127
      Height = 24
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
      TabOrder = 12
      OnClick = btnConsultarClick
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 148
      Top = 134
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
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 148
      Top = 160
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
    object edtNomeArquivo: TEditFocus
      Tag = 99
      Left = 148
      Top = 110
      Width = 650
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
      MaxLength = 200
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 200
      TipoTexto = ttAlfabetico
    end
    object rdgData: TRadioGroup
      Left = 241
      Top = 134
      Width = 174
      Height = 50
      Caption = 'Data de'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Lan'#231'amento'
        'Altera'#231#227'o'
        'Concilia'#231#227'o')
      TabOrder = 9
    end
    object rdgOrdernacao: TRadioGroup
      Left = 419
      Top = 135
      Width = 155
      Height = 50
      Caption = 'Agrupar por'
      ItemIndex = 0
      Items.Strings = (
        'Lan'#231'amento'
        'Portador + Nome Arquivo')
      TabOrder = 10
    end
    object btnCalculo: TBitBtnLocked
      AlignWithMargins = True
      Left = 858
      Top = 59
      Width = 158
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 14
      OnClick = btnCalculoClick
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 67
      Top = 62
      Width = 737
      Height = 22
      TabOrder = 3
      ExplicitLeft = 67
      ExplicitTop = 62
      ExplicitWidth = 737
      inherited lblPlaContas: TLabel
        Left = 4
        Width = 75
        Height = 14
        Caption = 'Plano de Conta:'
        ExplicitLeft = 4
        ExplicitWidth = 75
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 174
        Width = 557
        Height = 22
        ExplicitLeft = 174
        ExplicitWidth = 557
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 81
        Width = 90
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 81
        ExplicitWidth = 90
        ExplicitHeight = 22
      end
    end
    object gpbRegcomAlteracao: TGroupBox
      Left = 580
      Top = 135
      Width = 219
      Height = 73
      Caption = 'Somente Registros com Altera'#231#227'o'
      TabOrder = 11
      object Label3: TLabel
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
          'Data de Lan'#231'amento'
          'Portador'
          'Valor do Documento')
      end
    end
  end
  object dbgConsulta: TcxGrid [3]
    Left = 0
    Top = 215
    Width = 1018
    Height = 480
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgConsultaDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgConsultaDBTableView1CustomDrawCell
      DataController.DataSource = dtsConsulta
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
      object dbgConsultaDBTableView1CTB_DTALOG: TcxGridDBColumn
        Caption = 'Data Log.'
        DataBinding.FieldName = 'CTB_DTALOG'
        Options.AutoWidthSizable = False
        Width = 65
      end
      object dbgConsultaDBTableView1CTB_HORLOG: TcxGridDBColumn
        Caption = 'Hora Log.'
        DataBinding.FieldName = 'CTB_HORLOG'
        Options.AutoWidthSizable = False
      end
      object dbgConsultaDBTableView1CTB_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CTB_DESCRI'
        Options.AutoWidthSizable = False
        Width = 143
      end
      object dbgConsultaDBTableView1CTB_NOMFRM: TcxGridDBColumn
        Caption = 'Nome do Formul'#225'rio'
        DataBinding.FieldName = 'CTB_NOMFRM'
        Options.AutoWidthSizable = False
        Width = 101
      end
      object dbgConsultaDBTableView1CTB_OPELOG: TcxGridDBColumn
        Caption = 'C'#243'd. Operador Log.'
        DataBinding.FieldName = 'CTB_OPELOG'
        Options.AutoWidthSizable = False
        Width = 101
      end
      object dbgConsultaDBTableView1CTB_CODCTA: TcxGridDBColumn
        Caption = 'Plano De Contas'
        DataBinding.FieldName = 'CTB_CODCTA'
        Width = 130
      end
      object dbgConsultaDBTableView1CTB_CODPOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'CTB_CODPOR'
        Width = 100
      end
      object dbgConsultaDBTableView1CTB_SEQLAN: TcxGridDBColumn
        Caption = 'Seq. Lan'#231'amento'
        DataBinding.FieldName = 'CTB_SEQLAN'
      end
      object dbgConsultaDBTableView1CTB_DTALAN: TcxGridDBColumn
        Caption = 'Dta. Lan'#231'amento'
        DataBinding.FieldName = 'CTB_DTALAN'
        Width = 88
      end
      object dbgConsultaDBTableView1CTB_HORLAN: TcxGridDBColumn
        Caption = 'Hro. Lan'#231'amento'
        DataBinding.FieldName = 'CTB_DTALAN'
        Width = 89
      end
      object dbgConsultaDBTableView1CTB_ARQIMP: TcxGridDBColumn
        Caption = 'Arquivo Importa'#231#227'o'
        DataBinding.FieldName = 'CTB_ARQIMP'
        Width = 350
      end
      object dbgConsultaDBTableView1CTB_NUMDOC: TcxGridDBColumn
        Caption = 'N'#250'm. Doc'
        DataBinding.FieldName = 'CTB_NUMDOC'
        Width = 70
      end
      object dbgConsultaDBTableView1CTB_CREDEB: TcxGridDBColumn
        Caption = 'C/D'
        DataBinding.FieldName = 'CTB_CREDEB'
      end
      object dbgConsultaDBTableView1CTB_VALLAN: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTB_VALLAN'
      end
      object dbgConsultaDBTableView1CTB_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico 1'
        DataBinding.FieldName = 'HIST01'
      end
      object dbgConsultaDBTableView1CTB_HIST02: TcxGridDBColumn
        Caption = 'Hist'#243'rico 2'
        DataBinding.FieldName = 'HIST02'
      end
      object dbgConsultaDBTableView1CTB_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CTB_CODEMP'
        Width = 75
      end
      object dbgConsultaDBTableView1CTB_CODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CTB_CODCLI'
      end
      object dbgConsultaDBTableViewCTB_CODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'CTB_CODFOR'
      end
      object dbgConsultaDBTableView1CTB_SEQBAI: TcxGridDBColumn
        Caption = 'Sequencial da Baixa'
        DataBinding.FieldName = 'CTB_SEQBAI'
        Width = 112
      end
      object dbgConsultaDBTableView1CTB_PARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'CTB_PARCEL'
        Width = 83
      end
      object dbgConsultaDBTableView1CTB_EMPDUP: TcxGridDBColumn
        Caption = 'Emp. Duplic'
        DataBinding.FieldName = 'CTB_EMPDUP'
        Width = 75
      end
      object dbgConsultaDBTableView1CTB_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTB_NUMDUP'
      end
      object dbgConsultaDBTableView1CTB_SERIE_: TcxGridDBColumn
        Caption = 'Serie'
        DataBinding.FieldName = 'CTB_SERIE_'
      end
      object dbgConsultaDBTableView1CTB_CODEVE: TcxGridDBColumn
        Caption = 'Ctr. Custo'
        DataBinding.FieldName = 'CTB_CODEVE'
      end
      object dbgConsultaDBTableView1CTB_DTACON: TcxGridDBColumn
        Caption = 'Dta. Concilia'#231#227'o'
        DataBinding.FieldName = 'CTB_DTACON'
        Width = 99
      end
      object dbgConsultaDBTableView1CTB_OPECON: TcxGridDBColumn
        Caption = 'Ope. Concilia'#231#227'o'
        DataBinding.FieldName = 'CTB_OPECON'
        Width = 96
      end
      object dbgConsultaDBTableView1CTB_SEQCTP: TcxGridDBColumn
        Caption = 'Seq. Cta a Pagar'
        DataBinding.FieldName = 'CTB_SEQCTP'
        Width = 87
      end
      object dbgConsultaDBTableView1CTB_DOCBAI: TcxGridDBColumn
        Caption = 'Doc. de Baixa'
        DataBinding.FieldName = 'CTB_DOCBAI'
        Width = 82
      end
      object dbgConsultaDBTableView1CTB_SEQTRF: TcxGridDBColumn
        Caption = 'Seq. de Transferencia'
        DataBinding.FieldName = 'CTB_SEQTRF'
      end
      object dbgConsultaDBTableView1CTB_CODVEL: TcxGridDBColumn
        Caption = 'C'#243'd. de Controle Anterior'
        DataBinding.FieldName = 'CTB_CODVEL'
      end
      object dbgConsultaDBTableView1CTB_PAGCON: TcxGridDBColumn
        Caption = 'Seq. de Controle'
        DataBinding.FieldName = 'CTB_PAGCON'
      end
      object dbgConsultaDBTableView1CTB_HORCON: TcxGridDBColumn
        Caption = 'Hro.da Concilia'#231#227'o'
        DataBinding.FieldName = 'CTB_HORCON'
      end
      object dbgConsultaDBTableView1CTB_ORIGEM: TcxGridDBColumn
        Caption = 'Orig . do Lan'#231'.'
        DataBinding.FieldName = 'CTB_ORIGEM'
      end
      object dbgConsultaDBTableView1CTB_COMPET: TcxGridDBColumn
        Caption = 'Compet'#234'ncia'
        DataBinding.FieldName = 'CTB_COMPET'
      end
      object dbgConsultaDBTableView1CTB_CODCHQ: TcxGridDBColumn
        Caption = 'Cod. Cheque'
        DataBinding.FieldName = 'CTB_CODCHQ'
      end
      object dbgConsultaDBTableView1CTB_CODCAR: TcxGridDBColumn
        Caption = 'C'#243'd. Cart'#227'o'
        DataBinding.FieldName = 'CTB_CODCAR'
      end
      object dbgConsultaDBTableView1CTB_OCOIGN: TcxGridDBColumn
        Caption = 'C'#243'd. Ocorr'#234'ncia'
        DataBinding.FieldName = 'CTB_OCOIGN'
      end
      object dbgConsultaDBTableView1CTB_IGNORA: TcxGridDBColumn
        Caption = 'Ignorado?'
        DataBinding.FieldName = 'CTB_IGNORA'
      end
      object dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn
        DataBinding.FieldName = 'ALTERACOES'
        Visible = False
      end
      object dbgConsultaDBTableView1Lanc: TcxGridDBColumn
        Caption = 'Lan'#231'amento'
        DataBinding.FieldName = 'LANC'
        Options.AutoWidthSizable = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 65
      end
      object dbgConsultaDBTableView1CTB_NOMEXE: TcxGridDBColumn
        Caption = 'Nome EXE'
        DataBinding.FieldName = 'CTB_NOMEXE'
        Width = 130
      end
      object dbgConsultaDBTableView1CTB_DTAEXE: TcxGridDBColumn
        Caption = 'Data EXE'
        DataBinding.FieldName = 'CTB_DTAEXE'
        Width = 65
      end
      object dbgConsultaDBTableView1CTB_HOREXE: TcxGridDBColumn
        Caption = 'Hora EXE'
        DataBinding.FieldName = 'CTB_HOREXE'
      end
      object dbgConsultaDBTableView1CTB_VEREXE: TcxGridDBColumn
        Caption = 'Vers'#227'o EXE'
        DataBinding.FieldName = 'CTB_VEREXE'
        Width = 95
      end
    end
    object dbgConsultaLevel1: TcxGridLevel
      GridView = dbgConsultaDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 820
    Top = 356
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 786
    Top = 356
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 792
    Top = 312
  end
  object cxsrConsulta: TcxStyleRepository
    Left = 826
    Top = 409
    PixelsPerInch = 96
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 27001596
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
          25D0522C17931209053000000009000000010000000000000000000000000000
          00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
          6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
          0110744226B9BC7C4DFFDDAE77FFDEB076FFDEAF75FFDEAF75FFDEB074FFDDAF
          75FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
          2095BE8053FFE0B37CFFDFB076FFDEB177FFDFB279FFE0B379FFE0B27AFFE0B2
          79FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
          47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFE1B67EFFE2B67FFFE2B77FFFE2B7
          7FFFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
          6FFFE2B780FFE5BD89FFE7C291FFE8C393FFE8C494FFE8C594FFE8C495FFE8C4
          95FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
          83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFB0794AFFAB7245FFAD75
          47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
          8FFFE4BB84FFA56B3FFFF5EEE9FFFAF6F3FFFAF7F3FFFBF7F4FFFBF7F5FFFAF7
          F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
          A0FFE5BE89FFA56B3FFFE6D9D2FFE7DBD4FFE9DED7FFEAE0D9FFEAE0DAFFEBE1
          DBFFEBE0DBFFEEE5E1FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
          ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B
          3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
          9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFF1D7ABFFF1D8ADFFF1D8ADFFF1D8
          ADFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
          6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFF3DCB3FFF3DEB4FFF3DEB4FFF3DE
          B4FFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
          3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFF4E1B9FFF5E3BBFFF5E2BBFFF5E2
          BBFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
          0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
          CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
          00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
          B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
          000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
          60CD6C543F8B16110D2200000003000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end>
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 44
    Top = 392
  end
  object dspConsulta: TUniDataSetProvider
    Options = []
    Left = 48
    Top = 268
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 48
    Top = 328
  end
end
