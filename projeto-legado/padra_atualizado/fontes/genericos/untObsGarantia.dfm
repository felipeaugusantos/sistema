inherited frmObsGarantia: TfrmObsGarantia
  Width = 522
  Height = 157
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 522
  ExplicitHeight = 157
  PixelsPerInch = 96
  TextHeight = 14
  object lblMensagem: TLabel [0]
    Left = 8
    Top = 9
    Width = 66
    Height = 14
    Caption = 'Observa'#231#245'es'
  end
  inherited pnlBotoes: TPanel
    Top = 84
    Width = 516
    TabOrder = 2
    ExplicitTop = 84
    ExplicitWidth = 516
    DesignSize = (
      516
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 512
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 512
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 412
      Width = 100
      Caption = '[ ESC ] &Sair'
      ExplicitLeft = 412
      ExplicitWidth = 100
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 86
      Height = 22
      Caption = '[ F2 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  object edtObs1: TEditFocus [3]
    Left = 8
    Top = 24
    Width = 498
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 100
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 6
    TipoTexto = ttAlfanumerico
  end
  object edtObs2: TEditFocus [4]
    Left = 8
    Top = 48
    Width = 498
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 100
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 6
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 112
    Width = 516
    TabOrder = 3
    ExplicitTop = 112
    ExplicitWidth = 516
    inherited pnlNomeForm: TPanel
      Left = 345
      ExplicitLeft = 345
    end
    inherited pnlInfo: TPanel
      Width = 345
      ExplicitWidth = 345
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 8
  end
end
