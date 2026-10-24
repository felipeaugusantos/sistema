inherited frmCadAbfReformaTributaria: TfrmCadAbfReformaTributaria
  Width = 867
  Height = 751
  Caption = 'Abrevia'#231#227'o Reforma Tribut'#225'ria'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 867
  ExplicitHeight = 751
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 678
    Width = 861
    ExplicitTop = 678
    ExplicitWidth = 861
    inherited FlwBotoes: TFlowPanel
      Width = 857
      ExplicitWidth = 857
    end
    inherited btnSair: TBitBtnLocked
      Left = 778
      ExplicitLeft = 778
    end
    object btnPesquisa: TBitBtnLocked
      Left = 371
      Top = 4
      Width = 78
      Height = 20
      Caption = '&Pesquisar'
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
      TabOrder = 2
      OnClick = btnPesquisaClick
    end
    object btnCancela: TBitBtnLocked
      Left = 297
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Cancelar'
      Enabled = False
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
      TabOrder = 3
      OnClick = btnCancelaClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 223
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Excluir'
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
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnGravar: TBitBtnLocked
      Left = 148
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Gravar'
      Enabled = False
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
      TabOrder = 5
      OnClick = btnGravarClick
    end
    object btnIncluir: TBitBtnLocked
      Left = 5
      Top = 4
      Width = 71
      Height = 20
      Caption = '&Incluir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 6
      OnClick = btnIncluirClick
    end
    object btnAlterar: TBitBtnLocked
      Left = 77
      Top = 4
      Width = 69
      Height = 20
      Caption = '&Alterar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
        CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
        A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
        820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
        860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
        C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
        D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
        9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 7
      OnClick = btnAlterarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 706
    Width = 861
    ExplicitTop = 706
    ExplicitWidth = 861
    inherited pnlNomeForm: TPanel
      Left = 690
      ExplicitLeft = 690
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 861
    Height = 34
    Align = alTop
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 18
      Top = 9
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 152
      Top = 9
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object edtCodApc: TEditFocus
      Tag = 99
      Left = 58
      Top = 6
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 210
      Top = 6
      Width = 615
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
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
  object pnlProgresso: TPanel [3]
    Left = 0
    Top = 637
    Width = 861
    Height = 41
    Align = alBottom
    TabOrder = 4
    Visible = False
    object lblInformacao: TLabel
      Left = 1
      Top = 25
      Width = 859
      Height = 15
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'AGUARDE PROCESSANDO REGISTROS...'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Verdana'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitTop = 24
      ExplicitWidth = 821
    end
    object pbProgresso: TcxProgressBar
      Left = 1
      Top = 1
      Align = alTop
      TabOrder = 0
      Width = 859
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 34
    Width = 861
    Height = 603
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlSaida: TPanel
      Left = 0
      Top = 0
      Width = 861
      Height = 185
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object gpbSaida: TGroupBox
        Tag = 99
        Left = 1
        Top = 1
        Width = 859
        Height = 183
        Align = alClient
        Caption = 'Sa'#237'da'
        TabOrder = 0
        object Label3: TLabel
          Left = 99
          Top = 14
          Width = 22
          Height = 14
          Caption = 'CST:'
        end
        object Label4: TLabel
          Left = 4
          Top = 39
          Width = 116
          Height = 14
          Caption = 'Classifica'#231#227'o Tribut'#225'ria:'
        end
        object Label6: TLabel
          Left = 91
          Top = 63
          Width = 30
          Height = 14
          Caption = 'CFOP:'
        end
        object Label26: TLabel
          Left = 195
          Top = 38
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label17: TLabel
          Left = 195
          Top = 13
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object edtCstSaida: TEditFocus
          Tag = 99
          Left = 126
          Top = 10
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          ReadOnly = True
          TabOrder = 0
          OnKeyPress = edtCstSaidaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object mskCfopSaida: TMaskEditFocus
          Tag = 99
          Left = 126
          Top = 60
          Width = 696
          Height = 22
          EditMask = 
            '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
            '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
            '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
            '99-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9' +
            '999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-' +
            '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
            '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
            '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
            '99-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9' +
            '999-9999-9999-9999-9999-9999-9999-9999-9999-9999;1;_'
          MaxLength = 624
          ReadOnly = True
          TabOrder = 3
          Text = 
            '    -    -    -    -    -    -    -    -    -    -    -    -    ' +
            '-    -    -    -    -    -    -    -    -    -    -    -    -   ' +
            ' -    -    -    -    -    -    -    -    -    -    -    -    -  ' +
            '  -    -    -    -    -    -    -    -    -    -    -    -    - ' +
            '   -    -    -    -    -    -    -    -    -    -    -    -    -' +
            '    -    -    -    -    -    -    -    -    -    -    -    -    ' +
            '-    -    -    -    -    -    -    -    -    -    -    -    -   ' +
            ' -    -    -    -    -    -    -    -    -    -    -    -    -  ' +
            '  -    -    -    -    -    -    -    -    -    -    -    -    - ' +
            '   -    -    -    -    -    -    -    -    -    '
          OnEnter = mskCfopSaidaEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnConfirmaSaida: TBitBtnLocked
          Left = 3
          Top = 158
          Width = 108
          Height = 22
          Caption = 'Co&nfirma'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 5
          OnClick = btnConfirmaSaidaClick
        end
        object btnCancelaSaida: TBitBtnLocked
          Left = 117
          Top = 158
          Width = 108
          Height = 22
          Caption = 'C&ancelar'
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
          TabOrder = 6
          OnClick = btnCancelaSaidaClick
        end
        object edtCodClaTribSai: TEditFocus
          Tag = 99
          Left = 126
          Top = 35
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnKeyPress = edtCodClaTribSaiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesClaTribSai: TEditFocus
          Tag = 99
          Left = 251
          Top = 35
          Width = 573
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          MaxLength = 3
          ReadOnly = True
          TabOrder = 2
          OnKeyPress = edtCstSaidaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object gpbAliquotasSaida: TGroupBox
          Left = 1
          Top = 82
          Width = 823
          Height = 75
          Caption = 'Aliquotas'
          TabOrder = 4
          object Label8: TLabel
            Left = 28
            Top = 22
            Width = 24
            Height = 14
            Caption = 'CBS:'
            WordWrap = True
          end
          object Label9: TLabel
            Left = 123
            Top = 22
            Width = 43
            Height = 14
            Caption = 'CBS Dif.:'
          end
          object Label11: TLabel
            Left = 238
            Top = 22
            Width = 49
            Height = 14
            Caption = 'CBS Red.:'
          end
          object Label12: TLabel
            Left = 131
            Top = 47
            Width = 35
            Height = 14
            Caption = 'IBS UF:'
          end
          object Label27: TLabel
            Left = 33
            Top = 47
            Width = 19
            Height = 14
            Caption = 'IBS:'
          end
          object Label13: TLabel
            Left = 233
            Top = 47
            Width = 54
            Height = 14
            Caption = 'IBS UF Dif.:'
          end
          object Label14: TLabel
            Left = 354
            Top = 47
            Width = 60
            Height = 14
            Caption = 'IBS UF Red.:'
          end
          object ColorLabel30: TColorLabel
            Left = 737
            Top = 22
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object Label15: TLabel
            Left = 613
            Top = 22
            Width = 94
            Height = 14
            Caption = 'Tributa'#231#227'o Regular:'
          end
          object ColorLabel1: TColorLabel
            Left = 737
            Top = 47
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object Label16: TLabel
            Left = 617
            Top = 47
            Width = 90
            Height = 14
            Caption = 'Cr'#233'dito Presumido:'
          end
          object edtCbsAlqSaida: TEditFocus
            Left = 58
            Top = 19
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS'
            Alignment = taRightJustify
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtCbsDifSaida: TEditFocus
            Left = 168
            Top = 19
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS Diferimento'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtCbsRedSaida: TEditFocus
            Left = 288
            Top = 19
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS Redu'#231#227'o'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfASaida: TEditFocus
            Left = 168
            Top = 44
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS UF'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsTotSaida: TEditFocus
            Left = 58
            Top = 44
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS (Soma IBS)'
            TabStop = False
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 3
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfDSaida: TEditFocus
            Left = 288
            Top = 44
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS UF Diferimento'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfRSaida: TEditFocus
            Left = 414
            Top = 44
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS UF Redu'#231#227'o'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtTriRegSaida: TEditFocus
            Tag = 99
            Left = 708
            Top = 19
            Width = 27
            Height = 22
            Hint = 'Enviar Grupo de Tributa'#231#227'o Regular no XML'
            Alignment = taCenter
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
          object edtCrePreSaida: TEditFocus
            Tag = 99
            Left = 708
            Top = 44
            Width = 27
            Height = 22
            Hint = 'Enviar Grupo de Cr'#233'dito Presumido no XML'
            Alignment = taCenter
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
        end
        object edtDesCstSaida: TEditFocus
          Tag = 99
          Left = 251
          Top = 10
          Width = 573
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          MaxLength = 3
          ReadOnly = True
          TabOrder = 7
          OnKeyPress = edtCstSaidaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object dbgSaida: TDBGridCitel
      Left = 0
      Top = 185
      Width = 861
      Height = 112
      Align = alTop
      DataSource = dtsSaida
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgSaidaKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLATRIB'
          Title.Caption = 'Class. Tribut'#225'ria'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CFOPS'
          Title.Caption = 'CFOP'
          Width = 340
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSALQ'
          Title.Caption = 'Al'#237'q. CBS'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSDIF'
          Title.Caption = 'Al'#237'q. CBS Dif.'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSRED'
          Title.Caption = 'Al'#237'q. CBS Red.'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFA'
          Title.Caption = 'Al'#237'q. IBS UF'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFD'
          Title.Caption = 'Al'#237'q. IBS UF Dif.'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFR'
          Title.Caption = 'Al'#237'q. IBS UF Red.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRIREG'
          Title.Caption = 'Trib. Regular'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CREPRE'
          Title.Caption = 'Cr'#233'd. Presumido'
          Visible = True
        end>
    end
    object pnlEntrada: TPanel
      Left = 0
      Top = 297
      Width = 861
      Height = 194
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object gpbEntrada: TGroupBox
        Tag = 99
        Left = 1
        Top = 1
        Width = 859
        Height = 192
        Align = alClient
        Caption = 'Entrada'
        TabOrder = 0
        TabStop = True
        object Label7: TLabel
          Left = 99
          Top = 22
          Width = 22
          Height = 14
          Caption = 'CST:'
        end
        object Label10: TLabel
          Left = 90
          Top = 72
          Width = 30
          Height = 14
          Caption = 'CFOP:'
        end
        object Label5: TLabel
          Left = 4
          Top = 46
          Width = 116
          Height = 14
          Caption = 'Classifica'#231#227'o Tribut'#225'ria:'
        end
        object Label30: TLabel
          Left = 195
          Top = 46
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label18: TLabel
          Left = 195
          Top = 24
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object edtCstEntrada: TEditFocus
          Tag = 99
          Left = 126
          Top = 18
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          ReadOnly = True
          TabOrder = 0
          OnKeyPress = edtCstEntradaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object mskCfopEntrada: TMaskEditFocus
          Tag = 99
          Left = 126
          Top = 68
          Width = 696
          Height = 22
          EditMask = 
            '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
            '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
            '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
            '99-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9' +
            '999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-' +
            '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
            '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
            '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
            '99-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9' +
            '999-9999-9999-9999-9999-9999-9999-9999-9999-9999;1;_'
          MaxLength = 624
          ReadOnly = True
          TabOrder = 3
          Text = 
            '    -    -    -    -    -    -    -    -    -    -    -    -    ' +
            '-    -    -    -    -    -    -    -    -    -    -    -    -   ' +
            ' -    -    -    -    -    -    -    -    -    -    -    -    -  ' +
            '  -    -    -    -    -    -    -    -    -    -    -    -    - ' +
            '   -    -    -    -    -    -    -    -    -    -    -    -    -' +
            '    -    -    -    -    -    -    -    -    -    -    -    -    ' +
            '-    -    -    -    -    -    -    -    -    -    -    -    -   ' +
            ' -    -    -    -    -    -    -    -    -    -    -    -    -  ' +
            '  -    -    -    -    -    -    -    -    -    -    -    -    - ' +
            '   -    -    -    -    -    -    -    -    -    '
          OnEnter = mskCfopSaidaEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnConfirmaEntrada: TBitBtnLocked
          Left = 3
          Top = 167
          Width = 108
          Height = 22
          Caption = 'Confirma'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 5
          OnClick = btnConfirmaEntradaClick
        end
        object btnCancelaEntrada: TBitBtnLocked
          Left = 117
          Top = 167
          Width = 108
          Height = 22
          Caption = 'Cancelar'
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
          TabOrder = 6
          OnClick = btnCancelaEntradaClick
        end
        object edtCodClaTribEnt: TEditFocus
          Tag = 99
          Left = 126
          Top = 43
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnKeyPress = edtCodClaTribEntKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesClaTribEnt: TEditFocus
          Tag = 99
          Left = 251
          Top = 43
          Width = 573
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          MaxLength = 3
          ReadOnly = True
          TabOrder = 2
          OnKeyPress = edtCstSaidaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object gpbAliquotasEntrada: TGroupBox
          Left = 1
          Top = 90
          Width = 823
          Height = 73
          Caption = 'Al'#237'quotas'
          TabOrder = 4
          object Label31: TLabel
            Left = 28
            Top = 23
            Width = 24
            Height = 14
            Caption = 'CBS:'
            WordWrap = True
          end
          object Label32: TLabel
            Left = 33
            Top = 48
            Width = 19
            Height = 14
            Caption = 'IBS:'
          end
          object Label33: TLabel
            Left = 123
            Top = 23
            Width = 43
            Height = 14
            Caption = 'CBS Dif.:'
          end
          object Label34: TLabel
            Left = 131
            Top = 48
            Width = 35
            Height = 14
            Caption = 'IBS UF:'
          end
          object Label35: TLabel
            Left = 238
            Top = 23
            Width = 49
            Height = 14
            Caption = 'CBS Red.:'
          end
          object Label36: TLabel
            Left = 233
            Top = 48
            Width = 54
            Height = 14
            Caption = 'IBS UF Dif.:'
          end
          object Label37: TLabel
            Left = 354
            Top = 48
            Width = 60
            Height = 14
            Caption = 'IBS UF Red.:'
          end
          object Label39: TLabel
            Left = 613
            Top = 23
            Width = 94
            Height = 14
            Caption = 'Tributa'#231#227'o Regular:'
          end
          object Label40: TLabel
            Left = 617
            Top = 48
            Width = 90
            Height = 14
            Caption = 'Cr'#233'dito Presumido:'
          end
          object ColorLabel4: TColorLabel
            Left = 737
            Top = 48
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object ColorLabel5: TColorLabel
            Left = 737
            Top = 23
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object edtCbsAlqEntrada: TEditFocus
            Left = 58
            Top = 20
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtCbsDifEntrada: TEditFocus
            Left = 167
            Top = 20
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS Diferimento'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtCbsRedEntrada: TEditFocus
            Left = 288
            Top = 20
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. CBS Redu'#231#227'o'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfAEntrada: TEditFocus
            Left = 167
            Top = 45
            Width = 60
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfDEntrada: TEditFocus
            Left = 288
            Top = 45
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS UF Diferimento'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtIbsUfREntrada: TEditFocus
            Left = 415
            Top = 43
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS UF Redu'#231#227'o'
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtTriRegEntrada: TEditFocus
            Tag = 99
            Left = 708
            Top = 20
            Width = 27
            Height = 22
            Hint = 'Enviar Grupo de Tributa'#231#227'o Regular no XML'
            Alignment = taCenter
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
          object edtCrePreEntrada: TEditFocus
            Tag = 99
            Left = 708
            Top = 45
            Width = 27
            Height = 22
            Hint = 'Enviar Grupo de Cr'#233'dito Presumido no XML'
            Alignment = taCenter
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
          object edtIbsTotEntrada: TEditFocus
            Left = 58
            Top = 45
            Width = 60
            Height = 22
            Hint = 'Al'#237'q. IBS (Soma IBS)'
            TabStop = False
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 3
            Text = '0,00 %'
            OnExit = edtCbsAlqSaidaExit
            OnKeyPress = edtCbsAlqSaidaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
        end
        object edtDesCstEntrada: TEditFocus
          Tag = 99
          Left = 251
          Top = 21
          Width = 573
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          MaxLength = 3
          ReadOnly = True
          TabOrder = 7
          OnKeyPress = edtCstSaidaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object dbgEntrada: TDBGridCitel
      Left = 0
      Top = 491
      Width = 861
      Height = 112
      Align = alClient
      DataSource = dtsEntrada
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgEntradaKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLATRIB'
          Title.Caption = 'Class. Tribut'#225'ria'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CFOPS'
          Title.Caption = 'CFOP'
          Width = 340
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSALQ'
          Title.Caption = 'Al'#237'q. CBS'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSDIF'
          Title.Caption = 'Al'#237'q. CBS Dif.'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CBSRED'
          Title.Caption = 'Al'#237'q. CBS Red.'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFA'
          Title.Caption = 'Al'#237'q. IBS UF'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFD'
          Title.Caption = 'Al'#237'q. IBS UF Dif.'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBSUFR'
          Title.Caption = 'Al'#237'q. IBS UF Red.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRIREG'
          Title.Caption = 'Trib. Regular'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CREPRE'
          Title.Caption = 'Cr'#233'd. Presumido'
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 65520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 728
    Top = 0
  end
  object dtsSaida: TDataSource
    DataSet = cdsSaida
    Left = 696
    Top = 104
  end
  object dtsEntrada: TDataSource
    DataSet = cdsEntrada
    Left = 640
    Top = 120
  end
  object cdsSaida: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 696
    Top = 59
    object cdsSaidaCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsSaidaCLATRIB: TStringField
      FieldName = 'CLATRIB'
      Size = 6
    end
    object cdsSaidaCFOPS: TStringField
      DisplayWidth = 3000
      FieldName = 'CFOPS'
      Size = 3000
    end
    object cdsSaidaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsSaidaREMOVER: TStringField
      FieldName = 'REMOVER'
    end
    object cdsSaidaCBSALQ: TFloatField
      FieldName = 'CBSALQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaCBSDIF: TFloatField
      FieldName = 'CBSDIF'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaCBSRED: TFloatField
      FieldName = 'CBSRED'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaIBSUFA: TFloatField
      FieldName = 'IBSUFA'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaIBSUFD: TFloatField
      FieldName = 'IBSUFD'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaIBSUFR: TFloatField
      FieldName = 'IBSUFR'
      DisplayFormat = '#,##0.00'
    end
    object cdsSaidaTRIREG: TStringField
      FieldName = 'TRIREG'
      Size = 3
    end
    object cdsSaidaCREPRE: TStringField
      FieldName = 'CREPRE'
      Size = 3
    end
    object cdsSaidaIBSTOT: TFloatField
      FieldName = 'IBSTOT'
    end
  end
  object cdsEntrada: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 640
    Top = 64
    object cdsEntradaCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsEntradaCLATRIB: TStringField
      FieldName = 'CLATRIB'
      Size = 6
    end
    object cdsEntradaCFOPS: TStringField
      DisplayWidth = 3000
      FieldName = 'CFOPS'
      Size = 3000
    end
    object cdsEntradaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEntradaREMOVER: TStringField
      FieldName = 'REMOVER'
    end
    object cdsEntradaCBSALQ: TFloatField
      FieldName = 'CBSALQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaCBSDIF: TFloatField
      FieldName = 'CBSDIF'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaCBSRED: TFloatField
      FieldName = 'CBSRED'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaIBSUFA: TFloatField
      FieldName = 'IBSUFA'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaIBSUFD: TFloatField
      FieldName = 'IBSUFD'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaIBSUFR: TFloatField
      FieldName = 'IBSUFR'
      DisplayFormat = '#,##0.00'
    end
    object cdsEntradaTRIREG: TStringField
      FieldName = 'TRIREG'
      Size = 3
    end
    object cdsEntradaCREPRE: TStringField
      FieldName = 'CREPRE'
      Size = 3
    end
    object cdsEntradaIBSTOT: TFloatField
      FieldName = 'IBSTOT'
    end
  end
end
