inherited frmDigTintaAutomotivaDupont: TfrmDigTintaAutomotivaDupont
  Left = 442
  Top = 306
  Width = 473
  Height = 451
  Caption = 'Tinta de M'#225'quina - Dupont'
  ExplicitWidth = 473
  ExplicitHeight = 451
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 467
    ExplicitTop = 379
    ExplicitWidth = 467
    inherited btnSair: TBitBtnLocked
      Left = 384
      ExplicitLeft = 384
    end
  end
  inherited pnlStatus: TPanel
    Top = 407
    Width = 467
    ExplicitTop = 407
    ExplicitWidth = 467
    inherited pnlNomeForm: TPanel
      Left = 296
      ExplicitLeft = 296
    end
    inherited pnlInfo: TPanel
      Width = 296
      ExplicitWidth = 296
    end
  end
  inherited pnlGeral: TPanel
    Width = 467
    Height = 379
    ExplicitWidth = 467
    ExplicitHeight = 379
    inherited pnlCabecalho: TPanel
      Width = 465
      Height = 264
      ExplicitWidth = 465
      ExplicitHeight = 264
      inherited rdgModoVenda: TRadioGroup
        Width = 247
        ExplicitWidth = 247
      end
      inherited gpbEmbalagem: TGroupBox
        Left = 9
        Top = 63
        Width = 247
        Height = 196
        ExplicitLeft = 9
        ExplicitTop = 63
        ExplicitWidth = 247
        ExplicitHeight = 196
        inherited lblTipo: TLabel
          Top = 123
          ExplicitTop = 123
        end
        inherited rdbLitro: TRadioButton
          Left = 9
          Top = 40
          ExplicitLeft = 9
          ExplicitTop = 40
        end
        inherited rdbGalao: TRadioButton
          Top = 76
          ExplicitTop = 76
        end
        inherited rdbCopo: TRadioButton
          Top = 58
          ExplicitTop = 58
        end
        inherited rdbSpray: TRadioButton
          Left = 127
          Top = 17
          TabOrder = 10
          ExplicitLeft = 127
          ExplicitTop = 17
        end
        inherited rdgAcerto: TRadioGroup
          Left = 9
          Top = 148
          Width = 231
          TabOrder = 12
          ExplicitLeft = 9
          ExplicitTop = 148
          ExplicitWidth = 231
        end
        inherited rdbTambor: TRadioButton
          Left = 71
          Top = 58
          TabOrder = 6
          OnClick = rdbTamborClick
          ExplicitLeft = 71
          ExplicitTop = 58
        end
        inherited rdbLata: TRadioButton
          Left = 71
          Top = 40
          TabOrder = 5
          ExplicitLeft = 71
          ExplicitTop = 40
        end
        inherited cmbTipoEmbalagem: TComboBoxFocus
          Top = 120
          TabOrder = 11
          ExplicitTop = 120
        end
        inherited rdbBalde: TRadioButton
          Left = 8
          Top = 94
          TabOrder = 4
          OnClick = rdbBaldeClick
          ExplicitLeft = 8
          ExplicitTop = 94
        end
        inherited rdbSprayS: TRadioButton
          Left = 71
          Top = 76
          Width = 102
          Caption = '&Spray Sint'#233'tico'
          TabOrder = 7
          ExplicitLeft = 71
          ExplicitTop = 76
          ExplicitWidth = 102
        end
        object rdbDuco: TRadioButton
          Left = 158
          Top = 40
          Width = 81
          Height = 17
          Caption = 'Spray &Duco'
          TabOrder = 9
          OnClick = rdbDucoClick
        end
        object rdbPoliester: TRadioButton
          Left = 71
          Top = 94
          Width = 102
          Height = 17
          Caption = 'Spray &Poliester'
          TabOrder = 8
          OnClick = rdbPoliesterClick
        end
      end
      inherited pnlPreco: TPanel
        Left = 259
        Height = 246
        ExplicitLeft = 259
        ExplicitHeight = 246
        inherited Label4: TLabel
          Top = 191
          ExplicitTop = 191
        end
        inherited Label5: TLabel
          Top = 143
          ExplicitTop = 143
        end
        inherited Label2: TLabel
          Top = 95
          ExplicitTop = 95
        end
        inherited edtPreco: TEditFocus
          Top = 207
          ExplicitTop = 207
        end
        inherited edtPreEmb: TEditFocus
          Top = 159
          ExplicitTop = 159
        end
        inherited edtPrecoSemEmb: TEditFocus
          Top = 111
          ExplicitTop = 111
        end
      end
    end
    inherited pnlAdicional: TPanel
      Top = 265
      Width = 465
      Height = 52
      ExplicitTop = 265
      ExplicitWidth = 465
      ExplicitHeight = 52
    end
    inherited pnlRodape: TPanel
      Top = 317
      Width = 465
      Height = 61
      ExplicitTop = 317
      ExplicitWidth = 465
      ExplicitHeight = 61
    end
  end
  inherited PopupMenu1: TPopupMenu
    Top = 208
  end
end
