inherited frmConsultaFatCatalogo: TfrmConsultaFatCatalogo
  Left = 397
  Top = 228
  Width = 800
  Height = 520
  Caption = 'Consulta de Cat'#225'logos de Pre'#231'os'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 424
    Width = 794
    Height = 51
    TabOrder = 3
    ExplicitTop = 424
    ExplicitWidth = 794
    ExplicitHeight = 51
    object Shape1: TShape [0]
      Left = 475
      Top = 30
      Width = 11
      Height = 10
      Anchors = [akTop, akRight]
      Brush.Color = clGreen
      Pen.Color = clGreen
      ExplicitLeft = 470
    end
    object Shape2: TShape [1]
      Left = 589
      Top = 30
      Width = 11
      Height = 10
      Anchors = [akTop, akRight]
      Brush.Color = clRed
      Pen.Color = clRed
      ExplicitLeft = 584
    end
    object Label1: TLabel [2]
      Left = 493
      Top = 28
      Width = 90
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Item em Promo'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 488
    end
    object Label3: TLabel [3]
      Left = 606
      Top = 28
      Width = 56
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Item Inativo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 601
    end
    object lblAltera: TLabel [4]
      AlignWithMargins = True
      Left = 5
      Top = 28
      Width = 662
      Height = 20
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '[ ENTER ] Alterar Item pelo Grid'
      Font.Charset = ANSI_CHARSET
      Font.Color = clCream
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 708
    end
    object Panel4: TPanel [5]
      Left = 2
      Top = 2
      Width = 790
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
    end
    inherited FlwBotoes: TFlowPanel
      Width = 790
      Height = 47
      Align = alBottom
      ExplicitWidth = 790
      ExplicitHeight = 47
      object btnMudaOrdem: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F3 ] Muda Ordem'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333FFF33F333FF3F330E0330FFFCCFCC33777FF7F3377F7730EEE030FFFC
          CFCC377777F7F33773770EEE0000FFFFFCCF777777773F33377FEEE0BFBF0FFF
          FCCF7777333373F337730E0BFBFBF0FFCCFF77733333373F77F330BFBFBFBF0F
          CCFF37F333333F7F773330FBFBFB0B0FFFFF37F3F33F737FFFFF30B0BF0FB000
          000037F73F73F777777730FB0BF0FB0FFFFF373F73F73F7F333F330030BF0F0F
          FF993F77373F737F3377CC33330BF00FFF9977FFF373F77F3F77CC993330009F
          99FF7777F337777F77F333993330F99F99FF3F77FF37F773773F993CC330FFF9
          9F9977F77F37F3377F77993CC330FFF99F997737733733377377}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnMudaOrdemClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 118
        Top = 0
        Width = 108
        Height = 22
        Caption = '[ F4 ] &Heran'#231'a'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000C00000010000000110000
          0011000000120000001200000013000000130000001000000004000000000000
          00000000000000000000000000000000000BA97563FFA87462FFA77261FFA571
          5FFFA5705EFFA36F5DFFA36D5CFFA26D5BFFA26C5AFF0000000F000000000000
          00000000000000000000000000000000000DAB7866FFFDFBF8FFF7EFE8FFF6EF
          E6FFF6EEE6FFF5EEE5FFF5EDE4FFF5EDE4FFA36D5CFF00000013000000000000
          0000265080B7336CB1FF326BB0FF2E63A6FFAD7C6AFFFDFCFAFFF7F0E9FFF7F0
          E8FFF7EFE7FFF6EFE7FFF6EEE6FFF5EEE5FFA46F5DFF00000012000000000000
          00003976B8FF91D2F4FF66BEEEFF60B5E4FFB07F6DFFFEFDFCFFF7F2EAFFF8F1
          E9FFF7F0E9FFF6F0E8FFF6EFE7FFF6EFE6FFA67260FF00000011000000000000
          00003F7DBCFF9AD6F5FF6CC3F0FF66B8E5FFB28070FFFEFEFDFFF8F3ECFFF8F2
          EBFFF7F1EAFFF7F1E9FFF7F0E8FFF7EFE8FFA87563FF00000010000000000000
          00004384C1FFA4DBF6FF73C7F1FF6CBEE8FFB48473FFFFFFFEFFF9F3EEFFF9F3
          EDFFF9F2ECFFF8F2EBFFF7F1EAFFF7F0E9FFAB7766FF0000000F000000000000
          0000488BC5FFADE1F8FF7ACCF2FF73C3E9FFB68676FFFFFFFFFFF9F5EEFFF9F4
          EEFFF9F3EDFFF8F3ECFFF8F2EBFFF7F2EBFFAC7A6AFF0000000E000000000000
          00004C92CAFFB6E6FAFF81D2F4FF7AC9EBFFB88878FFFFFFFFFFFAF5F0FFF9F5
          EFFFF9F5EFFFF9F4EEFFF9F3EDFFF9F3ECFFAF7E6CFF0000000D000000000000
          00005098CDFFBEE9FAFF88D6F6FF81CEEEFFBB8B7BFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFAFFB1816FFF0000000C000000000000
          0000539DD1FFC5EDFBFF8FDBF7FF89D5F2FFBD8D7DFFBB8C7CFFBA8B7BFFB989
          79FFB98977FFB78876FFB68674FFB58373FFB38371FF00000009000000000000
          000056A1D4FFCBF0FCFF95E0F8FF82CBE9FF72B7D9FF71B7D9FF70B7DAFF70B8
          DBFF6FB7DBFF4385BBFF00000009000000090000000800000002000000000000
          000058A5D7FFCBEDF8FF73B2D0FF5792B7FF5893B7FF5995BAFF5B99BDFF62A3
          C9FF69AFD4FF4184BBFF00000000000000000000000000000000000000000000
          000059A8D9FFBCDBE7FF8E7875FF9B7061FF946A5BFF8F6456FF885D50FF7B65
          63FF97BCD3FF488EC4FF00000000000000000000000000000000000000000000
          0000437EA2BD4A90BFFFB48E7FFFF3EDE7FFDEC9B8FFDDC8B5FFDBC4B2FF9770
          60FF3B7BAEFF40799EBD00000000000000000000000000000000000000000000
          00000000000000000000876B60BDB69181FFB69080FFB58E7FFFB28C7DFF7D60
          54BD000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnHerancaClick
      end
      object btnAtiva: TBitBtnLocked
        Left = 226
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F6 ] &Ativar/Inativar'
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
        TabOrder = 2
        OnClick = btnAtivaClick
      end
      object btnIncluiItem: TBitBtnLocked
        Left = 344
        Top = 0
        Width = 108
        Height = 22
        Caption = '[ F7 ] &Incluir'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DD7777777777
          777DDD7888888888887DDD7F88828888887DDD7FF8222888887DDD7FF2272688
          887DDD7FF2888228887DDD7FFFFF8822887DDD7FFFFFF888887DDD7F66666666
          687DDD7FFFFFFFFF887DDD7FFFFFFFFFF87DDD7F666666666F7DDD7FFFFFFFFF
          FF7DDD7FFFFFFFFFFF7DDD7777777777777DDDDDDDDDDDDDDDDD}
        TabOrder = 3
        OnClick = btnIncluiItemClick
      end
      object btnAltera: TBitBtnLocked
        Left = 452
        Top = 0
        Width = 108
        Height = 22
        Caption = '[ F8 ] A&lterar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnAlteraClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 560
        Top = 0
        Width = 108
        Height = 22
        Caption = '[ DEL ] &Excluir'
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
        TabOrder = 5
        OnClick = btnExcluirClick
      end
      object btnPromocao: TBitBtnLocked
        Left = 668
        Top = 0
        Width = 112
        Height = 22
        Caption = '[ F9 ] P&romo'#231#227'o'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00559999999995
          5555557777777775F5555559999999505555555777777757FFF5555555555550
          0955555555555FF7775F55555555995501955555555577557F75555555555555
          01995555555555557F5755555555555501905555555555557F57555555555555
          0F905555555555557FF75555555555500005555555555557777555555555550F
          F05555555555557F57F5555555555008F05555555555F775F755555555570000
          05555555555775577555555555700007555555555F755F775555555570000755
          55555555775F77555555555700075555555555F75F7755555555570007555555
          5555577F77555555555500075555555555557777555555555555}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnPromocaoClick
      end
      object btnPesquisar: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 108
        Height = 22
        Caption = '[ F5 ] &Pesquisar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
          CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
          1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
          D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
          7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
          E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
          EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
          8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnPesquisarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 670
      Top = 25
      Width = 122
      Height = 21
      Align = alRight
      ExplicitLeft = 670
      ExplicitTop = 25
      ExplicitWidth = 122
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 794
    TabOrder = 4
    ExplicitTop = 475
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 14
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 72
      Top = 10
      Width = 86
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnEnter = edtCodForEnter
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 158
      Top = 10
      Width = 499
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlPesquisa: TPanel [3]
    Left = 0
    Top = 41
    Width = 794
    Height = 36
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    Visible = False
    object lblPesquisa: TLabel
      Left = 8
      Top = 11
      Width = 70
      Height = 14
      Caption = '&Pesquisar por '
    end
    object lblNomeCampo: TLabel
      Left = 80
      Top = 11
      Width = 73
      Height = 14
      Caption = 'DET_MMMMMM'
    end
    object edtNumero: TEditFocus
      Left = 156
      Top = 7
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtString: TEditFocus
      Left = 228
      Top = 7
      Width = 329
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 556
      Top = 7
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.00'
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 77
    Width = 794
    Height = 251
    TabStop = False
    Align = alClient
    Ctl3D = False
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    OnKeyPress = dbgItensKeyPress
    OnTitleClick = dbgItensTitleClick
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CAT_ATIVO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Verdana'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ReadOnly = True
        Title.Caption = 'Ativo'
        Width = 30
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CAT_ITEALT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Verdana'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ReadOnly = True
        Title.Caption = 'Alterado'
        Width = 45
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_QTDEST'
        ReadOnly = True
        Title.Caption = 'Estoque'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CODFAB'
        ReadOnly = True
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 146
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 442
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_PREDOL'
        Title.Caption = 'D'#243'lar'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PRECOM'
        Title.Caption = 'Pre'#231'o Compra'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF01'
        Title.Caption = 'Desconto 01'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF02'
        Title.Caption = 'Desconto 02'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF03'
        Title.Caption = 'Desconto 03'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF04'
        Title.Caption = 'Desconto 04'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF05'
        Title.Caption = 'Desconto 05'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESF06'
        Title.Caption = 'Desconto 06'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_ICMENT'
        Title.Caption = 'ICM Entrada'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_SUBFED'
        Title.Caption = 'Impostos Federais (-)'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_IPIENT'
        Title.Caption = 'IPI Entrada'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_FREENT'
        Title.Caption = 'Frete'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_VALFRE'
        Title.Caption = 'Valor Frete'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_ACRFIN'
        Title.Caption = 'Acr'#233'sc. Financ.'
        Width = 81
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_SUBSTI'
        Title.Caption = 'Sub. Tribut'#225'ria'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESADB'
        Title.Caption = 'Desc. Ad. Boleto'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PRECUS'
        ReadOnly = True
        Title.Caption = 'Pre'#231'o Custo'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_OUTVAL'
        ReadOnly = True
        Title.Caption = 'Outros Valores'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_ICMSAI'
        Title.Caption = 'Icms. Saida'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_DESOPE'
        Title.Caption = 'Desp. Ope.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_IMPFED'
        Title.Caption = 'Imp. Fed.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR1'
        Title.Caption = 'Margem Bruta 1'
        Width = 82
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE1'
        Title.Caption = 'Pre'#231'o Venda 1'
        Width = 82
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR2'
        Title.Caption = 'Margem Bruta 2'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE2'
        Title.Caption = 'Pre'#231'o Venda 2'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR3'
        Title.Caption = 'Margem Bruta 3'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE3'
        Title.Caption = 'Pre'#231'o Venda 3'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR4'
        Title.Caption = 'Margem Bruta 4'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE4'
        Title.Caption = 'Pre'#231'o Venda 4'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR5'
        Title.Caption = 'Margem Bruta 5'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE5'
        Title.Caption = 'Pre'#231'o Venda 5'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR6'
        Title.Caption = 'Margem Bruta 6'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE6'
        Title.Caption = 'Pre'#231'o Venda 6'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_MARBR7'
        Title.Caption = 'Margem Bruta 7'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PREVE7'
        Title.Caption = 'Pre'#231'o Venda 7'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CAT_PREORI'
        Title.Caption = 'Pre'#231'o Venda Orig.'
        Width = 92
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PESOIT'
        Title.Caption = 'Peso Bruto'
        Width = 57
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_PESLIQ'
        Title.Caption = 'Peso Liq.'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CODUNI'
        Title.Caption = 'Unid.'
        Width = 35
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Sigla'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CLAIPI'
        Title.Caption = 'Classif. IPI'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CODBAR'
        Title.Caption = 'C'#243'd.Barra'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CPRCEN'
        Title.Alignment = taCenter
        Title.Caption = 'Centralizada'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_EMBALA'
        Title.Caption = 'Embalagem'
        Width = 57
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CAT_COMVAR'
        Title.Caption = 'Comiss'#227'o'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_CODMAR'
        Title.Caption = 'C'#243'd.Marca'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_OPEATI'
        ReadOnly = True
        Title.Caption = 'Ope. Ativou'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_DTAATI'
        ReadOnly = True
        Title.Caption = 'Dta. Ativa'#231#227'o'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_HORATI'
        ReadOnly = True
        Title.Caption = 'Hor. Ativa'#231#227'o'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_OPEALT'
        ReadOnly = True
        Title.Caption = 'Ope. Alterou'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_DTAALT'
        ReadOnly = True
        Title.Caption = 'Dta. Altera'#231#227'o'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAT_HORALT'
        ReadOnly = True
        Title.Caption = 'Hor. Altera'#231#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'APLICA'
        Title.Caption = 'Aplica'#231#227'o'
        Visible = True
      end>
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 328
    Width = 794
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object DBMemoFocus1: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 794
      Height = 76
      TabStop = False
      Align = alClient
      BorderStyle = bsNone
      DataField = 'CAT_APLICA'
      DataSource = dtsConsulta
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 480
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 192
  end
  object dspConsulta: TUniDataSetProvider
    Options = []
    UpdateMode = upWhereChanged
    Left = 576
    Top = 144
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    AfterInsert = cdsConsultaAfterInsert
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    AfterScroll = cdsConsultaAfterScroll
    Left = 608
    Top = 144
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 640
    Top = 144
  end
end
