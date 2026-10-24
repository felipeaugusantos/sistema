inherited frmConsultaCadShe: TfrmConsultaCadShe
  Width = 805
  VertScrollBar.Range = 212
  Caption = 'Consulta - SherwinWhilliams'
  ExplicitWidth = 805
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 797
    Height = 318
  end
  inherited pnlBotoes: TPanel
    Width = 797
    ExplicitWidth = 797
    inherited btnSair: TBitBtnLocked
      Left = 704
      ExplicitLeft = 708
    end
  end
  inherited stbStatus: TStatusBar
    Width = 797
    ExplicitWidth = 797
  end
  inherited Panel1: TPanel
    Width = 797
    ExplicitWidth = 797
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 318
    Width = 797
    Height = 32
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    ExplicitTop = 320
    object Label3: TLabel
      Left = 131
      Top = 12
      Width = 76
      Height = 13
      Caption = 'Pre'#231'o de Custo:'
    end
    object Label4: TLabel
      Left = 480
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbePreCus: TDBEditFocus
      Left = 211
      Top = 5
      Width = 79
      Height = 21
      DataField = 'SHE_PRECUS'
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
    object dbePreVen: TDBEditFocus
      Left = 565
      Top = 5
      Width = 79
      Height = 21
      DataField = 'SHE_PREVEN'
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
