inherited frmCadRapidoFreteTranspRegiao: TfrmCadRapidoFreteTranspRegiao
  Width = 1024
  Height = 605
  Caption = 'Cadastro R'#225'pido de Frete por Transportadora / Regi'#227'o'
  ExplicitWidth = 1024
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 534
    Width = 1018
    TabOrder = 3
    ExplicitTop = 534
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        Width = 120
        ModalResult = 0
        ExplicitWidth = 120
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 894
      Top = 2
      Width = 120
      Glyph.Data = {00000000}
      ModalResult = 0
      NumGlyphs = 2
      ExplicitLeft = 894
      ExplicitTop = 2
      ExplicitWidth = 120
    end
  end
  inherited pnlStatus: TPanel
    Top = 560
    Width = 1018
    TabOrder = 4
    ExplicitTop = 560
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 349
    Width = 1018
    Height = 185
    Align = alBottom
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object gpbCalculoFrete: TGroupBox
      Left = 1
      Top = 1
      Width = 1016
      Height = 148
      Align = alTop
      Caption = 'C'#225'lculo do Frete'
      TabOrder = 0
      object Label2: TLabel
        Left = 64
        Top = 94
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor m'#237'nimo do frete:'
      end
      object Label3: TLabel
        Left = 17
        Top = 117
        Width = 151
        Height = 14
        Alignment = taRightJustify
        Caption = 'Percentual sobre valor da nota:'
      end
      object Label4: TLabel
        Left = 357
        Top = 94
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor por Kilo:'
      end
      object Label5: TLabel
        Left = 270
        Top = 117
        Width = 154
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do ped'#225'gio a cada 100Kg:'
      end
      object Label6: TLabel
        Left = 527
        Top = 117
        Width = 105
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor m'#237'nimo do GRIS:'
      end
      object Label8: TLabel
        Left = 536
        Top = 94
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Percentual do GRIS:'
      end
      object Label9: TLabel
        Left = 738
        Top = 117
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da TAS:'
      end
      object Label31: TLabel
        Left = 90
        Top = 25
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object Label7: TLabel
        Left = 132
        Top = 48
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Regi'#227'o:'
      end
      object Label1: TLabel
        Left = 35
        Top = 71
        Width = 133
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da nota para isen'#231#227'o:'
      end
      object dbeMinFre: TDBEditFocus
        Tag = 99
        Left = 172
        Top = 90
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MINFRE'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbePerTot: TDBEditFocus
        Tag = 99
        Left = 172
        Top = 113
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PERTOT'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbeValKil: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 90
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VALKIL'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbePd100K: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 113
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PD100K'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbeMinGri: TDBEditFocus
        Tag = 99
        Left = 636
        Top = 113
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MINGRI'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbePerGri: TDBEditFocus
        Tag = 99
        Left = 636
        Top = 90
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PERGRI'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbeValTas: TDBEditFocus
        Tag = 99
        Left = 808
        Top = 113
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VALTAS'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object dbeCodTra: TDBEditFocus
        Tag = 99
        Left = 172
        Top = 21
        Width = 50
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CODTRA'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 223
        Top = 21
        Width = 324
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
      object dbeCodReg: TDBEditFocus
        Tag = 99
        Left = 172
        Top = 44
        Width = 50
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CODREG'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnKeyPress = dbeCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtRegiao: TEditFocus
        Left = 223
        Top = 44
        Width = 324
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
      object dbeValIse: TDBEditFocus
        Tag = 99
        Left = 172
        Top = 67
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VALISE'
        DataSource = dscTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
    end
    object btnIncluir: TBitBtnLocked
      Left = 537
      Top = 154
      Width = 72
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
      TabOrder = 1
      OnClick = btnIncluirClick
    end
    object btnGravar: TBitBtnLocked
      Left = 609
      Top = 154
      Width = 72
      Height = 20
      Caption = '&Gravar'
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
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnAlterar: TBitBtnLocked
      Left = 681
      Top = 154
      Width = 72
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
      TabOrder = 3
      OnClick = btnAlterarClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 753
      Top = 154
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
    object btnCancela: TBitBtnLocked
      Left = 825
      Top = 154
      Width = 72
      Height = 20
      Caption = '&Cancelar'
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
      TabOrder = 5
      OnClick = btnCancelaClick
    end
  end
  object cxFrete: TcxGrid [4]
    Left = 0
    Top = 41
    Width = 1018
    Height = 308
    Align = alClient
    TabOrder = 1
    object cxTblFrete: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dscTraReg
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object cxTblFreteNOMTRA: TcxGridDBColumn
        DataBinding.FieldName = 'NOMTRA'
        Options.Editing = False
        Width = 100
      end
      object cxTblFreteNOMREG: TcxGridDBColumn
        DataBinding.FieldName = 'NOMREG'
        Options.Editing = False
        Width = 100
      end
      object cxTblFreteVALISE: TcxGridDBColumn
        DataBinding.FieldName = 'VALISE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
      object cxTblFreteMINFRE: TcxGridDBColumn
        DataBinding.FieldName = 'MINFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
      object cxTblFretePERTOT: TcxGridDBColumn
        DataBinding.FieldName = 'PERTOT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 100
      end
      object cxTblFreteVALKIL: TcxGridDBColumn
        DataBinding.FieldName = 'VALKIL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
      object cxTblFretePD100K: TcxGridDBColumn
        DataBinding.FieldName = 'PD100K'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 140
      end
      object cxTblFretePERGRI: TcxGridDBColumn
        DataBinding.FieldName = 'PERGRI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxTblFreteMINGRI: TcxGridDBColumn
        DataBinding.FieldName = 'MINGRI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
      object cxTblFreteVALTAS: TcxGridDBColumn
        DataBinding.FieldName = 'VALTAS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
    end
    object cxFreteLvl: TcxGridLevel
      GridView = cxTblFrete
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 1018
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblTraCid: TLabel
      Left = 12
      Top = 12
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora / Regi'#227'o:'
    end
    object edtNomTraReg: TEditFocus
      Left = 189
      Top = 8
      Width = 404
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
    object edtCodTraReg: TEditFocus
      Tag = 99
      Left = 137
      Top = 8
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodTraRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 852
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 852
    Top = 56
  end
  object cdsTraReg: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsTraRegBeforePost
    AfterScroll = cdsTraRegAfterScroll
    OnNewRecord = cdsTraRegNewRecord
    Left = 852
    Top = 108
    object cdsTraRegCODTRA: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'CODTRA'
      Size = 5
    end
    object cdsTraRegNOMTRA: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMTRA'
      Size = 100
    end
    object cdsTraRegCODREG: TStringField
      DisplayLabel = 'Regi'#227'o'
      FieldName = 'CODREG'
      Size = 5
    end
    object cdsTraRegNOMREG: TStringField
      DisplayLabel = 'Regi'#227'o'
      FieldName = 'NOMREG'
      Size = 100
    end
    object cdsTraRegVALISE: TFloatField
      DisplayLabel = 'Vlr. Nota Isen'#231#227'o'
      FieldName = 'VALISE'
      currency = True
    end
    object cdsTraRegMINFRE: TFloatField
      DisplayLabel = 'Vlr. Min. Frete'
      FieldName = 'MINFRE'
      currency = True
    end
    object cdsTraRegPERTOT: TFloatField
      DisplayLabel = '% Sobre Vlr. Nota'
      FieldName = 'PERTOT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsTraRegVALKIL: TFloatField
      DisplayLabel = 'Vlr. por KG'
      FieldName = 'VALKIL'
      currency = True
    end
    object cdsTraRegPD100K: TFloatField
      DisplayLabel = 'Vlr. Ped'#225'gio (cada 100KG)'
      FieldName = 'PD100K'
      currency = True
    end
    object cdsTraRegPERGRI: TFloatField
      DisplayLabel = '% do GRIS'
      FieldName = 'PERGRI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsTraRegMINGRI: TFloatField
      DisplayLabel = 'Vlr. Min. GRIS'
      FieldName = 'MINGRI'
      currency = True
    end
    object cdsTraRegVALTAS: TFloatField
      DisplayLabel = 'Vlr. da TAS'
      FieldName = 'VALTAS'
      currency = True
    end
  end
  object dscTraReg: TDataSource
    DataSet = cdsTraReg
    Left = 928
    Top = 108
  end
end
