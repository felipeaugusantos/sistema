inherited frmCadGrupoAtividade: TfrmCadGrupoAtividade
  Width = 549
  Height = 139
  Caption = 'Cadastro de Grupo de Atividade'
  OnDestroy = FormDestroy
  ExplicitWidth = 549
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 543
    Height = 25
    TabOrder = 2
    ExplicitTop = 69
    ExplicitWidth = 543
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 539
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 539
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Width = 73
      Height = 20
      ExplicitLeft = 452
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 94
    Width = 543
    TabOrder = 3
    ExplicitTop = 94
    ExplicitWidth = 543
    inherited pnlNomeForm: TPanel
      Left = 351
      Width = 192
      TabOrder = 1
      ExplicitLeft = 351
      ExplicitWidth = 192
    end
    inherited pnlInfo: TPanel
      Width = 351
      TabOrder = 0
      ExplicitWidth = 351
    end
  end
  inherited pgcDados: TPageControl
    Left = -10
    Width = 0
    Height = 0
    ActivePage = nil
    Align = alNone
    TabOrder = 0
    Visible = False
    ExplicitLeft = -10
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 543
    Height = 69
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
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
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GAT_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodGat: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GAT_CODGAT'
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
    Left = 612
    Top = 20
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 580
    Top = 20
  end
end
