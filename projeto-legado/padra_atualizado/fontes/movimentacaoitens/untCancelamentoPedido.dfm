inherited frmCancelamentoPedido: TfrmCancelamentoPedido
  Left = 226
  Top = 199
  Width = 459
  Height = 180
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Pedidos'
  Position = poMainFormCenter
  ExplicitWidth = 459
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 135
    Width = 453
    ExplicitTop = 135
    ExplicitWidth = 453
    inherited FlwBotoes: TFlowPanel
      Width = 449
      ExplicitWidth = 449
    end
    inherited btnSair: TBitBtnLocked
      Left = 320
      ExplicitLeft = 320
    end
  end
  inherited pnlStatus: TPanel
    Top = 135
    Width = 453
    TabOrder = 3
    ExplicitTop = 135
    ExplicitWidth = 453
    inherited pnlNomeForm: TPanel
      Left = 274
      Width = 179
      ExplicitLeft = 274
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 274
      ExplicitWidth = 274
    end
  end
  inherited pgcDados: TPageControl
    Width = 453
    Height = 135
    TabOrder = 1
    Visible = False
    ExplicitWidth = 453
    ExplicitHeight = 135
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 445
      ExplicitHeight = 103
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 453
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblPedOrc: TLabel
      Left = 8
      Top = 104
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido para cancelar:'
    end
    object Label1: TLabel
      Left = 68
      Top = 80
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNomEmp: TEditFocus
      Left = 197
      Top = 76
      Width = 234
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 116
      Top = 100
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 116
      Top = 76
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object rdgOpcoes: TRadioGroup
      Left = 98
      Top = 8
      Width = 256
      Height = 64
      Caption = 'Op'#231#245'es'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '&Pedido'
        '&Or'#231'amento')
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 8
  end
end
