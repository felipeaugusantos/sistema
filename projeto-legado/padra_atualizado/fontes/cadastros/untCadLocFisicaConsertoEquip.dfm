inherited frmCadLocFisicaConsertoEquip: TfrmCadLocFisicaConsertoEquip
  Width = 522
  Height = 145
  Caption = 'Cadastro de Localiza'#231#245'es F'#237'sica'
  ExplicitWidth = 522
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 516
    ExplicitTop = 72
    ExplicitWidth = 516
    inherited FlwBotoes: TFlowPanel
      Width = 512
      ExplicitTop = 2
      ExplicitWidth = 512
    end
    inherited btnSair: TBitBtnLocked
      Left = 435
      Width = 72
      Height = 20
      ExplicitLeft = 435
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 100
    Width = 516
    ExplicitTop = 100
    ExplicitWidth = 516
    inherited pnlNomeForm: TPanel
      Left = 169
      ExplicitLeft = 169
    end
    inherited pnlInfo: TPanel
      Width = 169
      ExplicitWidth = 169
    end
  end
  inherited pgcDados: TPageControl
    Left = 488
    Top = 224
    Width = 97
    Height = 34
    Align = alNone
    ExplicitLeft = 488
    ExplicitTop = 224
    ExplicitWidth = 97
    ExplicitHeight = 34
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 89
      ExplicitHeight = 2
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 516
    Height = 72
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 43
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 9
      Top = 17
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Localiza'#231#227'o:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 38
      Width = 410
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LEQ_DESCRI'
      DataSource = dtsLocEqu
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodLoc: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LEQ_CODLOC'
      DataSource = dtsLocEqu
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 0
  end
  object dtsLocEqu: TDataSource
    Left = 360
  end
end
