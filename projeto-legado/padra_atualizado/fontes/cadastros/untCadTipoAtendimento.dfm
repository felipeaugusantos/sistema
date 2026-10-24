inherited frmCadTipoAtendimento: TfrmCadTipoAtendimento
  Left = 578
  Top = 392
  Width = 529
  Height = 142
  Caption = 'Cadastro de Tipos de Atendimento'
  ExplicitWidth = 529
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 523
    Height = 25
    ExplicitTop = 72
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 450
      Height = 21
      ExplicitWidth = 450
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Width = 75
        Height = 21
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 363
        Width = 75
        Height = 21
        ExplicitLeft = 363
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Width = 69
      Height = 21
      Align = alRight
      ExplicitLeft = 452
      ExplicitWidth = 69
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 523
    ExplicitTop = 97
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 341
      Width = 182
      ExplicitLeft = 341
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 341
      ExplicitWidth = 341
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 72
    ExplicitWidth = 523
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 40
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 72
    Align = alClient
    Color = 16770261
    ParentBackground = False
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
    object dbeDesTpa: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 33
      Width = 424
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TPA_DESCRI'
      DataSource = dtsCadTpa
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodTpa: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'TPA_CODIGO'
      DataSource = dtsCadTpa
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    Left = 472
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 8
  end
  object dtsCadTpa: TDataSource
    Left = 408
    Top = 8
  end
end
