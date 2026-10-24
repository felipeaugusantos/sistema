inherited frmDigTintaAutomotivaColorPro: TfrmDigTintaAutomotivaColorPro
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlGeral: TPanel
    inherited pnlCabecalho: TPanel
      inherited gpbEmbalagem: TGroupBox
        inherited rdbSpray: TRadioButton
          Left = 72
          ExplicitLeft = 72
        end
        inherited rdgAcerto: TRadioGroup
          TabOrder = 10
        end
        inherited rdbTambor: TRadioButton
          Left = 72
          ExplicitLeft = 72
        end
        inherited rdbLata: TRadioButton
          Left = 72
          ExplicitLeft = 72
        end
        inherited cmbTipoEmbalagem: TComboBoxFocus
          TabOrder = 9
        end
        inherited rdbBalde: TRadioButton
          Left = 132
          Top = 56
          TabOrder = 8
          ExplicitLeft = 132
          ExplicitTop = 56
        end
        object rdbSprayS: TRadioButton
          Left = 132
          Top = 38
          Width = 74
          Height = 17
          Caption = '&Spray Sint.'
          TabOrder = 7
          OnClick = rdbLitroClick
        end
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 65528
  end
  inherited PopupMenu1: TPopupMenu
    Left = 337
    Top = 209
  end
end
