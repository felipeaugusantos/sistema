inherited frmConsultaCadGlaDinamicaGeral: TfrmConsultaCadGlaDinamicaGeral
  Left = 181
  Top = 178
  Width = 791
  Caption = 'Consulta - Glasurit'
  ExplicitWidth = 791
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 775
  end
  inherited pnlBotoes: TPanel
    Width = 775
    ExplicitWidth = 775
    inherited btnSair: TBitBtnLocked
      Left = 670
      ExplicitLeft = 670
    end
  end
  inherited stbStatus: TStatusBar
    Width = 775
    ExplicitWidth = 775
  end
  inherited Panel1: TPanel
    Width = 775
    ExplicitWidth = 775
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Formula'#231#227'o'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
end
