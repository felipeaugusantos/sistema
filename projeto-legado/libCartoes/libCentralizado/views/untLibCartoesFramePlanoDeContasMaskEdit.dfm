object fraPlanoDeContasMskEdit: TfraPlanoDeContasMskEdit
  Left = 0
  Top = 0
  Width = 551
  Height = 22
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object lblPlaContas: TLabel
    Left = 3
    Top = 4
    Width = 82
    Height = 13
    Alignment = taRightJustify
    Caption = 'Plano de Contas:'
  end
  object edtDesCta: TEditFocus
    Left = 143
    Top = 0
    Width = 400
    Height = 21
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object MskCodCta: TMaskEdit
    Tag = 99
    Left = 85
    Top = 0
    Width = 52
    Height = 21
    EditMask = '99.99.999;0;_'
    MaxLength = 9
    TabOrder = 1
    Text = ''
    OnChange = MskCodCtaChange
    OnEnter = MskCodCtaEnter
    OnExit = MskCodCtaExit
    OnKeyPress = MskCodCtaKeyPress
  end
end
