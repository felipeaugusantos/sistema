object fraDadosFechamentoVendaPlanContasFrame: TfraDadosFechamentoVendaPlanContasFrame
  Left = 0
  Top = 0
  Width = 689
  Height = 26
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 26
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 74
    ExplicitWidth = 711
    ExplicitHeight = 166
    object lblCentroCusto: TLabel
      Left = 17
      Top = 6
      Width = 82
      Height = 13
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object edtDesCta: TEditFocus
      Left = 160
      Top = 2
      Width = 524
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskCodCta: TMaskEditFocus
      Tag = 99
      Left = 104
      Top = 2
      Width = 55
      Height = 22
      AutoSize = False
      EditMask = '99.99.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 1
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
end
