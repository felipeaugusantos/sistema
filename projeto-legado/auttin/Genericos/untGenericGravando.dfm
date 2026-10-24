inherited frmGenericGravando: TfrmGenericGravando
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmGenericGravando'
  ExplicitWidth = 808
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnConfirmaGeracao: TBitBtnLocked
      OnClick = btnConfirmaGeracaoClick
    end
  end
  inherited actlstPadrao: TActionList
    Left = 360
    Top = 232
  end
end
