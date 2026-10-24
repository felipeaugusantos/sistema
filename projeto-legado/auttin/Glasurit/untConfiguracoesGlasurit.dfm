inherited frmConfiguracoesGlasurit: TfrmConfiguracoesGlasurit
  Left = 361
  Top = 422
  Width = 574
  Height = 563
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Glasurit'
  Position = poMainFormCenter
  ExplicitWidth = 574
  ExplicitHeight = 563
  PixelsPerInch = 96
  TextHeight = 14
  object pnlCentral: TPanel [0]
    Left = 0
    Top = 23
    Width = 568
    Height = 467
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 490
    Width = 568
    ExplicitTop = 490
    ExplicitWidth = 568
    DesignSize = (
      568
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 564
    end
  end
  inherited pnlStatus: TPanel
    Top = 518
    Width = 568
    ExplicitTop = 518
    ExplicitWidth = 568
    inherited pnlNomeForm: TPanel
      Left = 397
      ExplicitLeft = 397
    end
    inherited pnlInfo: TPanel
      Width = 397
      ExplicitWidth = 397
    end
  end
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 490
    Width = 568
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    DesignSize = (
      568
      28)
    object btnSairConf: TBitBtnLocked
      Left = 486
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
  inherited pgcDados: TPageControl
    Top = 23
    Width = 568
    Height = 467
    OnChange = pgcDadosChange
    ExplicitTop = 23
    ExplicitWidth = 568
    ExplicitHeight = 467
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 560
      ExplicitHeight = 435
      object ColorLabel4: TColorLabel
        Left = 289
        Top = 358
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
      object Label1: TLabel
        Left = 49
        Top = 165
        Width = 130
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator para pre'#231'o de Custo:'
      end
      object Label13: TLabel
        Left = 115
        Top = 358
        Width = 114
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valores da Formula'#231#227'o:'
      end
      object Label16: TLabel
        Left = 208
        Top = 186
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Embalagem (LT):'
      end
      object Label2: TLabel
        Left = 5
        Top = 142
        Width = 128
        Height = 14
        Alignment = taRightJustify
        Caption = 'Trava para valor de venda'
      end
      object Label20: TLabel
        Left = 137
        Top = 143
        Width = 47
        Height = 14
        Caption = 'GLA_PRE'
      end
      object Label3: TLabel
        Left = 264
        Top = 143
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator'
      end
      object Label4: TLabel
        Left = 83
        Top = 309
        Width = 145
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
      end
      object Label5: TLabel
        Left = 79
        Top = 332
        Width = 148
        Height = 14
        Alignment = taRightJustify
        Caption = 'Path para arquivo de f'#243'rmulas:'
      end
      object Label6: TLabel
        Left = 212
        Top = 208
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Embalagem(Gl):'
      end
      object Label8: TLabel
        Left = 84
        Top = 120
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto para venda:'
      end
      object lblGlaIco: TLabel
        Left = 155
        Top = 230
        Width = 132
        Height = 14
        Alignment = taRightJustify
        Caption = 'Item embalagem para Copo:'
      end
      object lblGlaIsp: TLabel
        Left = 151
        Top = 252
        Width = 136
        Height = 14
        Alignment = taRightJustify
        Caption = 'Item embalagem para Spray:'
      end
      object lblGlaBal: TLabel
        Left = 153
        Top = 274
        Width = 134
        Height = 14
        Alignment = taRightJustify
        Caption = 'Item embalagem para Balde:'
      end
      object Label7: TLabel
        Left = 96
        Top = 379
        Width = 129
        Height = 14
        Alignment = taRightJustify
        Caption = 'Despesas Operacionais %'
      end
      object Label38: TLabel
        Left = 2
        Top = 403
        Width = 222
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda %'
      end
      object chkUsaFor: TCheckBox
        Tag = 99
        Left = 192
        Top = 30
        Width = 175
        Height = 19
        Caption = 'Utilizar Formula'#231#227'o'
        TabOrder = 1
      end
      object chkUsaGla: TCheckBox
        Tag = 99
        Left = 16
        Top = 30
        Width = 175
        Height = 18
        Caption = 'Utilizar essa tinta de m'#225'quina'
        TabOrder = 0
      end
      object edtAcuAbs: TEditFocus
        Tag = 99
        Left = 231
        Top = 350
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesGlaIco: TEditFocus
        Left = 347
        Top = 223
        Width = 209
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 17
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesGlaIem: TEditFocus
        Left = 347
        Top = 179
        Width = 209
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesGlaIgl: TEditFocus
        Left = 347
        Top = 201
        Width = 209
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 19
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesGlaIsp: TEditFocus
        Left = 347
        Top = 245
        Width = 209
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 20
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesProGla: TEditFocus
        Left = 243
        Top = 113
        Width = 313
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 21
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFatGla: TEditFocus
        Tag = 99
        Left = 290
        Top = 136
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtFveGla: TEditFocus
        Tag = 99
        Left = 187
        Top = 157
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtGlaIco: TEditFocus
        Tag = 99
        Left = 289
        Top = 223
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 9
        OnKeyPress = edtGlaIemKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtGlaIem: TEditFocus
        Tag = 99
        Left = 289
        Top = 179
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 7
        OnKeyPress = edtGlaIemKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtGlaIgl: TEditFocus
        Tag = 99
        Left = 289
        Top = 201
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 8
        OnKeyPress = edtGlaIglKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtGlaIsp: TEditFocus
        Tag = 99
        Left = 289
        Top = 245
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 10
        OnKeyPress = edtGlaIglKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNfmGla: TEditFocus
        Tag = 99
        Left = 231
        Top = 302
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtProGla: TEditFocus
        Tag = 99
        Left = 187
        Top = 113
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 3
        OnKeyPress = edtProGlaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtTraGla: TEditFocus
        Tag = 99
        Left = 187
        Top = 135
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
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgCalculoFormulacao: TRadioGroup
        Left = 45
        Top = 51
        Width = 511
        Height = 55
        Caption = 'C'#225'lculo da formula'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Direta, obtida pela formula'#231#227'o gerada pelo autcom'
          
            'Indireta, obtida pela formula'#231#227'o gerada pelo sistema Glasurit no' +
            ' momento da venda')
        TabOrder = 2
      end
      object edtGlaBal: TEditFocus
        Tag = 99
        Left = 289
        Top = 268
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 11
        OnKeyPress = edtGlaIglKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGlaBal: TEditFocus
        Left = 347
        Top = 268
        Width = 209
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 22
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesOpe: TEditFocus
        Tag = 99
        Left = 231
        Top = 373
        Width = 56
        Height = 22
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
      object edtApreve: TEditFocus
        Tag = 99
        Left = 231
        Top = 395
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPatGla: TFilenameEditFocus
        Left = 231
        Top = 325
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000004020FF406040FF406040FF4060
              40FF004020FF0000000000000000000000000000000000000000806040FFC080
              60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
              80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
              FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
              60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
              FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
              60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
              FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
              60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
              60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
              80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
              A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
              FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
              80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
              80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
              80FFC0A080FF808060FF000000000000000000000000}
            Kind = bkGlyph
          end>
        StyleFocused.Color = clInfoBk
        TabOrder = 13
        Width = 186
      end
      inline fraPatGlaDir: TfraDirectoryEditFocus
        Left = 419
        Top = 325
        TabOrder = 14
        Width = 141
        Height = 24
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        inherited edtDirectory: TEditFocus
        end
      end
    end
    object tbsConexaoSQLServer: TTabSheet
      Caption = '&2 - Integra'#231#227'o sistema Glasurit'
      ImageIndex = 1
      object Label9: TLabel
        Left = 26
        Top = 12
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Usu'#225'rio:'
      end
      object Label11: TLabel
        Left = 32
        Top = 36
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Senha:'
      end
      object Label12: TLabel
        Left = 280
        Top = 36
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'IP / Host:'
      end
      object Label14: TLabel
        Left = 288
        Top = 12
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object edtSenha: TEditFocus
        Left = 72
        Top = 28
        Width = 149
        Height = 22
        Alignment = taLeftJustify
        PasswordChar = '*'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUsuario: TEditFocus
        Left = 72
        Top = 4
        Width = 149
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtHost: TEditFocus
        Left = 328
        Top = 28
        Width = 149
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtBanco: TEditFocus
        Left = 328
        Top = 3
        Width = 149
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 2
        NormalColor = clWindow
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
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 568
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Glasurit'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 64
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 32
  end
end
