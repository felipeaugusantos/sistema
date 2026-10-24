inherited frmReinfCadastroManualR1000: TfrmReinfCadastroManualR1000
  Width = 268
  Height = 143
  Caption = 'REINF - R1000'
  ExplicitWidth = 268
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  object lblRecibo: TLabel [0]
    Left = 29
    Top = 27
    Width = 76
    Height = 14
    Caption = 'N'#250'mero Recibo:'
  end
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 262
    TabOrder = 1
    ExplicitTop = 72
    ExplicitWidth = 262
    inherited FlwBotoes: TFlowPanel
      Width = 258
      ExplicitWidth = 258
    end
    inherited btnSair: TBitBtnLocked
      Left = 182
      ExplicitLeft = 182
    end
  end
  inherited pnlStatus: TPanel
    Top = 98
    Width = 262
    TabOrder = 2
    ExplicitTop = 98
    ExplicitWidth = 262
    inherited pnlNomeForm: TPanel
      Left = 91
      ExplicitLeft = 91
    end
    inherited pnlInfo: TPanel
      Width = 91
      ExplicitWidth = 91
    end
  end
  object edtNumRecibo: TEditFocus [3]
    Left = 109
    Top = 24
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 584
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
  end
end
