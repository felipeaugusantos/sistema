inherited frmCadEstProduto: TfrmCadEstProduto
  Width = 521
  Height = 145
  Caption = 'Cadastro de Estado do Produto'
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
  inherited pgcDados: TPageControl
    Left = 504
    Top = 8
    Width = 81
    Height = 42
    Align = alNone
    ExplicitLeft = 504
    ExplicitTop = 8
    ExplicitWidth = 81
    ExplicitHeight = 42
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 73
      ExplicitHeight = 10
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 515
    Height = 72
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
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
      DataField = 'EPR_DESCRI'
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEpr: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EPR_CODEPR'
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
    Left = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 0
  end
end
