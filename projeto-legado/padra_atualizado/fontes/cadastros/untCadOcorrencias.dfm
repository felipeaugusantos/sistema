inherited frmCadOcorrencias: TfrmCadOcorrencias
  Height = 140
  Caption = 'Cadastro de Ocorr'#234'ncias'
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 70
    Height = 25
    ExplicitTop = 70
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 509
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 509
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        ExplicitLeft = 164
        ExplicitWidth = 82
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        ExplicitLeft = 246
        ExplicitWidth = 82
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 84
        ExplicitLeft = 328
        ExplicitWidth = 84
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 412
        Width = 84
        ExplicitLeft = 412
        ExplicitWidth = 84
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 511
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 511
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    ExplicitTop = 95
    inherited pnlNomeForm: TPanel
      Left = 416
      Width = 169
      ExplicitLeft = 416
      ExplicitWidth = 169
    end
    inherited pnlInfo: TPanel
      Width = 416
      ExplicitWidth = 416
    end
  end
  inherited pgcDados: TPageControl
    Height = 70
    ActivePage = nil
    ExplicitHeight = 70
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 577
      ExplicitHeight = 60
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 70
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object lbl2: TLabel
      Left = 37
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lbl3: TLabel
      Left = 53
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblLegendaSituacao: TColorLabel
      Left = 430
      Top = 17
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = '(A)tivo/(I)nativo'
      ParentShowHint = False
      ShowHint = False
      CorDestaque = clRed
    end
    object lblSituacao: TLabel
      Left = 351
      Top = 17
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object dbeDesOco: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 36
      Width = 413
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCO_DESOCO'
      DataSource = dtsCadOco
      MaxLength = 100
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodOco: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 13
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCO_CODOCO'
      DataSource = dtsCadOco
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeSituac: TDBEditFocus
      Tag = 99
      Left = 399
      Top = 13
      Width = 27
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCO_SITUAC'
      DataSource = dtsCadOco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 0
  end
  object dtsCadOco: TDataSource
    Left = 512
  end
end
