inherited frmCadMontagemCaixa: TfrmCadMontagemCaixa
  Width = 526
  Height = 182
  Caption = 'Cadastro Caixas - Montagem de Caixas'
  ExplicitWidth = 526
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 109
    Width = 520
    ExplicitTop = 109
    ExplicitWidth = 520
    inherited FlwBotoes: TFlowPanel
      Width = 516
      ExplicitTop = 2
      ExplicitWidth = 516
    end
    inherited btnSair: TBitBtnLocked
      Left = 439
      ExplicitLeft = 439
    end
  end
  inherited pnlStatus: TPanel
    Top = 137
    Width = 520
    ExplicitTop = 137
    ExplicitWidth = 520
    inherited pnlNomeForm: TPanel
      Left = 173
      ExplicitLeft = 173
    end
    inherited pnlInfo: TPanel
      Width = 173
      ExplicitWidth = 173
    end
  end
  inherited pgcDados: TPageControl
    Width = 520
    Height = 109
    Visible = False
    ExplicitWidth = 520
    ExplicitHeight = 109
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 512
      ExplicitHeight = 77
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 520
    Height = 109
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 46
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 30
      Top = 42
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 50
      Top = 65
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Altura:'
    end
    object Label4: TLabel
      Left = 194
      Top = 65
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Largura:'
    end
    object Label5: TLabel
      Left = 347
      Top = 65
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Profundidade:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 13
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCX_CODIGO'
      DataSource = dtsMntCxa
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 37
      Width = 412
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCX_DESCRI'
      DataSource = dtsMntCxa
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAltura: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 61
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCX_ALTURA'
      DataSource = dtsMntCxa
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeLargur: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 61
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCX_LARGUR'
      DataSource = dtsMntCxa
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeProfun: TDBEditFocus
      Tag = 99
      Left = 417
      Top = 61
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCX_PROFUN'
      DataSource = dtsMntCxa
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 8
  end
  object dtsMntCxa: TDataSource
    Left = 172
    Top = 8
  end
end
