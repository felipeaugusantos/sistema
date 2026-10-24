inherited frmLeArmazem: TfrmLeArmazem
  Width = 423
  Height = 139
  ActiveControl = edtCodAmz
  Caption = 'Informe o armaz'#233'm para o endere'#231'amento geral'
  ExplicitWidth = 423
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 68
    Width = 417
    ExplicitTop = 68
    ExplicitWidth = 417
    inherited FlwBotoes: TFlowPanel
      Width = 336
      ExplicitWidth = 413
    end
    inherited btnSair: TBitBtnLocked
      Left = 338
      Top = 2
      Align = alRight
      ExplicitLeft = 334
    end
  end
  object edtCodAmz: TEditFocus [2]
    Tag = 99
    Left = 12
    Top = 24
    Width = 35
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtCodAmzKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesAmz: TEditFocus [3]
    Left = 48
    Top = 24
    Width = 356
    Height = 22
    TabStop = False
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
  inherited pnlStatus: TPanel
    Top = 94
    Width = 417
    ExplicitTop = 94
    ExplicitWidth = 417
    inherited pnlNomeForm: TPanel
      Left = 246
      ExplicitLeft = 246
    end
    inherited pnlInfo: TPanel
      Width = 246
      ExplicitWidth = 246
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 80
  end
end
