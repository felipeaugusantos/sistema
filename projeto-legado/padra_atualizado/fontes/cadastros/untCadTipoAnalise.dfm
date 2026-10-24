inherited frmCadTipoAnalise: TfrmCadTipoAnalise
  Width = 556
  Height = 169
  Caption = 'Cadastro de Tipos de An'#225'lise'
  OnDestroy = FormDestroy
  ExplicitWidth = 556
  ExplicitHeight = 169
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 18
    Top = 8
    Width = 33
    Height = 14
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 18
    Top = 52
    Width = 49
    Height = 14
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 389
    Top = 52
    Width = 35
    Height = 14
    Caption = 'M'#233'todo'
  end
  inherited pnlBotoes: TPanel
    Top = 99
    Width = 550
    Height = 25
    ExplicitTop = 99
    ExplicitWidth = 550
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 478
      Height = 21
      ExplicitWidth = 478
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 77
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 77
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 154
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 154
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 231
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 231
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 308
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 308
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 385
        Width = 77
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 385
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 480
      Width = 68
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 480
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 124
    Width = 550
    TabOrder = 4
    ExplicitTop = 124
    ExplicitWidth = 550
    inherited pnlNomeForm: TPanel
      Left = 368
      Width = 182
      ExplicitLeft = 368
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  inherited pgcDados: TPageControl
    Left = 19999
    Top = -2
    Width = 5
    Align = alNone
    TabOrder = 5
    ExplicitLeft = 19999
    ExplicitTop = -2
    ExplicitWidth = 5
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbeCodigo: TDBEditFocus [6]
    Left = 18
    Top = 23
    Width = 66
    Height = 22
    Color = 16768952
    DataField = 'TAN_CODIGO'
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [7]
    Tag = 99
    Left = 18
    Top = 67
    Width = 365
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TAN_DESCRI'
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dblMetodo: TDBLookupComboBox [8]
    Left = 389
    Top = 67
    Width = 144
    Height = 22
    DataField = 'TAN_METODO'
    KeyField = 'MET_CODIGO'
    ListField = 'MET_DESCRI'
    TabOrder = 3
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 198
    Top = 43
  end
end
