inherited frmConsultaCadWan: TfrmConsultaCadWan
  Caption = 'Consulta - Wanda'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 290
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 290
    Width = 780
    Height = 56
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
    object Label3: TLabel
      Left = 26
      Top = 33
      Width = 92
      Height = 13
      Caption = 'Pre'#231'o de Custo LT:'
    end
    object Label5: TLabel
      Left = 222
      Top = 12
      Width = 97
      Height = 13
      Caption = 'Pre'#231'o de Venda GL:'
    end
    object Label6: TLabel
      Left = 226
      Top = 33
      Width = 93
      Height = 13
      Caption = 'Pre'#231'o de Custo GL:'
    end
    object dbeVenLt: TDBEditFocus
      Left = 125
      Top = 5
      Width = 79
      Height = 21
      DataField = 'WAN_VENLT'
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
    object dbeCusLt: TDBEditFocus
      Left = 125
      Top = 26
      Width = 79
      Height = 21
      DataField = 'WAN_CUSLT'
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
    object dbeVenGl: TDBEditFocus
      Left = 325
      Top = 5
      Width = 79
      Height = 21
      DataField = 'WAN_VENGL'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCusGl: TDBEditFocus
      Left = 325
      Top = 26
      Width = 79
      Height = 21
      DataField = 'WAN_CUSGL'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
