inherited frmCadForAtuCRM: TfrmCadForAtuCRM
  Height = 148
  Caption = 'Cadastro de Fornecedor Atual'
  ExplicitHeight = 148
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 30
    Top = 17
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 14
    Top = 40
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 78
    Height = 25
    TabOrder = 1
    ExplicitTop = 78
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 504
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 504
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
      Left = 506
      Height = 21
      Align = alRight
      ExplicitLeft = 506
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 2042
    Top = 104
    Width = 261
    Height = 79
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitLeft = 2042
    ExplicitTop = 104
    ExplicitWidth = 261
    ExplicitHeight = 79
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 253
      ExplicitHeight = 47
    end
  end
  inherited pnlStatus: TPanel
    Top = 103
    TabOrder = 2
    ExplicitTop = 103
    inherited pnlNomeForm: TPanel
      Left = 384
      Width = 201
      ExplicitLeft = 384
      ExplicitWidth = 201
    end
    inherited pnlInfo: TPanel
      Width = 384
    end
  end
  object dbeDescri: TDBEditFocus [6]
    Tag = 99
    Left = 68
    Top = 37
    Width = 381
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRF_NOMFOR'
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
    DataField = 'CRF_CODIGO'
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
