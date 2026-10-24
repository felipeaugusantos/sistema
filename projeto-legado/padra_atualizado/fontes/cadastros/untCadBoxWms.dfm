inherited frmCadBoxWms: TfrmCadBoxWms
  Width = 553
  Height = 127
  Caption = 'Cadastro de Box - WMS'
  OnDestroy = FormDestroy
  ExplicitWidth = 553
  ExplicitHeight = 127
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 10
    Top = 21
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 153
    Top = 21
    Width = 57
    Height = 14
    Alignment = taRightJustify
    Caption = 'Documento:'
  end
  object Label3: TLabel [2]
    Left = 344
    Top = 21
    Width = 41
    Height = 14
    Alignment = taRightJustify
    Caption = 'Esp'#233'cie:'
  end
  object Label4: TLabel [3]
    Left = 434
    Top = 21
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 55
    Width = 547
    ExplicitTop = 55
    ExplicitWidth = 547
    inherited btnSair: TBitBtnLocked
      Left = 473
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 473
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = -1
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnGravar: TBitBtnLocked
      Left = 74
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 74
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnCancela: TBitBtnLocked
      Left = 290
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 290
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 218
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 218
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 362
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 362
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 146
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 146
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pgcDados: TPageControl
    Left = 1312
    Top = 72
    Width = 193
    Height = 41
    Align = alNone
    Visible = False
    ExplicitLeft = 1312
    ExplicitTop = 72
    ExplicitWidth = 193
    ExplicitHeight = 41
    inherited tbsGeral: TTabSheet
      ExplicitTop = 27
    end
  end
  inherited pnlStatus: TPanel
    Top = 83
    Width = 547
    ExplicitTop = 83
    ExplicitWidth = 547
    inherited pnlNomeForm: TPanel
      Left = 200
      ExplicitLeft = 200
    end
    inherited pnlInfo: TPanel
      Width = 200
      ExplicitWidth = 200
    end
  end
  object dbeCodBox: TDBEditFocus [8]
    Tag = 99
    Left = 52
    Top = 18
    Width = 87
    Height = 22
    CharCase = ecUpperCase
    DataField = 'BOX_CODIGO'
    DataSource = dtsTabela
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object DBEditFocus1: TDBEditFocus [9]
    Tag = 50
    Left = 212
    Top = 18
    Width = 123
    Height = 22
    CharCase = ecUpperCase
    DataField = 'BOX_NUMDOC'
    DataSource = dtsTabela
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object DBEditFocus2: TDBEditFocus [10]
    Tag = 50
    Left = 391
    Top = 18
    Width = 34
    Height = 22
    CharCase = ecUpperCase
    DataField = 'BOX_ESPDOC'
    DataSource = dtsTabela
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object DBEditFocus3: TDBEditFocus [11]
    Tag = 50
    Left = 485
    Top = 18
    Width = 35
    Height = 22
    CharCase = ecUpperCase
    DataField = 'BOX_EMPDOC'
    DataSource = dtsTabela
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 6
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 6
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 46
  end
  object dtsTabela: TDataSource
    Left = 448
    Top = 14
  end
end
