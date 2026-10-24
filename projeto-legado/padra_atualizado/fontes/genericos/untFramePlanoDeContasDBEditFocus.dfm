object fraPlanoDeContasDBEditFocus: TfraPlanoDeContasDBEditFocus
  Left = 0
  Top = 0
  Width = 551
  Height = 22
  TabOrder = 0
  object lblPlaContas: TLabel
    Left = 7
    Top = 4
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = 'Plano de Contas: '
  end
  object dbeCodCta: TDBEditFocus
    Tag = 99
    Left = 94
    Top = 0
    Width = 55
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 0
    OnEnter = dbeCodCtaEnter
    OnExit = dbeCodCtaExit
    OnKeyPress = dbeCodCtaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object edtDesCta: TEditFocus
    Left = 150
    Top = 0
    Width = 400
    Height = 21
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
end
