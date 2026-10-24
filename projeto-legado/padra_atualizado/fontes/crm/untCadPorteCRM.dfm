inherited frmCadPorteCRM: TfrmCadPorteCRM
  Height = 147
  Caption = 'Cadastro de Porte '
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 14
    Top = 40
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object Label1: TLabel [1]
    Left = 30
    Top = 17
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  inherited pnlBotoes: TPanel
    Top = 77
    Height = 25
    TabOrder = 1
    ExplicitTop = 77
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 504
      Height = 21
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
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 506
      Height = 21
      Align = alRight
      ExplicitLeft = 506
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 1000
    Align = alNone
    TabOrder = 3
    ExplicitLeft = 1000
  end
  inherited pnlStatus: TPanel
    Top = 102
    TabOrder = 2
    ExplicitTop = 102
  end
  object dbeDescri: TDBEditFocus [6]
    Tag = 99
    Left = 68
    Top = 37
    Width = 381
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRP_DESCRI'
    DataSource = dtsSource
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodigo: TDBEditFocus [7]
    Tag = 50
    Left = 68
    Top = 12
    Width = 88
    Height = 22
    CharCase = ecUpperCase
    Color = 16770261
    DataField = 'CRP_CODIGO'
    DataSource = dtsSource
    Enabled = False
    ReadOnly = True
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dtsSource: TDataSource
    Left = 492
    Top = 16
  end
end
