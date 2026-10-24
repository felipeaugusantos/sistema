inherited frmCalcFatorInventario: TfrmCalcFatorInventario
  Width = 370
  Height = 165
  Caption = 'Calcula Fator'
  ExplicitWidth = 370
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 44
    Width = 178
    Height = 14
    Caption = 'Valor Total do Invent'#225'rio Desejado....:'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 16
    Width = 179
    Height = 14
    Caption = 'Valor Total do Invent'#225'rioAtual............:'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 72
    Width = 177
    Height = 14
    Caption = 'Fator Calculado.................................:'
  end
  inherited pnlBotoes: TPanel
    Top = 94
    Width = 364
    ExplicitTop = 94
    ExplicitWidth = 364
    inherited FlwBotoes: TFlowPanel
      Width = 360
      ExplicitTop = 2
      ExplicitWidth = 360
    end
    inherited btnSair: TBitBtnLocked
      Left = 284
      ExplicitLeft = 284
    end
  end
  inherited pnlStatus: TPanel
    Top = 120
    Width = 364
    ExplicitTop = 120
    ExplicitWidth = 364
    inherited pnlNomeForm: TPanel
      Left = 193
      ExplicitLeft = 193
    end
    inherited pnlInfo: TPanel
      Width = 193
      ExplicitWidth = 193
    end
  end
  object edtValAtu: TEditFocus [6]
    Left = 192
    Top = 8
    Width = 159
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 3
    Text = '0,00'
    NormalColor = clWindow
    FocusColor = clInactiveBorder
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtValFut: TEditFocus [7]
    Tag = 99
    Left = 192
    Top = 36
    Width = 159
    Height = 22
    Alignment = taRightJustify
    TabOrder = 4
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
  object edtFatorCalc: TEditFocus [8]
    Left = 193
    Top = 64
    Width = 159
    Height = 22
    Alignment = taRightJustify
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 5
    Text = '0,000000'
    NormalColor = clWindow
    FocusColor = clInactiveBorder
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.000000'
  end
end
