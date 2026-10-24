inherited frmConsultaCadDupGeral: TfrmConsultaCadDupGeral
  VertScrollBar.Range = 241
  Caption = 'Consulta DUPONT'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    TabOrder = 2
  end
  inherited Panel1: TPanel
    TabOrder = 1
    inherited lblBuscarPor1: TLabel
      Left = 177
      ExplicitLeft = 177
    end
    inherited lblChave2: TLabel
      Left = 236
      ExplicitLeft = 236
    end
    inherited lblBuscarPor2: TLabel
      Left = 177
      ExplicitLeft = 177
    end
    inherited lblBuscarPor3: TLabel
      Left = 177
      ExplicitLeft = 177
    end
    inherited lblChave3: TLabel
      Left = 236
      ExplicitLeft = 236
    end
    inherited lstIndices: TListBox
      Width = 166
      ExplicitWidth = 166
    end
    inherited edtFiltro1: TEdit
      Left = 174
      ExplicitLeft = 174
    end
    inherited edtFiltro2: TEdit
      Left = 174
      ExplicitLeft = 174
    end
    inherited edtFiltro3: TEdit
      Left = 172
      ExplicitLeft = 172
    end
    inherited btnExecutaTarefa: TBitBtn
      Caption = '[ F4 ] Formula'#231#227'o'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
end
