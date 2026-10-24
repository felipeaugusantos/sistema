inherited frmNovasFormulasHydronorth: TfrmNovasFormulasHydronorth
  Caption = 'frmNovasFormulasHydronorth'
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
    ExplicitLeft = -1
    ExplicitTop = -2
    inherited lblCodigo: TLabel
      Left = 38
      ExplicitLeft = 38
    end
    object lblCorCod: TLabel [1]
      Left = 32
      Top = 61
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cole'#231#227'o:'
    end
    object lblCodBas: TLabel [2]
      Left = 34
      Top = 89
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblFanDeck: TLabel [3]
      Left = 54
      Top = 117
      Width = 20
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor:'
    end
    object lblProduto: TLabel [4]
      Left = 271
      Top = 61
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor Nome Longo:'
    end
    object lblEmbalagem: TLabel [5]
      Left = 326
      Top = 89
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object lblNota: TLabel [6]
      Left = 297
      Top = 117
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label55: TLabel [7]
      Left = 281
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
      TabOrder = 8
      ExplicitTop = 164
      ExplicitHeight = 253
    end
    object dbeColecao: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_COLECA'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProduto: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_PRODUT'
      TabOrder = 3
      OnKeyPress = dbeBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCor: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 114
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_C_O_R_'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCorNomeLongo: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CORLON'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_BASE__'
      TabOrder = 6
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
      Left = 360
      Top = 114
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODEMB'
      TabOrder = 7
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
      Left = 360
      Top = 30
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 9
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
    Top = 160
  end
end
