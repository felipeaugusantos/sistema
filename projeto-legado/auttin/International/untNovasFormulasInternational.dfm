inherited frmNovasFormulasInternational: TfrmNovasFormulasInternational
  Caption = 'frmNovasFormulasInternational'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    TabOrder = 2
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    TabOrder = 0
  end
  inherited pnlCentral: TPanel
    TabOrder = 1
    inherited lblCodigo: TLabel
      Left = 38
      ExplicitLeft = 38
    end
    object lblFanDeck: TLabel [1]
      Left = 54
      Top = 61
      Width = 20
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor:'
    end
    object lblEmbalagem: TLabel [2]
      Left = 46
      Top = 89
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object lblNota: TLabel [3]
      Left = 306
      Top = 61
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object lblLinha: TLabel [4]
      Left = 334
      Top = 89
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
    end
    object Label55: TLabel [5]
      Left = 290
      Top = 33
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    inherited pnlCabecalho: TPanel
      ParentBackground = False
      TabOrder = 0
    end
    inherited dbeCodigo: TDBEditFocus
      Left = 80
      Width = 174
      TabOrder = 1
      ExplicitLeft = 80
      ExplicitWidth = 174
    end
    inherited dbgComponentes: TcxGrid
      Top = 164
      Height = 253
      TabOrder = 6
      ExplicitTop = 164
      ExplicitHeight = 253
    end
    object dbeCor: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCOR'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODBAS'
      TabOrder = 3
      OnKeyPress = dbeBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 369
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODEMB'
      TabOrder = 4
      OnKeyPress = dbeBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha: TDBEditFocus
      Tag = 99
      Left = 369
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_LINHA_'
      TabOrder = 5
      OnKeyPress = dbeBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 369
      Top = 30
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
end
