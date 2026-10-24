inherited frmCadClassifCentroCusto: TfrmCadClassifCentroCusto
  Height = 203
  Caption = 'Cadastro de Classifica'#231#227'o do Plano de Contas'
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 133
    Height = 25
    ExplicitTop = 133
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 505
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        Align = alLeft
        ExplicitWidth = 82
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        Align = alLeft
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        Align = alLeft
        ExplicitLeft = 164
        ExplicitWidth = 82
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        Align = alLeft
        ExplicitLeft = 246
        ExplicitWidth = 82
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 82
        Align = alLeft
        ExplicitLeft = 328
        ExplicitWidth = 82
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 410
        Width = 82
        Align = alLeft
        ExplicitLeft = 410
        ExplicitWidth = 82
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 507
      Width = 76
      Height = 21
      Align = alRight
      ExplicitLeft = 505
      ExplicitWidth = 76
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 133
    ExplicitHeight = 133
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 101
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 133
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lbl1: TLabel
      Left = 81
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lbl2: TLabel
      Left = 65
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lbl3: TLabel
      Left = 8
      Top = 58
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Reduzida 1:'
    end
    object lbl4: TLabel
      Left = 8
      Top = 81
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Reduzida 2:'
    end
    object lbl5: TLabel
      Left = 8
      Top = 104
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Reduzida 3:'
    end
    object lbl6: TLabel
      Left = 357
      Top = 106
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Opera'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 8
      Width = 75
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCC_CODIGO'
      DataSource = dtsClaCCu
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
      Left = 121
      Top = 31
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCC_DESCRI'
      DataSource = dtsClaCCu
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeClaRe1: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 54
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCC_DESRE1'
      DataSource = dtsClaCCu
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeClaRe2: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 77
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCC_DESRE2'
      DataSource = dtsClaCCu
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeClaRe3: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 100
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CCC_DESRE3'
      DataSource = dtsClaCCu
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtTipOpe: TComboBoxFocus
      Left = 451
      Top = 102
      Width = 120
      Height = 22
      TabOrder = 5
      Items.Strings = (
        'ENTRADA'
        'SAIDA'
        'ENTRADA/SA'#205'DA')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 158
    ExplicitTop = 158
    inherited pnlNomeForm: TPanel
      Left = 357
      Width = 228
      ExplicitLeft = 357
      ExplicitWidth = 228
    end
    inherited pnlInfo: TPanel
      Width = 357
      ExplicitWidth = 357
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 64
  end
  object dtsClaCCu: TDataSource
    Left = 472
    Top = 64
  end
end
