inherited frmExcluiFechamentoEstoque: TfrmExcluiFechamentoEstoque
  Height = 149
  Caption = 'Remover '#250'ltimo fechamento de estoque'
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 111
    Top = 26
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 8
    Top = 49
    Width = 148
    Height = 14
    Caption = #218'ltimo fechamento de estoque:'
  end
  inherited pnlBotoes: TPanel
    Top = 78
    TabOrder = 1
    ExplicitTop = 78
    inherited FlwBotoes: TFlowPanel
      ExplicitTop = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 398
      ExplicitLeft = 398
    end
  end
  inherited pnlStatus: TPanel
    Top = 104
    TabOrder = 2
    ExplicitTop = 104
  end
  object edtCodEmp: TEditFocus [5]
    Tag = 99
    Left = 158
    Top = 18
    Width = 53
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
  object edtNomEmp: TEditFocus [6]
    Left = 213
    Top = 18
    Width = 261
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
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskUltFec: TMaskEditFocus [7]
    Tag = 99
    Left = 158
    Top = 41
    Width = 53
    Height = 22
    TabStop = False
    Color = 16768952
    EditMask = '99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = '  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 200
  end
end
