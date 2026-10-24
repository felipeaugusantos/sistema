inherited frmFormulacaoImobiliariaAdvance: TfrmFormulacaoImobiliariaAdvance
  Left = 388
  Top = 240
  PixelsPerInch = 96
  TextHeight = 14
  inherited lsvFormulacao: TListView
    Columns = <
      item
        Caption = 'Tipo'
        Width = 70
      end
      item
        Caption = 'Componente'
        Width = 130
      end
      item
        Alignment = taRightJustify
        Caption = 'Quantidade'
        Width = 120
      end
      item
        Alignment = taRightJustify
        Caption = 'Pre'#231'o'
        Width = 120
      end>
    OnAdvanceCustomDrawItem = lsvFormulacaoAdvanceCustomDrawItem
  end
end
