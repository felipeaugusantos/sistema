inherited frmCadProxCodigos: TfrmCadProxCodigos
  Left = 149
  Top = 173
  Width = 537
  Height = 140
  Caption = 'Pr'#243'ximos C'#243'digos'
  ExplicitWidth = 537
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 70
    Width = 531
    Height = 25
    TabOrder = 1
    ExplicitTop = 73
    ExplicitWidth = 531
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 454
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 454
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
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      Width = 73
      Height = 21
      Align = alRight
      ExplicitLeft = 456
      ExplicitWidth = 73
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 531
    TabOrder = 3
    ExplicitTop = 98
    ExplicitWidth = 531
    inherited pnlNomeForm: TPanel
      Left = 360
      Width = 171
      ExplicitLeft = 360
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 360
      ExplicitWidth = 360
    end
  end
  inherited pgcDados: TPageControl
    Width = 531
    Height = 70
    Visible = False
    ExplicitWidth = 531
    ExplicitHeight = 73
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 523
      ExplicitHeight = 41
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 531
    Height = 70
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 73
    object Label1: TLabel
      Left = 49
      Top = 18
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome do Arquivo:'
    end
    object Label2: TLabel
      Left = 58
      Top = 41
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tam. do Campo:'
    end
    object Label3: TLabel
      Left = 293
      Top = 40
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#243'ximo C'#243'digo:'
    end
    object dbeNomArq: TDBEditFocus
      Tag = 99
      Left = 137
      Top = 14
      Width = 113
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_NOMARQ'
      DataSource = dtsProCod
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTamCod: TDBEditFocus
      Tag = 99
      Left = 137
      Top = 37
      Width = 113
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_TAMCOD'
      DataSource = dtsProCod
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValCod: TDBEditFocus
      Tag = 99
      Left = 376
      Top = 37
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_CODSEQ'
      DataSource = dtsProCod
      TabOrder = 4
      OnExit = dbeValCodExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodAut: TDBCheckBox
      Left = 268
      Top = 12
      Width = 92
      Height = 22
      Caption = 'Autom'#225'tico?'
      DataField = 'PRO_CODAUT'
      DataSource = dtsProCod
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeSeqEmp: TDBCheckBox
      Left = 376
      Top = 12
      Width = 151
      Height = 22
      Caption = 'Gerar c'#243'digo por empresa?'
      DataField = 'PRO_SEQEMP'
      DataSource = dtsProCod
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 16
    Top = 8
  end
  object dtsProCod: TDataSource
    Left = 120
    Top = 24
  end
end
