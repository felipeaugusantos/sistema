inherited frmConsultaCadBzaVendaDinamica: TfrmConsultaCadBzaVendaDinamica
  Caption = 'Consulta Brasimix Automotiva'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 314
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
    Top = 314
    Width = 780
    Height = 32
    Align = alBottom
    Color = 16770261
    TabOrder = 4
  end
end
