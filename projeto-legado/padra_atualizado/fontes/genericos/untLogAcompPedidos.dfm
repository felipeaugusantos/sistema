inherited frmLogAcompPedidos: TfrmLogAcompPedidos
  Width = 1024
  Height = 576
  Caption = 'Log de Acompanhamento de Or'#231'amentos/Pedidos'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 505
    Width = 1018
    Height = 26
    ExplicitTop = 505
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 937
      Height = 22
      ExplicitWidth = 937
      ExplicitHeight = 22
      object btnDetalhes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F2] Detalhes'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000060000000A0000000B0000000B0000000C0000000C0000000C0000
          000C0000000C0000000D0000000C000000080000000200000000000000000000
          000681594BBEB37B67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB177
          65FFB17763FFB07664FFB07664FF7E5448C00000000800000000000000000000
          0009B57D6BFFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFF8F0EBFFF9F0EAFFB17866FF0000000C00000000000000000000
          0009B7816DFFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFF8EBE4FFF6EBE4FFF9F1ECFFB37A68FF0000000C00000000000000000000
          0008B98472FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFF7ECE5FFF6ECE5FFFAF2EEFFB57D6BFF0000000C00000000000000000000
          0008BB8775FFFEFCFBFFF9F0EAFFBF9685FFBE9585FFBE9584FFBD9484FFBE94
          83FFBD9382FFF8EDE7FFFAF4EFFFB7816EFF0000000B00000000000000000000
          0007BE8A79FFFEFDFCFFF9F2EDFFF3E9E3FFF3E7E1FFF3E7E0FFF2E7E0FFF2E7
          DFFFF2E6DFFFF8EFE8FFFAF5F1FFBA8571FF0000000A00000000000000000000
          0006C08F7EFFFEFDFDFFFAF3EFFFC29A8AFFC19A8AFFC09989FFC09888FFC098
          87FFBF9787FFF8F0EAFFFBF6F3FFBB8975FF0000000A00000000000000000000
          0006C49380FFFEFEFDFFFBF5F1FFF5ECE6FFF5EBE6FFF4EAE5FFF4EAE5FFF3EA
          E3FFF3E9E3FFF9F1EBFFFCF7F4FFBE8B79FF0000000900000000000000000000
          0006C69686FFFEFEFDFFFAF5F3FFC4A090FFC49F8FFFC39E8EFFC39D8EFFC39C
          8CFFC39B8CFFFAF3EFFFFDF9F7FFC18E7DFF0000000900000000000000000000
          0005C99B8AFFFEFEFEFFFBF6F4FFF6EDEAFFF6EDE9FFF6EDE9FFF6EBE8FFF5EC
          E7FFF5ECE6FFFAF5F0FFFDFAF8FFC39382FF0000000800000000000000000000
          0005C99E8DFFFFFEFEFFFCF8F6FFC7A495FFC7A494FFC7A393FFC7A392FFC6A2
          92FFC5A192FFFBF6F1FFFDFBF9FFC69786FF0000000800000000000000000000
          0004CEA190FFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
          F5FFFBF7F4FFFCF7F3FFFDFCFAFFC89B8AFF0000000700000000000000000000
          0004CEA393FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
          F6FFFBF7F6FFFCF7F5FFFEFCFCFFCB9D8DFF0000000700000000000000000000
          0003D0A696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFFEFEFDFFCDA191FF0000000600000000000000000000
          00029C7C70BFD2A898FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A6
          95FFD0A595FFCFA595FFCFA494FF99786EC00000000300000000}
        TabOrder = 0
        OnClick = btnDetalhesClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 121
        Height = 22
        Align = alCustom
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmTodos: TBitBtnLocked
        Left = 247
        Top = 0
        Width = 121
        Height = 22
        Align = alCustom
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmTodosClick
      end
      object btnSelCol: TBitBtnLocked
        Left = 368
        Top = 0
        Width = 107
        Height = 22
        Align = alCustom
        Caption = 'Selecionar &Colunas'
        TabOrder = 3
        OnClick = btnSelColClick
      end
      object btnExportar: TBitBtnLocked
        Left = 475
        Top = 0
        Width = 85
        Height = 22
        Align = alCustom
        Caption = '&Exportar CSV'
        TabOrder = 4
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 1018
    ExplicitTop = 531
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
    Height = 169
    Align = alTop
    ParentColor = True
    TabOrder = 3
    object lbl1: TLabel
      Left = 22
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label1: TLabel
      Left = 10
      Top = 12
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 32
      Top = 60
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 18
      Top = 84
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label4: TLabel
      Left = 440
      Top = 35
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 692
      Top = 53
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 426
      Top = 59
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ocorr'#234'ncia Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 678
      Top = 77
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ocorr'#234'ncia Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 246
      Top = 12
      Width = 45
      Height = 14
      Caption = 'Situa'#231#227'o:'
    end
    object Label10: TLabel
      Left = 431
      Top = 12
      Width = 80
      Height = 14
      Caption = 'Situa'#231#227'o Pedido:'
    end
    object Label11: TLabel
      Left = 27
      Top = 108
      Width = 40
      Height = 14
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 69
      Top = 32
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 127
      Top = 32
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 8
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 69
      Top = 56
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 10
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
      Left = 127
      Top = 56
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 69
      Top = 80
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 14
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 127
      Top = 80
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskEmiIni: TcxDateEdit
      Tag = 99
      Left = 517
      Top = 31
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
    object mskEmifin: TcxDateEdit
      Tag = 99
      Left = 763
      Top = 49
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
      TabOrder = 9
      Width = 90
    end
    object btnConsultar: TBitBtnLocked
      Left = 654
      Top = 111
      Width = 126
      Height = 22
      Caption = '[F10] Confirmar'
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
      TabOrder = 19
      OnClick = btnConsultarClick
    end
    object mskOcoIni: TcxDateEdit
      Tag = 99
      Left = 517
      Top = 56
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
    object mskOcoFin: TcxDateEdit
      Tag = 99
      Left = 763
      Top = 74
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
    object edtEspDoc: TComboBoxFocus
      Left = 150
      Top = 8
      Width = 41
      Height = 22
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 1
      Text = 'PD'
      OnChange = edtEspDocChange
      Items.Strings = (
        ''
        'PD'
        'OR')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object GroupBox1: TGroupBox
      Left = 866
      Top = 74
      Width = 144
      Height = 46
      Caption = 'Legenda de cores'
      TabOrder = 20
      object Shape1: TShape
        Left = 16
        Top = 24
        Width = 25
        Height = 14
        Brush.Color = 8417535
      end
      object Label8: TLabel
        Left = 47
        Top = 24
        Width = 87
        Height = 14
        Caption = 'Campos alterados'
      end
    end
    object cbxSituacao: TComboBoxFocus
      Left = 297
      Top = 8
      Width = 125
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Items.Strings = (
        ''
        'Inclus'#227'o'
        'Altera'#231#227'o'
        'Exclus'#227'o')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbxSituacaoPedido: TComboBoxFocus
      Left = 517
      Top = 8
      Width = 143
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Items.Strings = (
        ''
        'N'#227'o Faturado'
        'Faturado'
        'Baixado n'#227'o ser'#225' entregue')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkPedMultFat: TCheckBox
      Left = 692
      Top = 8
      Width = 277
      Height = 17
      Hint = 
        'Isso vai fazer com que os registros apare'#231'am duplicados para cad' +
        'a novo faturamento dentro do mesmo pedido'
      Caption = 'Exibir diferentes Doc. Faturados p/ o mesmo Pedido?'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = chkPedMultFatClick
    end
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 69
      Top = 104
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 16
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 127
      Top = 104
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbRegcomAlteracao: TGroupBox
      Left = 426
      Top = 86
      Width = 219
      Height = 73
      Caption = 'Somente Registros com Altera'#231#227'o'
      TabOrder = 18
      object Label12: TLabel
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
          'Data de Emiss'#227'o'
          'Condi'#231#227'o de Pagamento'
          'Forma de Pagamento'
          'Portador'
          'Cliente')
      end
    end
    object chkExbFatPed: TCheckBox
      Left = 692
      Top = 26
      Width = 277
      Height = 17
      Hint = 
        'Clique aqui para exibir os documentos faturados vinculados aos p' +
        'edidos dos or'#231'amentos listados'
      Caption = 'Exibir faturamento dos pedidos nos or'#231'amentos'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  object pcDados: TcxPageControl [3]
    Left = 0
    Top = 169
    Width = 1018
    Height = 336
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tbAcompanhamento
    Properties.CustomButtons.Buttons = <>
    OnPageChanging = pcDadosPageChanging
    ClientRectBottom = 332
    ClientRectLeft = 4
    ClientRectRight = 1014
    ClientRectTop = 25
    object tbAcompanhamento: TcxTabSheet
      Caption = 'Acompanhamento'
      ImageIndex = 0
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1010
        Height = 307
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDadosView: TcxGridDBTableViewCitel
          OnKeyDown = cxgDadosViewKeyDown
          OnKeyPress = cxgDadosViewKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgDadosViewCustomDrawCell
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosViewMARCA: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'MARCA'
            Options.AutoWidthSizable = False
            Width = 21
          end
          object cxgDadosViewFGO_SITUAC: TcxGridDBColumn
            Caption = 'Situa'#231#227'o'
            DataBinding.FieldName = 'FGO_SITUAC'
            OnGetDataText = cxgDadosViewFGO_SITUACGetDataText
            Width = 55
          end
          object cxgDadosViewDTALOG: TcxGridDBColumn
            Caption = 'Data Log'
            DataBinding.FieldName = 'DTALOG'
            Width = 72
          end
          object cxgDadosViewHORLOG: TcxGridDBColumn
            Caption = 'Hora do Log'
            DataBinding.FieldName = 'HORLOG'
            Width = 65
          end
          object cxgDadosViewOPELOG: TcxGridDBColumn
            Caption = 'Ope. Log'
            DataBinding.FieldName = 'OPELOG'
            Width = 55
          end
          object cxgDadosViewFGO_DTAENT: TcxGridDBColumn
            Caption = 'Dta. Emi.'
            DataBinding.FieldName = 'FGO_DTAENT'
            Width = 82
          end
          object cxgDadosViewFGO_NUMDOC: TcxGridDBColumn
            Caption = 'N'#250'mero Documento'
            DataBinding.FieldName = 'FGO_NUMDOC'
            Width = 103
          end
          object cxgDadosViewFGO_ESPDOC: TcxGridDBColumn
            Caption = 'Esp.'
            DataBinding.FieldName = 'FGO_ESPDOC'
            Width = 48
          end
          object cxgDadosViewFGO_CODEMP: TcxGridDBColumn
            Caption = 'C'#243'd.Emp.'
            DataBinding.FieldName = 'FGO_CODEMP'
            Width = 48
          end
          object cxgDadosViewSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS'
            Width = 129
          end
          object cxgDadosViewTIPATE: TcxGridDBColumn
            Caption = 'Tipo Atendimento'
            DataBinding.FieldName = 'TIPATE'
            Width = 141
          end
          object cxgDadosViewFGO_NUMFAT: TcxGridDBColumn
            Caption = 'Doc. Fat.'
            DataBinding.FieldName = 'FGO_NUMFAT'
            Width = 93
          end
          object cxgDadosViewFGO_TIPFAT: TcxGridDBColumn
            Caption = 'Esp. Fat.'
            DataBinding.FieldName = 'FGO_TIPFAT'
            Width = 52
          end
          object cxgDadosViewFGO_EMPFAT: TcxGridDBColumn
            Caption = 'Emp. Fat.'
            DataBinding.FieldName = 'FGO_EMPFAT'
          end
          object cxgDadosViewFGO_CODCLI: TcxGridDBColumn
            Caption = 'Cod.Cli.'
            DataBinding.FieldName = 'FGO_CODCLI'
            Width = 82
          end
          object cxgDadosViewNOMCLI: TcxGridDBColumn
            Caption = 'Nome Cliente'
            DataBinding.FieldName = 'NOMCLI'
            Width = 261
          end
          object cxgDadosViewNOMPOR: TcxGridDBColumn
            Caption = 'Portador'
            DataBinding.FieldName = 'NOMPOR'
          end
          object cxgDadosViewFGO_CODVEN: TcxGridDBColumn
            Caption = 'C'#243'd. Ven.'
            DataBinding.FieldName = 'FGO_CODVEN'
            Width = 55
          end
          object cxgDadosViewFGO_TIPFRE: TcxGridDBColumn
            Caption = 'Tip. Frete'
            DataBinding.FieldName = 'FGO_TIPFRE'
            Width = 51
          end
          object cxgDadosViewFGO_CODTRA: TcxGridDBColumn
            Caption = 'C'#243'd. Tra.'
            DataBinding.FieldName = 'FGO_CODTRA'
            Width = 54
          end
          object cxgDadosViewFGO_TOTFRE: TcxGridDBColumn
            Caption = 'Tot. Frete'
            DataBinding.FieldName = 'FGO_TOTFRE'
            Width = 75
          end
          object cxgDadosViewFGO_CODCND: TcxGridDBColumn
            Caption = 'C'#243'd.Cnd.'
            DataBinding.FieldName = 'FGO_CODCND'
            Width = 55
          end
          object cxgDadosViewFGO_CONPAG: TcxGridDBColumn
            Caption = 'Con. Pag.'
            DataBinding.FieldName = 'FGO_CONPAG'
            Width = 54
          end
          object cxgDadosViewFGO_CODFPG: TcxGridDBColumn
            Caption = 'C'#243'd. Fpg.'
            DataBinding.FieldName = 'FGO_CODFPG'
            Width = 56
          end
          object cxgDadosViewFGO_TOTPRO: TcxGridDBColumn
            Caption = 'Tot. Produtos'
            DataBinding.FieldName = 'FGO_TOTPRO'
          end
          object cxgDadosViewFGO_DESESP: TcxGridDBColumn
            Caption = 'Desc. Especial'
            DataBinding.FieldName = 'FGO_DESESP'
          end
          object cxgDadosViewFGO_TOTSER: TcxGridDBColumn
            Caption = 'Tot. Ser.'
            DataBinding.FieldName = 'FGO_TOTSER'
            Width = 68
          end
          object cxgDadosViewFGO_DESACE: TcxGridDBColumn
            Caption = 'Desp. Acess.'
            DataBinding.FieldName = 'FGO_DESACE'
            Width = 84
          end
          object cxgDadosViewFGO_TOTIPI: TcxGridDBColumn
            Caption = 'Tot. Ipi'
            DataBinding.FieldName = 'FGO_TOTIPI'
          end
          object cxgDadosViewFGO_TOTRET: TcxGridDBColumn
            Caption = 'Tot. Ret.'
            DataBinding.FieldName = 'FGO_TOTRET'
            Width = 81
          end
          object cxgDadosViewFGO_VLRCON: TcxGridDBColumn
            Caption = 'Vlr. Cont'#225'bil'
            DataBinding.FieldName = 'FGO_VLRCON'
            Width = 78
          end
          object cxgDadosViewFGO_ENT_CD: TcxGridDBColumn
            Caption = 'Ent. CD'
            DataBinding.FieldName = 'FGO_ENT_CD'
            Width = 71
          end
          object cxgDadosViewFGO_OPRFLJ: TcxGridDBColumn
            Caption = 'Oper. Fora Lj.'
            DataBinding.FieldName = 'FGO_OPRFLJ'
            Width = 73
          end
          object cxgDadosViewFRMLOG: TcxGridDBColumn
            Caption = 'Form Log'
            DataBinding.FieldName = 'FRMLOG'
            Options.AutoWidthSizable = False
            Width = 200
          end
          object cxgDadosViewALTERACOES: TcxGridDBColumn
            DataBinding.FieldName = 'ALTERACOES'
            Visible = False
            VisibleForCustomization = False
            VisibleForEditForm = bFalse
          end
          object cxgDadosViewWTSMAQ: TcxGridDBColumn
            Caption = 'Nome M'#225'q.'
            DataBinding.FieldName = 'WTSMAQ'
          end
          object cxgDadosViewWTS_IP: TcxGridDBColumn
            Caption = 'Ip M'#225'q.'
            DataBinding.FieldName = 'WTS_IP'
          end
          object cxgDadosViewFGOINC: TcxGridDBColumn
            DataBinding.FieldName = 'FGOINC'
            Visible = False
          end
        end
        object cxgDadosStaView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDadosSta
          DataController.DetailKeyFieldNames = 'STA_SEQFGO'
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'STA_SEQFGO'
          DataController.MasterKeyFieldNames = 'FGOINC'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosStaViewDTAMUD: TcxGridDBColumn
            Caption = 'Data Status'
            DataBinding.FieldName = 'STA_DTAMUD'
            Options.Editing = False
          end
          object cxgDadosStaViewHRAMUD: TcxGridDBColumn
            Caption = 'Hora Status'
            DataBinding.FieldName = 'STA_HRAMUD'
            Options.Editing = False
          end
          object cxgDadosStaViewDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'STA_DESCRI'
            Options.Editing = False
          end
          object cxgDadosStaViewSEQFGO: TcxGridDBColumn
            DataBinding.FieldName = 'STA_SEQFGO'
            Visible = False
          end
        end
        object cxgDadosLevel1: TcxGridLevel
          GridView = cxgDadosView
        end
      end
    end
    object tbStatus: TcxTabSheet
      Caption = 'Altera'#231#227'o de Status'
      ImageIndex = 1
      object cxgStatus: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1010
        Height = 307
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgStatusView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDadosSta
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgStatusViewDOCUMENTO: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'DOCUMENTO'
          end
          object cxgStatusViewDTAMUD: TcxGridDBColumn
            Caption = 'Data Status'
            DataBinding.FieldName = 'STA_DTAMUD'
          end
          object cxgStatusViewHRAMUD: TcxGridDBColumn
            Caption = 'Hora Status'
            DataBinding.FieldName = 'STA_HRAMUD'
          end
          object cxgStatusViewDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'STA_DESCRI'
          end
        end
        object cxgStatusLevel1: TcxGridLevel
          GridView = cxgStatusView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 304
  end
  object dtsDados: TDataSource
    Left = 384
    Top = 272
  end
  object imgLista: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 12583416
    ImageInfo = <
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000DEDEDE00D6D6D600D6D6D600D6D6
          D600DEDEDE000000000000000000000000000000000000000000000000000000
          000000000000BDBDF70000000000000000000000000000000000000000000000
          00000000000000000000BDBDF700000000000000000000000000000000000000
          00006B6BE7000000CE008484E700000000000000000000000000000000000000
          0000000000008484E7000000CE006B6BE700000000000000000000000000BDBD
          EF000000CE000000CE000000CE008484E7000000000000000000000000000000
          00008484E7000000CE000000CE000000CE00BDBDEF0000000000000000000000
          00008484E7000000C6000000C6000000C6008484E70000000000000000008484
          E7000000C6000000C6000000C6008484E7000000000000000000000000000000
          0000000000008484DE000000BD000000BD000000BD008484DE008484DE000000
          BD000000BD000000BD008484DE00000000000000000000000000000000000000
          000000000000000000008484DE000000B5000000B5000000B5000000B5000000
          B5000000B5008484DE0000000000000000000000000000000000000000000000
          00000000000000000000000000008484DE000000B5000000B5000000B5000000
          B5008484DE000000000000000000000000000000000000000000000000000000
          00000000000000000000000000008484D6000000AD000000AD000000AD000000
          AD008484D6000000000000000000000000000000000000000000000000000000
          000000000000000000008484D6000000A5000000A5000000A5000000A5000000
          A5000000A5008484D60000000000000000000000000000000000000000000000
          0000000000008484D60000009C0000009C0000009C008484D6008484D6000000
          A5000000A5000000A5008484D600000000000000000000000000000000000000
          00008484CE0000009C0000009C0000009C008484CE0000000000000000008484
          CE0000009C0000009C0000009C008484CE00000000000000000000000000BDBD
          DE000000940000009400000094008484CE000000000000000000000000000000
          00008484CE00000094000000940000009400BDBDE70000000000000000000000
          00006B6BBD0000008C008484CE00000000000000000000000000000000000000
          0000000000008484CE0000008C006B6BBD000000000000000000000000000000
          000000000000BDBDDE0000000000000000000000000000000000000000000000
          00000000000000000000BDBDDE00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FC1F0000EFF70000C7E3000083C10000C1830000E0070000F00F0000F81F
          0000F81F0000F00F0000E0070000C183000083C10000C7E30000EFF70000FFFF
          0000}
      end
      item
        ImageClass = 'TBitmap'
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C6E7C60008A5390010AD420008AD420063AD730000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000052B56B004AE79C005AEFAD005AEFAD0021C66B0052A56B00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000018B55A0063FFCE006BFFCE0052FFC6004AFFBD0018C66B0052A563000000
          0000000000000000000000000000000000000000000000000000000000009CCE
          A50010DE840029FFB50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C
          52000000000000000000000000000000000000000000000000000000000042AD
          5A0000FF940000FF9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B5
          52004AA55A0000000000000000000000000000000000000000000000000000AD
          420000F7940029F7A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E7
          9C0018AD4A00399C4A000000000000000000000000000000000094C6940010CE
          63004AEFA50063F7B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7
          AD0084D69C0029AD4A0039A54A000000000000000000000000007BC6840052DE
          940073E7AD006BEFAD0094CE9C000000000000000000D6E7D60063B5730094E7
          B50094DEAD009CDEAD0039AD5200299431000000000000000000000000008CBD
          8C005AB573004AB56B0000000000000000000000000000000000D6E7D6006BB5
          7300ADE7BD00ADDEB500B5DEB50052AD630029943100D6EFD600000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000073B57B00C6E7C600BDDEBD00CEE7CE006BBD7B0073B57300000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000007BB57B00DEEFDE00E7F7E700A5D6A500ADCEAD00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000073A573008CBD8C00C6D6C60000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000C1FF0000C0FF0000C07F0000803F0000801F0000800F
          000004070000060300008F000000FFC00000FFE00000FFF10000FFFF0000FFFF
          0000}
      end>
  end
  object stfDialog: TSaveTextFileDialog
    DefaultExt = 'csv'
    Filter = 'Arquivo CSV|*.csv'
    Left = 560
    Top = 192
  end
  object dtsDadosSta: TDataSource
    Left = 232
    Top = 328
  end
end
