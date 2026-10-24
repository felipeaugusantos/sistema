inherited frmFormulacaoIndustrialAdvanceTintoSystem: TfrmFormulacaoIndustrialAdvanceTintoSystem
  Caption = 'frmFormulacaoIndustrialAdvanceTintoSystem'
  PixelsPerInch = 96
  TextHeight = 14
  inherited lsvFormulacao: TListView
    OnAdvancedCustomDrawItem = lsvFormulacaoAdvancedCustomDrawItem
    OnAdvancedCustomDrawSubItem = lsvFormulacaoAdvancedCustomDrawSubItem
  end
  inherited pnlRodape: TPanel
    inherited Label1: TLabel
      Width = 455
    end
  end
end
