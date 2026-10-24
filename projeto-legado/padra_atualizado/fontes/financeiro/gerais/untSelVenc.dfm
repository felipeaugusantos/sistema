inherited frmSelVen: TfrmSelVen
  Width = 606
  Height = 356
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Vencimento para Gera'#231#227'o do Contas a Pagar'
  Position = poMainFormCenter
  ExplicitWidth = 606
  ExplicitHeight = 356
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 37
    Top = 33
    Width = 65
    Height = 14
    Alignment = taRightJustify
    Caption = 'Compet'#234'ncia:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [1]
    Left = 57
    Top = 9
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [2]
    Left = 181
    Top = 33
    Width = 59
    Height = 14
    Alignment = taRightJustify
    Caption = 'Vencimento:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel [3]
    Left = 57
    Top = 126
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Hist'#243'rico:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblDesPor: TLabel [4]
    Left = 58
    Top = 81
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblPrevSN: TColorLabel [5]
    Left = 431
    Top = 32
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    Visible = False
    CorDestaque = clRed
  end
  object lblPrevis: TLabel [6]
    Left = 355
    Top = 34
    Width = 51
    Height = 14
    Alignment = taRightJustify
    Caption = 'Previs'#227'o?:'
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 283
    Width = 600
    TabOrder = 9
    ExplicitTop = 283
    ExplicitWidth = 600
    inherited FlwBotoes: TFlowPanel
      Left = 88
      Width = 433
      TabOrder = 2
      ExplicitLeft = 88
      ExplicitWidth = 433
    end
    inherited btnSair: TBitBtnLocked
      Left = 521
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 521
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 86
      Height = 24
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000C0E0A1500000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000031362652909F70F32D32234C000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000003136265293A373F997A776FF93A373F92B3022490000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000003136265293A373F997A776FF97A776FF97A776FF93A273F82B2F
        2148000000000000000000000000000000000000000000000000000000000000
        00003136265393A373F997A776FF91A071F54951397B93A273F897A776FF93A2
        73F82B2F21480000000000000000000000000000000000000000000000000506
        0409839166DD97A776FF91A071F5262A1E40000000002B2F214893A273F897A7
        76FF93A273F82B30224900000000000000000000000000000000000000000000
        000015171023808D64D8262A1E400000000000000000000000002B2F214893A2
        73F897A776FF93A273F82B302249000000000000000000000000000000000000
        0000000000000202010300000000000000000000000000000000000000002B2F
        214893A273F897A776FF93A273F82B3022490000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00002B2F214893A273F897A776FF93A273F82B30224900000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000002B2F214893A273F897A776FF76825CC701010001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000002B2F214875825CC60B0C081200000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000010100010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 311
    Width = 600
    TabOrder = 10
    ExplicitTop = 311
    ExplicitWidth = 600
    inherited pnlNomeForm: TPanel
      Left = 429
      ExplicitLeft = 429
    end
    inherited pnlInfo: TPanel
      Width = 429
      ExplicitWidth = 429
    end
  end
  object mskCompet: TMaskEditFocus [9]
    Tag = 99
    Left = 107
    Top = 29
    Width = 49
    Height = 22
    EditMask = '!99/9999;1;_'
    MaxLength = 7
    TabOrder = 1
    Text = '  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtCodEmp: TEditFocus [10]
    Tag = 99
    Left = 107
    Top = 6
    Width = 49
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
    TabOrder = 0
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [11]
    Left = 157
    Top = 6
    Width = 430
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 8
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskDtaVen: TcxDateEdit [12]
    Tag = 99
    Left = 243
    Top = 29
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
  object memHistorico: TMemoFocus [13]
    Left = 107
    Top = 126
    Width = 480
    Height = 148
    ScrollBars = ssVertical
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object edtDesPor: TEditFocus [14]
    Left = 180
    Top = 77
    Width = 407
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    AutoSize = False
    Color = 16768952
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
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
  object edtCodPor: TEditFocus [15]
    Tag = 99
    Left = 107
    Top = 77
    Width = 72
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 5
    TabOrder = 5
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
  inline fraPlanoDeContas: TfraPlanoDeContasMskEdit [16]
    Left = 10
    Top = 53
    Width = 580
    Height = 22
    TabOrder = 4
    ExplicitLeft = 10
    ExplicitTop = 53
    ExplicitWidth = 580
    inherited lblPlaContas: TLabel
      Left = 11
      Width = 81
      Height = 14
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      ParentFont = False
      ExplicitLeft = 11
      ExplicitWidth = 81
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 170
      Width = 407
      Height = 22
      ExplicitLeft = 170
      ExplicitWidth = 407
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Left = 97
      Width = 72
      Height = 22
      OnEnter = fraPlanoDeContasMskCodCtaEnter
      OnExit = fraPlanoDeContasMskEdit1MskCodCtaExit
      OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
      ExplicitLeft = 97
      ExplicitWidth = 72
      ExplicitHeight = 22
    end
  end
  inline fraCentroCusto: TfraCentroCustoEditFocus [17]
    Left = 2
    Top = 101
    Width = 613
    Height = 22
    TabOrder = 6
    ExplicitLeft = 2
    ExplicitTop = 101
    ExplicitWidth = 613
    inherited lblEventos: TLabel
      Left = 13
      Top = 3
      Width = 87
      Height = 14
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      ParentFont = False
      ExplicitLeft = 13
      ExplicitTop = 3
      ExplicitWidth = 87
      ExplicitHeight = 14
    end
    inherited edtCodEve: TEditFocus
      Left = 105
      Width = 72
      Height = 22
      MaxLength = 5
      CompZeros = True
      TamCampo = 5
      ExplicitLeft = 105
      ExplicitWidth = 72
      ExplicitHeight = 22
    end
    inherited edtDesEve: TEditFocus
      Left = 178
      Width = 407
      Height = 22
      ExplicitLeft = 178
      ExplicitWidth = 407
      ExplicitHeight = 22
    end
  end
  object edtPrevis: TEditFocus [18]
    Tag = 99
    Left = 406
    Top = 29
    Width = 22
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
    MaxLength = 1
    ParentFont = False
    TabOrder = 3
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 1
    TipoTexto = ttAlfabetico
  end
  inherited mnuAuxiliar: TPopupMenu [19]
    Left = 234
    Top = 139
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 266
    Top = 139
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 298
    Top = 139
  end
end
