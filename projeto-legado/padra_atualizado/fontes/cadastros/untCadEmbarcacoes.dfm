inherited frmCadEmbarcacoes: TfrmCadEmbarcacoes
  Width = 537
  Height = 600
  Caption = 'Cadastro de Embarca'#231#245'es'
  ExplicitWidth = 537
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object lblCodEmb: TLabel [0]
    Left = 89
    Top = 11
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  object lblNumImo: TLabel [1]
    Left = 49
    Top = 35
    Width = 76
    Height = 14
    Caption = 'N'#250'mero da IMO:'
  end
  object lblInscri: TLabel [2]
    Left = 23
    Top = 59
    Width = 102
    Height = 14
    Caption = 'N'#250'mero da Inscri'#231#227'o:'
  end
  object lblNomEmb: TLabel [3]
    Left = 17
    Top = 83
    Width = 108
    Height = 14
    Caption = 'Nome da Embarca'#231#227'o:'
  end
  object lblIndEmb: TLabel [4]
    Left = 32
    Top = 107
    Width = 93
    Height = 14
    Caption = 'Indicativo do Navio:'
  end
  object lblPortoi: TLabel [5]
    Left = 29
    Top = 131
    Width = 96
    Height = 14
    Caption = 'Porto de Inscri'#231#245'es:'
  end
  object lblLocEmb: TLabel [6]
    Left = 51
    Top = 155
    Width = 74
    Height = 14
    Caption = 'Local do Navio:'
  end
  object lblPorte_: TLabel [7]
    Left = 52
    Top = 179
    Width = 73
    Height = 14
    Caption = 'Porte do Navio:'
  end
  object lblCompri: TLabel [8]
    Left = 15
    Top = 203
    Width = 110
    Height = 14
    Caption = 'Comprimento do Navio:'
  end
  object lblArqBru: TLabel [9]
    Left = 39
    Top = 227
    Width = 86
    Height = 14
    Caption = 'Arquea'#231#227'o Bruta:'
  end
  object lblObserv: TLabel [10]
    Left = 56
    Top = 252
    Width = 69
    Height = 14
    Caption = 'Observa'#231#245'es:'
  end
  object Label1: TLabel [11]
    Left = 3
    Top = 386
    Width = 122
    Height = 14
    Caption = 'Observa'#231#245'es Drawback:'
  end
  inherited pnlBotoes: TPanel
    Top = 530
    Width = 531
    Height = 25
    TabOrder = 13
    ExplicitTop = 530
    ExplicitWidth = 531
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 461
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 527
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 74
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 149
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 149
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 224
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 224
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 299
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 299
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 374
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 374
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 463
      Width = 66
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 458
      ExplicitWidth = 66
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 790
    Top = 611
    Width = 76
    Height = 57
    Align = alNone
    TabOrder = 15
    Visible = False
    ExplicitLeft = 790
    ExplicitTop = 611
    ExplicitWidth = 76
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 68
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 531
    TabOrder = 14
    ExplicitTop = 555
    ExplicitWidth = 531
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 187
      ExplicitLeft = 344
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  object dbeCodEmb: TDBEditFocus [16]
    Tag = 99
    Left = 128
    Top = 8
    Width = 121
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_CODEMB'
    DataSource = dtsCadEmb
    MaxLength = 6
    ReadOnly = True
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtNumImo: TDBEditFocus [17]
    Tag = 99
    Left = 128
    Top = 32
    Width = 121
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_NUMIMO'
    DataSource = dtsCadEmb
    MaxLength = 7
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeInscri: TDBEditFocus [18]
    Tag = 99
    Left = 128
    Top = 56
    Width = 121
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_INSCRI'
    DataSource = dtsCadEmb
    MaxLength = 14
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtNomEmb: TDBEditFocus [19]
    Tag = 99
    Left = 128
    Top = 80
    Width = 390
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_NOMEMB'
    DataSource = dtsCadEmb
    MaxLength = 70
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtIndEmb: TDBEditFocus [20]
    Tag = 99
    Left = 128
    Top = 104
    Width = 121
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_INDEMB'
    DataSource = dtsCadEmb
    MaxLength = 10
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtPortoi: TDBEditFocus [21]
    Tag = 99
    Left = 128
    Top = 128
    Width = 390
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_PORTOI'
    DataSource = dtsCadEmb
    MaxLength = 30
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtLocEmb: TDBEditFocus [22]
    Tag = 99
    Left = 128
    Top = 152
    Width = 390
    Height = 22
    CharCase = ecUpperCase
    DataField = 'EMB_LOCEMB'
    DataSource = dtsCadEmb
    MaxLength = 30
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object cmbPorte_: TComboBoxFocus [23]
    Tag = 99
    Left = 128
    Top = 176
    Width = 145
    Height = 22
    CharCase = ecUpperCase
    TabOrder = 8
    OnChange = cmbPorte_Change
    Items.Strings = (
      'PEQUENO'
      'M'#201'DIO'
      'GRANDE')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object edtCompri: TEditFocus [24]
    Tag = 99
    Left = 128
    Top = 200
    Width = 121
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 9
    OnExit = edtCompriExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtArqBru: TEditFocus [25]
    Tag = 99
    Left = 128
    Top = 224
    Width = 121
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 10
    OnExit = edtArqBruExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object mmoObserv: TDBMemoFocus [26]
    Tag = 99
    Left = 128
    Top = 248
    Width = 390
    Height = 130
    DataField = 'EMB_OBSERV'
    DataSource = dtsCadEmb
    ScrollBars = ssVertical
    TabOrder = 11
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object chkDraBck: TDBCheckBox [27]
    Tag = 99
    Left = 255
    Top = 35
    Width = 200
    Height = 17
    Caption = 'Incide Opera'#231#227'o Drawback?'
    DataField = 'EMB_DRABCK'
    DataSource = dtsCadEmb
    TabOrder = 2
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object mmoObsDbk: TDBMemoFocus [28]
    Tag = 99
    Left = 128
    Top = 384
    Width = 390
    Height = 130
    DataField = 'EMB_OBSDBK'
    DataSource = dtsCadEmb
    ScrollBars = ssVertical
    TabOrder = 12
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 800
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 800
    Top = 304
  end
  object dtsCadEmb: TDataSource
    OnStateChange = dtsCadEmbStateChange
    Left = 480
    Top = 16
  end
end
