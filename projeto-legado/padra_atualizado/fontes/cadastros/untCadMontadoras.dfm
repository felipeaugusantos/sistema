inherited frmCadMontadoras: TfrmCadMontadoras
  Width = 525
  Height = 138
  Caption = 'Cadastro de Montadoras'
  ExplicitWidth = 525
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 68
    Width = 519
    Height = 25
    ExplicitTop = 68
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      inherited btnCancela: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 363
        Width = 75
        ExplicitLeft = 363
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      Width = 70
      Height = 20
      ExplicitLeft = 440
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 68
    ExplicitWidth = 519
    ExplicitHeight = 65
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 33
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 68
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 65
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
      DataField = 'MON_DESCRI'
      DataSource = dtsCadMon
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMon: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MON_CODMON'
      DataSource = dtsCadMon
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
    Top = 93
    Width = 519
    ExplicitTop = 93
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 340
      Width = 179
      ExplicitLeft = 340
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 340
      ExplicitWidth = 172
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 0
  end
  object dtsCadMon: TDataSource
    Left = 344
  end
end
