inherited frmCadAjudantes: TfrmCadAjudantes
  Left = 578
  Top = 392
  Width = 529
  Height = 142
  Caption = 'Cadastro de Ajudante'
  ExplicitWidth = 529
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 523
    Height = 25
    ExplicitTop = 72
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 519
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 519
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
      Left = 441
      Width = 73
      Height = 20
      ExplicitLeft = 441
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 72
    ExplicitWidth = 523
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 40
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 72
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lbl1: TLabel
      Left = 324
      Top = 15
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object lbl2: TColorLabel
      Left = 415
      Top = 15
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeNomAju: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 33
      Width = 424
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_NOMAJU'
      DataSource = dtsCadAju
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAju: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_CODAJU'
      DataSource = dtsCadAju
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 372
      Top = 11
      Width = 37
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_STATUS'
      DataSource = dtsCadAju
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 523
    ExplicitTop = 97
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 179
      ExplicitLeft = 344
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 308
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 8
  end
  object dtsCadAju: TDataSource
    Left = 240
    Top = 20
  end
end
