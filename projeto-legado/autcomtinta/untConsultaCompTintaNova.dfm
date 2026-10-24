inherited frmConsultaCompTintaNova: TfrmConsultaCompTintaNova
  Left = 144
  Top = 107
  Caption = 'frmConsultaCompTintaNova'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    OnDrawDataCell = dbgConsultaDrawDataCell
  end
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 691
      ExplicitLeft = 691
    end
  end
  inherited qryConsulta: TUniQuery
    AfterOpen = qryConsultaAfterOpen
    AfterClose = qryConsultaAfterClose
    BeforeScroll = qryConsultaBeforeScroll
  end
end
