inherited frmGerAutCtaReceber: TfrmGerAutCtaReceber
  Width = 640
  Height = 607
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o Autom'#225'tica de Contas a Receber'
  Position = poMainFormCenter
  ExplicitWidth = 640
  ExplicitHeight = 607
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 534
    Width = 634
    ExplicitTop = 534
    ExplicitWidth = 634
    inherited FlwBotoes: TFlowPanel
      Width = 630
      TabOrder = 1
      ExplicitWidth = 630
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F10]Gravar'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 555
      TabOrder = 0
      ExplicitLeft = 555
    end
  end
  inherited pnlStatus: TPanel
    Top = 562
    Width = 634
    ExplicitTop = 562
    ExplicitWidth = 634
    inherited pnlNomeForm: TPanel
      Left = 463
      ExplicitLeft = 463
    end
    inherited pnlInfo: TPanel
      Width = 463
      ExplicitWidth = 463
    end
  end
  object pnlCampos: TPanel [2]
    Left = 0
    Top = 0
    Width = 634
    Height = 154
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    OnEnter = pnlCamposEnter
    object Label5: TLabel
      Left = 48
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 38
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 351
      Top = 12
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label1: TLabel
      Left = 6
      Top = 59
      Width = 77
      Height = 14
      Caption = 'Data 1'#170' Parcela:'
    end
    object Label4: TLabel
      Left = 186
      Top = 59
      Width = 80
      Height = 14
      Caption = 'Valor 1'#170' Parcela:'
    end
    object Label6: TLabel
      Left = 351
      Top = 59
      Width = 62
      Height = 14
      Caption = 'Qtd. Parcela:'
    end
    object Label34: TLabel
      Left = 200
      Top = 82
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object Label35: TLabel
      Left = 341
      Top = 82
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros:'
    end
    object Label10: TLabel
      Left = 467
      Top = 82
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Cobran'#231'a:'
    end
    object Label11: TLabel
      Left = 3
      Top = 82
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dp. Descontada:'
    end
    object ColorLabel1: TColorLabel
      Left = 110
      Top = 82
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label8: TLabel
      Left = 345
      Top = 36
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtNomCli: TEditFocus
      Left = 144
      Top = 9
      Width = 196
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
    object edtNomEmp: TEditFocus
      Left = 144
      Top = 32
      Width = 196
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomPor: TEditFocus
      Left = 447
      Top = 9
      Width = 177
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtValParcela: TEditFocus
      Tag = 99
      Left = 267
      Top = 55
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdParcela: TEditFocus
      Tag = 99
      Left = 416
      Top = 55
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 10
      OnKeyPress = edtQtdParcelaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttInteiro
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 398
      Top = 9
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 85
      Top = 9
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnEnter = edtCodCliEnter
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      OnKeyUp = edtCodCliKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 85
      Top = 32
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object gpbVencimento: TGroupBox
      Left = 6
      Top = 99
      Width = 305
      Height = 43
      Caption = 'Vencimento'
      TabOrder = 16
      object lblPeriodicidade: TLabel
        Left = 181
        Top = 17
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Periodicidade:'
      end
      object lbl4: TLabel
        Left = 6
        Top = 17
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Usar dia Fixo:'
      end
      object lbl5: TColorLabel
        Left = 102
        Top = 17
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtPeriod: TEditFocus
        Tag = 99
        Left = 251
        Top = 13
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDiaFix: TEditFocus
        Tag = 99
        Left = 75
        Top = 13
        Width = 24
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'N'
        OnExit = edtDiaFixExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbCadastro: TGroupBox
      Left = 319
      Top = 99
      Width = 305
      Height = 43
      Caption = 'Cadastro'
      Enabled = False
      TabOrder = 17
      object lblSNCadast: TColorLabel
        Left = 102
        Top = 17
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        Enabled = False
        CorDestaque = clRed
      end
      object lblCadastro: TLabel
        Left = 6
        Top = 17
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Usar dia Fixo:'
        Enabled = False
      end
      object lblPeriodicidC: TLabel
        Left = 181
        Top = 17
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Periodicidade:'
        Enabled = False
      end
      object edtPeriodC: TEditFocus
        Tag = 99
        Left = 251
        Top = 13
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDiaFixC: TEditFocus
        Tag = 99
        Left = 75
        Top = 13
        Width = 24
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        OnExit = edtDiaFixCExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object mskDtaParcela: TcxDateEdit
      Tag = 99
      Left = 85
      Top = 55
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
      Width = 86
    end
    object chkDtCadFixa: TCheckBox
      Left = 460
      Top = 59
      Width = 164
      Height = 17
      Caption = 'Dta. Cadastro fixa em "Hoje"?'
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = chkDtCadFixaClick
    end
    object edtDesSuj: TEditFocus
      Tag = 99
      Left = 251
      Top = 79
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtJurSuj: TEditFocus
      Tag = 99
      Left = 373
      Top = 79
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesCob: TEditFocus
      Tag = 99
      Left = 551
      Top = 79
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDescon: TEditFocus
      Tag = 99
      Left = 85
      Top = 79
      Width = 24
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 12
      Text = 'N'
      OnExit = edtDiaFixExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 398
      Top = 32
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomVen: TEditFocus
      Left = 447
      Top = 32
      Width = 177
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
  end
  object pnlCamAlt: TPanel [3]
    Left = 0
    Top = 154
    Width = 634
    Height = 79
    Align = alTop
    Color = 16770261
    TabOrder = 4
    object Label17: TLabel
      Left = 29
      Top = 34
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object edtHist01: TEditFocus
      Tag = 99
      Left = 76
      Top = 31
      Width = 226
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 400
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirmar: TBitBtnLocked
      Left = 76
      Top = 53
      Width = 114
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
    object btnCancela: TBitBtnLocked
      Left = 189
      Top = 53
      Width = 114
      Height = 22
      Caption = 'C&ancelar'
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
      TabOrder = 5
      OnClick = btnCancelaClick
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = -18
      Top = 8
      Width = 327
      Height = 22
      TabOrder = 0
      ExplicitLeft = -18
      ExplicitTop = 8
      ExplicitWidth = 327
      inherited lblEventos: TLabel
        Left = 20
        Width = 72
        Height = 14
        Caption = 'Centro Custos:'
        ExplicitLeft = 20
        ExplicitWidth = 72
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 58
        Height = 22
        ExplicitWidth = 58
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 153
        Width = 167
        Height = 22
        ExplicitLeft = 153
        ExplicitWidth = 167
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 310
      Top = 7
      Width = 314
      Height = 22
      TabOrder = 1
      ExplicitLeft = 310
      ExplicitTop = 7
      ExplicitWidth = 314
      inherited lblPlaContas: TLabel
        Left = 1
        Width = 66
        Height = 14
        Caption = 'Plano Contas:'
        ExplicitLeft = 1
        ExplicitWidth = 66
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 124
        Width = 189
        Height = 22
        ExplicitLeft = 124
        ExplicitWidth = 189
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 69
        Width = 54
        Height = 22
        ExplicitLeft = 69
        ExplicitWidth = 54
        ExplicitHeight = 22
      end
    end
    object pnlProjeto: TPanel
      Left = 309
      Top = 30
      Width = 315
      Height = 22
      BevelOuter = bvNone
      TabOrder = 3
      object lblProjeto: TLabel
        Left = 29
        Top = 3
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Projeto: '
      end
      object edtCodPrj: TEditFocus
        Tag = 99
        Left = 70
        Top = 0
        Width = 54
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
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodPrjKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesPrj: TEditFocus
        Left = 125
        Top = 0
        Width = 189
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
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 233
    Width = 634
    Height = 301
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 243
    ExplicitHeight = 291
    object Panel1: TPanel
      Left = 1
      Top = 273
      Width = 632
      Height = 27
      Align = alBottom
      Color = 16770261
      Enabled = False
      ParentBackground = False
      TabOrder = 0
      ExplicitTop = 263
      object Label7: TLabel
        Left = 493
        Top = 7
        Width = 25
        Height = 14
        Caption = 'Total:'
      end
      object edtTotPar: TEditFocus
        Tag = 99
        Left = 526
        Top = 2
        Width = 97
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object grdDados: TcxGrid
      Left = 1
      Top = 1
      Width = 632
      Height = 272
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 262
      object grdDadosDBTableView1: TcxGridDBTableView
        OnKeyDown = grdDadosDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = grdDadosDBTableView1EditKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object grdDadosDBTableView1TMP_PARCEL: TcxGridDBColumn
          Caption = 'Parcela'
          DataBinding.FieldName = 'TMP_PARCEL'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 45
        end
        object grdDadosDBTableView1TMP_DTACAD: TcxGridDBColumn
          Caption = 'Data Cadastro'
          DataBinding.FieldName = 'TMP_DTACAD'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 80
        end
        object grdDadosDBTableView1TMP_DTAPAR: TcxGridDBColumn
          Caption = 'Data Parcela'
          DataBinding.FieldName = 'TMP_DTAPAR'
          PropertiesClassName = 'TcxDateEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object grdDadosDBTableView1TMP_VALPAR: TcxGridDBColumn
          Caption = 'Valor Parcela'
          DataBinding.FieldName = 'TMP_VALPAR'
          PropertiesClassName = 'TcxTextEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object grdDadosDBTableView1TMP_DESSUJ: TcxGridDBColumn
          Caption = 'Desconto'
          DataBinding.FieldName = 'TMP_DESSUJ'
          PropertiesClassName = 'TcxTextEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object grdDadosDBTableView1TMP_JURSUJ: TcxGridDBColumn
          Caption = 'Juros'
          DataBinding.FieldName = 'TMP_JURSUJ'
          PropertiesClassName = 'TcxTextEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object grdDadosDBTableView1TMP_DESCOB: TcxGridDBColumn
          Caption = 'Desp. Cobran'#231'a'
          DataBinding.FieldName = 'TMP_DESCOB'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 90
        end
        object grdDadosDBTableView1TMP_HISTOR: TcxGridDBColumn
          Caption = 'Hist'#243'rico'
          DataBinding.FieldName = 'TMP_HISTOR'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Width = 300
        end
      end
      object grdDadosLevel1: TcxGridLevel
        GridView = grdDadosDBTableView1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 467
    Top = 328
  end
end
