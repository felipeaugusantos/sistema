inherited frmDigTintaAutomotivaSalcomix: TfrmDigTintaAutomotivaSalcomix
  Caption = 'frmDigTintaAutomotivaSalcomix'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlGeral: TPanel
    inherited pnlRodape: TPanel
      inherited edtVolume: TEditFocus
        TabOrder = 3
      end
      inherited chkComCat: TCheckBox
        Left = 216
        TabOrder = 1
        Visible = False
        ExplicitLeft = 216
      end
      object chkResina325: TCheckBox
        Left = 8
        Top = 6
        Width = 202
        Height = 17
        Caption = 'Resina 325?'
        TabOrder = 0
        OnClick = chkComCatClick
      end
    end
  end
end
