inherited frmConfiguracoesKilling: TfrmConfiguracoesKilling
  Left = 199
  Top = 218
  Width = 599
  Height = 418
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Killing'
  Position = poMainFormCenter
  ExplicitWidth = 599
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 350
    Width = 593
    TabOrder = 1
    ExplicitTop = 310
    ExplicitWidth = 593
    DesignSize = (
      593
      0)
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 593
    Height = 327
    OnChange = pgcDadosChange
    ExplicitTop = 23
    ExplicitWidth = 593
    ExplicitHeight = 287
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 585
      ExplicitHeight = 255
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 585
        Height = 295
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        ExplicitHeight = 255
        object Label2: TLabel
          Left = 35
          Top = 59
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label3: TLabel
          Left = 293
          Top = 59
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label4: TLabel
          Left = 69
          Top = 82
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
        end
        object Label5: TLabel
          Left = 66
          Top = 105
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo de f'#243'rmulas'
        end
        object Label20: TLabel
          Left = 168
          Top = 59
          Width = 40
          Height = 14
          Caption = 'KIL_PRE'
        end
        object Label7: TLabel
          Left = 82
          Top = 134
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label22: TLabel
          Left = 2
          Top = 155
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object chkUsaKil: TCheckBox
          Tag = 99
          Left = 16
          Top = 30
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraKil: TEditFocus
          Tag = 99
          Left = 220
          Top = 55
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFatKil: TEditFocus
          Tag = 99
          Left = 326
          Top = 55
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtNfmKil: TEditFocus
          Tag = 99
          Left = 220
          Top = 78
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 192
          Top = 30
          Width = 121
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 220
          Top = 126
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtApreve: TEditFocus
          Tag = 99
          Left = 220
          Top = 149
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtPatKil: TFilenameEditFocus
          Left = 220
          Top = 101
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
          TabOrder = 5
          Width = 316
        end
        object grbConexao: TGroupBox
          Left = 20
          Top = 178
          Width = 498
          Height = 97
          Caption = 'Conex'#227'o Firebird'
          TabOrder = 8
          object Label1: TLabel
            Left = 19
            Top = 30
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Servidor:'
          end
          object Label6: TLabel
            Left = 23
            Top = 57
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'Usu'#225'rio:'
          end
          object Label8: TLabel
            Left = 276
            Top = 30
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Porta:'
          end
          object Label9: TLabel
            Left = 270
            Top = 57
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Senha:'
          end
          object edtSerKil: TEditFocus
            Tag = 99
            Left = 69
            Top = 26
            Width = 144
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttAlfabetico
          end
          object edtUsuKil: TEditFocus
            Tag = 99
            Left = 69
            Top = 54
            Width = 144
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPorKil: TEditFocus
            Tag = 99
            Left = 311
            Top = 26
            Width = 144
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtSenKil: TEditFocus
            Tag = 99
            Left = 311
            Top = 54
            Width = 144
            Height = 22
            Alignment = taLeftJustify
            PasswordChar = '*'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
      ExplicitHeight = 255
    end
  end
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 350
    Width = 593
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 2
    ExplicitTop = 310
    DesignSize = (
      593
      28)
    object btnSairConf: TBitBtnLocked
      Left = 511
      Top = 4
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairConfClick
    end
    object btnGravarConf: TBitBtnLocked
      Left = 4
      Top = 4
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
      Top = 4
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
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 593
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Killing'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  inherited pnlStatus: TPanel
    Top = 378
    Width = 593
    TabOrder = 3
    ExplicitTop = 338
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 422
      TabOrder = 1
      ExplicitLeft = 422
    end
    inherited pnlInfo: TPanel
      Width = 422
      TabOrder = 0
      ExplicitWidth = 422
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 24
  end
end
