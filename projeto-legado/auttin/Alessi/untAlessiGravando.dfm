inherited frmAlessiGravando: TfrmAlessiGravando
  Caption = 'frmAlessiGravando'
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
        'Cadastro de Bases'
        'Cadastro de Colorantes'
        'Cadastro de Cores')
    end
  end
end
