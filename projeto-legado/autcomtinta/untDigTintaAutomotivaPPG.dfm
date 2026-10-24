inherited frmDigTintaAutomotivaPPG: TfrmDigTintaAutomotivaPPG
  Left = 383
  Top = 224
  Width = 439
  Height = 481
  ExplicitWidth = 439
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 409
    Width = 433
    ExplicitTop = 409
    ExplicitWidth = 433
    inherited btnSair: TBitBtnLocked
      Left = 350
      ExplicitLeft = 350
    end
  end
  inherited pnlStatus: TPanel
    Top = 437
    Width = 433
    ExplicitTop = 437
    ExplicitWidth = 433
    inherited pnlNomeForm: TPanel
      Left = 262
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      ExplicitWidth = 262
    end
  end
  inherited pnlGeral: TPanel
    Width = 433
    Height = 409
    ExplicitWidth = 433
    ExplicitHeight = 409
    inherited pnlCabecalho: TPanel
      Width = 431
      Height = 255
      ExplicitWidth = 431
      ExplicitHeight = 255
      inherited gpbEmbalagem: TGroupBox
        Height = 186
        ExplicitHeight = 186
        inherited lblTipo: TLabel
          Top = 119
          ExplicitTop = 119
        end
        inherited rdbCopo: TRadioButton
          Caption = '&Balde'
        end
        inherited rdbSpray: TRadioButton
          Caption = '&Tambor'
        end
        inherited rdgAcerto: TRadioGroup
          Top = 141
          ExplicitTop = 141
        end
        inherited rdbLata: TRadioButton
          TabOrder = 10
        end
        inherited cmbTipoEmbalagem: TComboBoxFocus
          Top = 111
          Enabled = False
          ExplicitTop = 111
        end
        object rdbCopoPpg: TRadioButton
          Left = 8
          Top = 93
          Width = 57
          Height = 17
          Caption = '&Copo'
          TabOrder = 6
          OnClick = rdbCopoPpgClick
        end
      end
      inherited pnlPreco: TPanel
        Left = 223
        Top = 13
        Height = 237
        ExplicitLeft = 223
        ExplicitTop = 13
        ExplicitHeight = 237
        inherited Label4: TLabel
          Top = 183
          ExplicitTop = 183
        end
        inherited Label5: TLabel
          Top = 135
          ExplicitTop = 135
        end
        inherited Label2: TLabel
          Top = 87
          ExplicitTop = 87
        end
        object btnCfgEmb: TSpeedButton [3]
          Left = 163
          Top = 151
          Width = 30
          Height = 27
          Hint = 'Trocar o produto embalagem'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
            300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
            330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
            333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
            339977FF777777773377000BFB03333333337773FF733333333F333000333333
            3300333777333333337733333333333333003333333333333377333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCfgEmbClick
        end
        inherited edtPreco: TEditFocus
          Top = 199
          ExplicitTop = 199
        end
        inherited edtPreEmb: TEditFocus
          Top = 151
          Width = 153
          ExplicitTop = 151
          ExplicitWidth = 153
        end
        inherited edtPrecoSemEmb: TEditFocus
          Top = 103
          ExplicitTop = 103
        end
      end
    end
    inherited pnlAdicional: TPanel
      Top = 256
      Width = 431
      Height = 93
      ExplicitTop = 256
      ExplicitWidth = 431
      ExplicitHeight = 93
      object lblAdicional2: TLabel [1]
        Left = 184
        Top = 8
        Width = 60
        Height = 14
        Caption = 'lblAdicional2'
      end
      object lblAdicional3: TLabel [2]
        Left = 8
        Top = 48
        Width = 60
        Height = 14
        Caption = 'lblAdicional3'
      end
      object lblAdicional4: TLabel [3]
        Left = 184
        Top = 48
        Width = 60
        Height = 14
        Caption = 'lblAdicional4'
      end
      inherited cmbListaAdicional: TComboBoxFocus
        Width = 169
        ExplicitWidth = 169
      end
      object cmbListaAdicional2: TComboBoxFocus
        Left = 184
        Top = 23
        Width = 169
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
        OnChange = cmbListaAdicionalChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbListaAdicional3: TComboBoxFocus
        Left = 8
        Top = 63
        Width = 169
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 2
        OnChange = cmbListaAdicionalChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbListaAdicional4: TComboBoxFocus
        Left = 184
        Top = 63
        Width = 169
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 3
        OnChange = cmbListaAdicionalChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    inherited pnlRodape: TPanel
      Top = 349
      Width = 431
      Height = 59
      ExplicitTop = 349
      ExplicitWidth = 431
      ExplicitHeight = 59
      inherited chkComCat: TCheckBox
        Visible = False
      end
    end
  end
end
