inherited frmPedeDestinoRel: TfrmPedeDestinoRel
  Height = 135
  Caption = 'Selecione o destino de Impress'#227'o'
  ExplicitHeight = 135
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 105
    Top = 25
    Width = 39
    Height = 14
    Caption = 'Destino:'
  end
  inherited pnlBotoes: TPanel
    Top = 64
    TabOrder = 1
  end
  inherited pnlStatus: TPanel
    Top = 90
    TabOrder = 2
  end
  object cmbDestino: TComboBoxFocus [3]
    Left = 148
    Top = 21
    Width = 226
    Height = 22
    Style = csDropDownList
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 184
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 104
  end
end
