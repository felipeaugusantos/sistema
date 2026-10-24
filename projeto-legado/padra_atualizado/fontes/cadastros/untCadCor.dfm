inherited frmCadCor: TfrmCadCor
  Width = 543
  Height = 185
  Caption = 'Cadastro de Cores'
  ExplicitWidth = 543
  ExplicitHeight = 185
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 115
    Width = 537
    Height = 25
    ExplicitTop = 115
    ExplicitWidth = 537
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 533
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 533
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        ExplicitWidth = 76
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 76
        ExplicitLeft = 76
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 152
        Width = 76
        ExplicitLeft = 152
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 228
        Width = 76
        ExplicitLeft = 228
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 304
        Width = 76
        ExplicitLeft = 304
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 380
        Width = 76
        ExplicitLeft = 380
        ExplicitWidth = 76
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 458
      Width = 70
      Height = 20
      ExplicitLeft = 458
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 537
    Height = 115
    ExplicitWidth = 537
    ExplicitHeight = 112
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 529
      ExplicitHeight = 80
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 537
    Height = 115
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 112
    object Label1: TLabel
      Left = 50
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 34
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 5
      Top = 63
      Width = 81
      Height = 14
      Caption = 'Desc. Resumida:'
    end
    object lblDetGru: TLabel
      Left = 10
      Top = 87
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desc. Etiqueta:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_CODCOR'
      DataSource = dtsCadCor
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesCor: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 36
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_DESCOR'
      DataSource = dtsCadCor
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesRes: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 59
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_DESRES'
      DataSource = dtsCadCor
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDetCor: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 82
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_DETCOR'
      DataSource = dtsCadCor
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    Top = 140
    Width = 537
    ExplicitTop = 140
    ExplicitWidth = 537
    inherited pnlNomeForm: TPanel
      Left = 190
      ExplicitLeft = 190
    end
    inherited pnlInfo: TPanel
      Width = 190
      ExplicitWidth = 190
    end
  end
  object dtsCadCor: TDataSource
    Left = 344
  end
end
