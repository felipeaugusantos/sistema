inherited frmConfiguracoesWandaPro: TfrmConfiguracoesWandaPro
  Left = 21
  Top = 63
  Width = 705
  Height = 621
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Color Pro'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 705
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 553
    Width = 699
    ExplicitTop = 553
    ExplicitWidth = 699
    DesignSize = (
      699
      28)
    inherited btnSair: TBitBtnLocked
      Left = 616
      TabOrder = 1
      ExplicitLeft = 616
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
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 699
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Color Pro'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object pgcGeral: TPageControl [3]
    Left = 0
    Top = 23
    Width = 699
    Height = 530
    ActivePage = tbsEmbalagens
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgcGeralChange
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 691
        Height = 498
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        object Label17: TLabel
          Left = 204
          Top = 384
          Width = 106
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo Txt:'
        end
        object Label9: TLabel
          Left = 380
          Top = 73
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object Label20: TLabel
          Left = 257
          Top = 73
          Width = 53
          Height = 14
          Caption = 'WAN_CON'
        end
        object Label11: TLabel
          Left = 75
          Top = 73
          Width = 179
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava p/ valor de venda concentrado'
        end
        object Label2: TLabel
          Left = 380
          Top = 95
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object Label3: TLabel
          Left = 262
          Top = 95
          Width = 46
          Height = 14
          Caption = 'WAN_DIL'
        end
        object Label4: TLabel
          Left = 110
          Top = 95
          Width = 148
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava p/ valor de venda diluido'
        end
        object Label5: TLabel
          Left = 74
          Top = 117
          Width = 235
          Height = 14
          Caption = 'Linhas para utiliza'#231#227'o (duplo clique para alterar):'
        end
        object Label8: TLabel
          Left = 78
          Top = 139
          Width = 230
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do Wandabase HS:'
        end
        object Label13: TLabel
          Left = 381
          Top = 139
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label14: TLabel
          Left = 117
          Top = 51
          Width = 190
          Height = 14
          Caption = 'Fator para gera'#231#227'o de pre'#231'o de venda:'
        end
        object Label12: TLabel
          Left = 70
          Top = 161
          Width = 237
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do Autobase 100:50:'
        end
        object Label15: TLabel
          Left = 381
          Top = 161
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label18: TLabel
          Left = 70
          Top = 183
          Width = 237
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do Autobase 100:80:'
        end
        object Label19: TLabel
          Left = 381
          Top = 183
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label21: TLabel
          Left = 85
          Top = 205
          Width = 223
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do Wanda PU MS:'
        end
        object Label22: TLabel
          Left = 381
          Top = 205
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label23: TLabel
          Left = 85
          Top = 227
          Width = 222
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do Wanda PU HS:'
        end
        object Label24: TLabel
          Left = 381
          Top = 227
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label25: TLabel
          Left = 164
          Top = 410
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
        end
        object Label26: TLabel
          Left = 196
          Top = 433
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object ColorLabel4: TColorLabel
          Left = 370
          Top = 435
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
        object Label29: TLabel
          Left = 123
          Top = 250
          Width = 186
          Height = 14
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do BT120:'
        end
        object Label30: TLabel
          Left = 381
          Top = 250
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label31: TLabel
          Left = 1
          Top = 271
          Width = 305
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do BT90:'
        end
        object Label32: TLabel
          Left = 381
          Top = 273
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label33: TLabel
          Left = 1
          Top = 293
          Width = 305
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do BT80:'
        end
        object Label34: TLabel
          Left = 381
          Top = 295
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label35: TLabel
          Left = 1
          Top = 316
          Width = 305
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Linha / Base para pre'#231'o dilu'#237'do BT100:'
        end
        object Label36: TLabel
          Left = 381
          Top = 318
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label37: TLabel
          Left = 177
          Top = 455
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label38: TLabel
          Left = 97
          Top = 476
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object Label46: TLabel
          Left = 1
          Top = 338
          Width = 305
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Linha / Base para pre'#231'o Dilu'#237'do Autobase Plus Baseline 100:80'
        end
        object Label47: TLabel
          Left = 381
          Top = 340
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label52: TLabel
          Left = 381
          Top = 363
          Width = 28
          Height = 14
          Caption = 'Base:'
        end
        object Label48: TLabel
          Left = 1
          Top = 361
          Width = 305
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Linha / Base para pre'#231'o Dilu'#237'do Autobase Plus Baseline 100:50'
        end
        object chkUsaWan: TCheckBox
          Tag = 99
          Left = 11
          Top = 12
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraWan: TEditFocus
          Tag = 99
          Left = 312
          Top = 65
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFatWan: TEditFocus
          Tag = 99
          Left = 410
          Top = 65
          Width = 58
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTrdWan: TEditFocus
          Tag = 99
          Left = 312
          Top = 87
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFadWan: TEditFocus
          Tag = 99
          Left = 410
          Top = 87
          Width = 58
          Height = 22
          Alignment = taLeftJustify
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
        object mskLinWan: TMaskEditFocus
          Tag = 99
          Left = 312
          Top = 111
          Width = 360
          Height = 22
          EditMask = '999_999_999_999_999_999_999_999_999_999_999_999_999_999;0;_'
          MaxLength = 55
          ReadOnly = True
          TabOrder = 7
          Text = ''
          OnDblClick = mskLinWanDblClick
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtLd1Wan: TEditFocus
          Tag = 99
          Left = 312
          Top = 131
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 8
          OnKeyPress = edtLd1WanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1Wan: TEditFocus
          Tag = 99
          Left = 414
          Top = 131
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFveWan: TEditFocus
          Tag = 99
          Left = 312
          Top = 43
          Width = 57
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
          EditFormat = '#,##0.00'
        end
        object edtLd1Abs_100_50: TEditFocus
          Tag = 99
          Left = 312
          Top = 153
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 10
          OnKeyPress = edtLd1Abs_100_50KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1Abs_100_50: TEditFocus
          Tag = 99
          Left = 414
          Top = 153
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1Abs_100_80: TEditFocus
          Tag = 99
          Left = 313
          Top = 175
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 12
          OnKeyPress = edtLd1Abs_100_80KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1Abs_100_80: TEditFocus
          Tag = 99
          Left = 414
          Top = 175
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1PU_MS: TEditFocus
          Tag = 99
          Left = 312
          Top = 197
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 14
          OnKeyPress = edtLd1PU_MSKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1PU_MS: TEditFocus
          Tag = 99
          Left = 414
          Top = 197
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1PU_HS: TEditFocus
          Tag = 99
          Left = 312
          Top = 219
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 16
          OnKeyPress = edtLd1PU_HSKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1PU_HS: TEditFocus
          Tag = 99
          Left = 414
          Top = 219
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 257
          Top = 12
          Width = 175
          Height = 15
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtNfmPro: TEditFocus
          Tag = 99
          Left = 312
          Top = 403
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 31
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtAcuAbs: TEditFocus
          Tag = 99
          Left = 312
          Top = 425
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 32
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLd1_BT120: TEditFocus
          Tag = 99
          Left = 312
          Top = 242
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 18
          OnKeyPress = edtLd1_BT120KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1_BT120: TEditFocus
          Tag = 99
          Left = 414
          Top = 242
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1_BT90: TEditFocus
          Tag = 99
          Left = 312
          Top = 265
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 20
          OnKeyPress = edtLd1_BT90KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1_BT90: TEditFocus
          Tag = 99
          Left = 414
          Top = 265
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1_BT80: TEditFocus
          Tag = 99
          Left = 312
          Top = 287
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 22
          OnKeyPress = edtLd1_BT80KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1_BT80: TEditFocus
          Tag = 99
          Left = 414
          Top = 287
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLd1_BT100: TEditFocus
          Tag = 99
          Left = 312
          Top = 310
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 24
          OnKeyPress = edtLd1_BT100KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBd1_BT100: TEditFocus
          Tag = 99
          Left = 414
          Top = 310
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 25
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
          Left = 312
          Top = 447
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 33
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
          Left = 312
          Top = 470
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 34
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        inline fraPatWan: TfraDirectoryEditFocus
          Left = 312
          Top = 378
          TabOrder = 30
          Width = 360
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
        object edtLPAPB_10080: TEditFocus
          Tag = 99
          Left = 312
          Top = 332
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 26
          OnKeyPress = edtLPAPB_10080KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBPAPB_10080: TEditFocus
          Tag = 99
          Left = 414
          Top = 332
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLD1ABS_BASELINE: TEditFocus
          Tag = 99
          Left = 312
          Top = 355
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          ReadOnly = True
          TabOrder = 28
          OnKeyPress = edtLD1ABS_BASELINEKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBD1ABS_BASELINE: TEditFocus
          Tag = 99
          Left = 414
          Top = 355
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 29
          NormalColor = clWindow
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
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
    object tbsEmbalagens: TTabSheet
      Caption = '&3 - Embalagens'
      ImageIndex = 2
      object Label6: TLabel
        Left = 12
        Top = 16
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto para venda:'
      end
      object Label10: TLabel
        Left = 180
        Top = 38
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Gal'#227'o:'
      end
      object Label7: TLabel
        Left = 16
        Top = 38
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Emb. (LT):'
      end
      object edtDesProWan: TEditFocus
        Left = 174
        Top = 9
        Width = 502
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtProWan: TEditFocus
        Tag = 99
        Left = 112
        Top = 9
        Width = 63
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtProWanKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtGalWan: TEditFocus
        Tag = 99
        Left = 259
        Top = 31
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtEmbWan: TEditFocus
        Tag = 99
        Left = 112
        Top = 31
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 10
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object GroupBox5: TGroupBox
        Left = 3
        Top = 409
        Width = 502
        Height = 87
        TabOrder = 3
        object lblWanIco: TLabel
          Left = 52
          Top = 14
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Copo:'
        end
        object lblWanIsp: TLabel
          Left = 48
          Top = 36
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Spray:'
        end
        object lblWanIss: TLabel
          Left = 4
          Top = 58
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Spray Sint'#233'tico:'
        end
        object edtDesWanIco: TEditFocus
          Left = 143
          Top = 11
          Width = 348
          Height = 22
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
        object edtDesWanIsp: TEditFocus
          Left = 143
          Top = 33
          Width = 348
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
        object edtWanIco: TEditFocus
          Tag = 99
          Left = 86
          Top = 11
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtProWanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtWanIsp: TEditFocus
          Tag = 99
          Left = 86
          Top = 33
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 2
          OnKeyPress = edtProWanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtWanIss: TEditFocus
          Tag = 99
          Left = 86
          Top = 55
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 4
          OnKeyPress = edtProWanKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesWanIss: TEditFocus
          Left = 143
          Top = 55
          Width = 348
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
      object pnlEmbalagens: TPanel
        Left = 3
        Top = 59
        Width = 673
        Height = 345
        BevelOuter = bvNone
        TabOrder = 5
        object pgcEmbColorPro: TPageControl
          Left = 0
          Top = 0
          Width = 673
          Height = 345
          Align = alClient
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 581
    Width = 699
    ExplicitTop = 581
    ExplicitWidth = 699
    inherited pnlNomeForm: TPanel
      Left = 528
      ExplicitLeft = 528
    end
    inherited pnlInfo: TPanel
      Width = 528
      ExplicitWidth = 528
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 80
    Top = 65520
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 136
    Top = 65520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 65520
  end
end
