inherited frmDefinicoesSinaleiroFaturamento: TfrmDefinicoesSinaleiroFaturamento
  Width = 665
  Height = 267
  BorderIcons = [biMaximize]
  Caption = 'Defini'#231#245'es do Sinaleiro do Faturamento'
  Position = poMainFormCenter
  ExplicitWidth = 665
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 14
  object lblPrecoUtilizadoParaCalculo: TLabel [0]
    Left = 46
    Top = 24
    Width = 135
    Height = 14
    Alignment = taRightJustify
    Caption = 'Pre'#231'o utilizado para c'#225'lculo:'
  end
  object lblDiaParaCorte: TLabel [1]
    Left = 8
    Top = 50
    Width = 173
    Height = 14
    Alignment = taRightJustify
    Caption = 'Dia para corte do m'#234's de apura'#231#227'o:'
  end
  object lblMargemDocumentoAtual: TLabel [2]
    Left = 37
    Top = 76
    Width = 144
    Height = 14
    Alignment = taRightJustify
    Caption = 'Margem documento atual (%):'
  end
  object lblFaixaEncontradaDocumentoAtual: TLabel [3]
    Left = 94
    Top = 102
    Width = 87
    Height = 14
    Alignment = taRightJustify
    Caption = 'Faixa encontrada:'
  end
  object lblMargemMesApuracao: TLabel [4]
    Left = 32
    Top = 128
    Width = 149
    Height = 14
    Alignment = taRightJustify
    Caption = 'Margem m'#234's de apura'#231#227'o (%):'
  end
  object lblFaixaEncontradaMesApuracao: TLabel [5]
    Left = 94
    Top = 154
    Width = 87
    Height = 14
    Alignment = taRightJustify
    Caption = 'Faixa encontrada:'
  end
  inherited pnlBotoes: TPanel
    Top = 194
    Width = 659
    TabOrder = 6
    ExplicitTop = 194
    ExplicitWidth = 459
    inherited FlwBotoes: TFlowPanel
      Width = 655
      ExplicitWidth = 455
    end
    inherited btnSair: TBitBtnLocked
      Left = 579
      ExplicitLeft = 379
    end
  end
  inherited pnlStatus: TPanel
    Top = 222
    Width = 659
    TabOrder = 7
    ExplicitTop = 222
    ExplicitWidth = 459
    inherited pnlNomeForm: TPanel
      Left = 409
      Width = 250
      ExplicitLeft = 209
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 409
      ExplicitWidth = 209
    end
  end
  object edtPrecoUtilizadoParaCalculo: TEditFocus [9]
    Tag = 99
    Left = 185
    Top = 21
    Width = 200
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtDiaParaCorte: TEditFocus [10]
    Tag = 99
    Left = 185
    Top = 47
    Width = 60
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object edtFaixaEncontradaDocumentoAtual: TEditFocus [11]
    Tag = 99
    Left = 185
    Top = 99
    Width = 464
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMargemDocumentoAtual: TEditFocus [12]
    Tag = 99
    Left = 185
    Top = 73
    Width = 60
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtMargemMesApuracao: TEditFocus [13]
    Tag = 99
    Left = 185
    Top = 125
    Width = 60
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtFaixaEncontradaMesApuracao: TEditFocus [14]
    Tag = 99
    Left = 185
    Top = 151
    Width = 464
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 524
    Top = 20
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 492
    Top = 20
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 556
    Top = 20
  end
end
