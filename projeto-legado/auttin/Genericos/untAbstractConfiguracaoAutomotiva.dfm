inherited frmAbstractConfiguracaoAutomotiva: TfrmAbstractConfiguracaoAutomotiva
  Caption = 'frmAbstractConfiguracaoAutomotiva'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      inherited edtTraTin: TEditFocus
        TabOrder = 3
      end
      inherited edtFatTin: TEditFocus
        TabOrder = 4
      end
      inherited edtNfmTin: TEditFocus
        TabOrder = 5
      end
      object chkAcumuladoAbsoluto: TCheckBox [9]
        Tag = 99
        Left = 299
        Top = 3
        Width = 175
        Height = 18
        Caption = 'Formula'#231#227'o Acumulada'
        TabOrder = 2
      end
      object grpProdutos: TGroupBox [10]
        Left = 14
        Top = 147
        Width = 529
        Height = 50
        Caption = 'Produtos'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 8
        object lblProdutos: TLabel
          Left = 11
          Top = 22
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Venda:'
        end
        object edtCodProdut: TEditFocus
          Tag = 99
          Left = 47
          Top = 18
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentCtl3D = False
          TabOrder = 0
          OnKeyPress = edtCodProdutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesProdut: TEditFocus
          Left = 104
          Top = 18
          Width = 417
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Ctl3D = True
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      inherited edtDesOpe: TEditFocus
        TabOrder = 6
      end
      inherited edtApreve: TEditFocus
        Height = 22
        TabOrder = 7
        ExplicitHeight = 22
      end
    end
  end
end
