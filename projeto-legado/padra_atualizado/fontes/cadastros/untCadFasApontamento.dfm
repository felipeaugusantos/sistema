inherited frmCadFasApontamento: TfrmCadFasApontamento
  Width = 521
  Height = 154
  Caption = 'Cadastro de Fases do Apontamento de Horas'
  ExplicitWidth = 521
  ExplicitHeight = 154
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 81
    Width = 515
    ExplicitTop = 81
    ExplicitWidth = 515
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitTop = 2
      ExplicitWidth = 511
    end
    inherited btnSair: TBitBtnLocked
      Left = 434
      Width = 72
      Height = 20
      ExplicitLeft = 434
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 376
    Top = 24
    Width = 121
    Height = 26
    Align = alNone
    ExplicitLeft = 376
    ExplicitTop = 24
    ExplicitWidth = 121
    ExplicitHeight = 26
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 113
      ExplicitHeight = 16
    end
  end
  inherited pnlStatus: TPanel
    Top = 109
    Width = 515
    ExplicitTop = 109
    ExplicitWidth = 515
    inherited pnlNomeForm: TPanel
      Left = 168
      ExplicitLeft = 168
    end
    inherited pnlInfo: TPanel
      Width = 168
      ExplicitWidth = 168
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 515
    Height = 81
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object lblDescri: TLabel
      Left = 11
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblCodigo: TLabel
      Left = 27
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 38
      Width = 440
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APO_DESCRI'
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodApo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'APO_CODAPO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 1
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 1
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 1
  end
end
