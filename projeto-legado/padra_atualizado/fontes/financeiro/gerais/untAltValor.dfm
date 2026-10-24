inherited frmAltValor: TfrmAltValor
  Width = 257
  Height = 168
  Caption = 'Alterar Valor'
  ExplicitWidth = 257
  ExplicitHeight = 168
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 53
    Top = 50
    Width = 55
    Height = 14
    Alignment = taRightJustify
    Caption = 'Novo valor:'
  end
  object Label1: TLabel [1]
    Left = 14
    Top = 22
    Width = 94
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor atual do t'#237'tulo:'
  end
  inherited pnlBotoes: TPanel
    Top = 96
    Width = 251
    TabOrder = 2
    inherited btnSair: TBitBtnLocked
      Left = 168
    end
  end
  inherited pnlStatus: TPanel
    Top = 124
    Width = 251
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      Left = 80
    end
    inherited pnlInfo: TPanel
      Width = 80
    end
  end
  object edtNovoValor: TEditFocus [5]
    Tag = 99
    Left = 113
    Top = 47
    Width = 107
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 1
    Text = '0,00'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtValAtual: TEditFocus [6]
    Tag = 99
    Left = 113
    Top = 19
    Width = 107
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 0
    Text = '0,00'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 72
  end
end
