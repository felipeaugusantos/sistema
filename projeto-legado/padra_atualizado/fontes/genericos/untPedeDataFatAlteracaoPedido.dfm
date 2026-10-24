inherited frmPedeDataFatAlteracaoPedido: TfrmPedeDataFatAlteracaoPedido
  Width = 493
  Height = 242
  Caption = 'Nova data de faturamento do pedido'
  Position = poMainFormCenter
  ExplicitWidth = 493
  ExplicitHeight = 242
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 16
    Top = 75
    Width = 53
    Height = 14
    Alignment = taRightJustify
    Caption = 'Nova Data:'
  end
  object Label2: TLabel [1]
    Left = 38
    Top = 100
    Width = 31
    Height = 14
    Alignment = taRightJustify
    Caption = 'Motivo'
  end
  object Label3: TLabel [2]
    Left = 0
    Top = 34
    Width = 115
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data Faturamento Atual:'
  end
  object Label4: TLabel [3]
    Left = 236
    Top = 34
    Width = 65
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data Entrega:'
  end
  inherited pnlBotoes: TPanel
    Top = 171
    Width = 487
    ExplicitTop = 171
    ExplicitWidth = 487
    inherited FlwBotoes: TFlowPanel
      Width = 483
      ExplicitWidth = 483
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      ExplicitLeft = 404
    end
  end
  inherited pnlStatus: TPanel
    Top = 197
    Width = 487
    ExplicitTop = 197
    ExplicitWidth = 487
    inherited pnlNomeForm: TPanel
      Left = 316
      ExplicitLeft = 316
    end
    inherited pnlInfo: TPanel
      Width = 316
      ExplicitWidth = 316
    end
  end
  object mskDtaEntPed: TMaskEditFocus [6]
    Tag = 99
    Left = 75
    Top = 71
    Width = 62
    Height = 22
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mmoMotivo: TMemo [7]
    Tag = 99
    Left = 75
    Top = 96
    Width = 404
    Height = 63
    CharCase = ecUpperCase
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object Panel1: TPanel [8]
    Left = 0
    Top = 0
    Width = 487
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblFornecedor: TLabel
      Left = 0
      Top = 14
      Width = 487
      Height = 14
      Align = alTop
      Caption = 'Fornecedor:'
      ExplicitWidth = 59
    end
    object lblPedido: TLabel
      Left = 0
      Top = 0
      Width = 487
      Height = 14
      Align = alTop
      Caption = 'Pedido:'
      ExplicitWidth = 35
    end
  end
  object mskDataFatAtual: TMaskEditFocus [9]
    Tag = 99
    Left = 120
    Top = 31
    Width = 62
    Height = 22
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 5
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mskDataEntrega: TMaskEditFocus [10]
    Tag = 99
    Left = 307
    Top = 31
    Width = 62
    Height = 22
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 6
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object Panel2: TPanel [11]
    Left = 0
    Top = 57
    Width = 487
    Height = 4
    TabOrder = 7
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 316
    Top = 118
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 268
    Top = 54
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 196
    Top = 78
  end
end
