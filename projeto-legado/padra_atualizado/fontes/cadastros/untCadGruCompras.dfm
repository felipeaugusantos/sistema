inherited frmCadGruCompras: TfrmCadGruCompras
  Left = 292
  Top = 337
  Width = 533
  Height = 159
  Caption = 'Cadastro de Grupos de Compra'
  ExplicitWidth = 533
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 89
    Width = 527
    Height = 25
    ExplicitTop = 89
    ExplicitWidth = 527
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 451
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 451
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 75
        ExplicitLeft = 292
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 367
        Width = 75
        ExplicitLeft = 367
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 453
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 114
    Width = 527
    ExplicitTop = 114
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 199
      ExplicitLeft = 328
      ExplicitWidth = 199
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  inherited pgcDados: TPageControl
    Width = 527
    Height = 89
    ExplicitWidth = 527
    ExplicitHeight = 89
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 519
      ExplicitHeight = 57
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 527
    Height = 89
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 57
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 41
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 33
      Top = 61
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Repons'#225'vel:'
    end
    object dbeCodGru: TDBEditFocus
      Left = 97
      Top = 10
      Width = 121
      Height = 22
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesGru: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 34
      Width = 417
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomRes: TEditFocus
      Tag = 99
      Left = 140
      Top = 57
      Width = 374
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 57
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeOpeRes: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 57
      Width = 41
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = dbeOpeResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
  end
end
