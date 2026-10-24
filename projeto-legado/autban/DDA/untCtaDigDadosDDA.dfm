inherited frmCtaDigDadosDDA: TfrmCtaDigDadosDDA
  Width = 601
  Height = 310
  BorderIcons = []
  Caption = 'Digite os dados da Duplicata'
  ExplicitWidth = 601
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 38
    Top = 10
    Width = 82
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Portador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object ColorLabel2: TColorLabel [1]
    Left = 154
    Top = 102
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label11: TLabel [2]
    Left = 61
    Top = 102
    Width = 63
    Height = 14
    Alignment = taRightJustify
    Caption = 'Veio Boleto?:'
  end
  object Label4: TLabel [3]
    Left = 78
    Top = 126
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cheque?:'
  end
  object ColorLabel1: TColorLabel [4]
    Left = 154
    Top = 126
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label5: TLabel [5]
    Left = 78
    Top = 150
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'Veio NF?:'
  end
  object ColorLabel3: TColorLabel [6]
    Left = 154
    Top = 150
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label6: TLabel [7]
    Left = 73
    Top = 173
    Width = 51
    Height = 14
    Alignment = taRightJustify
    Caption = 'Previs'#227'o?:'
  end
  object ColorLabel4: TColorLabel [8]
    Left = 154
    Top = 173
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label7: TLabel [9]
    Left = 73
    Top = 196
    Width = 51
    Height = 14
    Alignment = taRightJustify
    Caption = 'Dep'#243'sito?:'
  end
  object ColorLabel5: TColorLabel [10]
    Left = 154
    Top = 196
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object Label8: TLabel [11]
    Left = 26
    Top = 78
    Width = 94
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Hist'#243'rico:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [12]
    Left = 5
    Top = 219
    Width = 119
    Height = 14
    Alignment = taRightJustify
    Caption = 'Pagamento Antecipado?:'
  end
  object ColorLabel6: TColorLabel [13]
    Left = 154
    Top = 219
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object edtPagAnt: TEditFocus [14]
    Tag = 99
    Left = 126
    Top = 214
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
  inherited pnlStatus: TPanel [15]
    Top = 265
    Width = 595
    TabOrder = 11
    ExplicitTop = 265
    ExplicitWidth = 595
    inherited pnlNomeForm: TPanel
      Left = 424
      ExplicitLeft = 424
    end
    inherited pnlInfo: TPanel
      Width = 424
      ExplicitWidth = 424
    end
  end
  inherited pnlBotoes: TPanel [16]
    Top = 239
    Width = 595
    TabOrder = 10
    ExplicitTop = 239
    ExplicitWidth = 595
    inherited FlwBotoes: TFlowPanel
      Width = 514
      ExplicitWidth = 514
    end
    inherited btnSair: TBitBtnLocked
      Left = 516
      Top = 2
      Align = alRight
      ExplicitLeft = 516
      ExplicitTop = 2
    end
  end
  object edtCodPor: TEditFocus [17]
    Tag = 99
    Left = 126
    Top = 7
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    AutoSize = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
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
  object edtDesPor: TEditFocus [18]
    Left = 190
    Top = 7
    Width = 345
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    AutoSize = False
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 12
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtHist01: TEditFocus [19]
    Left = 126
    Top = 76
    Width = 409
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 200
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCheque: TEditFocus [20]
    Tag = 99
    Left = 126
    Top = 122
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  object edtVeioNF: TEditFocus [21]
    Tag = 99
    Left = 126
    Top = 145
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  inline fraCentroCusto: TfraCentroCustoEditFocus [22]
    Left = 30
    Top = 53
    Width = 518
    Height = 22
    TabOrder = 2
    ExplicitLeft = 30
    ExplicitTop = 53
    ExplicitWidth = 518
    inherited lblEventos: TLabel
      Width = 87
      Height = 14
      ExplicitWidth = 87
      ExplicitHeight = 14
    end
    inherited edtCodEve: TEditFocus
      Left = 96
      Width = 61
      Height = 22
      OnKeyPress = fraCentroCustoedtCodEveKeyPress
      ExplicitLeft = 96
      ExplicitWidth = 61
      ExplicitHeight = 22
    end
    inherited edtDesEve: TEditFocus
      Left = 160
      Width = 345
      Height = 22
      ExplicitLeft = 160
      ExplicitWidth = 345
      ExplicitHeight = 22
    end
  end
  object edtPrevis: TEditFocus [23]
    Tag = 99
    Left = 126
    Top = 168
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  inline fraPlanoDeContas: TfraPlanoDeContasMskEdit [24]
    Left = 41
    Top = 30
    Width = 551
    Height = 23
    TabOrder = 1
    ExplicitLeft = 41
    ExplicitTop = 30
    ExplicitHeight = 23
    inherited lblPlaContas: TLabel
      Left = 4
      Width = 81
      Height = 14
      ExplicitLeft = 4
      ExplicitWidth = 81
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 149
      Width = 345
      Height = 22
      ExplicitLeft = 149
      ExplicitWidth = 345
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Width = 61
      Height = 22
      OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
      ExplicitWidth = 61
      ExplicitHeight = 22
    end
  end
  object edtDeposi: TEditFocus [25]
    Tag = 99
    Left = 126
    Top = 191
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
  object edtVeiobo: TEditFocus [26]
    Tag = 99
    Left = 126
    Top = 99
    Width = 18
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  inherited mnuAuxiliar: TPopupMenu [27]
    Left = 480
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 296
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 288
  end
end
