inherited frmCadDepartamentosCliCon: TfrmCadDepartamentosCliCon
  Height = 143
  Caption = 'Cadastro de Departamentos'
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 73
    Height = 25
    ExplicitTop = 73
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Height = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 84
        ExplicitWidth = 84
      end
      inherited btnGravar: TBitBtnLocked
        Left = 84
        Width = 84
        ExplicitLeft = 84
        ExplicitWidth = 84
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 168
        Width = 84
        ExplicitLeft = 168
        ExplicitWidth = 84
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 84
        ExplicitLeft = 252
        ExplicitWidth = 84
      end
      inherited btnCancela: TBitBtnLocked
        Left = 336
        Width = 84
        ExplicitLeft = 336
        ExplicitWidth = 84
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 420
        Width = 84
        ExplicitLeft = 420
        ExplicitWidth = 84
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 505
      Width = 72
      Height = 20
      ExplicitLeft = 505
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 73
    ExplicitHeight = 70
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 38
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 73
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 70
    object Label1: TLabel
      Left = 32
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DPT_CODDPT'
      DataSource = dtsCadDpt
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesDpt: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 36
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DPT_DESDPT'
      DataSource = dtsCadDpt
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
    Top = 98
    ExplicitTop = 98
    inherited pnlNomeForm: TPanel
      Left = 360
      Width = 225
      ExplicitLeft = 360
      ExplicitWidth = 225
    end
    inherited pnlInfo: TPanel
      Width = 360
    end
  end
  object dtsCadDpt: TDataSource
    Left = 344
  end
end
