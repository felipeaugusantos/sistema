inherited frmAlessiGravandoNovasFormulas: TfrmAlessiGravandoNovasFormulas
  Caption = 'frmAlessiGravandoNovasFormulas'
  ExplicitWidth = 808
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnConfirmaGeracao: TBitBtnLocked
      OnClick = btnConfirmaGeracaoClick
    end
  end
  inherited grpOpcoes: TGroupBox
    inherited chklstOpcoes: TCheckListBox
      Items.Strings = (
        'Novas Formulas')
    end
  end
end
