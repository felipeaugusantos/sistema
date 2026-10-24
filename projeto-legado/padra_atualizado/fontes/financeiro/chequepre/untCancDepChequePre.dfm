inherited frmCancDepChequePre: TfrmCancDepChequePre
  Left = 276
  Top = 221
  Width = 702
  Height = 510
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Dep'#243'sito de Cheque'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 702
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 696
    Height = 27
    ExplicitTop = 438
    ExplicitWidth = 696
    ExplicitHeight = 27
    DesignSize = (
      696
      27)
    inherited FlwBotoes: TFlowPanel
      Width = 692
      Height = 23
      ExplicitTop = 2
      ExplicitWidth = 692
      ExplicitHeight = 23
      object btnCancela: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 190
        Height = 22
        Caption = '&Cancela Dep'#243'sito de Cheque Pr'#233
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
        OnClick = btnCancelaClick
      end
      object btnPesquisa: TBitBtnLocked
        Left = 190
        Top = 0
        Width = 190
        Height = 22
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
        TabOrder = 1
        OnClick = btnPesquisaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 616
      Top = 2
      ExplicitLeft = 616
      ExplicitTop = 2
    end
  end
  object pnlCons: TPanel [2]
    Left = 0
    Top = 0
    Width = 696
    Height = 111
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitLeft = -2
    ExplicitTop = 6
    object Label1: TLabel
      Left = 59
      Top = 12
      Width = 40
      Height = 14
      Caption = 'Banco : '
    end
    object Label2: TLabel
      Left = 50
      Top = 36
      Width = 49
      Height = 14
      Caption = 'Ag'#234'ncia : '
    end
    object Label3: TLabel
      Left = 17
      Top = 60
      Width = 82
      Height = 14
      Caption = 'Conta Corrente : '
    end
    object Label4: TLabel
      Left = 13
      Top = 84
      Width = 86
      Height = 14
      Caption = 'N'#250'mero Cheque : '
    end
    object EdtCodBco: TEditFocus
      Tag = 99
      Left = 102
      Top = 8
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = EdtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object EdtNumAge: TEditFocus
      Tag = 99
      Left = 102
      Top = 32
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object EdtConCor: TEditFocus
      Tag = 99
      Left = 102
      Top = 56
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object EdtNumChq: TEditFocus
      Tag = 99
      Left = 102
      Top = 80
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomBco: TEditFocus
      Left = 170
      Top = 8
      Width = 460
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
    object btnCarrCheques: TBitBtnLocked
      Left = 509
      Top = 80
      Width = 121
      Height = 22
      Align = alCustom
      Caption = '&Carregar Cheques'
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
      OnClick = btnCarrChequesClick
    end
  end
  object pnlInf: TPanel [3]
    Left = 0
    Top = 111
    Width = 696
    Height = 327
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label6: TLabel
      Left = 58
      Top = 12
      Width = 41
      Height = 14
      Caption = 'Cliente : '
    end
    object Label7: TLabel
      Left = 50
      Top = 36
      Width = 49
      Height = 14
      Caption = 'Emitente : '
    end
    object Label8: TLabel
      Left = 44
      Top = 60
      Width = 55
      Height = 14
      Caption = 'Endere'#231'o : '
    end
    object Label9: TLabel
      Left = 392
      Top = 12
      Width = 79
      Height = 14
      Caption = '1-CNPJ / 2-CPF :'
    end
    object Label10: TLabel
      Left = 423
      Top = 36
      Width = 47
      Height = 14
      Caption = 'Telefone :'
    end
    object Label11: TLabel
      Left = 21
      Top = 101
      Width = 78
      Height = 14
      Caption = 'Data Cadastro : '
    end
    object Label12: TLabel
      Left = 64
      Top = 125
      Width = 34
      Height = 14
      Caption = 'Valor : '
    end
    object Label13: TLabel
      Left = 48
      Top = 149
      Width = 51
      Height = 14
      Caption = 'Historico : '
    end
    object Label14: TLabel
      Left = 408
      Top = 101
      Width = 62
      Height = 14
      Caption = 'Vencimento :'
    end
    object Label15: TLabel
      Left = 408
      Top = 125
      Width = 63
      Height = 14
      Caption = 'Nro da Nota :'
    end
    object Label16: TLabel
      Left = 26
      Top = 204
      Width = 73
      Height = 14
      Caption = 'Cta. Dep'#243'sito : '
    end
    object Label17: TLabel
      Left = 23
      Top = 228
      Width = 76
      Height = 14
      Caption = 'Data Dep'#243'sito : '
    end
    object Label18: TLabel
      Left = 8
      Top = 252
      Width = 91
      Height = 14
      Caption = 'Data Devolu'#231#227'o 1: '
    end
    object Label19: TLabel
      Left = 224
      Top = 204
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pl. Contas : '
    end
    object Label20: TLabel
      Left = 231
      Top = 228
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador : '
    end
    object Label21: TLabel
      Left = 235
      Top = 252
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo 1: '
    end
    object DBText1: TDBText
      Left = 101
      Top = 12
      Width = 279
      Height = 17
      DataField = 'CHQ_CODCLI'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 101
      Top = 36
      Width = 279
      Height = 17
      DataField = 'CHQ_NOMEMI'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 101
      Top = 60
      Width = 279
      Height = 17
      DataField = 'CHQ_ENDERE'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 476
      Top = 12
      Width = 157
      Height = 17
      DataField = 'CHQ_C_G_C_'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 476
      Top = 36
      Width = 157
      Height = 17
      DataField = 'CHQ_TELEMI'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText6: TDBText
      Left = 101
      Top = 101
      Width = 159
      Height = 17
      DataField = 'CHQ_DTACAD'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText7: TDBText
      Left = 101
      Top = 125
      Width = 87
      Height = 17
      DataField = 'CHQ_VALCHQ'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText8: TDBText
      Left = 101
      Top = 149
      Width = 279
      Height = 17
      DataField = 'CHQ_HIST01'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText9: TDBText
      Left = 101
      Top = 167
      Width = 279
      Height = 17
      DataField = 'CHQ_HIST02'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText10: TDBText
      Left = 476
      Top = 101
      Width = 149
      Height = 17
      DataField = 'CHQ_DTAVEN'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText11: TDBText
      Left = 476
      Top = 125
      Width = 149
      Height = 17
      DataField = 'CHQ_NUMNOT'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText12: TDBText
      Left = 101
      Top = 204
      Width = 97
      Height = 17
      DataField = 'CHQ_CTADEP'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText13: TDBText
      Left = 101
      Top = 228
      Width = 97
      Height = 17
      DataField = 'CHQ_DTADEP'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText14: TDBText
      Left = 101
      Top = 252
      Width = 97
      Height = 17
      DataField = 'CHQ_DTADEV'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText15: TDBText
      Left = 286
      Top = 204
      Width = 307
      Height = 17
      DataField = 'CHQ_CODCTA'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText16: TDBText
      Left = 286
      Top = 228
      Width = 307
      Height = 17
      DataField = 'CHQ_CODPOR'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText17: TDBText
      Left = 285
      Top = 252
      Width = 307
      Height = 17
      DataField = 'CHQ_MOTDEV'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 600
      Top = 252
      Width = 47
      Height = 14
      Caption = 'Definitiva:'
    end
    object Label22: TLabel
      Left = 11
      Top = 276
      Width = 88
      Height = 14
      Caption = 'Data Redep'#243'sito : '
    end
    object DBText18: TDBText
      Left = 101
      Top = 276
      Width = 97
      Height = 17
      DataField = 'CHQ_DTADP2'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 8
      Top = 300
      Width = 91
      Height = 14
      Caption = 'Data Devolu'#231#227'o 2: '
    end
    object DBText19: TDBText
      Left = 101
      Top = 300
      Width = 97
      Height = 17
      DataField = 'CHQ_DTADV2'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 232
      Top = 300
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo 2 : '
    end
    object DBText20: TDBText
      Left = 284
      Top = 300
      Width = 307
      Height = 17
      DataField = 'CHQ_MOTDV2'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText21: TDBText
      Left = 651
      Top = 252
      Width = 32
      Height = 17
      DataField = 'DEVDEF'
      DataSource = dsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 465
    Width = 696
    ExplicitTop = 465
    ExplicitWidth = 696
    inherited pnlNomeForm: TPanel
      Left = 525
      ExplicitLeft = 525
    end
    inherited pnlInfo: TPanel
      Width = 525
      ExplicitWidth = 525
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 430
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 32
  end
  object dsConsulta: TDataSource
    Left = 461
    Top = 32
  end
end
