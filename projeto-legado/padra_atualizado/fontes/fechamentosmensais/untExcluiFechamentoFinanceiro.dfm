inherited frmExcluiFechamentoFinanceiro: TfrmExcluiFechamentoFinanceiro
  Left = 0
  Top = 0
  Width = 595
  Height = 133
  Caption = 'Remover '#250'ltimo fechamento financeiro'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  ExplicitWidth = 595
  ExplicitHeight = 133
  PixelsPerInch = 96
  TextHeight = 13
  object Label62: TLabel [0]
    Left = 104
    Top = 11
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 6
    Top = 34
    Width = 143
    Height = 13
    Alignment = taRightJustify
    Caption = #218'ltimo fechamento financeiro:'
  end
  inherited pnlBotoes: TPanel
    Top = 62
    Width = 589
    ExplicitTop = 62
    ExplicitWidth = 589
    inherited FlwBotoes: TFlowPanel
      Width = 585
      ExplicitTop = 2
      ExplicitWidth = 585
    end
    inherited btnSair: TBitBtnLocked
      Left = 506
      Top = 2
      ExplicitLeft = 506
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 88
    Width = 589
    ExplicitTop = 88
    ExplicitWidth = 589
    inherited pnlNomeForm: TPanel
      Left = 418
      ExplicitLeft = 418
    end
    inherited pnlInfo: TPanel
      Width = 418
      ExplicitWidth = 418
    end
  end
  object edtCodEmp: TEditFocus [5]
    Tag = 99
    Left = 152
    Top = 8
    Width = 61
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
  object edtNomEmp: TEditFocus [6]
    Left = 215
    Top = 8
    Width = 361
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
    TabOrder = 5
    Text = '  /  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 616
    Top = 136
  end
end
