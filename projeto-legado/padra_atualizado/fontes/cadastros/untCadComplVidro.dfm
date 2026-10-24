inherited frmCadComplVidro: TfrmCadComplVidro
  Width = 531
  Height = 162
  Caption = 'Cadastro de Complementos para Venda de Vidro'
  ExplicitWidth = 531
  ExplicitHeight = 162
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 92
    Width = 525
    Height = 25
    ExplicitTop = 92
    ExplicitWidth = 525
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 457
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 521
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      Width = 64
      Height = 21
      Align = alRight
      ExplicitLeft = 451
      ExplicitWidth = 64
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 525
    Height = 92
    ExplicitWidth = 525
    ExplicitHeight = 92
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 517
      ExplicitHeight = 60
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 525
    Height = 92
    Align = alClient
    BevelInner = bvRaised
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 63
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 79
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label8: TLabel
      Left = 10
      Top = 62
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator Pre'#231'o de Custo:'
    end
    object Label9: TLabel
      Left = 221
      Top = 62
      Width = 108
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator Pre'#231'o de Venda:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 33
      Width = 388
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CPL_DESCRI'
      DataSource = dtsCadCpl
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CPL_CODIGO'
      DataSource = dtsCadCpl
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFatCus: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 56
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CPL_FATCUS'
      DataSource = dtsCadCpl
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFatVen: TDBEditFocus
      Tag = 99
      Left = 331
      Top = 56
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CPL_FATVEN'
      DataSource = dtsCadCpl
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 117
    Width = 525
    ExplicitTop = 117
    ExplicitWidth = 525
    inherited pnlNomeForm: TPanel
      Left = 368
      Width = 157
      ExplicitLeft = 368
      ExplicitWidth = 157
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 0
  end
  object dtsCadCpl: TDataSource
    Left = 344
  end
end
