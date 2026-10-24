inherited frmConsultaCadCorIndGeral: TfrmConsultaCadCorIndGeral
  Caption = 'Consulta - Coral Industrial'
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
      Width = 80
      Height = 13
      Caption = 'Pre'#231'o de Venda:'
    end
    object Label5: TLabel
      Left = 222
      Top = 12
      Width = 128
      Height = 13
      Caption = 'Pre'#231'o de Venda Colorante:'
    end
    object dbePreVen: TDBEditFocus
      Left = 125
      Top = 5
      Width = 79
      Height = 21
      DataField = 'COR_PREVEN'
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
    object dbeColVen: TDBEditFocus
      Left = 357
      Top = 5
      Width = 79
      Height = 21
      DataField = 'COR_COLVEN'
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
