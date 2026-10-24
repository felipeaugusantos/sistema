inherited frmIncluiFechamentoFinanceiro: TfrmIncluiFechamentoFinanceiro
  Left = 0
  Top = 0
  Width = 638
  Height = 156
  Caption = 'Incluir novo fechamento financeiro'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  ExplicitWidth = 638
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 13
  object Label62: TLabel [0]
    Left = 144
    Top = 11
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 46
    Top = 34
    Width = 143
    Height = 13
    Caption = #218'ltimo fechamento financeiro:'
  end
  object Label2: TLabel [2]
    Left = 10
    Top = 57
    Width = 179
    Height = 13
    Alignment = taRightJustify
    Caption = 'Data do novo fechamento financeiro:'
  end
  inherited pnlBotoes: TPanel
    Top = 85
    Width = 632
    ExplicitTop = 93
    ExplicitWidth = 632
    inherited FlwBotoes: TFlowPanel
      Width = 628
      ExplicitTop = 2
      ExplicitWidth = 628
    end
    inherited btnSair: TBitBtnLocked
      Left = 549
      Top = 2
      ExplicitLeft = 549
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 111
    Width = 632
    ExplicitTop = 119
    ExplicitWidth = 632
    inherited pnlNomeForm: TPanel
      Left = 461
      ExplicitLeft = 461
    end
    inherited pnlInfo: TPanel
      Width = 461
      ExplicitWidth = 461
    end
  end
  object edtCodEmp: TEditFocus [6]
    Tag = 99
    Left = 191
    Top = 8
    Width = 60
    Height = 21
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 3
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
    Left = 255
    Top = 8
    Width = 367
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
  object mskUltFec: TMaskEditFocus [8]
    Tag = 99
    Left = 191
    Top = 31
    Width = 61
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
  object mskNovFec: TMaskEditFocus [9]
    Tag = 99
    Left = 191
    Top = 54
    Width = 62
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
    TabOrder = 6
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 736
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 436
    Top = 20
  end
end
