inherited frmGeraLivroCaixa: TfrmGeraLivroCaixa
  Left = 322
  Top = 303
  Width = 505
  Height = 336
  Caption = 'Gera'#231#227'o de Livro Caixa'
  OnClose = FormClose
  ExplicitWidth = 505
  ExplicitHeight = 336
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel [0]
    Left = 107
    Top = 24
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador:'
  end
  object lblCodEmp: TLabel [1]
    Left = 106
    Top = 48
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label2: TLabel [2]
    Left = 112
    Top = 144
    Width = 39
    Height = 14
    Alignment = taRightJustify
    Caption = 'Per'#237'odo:'
  end
  object Label3: TLabel [3]
    Left = 254
    Top = 144
    Width = 6
    Height = 14
    Alignment = taRightJustify
    Caption = 'a'
  end
  object Label7: TLabel [4]
    Left = 8
    Top = 120
    Width = 143
    Height = 14
    Alignment = taRightJustify
    Caption = 'Plano de Contas para Cr'#233'dito:'
  end
  object lblPortador: TLabel [5]
    Left = 55
    Top = 72
    Width = 96
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador de Origem:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblCCustoOri: TLabel [6]
    Left = 18
    Top = 96
    Width = 133
    Height = 14
    Alignment = taRightJustify
    Caption = 'Plano de Contas de Origem:'
  end
  inherited pnlBotoes: TPanel
    Top = 263
    Width = 499
    TabOrder = 14
    ExplicitTop = 263
    ExplicitWidth = 499
    inherited FlwBotoes: TFlowPanel
      Top = 2
      Width = 495
      Height = 24
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 495
      ExplicitHeight = 24
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Gravar'
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
        ModalResult = 1
        TabOrder = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 419
      Top = 2
      TabOrder = 0
      ExplicitLeft = 419
      ExplicitTop = 2
    end
  end
  object edtCodPor: TEditFocus [9]
    Tag = 99
    Left = 160
    Top = 16
    Width = 57
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    ReadOnly = True
    TabOrder = 0
    OnKeyPress = edtCodPorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtNomPor: TEditFocus [10]
    Left = 224
    Top = 16
    Width = 257
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
  object edtCodEmp: TEditFocus [11]
    Tag = 99
    Left = 160
    Top = 40
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [12]
    Left = 224
    Top = 40
    Width = 257
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object edtCentroCusto: TEditFocus [13]
    Left = 224
    Top = 112
    Width = 257
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskCodCta: TMaskEditFocus [14]
    Tag = 99
    Left = 160
    Top = 112
    Width = 57
    Height = 22
    EditMask = '99.99.999;0;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 9
    TabOrder = 8
    Text = ''
    OnKeyPress = mskCodCtaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object prgProgresso: TProgressBar [15]
    Left = 0
    Top = 247
    Width = 499
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 16
  end
  object edtNomPorOri: TEditFocus [16]
    Left = 224
    Top = 64
    Width = 257
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object edtCodPorOri: TEditFocus [17]
    Tag = 99
    Left = 160
    Top = 64
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 4
    OnExit = edtCodPorOriExit
    OnKeyPress = edtCodPorOriKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesCustoOri: TEditFocus [18]
    Left = 224
    Top = 88
    Width = 257
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object mskCodCtaOri: TMaskEditFocus [19]
    Left = 160
    Top = 88
    Width = 57
    Height = 22
    EditMask = '99.99.999;0;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 9
    TabOrder = 6
    Text = ''
    OnExit = mskCodCtaOriExit
    OnKeyPress = mskCodCtaOriKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object chkApagar: TCheckBox [20]
    Left = 160
    Top = 164
    Width = 329
    Height = 17
    Caption = 'Apagar gera'#231#245'es anteriores?'
    TabOrder = 12
  end
  object gpbArquivos: TGroupBox [21]
    Left = 8
    Top = 184
    Width = 481
    Height = 49
    Caption = 'Arquivos para gera'#231#227'o'
    TabOrder = 13
    object chkCadRec: TCheckBox
      Left = 8
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Contas a Receber'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkCadPag: TCheckBox
      Left = 128
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Contas a Pagar'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkCadRcxx: TCheckBox
      Left = 248
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Caixa'
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 291
    Width = 499
    TabOrder = 15
    ExplicitTop = 291
    ExplicitWidth = 499
    inherited pnlNomeForm: TPanel
      Left = 328
      ExplicitLeft = 328
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
      object shpMultSel: TShape
        Left = 298
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        Visible = False
      end
    end
  end
  object mskDtaIni: TcxDateEdit [23]
    Tag = 99
    Left = 160
    Top = 137
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
    TabOrder = 10
    Width = 90
  end
  object mskDtaFin: TcxDateEdit [24]
    Tag = 99
    Left = 266
    Top = 137
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
    TabOrder = 11
    Width = 90
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 8
  end
end
