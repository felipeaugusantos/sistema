inherited frmConsultaCadSta: TfrmConsultaCadSta
  Caption = 'Consulta - Starmix'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 290
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 290
    Width = 780
    Height = 56
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object lblVenLt: TLabel
      Left = 99
      Top = 15
      Width = 88
      Height = 13
      Caption = 'Pre'#231'o Venda Litro:'
    end
    object lblCusLt: TLabel
      Left = 103
      Top = 37
      Width = 84
      Height = 13
      Caption = 'Pre'#231'o Custo Litro:'
    end
    object lblCusGl: TLabel
      Left = 487
      Top = 35
      Width = 92
      Height = 13
      Caption = 'Pre'#231'o Custo Gal'#227'o:'
    end
    object lblVenGl: TLabel
      Left = 483
      Top = 15
      Width = 96
      Height = 13
      Caption = 'Pre'#231'o Venda Gal'#227'o:'
    end
    object dbePreVenLt: TDBEditFocus
      Left = 190
      Top = 9
      Width = 72
      Height = 21
      DataField = 'STA_PREVEN'
      DataSource = dtsConsulta
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCusLt: TDBEditFocus
      Left = 190
      Top = 30
      Width = 72
      Height = 21
      DataField = 'STA_PRECUS'
      DataSource = dtsConsulta
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCusGl: TDBEditFocus
      Left = 583
      Top = 30
      Width = 72
      Height = 21
      DataField = 'STA_PRECUS_GL'
      DataSource = dtsConsulta
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreVenGl: TDBEditFocus
      Left = 583
      Top = 9
      Width = 72
      Height = 21
      DataField = 'STA_PREVEN_GL'
      DataSource = dtsConsulta
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
