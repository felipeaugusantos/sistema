inherited frmConfiguracoesBrasimixAutomotiva: TfrmConfiguracoesBrasimixAutomotiva
  Left = 242
  Top = 193
  Width = 622
  Height = 469
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Brasimix Automotiva'
  Position = poMainFormCenter
  ExplicitWidth = 622
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 401
    Width = 616
    ExplicitTop = 401
    ExplicitWidth = 616
    DesignSize = (
      616
      28)
    inherited btnSair: TBitBtnLocked
      Left = 533
      TabOrder = 1
      ExplicitLeft = 533
    end
    object btnGravarConf: TBitBtnLocked
      Left = 4
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
      Left = 82
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
      TabOrder = 2
      Visible = False
      OnClick = btnRestaurarClick
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 616
    Height = 401
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 614
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Brasimix Automotiva'
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
    object pgcGeral: TPageControl
      Left = 1
      Top = 24
      Width = 614
      Height = 376
      ActivePage = tbsGeral
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      OnChange = pgcGeralChange
      object tbsGeral: TTabSheet
        Caption = '&1 - Geral'
        object Label6: TLabel
          Left = 121
          Top = 25
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object Label3: TLabel
          Left = 294
          Top = 71
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label20: TLabel
          Left = 171
          Top = 71
          Width = 47
          Height = 14
          Caption = 'BZA_PRE'
        end
        object Label2: TLabel
          Left = 39
          Top = 71
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label10: TLabel
          Left = 142
          Top = 117
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Gal'#227'o:'
        end
        object Label7: TLabel
          Left = 116
          Top = 94
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem:'
        end
        object Label19: TLabel
          Left = 75
          Top = 48
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
        end
        object Label1: TLabel
          Left = 37
          Top = 140
          Width = 182
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator para c'#225'lculo do pre'#231'o de Custo:'
        end
        object Label17: TLabel
          Left = 50
          Top = 162
          Width = 169
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (BRASIMIX.TXT):'
        end
        object Label18: TLabel
          Left = 105
          Top = 192
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object ColorLabel4: TColorLabel
          Left = 279
          Top = 192
          Width = 144
          Height = 14
          Caption = '(1) Acumulados (2) Absolutos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label21: TLabel
          Left = 88
          Top = 215
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label22: TLabel
          Left = 7
          Top = 233
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object edtDesProBza: TEditFocus
          Left = 278
          Top = 21
          Width = 309
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 12
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtProBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 21
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 2
          OnKeyPress = edtProBzaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaLaz: TCheckBox
          Tag = 99
          Left = 16
          Top = 6
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 67
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtFatBza: TEditFocus
          Tag = 99
          Left = 327
          Top = 67
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtGalBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 113
          Width = 56
          Height = 22
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
        object edtEmbBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 90
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 10
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 221
          Top = 6
          Width = 156
          Height = 15
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtNfmBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 44
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 6
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtMarBza: TEditFocus
          Tag = 99
          Left = 221
          Top = 136
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,###0.000'
        end
        object edtAcuAbs: TEditFocus
          Tag = 99
          Left = 221
          Top = 184
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 221
          Top = 207
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtApreve: TEditFocus
          Tag = 99
          Left = 221
          Top = 230
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPatBza: TFilenameEditFocus
          Left = 221
          Top = 159
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
          TabOrder = 9
          Width = 366
        end
      end
      object tbsEmbalagens: TTabSheet
        Caption = '&2 - Embalagens'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblBzaCop: TLabel
          Left = 69
          Top = 293
          Width = 154
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem Copo:'
        end
        object lblBzaSpr: TLabel
          Left = 65
          Top = 315
          Width = 158
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem Spray:'
        end
        object gpbGalao: TGroupBox
          Left = 4
          Top = 8
          Width = 593
          Height = 135
          Caption = 'Gal'#227'o'
          TabOrder = 0
          object Label4: TLabel
            Left = 39
            Top = 21
            Width = 180
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem SINTETICO:'
          end
          object Label5: TLabel
            Left = 61
            Top = 43
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem LACA:'
          end
          object Label8: TLabel
            Left = 36
            Top = 67
            Width = 183
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem POLIESTER:'
          end
          object Label9: TLabel
            Left = 69
            Top = 91
            Width = 150
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem P. U.:'
          end
          object Label11: TLabel
            Left = 61
            Top = 115
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem EPOXI:'
          end
          object edtDesBzaIgl: TEditFocus
            Left = 277
            Top = 17
            Width = 308
            Height = 22
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
          object edtBzaIgl: TEditFocus
            Tag = 99
            Left = 221
            Top = 17
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaGla: TEditFocus
            Left = 277
            Top = 39
            Width = 308
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 6
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtBzaGla: TEditFocus
            Tag = 99
            Left = 221
            Top = 39
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 1
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaGpo: TEditFocus
            Left = 277
            Top = 61
            Width = 308
            Height = 22
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
          object edtBzaGpo: TEditFocus
            Tag = 99
            Left = 221
            Top = 61
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaGpu: TEditFocus
            Left = 277
            Top = 83
            Width = 308
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtBzaGpu: TEditFocus
            Tag = 99
            Left = 221
            Top = 83
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 3
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaGpe: TEditFocus
            Left = 277
            Top = 105
            Width = 308
            Height = 22
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
          object edtBzaGpe: TEditFocus
            Tag = 99
            Left = 221
            Top = 105
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
        end
        object gpbLitro: TGroupBox
          Left = 4
          Top = 152
          Width = 593
          Height = 133
          Caption = 'Litro'
          TabOrder = 1
          object Label12: TLabel
            Left = 39
            Top = 19
            Width = 180
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem SINTETICO:'
          end
          object Label13: TLabel
            Left = 61
            Top = 41
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem LACA:'
          end
          object Label14: TLabel
            Left = 36
            Top = 63
            Width = 183
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem POLIESTER:'
          end
          object Label15: TLabel
            Left = 69
            Top = 85
            Width = 150
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem P. U.:'
          end
          object Label16: TLabel
            Left = 61
            Top = 107
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem EPOXI:'
          end
          object edtDesBzaIem: TEditFocus
            Left = 277
            Top = 15
            Width = 308
            Height = 22
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
          object edtBzaIem: TEditFocus
            Tag = 99
            Left = 221
            Top = 15
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaLla: TEditFocus
            Left = 277
            Top = 37
            Width = 308
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 6
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtBzaLla: TEditFocus
            Tag = 99
            Left = 221
            Top = 37
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 1
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaLpo: TEditFocus
            Left = 277
            Top = 59
            Width = 308
            Height = 22
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
          object edtBzaLpo: TEditFocus
            Tag = 99
            Left = 221
            Top = 59
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaLpu: TEditFocus
            Left = 277
            Top = 81
            Width = 308
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtBzaLpu: TEditFocus
            Tag = 99
            Left = 221
            Top = 81
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 3
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesBzaLpe: TEditFocus
            Left = 277
            Top = 103
            Width = 308
            Height = 22
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
          object edtBzaLpe: TEditFocus
            Tag = 99
            Left = 221
            Top = 103
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtBzaIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
        end
        object edtBzaCop: TEditFocus
          Tag = 99
          Left = 225
          Top = 289
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 2
          OnKeyPress = edtBzaIglKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesBzaCop: TEditFocus
          Left = 281
          Top = 289
          Width = 308
          Height = 22
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
        object edtBzaSpr: TEditFocus
          Tag = 99
          Left = 225
          Top = 311
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = edtBzaIglKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesBzaSpr: TEditFocus
          Left = 281
          Top = 311
          Width = 308
          Height = 22
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
      end
      object tbsConfCampos: TTabSheet
        Caption = '&3 - Consulta'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 429
    Width = 616
    ExplicitTop = 429
    ExplicitWidth = 616
    inherited pnlNomeForm: TPanel
      Left = 392
      Width = 224
      ExplicitLeft = 392
      ExplicitWidth = 224
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 392
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
  end
end
