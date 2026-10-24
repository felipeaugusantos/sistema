inherited frmConsultaCadSuvGeral: TfrmConsultaCadSuvGeral
  VertScrollBar.Range = 212
  Caption = 'Consulta - Suvinil'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 316
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 316
    Width = 780
    Height = 30
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label4: TLabel
      Left = 58
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbePreVen: TDBEditFocus
      Left = 142
      Top = 5
      Width = 79
      Height = 21
      DataField = 'SUV_PREVEN'
      DataSource = dtsConsulta
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
