inherited frmDigMotivoFinOco: TfrmDigMotivoFinOco
  Width = 629
  Height = 123
  Caption = 'Selecione o Motivo da Finaliza'#231#227'o da Ocorr'#234'ncia'
  ExplicitWidth = 629
  ExplicitHeight = 123
  PixelsPerInch = 96
  TextHeight = 14
  object lblMotivo: TLabel [0]
    Left = 8
    Top = 18
    Width = 39
    Height = 14
    Alignment = taRightJustify
    Caption = 'Motivo:'
  end
  inherited pnlBotoes: TPanel
    Top = 52
    Width = 623
    inherited FlwBotoes: TFlowPanel
      Width = 619
      ExplicitLeft = 6
      ExplicitTop = -2
      ExplicitWidth = 619
    end
    inherited btnSair: TBitBtnLocked
      Left = 540
    end
  end
  inherited pnlStatus: TPanel
    Top = 78
    Width = 623
    inherited pnlNomeForm: TPanel
      Left = 452
    end
    inherited pnlInfo: TPanel
      Width = 452
    end
  end
  object edtCodMot: TEditFocus [3]
    Tag = 99
    Left = 49
    Top = 14
    Width = 65
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 2
    OnKeyPress = edtCodMotKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesMot: TEditFocus [4]
    Left = 116
    Top = 14
    Width = 496
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    Color = 16768952
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
end
