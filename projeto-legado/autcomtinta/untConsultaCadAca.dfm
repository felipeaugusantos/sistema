inherited frmConsultaCadAca: TfrmConsultaCadAca
  Left = 70
  Top = 156
  Caption = 'Consulta de Produtos Acabados'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 555
      ExplicitLeft = 555
    end
  end
  inherited Panel1: TPanel
    object Shape: TShape [7]
      Left = 550
      Top = 56
      Width = 12
      Height = 12
      Brush.Color = clRed
    end
    object Label3: TLabel [8]
      Left = 568
      Top = 56
      Width = 73
      Height = 13
      Caption = 'Saldo Negativo'
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Mostrar Saldos'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
end
