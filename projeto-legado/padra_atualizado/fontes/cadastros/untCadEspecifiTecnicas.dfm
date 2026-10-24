inherited frmCadEspecifiTecnicas: TfrmCadEspecifiTecnicas
  Width = 596
  Height = 169
  Caption = 'Cadastro de Especifica'#231#245'es T'#233'cnicas Para Controle de Produ'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 596
  ExplicitHeight = 169
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 13
    Top = 7
    Width = 33
    Height = 14
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 13
    Top = 51
    Width = 49
    Height = 14
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 432
    Top = 51
    Width = 35
    Height = 14
    Caption = 'M'#233'todo'
  end
  object Label4: TLabel [3]
    Left = 384
    Top = 51
    Width = 32
    Height = 14
    Caption = 'Escala'
  end
  inherited pnlBotoes: TPanel
    Top = 99
    Width = 590
    Height = 25
    ExplicitTop = 99
    ExplicitWidth = 590
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 514
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 586
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 21
        Align = alLeft
        Spacing = 2
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 516
      Width = 72
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 506
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 19999
    Top = -2
    Width = 5
    Align = alNone
    TabOrder = 6
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
  inherited pnlStatus: TPanel
    Top = 124
    Width = 590
    TabOrder = 5
    ExplicitTop = 124
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 389
      Width = 201
      ExplicitLeft = 389
      ExplicitWidth = 201
    end
    inherited pnlInfo: TPanel
      Width = 389
      ExplicitWidth = 389
    end
  end
  object dbeCodigo: TDBEditFocus [8]
    Left = 13
    Top = 22
    Width = 66
    Height = 22
    DataField = 'ETE_CODIGO'
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
  object dbeDescri: TDBEditFocus [9]
    Tag = 99
    Left = 13
    Top = 66
    Width = 365
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ETE_DESCRI'
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dblMetodo: TDBLookupComboBox [10]
    Left = 432
    Top = 66
    Width = 144
    Height = 22
    DataField = 'ETE_METODO'
    KeyField = 'MET_CODIGO'
    ListField = 'MET_DESCRI'
    TabOrder = 4
  end
  object dbeEscala: TDBEditFocus [11]
    Tag = 99
    Left = 384
    Top = 66
    Width = 44
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ETE_ESCALA'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 198
    Top = 43
  end
end
