inherited frmConfiguracoesFutura: TfrmConfiguracoesFutura
  Left = 312
  Top = 211
  Width = 539
  Height = 387
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Futura'
  Position = poMainFormCenter
  ExplicitWidth = 539
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 533
    ExplicitTop = 319
    ExplicitWidth = 533
    DesignSize = (
      533
      0)
  end
  inherited pnlStatus: TPanel
    Top = 347
    Width = 533
    ExplicitTop = 347
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 362
      ExplicitLeft = 362
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 533
    Height = 296
    OnChange = pgcDadosChange
    ExplicitTop = 23
    ExplicitWidth = 533
    ExplicitHeight = 296
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 264
      object Label2: TLabel
        Left = 9
        Top = 59
        Width = 128
        Height = 14
        Alignment = taRightJustify
        Caption = 'Trava para valor de venda'
      end
      object Label3: TLabel
        Left = 264
        Top = 59
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator'
      end
      object Label4: TLabel
        Left = 35
        Top = 82
        Width = 142
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
      end
      object Label5: TLabel
        Left = 31
        Top = 106
        Width = 145
        Height = 14
        Alignment = taRightJustify
        Caption = 'Path para arquivo de f'#243'rmulas'
      end
      object Label20: TLabel
        Left = 141
        Top = 59
        Width = 44
        Height = 14
        Caption = 'FUT_PRE'
      end
      object Label1: TLabel
        Left = 29
        Top = 131
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade(Quarto):'
      end
      object Label6: TLabel
        Left = 34
        Top = 155
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade(Gal'#227'o):'
      end
      object Label7: TLabel
        Left = 41
        Top = 180
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade(Lata):'
      end
      object Label8: TLabel
        Left = 85
        Top = 207
        Width = 129
        Height = 14
        Alignment = taRightJustify
        Caption = 'Despesas Operacionais %'
      end
      object Label38: TLabel
        Left = 7
        Top = 231
        Width = 209
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
      end
      object chkUsaFut: TCheckBox
        Tag = 99
        Left = 16
        Top = 30
        Width = 169
        Height = 18
        Caption = 'Utilizar essa tinta de m'#225'quina'
        TabOrder = 0
      end
      object edtTraFut: TEditFocus
        Tag = 99
        Left = 190
        Top = 55
        Width = 56
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
      object edtFatFut: TEditFocus
        Tag = 99
        Left = 297
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
      object edtNfmFut: TEditFocus
        Tag = 99
        Left = 190
        Top = 78
        Width = 56
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
      object edtPatFut: TFilenameEditFocus
        Tag = 99
        Left = 190
        Top = 103
        Width = 322
        Height = 22
        Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
        CharCase = ecUpperCase
        TabOrder = 5
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
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
      object edtUniQuaDescri: TEditFocus
        Left = 184
        Top = 127
        Width = 273
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniQuaUni: TEditFocus
        Left = 455
        Top = 127
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniGalDescri: TEditFocus
        Left = 184
        Top = 151
        Width = 273
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniGalUni: TEditFocus
        Left = 455
        Top = 151
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniLatDescri: TEditFocus
        Left = 184
        Top = 176
        Width = 273
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniLatUni: TEditFocus
        Left = 455
        Top = 176
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniQua: TEditFocus
        Tag = 99
        Left = 120
        Top = 127
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 6
        OnExit = edtUniLatExit
        OnKeyPress = edtUniLatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniGal: TEditFocus
        Tag = 99
        Left = 120
        Top = 151
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 9
        OnExit = edtUniLatExit
        OnKeyPress = edtUniLatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniLat: TEditFocus
        Tag = 99
        Left = 120
        Top = 176
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 12
        OnExit = edtUniLatExit
        OnKeyPress = edtUniLatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesOpe: TEditFocus
        Tag = 99
        Left = 222
        Top = 199
        Width = 56
        Height = 22
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
        Left = 222
        Top = 223
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
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
  end
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 319
    Width = 533
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    DesignSize = (
      533
      28)
    object btnSairConf: TBitBtnLocked
      Left = 451
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
      Left = 83
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
    Width = 533
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Futura'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 40
  end
end
