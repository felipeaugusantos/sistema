inherited frmCadGrupoServicos: TfrmCadGrupoServicos
  Width = 565
  Height = 134
  Caption = 'Cadastro de Grupos de Servi'#231'os'
  ExplicitWidth = 565
  ExplicitHeight = 134
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 64
    Width = 559
    Height = 25
    ExplicitTop = 64
    ExplicitWidth = 559
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 489
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 555
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 79
        Height = 21
        Spacing = 2
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 79
        Width = 79
        Height = 21
        Spacing = 2
        ExplicitLeft = 79
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 158
        Width = 79
        Height = 21
        Spacing = 2
        ExplicitLeft = 158
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 237
        Width = 79
        Height = 21
        Spacing = 2
        ExplicitLeft = 237
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 316
        Width = 79
        Height = 21
        Spacing = 2
        ExplicitLeft = 316
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 395
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 395
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 491
      Width = 66
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 482
      ExplicitWidth = 66
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 584
    Top = 176
    Width = 89
    Height = 67
    Align = alNone
    ExplicitLeft = 584
    ExplicitTop = 176
    ExplicitWidth = 89
    ExplicitHeight = 67
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 81
      ExplicitHeight = 35
    end
  end
  inherited pnlStatus: TPanel
    Top = 89
    Width = 559
    ExplicitTop = 89
    ExplicitWidth = 559
    inherited pnlNomeForm: TPanel
      Left = 384
      Width = 175
      ExplicitLeft = 384
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 384
      ExplicitWidth = 384
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 0
    Width = 559
    Height = 64
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 22
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 6
      Top = 35
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodGru: TDBEditFocus
      Tag = 99
      Left = 60
      Top = 8
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_CODGRU'
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesGru: TDBEditFocus
      Tag = 99
      Left = 60
      Top = 32
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DESGRU'
      MaxLength = 40
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 8
  end
end
