object fraDadosFechamentoVendaProjetoFrame: TfraDadosFechamentoVendaProjetoFrame
  Left = 0
  Top = 0
  Width = 688
  Height = 24
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 214
    ExplicitWidth = 711
    object lblProjetoCliente: TLabel
      Left = 9
      Top = 7
      Width = 90
      Height = 13
      Caption = 'Projeto do Cliente:'
    end
    object edtCodPrj: TEditFocus
      Tag = 99
      Left = 104
      Top = 2
      Width = 55
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrj: TEditFocus
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
end
