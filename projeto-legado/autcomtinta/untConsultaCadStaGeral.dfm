inherited frmConsultaCadStaGeral: TfrmConsultaCadStaGeral
  Caption = 'Consulta - Starmix'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 309
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 309
    Width = 780
    Height = 37
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
    object dbePreVenGl: TDBEditFocus
      Left = 583
      Top = 9
      Width = 72
      Height = 21
      DataField = 'STA_PREVEN_GL'
      DataSource = dtsConsulta
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
