inherited frmExcluiFechamentoFiscal: TfrmExcluiFechamentoFiscal
  Width = 603
  Height = 149
  Caption = 'Remover '#250'ltimo fechamento fiscal'
  ExplicitWidth = 603
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 115
    Top = 26
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 40
    Top = 49
    Width = 120
    Height = 14
    Alignment = taRightJustify
    Caption = #218'ltimo fechamento fiscal:'
  end
  inherited pnlBotoes: TPanel
    Top = 76
    Width = 597
    TabOrder = 1
    ExplicitTop = 76
    ExplicitWidth = 597
    inherited btnSair: TBitBtnLocked
      Left = 514
      ExplicitLeft = 514
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 104
    Width = 597
    TabOrder = 2
    ExplicitTop = 104
    ExplicitWidth = 597
    inherited pnlNomeForm: TPanel
      Left = 426
      ExplicitLeft = 426
    end
    inherited pnlInfo: TPanel
      Width = 426
      ExplicitWidth = 426
    end
  end
  object edtCodEmp: TEditFocus [5]
    Tag = 99
    Left = 162
    Top = 18
    Width = 62
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
    Left = 225
    Top = 18
    Width = 362
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
    Left = 162
    Top = 41
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
    TabOrder = 5
    Text = '  /  /    '
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
