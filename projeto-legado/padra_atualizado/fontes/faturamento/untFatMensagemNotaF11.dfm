inherited frmFatMensagemNotaF11: TfrmFatMensagemNotaF11
  Width = 664
  Height = 184
  Caption = 'Mensagem para a Nota Fiscal'
  ExplicitWidth = 664
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 114
    Width = 658
    Height = 25
    TabOrder = 5
    ExplicitTop = 114
    ExplicitWidth = 658
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 577
      Height = 21
      ExplicitWidth = 577
      ExplicitHeight = 21
      inherited btnConfirma: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 579
      Top = 2
      Height = 21
      Align = alRight
      ExplicitLeft = 579
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  object edtMens01: TEditFocus [2]
    Tag = 99
    Left = 0
    Top = 0
    Width = 658
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 80
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMens05: TEditFocus [3]
    Tag = 99
    Left = 0
    Top = 88
    Width = 658
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 80
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMens04: TEditFocus [4]
    Tag = 99
    Left = 0
    Top = 66
    Width = 658
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 80
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMens03: TEditFocus [5]
    Tag = 99
    Left = 0
    Top = 44
    Width = 658
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 80
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMens02: TEditFocus [6]
    Tag = 99
    Left = 0
    Top = 22
    Width = 658
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 80
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
    Top = 139
    Width = 658
    TabOrder = 6
    ExplicitTop = 139
    ExplicitWidth = 658
    inherited pnlNomeForm: TPanel
      Left = 487
      ExplicitLeft = 487
    end
    inherited pnlInfo: TPanel
      Width = 487
      ExplicitWidth = 487
    end
  end
end
