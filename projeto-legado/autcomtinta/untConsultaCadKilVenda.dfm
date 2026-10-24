inherited frmConsultaCadKilVenda: TfrmConsultaCadKilVenda
  VertScrollBar.Range = 212
  Caption = 'Consulta - Killing'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 316
  end
  inherited Panel1: TPanel
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Cadastrar Nova F'#243'rmula'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
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
      Left = 49
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbePreVen: TDBEditFocus
      Left = 134
      Top = 5
      Width = 79
      Height = 21
      DataField = 'KIL_PREVEN'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
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
