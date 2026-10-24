inherited frmCadMovCartoesParcelas: TfrmCadMovCartoesParcelas
  Width = 790
  Height = 621
  Caption = 'Altera'#231#227'o de dados das parcelas dos cart'#245'es'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  ExplicitWidth = 790
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 548
    Width = 784
    ExplicitTop = 548
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 780
      TabOrder = 1
      ExplicitWidth = 780
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F10] Gravar'
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
        OnClick = btnGravarClick
      end
      object btnVincularCredito: TBitBtnLocked
        Left = 97
        Top = 0
        Width = 184
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F11] Vincular Cr'#233'dito Cliente'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000B00000011000000120000
          0013000000130000001300000013000000120000000C00000003000000000000
          00000000000000000000000000000000000A184D38C2226B4DFF226A4CFF226A
          4BFF22694BFF22684BFF22684BFF21684AFF184A34C30000000B000000000000
          00000000000000000000000000000000000E267856FF49C59DFF3EBF94FF3CBE
          92FF3BBE91FF3ABD90FF38BC8FFF37BA8DFF22694BFF00000010000000000000
          00000000000000000000000000000000000E287C5AFF53CBA4FF37BE90FF36BE
          90FF37BD90FF36BD8FFF35BC8FFF3CBE93FF236C4EFF00000010000000000000
          00000000000000000000000000000000000D2A815FFF5DD1AEFF39C295FF39C1
          95FF39C094FF38BF93FF38BF93FF41C599FF246F50FF0000000F000000020000
          00070000000B0000000C0000000C000000152C8663FF66D6B6FF3CC59AFF3BC4
          98FF3BC498FF3BC397FF3AC396FF47C8A0FF267254FF0000000E000000061E59
          41BE287959FF277858FF287757FF277757FF2E8766FF4BB694FF45B490FF50BE
          9CFF5ED4B0FF55D0AAFF49CBA2FF4ECDA6FF277657FF0000000D000000083395
          71FF88E5CDFF65D9B9FF62D9B8FF62D8B6FF52BC9BFF81E1C6FF6EDCBCFF58BC
          9EFF68DAB8FF65D8B6FF62D7B4FF6CDABAFF297B5BFF0000000C00000008349A
          75FF90E8D2FF42CEA5FF42CEA4FF42CEA4FF51BC9BFF8BE6CDFFA2EDD8FF7BC8
          B2FFAFEEDEFFACEDDCFFA7EDDAFFA4EBD8FF2B805FFF0000000A00000007369E
          7AFF98EBD6FF43D0A6FF43D0A6FF43D0A6FF3FBD96FF3EB791FF56BFA0FF3392
          70FF339672FF339671FF339471FF329370FF226349C3000000060000000638A2
          7EFFA0EDDAFF44D1A7FF44D1A7FF44D1A7FF44D0A7FF44D0A6FF6DDEBFFF2D86
          64FF0000000D0000000800000008000000080000000500000002000000053AA6
          81FFA6EEDDFF65DDBBFF7AE4C7FF81E6CBFF71E1C2FF5BD9B5FF72E0C2FF2F8C
          6AFF000000070000000000000000000000000000000000000000000000043BAA
          84FFD5F8EFFF9DF0DBFF98EED8FF92ECD5FF8DEAD2FF87E8CEFF9EEDD9FF3293
          70FF000000060000000000000000000000000000000000000000000000033CAD
          87FFE9FDF9FFE8FCF7FFE5FCF7FFE3FBF6FFE0FAF4FFDDFAF3FFDAF9F2FF3599
          76FF000000040000000000000000000000000000000000000000000000022D81
          64BF3DAE88FF3CAE87FF3DAD87FF3DAD87FF3DAC87FF3CAC87FF3CAC85FF2876
          5BBF000000020000000000000000000000000000000000000000000000000000
          0001000000020000000200000002000000020000000200000003000000030000
          0002000000010000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnVincularCreditoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 701
      TabOrder = 0
      ExplicitLeft = 701
    end
  end
  inherited pnlStatus: TPanel
    Top = 576
    Width = 784
    ExplicitTop = 576
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 548
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object pnlDados: TPanel
      Left = 2
      Top = 2
      Width = 780
      Height = 266
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object Label6: TLabel
        Left = 32
        Top = 12
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Libera'#231#227'o N'#186':'
      end
      object Label16: TLabel
        Left = 234
        Top = 12
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#186' NSU:'
      end
      object Label17: TLabel
        Left = 212
        Top = 62
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da Transa'#231#227'o:'
      end
      object Label9: TLabel
        Left = 21
        Top = 87
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor sem Taxa:'
      end
      object lblConNsu: TLabel
        Left = 418
        Top = 12
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Confirme o NSU:'
      end
      object Label4: TLabel
        Left = 63
        Top = 38
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cart'#227'o:'
      end
      object Label7: TLabel
        Left = 11
        Top = 63
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data de Cadastro:'
      end
      object Label10: TLabel
        Left = 252
        Top = 88
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Taxas Adm.:'
      end
      object Label11: TLabel
        Left = 403
        Top = 88
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label29: TLabel
        Left = 441
        Top = 87
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor das Tx. Adm.:'
      end
      object edtDtaCup: TcxDateEdit
        Tag = 99
        Left = 313
        Top = 59
        AutoSize = False
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
        Properties.ShowTime = False
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 6
        Height = 22
        Width = 87
      end
      object edtNumCCD: TEditFocus
        Tag = 99
        Left = 100
        Top = 9
        Width = 113
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 14
        TipoTexto = ttAlfanumerico
      end
      object edtNumNSU: TEditFocus
        Tag = 99
        Left = 275
        Top = 9
        Width = 125
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 14
        TabOrder = 1
        OnKeyPress = edtNumNSUKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 14
        TipoTexto = ttAlfanumerico
      end
      object edtConNsu: TEditFocus
        Tag = 99
        Left = 501
        Top = 9
        Width = 124
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 14
        PasswordChar = '*'
        TabOrder = 2
        OnKeyPress = edtNumNSUKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 14
        TipoTexto = ttAlfanumerico
      end
      object edtValSta: TEditFocus
        Tag = 99
        Left = 100
        Top = 83
        Width = 87
        Height = 22
        Alignment = taRightJustify
        MaxLength = 14
        TabOrder = 7
        OnExit = edtValStaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 14
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object grbMovBan: TGroupBox
        Left = 8
        Top = 108
        Width = 762
        Height = 38
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 10
        object Label25: TLabel
          Left = 6
          Top = 12
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object edtDesPorCar: TEditFocus
          Left = 96
          Top = 9
          Width = 244
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtPorCar: TEditFocus
          Tag = 99
          Left = 52
          Top = 9
          Width = 42
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 1
          OnKeyPress = edtPorCarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
          Left = 356
          Top = 9
          Width = 399
          Height = 22
          TabOrder = 2
          ExplicitLeft = 356
          ExplicitTop = 9
          ExplicitWidth = 399
          inherited lblPlaContas: TLabel
            Left = 1
            Top = 3
            Width = 81
            Height = 14
            ExplicitLeft = 1
            ExplicitTop = 3
            ExplicitWidth = 81
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 146
            Width = 251
            Height = 22
            ExplicitLeft = 146
            ExplicitWidth = 251
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 84
            Width = 60
            Height = 22
            OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
            ExplicitLeft = 84
            ExplicitWidth = 60
            ExplicitHeight = 22
          end
        end
      end
      object edtCodCar: TEditFocus
        Tag = 99
        Left = 100
        Top = 34
        Width = 87
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 3
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
        Left = 188
        Top = 34
        Width = 437
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtPerCar: TEditFocus
        Tag = 99
        Left = 313
        Top = 83
        Width = 87
        Height = 22
        Alignment = taRightJustify
        MaxLength = 14
        TabOrder = 8
        OnExit = edtPerCarExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 14
        TipoTexto = ttNumerico
        EditFormat = ',0.000000'
      end
      object edtValTax: TEditFocus
        Tag = 99
        Left = 539
        Top = 83
        Width = 87
        Height = 22
        Alignment = taRightJustify
        MaxLength = 14
        TabOrder = 9
        OnExit = edtValTaxExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 14
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDtaCad: TcxDateEdit
        Tag = 99
        Left = 100
        Top = 58
        AutoSize = False
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
        Properties.ShowTime = False
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 5
        Height = 22
        Width = 87
      end
      object grpFrete: TGroupBox
        Left = 8
        Top = 149
        Width = 465
        Height = 40
        Caption = 'Frete Market Place'
        TabOrder = 11
        Visible = False
        object lblValorFrete: TLabel
          Left = 265
          Top = 16
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total do  Frete:'
        end
        object chkDesmembrarFrete: TCheckBox
          Left = 10
          Top = 16
          Width = 249
          Height = 17
          Caption = 'Desmembrar valor do Frete entre as parcelas '
          TabOrder = 0
        end
        object edtValorFrete: TEditFocus
          Tag = 99
          Left = 370
          Top = 13
          Width = 87
          Height = 22
          Alignment = taRightJustify
          MaxLength = 14
          TabOrder = 1
          OnExit = edtValStaExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 14
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object pnlConfirma: TPanel
        Left = 2
        Top = 192
        Width = 776
        Height = 72
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 12
        object rdgAltVal: TRadioGroup
          Left = 7
          Top = 4
          Width = 465
          Height = 34
          Caption = ' Alterar Valor '
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Primeira parcela'
            #218'ltima parcela'
            'Todas as parcelas')
          TabOrder = 0
        end
        object btnIncluirParcela: TBitBtnLocked
          Left = 7
          Top = 43
          Width = 140
          Height = 22
          Caption = '&Incluir nova parcela'
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
          TabOrder = 1
          OnClick = btnIncluirParcelaClick
        end
        object btnExcluirParcela: TBitBtnLocked
          Left = 153
          Top = 43
          Width = 140
          Height = 22
          Caption = '&Excluir '#250'ltima parcela'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnExcluirParcelaClick
        end
        object btnCancela: TBitBtnLocked
          Left = 684
          Top = 43
          Width = 84
          Height = 22
          Caption = 'Cancela&r'
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
          TabOrder = 3
          OnClick = btnCancelaClick
        end
        object btnConfirmar: TBitBtnLocked
          Left = 597
          Top = 43
          Width = 82
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 4
          OnClick = btnConfirmarClick
        end
      end
    end
    object pnlTotal: TPanel
      Left = 2
      Top = 516
      Width = 780
      Height = 30
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        780
        30)
      object Label23: TLabel
        Left = 611
        Top = 7
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total:'
        ExplicitLeft = 534
      end
      object Label1: TLabel
        Left = 453
        Top = 7
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Parcelas:'
        ExplicitLeft = 376
      end
      object edtValTot: TEditFocus
        Left = 667
        Top = 4
        Width = 93
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
      object edtQtdPar: TEditFocus
        Left = 528
        Top = 4
        Width = 76
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
    end
    object grdDuplic: TcxGridCitel
      Left = 2
      Top = 268
      Width = 780
      Height = 248
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdDuplicDados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsMovCar
        DataController.Filter.Options = [fcoCaseInsensitive]
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
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn
          Caption = 'N'#250'm. Libera'#231#227'o'
          DataBinding.FieldName = 'MCA_NUMCCD'
          Width = 90
        end
        object grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn
          Caption = 'NSU'
          DataBinding.FieldName = 'MCA_NUMNSU'
          Width = 110
        end
        object grdDuplicDadosMCA_DTACAD: TcxGridDBColumn
          Caption = 'Dt. Cadastro'
          DataBinding.FieldName = 'MCA_DTACAD'
          Width = 68
        end
        object grdDuplicDadosMCA_DTACUP: TcxGridDBColumn
          Caption = 'Dt.Transa'#231#227'o'
          DataBinding.FieldName = 'MCA_DTACUP'
          Width = 74
        end
        object grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn
          Caption = 'Dt. Vencto.'
          DataBinding.FieldName = 'MCA_DTAVEN'
          Width = 68
        end
        object grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn
          Caption = 'N'#250'm. Nota'
          DataBinding.FieldName = 'MCA_DOCUME'
          Width = 155
        end
        object grdDuplicDadosMCA_CODCAR: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'MCA_CODCAR'
          OnGetDisplayText = grdDuplicDadosMCA_CODCARGetDisplayText
          Width = 180
        end
        object grdDuplicDadosPARDUP: TcxGridDBColumn
          Caption = 'Parc'
          DataBinding.FieldName = 'MCA_PARCEL'
          HeaderAlignmentHorz = taCenter
          Width = 28
        end
        object grdDuplicDadosMCA_VALSTA: TcxGridDBColumn
          Caption = 'Vl. s/ Taxa'
          DataBinding.FieldName = 'MCA_VALSTA'
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object grdDuplicDadosMCA_PERCAR: TcxGridDBColumn
          Caption = 'Tx. Adm. %'
          DataBinding.FieldName = 'MCA_PERCAR'
          HeaderAlignmentHorz = taRightJustify
          Width = 65
        end
        object grdDuplicDadosMCA_VALTAX: TcxGridDBColumn
          Caption = 'Val. Taxa'
          DataBinding.FieldName = 'MCA_VALTAX'
          HeaderAlignmentHorz = taRightJustify
          Width = 65
        end
        object grdDuplicDadosMCA_CODPOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'MCA_PORCAR'
          OnGetDisplayText = grdDuplicDadosMCA_CODPORGetDisplayText
          Width = 180
        end
        object grdDuplicDadosMCA_CODCTA: TcxGridDBColumn
          Caption = 'Pl. Contas'
          DataBinding.FieldName = 'MCA_CTACAR'
          OnGetDisplayText = grdDuplicDadosMCA_CODCTAGetDisplayText
          Width = 180
        end
      end
      object grdDuplicNivel: TcxGridLevel
        GridView = grdDuplicDados
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 256
  end
  object dtsMovCar: TDataSource
    AutoEdit = False
    Left = 144
    Top = 288
  end
end
