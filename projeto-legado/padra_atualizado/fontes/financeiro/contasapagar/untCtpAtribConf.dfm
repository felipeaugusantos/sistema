inherited frmCtpAtribConf: TfrmCtpAtribConf
  Left = 403
  Top = 305
  Width = 517
  Height = 354
  Caption = 'Altera'#231#227'o dos Dados das Duplicatas'
  ExplicitWidth = 517
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel [0]
    Left = 52
    Top = 12
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador:'
  end
  object ColorLabel2: TColorLabel [1]
    Left = 446
    Top = 83
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label11: TLabel [2]
    Left = 355
    Top = 86
    Width = 63
    Height = 14
    Alignment = taRightJustify
    Caption = 'Veio Boleto?:'
  end
  object Label4: TLabel [3]
    Left = 372
    Top = 107
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cheque?:'
  end
  object ColorLabel1: TColorLabel [4]
    Left = 446
    Top = 107
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label1: TLabel [5]
    Left = 372
    Top = 131
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'Veio NF?:'
  end
  object ColorLabel3: TColorLabel [6]
    Left = 446
    Top = 131
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label6: TLabel [7]
    Left = 367
    Top = 154
    Width = 51
    Height = 14
    Alignment = taRightJustify
    Caption = 'Previs'#227'o?:'
  end
  object ColorLabel4: TColorLabel [8]
    Left = 446
    Top = 154
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label7: TLabel [9]
    Left = 367
    Top = 177
    Width = 51
    Height = 14
    Alignment = taRightJustify
    Caption = 'Dep'#243'sito?:'
  end
  object ColorLabel5: TColorLabel [10]
    Left = 446
    Top = 177
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object lblPlaContas: TLabel [11]
    Left = 24
    Top = 83
    Width = 72
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data Cadastro:'
  end
  object Label2: TLabel [12]
    Left = 37
    Top = 107
    Width = 59
    Height = 14
    Alignment = taRightJustify
    Caption = 'Vencimento:'
  end
  object Label3: TLabel [13]
    Left = 68
    Top = 131
    Width = 28
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor:'
  end
  object Label8: TLabel [14]
    Left = 31
    Top = 154
    Width = 65
    Height = 14
    Alignment = taRightJustify
    Caption = 'Compet'#234'ncia:'
  end
  object Label9: TLabel [15]
    Left = 10
    Top = 186
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Hist'#243'rico:'
  end
  object edtPrevisao: TEditFocus [16]
    Tag = 99
    Left = 421
    Top = 149
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 11
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  object edtVeiobo: TEditFocus [17]
    Tag = 99
    Left = 421
    Top = 80
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  object edtDeposito: TEditFocus [18]
    Tag = 99
    Left = 421
    Top = 172
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 12
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  inherited pnlBotoes: TPanel
    Top = 281
    Width = 511
    TabOrder = 14
    ExplicitTop = 281
    ExplicitWidth = 511
    DesignSize = (
      511
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 507
      TabOrder = 2
      ExplicitWidth = 507
    end
    inherited btnSair: TBitBtnLocked
      Left = 407
      Width = 100
      ExplicitLeft = 407
      ExplicitWidth = 100
    end
    object btnGravar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 109
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 309
    Width = 511
    TabOrder = 15
    ExplicitTop = 309
    ExplicitWidth = 511
    inherited pnlNomeForm: TPanel
      Left = 340
      ExplicitLeft = 340
    end
    inherited pnlInfo: TPanel
      Width = 340
      ExplicitWidth = 340
    end
  end
  object mmHist: TMemoFocus [21]
    Left = 7
    Top = 200
    Width = 495
    Height = 74
    TabOrder = 13
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object edtVeioNF: TEditFocus [22]
    Tag = 99
    Left = 421
    Top = 126
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  object edtCheque: TEditFocus [23]
    Tag = 99
    Left = 421
    Top = 103
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 9
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  inline fraCentroCusto: TfraCentroCustoEditFocus [24]
    Left = 5
    Top = 32
    Width = 502
    Height = 22
    TabOrder = 2
    ExplicitLeft = 5
    ExplicitTop = 32
    ExplicitWidth = 502
    inherited lblEventos: TLabel
      Width = 87
      Height = 14
      ExplicitWidth = 87
      ExplicitHeight = 14
    end
    inherited edtCodEve: TEditFocus
      Width = 90
      Height = 22
      OnExit = fraCentro
      ExplicitWidth = 90
      ExplicitHeight = 22
    end
    inherited edtDesEve: TEditFocus
      Left = 187
      Width = 309
      Height = 22
      ExplicitLeft = 187
      ExplicitWidth = 309
      ExplicitHeight = 22
    end
  end
  object edtNomPor: TEditFocus [25]
    Left = 192
    Top = 8
    Width = 309
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
  inline fraPlanoDeContas: TfraPlanoDeContasMskEdit [26]
    Left = 15
    Top = 55
    Width = 492
    Height = 22
    TabOrder = 3
    ExplicitLeft = 15
    ExplicitTop = 55
    ExplicitWidth = 492
    ExplicitHeight = 22
    inherited lblPlaContas: TLabel
      Left = 0
      Top = 4
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
      ExplicitLeft = 0
      ExplicitWidth = 81
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 177
      Top = 0
      Width = 309
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      ExplicitLeft = 177
      ExplicitWidth = 309
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Tag = 99
      Left = 84
      Top = 0
      Width = 90
      Height = 22
      EditMask = '99.99.999;0;_'
      MaxLength = 9
      TabOrder = 1
      Text = ''
      OnExit = fraPlanoDeContasMskCodCtaExit
      OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
      ExplicitLeft = 84
      ExplicitWidth = 90
      ExplicitHeight = 22
    end
  end
  object edtCodPor: TEditFocus [27]
    Tag = 99
    Left = 99
    Top = 8
    Width = 90
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 0
    OnExit = edtCodPorExit
    OnKeyPress = edtCodPorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtValDup: TEditFocus [28]
    Tag = 99
    Left = 99
    Top = 128
    Width = 90
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 20
    TabOrder = 6
    OnExit = edtValDupExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object MskCompet: TMaskEditFocus [29]
    Tag = 99
    Left = 99
    Top = 151
    Width = 90
    Height = 22
    EditMask = '99/9999;1;_'
    MaxLength = 7
    TabOrder = 7
    Text = '  /    '
    OnExit = MskCompetExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object MskDtaVen: TcxDateEdit [30]
    Tag = 99
    Left = 99
    Top = 103
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
    OnExit = MskDtaVenExit
    Width = 90
  end
  object MskDtaCad: TcxDateEdit [31]
    Tag = 99
    Left = 99
    Top = 78
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
    OnExit = MskDtaCadExit
    Width = 90
  end
  inherited mnuAuxiliar: TPopupMenu [32]
    Left = 232
    Top = 92
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 283
    Top = 124
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 235
    Top = 143
  end
end
