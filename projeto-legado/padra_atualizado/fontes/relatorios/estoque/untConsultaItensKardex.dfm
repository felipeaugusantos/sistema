inherited frmConsultaItensKardex: TfrmConsultaItensKardex
  Left = 76
  Top = 185
  Caption = 'Consulta de Produtos'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Label3: TLabel [7]
      Left = 569
      Top = 58
      Width = 62
      Height = 13
      Caption = 'Itens inativos'
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Estoque das Lojas'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
end
