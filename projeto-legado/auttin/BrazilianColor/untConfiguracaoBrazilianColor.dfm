inherited frmConfiguracaoBrazilianColor: TfrmConfiguracaoBrazilianColor
  Caption = 'frmConfiguracaoBrazilianColor'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      object lblArquivos: TLabel [3]
        Left = 167
        Top = 147
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Arquivos:'
      end
      inherited edtNfmTin: TEditFocus
        MaxLength = 5
      end
      inherited grpProdutos: TGroupBox
        Left = 96
        Top = 175
        TabOrder = 9
        ExplicitLeft = 96
        ExplicitTop = 175
      end
      inherited chkUsaFor: TCheckBox
        Width = 118
        ExplicitWidth = 118
      end
      object grpEmbalagens: TGroupBox [14]
        Left = 96
        Top = 233
        Width = 529
        Height = 112
        Caption = 'Embalagens'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 10
        object lblEmbLitro: TLabel
          Left = 21
          Top = 22
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'Litro:'
        end
        object lblEmbGal: TLabel
          Left = 14
          Top = 50
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Gal'#227'o:'
        end
        object lblLata: TLabel
          Left = 21
          Top = 78
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lata:'
        end
        object edtCodEmbLit: TEditFocus
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
          OnKeyPress = edtCodEmbLitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEmbLit: TEditFocus
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
        object edtCodEmbGal: TEditFocus
          Tag = 99
          Left = 47
          Top = 46
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentCtl3D = False
          TabOrder = 2
          OnKeyPress = edtCodEmbLitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEmbGal: TEditFocus
          Left = 104
          Top = 46
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
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmbLat: TEditFocus
          Tag = 99
          Left = 47
          Top = 74
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentCtl3D = False
          TabOrder = 4
          OnKeyPress = edtCodEmbLitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEmbLat: TEditFocus
          Left = 104
          Top = 74
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
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object edtArquivos: TFilenameEditFocus
        Left = 220
        Top = 144
        Properties.Buttons = <
          item
            Default = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000115A5A5A1100000000009AE3DBECF7
              636C7474746B6300000000E3FFFF086375756B636B757463000000E3FFF6AD75
              7D7563FF637D756C120000E3FFF66CBE6C6363F663636C75630000E3FFFF6BBE
              6308FFFFFFFF637D630000E3FFFF6C08AC6363FF63636CBE630000E4FFFFB5B6
              F6F66CF66C0808B55A0000E4FFFFF66C08F6B56CADF6086C000000E4FFFFFF08
              6CB6F6F6F6B66C11000000E4FFFFFFFFF6B6746C74B60700000000ECFFFFFFFF
              FFFFFFFFFFFFEC00000000ECFFFFFFFFFFFFFFFFFFFFE400000000ECFFFFFFFF
              FFFFFFFFFFFFEC00000000A3ECECECECECECECECECECA3000000}
            Kind = bkGlyph
          end>
        StyleFocused.Color = clInfoBk
        TabOrder = 8
        Width = 405
      end
    end
  end
end
