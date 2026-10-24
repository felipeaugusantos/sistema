inherited frmBaixaOrdProdAcabadoIncluiItens: TfrmBaixaOrdProdAcabadoIncluiItens
  Width = 526
  Height = 131
  Caption = 'Incluir Item'
  Position = poMainFormCenter
  ExplicitWidth = 526
  ExplicitHeight = 131
  PixelsPerInch = 96
  TextHeight = 14
  object lblItemEntrada: TLabel [0]
    Left = 42
    Top = 9
    Width = 22
    Height = 14
    Alignment = taRightJustify
    Caption = 'Item:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel [1]
    Left = 6
    Top = 34
    Width = 58
    Height = 14
    Alignment = taRightJustify
    Caption = 'Quantidade:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 58
    Width = 520
    TabOrder = 3
    ExplicitTop = 58
    ExplicitWidth = 520
    inherited FlwBotoes: TFlowPanel
      Width = 516
      ExplicitWidth = 516
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 23
        Caption = '&Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
  end
  inherited pnlStatus: TPanel
    Top = 86
    Width = 520
    TabOrder = 4
    ExplicitTop = 86
    ExplicitWidth = 520
    inherited pnlNomeForm: TPanel
      Left = 349
      ExplicitLeft = 349
    end
    inherited pnlInfo: TPanel
      Width = 349
      ExplicitWidth = 349
    end
  end
  object edtCodIte: TEditFocus [4]
    Tag = 99
    Left = 67
    Top = 6
    Width = 89
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 15
    TabOrder = 0
    OnExit = edtCodIteExit
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
    Left = 161
    Top = 6
    Width = 357
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 1
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtQtdIte: TEditFocus [6]
    Tag = 99
    Left = 67
    Top = 30
    Width = 89
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
end
