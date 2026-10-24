inherited frmCadPendencias: TfrmCadPendencias
  Width = 522
  Height = 146
  Caption = 'Pend'#234'ncia Fiscal de Nota de Entrada'
  ExplicitWidth = 522
  ExplicitHeight = 146
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 73
    Width = 516
    TabOrder = 1
    ExplicitTop = 73
    ExplicitWidth = 516
    inherited FlwBotoes: TFlowPanel
      Width = 512
      ExplicitWidth = 512
    end
    inherited btnSair: TBitBtnLocked
      Left = 435
      Width = 72
      Height = 20
      ExplicitLeft = 435
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 101
    Width = 516
    TabOrder = 2
    ExplicitTop = 101
    ExplicitWidth = 516
    inherited pnlNomeForm: TPanel
      Left = 169
      ExplicitLeft = 169
    end
    inherited pnlInfo: TPanel
      Width = 169
      ExplicitWidth = 169
    end
  end
  inherited pgcDados: TPageControl
    Width = 516
    Height = 73
    TabOrder = 3
    Visible = False
    ExplicitWidth = 516
    ExplicitHeight = 73
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 508
      ExplicitHeight = 41
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 516
    Height = 73
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDados'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 16
      Top = 40
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label67: TLabel
      Left = 376
      Top = 16
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo:'
    end
    object ColorLabel4: TColorLabel
      Left = 442
      Top = 16
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 12
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PEN_CODPEN'
      DataSource = dtsCadPen
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 36
      Width = 427
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PEN_DESCRI'
      DataSource = dtsCadPen
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAtivo_: TDBEditFocus
      Tag = 99
      Left = 405
      Top = 8
      Width = 31
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PEN_ATIVO_'
      DataSource = dtsCadPen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 144
  end
  object dtsCadPen: TDataSource
    Left = 520
    Top = 16
  end
end
