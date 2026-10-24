inherited frmSelItensVendasParaPedidoCompra: TfrmSelItensVendasParaPedidoCompra
  Width = 497
  Height = 274
  Caption = 'Filtro'
  OnDestroy = FormDestroy
  ExplicitWidth = 497
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 14
  object Label12: TLabel [0]
    Left = 48
    Top = 8
    Width = 57
    Height = 14
    Caption = 'Data Inicial.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel [1]
    Left = 354
    Top = 8
    Width = 53
    Height = 14
    Caption = 'Data Final.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel [2]
    Left = 66
    Top = 32
    Width = 38
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cliente.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblEmpresa: TLabel [3]
    Left = 52
    Top = 55
    Width = 52
    Height = 14
    Caption = 'Vendedor.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel [4]
    Left = 39
    Top = 78
    Width = 65
    Height = 14
    Alignment = taRightJustify
    Caption = 'Linha/Grupo.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [5]
    Left = 69
    Top = 101
    Width = 36
    Height = 14
    Caption = 'Marca.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [6]
    Left = 43
    Top = 124
    Width = 61
    Height = 14
    Caption = 'Fornecedor.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel [7]
    Left = 7
    Top = 148
    Width = 97
    Height = 14
    Alignment = taRightJustify
    Caption = 'Grupo de Compras.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [8]
    Left = 56
    Top = 172
    Width = 48
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 203
    Width = 491
    TabOrder = 9
    ExplicitTop = 203
    ExplicitWidth = 491
    inherited FlwBotoes: TFlowPanel
      Width = 487
      ExplicitWidth = 487
    end
    inherited btnSair: TBitBtnLocked
      Left = 408
      ExplicitLeft = 408
    end
  end
  inherited pnlStatus: TPanel
    Top = 229
    Width = 491
    TabOrder = 10
    ExplicitTop = 229
    ExplicitWidth = 491
    inherited pnlNomeForm: TPanel
      Left = 320
      ExplicitLeft = 320
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  object mskDtaEntIni: TMaskEditFocus [11]
    Tag = 99
    Left = 107
    Top = 5
    Width = 61
    Height = 22
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mskDtaEntFin: TMaskEditFocus [12]
    Tag = 99
    Left = 407
    Top = 5
    Width = 62
    Height = 22
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object edtCodCliente: TEditFocus [13]
    Tag = 99
    Left = 107
    Top = 29
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    ParentFont = False
    TabOrder = 2
    OnExit = edtCodClienteExit
    OnKeyPress = edtCodClienteKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtDesCliente: TEditFocus [14]
    Left = 169
    Top = 29
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodVen: TEditFocus [15]
    Tag = 99
    Left = 107
    Top = 52
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 3
    OnExit = edtCodVenExit
    OnKeyPress = edtCodVenKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesVen: TEditFocus [16]
    Left = 169
    Top = 52
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 12
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskLinhaGrupo: TMaskEditFocus [17]
    Tag = 99
    Left = 107
    Top = 75
    Width = 61
    Height = 22
    EditMask = '999.999;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ParentFont = False
    TabOrder = 4
    Text = ''
    OnExit = mskLinhaGrupoExit
    OnKeyPress = mskLinhaGrupoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtDesGrupo: TEditFocus [18]
    Left = 169
    Top = 75
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 13
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMarca: TEditFocus [19]
    Tag = 99
    Left = 107
    Top = 98
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 6
    ParentFont = False
    TabOrder = 5
    OnExit = edtMarcaExit
    OnKeyPress = edtMarcaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttNumerico
  end
  object edtDesMarca: TEditFocus [20]
    Left = 169
    Top = 98
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 14
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtFornecedor: TEditFocus [21]
    Tag = 99
    Left = 107
    Top = 121
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    ParentFont = False
    TabOrder = 6
    OnExit = edtFornecedorExit
    OnKeyPress = edtFornecedorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtDesFornecedor: TEditFocus [22]
    Left = 169
    Top = 121
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 15
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtGruCmp: TEditFocus [23]
    Tag = 99
    Left = 107
    Top = 145
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnExit = edtGruCmpExit
    OnKeyPress = edtGruCmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesGruCmp: TEditFocus [24]
    Left = 169
    Top = 145
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 16
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmp: TEditFocus [25]
    Tag = 99
    Left = 107
    Top = 169
    Width = 61
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnExit = edtCodEmpExit
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [26]
    Left = 169
    Top = 169
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 17
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 340
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 292
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 220
  end
end
