inherited frmDigOperador: TfrmDigOperador
  Width = 429
  Height = 124
  BorderIcons = [biSystemMenu]
  Caption = 'Digite o c'#243'digo do operador'
  ExplicitWidth = 429
  ExplicitHeight = 124
  PixelsPerInch = 96
  TextHeight = 14
  object lbl8: TLabel [0]
    Left = 8
    Top = 5
    Width = 46
    Height = 14
    Caption = 'Operador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 53
    Width = 423
    TabOrder = 1
    ExplicitTop = 53
    ExplicitWidth = 423
    inherited FlwBotoes: TFlowPanel
      Width = 419
      ExplicitWidth = 419
    end
    inherited btnSair: TBitBtnLocked
      Left = 340
      ExplicitLeft = 340
    end
  end
  inherited pnlStatus: TPanel
    Top = 79
    Width = 423
    TabOrder = 2
    ExplicitTop = 79
    ExplicitWidth = 423
    inherited pnlNomeForm: TPanel
      Left = 252
      ExplicitLeft = 252
    end
    inherited pnlInfo: TPanel
      Width = 252
      ExplicitWidth = 252
    end
  end
  object edtCodOpe: TEditFocus [4]
    Tag = 99
    Left = 8
    Top = 19
    Width = 56
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 0
    OnExit = edtCodOpeExit
    OnKeyPress = edtCodOpeKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtNomOpe: TEditFocus [5]
    Left = 66
    Top = 19
    Width = 346
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
