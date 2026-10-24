inherited frmCadCest: TfrmCadCest
  Width = 525
  Height = 231
  Caption = 'Classifica'#231#227'o CEST'
  ExplicitWidth = 525
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 161
    Width = 519
    Height = 25
    ExplicitTop = 161
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 445
      Height = 21
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        Height = 21
        Spacing = 2
        ExplicitLeft = 71
        ExplicitWidth = 71
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Height = 21
        Spacing = 2
        ExplicitLeft = 142
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 214
        Height = 21
        Spacing = 2
        ExplicitLeft = 214
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 286
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 286
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 359
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 359
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 447
      Width = 70
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 440
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 161
    ExplicitWidth = 519
    ExplicitHeight = 161
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 511
      ExplicitHeight = 129
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 161
    Align = alClient
    TabOrder = 3
    object Label1: TLabel
      Left = 4
      Top = 4
      Width = 62
      Height = 14
      Caption = 'C'#243'digo CEST'
    end
    object Label2: TLabel
      Left = 4
      Top = 39
      Width = 58
      Height = 14
      Caption = 'C'#243'digo NCM'
    end
    object Label3: TLabel
      Left = 4
      Top = 74
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object dbeCodCest: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 17
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CES_CDCEST'
      DataSource = dtsDados
      TabOrder = 0
      OnExit = dbeCodCestExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNCM: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 52
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CES_CODNCM'
      DataSource = dtsDados
      TabOrder = 1
      OnKeyPress = dbeNCMKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeNCMChamaCadastro
    end
    object dbeDescr: TDBMemoFocus
      Tag = 99
      Left = 6
      Top = 92
      Width = 500
      Height = 60
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'CES_DESCRI'
      DataSource = dtsDados
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    Width = 519
    ExplicitTop = 186
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 191
      ExplicitLeft = 328
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 8
  end
  object dtsDados: TDataSource
    Left = 328
    Top = 24
  end
end
