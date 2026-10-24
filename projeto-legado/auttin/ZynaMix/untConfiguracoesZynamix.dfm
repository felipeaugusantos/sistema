inherited frmConfiguracoesZynamix: TfrmConfiguracoesZynamix
  Left = 278
  Top = 156
  Width = 601
  Height = 647
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Zynamix'
  Position = poMainFormCenter
  ExplicitWidth = 601
  ExplicitHeight = 647
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 579
    Width = 595
    ExplicitTop = 579
    ExplicitWidth = 595
    DesignSize = (
      595
      28)
    inherited btnSair: TBitBtnLocked
      Left = 512
      TabOrder = 1
      ExplicitLeft = 512
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
  inherited pnlStatus: TPanel
    Top = 607
    Width = 595
    ExplicitTop = 607
    ExplicitWidth = 595
    inherited pnlNomeForm: TPanel
      Left = 424
      ExplicitLeft = 424
    end
    inherited pnlInfo: TPanel
      Width = 424
      ExplicitWidth = 424
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 595
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Zynamix'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 23
    Width = 595
    Height = 556
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgcDadosChange
    object tbsGeral: TTabSheet
      Caption = '&1 - Dados'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 587
        Height = 524
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        object Label6: TLabel
          Left = 113
          Top = 37
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object Label17: TLabel
          Left = 87
          Top = 433
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt):'
        end
        object lblEmbGal: TLabel
          Left = 30
          Top = 149
          Width = 181
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem GL DULON:'
        end
        object lblZynGdf: TLabel
          Left = 17
          Top = 170
          Width = 194
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem GL DELFLEET:'
        end
        object lblZynGdt: TLabel
          Left = 19
          Top = 192
          Width = 192
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem GL DELTRON:'
        end
        object lblZynGom: TLabel
          Left = 40
          Top = 214
          Width = 171
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem GL OMNI:'
        end
        object lblZynLdf: TLabel
          Left = 20
          Top = 281
          Width = 191
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem LT DELFLEET:'
        end
        object lblZynLdt: TLabel
          Left = 22
          Top = 303
          Width = 189
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem LT DELTRON:'
        end
        object lblZynLom: TLabel
          Left = 43
          Top = 325
          Width = 168
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem LT OMNI:'
        end
        object lblEmbLit: TLabel
          Left = 33
          Top = 259
          Width = 178
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem LT DULON:'
        end
        object Label9: TLabel
          Left = 286
          Top = 60
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label20: TLabel
          Left = 163
          Top = 60
          Width = 47
          Height = 14
          Caption = 'ZYN_PRE'
        end
        object Label11: TLabel
          Left = 31
          Top = 60
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label10: TLabel
          Left = 134
          Top = 125
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Gal'#227'o:'
        end
        object Label7: TLabel
          Left = 108
          Top = 103
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem:'
        end
        object lblMarZyn: TLabel
          Left = 26
          Top = 82
          Width = 180
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem para c'#225'lculo Pre'#231'o de Custo:'
        end
        object lblZynVcd: TLabel
          Left = 78
          Top = 476
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de custo litro diluente:'
        end
        object lblZynVvd: TLabel
          Left = 75
          Top = 454
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de venda litro diluente:'
        end
        object lblZynLzy: TLabel
          Left = 21
          Top = 347
          Width = 190
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem LT ZYNAMIX:'
        end
        object lblZynGzy: TLabel
          Left = 18
          Top = 236
          Width = 193
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem GL ZYNAMIX:'
        end
        object Label4: TLabel
          Left = 57
          Top = 377
          Width = 154
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem Copo:'
        end
        object Label8: TLabel
          Left = 53
          Top = 399
          Width = 158
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto baixa embalagem Spray:'
        end
        object Label1: TLabel
          Left = 65
          Top = 497
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
        end
        object edtDesProZyn: TEditFocus
          Left = 270
          Top = 30
          Width = 308
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
        object edtProZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 30
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 1
          OnKeyPress = edtProZynKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynGdu: TEditFocus
          Left = 269
          Top = 141
          Width = 307
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
        object edtDesZynLdu: TEditFocus
          Left = 269
          Top = 252
          Width = 308
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
        object edtZynGdu: TEditFocus
          Tag = 99
          Left = 213
          Top = 141
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 7
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtZynLdu: TEditFocus
          Tag = 99
          Left = 213
          Top = 252
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 12
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaZyn: TCheckBox
          Tag = 99
          Left = 16
          Top = 9
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtDesZynGdf: TEditFocus
          Left = 269
          Top = 163
          Width = 308
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
        object edtZynGdf: TEditFocus
          Tag = 99
          Left = 213
          Top = 163
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 8
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynGdt: TEditFocus
          Left = 269
          Top = 185
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 23
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynGdt: TEditFocus
          Tag = 99
          Left = 213
          Top = 185
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 9
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynGom: TEditFocus
          Left = 269
          Top = 207
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 24
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynGom: TEditFocus
          Tag = 99
          Left = 213
          Top = 207
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 10
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynLdf: TEditFocus
          Left = 269
          Top = 274
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 25
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynLdf: TEditFocus
          Tag = 99
          Left = 213
          Top = 274
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 13
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynLdt: TEditFocus
          Left = 269
          Top = 296
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 26
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynLdt: TEditFocus
          Tag = 99
          Left = 213
          Top = 296
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 14
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynLom: TEditFocus
          Left = 269
          Top = 318
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 27
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynLom: TEditFocus
          Tag = 99
          Left = 213
          Top = 318
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 15
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtTraZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 52
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
        object edtFatZyn: TEditFocus
          Tag = 99
          Left = 319
          Top = 52
          Width = 57
          Height = 22
          Alignment = taLeftJustify
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
        object edtGalZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 118
          Width = 56
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
        object edtEmbZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 96
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 10
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
        inline fraPatZyn: TfraDirectoryEditFocus
          Left = 213
          Top = 426
          Width = 365
          Height = 22
          TabOrder = 28
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
        object edtMarZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 74
          Width = 56
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
        object edtZynVcd: TEditFocus
          Tag = 99
          Left = 213
          Top = 469
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 30
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtZynVvd: TEditFocus
          Tag = 99
          Left = 213
          Top = 447
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 10
          TabOrder = 29
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesZynLzy: TEditFocus
          Left = 269
          Top = 340
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 32
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynLzy: TEditFocus
          Tag = 99
          Left = 213
          Top = 340
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 16
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynGzy: TEditFocus
          Left = 269
          Top = 229
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 33
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynGzy: TEditFocus
          Tag = 99
          Left = 213
          Top = 229
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 11
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtZynCop: TEditFocus
          Tag = 99
          Left = 213
          Top = 370
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 17
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynCop: TEditFocus
          Left = 269
          Top = 370
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 34
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtZynSpr: TEditFocus
          Tag = 99
          Left = 213
          Top = 392
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 18
          OnKeyPress = edtZynGduKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesZynSpr: TEditFocus
          Left = 269
          Top = 392
          Width = 308
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 35
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNfmZyn: TEditFocus
          Tag = 99
          Left = 213
          Top = 491
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
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 384
    Top = 16
  end
end
