inherited frmConfiguracoesStarmix: TfrmConfiguracoesStarmix
  Left = 189
  Top = 146
  Width = 601
  Height = 585
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Starmix'
  Position = poMainFormCenter
  ExplicitWidth = 601
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 595
    ExplicitTop = 496
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
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 595
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Starmix'
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
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 23
    Width = 595
    Height = 494
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgcDadosChange
    ExplicitHeight = 473
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      ExplicitHeight = 441
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 587
        Height = 462
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        ExplicitHeight = 441
        object lbl1: TLabel
          Left = 89
          Top = 48
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object lbl2: TLabel
          Left = 91
          Top = 290
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt):'
        end
        object lbl3: TLabel
          Left = 285
          Top = 269
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object lbl4: TLabel
          Left = 167
          Top = 269
          Width = 45
          Height = 14
          Caption = 'STA_PRE'
        end
        object lbl5: TLabel
          Left = 31
          Top = 269
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object lbl6: TLabel
          Left = 38
          Top = 225
          Width = 176
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator para gera'#231#227'o Pre'#231'o de Venda:'
        end
        object lbl7: TLabel
          Left = 127
          Top = 336
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto m'#225'ximo:'
          Visible = False
        end
        object lbl8: TLabel
          Left = 99
          Top = 203
          Width = 115
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual de Impostos:'
        end
        object Label10: TLabel
          Left = 110
          Top = 92
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Gal'#227'o:'
        end
        object Label7: TLabel
          Left = 84
          Top = 70
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem:'
        end
        object lbl11: TLabel
          Left = 263
          Top = 70
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item Litro:'
        end
        object lbl12: TLabel
          Left = 256
          Top = 92
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item Gal'#227'o:'
        end
        object lbl13: TLabel
          Left = 115
          Top = 247
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual de Perda:'
        end
        object lbl14: TLabel
          Left = 69
          Top = 314
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
        end
        object lbl15: TLabel
          Left = 101
          Top = 358
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object lbl16: TColorLabel
          Left = 279
          Top = 359
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
        object lblStaIco: TLabel
          Left = 187
          Top = 115
          Width = 122
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem do Copo:'
        end
        object lblStaIsp: TLabel
          Left = 183
          Top = 137
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem do Spray:'
        end
        object Label1: TLabel
          Left = 83
          Top = 379
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %:'
        end
        object Label38: TLabel
          Left = 3
          Top = 401
          Width = 212
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda:'
        end
        object Label2: TLabel
          Left = 263
          Top = 159
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item Lata:'
        end
        object Label3: TLabel
          Left = 18
          Top = 422
          Width = 196
          Height = 14
          Alignment = taRightJustify
          Caption = 'Utilizar descri'#231#227'o personalizada Starmix:'
        end
        object ColorLabel1: TColorLabel
          Left = 251
          Top = 422
          Width = 82
          Height = 14
          Caption = '(S) Sim (N) N'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtDesProSta: TEditFocus
          Left = 246
          Top = 41
          Width = 332
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
        object edtProSta: TEditFocus
          Tag = 99
          Left = 189
          Top = 41
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 1
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaSta: TCheckBox
          Tag = 99
          Left = 16
          Top = 20
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraSta: TEditFocus
          Tag = 99
          Left = 217
          Top = 261
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFatSta: TEditFocus
          Tag = 99
          Left = 315
          Top = 261
          Width = 58
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFveSta: TEditFocus
          Tag = 99
          Left = 217
          Top = 217
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesSta: TEditFocus
          Tag = 99
          Left = 217
          Top = 329
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 16
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesStaIem: TEditFocus
          Left = 369
          Top = 63
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
        object edtDesStaIgl: TEditFocus
          Left = 369
          Top = 85
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
        object edtStaImp: TEditFocus
          Tag = 99
          Left = 217
          Top = 195
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtStaPgl: TEditFocus
          Tag = 99
          Left = 189
          Top = 85
          Width = 57
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
        object edtStaPlt: TEditFocus
          Tag = 99
          Left = 189
          Top = 63
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 10
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
        object edtStaIem: TEditFocus
          Tag = 99
          Left = 311
          Top = 63
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 3
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtStaIgl: TEditFocus
          Tag = 99
          Left = 311
          Top = 85
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 5
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtStaPer: TEditFocus
          Tag = 99
          Left = 217
          Top = 239
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtNfmSta: TEditFocus
          Tag = 99
          Left = 217
          Top = 307
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 20
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
          Left = 217
          Top = 351
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesStaIco: TEditFocus
          Left = 369
          Top = 108
          Width = 209
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
        object edtDesStaIsp: TEditFocus
          Left = 369
          Top = 130
          Width = 209
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtStaIco: TEditFocus
          Tag = 99
          Left = 311
          Top = 108
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 6
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtStaIsp: TEditFocus
          Tag = 99
          Left = 311
          Top = 130
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 7
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 217
          Top = 373
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 22
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
          Left = 217
          Top = 395
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        inline fraPatSta: TfraDirectoryEditFocus
          Left = 217
          Top = 283
          TabOrder = 15
          Width = 361
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
        object edtDesStaIla: TEditFocus
          Left = 369
          Top = 152
          Width = 209
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
        object edtStaIla: TEditFocus
          Tag = 99
          Left = 311
          Top = 152
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 8
          OnKeyPress = edtProStaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesPst: TEditFocus
          Tag = 99
          Left = 217
          Top = 417
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 26
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 595
    ExplicitTop = 524
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 40
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 16
  end
end
