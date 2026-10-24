inherited frmRcxLiberacaoDeCaixas: TfrmRcxLiberacaoDeCaixas
  Width = 1068
  Height = 725
  Caption = 'Libera'#231#227'o de Caixas'
  Position = poMainFormCenter
  ExplicitWidth = 1068
  ExplicitHeight = 725
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 652
    Width = 1062
    ExplicitTop = 652
    ExplicitWidth = 1062
    inherited FlwBotoes: TFlowPanel
      Width = 1058
      ExplicitWidth = 1058
      object BtnMarcarTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 0
        OnClick = BtnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 1
        OnClick = btnDesmarcarTodosClick
      end
      object btnLiberar: TBitBtnLocked
        Left = 252
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F10 ] Liberar'
        TabOrder = 2
        OnClick = btnLiberarClick
      end
      object btnRestaurar: TBitBtnLocked
        Left = 378
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F11 ] Restaurar Lib.'
        TabOrder = 3
        OnClick = btnRestaurarClick
      end
      object btnExportarCSV: TBitBtnLocked
        Left = 504
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F12 ] Exportar CSV'
        TabOrder = 4
        OnClick = btnExportarCSVClick
      end
      object btnAjuda: TBitBtnLocked
        Left = 630
        Top = 0
        Width = 27
        Height = 21
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
        TabOrder = 5
        TabStop = False
        Visible = False
        OnClick = btnAjudaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 982
      ExplicitLeft = 982
    end
  end
  inherited pnlStatus: TPanel
    Top = 680
    Width = 1062
    ExplicitTop = 680
    ExplicitWidth = 1062
    inherited pnlNomeForm: TPanel
      Left = 891
      ExplicitLeft = 891
    end
    inherited pnlInfo: TPanel
      Width = 891
      ExplicitWidth = 891
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1062
    Height = 128
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object Label2: TLabel
      Left = 11
      Top = 79
      Width = 128
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo dos Fechamentos:'
    end
    object Label1: TLabel
      Left = 72
      Top = 12
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Caixa Origem:'
    end
    object Label3: TLabel
      Left = 90
      Top = 34
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label4: TLabel
      Left = 238
      Top = 79
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label5: TLabel
      Left = 77
      Top = 102
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fechamento:'
    end
    object Label6: TLabel
      Left = 371
      Top = 102
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object lblEmpresa: TLabel
      Left = 94
      Top = 56
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtDataInicial: TcxDateEdit
      Tag = 99
      Left = 141
      Top = 75
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
      Width = 89
    end
    object edtCodigoCaixa: TEditFocus
      Tag = 99
      Left = 141
      Top = 9
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodigoCaixaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDescricaoCaixa: TEditFocus
      Left = 209
      Top = 9
      Width = 350
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
    object edtCodigoOperador: TEditFocus
      Tag = 99
      Left = 141
      Top = 31
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomeOperador: TEditFocus
      Left = 209
      Top = 31
      Width = 350
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
    object btnCarregarLancamentos: TBitBtnLocked
      Left = 565
      Top = 99
      Width = 145
      Height = 22
      Align = alCustom
      Caption = '&Carregar Fechamentos'
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
      TabOrder = 10
      OnClick = btnCarregarLancamentosClick
    end
    object edtDataFinal: TcxDateEdit
      Tag = 99
      Left = 248
      Top = 75
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
      Width = 89
    end
    object cmbFechamento: TComboBoxFocus
      Left = 141
      Top = 99
      Width = 196
      Height = 22
      Style = csDropDownList
      ItemIndex = 3
      TabOrder = 8
      Text = 'Todos'
      Items.Strings = (
        'Zerado'
        'Positivo'
        'Negativo'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbStatus: TComboBoxFocus
      Left = 405
      Top = 99
      Width = 154
      Height = 22
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 9
      Text = 'Todos'
      Items.Strings = (
        'Liberado'
        'Pendente'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkLimparFiltros: TCheckBox
      Left = 565
      Top = 12
      Width = 164
      Height = 17
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object edtCodigoEmpresa: TEditFocus
      Tag = 99
      Left = 141
      Top = 53
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnExit = edtCodigoEmpresaExit
      OnKeyPress = edtCodigoEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomeEmpresa: TEditFocus
      Left = 209
      Top = 53
      Width = 350
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
  object pnlDados: TPanel [3]
    Left = 0
    Top = 128
    Width = 1062
    Height = 447
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object grdLancamentos: TcxGridCitel
      Left = 2
      Top = 2
      Width = 1058
      Height = 443
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDados: TcxGridDBTableViewCitel
        OnKeyDown = grdLancamentosDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosCustomDrawCell
        DataController.DetailKeyFieldNames = 'AUTOINCREM'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'AUTOINCREM'
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
        object grdLancamentosDadosCAIXA: TcxGridDBColumn
          Caption = 'Caixa'
          DataBinding.FieldName = 'CAIXA'
          Width = 159
        end
        object grdLancamentosDadosEMPRESA: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMPRESA'
          Width = 183
        end
        object grdLancamentosDadosOPERADOR: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'OPERADOR'
          Width = 178
        end
        object grdLancamentosDadosRCX_DTACAD: TcxGridDBColumn
          Caption = 'Data Fec.'
          DataBinding.FieldName = 'RCX_DTACAD'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Properties.DisplayFormat = 'dd/mm/yyyy'
          Properties.ReadOnly = True
          Width = 97
        end
        object grdLancamentosDadosRCX_VALDOC: TcxGridDBColumn
          Caption = 'Valor Lan'#231'.'
          DataBinding.FieldName = 'RCX_VALDOC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Width = 122
        end
        object grdLancamentosDadosRCX_VALDIV: TcxGridDBColumn
          Caption = 'Valor Divergente'
          DataBinding.FieldName = 'RCX_VALDIV'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 90
        end
        object grdLancamentosDadosRCX_NUMLAC: TcxGridDBColumn
          Caption = 'N'#250'm. Lacre'
          DataBinding.FieldName = 'RCX_NUMLAC'
          Width = 112
        end
        object grdLancamentosDadosRCX_OPEPER: TcxGridDBColumn
          Caption = 'Permitido por'
          DataBinding.FieldName = 'RCX_OPEPER'
          Width = 74
        end
        object grdLancamentosDadosRCX_DTAPER: TcxGridDBColumn
          Caption = 'Data/Hora Permiss'#227'o'
          DataBinding.FieldName = 'RCX_DTAPER'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Properties.DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
          Properties.Kind = ckDateTime
          Width = 125
        end
        object grdLancamentosDadosRCX_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'RCX_STATUS'
          Width = 132
        end
        object grdLancamentosDadosRCX_OPELIB: TcxGridDBColumn
          Caption = 'Liberado por'
          DataBinding.FieldName = 'RCX_OPELIB'
          Width = 73
        end
        object grdLancamentosDadosRCX_DTALIB: TcxGridDBColumn
          Caption = 'Data/Hora Libera'#231#227'o'
          DataBinding.FieldName = 'RCX_DTALIB'
          Width = 144
        end
        object grdLancamentosDadosRCX_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'RCX_MARDES'
          Visible = False
        end
      end
      object grdLancamentosDadosTFs: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosTFsCustomDrawCell
        DataController.DetailKeyFieldNames = 'AUTOINCREM_FEC'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'AUTOINCREM_FEC;RCX_SEQCON;RCX_CODOPE;MODALIDADE'
        DataController.MasterKeyFieldNames = 'AUTOINCREM'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosTFsRCX_SEQCON: TcxGridDBColumn
          Caption = 'Seq. Controle'
          DataBinding.FieldName = 'RCX_SEQCON'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 80
        end
        object grdLancamentosDadosTFsMODALIDADE: TcxGridDBColumn
          Caption = 'Modalidade'
          DataBinding.FieldName = 'MODALIDADE'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 75
        end
        object grdLancamentosDadosTFsRCX_CODOPE: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'RCX_CODOPE'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 75
        end
        object grdLancamentosDadosTFsVALOR: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALOR'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 80
        end
        object grdLancamentosDadosTFsDOCUMENTOS: TcxGridDBColumn
          DataBinding.FieldName = 'BOTAO'
          RepositoryItem = reqEditorbtnDocumentos
          OnGetProperties = grdLancamentosDadosTFsDOCUMENTOSGetProperties
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.ShowEditButtons = isebAlways
          Width = 30
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosTFsRCX_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'RCX_STATUS'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Width = 85
        end
        object grdLancamentosDadosTFsACOES: TcxGridDBColumn
          RepositoryItem = reqEditorbtnAcoes
          OnGetProperties = grdLancamentosDadosTFsACOESGetProperties
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.ShowEditButtons = isebAlways
          Width = 190
        end
        object grdLancamentosDadosTFsVALORSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'VALORSELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosTFsTRF_OPELIB: TcxGridDBColumn
          Caption = 'Status por'
          DataBinding.FieldName = 'TRF_OPELIB'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 160
        end
        object grdLancamentosDadosTFsTRF_DTALIB: TcxGridDBColumn
          Caption = 'Data/Hora Status'
          DataBinding.FieldName = 'TRF_DTALIB'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 110
        end
        object grdLancamentosDadosTFsTRF_MOTIVO: TcxGridDBColumn
          Caption = 'Motivo Recusa'
          DataBinding.FieldName = 'TRF_MOTIVO'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 220
        end
      end
      object grdLancamentosNivel: TcxGridLevel
        GridView = grdLancamentosDados
        object grdLancamentosLevelTF: TcxGridLevel
          GridView = grdLancamentosDadosTFs
        end
      end
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 575
    Width = 1062
    Height = 77
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      1062
      77)
    object Label7: TLabel
      Left = 773
      Top = 24
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Total:'
      ExplicitLeft = 766
    end
    object Label9: TLabel
      Left = 730
      Top = 47
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Selecionados:'
      ExplicitLeft = 723
    end
    object Label8: TLabel
      Left = 823
      Top = 6
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Quantidade '
      ExplicitLeft = 816
    end
    object Label10: TLabel
      Left = 902
      Top = 6
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Valor Lan'#231'. '
      ExplicitLeft = 895
    end
    object Label11: TLabel
      Left = 994
      Top = 6
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Valor Div.'
      ExplicitLeft = 987
    end
    object edtQtdLancamentos: TEditFocus
      Left = 801
      Top = 21
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object edtValorLancamentos: TEditFocus
      Left = 880
      Top = 21
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object edtQtdSelecionados: TEditFocus
      Left = 801
      Top = 44
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object edtLancamentosSel: TEditFocus
      Left = 880
      Top = 44
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object edtValorDivergente: TEditFocus
      Left = 959
      Top = 21
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object edtValorDivergenteSel: TEditFocus
      Left = 959
      Top = 44
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    object gpbTransferencias: TGroupBox
      Left = 178
      Top = 2
      Width = 528
      Height = 73
      Align = alLeft
      Caption = 'Dados das transfer'#234'ncias'
      TabOrder = 6
      object lblValorTransferencia: TLabel
        Left = 12
        Top = 20
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object lblDinheiroTransferencia: TLabel
        Left = 128
        Top = 20
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dinheiro:'
      end
      object lblCartaoTransferencia: TLabel
        Left = 131
        Top = 43
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cart'#227'o:'
      end
      object lblChequeAVistaTransferencia: TLabel
        Left = 248
        Top = 20
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chq. a Vis.:'
      end
      object lblChequePreTransferencia: TLabel
        Left = 257
        Top = 43
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chq. Pr'#233'.:'
      end
      object lblOrdemPagamentoTransferencia: TLabel
        Left = 395
        Top = 20
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ord. Pag.'
      end
      object edtValorTransferencia: TEditFocus
        Left = 46
        Top = 17
        Width = 73
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
      object edtDinheiroTransferencia: TEditFocus
        Left = 172
        Top = 17
        Width = 73
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
      object edtCartaoTransferencia: TEditFocus
        Left = 172
        Top = 40
        Width = 73
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
      object edtChequeAVistaTransferencia: TEditFocus
        Left = 308
        Top = 17
        Width = 73
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
      object edtChequePreTransferencia: TEditFocus
        Left = 308
        Top = 40
        Width = 73
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
      object edtOrdemPagamentoTransferencia: TEditFocus
        Left = 444
        Top = 17
        Width = 73
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
    end
    object gpbLegenda: TGroupBox
      Left = 2
      Top = 2
      Width = 176
      Height = 73
      Align = alLeft
      Caption = 'Legenda'
      TabOrder = 7
      object Shape3: TShape
        Left = 8
        Top = 16
        Width = 14
        Height = 14
      end
      object Label16: TLabel
        Left = 27
        Top = 16
        Width = 65
        Height = 14
        Caption = 'Selecionados'
      end
      object Label17: TLabel
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
      object Label18: TLabel
        Left = 28
        Top = 32
        Width = 104
        Height = 14
        Caption = 'Fechamento Liberado'
      end
      object Shape4: TShape
        Left = 8
        Top = 32
        Width = 14
        Height = 14
      end
      object Label19: TLabel
        Left = 11
        Top = 32
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
      end
      object Label20: TLabel
        Left = 27
        Top = 48
        Width = 107
        Height = 14
        Caption = 'Fechamento Pendente'
      end
      object Shape5: TShape
        Left = 8
        Top = 48
        Width = 14
        Height = 14
      end
      object Label21: TLabel
        Left = 11
        Top = 48
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 304
  end
  object dlgSalvarCSV: TSaveDialog
    DefaultExt = 'CSV'
    Filter = 'Arquivo CSV|*.CSV'
    Left = 848
    Top = 48
  end
  object reqEditor: TcxEditRepository
    Left = 472
    Top = 240
    PixelsPerInch = 96
    object reqEditorbtnDocumentos: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = '...'
          Default = True
          Kind = bkEllipsis
          LeftAlignment = True
        end>
      Properties.HideSelection = False
      Properties.ValidateOnEnter = False
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = reqEditorbtnDocumentosPropertiesButtonClick
    end
    object reqEditortxtTexto: TcxEditRepositoryTextItem
      Properties.AutoSelect = False
      Properties.ReadOnly = True
      Properties.ValidationOptions = [evoRaiseException, evoAllowLoseFocus]
    end
    object reqEditorbtnAcoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000048744558745469746C6500436F6E646974696F6E616C466F726D6174
            74696E7349636F6E53657453796D626F6C73436972636C6564333B436F6E6469
            74696F6E616C466F726D617474696E673B94FCCE9B0000037F49444154785E4D
            8C7F4C947500879FF7BD3B0808079A42CB940EA5C6940B50C34616382C584B6C
            45DA5CD3569368688B585371CDA5AB308AFC43B786F66B6169239072845E3F16
            295A27C9CF38404039E480E338EE8EE3BD7BDFF71BDCD6D6677BB6CF1F9FCFC3
            90BB11A7F7770009301457AECD79F344FAA9FDA732DB0E7DB97EEAD017EBDA0E
            9CCEACDF576D2902220079C2D78A63A69961F77970782E0248DB4A5727BC5E95
            D674B4365FFC74FD03D179FB9C707AAE88EED13AF14B6795A86E2814E59FA6FF
            B9A33CE541C030E6FD2D2C0090F25F3627161FB3D86BAD6F89617793E899A811
            37C62AC535C741D1315E25FAA63E170E8F55345CAD10E52733C7B797A5A401F2
            E0543D1260DC7D784D43414E61C19A87CC387C360CB2C0289990251949924012
            B826BD98EF7D84915137E7ADB51DF527FB1F750CF8FC866D7B53F29292561CCE
            CDCE62D8FD07120201E8082440A0D3D4DC4663633B9D03D7C9CFC9C139399110
            754F68ACA365D2668CB8CBF0CAFAB5EB70CCB4A1E92A2030081DA16B204B7C7B
            B69578D3268EBF7D8692F73660BF7395F4D40D74F7DA770035B22EF4F4D83809
            BF324DFFCD3B547E58C7C54BED0455851F2ED8488C7D92375E3A42F5D7A53CBB
            753346934AD4DD6179066090758D6541E126A0F869A8FB8B63A52D1803597CF4
            7113B1522EAF3E57C1573F1E2561F91C2BCC1104423384840B5D1391A91B97C4
            CAAAAAB9263DA320740A9FCEE374DD3BECDDF92E653BCFB26BEB013CBE9BB4DC
            3847C6FAE5789509425A88F1F97D48D195EE2B2EBFAC05E9713A67E6CD7E9625
            6924AC0C50F35D051B2D59C4C545F3FE6725143E93CDF4DC0873C15994A01FA7
            731A25A076019AECF7AADFD8FF71239099F28D9292168D2B64E3FB4BC769B737
            63889E2672918759C5CBECFC1964FA7BDDF83CEA79409580E8823DC9971FCE8A
            B7DC971C81A6875812733F171A3B181C19E2C5A22D48312E000C9201E76D155B
            CB54A7B576E809BF3BE436007AECE2C8D6D980785E964554FC521301D54386C5
            424EF663041845D582C8C80CF505E8B279955BDD9EEDB7BA67067EED2FD38C3F
            F7EDD372577FD229E0294DD5CF8C8D04931F488D444DEC413248A083CBA932DC
            AB303EA2748D0DFA5FFBDBEABC06A8BA50C16A2F019000634CBC69F1A6A295FB
            F376992F17EC5925C214AF125B769BDB1F7F21E948F422D352C004480BBF05C2
            E5BF6C4E392187076130023220000D082E30BFD7F95FFE050C0CBFF47E0D5F47
            0000000049454E44AE426082}
          Kind = bkText
        end
        item
          Caption = 'Recusar'
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000023744558745469746C650043616E63656C3B53746F703B457869743B
            426172733B526962626F6E3B4C9696B20000038849444154785E1D906B4C5367
            18C7FF3DBD40CB1A2E32B55C9D598B4CA675D8D13836652E9B0359B67D589665
            3259E644A52571644474CB4CB6ECC23770C4449DD38D2885005E4683AB69C616
            8DA12384264EC8AAAC0C9149A1175ACEE9E939CFDE9EE7E477F2CBFFB924E720
            E6E943CC3B8895D12B00A0FEE3D08167A75A5BBAEEB71D9D081E6B4DA549FBDD
            A3CEEFDD1F3658016818AA98A71FD1915E202DE980A19D741E3EF6E0F8A7FC7F
            673B6979E002C5BC43B4C2581EB8480BE7BA68E6441BEF3B72F03300990C8E1D
            5016554E7B55D6C1ED9543C6C2B5BB739FDF025988838424E4240F10A0D2EAA0
            D26540AD37203CFE17C2C187A3EDBFDE7CF3DAD4748403A06EA8A8E830AC5FB3
            3B7BAB1901B717AE23DFE1CEC5EBEC90A0E0EB71A3CFD981C0B017C6F252180B
            D6BD74BCFA856E003A0CBDFD966DF250532AD4FF038DB734D18557DF21CFB08F
            2E37B5D370ED5E72D7D52BEEF9654CE9F91C1FD392EB0C4D3A0E4BE7F6ECD909
            CFDEFAD381AF4ED0A3D35FD399E272BA3F3D478F971234FD2044BDCE930AF798
            CF2FAED0DF5373CACCFCA92F2970B29DDCAFD7F56B48945E918201C41738945A
            2D581C7461ADA3192AB50AD64F9A010272730CC8D4AA313BE44289D58CF85D3F
            2411504BB28D93845489145E041F9CC1863C09A11BD7E1EFEA86240339463DB2
            B3F59025C0DFD98DD0C83594E6886C360831F408523265D208BC0021B20A35A7
            82B8BC0429C2239A10D812417988007088B14C8A8421EA75A094044A8A48F200
            17E78587629220B370E69F2884EA3750F07E23245946868E43A64EA3B8695F23
            F8EA7A046763EC780AC9640AF155FEB1269AE0BD91AC8CFDF910108E26F15A5B
            33788D1E860CF6CDE7CF225D45FB3F02A0C7CE36076E5CBD84825C3562A20E4B
            097E0CAD051B5FFCA97C9BE4ABAEA05B2FDBE9E6BE0F880F8568FCDB0E1AA9AA
            646C579C654AEF564D15FDB96333FDBCC94A8E751B6A0140DF5168B9E42A7B86
            266AB6D2ED1A1BF559CAC853B58DFCB576F2D7D9D3AE64B777D96862D716EA2F
            2BA76F4CE62B008C1A00C2F9C57F9D8DA2C99212C5E72C85323699F320A77FD2
            72040021DF9885F56BF2204457706F9EC74C4CF2F744169A012430DBF21E00A8
            2B754F98BEC82EEEED7AF2291A306FA451EBD3346633938FF13BF341969D62BD
            CF738AAF6ED6EA4B006882CE77A14ABFD255D2799903606830E4EF28E274070C
            1C67D74255041044C25C9CE43B4149F8B16735F41B8038DB9300E07F6924ECFB
            01D589CC0000000049454E44AE426082}
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = reqEditorbtnAcoesPropertiesButtonClick
    end
    object reqEditorbtnAcoesDivergencia: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Default = True
          Kind = bkText
        end
        item
          Caption = 'Recusar'
          Kind = bkText
        end
        item
          Caption = 'Ajuste'
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = reqEditorbtnAcoesDivergenciaPropertiesButtonClick
    end
    object reqEditorbtnAcaoAceitar: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = reqEditorbtnAcaoAceitarPropertiesButtonClick
    end
    object reqEditorbtnAcoesDisabled: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Enabled = False
          Kind = bkText
        end
        item
          Caption = 'Recusar'
          Enabled = False
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object reqEditorbtnAcaoAceitarDisabled: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Enabled = False
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object reqEditorbtnAcoesDivergenciaDisabled: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Aceitar'
          Enabled = False
          Kind = bkText
        end
        item
          Caption = 'Recusar'
          Enabled = False
          Kind = bkText
        end
        item
          Caption = 'Ajuste'
          Enabled = False
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object reqEditorbtnDocumentosDisabled: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = '...'
          Enabled = False
          Kind = bkEllipsis
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
  end
end
