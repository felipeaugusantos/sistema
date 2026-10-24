inherited frmIncluiFechamentoDiaMes: TfrmIncluiFechamentoDiaMes
  Width = 651
  Height = 165
  Caption = 'Incluir novo Fechamento Cont'#225'bil Di'#225'rio / Mensal'
  ExplicitWidth = 651
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 142
    Top = 11
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 53
    Top = 35
    Width = 134
    Height = 14
    Caption = #218'ltimo Fechamento Dia/M'#234's:'
  end
  object Label2: TLabel [2]
    Left = 20
    Top = 59
    Width = 167
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data do novo fechamento cont'#225'bil:'
  end
  object Label3: TLabel [3]
    Left = 260
    Top = 35
    Width = 134
    Height = 14
    Caption = #218'ltimo Fechamento Cont'#225'bil:'
  end
  inherited pnlBotoes: TPanel
    Top = 94
    Width = 645
    TabOrder = 5
    ExplicitTop = 94
    ExplicitWidth = 645
    inherited FlwBotoes: TFlowPanel
      Width = 641
      ExplicitWidth = 641
    end
    inherited btnSair: TBitBtnLocked
      Left = 565
      ExplicitLeft = 565
    end
  end
  inherited pnlStatus: TPanel
    Top = 120
    Width = 645
    TabOrder = 6
    ExplicitTop = 120
    ExplicitWidth = 645
    inherited pnlNomeForm: TPanel
      Left = 474
      ExplicitLeft = 474
    end
    inherited pnlInfo: TPanel
      Width = 474
      ExplicitWidth = 474
    end
  end
  object edtCodEmp: TEditFocus [6]
    Tag = 99
    Left = 191
    Top = 8
    Width = 60
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [7]
    Left = 257
    Top = 8
    Width = 365
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
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
  object mskUltFec: TMaskEditFocus [8]
    Tag = 99
    Left = 191
    Top = 32
    Width = 60
    Height = 22
    TabStop = False
    Color = 16768952
    EditMask = '99/99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskNovFec: TMaskEditFocus [9]
    Tag = 99
    Left = 191
    Top = 56
    Width = 60
    Height = 22
    EditMask = '99/99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    TabOrder = 3
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object chkRaiz: TCheckBox [10]
    Left = 257
    Top = 59
    Width = 334
    Height = 17
    Caption = 'Fechar todas as empresas com a mesma raiz do CNPJ'
    TabOrder = 4
    WordWrap = True
  end
  object mskUltFecCon: TMaskEditFocus [11]
    Tag = 99
    Left = 398
    Top = 32
    Width = 60
    Height = 22
    TabStop = False
    Color = 16768952
    EditMask = '99/99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = '  /  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 65520
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 65520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 65520
  end
end
