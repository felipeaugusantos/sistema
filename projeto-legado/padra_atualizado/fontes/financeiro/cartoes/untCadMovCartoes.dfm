inherited frmCadMovCartoes: TfrmCadMovCartoes
  Left = 331
  Top = 226
  Width = 800
  Height = 606
  Caption = 'Movimenta'#231#227'o de Cart'#245'es'
  ExplicitWidth = 800
  ExplicitHeight = 606
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 794
    Height = 65
    TabOrder = 3
    ExplicitTop = 496
    ExplicitWidth = 794
    ExplicitHeight = 65
    inherited FlwBotoes: TFlowPanel
      Width = 792
      Height = 61
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 792
      ExplicitHeight = 61
      inherited btnIncluir: TBitBtnLocked
        Width = 112
        ExplicitWidth = 112
      end
      inherited btnGravar: TBitBtnLocked
        Left = 112
        Width = 112
        ExplicitLeft = 112
        ExplicitWidth = 112
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 224
        Width = 112
        ExplicitLeft = 224
        ExplicitWidth = 112
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 336
        Width = 112
        ExplicitLeft = 336
        ExplicitWidth = 112
      end
      inherited btnCancela: TBitBtnLocked
        Left = 448
        Width = 112
        ExplicitLeft = 448
        ExplicitWidth = 112
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 560
        Width = 112
        ExplicitLeft = 560
        ExplicitWidth = 112
      end
      object btnBaixarCartoes: TBitBtnLocked
        Left = 672
        Top = 0
        Width = 112
        Height = 20
        Caption = '&Baixar Cart'#245'es'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          92635DA46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769FF00FFFF00FFFF00FFFF00FF92635DFCF3DEFFEED5FFEED5FFEED5FF
          EED5FEEBD1FEEBD1FEEBD1FEEBD1F7EDD0A46769FF00FFFF00FFFF00FFFF00FF
          92635DF7EAD8FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82F2E2
          C7A46769FF00FFFF00FFFF00FFFF00FF92635DF8EFDEFAE9D5FAE7D4FAE7D3F8
          E6D1F8E6D0F8E6D0F8E6D0F8E6D0F0E2C9A46769FF00FFFF00FFFF00FFFF00FF
          92635DEAE2D4FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82E1D3
          BAA46769FF00FFFF00FFFF00FFFF00FF987468AA9F95A69A92A59991A5998EA4
          978BA39689A19587A19384A19183A49381986B65FF00FFFF00FF8C38168C3816
          8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
          168C38168C38168C38168C3816FF00FFA77568E0E9EAE17545E17545E17545E1
          7545E17545E17545E17545E17545D7D8CAA46769FF00FF8B35128C38158C3816
          8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
          168C38168C38168C3816FF00FFFF00FFB17E6BD7B09CD1AF9ED1AF9ECEAA97CC
          A995CCA793CBA591CAA590CAA38BD4A78CA46769FF00FFFF00FFFF00FFFF00FF
          BB846EFFFFFFFFE3C1FFE2C0FFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFFC
          EFA46769FF00FFFF00FFFF00FFFF00FFC58C70FFFFFFFEBD82FEBD82FEBD82FE
          BD82FEBD82FEBD82FEBD82FEBD82FBF6E9A46769FF00FFFF00FFFF00FFFF00FF
          CB9173FFFFFFFEFFFFFEFFFFFEFEFEFEFBFAFBFAF7FBF8F6FAF7F3F8F4F0FCFA
          F0A46769FF00FFFF00FFFF00FFFF00FFD49876FFFFFFFEBD82FEBD82FEBD82FE
          BD82FEBD82FEBD82FEBD82FEBD82FFFCF4A46769FF00FFFF00FFFF00FFFF00FF
          D49876FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFAFFFF
          FFA46769FF00FFFF00FFFF00FFFF00FFD49876CF8E68CF8E68CF8E68CF8E68CF
          8E68CF8E68CF8E68CF8E68CF8E68CF8E68A46769FF00FFFF00FF}
        TabOrder = 6
        OnClick = btnBaixarCartoesClick
      end
      object btnEspelhoTEF: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 112
        Height = 20
        Caption = 'Espe&lho TEF'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnEspelhoTEFClick
      end
      object btnAjuda: TBitBtnLocked
        Left = 112
        Top = 20
        Width = 112
        Height = 20
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
          0000000000000000000000000000000000000000000000000000000000000000
          499191480000000000000000000000009AECEB91000000000000000000000000
          E309F49A00000000000000000000000049E3A349000000000000000000000000
          00000000000000000000000000000000009A9949000000000000000000000000
          00A309E2480000000000000000000000009AEC09E29100000000000000005191
          49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
          EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
          A3EC09EC9A000000000000000000000000000000000000000000}
        TabOrder = 8
        TabStop = False
        OnClick = btnAjudaClick
      end
      object btnAjuVal: TBitBtnLocked
        Left = 224
        Top = 20
        Width = 224
        Height = 20
        Caption = '[ F2 ] Ajustar Dados das Parcelas'
        TabOrder = 9
        OnClick = btnAjuValClick
      end
      object btnHistReceb: TBitBtnLocked
        Left = 448
        Top = 20
        Width = 112
        Height = 20
        Caption = '&Hist. Documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
          BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
          00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
          E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
          FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
          7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
          E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
          811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
          88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
          E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
          FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
          88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
          EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
          811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
          00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
          F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
          FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
          00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
          4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 10
        OnClick = btnHistRecebClick
      end
      object btnEstornoMovCartao: TBitBtnLocked
        Left = 560
        Top = 20
        Width = 112
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = '&Estorno Mov.'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 11
        OnClick = btnEstornoMovCartaoClick
      end
      object btnAltPortador: TBitBtnLocked
        Left = 672
        Top = 20
        Width = 112
        Height = 21
        Caption = '[ F4 ] Altera Portador'
        Enabled = False
        TabOrder = 12
        OnClick = btnAltPortadorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 674
      Top = 42
      Width = 112
      Height = 20
      Margins.Left = 2
      Margins.Top = 40
      Margins.Bottom = 1
      ExplicitLeft = 674
      ExplicitTop = 42
      ExplicitWidth = 112
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 561
    Width = 794
    TabOrder = 5
    ExplicitTop = 561
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 640
      Width = 154
      ExplicitLeft = 640
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 640
      ExplicitWidth = 640
    end
  end
  inherited pgcDados: TPageControl
    Top = 67
    Width = 794
    Height = 245
    TabOrder = 4
    Visible = False
    ExplicitTop = 67
    ExplicitWidth = 794
    ExplicitHeight = 245
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 213
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 67
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 31
      Top = 16
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 239
      Top = 16
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object Label5: TLabel
      Left = 367
      Top = 39
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 43
      Top = 39
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeNumDup: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 12
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_NUMDUP'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeParcel: TDBEditFocus
      Tag = 99
      Left = 280
      Top = 12
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_PARCEL'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      OnKeyPress = dbeParcelKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 405
      Top = 35
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_CODCLI'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentFont = False
      TabOrder = 4
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
      OnChamaCadastro = dbeCodCliChamaCadastro
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 35
      Width = 68
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_CODEMP'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentFont = False
      TabOrder = 2
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
      OnChamaCadastro = dbeCodEmpChamaCadastro
    end
    object edtNomEmp: TEditFocus
      Left = 159
      Top = 35
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomCli: TEditFocus
      Left = 477
      Top = 35
      Width = 237
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  object pnlDetalhe: TPanel [4]
    Left = 0
    Top = 67
    Width = 794
    Height = 245
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label4: TLabel
      Left = 53
      Top = 58
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label7: TLabel
      Left = 1
      Top = 80
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Cadastro:'
    end
    object Label8: TLabel
      Left = 370
      Top = 80
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Venc.:'
    end
    object Label9: TLabel
      Left = 11
      Top = 102
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor sem Taxa:'
    end
    object Label10: TLabel
      Left = 382
      Top = 102
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Taxas Adm.:'
    end
    object Label11: TLabel
      Left = 533
      Top = 102
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label12: TLabel
      Left = 3
      Top = 123
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Documento:'
    end
    object Label13: TLabel
      Left = 43
      Top = 146
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object Label6: TLabel
      Left = 22
      Top = 36
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Libera'#231#227'o N'#186':'
    end
    object Label16: TLabel
      Left = 369
      Top = 36
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' NSU:'
    end
    object lblConNsu: TLabel
      Left = 561
      Top = 36
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Confirme o NSU:'
    end
    object Label17: TLabel
      Left = 180
      Top = 80
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data da Transa'#231#227'o:'
    end
    object Label29: TLabel
      Left = 583
      Top = 102
      Width = 108
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor das Taxas Adm.:'
    end
    object dbeCodCar: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 54
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_CODCAR'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      OnEnter = dbeCodCarEnter
      OnExit = dbeCodCarExit
      OnKeyPress = dbeCodCarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
      OnChamaCadastro = dbeCodCarChamaCadastro
    end
    object dbeValSta: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 98
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_VALSTA'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      OnExit = dbeValStaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePerCar: TDBEditFocus
      Tag = 99
      Left = 443
      Top = 98
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_PERCAR'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      OnExit = dbePerCarExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValDup: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 120
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_VALDUP'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 12
      OnExit = dbeValDupExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHist01: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 142
      Width = 689
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_HIST01'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHist02: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 164
      Width = 689
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_HIST02'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesCar: TEditFocus
      Left = 179
      Top = 54
      Width = 351
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumLib: TDBEditFocus
      Left = 90
      Top = 32
      Width = 272
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_NUMCCD'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumNSU: TDBEditFocus
      Tag = 99
      Left = 410
      Top = 32
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_NUMNSU'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      ParentFont = False
      TabOrder = 1
      OnKeyPress = dbeNumNSUKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtConNsu: TEditFocus
      Tag = 99
      Left = 641
      Top = 32
      Width = 138
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 14
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = dbeNumNSUKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 14
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TcxDBDateEdit
      Tag = 99
      Left = 90
      Top = 76
      AutoSize = False
      DataBinding.DataField = 'MCA_DTACAD'
      DataBinding.DataSource = dtsMovCar
      Enabled = False
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnEditValueChanged = dbeDtaCadPropertiesEditValueChanged
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      Height = 22
      Width = 87
    end
    object dbeDtaVen: TcxDBDateEdit
      Tag = 99
      Left = 443
      Top = 76
      AutoSize = False
      DataBinding.DataField = 'MCA_DTAVEN'
      DataBinding.DataSource = dtsMovCar
      Enabled = False
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnEditValueChanged = dbeDtaVenPropertiesEditValueChanged
      StyleFocused.Color = clInfoBk
      TabOrder = 7
      Height = 22
      Width = 87
    end
    object dbeDtaCup: TcxDBDateEdit
      Tag = 99
      Left = 277
      Top = 76
      AutoSize = False
      DataBinding.DataField = 'MCA_DTACUP'
      DataBinding.DataSource = dtsMovCar
      Enabled = False
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnEditValueChanged = dbeDtaCupPropertiesEditValueChanged
      StyleFocused.Color = clInfoBk
      TabOrder = 6
      Height = 22
      Width = 87
    end
    object grbMovBan: TGroupBox
      Left = 11
      Top = 189
      Width = 774
      Height = 46
      Caption = 'Movimento Banc'#225'rio'
      TabOrder = 14
      Visible = False
      object Label25: TLabel
        Left = 12
        Top = 20
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object dbePorCar: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 17
        Width = 44
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MCA_PORCAR'
        DataSource = dtsMovCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbePorCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtDesPorCar: TEditFocus
        Left = 106
        Top = 17
        Width = 255
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
        Left = 364
        Top = 17
        Width = 405
        Height = 22
        TabOrder = 2
        ExplicitLeft = 364
        ExplicitTop = 17
        ExplicitWidth = 405
        inherited lblPlaContas: TLabel
          Left = 4
          Top = 3
          Width = 84
          Height = 14
          ExplicitLeft = 4
          ExplicitTop = 3
          ExplicitWidth = 84
          ExplicitHeight = 14
        end
        inherited dbeCodCta: TDBEditFocus
          Left = 92
          Height = 22
          DataField = 'MCA_CTACAR'
          DataSource = dtsMovCar
          OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
          PanelInfo = pnlInfo
          ExplicitLeft = 92
          ExplicitHeight = 22
        end
        inherited edtDesCta: TEditFocus
          Left = 148
          Width = 255
          Height = 22
          ExplicitLeft = 148
          ExplicitWidth = 255
          ExplicitHeight = 22
        end
      end
    end
    object dbeValTax: TDBEditFocus
      Tag = 99
      Left = 692
      Top = 98
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCA_VALTAX'
      DataSource = dtsMovCar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      OnExit = dbeValTaxExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlAntecipacao: TPanel
      Left = 533
      Top = 120
      Width = 252
      Height = 22
      BevelOuter = bvNone
      Caption = 'pnlAntecipacao'
      ShowCaption = False
      TabOrder = 16
      Visible = False
      object lblAntTax: TLabel
        Left = 8
        Top = 3
        Width = 153
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da Taxa de Antecipa'#231#227'o.: '
      end
      object edtAntTax: TEditFocus
        Tag = 99
        Left = 159
        Top = 0
        Width = 87
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnExit = dbeValTaxExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlFrete: TPanel
      Left = 187
      Top = 98
      Width = 181
      Height = 44
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 9
      Visible = False
      object lblFreMkt: TLabel
        Left = 32
        Top = 3
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Frete:'
      end
      object lblCupMkt: TLabel
        Left = 3
        Top = 25
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cupom Desconto:'
      end
      object dbeFreMkt: TDBEditFocus
        Tag = 99
        Left = 90
        Top = 0
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MCA_FREMKT'
        DataSource = dtsMovCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnExit = dbeValStaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCupMkt: TDBEditFocus
        Tag = 99
        Left = 90
        Top = 22
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MCA_CUPMKT'
        DataSource = dtsMovCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnExit = dbeValStaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlDadosBaixa: TPanel [5]
    Left = 0
    Top = 312
    Width = 794
    Height = 184
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label18: TLabel
      Left = 1
      Top = 1
      Width = 792
      Height = 24
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'INFORMA'#199#213'ES REFERENTES '#192' BAIXA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 790
    end
    object Label19: TLabel
      Left = 21
      Top = 55
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Recebimento:'
    end
    object Label20: TLabel
      Left = 114
      Top = 52
      Width = 200
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 9
      Font.Name = 'Luxi Sans'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label21: TLabel
      Left = 35
      Top = 77
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Recebido:'
    end
    object Label22: TLabel
      Left = 457
      Top = 99
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador Bx. Taxa:'
    end
    object Label23: TLabel
      Left = 37
      Top = 99
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador Baixa:'
    end
    object Label26: TLabel
      Left = 452
      Top = 121
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pl. Contas Bx. Taxa:'
    end
    object Label27: TLabel
      Left = 30
      Top = 121
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object Label24: TLabel
      Left = 453
      Top = 143
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc. Ban. Bx. Taxa:'
    end
    object Label14: TLabel
      Left = 31
      Top = 143
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc. Ban. Baixa:'
    end
    object Label15: TLabel
      Left = 477
      Top = 55
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor da Taxa:'
    end
    object Label28: TLabel
      Left = 399
      Top = 78
      Width = 147
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor da Taxa de Antecipa'#231#227'o:'
    end
    object Label30: TLabel
      Left = 672
      Top = 55
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Taxa:'
    end
    object Label31: TLabel
      Left = 650
      Top = 78
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Taxa Ant.:'
    end
    object Label32: TLabel
      Left = 759
      Top = 55
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label33: TLabel
      Left = 759
      Top = 77
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object edtDtaRec: TEditFocus
      Left = 113
      Top = 51
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValRec: TEditFocus
      Left = 113
      Top = 73
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorBai: TEditFocus
      Left = 113
      Top = 95
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCtaBai: TEditFocus
      Left = 113
      Top = 117
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDocBanBai: TEditFocus
      Left = 113
      Top = 139
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValTax: TEditFocus
      Left = 553
      Top = 51
      Width = 93
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtPorBaiTaxa: TEditFocus
      Left = 553
      Top = 95
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCtaBaiTaxa: TEditFocus
      Left = 553
      Top = 117
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDocBanTaxa: TEditFocus
      Left = 553
      Top = 139
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnDetalharValoresBaixa: TBitBtnLocked
      Left = 320
      Top = 74
      Width = 63
      Height = 21
      Hint = 'Mostra os valores de cada modalidade da baixa'
      Caption = '&Detalhar...'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnDetalharValoresBaixaClick
    end
    object edtValorTaxaAntecipacao: TEditFocus
      Left = 553
      Top = 73
      Width = 93
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPercentualTaxaBaixa: TEditFocus
      Left = 700
      Top = 51
      Width = 56
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPercentualAntBaixa: TEditFocus
      Left = 700
      Top = 73
      Width = 56
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
  end
  object dtsMovCar: TDataSource
    AutoEdit = False
    Left = 512
  end
end
