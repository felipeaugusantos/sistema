inherited frmSacMotivosAtend: TfrmSacMotivosAtend
  Width = 524
  Height = 163
  Caption = 'SAC - Motivos de Atendimento'
  ExplicitWidth = 524
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 518
    Height = 25
    ExplicitTop = 93
    ExplicitWidth = 518
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 444
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 514
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 70
        Height = 21
        Spacing = 2
        ExplicitWidth = 70
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 70
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 70
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 141
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 141
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 212
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 212
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 283
        Height = 21
        Spacing = 2
        ExplicitLeft = 283
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 355
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 70
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 437
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = -1500
    Top = -1500
    Width = 0
    Height = 0
    Align = alNone
    Visible = False
    ExplicitLeft = -1500
    ExplicitTop = -1500
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 518
    Height = 93
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 39
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 35
      Width = 440
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_DESCRI'
      DataSource = dtsMotAte
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_CODMOT'
      DataSource = dtsMotAte
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object chkDigInf: TDBCheckBox
      Left = 64
      Top = 64
      Width = 401
      Height = 17
      Caption = 'Digitar informa'#231#245'es do produto no Atendimento ao Cliente'
      DataField = 'MOT_DIGINF'
      DataSource = dtsMotAte
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited pnlStatus: TPanel
    Top = 118
    Width = 518
    ExplicitTop = 118
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 320
      Width = 198
      ExplicitLeft = 320
      ExplicitWidth = 198
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 392
    Top = 336
  end
  object dtsMotAte: TDataSource
    Left = 480
    Top = 8
  end
end
