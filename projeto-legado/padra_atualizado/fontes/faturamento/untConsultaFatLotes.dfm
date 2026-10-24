inherited frmConsultaFatLotes: TfrmConsultaFatLotes
  Left = 373
  Top = 232
  Caption = 'Consulta de Lotes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object btnMostraEstoque: TBitBtnLocked [11]
      Left = 554
      Top = 21
      Width = 143
      Height = 23
      Caption = '[ F6 ] Estoque das Lojas'
      TabOrder = 4
      OnClick = btnMostraEstoqueClick
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Top = 59
      Width = 145
      TabOrder = 7
      ExplicitTop = 59
      ExplicitWidth = 145
    end
  end
end
