inherited frmEstornaCartoes: TfrmEstornaCartoes
  Left = 318
  Top = 349
  Width = 845
  Height = 540
  BorderIcons = [biSystemMenu]
  Caption = 'Estorno de Cart'#245'es de Cr'#233'dito'
  ExplicitWidth = 845
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 457
    Width = 829
    TabOrder = 5
    ExplicitTop = 457
    ExplicitWidth = 829
    DesignSize = (
      829
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 825
      ExplicitWidth = 825
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 137
        ExplicitWidth = 137
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 137
        Width = 137
        ExplicitLeft = 137
        ExplicitWidth = 137
      end
      object btnMarcar: TBitBtnLocked
        Left = 274
        Top = 0
        Width = 137
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 411
        Top = 0
        Width = 137
        Height = 22
        Caption = '[ F8 ] Desmarcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FF00009ABB8E80FAF0DF00009AF9ECD6F9E9D100
          009A00009A00009A00009A00009A00009AF4DAB2B3897B00009AFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86FCF7EE006600FBF3E6FAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FFCFA089FDF9F2FDF7EEFBF5EBFCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          9F7B67BEBBB8BEBBB6BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00009A00009A00009A00009A00009A00009A00009A73
          2600993300993300993300993300993300F8E9D2B3897BFF00FF00009A4A79FF
          2F62FF0D43FF002BF6021AD100009ABEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00009A00009A00009A00009A00009A00009A00009AFD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          DEAD8EDAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnDesmarcarClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 548
        Top = 0
        Width = 137
        Height = 22
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 4
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 749
      Top = 2
      Caption = 'Sair'
      ExplicitLeft = 749
      ExplicitTop = 2
    end
  end
  inherited pnlHeader: TPanel
    Width = 829
    Height = 89
    TabOrder = 0
    ExplicitWidth = 829
    ExplicitHeight = 89
    object Label1: TLabel
      Left = 10
      Top = 15
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operadora do Cart'#227'o:'
    end
    object Label2: TLabel
      Left = 76
      Top = 39
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 212
      Top = 39
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label8: TLabel
      Left = 315
      Top = 39
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de'
    end
    object ColorLabel1: TColorLabel
      Left = 378
      Top = 39
      Width = 231
      Height = 14
      Caption = '(V)encimento (C)adastro (B)aixa (R)ecebimento'
      CorDestaque = clRed
    end
    object Label11: TLabel
      Left = 70
      Top = 64
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtCodCar: TEditFocus
      Tag = 99
      Left = 119
      Top = 11
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
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
      Left = 187
      Top = 11
      Width = 349
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
    object edtTipoData: TEditFocus
      Tag = 99
      Left = 354
      Top = 35
      Width = 20
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 4
      Text = 'V'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 119
      Top = 61
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 5
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 187
      Top = 61
      Width = 349
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
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 119
      Top = 35
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
      TabOrder = 2
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 222
      Top = 35
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
      TabOrder = 3
      Width = 90
    end
    object btnCarrTitulos: TBitBtnLocked
      Left = 542
      Top = 62
      Width = 121
      Height = 21
      Align = alCustom
      Caption = '&Carregar Cart'#245'es'
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
      OnClick = btnCarrTitulosClick
    end
  end
  inherited pnlTail: TPanel
    Top = 401
    Width = 829
    Height = 56
    TabOrder = 6
    Visible = True
    ExplicitTop = 401
    ExplicitWidth = 829
    ExplicitHeight = 56
    object gpbGeral: TGroupBox
      Left = 0
      Top = 0
      Width = 313
      Height = 56
      Align = alLeft
      Caption = 'Totais'
      TabOrder = 0
      object Label7: TLabel
        Left = 7
        Top = 27
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label9: TLabel
        Left = 166
        Top = 27
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vl. L'#237'q.:'
      end
      object edtQtdGer: TEditFocus
        Left = 67
        Top = 24
        Width = 97
        Height = 22
        Alignment = taLeftJustify
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
      object edtValGer: TEditFocus
        Left = 203
        Top = 24
        Width = 97
        Height = 22
        Alignment = taLeftJustify
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
    object gpbSelecionados: TGroupBox
      Left = 516
      Top = 0
      Width = 313
      Height = 56
      Align = alRight
      Caption = 'Selecionados:'
      TabOrder = 1
      object Label5: TLabel
        Left = 14
        Top = 27
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label6: TLabel
        Left = 174
        Top = 27
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vl. L'#237'q.:'
      end
      object edtQtdSel: TEditFocus
        Left = 74
        Top = 24
        Width = 97
        Height = 22
        Alignment = taLeftJustify
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
      object edtValSel: TEditFocus
        Left = 211
        Top = 24
        Width = 97
        Height = 22
        Alignment = taLeftJustify
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
  inherited dbgConsulta: TDBGridCitel
    Top = 129
    Width = 829
    Height = 272
    TabStop = False
    BorderStyle = bsNone
    TabOrder = 3
    Visible = False
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MCA_NUMCCD'
        Title.Caption = 'N'#250'm.Libera'#231#227'o'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_NUMNSU'
        Title.Caption = 'N'#250'm. NSU'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_CODEMP'
        Title.Caption = 'Emp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_DTAVEN'
        Title.Caption = 'Vencimento'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_DTACAD'
        Title.Caption = 'Cadastro'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_DTABAI'
        Title.Caption = 'Baixa'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_DTAREC'
        Title.Caption = 'Recebimento'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MCA_VALTOT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. Liq.'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MCA_VALSTA'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Original'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MCA_DOCUME'
        Title.Caption = 'Nota'
        Width = 162
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AUTOINCREM'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 89
    Width = 829
    TabOrder = 1
    ExplicitTop = 89
    ExplicitWidth = 829
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Tag = 99
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  inherited pnlStatus: TPanel
    Top = 485
    Width = 829
    TabOrder = 4
    ExplicitTop = 485
    ExplicitWidth = 829
    inherited pnlNomeForm: TPanel
      Left = 658
      ExplicitLeft = 658
    end
    inherited pnlInfo: TPanel
      Width = 658
      ExplicitWidth = 658
    end
  end
  object cxgConsulta: TcxGridCitel [7]
    Left = 0
    Top = 129
    Width = 829
    Height = 272
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsultaTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgConsultaTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgConsultaTableViewCellDblClick
      OnCustomDrawCell = cxgConsultaTableViewCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.AutoDataSetFilter = True
      DataController.Filter.TranslateBetween = True
      DataController.Filter.TranslateLike = True
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
      object cxgConsultaTableViewMCA_NUMCCD: TcxGridDBColumn
        Caption = 'N'#250'm.Libera'#231#227'o'
        DataBinding.FieldName = 'MCA_NUMCCD'
        Width = 83
      end
      object cxgConsultaTableViewMCA_NUMNSU: TcxGridDBColumn
        Caption = 'N'#250'm. NSU'
        DataBinding.FieldName = 'MCA_NUMNSU'
        Width = 87
      end
      object cxgConsultaTableViewMCA_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'MCA_CODEMP'
        Width = 27
      end
      object cxgConsultaTableViewMCA_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'MCA_DTAVEN'
        Width = 69
      end
      object cxgConsultaTableViewMCA_DTACAD: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'MCA_DTACAD'
        Width = 68
      end
      object cxgConsultaTableViewMCA_DTABAI: TcxGridDBColumn
        Caption = 'Baixa'
        DataBinding.FieldName = 'MCA_DTABAI'
        Width = 70
      end
      object cxgConsultaTableViewMCA_DTAREC: TcxGridDBColumn
        Caption = 'Recebimento'
        DataBinding.FieldName = 'MCA_DTAREC'
      end
      object cxgConsultaTableViewMCA_VALTOT: TcxGridDBColumn
        Caption = 'Vl. Liq.'
        DataBinding.FieldName = 'MCA_VALTOT'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgConsultaTableViewMCA_VALSTA: TcxGridDBColumn
        Caption = 'Valor Original'
        DataBinding.FieldName = 'MCA_VALSTA'
        HeaderAlignmentHorz = taRightJustify
        Width = 75
      end
      object cxgConsultaTableViewMCA_DOCUME: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'MCA_DOCUME'
        Width = 162
      end
      object cxgConsultaTableViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
    end
    object cxgConsultaLevel: TcxGridLevel
      GridView = cxgConsultaTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 72
  end
  inherited qryConsulta: TUniQuery
    Left = 280
    Top = 248
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 312
    Top = 248
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 344
    Top = 248
  end
  inherited dtsConsulta: TDataSource
    OnDataChange = dtsConsultaDataChange
    Left = 376
    Top = 248
  end
end
