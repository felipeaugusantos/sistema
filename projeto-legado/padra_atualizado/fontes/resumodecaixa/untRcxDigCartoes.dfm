inherited frmRcxDigCartoes: TfrmRcxDigCartoes
  Left = 277
  Top = 251
  Width = 676
  Height = 326
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Cart'#245'es de Cr'#233'dito'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 676
  ExplicitHeight = 326
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Top = 344
    Width = 670
    Height = 31
    Align = alNone
    TabOrder = 6
    Visible = False
    ExplicitTop = 344
    ExplicitWidth = 670
    ExplicitHeight = 31
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 662
      ExplicitHeight = 21
    end
  end
  object pnlATop: TPanel [1]
    Left = 0
    Top = 0
    Width = 670
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 65
      Width = 123
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Cupom (NSU):'
    end
    object lblNumLib: TLabel
      Left = 23
      Top = 40
      Width = 106
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero de Libera'#231#227'o:'
    end
    object Label2: TLabel
      Left = 49
      Top = 14
      Width = 78
      Height = 14
      Caption = 'Valor do Cart'#227'o:'
    end
    object Label11: TLabel
      Left = 236
      Top = 14
      Width = 80
      Height = 14
      Caption = 'Data Transa'#231#227'o:'
    end
    object edtValCar: TEditFocus
      Tag = 99
      Left = 132
      Top = 10
      Width = 90
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 0
      OnKeyPress = edtValCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtNumCcd: TEditFocus
      Tag = 99
      Left = 132
      Top = 36
      Width = 192
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 2
      OnKeyPress = edtNumCcdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumNsu: TEditFocus
      Tag = 99
      Left = 132
      Top = 62
      Width = 129
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      TabOrder = 3
      OnKeyPress = edtNumNsuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 14
      TipoTexto = ttAlfanumerico
    end
    object mskDtaTra: TcxDateEdit
      Tag = 99
      Left = 324
      Top = 9
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
      TabOrder = 1
      Width = 91
    end
  end
  object pnlConfirma: TPanel [2]
    Left = 0
    Top = 85
    Width = 670
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label5: TLabel
      Left = 7
      Top = 6
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Confirme o n'#186' do Cupom:'
    end
    object edtNumNsuCon: TEditFocus
      Tag = 99
      Left = 132
      Top = 3
      Width = 129
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      PasswordChar = '*'
      TabOrder = 0
      OnKeyPress = edtNumNsuConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 14
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 219
    Width = 670
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 248
    object Label7: TLabel
      Left = 111
      Top = 10
      Width = 66
      Height = 14
      Caption = 'Total Digitado:'
    end
    object Label8: TLabel
      Left = 280
      Top = 10
      Width = 54
      Height = 14
      Caption = 'Total Geral:'
    end
    object edtTotDig: TEditFocus
      Left = 183
      Top = 6
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotGer: TEditFocus
      Left = 337
      Top = 6
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 111
    Width = 670
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label3: TLabel
      Left = 92
      Top = 7
      Width = 35
      Height = 14
      Caption = 'Cart'#227'o:'
    end
    object Label4: TLabel
      Left = 247
      Top = 35
      Width = 28
      Height = 14
      Caption = 'Valor:'
      Visible = False
    end
    object lblCndPag: TLabel
      Left = 8
      Top = 60
      Width = 119
      Height = 14
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object Label6: TLabel
      Left = 58
      Top = 87
      Width = 69
      Height = 14
      Caption = 'Observa'#231#245'es:'
    end
    object Label9: TLabel
      Left = 9
      Top = 34
      Width = 118
      Height = 14
      Caption = 'Quantidade de Parcelas:'
    end
    object edtCodCar: TEditFocus
      Tag = 99
      Left = 132
      Top = 3
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodCarExit
      OnKeyPress = edtCodCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCar: TEditFocus
      Left = 191
      Top = 3
      Width = 224
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtTotCar: TEditFocus
      Tag = 99
      Left = 280
      Top = 31
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 3
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 132
      Top = 57
      Width = 526
      Height = 22
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 4
      Text = ''
      OnKeyPress = mskCndPagKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtObsCar: TEditFocus
      Tag = 99
      Left = 132
      Top = 83
      Width = 526
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 5
      OnKeyPress = edtObsCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdPar: TEditFocus
      Tag = 99
      Left = 132
      Top = 30
      Width = 59
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 2
      OnChange = edtQtdParChange
      OnKeyPress = edtQtdParKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 281
    Width = 670
    TabOrder = 5
    ExplicitTop = 310
    ExplicitWidth = 670
    inherited pnlNomeForm: TPanel
      Left = 499
      ExplicitLeft = 499
    end
    inherited pnlInfo: TPanel
      Width = 499
      ExplicitWidth = 499
    end
  end
  inherited pnlBotoes: TPanel [6]
    Top = 251
    Width = 670
    Height = 30
    Enabled = True
    TabOrder = 4
    Visible = True
    ExplicitTop = 280
    ExplicitWidth = 670
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 483
      Height = 26
      TabOrder = 3
      ExplicitLeft = 74
      ExplicitWidth = 483
      ExplicitHeight = 26
    end
    inherited btnSair: TBitBtnLocked
      Left = 591
      Top = 2
      Height = 26
      Align = alRight
      ExplicitLeft = 591
      ExplicitTop = 2
      ExplicitHeight = 26
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
      Height = 26
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAjuda: TBitBtnLocked
      Left = 557
      Top = 2
      Width = 34
      Height = 26
      Align = alRight
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
      TabOrder = 2
      TabStop = False
      OnClick = btnAjudaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 80
  end
end
