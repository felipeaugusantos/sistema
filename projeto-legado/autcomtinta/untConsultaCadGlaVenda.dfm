inherited frmConsultaCadGlaVenda: TfrmConsultaCadGlaVenda
  Caption = 'Consulta - Glasurit'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 314
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 314
    Width = 780
    Height = 32
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label4: TLabel
      Left = 22
      Top = 12
      Width = 96
      Height = 13
      Caption = 'Pre'#231'o de Venda LT:'
    end
    object Label5: TLabel
      Left = 222
      Top = 12
      Width = 97
      Height = 13
      Caption = 'Pre'#231'o de Venda GL:'
    end
    object dbeVenLt: TDBEditFocus
      Left = 125
      Top = 5
      Width = 79
      Height = 21
      DataField = 'GLA_VENLT'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVenGl: TDBEditFocus
      Left = 325
      Top = 5
      Width = 79
      Height = 21
      DataField = 'GLA_VENGL'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
