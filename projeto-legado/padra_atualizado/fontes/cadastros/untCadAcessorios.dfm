inherited frmCadAcessorios: TfrmCadAcessorios
  Width = 521
  Height = 145
  Caption = 'Cadastro de Acess'#243'rios'
  ExplicitWidth = 521
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 515
    ExplicitTop = 72
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
    Left = 488
    Top = 224
    Width = 97
    Height = 34
    Align = alNone
    ExplicitLeft = 488
    ExplicitTop = 224
    ExplicitWidth = 97
    ExplicitHeight = 34
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 89
      ExplicitHeight = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 100
    Width = 515
    ExplicitTop = 100
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
    Height = 72
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label2: TLabel
      Left = 11
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
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
      DataField = 'ACE_DESCRI'
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAce: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACE_CODACE'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 0
  end
end
