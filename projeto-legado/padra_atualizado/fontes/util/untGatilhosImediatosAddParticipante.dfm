inherited frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante
  Width = 326
  Height = 201
  Caption = 'Adicionar Participante'
  ExplicitWidth = 326
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 14
  object Label4: TLabel [0]
    Left = 5
    Top = 43
    Width = 94
    Height = 14
    Alignment = taRightJustify
    Caption = 'Grupo de Operador'
  end
  object Label2: TLabel [1]
    Left = 5
    Top = 5
    Width = 46
    Height = 14
    Alignment = taRightJustify
    Caption = 'Operador'
  end
  object Label148: TLabel [2]
    Left = 5
    Top = 82
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 130
    Width = 320
    TabOrder = 6
    ExplicitTop = 130
    ExplicitWidth = 320
    inherited FlwBotoes: TFlowPanel
      Width = 316
      ExplicitWidth = 316
    end
    inherited btnSair: TBitBtnLocked
      Left = 240
      ExplicitLeft = 240
    end
  end
  inherited pnlStatus: TPanel
    Top = 156
    Width = 320
    TabOrder = 7
    ExplicitTop = 156
    ExplicitWidth = 320
    inherited pnlNomeForm: TPanel
      Left = 149
      ExplicitLeft = 149
    end
    inherited pnlInfo: TPanel
      Width = 149
      ExplicitWidth = 149
    end
  end
  object edtGruGpo: TEditFocus [5]
    Tag = 99
    Left = 5
    Top = 57
    Width = 43
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtGruGpoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesGpo: TEditFocus [6]
    Left = 48
    Top = 57
    Width = 265
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodOpe: TEditFocus [7]
    Tag = 99
    Left = 5
    Top = 19
    Width = 43
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtCodOpeKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesOperador: TEditFocus [8]
    Left = 48
    Top = 19
    Width = 265
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 1
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtDesEmpresa: TEditFocus [9]
    Left = 48
    Top = 97
    Width = 265
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmpresa: TEditFocus [10]
    Tag = 99
    Left = 5
    Top = 97
    Width = 43
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 4
    OnExit = edtCodEmpresaExit
    OnKeyPress = edtCodEmpresaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 48
  end
end
