object fraCentroCustoDBEditFocus: TfraCentroCustoDBEditFocus
  Left = 0
  Top = 0
  Width = 551
  Height = 22
  TabOrder = 0
  object lblEventos: TLabel
    Left = 3
    Top = 4
    Width = 88
    Height = 13
    Alignment = taRightJustify
    Caption = 'Centro de Custos:'
  end
  object dbeCodEve: TDBEditFocus
    Tag = 99
    Left = 94
    Top = 0
    Width = 55
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 20
    TabOrder = 0
    OnKeyPress = dbeCodEveKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
    OnChamaCadastro = dbeCodEveChamaCadastro
  end
  object edtDesEve: TEditFocus
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
