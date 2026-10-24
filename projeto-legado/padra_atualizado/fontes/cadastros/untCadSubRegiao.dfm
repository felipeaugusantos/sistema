inherited frmCadSubRegiao: TfrmCadSubRegiao
  Width = 520
  Height = 150
  Caption = 'Cadastro de Sub-Regi'#227'o'
  ExplicitWidth = 520
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 80
    Width = 514
    Height = 25
    ExplicitTop = 80
    ExplicitWidth = 514
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 510
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 510
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
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 439
      Width = 67
      Height = 20
      ExplicitLeft = 439
      ExplicitWidth = 67
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 514
    Height = 80
    ExplicitWidth = 514
    ExplicitHeight = 77
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 506
      ExplicitHeight = 45
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 514
    Height = 80
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 77
    object lbl2: TLabel
      Left = 15
      Top = 45
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lbl3: TLabel
      Left = 31
      Top = 22
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDesSub: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 41
      Width = 427
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SUB_DESSUB'
      DataSource = dtsCadSub
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodSub: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 18
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SUB_CODSUB'
      DataSource = dtsCadSub
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
    Top = 105
    Width = 514
    ExplicitTop = 105
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 186
      ExplicitLeft = 328
      ExplicitWidth = 186
      ExplicitHeight = 17
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 167
    end
  end
  object dtsCadSub: TDataSource
    Left = 344
  end
end
