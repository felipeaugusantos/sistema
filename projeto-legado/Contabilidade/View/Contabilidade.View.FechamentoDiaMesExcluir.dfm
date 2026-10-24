inherited frmExcluiFechamentoDiaMes: TfrmExcluiFechamentoDiaMes
  Width = 599
  Height = 129
  Caption = 'Excluir Fechamento Cont'#225'bil Di'#225'rio / Mensal'
  ExplicitWidth = 599
  ExplicitHeight = 129
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 103
    Top = 11
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 17
    Top = 34
    Width = 131
    Height = 14
    Alignment = taRightJustify
    Caption = #218'ltimo fechamento cont'#225'bil:'
  end
  inherited pnlBotoes: TPanel
    Top = 58
    Width = 593
    ExplicitTop = 58
    ExplicitWidth = 593
    inherited FlwBotoes: TFlowPanel
      Width = 589
      ExplicitWidth = 589
    end
    inherited btnSair: TBitBtnLocked
      Left = 513
      ExplicitLeft = 513
    end
  end
  inherited pnlStatus: TPanel
    Top = 84
    Width = 593
    ExplicitTop = 84
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 422
      ExplicitLeft = 422
    end
    inherited pnlInfo: TPanel
      Width = 422
      ExplicitWidth = 422
    end
  end
  object edtCodEmp: TEditFocus [4]
    Tag = 99
    Left = 152
    Top = 8
    Width = 60
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [5]
    Left = 218
    Top = 8
    Width = 360
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
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskUltFec: TMaskEditFocus [6]
    Tag = 99
    Left = 152
    Top = 31
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
    TabOrder = 4
    Text = '  /  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 32
  end
end
