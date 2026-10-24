inherited frmDigTintaAutomotivaFarben: TfrmDigTintaAutomotivaFarben
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlGeral: TPanel
    inherited pnlCabecalho: TPanel
      inherited gpbEmbalagem: TGroupBox
        inherited rdbLitro: TRadioButton
          OnExit = rdbLitroExit
        end
        inherited rdbSpray: TRadioButton
          Caption = '&Lata'
        end
        object rdbSprayFarben: TRadioButton
          Left = 149
          Top = 55
          Width = 57
          Height = 17
          Caption = '&Spray'
          TabOrder = 10
          OnClick = rdbLitroClick
        end
      end
    end
  end
end
