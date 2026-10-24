inherited frmFatDigPedido: TfrmFatDigPedido
  Width = 223
  Height = 150
  Caption = 'Digite o n'#250'mero do pedido'
  OnDestroy = FormDestroy
  ExplicitWidth = 223
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 78
    Width = 217
    TabOrder = 1
    ExplicitTop = 78
    ExplicitWidth = 217
    inherited btnSair: TBitBtnLocked
      Left = 134
      ExplicitLeft = 134
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 4
      ExplicitLeft = 4
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 217
    Height = 78
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 16
      Width = 50
      Height = 14
      Caption = 'N'#186' Pedido:'
    end
    object Label3: TLabel
      Left = 22
      Top = 45
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 75
      Top = 13
      Width = 121
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtCodEmp: TEditFocus
      Left = 75
      Top = 42
      Width = 46
      Height = 22
      Alignment = taRightJustify
      MaxLength = 3
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
  end
  inherited pnlStatus: TPanel
    Top = 106
    Width = 217
    TabOrder = 2
    ExplicitTop = 106
    ExplicitWidth = 217
    inherited pnlNomeForm: TPanel
      Left = 46
      ExplicitLeft = 46
    end
    inherited pnlInfo: TPanel
      Width = 46
      ExplicitWidth = 46
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 24
  end
end
