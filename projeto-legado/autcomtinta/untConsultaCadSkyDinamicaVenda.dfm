inherited frmConsultaCadSkyDinamicaVenda: TfrmConsultaCadSkyDinamicaVenda
  Left = 263
  Top = 83
  Caption = 'Consulta - SkyMix Automotiva'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 475
      ExplicitLeft = 475
    end
  end
  inherited Panel1: TPanel
    inherited pnlLegendaCadCli: TPanel
      TabOrder = 6
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Cadastrar Nova F'#243'rmula'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
    object btnFormulacao: TBitBtnLocked
      Left = 552
      Top = 35
      Width = 217
      Height = 23
      Caption = '[ F6 ] Formula'#231#227'o'
      TabOrder = 5
      OnClick = btnFormulacaoClick
    end
  end
end
