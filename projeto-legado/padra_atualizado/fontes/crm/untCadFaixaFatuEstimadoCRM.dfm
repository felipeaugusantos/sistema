inherited frmCadFaixaFatuEstimadoCRM: TfrmCadFaixaFatuEstimadoCRM
  Width = 556
  Height = 161
  Caption = 'Cadastro de Faturamento Estimado'
  ExplicitWidth = 556
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 66
    Top = 14
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 50
    Top = 35
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object Label3: TLabel [2]
    Left = 10
    Top = 59
    Width = 92
    Height = 14
    Alignment = taRightJustify
    Caption = 'Faturamento Inicial:'
  end
  object Label4: TLabel [3]
    Left = 200
    Top = 59
    Width = 88
    Height = 14
    Alignment = taRightJustify
    Caption = 'Faturamento Final:'
  end
  inherited pnlBotoes: TPanel
    Top = 91
    Width = 550
    Height = 25
    TabOrder = 3
    ExplicitTop = 91
    ExplicitWidth = 550
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 469
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 469
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        Height = 21
        Align = alLeft
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 471
      Height = 21
      Align = alRight
      ExplicitLeft = 471
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 9168
    Width = 417
    Align = alNone
    TabOrder = 5
    ExplicitLeft = 9168
    ExplicitWidth = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 409
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel
    Top = 116
    Width = 550
    TabOrder = 4
    ExplicitTop = 116
    ExplicitWidth = 550
    inherited pnlNomeForm: TPanel
      Left = 203
      ExplicitLeft = 203
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 203
    end
  end
  object dbeDescri: TDBEditFocus [8]
    Tag = 99
    Left = 104
    Top = 32
    Width = 381
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRF_DESCRI'
    DataSource = dtsSource
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodigo: TDBEditFocus [9]
    Tag = 50
    Left = 104
    Top = 9
    Width = 88
    Height = 22
    CharCase = ecUpperCase
    Color = 16770261
    DataField = 'CRF_CODIGO'
    DataSource = dtsSource
    Enabled = False
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeFatIni: TDBEditFocus [10]
    Tag = 99
    Left = 104
    Top = 56
    Width = 78
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRF_FATINI'
    DataSource = dtsSource
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeFatFin: TDBEditFocus [11]
    Tag = 99
    Left = 290
    Top = 56
    Width = 78
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRF_FATFIN'
    DataSource = dtsSource
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dtsSource: TDataSource
    Left = 492
    Top = 16
  end
end
