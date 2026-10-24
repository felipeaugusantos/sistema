inherited frmCadFuncoes: TfrmCadFuncoes
  Width = 528
  Height = 150
  Caption = 'Cadastro de Fun'#231#245'es'
  ExplicitWidth = 528
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 80
    Width = 522
    Height = 25
    ExplicitTop = 80
    ExplicitWidth = 522
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 447
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 447
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        Spacing = 2
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        Spacing = 2
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        Spacing = 2
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        Spacing = 2
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        Spacing = 2
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 449
      Width = 71
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 449
      ExplicitWidth = 71
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 522
    Height = 80
    Visible = False
    ExplicitWidth = 522
    ExplicitHeight = 80
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 514
      ExplicitHeight = 48
    end
  end
  inherited pnlStatus: TPanel
    Top = 105
    Width = 522
    ExplicitTop = 105
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 362
      Width = 160
      ExplicitLeft = 362
      ExplicitWidth = 160
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 522
    Height = 80
    Align = alClient
    ParentColor = True
    TabOrder = 4
    DesignSize = (
      522
      80)
    object Label2: TLabel
      Left = 24
      Top = 45
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 40
      Top = 22
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeCodFnc: TDBEditFocus
      Tag = 99
      Left = 79
      Top = 18
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FNC_CODFNC'
      DataSource = dtsCadFnc
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomFnc: TDBEditFocus
      Tag = 99
      Left = 79
      Top = 41
      Width = 430
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      DataField = 'FNC_NOMFNC'
      DataSource = dtsCadFnc
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsCadFnc: TDataSource
    AutoEdit = False
    Left = 376
  end
end
