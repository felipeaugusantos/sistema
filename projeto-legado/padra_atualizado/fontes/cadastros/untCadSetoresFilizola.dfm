inherited frmCadSetoresFilizola: TfrmCadSetoresFilizola
  Width = 534
  Height = 136
  Caption = 'Filizola - Cadastro de Setores'
  ExplicitWidth = 534
  ExplicitHeight = 136
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 66
    Width = 528
    Height = 25
    ExplicitTop = 66
    ExplicitWidth = 528
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 454
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 524
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
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 74
        ExplicitLeft = 365
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 454
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 66
    ExplicitWidth = 528
    ExplicitHeight = 66
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 34
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 66
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 34
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 18
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodSfz: TDBEditFocus
      Left = 72
      Top = 8
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SFZ_CODSFZ'
      DataSource = dtsCadSfz
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Left = 72
      Top = 32
      Width = 385
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SFZ_DESCRI'
      DataSource = dtsCadSfz
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 91
    Width = 528
    ExplicitTop = 91
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 181
      ExplicitLeft = 181
    end
    inherited pnlInfo: TPanel
      Width = 181
      ExplicitWidth = 181
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 2
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 2
  end
  object dtsCadSfz: TDataSource
    Left = 320
    Top = 2
  end
end
