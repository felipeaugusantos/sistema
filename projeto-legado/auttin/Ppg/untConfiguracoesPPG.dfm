inherited frmConfiguracoesPPG: TfrmConfiguracoesPPG
  Left = 347
  Top = 80
  Width = 548
  Height = 669
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - PPG'
  Position = poMainFormCenter
  ExplicitWidth = 548
  ExplicitHeight = 669
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 601
    Width = 542
    TabOrder = 1
    ExplicitTop = 601
    ExplicitWidth = 542
    DesignSize = (
      542
      28)
    inherited btnSair: TBitBtnLocked
      Left = 459
      TabOrder = 2
      ExplicitLeft = 459
    end
    object btnGravarConf: TBitBtnLocked
      Left = 9
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnGravarConfClick
    end
    object btnRestaurar: TBitBtnLocked
      Left = 88
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Restaurar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      Visible = False
      OnClick = btnRestaurarClick
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 542
    Height = 601
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 2
      Top = 2
      Width = 538
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - PPG'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 25
      Width = 538
      Height = 574
      ActivePage = TabSheet1
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = '&1 - Geral'
        object lbPatTxtDin: TLabel
          Left = 79
          Top = 158
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt):'
        end
        object lbPatTxt: TLabel
          Left = 79
          Top = 158
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt):'
        end
        object Label9: TLabel
          Left = 278
          Top = 86
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label7: TLabel
          Left = 100
          Top = 110
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem:'
        end
        object Label6: TLabel
          Left = 105
          Top = 62
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object Label20: TLabel
          Left = 155
          Top = 86
          Width = 45
          Height = 14
          Caption = 'PPG_PRE'
        end
        object Label15: TLabel
          Left = 67
          Top = 184
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de venda litro diluente:'
        end
        object Label12: TLabel
          Left = 70
          Top = 208
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de custo litro diluente:'
        end
        object Label11: TLabel
          Left = 23
          Top = 86
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label10: TLabel
          Left = 126
          Top = 134
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Gal'#227'o:'
        end
        object Label21: TLabel
          Left = 48
          Top = 232
          Width = 155
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo C'#243'digo Novas F'#243'rmulas'
        end
        object Label58: TLabel
          Left = 89
          Top = 295
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label63: TLabel
          Left = 5
          Top = 323
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object edtTraPpg: TEditFocus
          Tag = 99
          Left = 205
          Top = 83
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtProPpg: TEditFocus
          Tag = 99
          Left = 205
          Top = 59
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = edtProPpgKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtPpgVvd: TEditFocus
          Tag = 99
          Left = 205
          Top = 181
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 10
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPpgVcd: TEditFocus
          Tag = 99
          Left = 205
          Top = 205
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtGalPpg: TEditFocus
          Tag = 99
          Left = 205
          Top = 131
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatPpg: TEditFocus
          Tag = 99
          Left = 311
          Top = 83
          Width = 57
          Height = 20
          Alignment = taLeftJustify
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtEmbPpg: TEditFocus
          Tag = 99
          Left = 205
          Top = 107
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 10
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesProPpg: TEditFocus
          Left = 262
          Top = 59
          Width = 251
          Height = 20
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkUsaPpg: TCheckBox
          Tag = 99
          Left = 4
          Top = 7
          Width = 164
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 174
          Top = 7
          Width = 117
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtProCod: TEditFocus
          Tag = 99
          Left = 205
          Top = 229
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttInteiro
          EditFormat = '#,##0.00'
        end
        object chkNovFor: TCheckBox
          Tag = 99
          Left = 4
          Top = 34
          Width = 201
          Height = 18
          Caption = 'Utilizar novo arquivo de F'#243'rmulas(PM)'
          TabOrder = 2
          OnClick = chkNovForClick
        end
        object rgVersaoArquivo: TRadioGroup
          Left = 40
          Top = 249
          Width = 473
          Height = 38
          Caption = 'Vers'#227'o do Arquivo'
          Columns = 2
          Items.Strings = (
            'Vers'#227'o 1.0'
            'Vers'#227'o 2.0 (PaintManager)')
          TabOrder = 14
        end
        object chkAcuAbs: TCheckBox
          Tag = 99
          Left = 230
          Top = 34
          Width = 138
          Height = 18
          Caption = 'Formula'#231#227'o Acumulada'
          TabOrder = 3
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 220
          Top = 290
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtApreve: TEditFocus
          Tag = 99
          Left = 220
          Top = 316
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPatPpgDin: TFilenameEditFocus
          Left = 205
          Top = 154
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
          TabOrder = 10
          Width = 308
        end
      end
      object TabSheet2: TTabSheet
        Caption = '&2 - Embalagens'
        ImageIndex = 1
        object GroupBox1: TGroupBox
          Left = 1
          Top = 8
          Width = 526
          Height = 113
          Caption = 'Litro'
          TabOrder = 0
          object Label8: TLabel
            Left = 19
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label13: TLabel
            Left = 10
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label16: TLabel
            Left = 12
            Top = 63
            Width = 37
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron:'
          end
          object Label17: TLabel
            Left = 22
            Top = 87
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Omni:'
          end
          object edtPpgLdu: TEditFocus
            Tag = 99
            Left = 56
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLdu: TEditFocus
            Left = 120
            Top = 11
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLdf: TEditFocus
            Tag = 99
            Left = 56
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLdf: TEditFocus
            Left = 120
            Top = 35
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLdt: TEditFocus
            Tag = 99
            Left = 56
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLdt: TEditFocus
            Left = 120
            Top = 59
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLom: TEditFocus
            Tag = 99
            Left = 56
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLom: TEditFocus
            Left = 120
            Top = 83
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox2: TGroupBox
          Left = 2
          Top = 129
          Width = 526
          Height = 113
          Caption = 'Gal'#227'o'
          TabOrder = 1
          object Label1: TLabel
            Left = 19
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label2: TLabel
            Left = 10
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label3: TLabel
            Left = 12
            Top = 63
            Width = 37
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron:'
          end
          object Label4: TLabel
            Left = 22
            Top = 87
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Omni:'
          end
          object edtPpgGdu: TEditFocus
            Tag = 99
            Left = 56
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgGdu: TEditFocus
            Left = 120
            Top = 11
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgGdf: TEditFocus
            Tag = 99
            Left = 56
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgGdf: TEditFocus
            Left = 120
            Top = 35
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgGdt: TEditFocus
            Tag = 99
            Left = 56
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgGdt: TEditFocus
            Left = 120
            Top = 59
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgGom: TEditFocus
            Tag = 99
            Left = 56
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgGduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgGom: TEditFocus
            Left = 120
            Top = 83
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox3: TGroupBox
          Left = 3
          Top = 248
          Width = 526
          Height = 113
          Caption = 'Balde'
          TabOrder = 2
          object Label5: TLabel
            Left = 19
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label14: TLabel
            Left = 10
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label18: TLabel
            Left = 12
            Top = 63
            Width = 37
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron:'
          end
          object Label19: TLabel
            Left = 22
            Top = 87
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Omni:'
          end
          object edtPpgLAdu: TEditFocus
            Tag = 99
            Left = 56
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLAdu: TEditFocus
            Left = 120
            Top = 11
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLAdf: TEditFocus
            Tag = 99
            Left = 56
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLAdf: TEditFocus
            Left = 120
            Top = 35
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLAdt: TEditFocus
            Tag = 99
            Left = 56
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLAdt: TEditFocus
            Left = 120
            Top = 59
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgLAom: TEditFocus
            Tag = 99
            Left = 56
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgLAom: TEditFocus
            Left = 120
            Top = 83
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox4: TGroupBox
          Left = 3
          Top = 372
          Width = 526
          Height = 113
          Caption = 'Tambor'
          TabOrder = 3
          object Label22: TLabel
            Left = 19
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label23: TLabel
            Left = 10
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label24: TLabel
            Left = 12
            Top = 63
            Width = 37
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron:'
          end
          object Label25: TLabel
            Left = 22
            Top = 87
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = 'Omni:'
          end
          object edtPpgTdu: TEditFocus
            Tag = 99
            Left = 56
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgTdu: TEditFocus
            Left = 120
            Top = 11
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgTdf: TEditFocus
            Tag = 99
            Left = 56
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgTdf: TEditFocus
            Left = 120
            Top = 35
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgTdt: TEditFocus
            Tag = 99
            Left = 56
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgTdt: TEditFocus
            Left = 120
            Top = 59
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgTom: TEditFocus
            Tag = 99
            Left = 56
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgTom: TEditFocus
            Left = 120
            Top = 83
            Width = 393
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object tbsConfCampos: TTabSheet
        Caption = '&3 - Consulta'
        ImageIndex = 2
      end
      object tbsEmbPM: TTabSheet
        Caption = '&4 - Embalagens PM (PPG)'
        ImageIndex = 3
        object lblLazCop: TLabel
          Left = 50
          Top = 493
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Copo:'
        end
        object SpeedButton36: TSpeedButton
          Left = 493
          Top = 489
          Width = 29
          Height = 20
          Hint = 'Hor'#225'rios Programa'#231#227'o de Produ'#231#227'o'
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
          OnClick = SpeedButton36Click
        end
        object GroupBox5: TGroupBox
          Left = 1
          Top = 8
          Width = 526
          Height = 113
          Caption = 'Litro'
          TabOrder = 0
          object Label26: TLabel
            Left = 50
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label27: TLabel
            Left = 41
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label28: TLabel
            Left = 21
            Top = 63
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron(LA):'
          end
          object Label29: TLabel
            Left = 7
            Top = 87
            Width = 73
            Height = 14
            Alignment = taRightJustify
            Caption = 'Envirobase HP:'
          end
          object SpeedButton20: TSpeedButton
            Left = 492
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton20Click
          end
          object SpeedButton21: TSpeedButton
            Left = 492
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton21Click
          end
          object SpeedButton22: TSpeedButton
            Left = 492
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton22Click
          end
          object SpeedButton23: TSpeedButton
            Left = 492
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton23Click
          end
          object edtPpgPMLdu: TEditFocus
            Tag = 99
            Left = 85
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLdu: TEditFocus
            Left = 149
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLdf: TEditFocus
            Tag = 99
            Left = 85
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLdf: TEditFocus
            Left = 149
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLdt: TEditFocus
            Tag = 99
            Left = 85
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLdt: TEditFocus
            Left = 149
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLeb: TEditFocus
            Tag = 99
            Left = 85
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLeb: TEditFocus
            Left = 149
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox6: TGroupBox
          Left = 2
          Top = 127
          Width = 526
          Height = 113
          Caption = 'Gal'#227'o'
          TabOrder = 1
          object Label30: TLabel
            Left = 47
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label31: TLabel
            Left = 38
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label32: TLabel
            Left = 18
            Top = 63
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron(LA):'
          end
          object Label33: TLabel
            Left = 4
            Top = 87
            Width = 73
            Height = 14
            Alignment = taRightJustify
            Caption = 'Envirobase HP:'
          end
          object SpeedButton24: TSpeedButton
            Left = 491
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton24Click
          end
          object SpeedButton25: TSpeedButton
            Left = 491
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton25Click
          end
          object SpeedButton26: TSpeedButton
            Left = 491
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton26Click
          end
          object SpeedButton27: TSpeedButton
            Left = 491
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton27Click
          end
          object edtPpgPMGdu: TEditFocus
            Tag = 99
            Left = 84
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGdu: TEditFocus
            Left = 148
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGdf: TEditFocus
            Tag = 99
            Left = 84
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGdf: TEditFocus
            Left = 148
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGdt: TEditFocus
            Tag = 99
            Left = 84
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGdt: TEditFocus
            Left = 148
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGeb: TEditFocus
            Tag = 99
            Left = 84
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGeb: TEditFocus
            Left = 148
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox7: TGroupBox
          Left = 3
          Top = 246
          Width = 526
          Height = 113
          Caption = 'Balde'
          TabOrder = 2
          object Label34: TLabel
            Left = 46
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label35: TLabel
            Left = 34
            Top = 39
            Width = 42
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet::'
          end
          object Label36: TLabel
            Left = 17
            Top = 63
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron(LA):'
          end
          object Label37: TLabel
            Left = 3
            Top = 87
            Width = 73
            Height = 14
            Alignment = taRightJustify
            Caption = 'Envirobase HP:'
          end
          object SpeedButton28: TSpeedButton
            Left = 490
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton28Click
          end
          object SpeedButton29: TSpeedButton
            Left = 490
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton29Click
          end
          object SpeedButton30: TSpeedButton
            Left = 490
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton30Click
          end
          object SpeedButton31: TSpeedButton
            Left = 490
            Top = 85
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton31Click
          end
          object edtPpgPMLAdu: TEditFocus
            Tag = 99
            Left = 83
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAdu: TEditFocus
            Left = 147
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAdf: TEditFocus
            Tag = 99
            Left = 83
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAdf: TEditFocus
            Left = 147
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAdt: TEditFocus
            Tag = 99
            Left = 83
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAdt: TEditFocus
            Left = 147
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAeb: TEditFocus
            Tag = 99
            Left = 83
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAeb: TEditFocus
            Left = 145
            Top = 85
            Width = 342
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox8: TGroupBox
          Left = 3
          Top = 370
          Width = 526
          Height = 113
          Caption = 'Tambor'
          TabOrder = 3
          object Label38: TLabel
            Left = 46
            Top = 15
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Dulon:'
          end
          object Label39: TLabel
            Left = 37
            Top = 39
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delfleet:'
          end
          object Label40: TLabel
            Left = 17
            Top = 63
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deltron(LA):'
          end
          object Label41: TLabel
            Left = 3
            Top = 87
            Width = 73
            Height = 14
            Alignment = taRightJustify
            Caption = 'Envirobase HP:'
          end
          object SpeedButton32: TSpeedButton
            Left = 490
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton32Click
          end
          object SpeedButton33: TSpeedButton
            Left = 490
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton33Click
          end
          object SpeedButton34: TSpeedButton
            Left = 490
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton34Click
          end
          object SpeedButton35: TSpeedButton
            Left = 490
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton35Click
          end
          object edtPpgPMTdu: TEditFocus
            Tag = 99
            Left = 83
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTdu: TEditFocus
            Left = 147
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTdf: TEditFocus
            Tag = 99
            Left = 83
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTdf: TEditFocus
            Left = 147
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTdt: TEditFocus
            Tag = 99
            Left = 83
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTdt: TEditFocus
            Left = 147
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTeb: TEditFocus
            Tag = 99
            Left = 83
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            Enabled = False
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTeb: TEditFocus
            Left = 147
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object edtPpgCopEb: TEditFocus
          Tag = 99
          Left = 86
          Top = 489
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = edtPpgCopKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesPpgCopEb: TEditFocus
          Left = 150
          Top = 489
          Width = 340
          Height = 20
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object tbsEmbPMNexa: TTabSheet
        Caption = '&5 - Embalagens PM (Nexa)'
        ImageIndex = 4
        object GroupBox9: TGroupBox
          Left = 1
          Top = 8
          Width = 526
          Height = 132
          Caption = 'Litro'
          TabOrder = 0
          object Label42: TLabel
            Left = 64
            Top = 15
            Width = 16
            Height = 14
            Alignment = taRightJustify
            Caption = '2K:'
          end
          object Label43: TLabel
            Left = 30
            Top = 39
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS (LA):'
          end
          object Label44: TLabel
            Left = 32
            Top = 63
            Width = 48
            Height = 14
            Alignment = taRightJustify
            Caption = 'Industran:'
          end
          object Label45: TLabel
            Left = 10
            Top = 87
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Spectral Grey:'
          end
          object Label59: TLabel
            Left = 36
            Top = 111
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Zynamix:'
          end
          object btnPreVis: TSpeedButton
            Left = 491
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = btnPreVisClick
          end
          object SpeedButton1: TSpeedButton
            Left = 491
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 491
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton2Click
          end
          object SpeedButton3: TSpeedButton
            Left = 491
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton3Click
          end
          object SpeedButton4: TSpeedButton
            Left = 491
            Top = 107
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton4Click
          end
          object edtPpgPML2k: TEditFocus
            Tag = 99
            Left = 85
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPML2k: TEditFocus
            Left = 149
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAc: TEditFocus
            Tag = 99
            Left = 85
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAc: TEditFocus
            Left = 149
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLIn: TEditFocus
            Tag = 99
            Left = 85
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLIn: TEditFocus
            Left = 149
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLSg: TEditFocus
            Tag = 99
            Left = 85
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLSg: TEditFocus
            Left = 149
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLZy: TEditFocus
            Tag = 99
            Left = 85
            Top = 107
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLZy: TEditFocus
            Left = 149
            Top = 107
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox10: TGroupBox
          Left = 1
          Top = 142
          Width = 526
          Height = 132
          Caption = 'Gal'#227'o'
          TabOrder = 1
          object Label46: TLabel
            Left = 61
            Top = 15
            Width = 16
            Height = 14
            Alignment = taRightJustify
            Caption = '2K:'
          end
          object Label47: TLabel
            Left = 27
            Top = 39
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS (LA):'
          end
          object Label48: TLabel
            Left = 29
            Top = 63
            Width = 48
            Height = 14
            Alignment = taRightJustify
            Caption = 'Industran:'
          end
          object Label49: TLabel
            Left = 7
            Top = 87
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Spectral Grey:'
          end
          object Label60: TLabel
            Left = 35
            Top = 111
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Zynamix:'
          end
          object SpeedButton5: TSpeedButton
            Left = 491
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton5Click
          end
          object SpeedButton6: TSpeedButton
            Left = 491
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton6Click
          end
          object SpeedButton7: TSpeedButton
            Left = 491
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton7Click
          end
          object SpeedButton8: TSpeedButton
            Left = 491
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton8Click
          end
          object SpeedButton9: TSpeedButton
            Left = 491
            Top = 106
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton9Click
          end
          object edtPpgPMG2k: TEditFocus
            Tag = 99
            Left = 84
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMG2k: TEditFocus
            Left = 148
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGAc: TEditFocus
            Tag = 99
            Left = 84
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGAc: TEditFocus
            Left = 148
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGIn: TEditFocus
            Tag = 99
            Left = 84
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGIn: TEditFocus
            Left = 148
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGSg: TEditFocus
            Tag = 99
            Left = 84
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGSg: TEditFocus
            Left = 148
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMGZy: TEditFocus
            Tag = 99
            Left = 84
            Top = 107
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMGZy: TEditFocus
            Left = 148
            Top = 107
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox11: TGroupBox
          Left = 1
          Top = 276
          Width = 526
          Height = 132
          Caption = 'Balde'
          TabOrder = 2
          object Label50: TLabel
            Left = 60
            Top = 15
            Width = 16
            Height = 14
            Alignment = taRightJustify
            Caption = '2K:'
          end
          object Label51: TLabel
            Left = 26
            Top = 39
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS (LA):'
          end
          object Label52: TLabel
            Left = 28
            Top = 63
            Width = 48
            Height = 14
            Alignment = taRightJustify
            Caption = 'Industran:'
          end
          object Label53: TLabel
            Left = 6
            Top = 87
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Spectral Grey:'
          end
          object Label61: TLabel
            Left = 34
            Top = 111
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Zynamix:'
          end
          object SpeedButton10: TSpeedButton
            Left = 491
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton10Click
          end
          object SpeedButton11: TSpeedButton
            Left = 491
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton11Click
          end
          object SpeedButton12: TSpeedButton
            Left = 491
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton12Click
          end
          object SpeedButton13: TSpeedButton
            Left = 491
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton13Click
          end
          object SpeedButton14: TSpeedButton
            Left = 491
            Top = 107
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton14Click
          end
          object edtPpgPMLA2k: TEditFocus
            Tag = 99
            Left = 83
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLA2k: TEditFocus
            Left = 148
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAAc: TEditFocus
            Tag = 99
            Left = 83
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAAc: TEditFocus
            Left = 148
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAIn: TEditFocus
            Tag = 99
            Left = 83
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAIn: TEditFocus
            Left = 148
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLASg: TEditFocus
            Tag = 99
            Left = 83
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLASg: TEditFocus
            Left = 148
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMLAZy: TEditFocus
            Tag = 99
            Left = 83
            Top = 107
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtPpgPMLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMLAZy: TEditFocus
            Left = 148
            Top = 107
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object GroupBox12: TGroupBox
          Left = 1
          Top = 409
          Width = 526
          Height = 132
          Caption = 'Tambor'
          TabOrder = 3
          object Label54: TLabel
            Left = 60
            Top = 15
            Width = 16
            Height = 14
            Alignment = taRightJustify
            Caption = '2K:'
          end
          object Label55: TLabel
            Left = 26
            Top = 39
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS (LA):'
          end
          object Label56: TLabel
            Left = 28
            Top = 63
            Width = 48
            Height = 14
            Alignment = taRightJustify
            Caption = 'Industran:'
          end
          object Label57: TLabel
            Left = 6
            Top = 87
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Spectral Grey:'
          end
          object Label62: TLabel
            Left = 34
            Top = 111
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Zynamix:'
          end
          object SpeedButton15: TSpeedButton
            Left = 491
            Top = 11
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton15Click
          end
          object SpeedButton16: TSpeedButton
            Left = 491
            Top = 35
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton16Click
          end
          object SpeedButton17: TSpeedButton
            Left = 491
            Top = 59
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton17Click
          end
          object SpeedButton18: TSpeedButton
            Left = 491
            Top = 83
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton18Click
          end
          object SpeedButton19: TSpeedButton
            Left = 491
            Top = 107
            Width = 29
            Height = 20
            Hint = 'Adicionar Produtos Embalagens'
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
            OnClick = SpeedButton19Click
          end
          object edtPpgPMT2k: TEditFocus
            Tag = 99
            Left = 83
            Top = 11
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMT2k: TEditFocus
            Left = 148
            Top = 11
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTAc: TEditFocus
            Tag = 99
            Left = 83
            Top = 35
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTAc: TEditFocus
            Left = 148
            Top = 35
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTin: TEditFocus
            Tag = 99
            Left = 83
            Top = 59
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTin: TEditFocus
            Left = 148
            Top = 59
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTSg: TEditFocus
            Tag = 99
            Left = 83
            Top = 83
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTSg: TEditFocus
            Left = 148
            Top = 83
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPpgPMTZy: TEditFocus
            Tag = 99
            Left = 83
            Top = 107
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtPpgPMLduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesPpgPMTZy: TEditFocus
            Left = 148
            Top = 107
            Width = 340
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 629
    Width = 542
    TabOrder = 2
    ExplicitTop = 629
    ExplicitWidth = 542
    inherited pnlNomeForm: TPanel
      Left = 371
      TabOrder = 1
      ExplicitLeft = 371
    end
    inherited pnlInfo: TPanel
      Width = 371
      TabOrder = 0
      ExplicitWidth = 371
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 96
  end
end
