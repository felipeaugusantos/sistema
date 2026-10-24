inherited frmConsultaCadBziVenda: TfrmConsultaCadBziVenda
  Caption = 'Consulta Brasimix Imobiliaria'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 312
  end
  inherited Panel1: TPanel
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Cadastrar Nova F'#243'rmula'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 312
    Width = 780
    Height = 34
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbePreVen: TDBEditFocus
      Left = 101
      Top = 5
      Width = 79
      Height = 21
      DataField = 'BZI_PREVEN'
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
  end
end
