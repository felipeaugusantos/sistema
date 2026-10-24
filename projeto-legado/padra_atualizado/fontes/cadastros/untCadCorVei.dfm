inherited frmCadCorVei: TfrmCadCorVei
  Left = 319
  Top = 465
  Width = 535
  Height = 141
  Caption = 'Cadastro de Cores de Ve'#237'culos'
  ExplicitWidth = 535
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 71
    Width = 529
    Height = 25
    ExplicitTop = 71
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 457
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Width = 73
        Height = 21
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 145
        Width = 73
        Height = 21
        ExplicitLeft = 145
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 218
        Width = 73
        Height = 21
        ExplicitLeft = 218
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 291
        Width = 75
        Height = 21
        ExplicitLeft = 291
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 366
        Width = 75
        Height = 21
        ExplicitLeft = 366
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 452
      ExplicitWidth = 68
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 71
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDesCor: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_DESCOR'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCor: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_CODCOR'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 529
    ExplicitTop = 96
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 336
      Width = 193
      ExplicitLeft = 336
      ExplicitWidth = 193
    end
    inherited pnlInfo: TPanel
      Width = 336
      ExplicitWidth = 336
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 0
  end
end
