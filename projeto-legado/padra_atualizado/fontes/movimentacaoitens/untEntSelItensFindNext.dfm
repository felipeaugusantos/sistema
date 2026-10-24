inherited frmEntSelItensFindNext: TfrmEntSelItensFindNext
  Width = 462
  Height = 140
  Caption = 'Localizar registros'
  ExplicitWidth = 462
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 29
    Top = 16
    Width = 40
    Height = 14
    Caption = 'Produto:'
  end
  object Label3: TLabel [1]
    Left = 16
    Top = 39
    Width = 53
    Height = 14
    AutoSize = False
    Caption = 'Refer'#234'ncia:'
  end
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 456
    TabOrder = 2
    ExplicitTop = 69
    ExplicitWidth = 456
    inherited FlwBotoes: TFlowPanel
      Width = 375
      ExplicitWidth = 452
    end
    inherited btnSair: TBitBtnLocked
      Left = 377
      Top = 2
      Align = alRight
      ExplicitLeft = 373
    end
  end
  object edtCodIte: TEditFocus [4]
    Tag = 99
    Left = 75
    Top = 8
    Width = 51
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 5
    TabOrder = 0
    OnKeyPress = edtCodIteKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesIte: TEditFocus [5]
    Left = 127
    Top = 8
    Width = 318
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
  object edtRefere: TEditFocus [6]
    Tag = 99
    Left = 75
    Top = 31
    Width = 137
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 16
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 456
    TabOrder = 3
    ExplicitTop = 95
    ExplicitWidth = 456
    inherited pnlNomeForm: TPanel
      Left = 285
      ExplicitLeft = 285
    end
    inherited pnlInfo: TPanel
      Width = 285
      ExplicitWidth = 285
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 80
  end
end
