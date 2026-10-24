inherited frmConfiguracoesAutocolor: TfrmConfiguracoesAutocolor
  Left = 189
  Top = 146
  Width = 597
  Height = 460
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Autocolor Automotiva'
  Position = poScreenCenter
  ExplicitWidth = 597
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 392
    Width = 591
    ExplicitTop = 387
    ExplicitWidth = 591
    DesignSize = (
      591
      28)
    inherited btnSair: TBitBtnLocked
      Left = 508
      TabOrder = 1
      ExplicitLeft = 508
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
    Top = 420
    Width = 591
    ExplicitTop = 415
    ExplicitWidth = 591
    inherited pnlNomeForm: TPanel
      Left = 420
      ExplicitLeft = 420
    end
    inherited pnlInfo: TPanel
      Width = 420
      ExplicitWidth = 420
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 23
    Width = 591
    Height = 369
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    OnChange = pgcDadosChange
    ExplicitHeight = 364
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      ExplicitHeight = 332
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 583
        Height = 337
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        ExplicitHeight = 332
        object Label6: TLabel
          Left = 113
          Top = 55
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object Label17: TLabel
          Left = 55
          Top = 285
          Width = 156
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt / *.dbf):'
        end
        object Label9: TLabel
          Left = 281
          Top = 239
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object Label20: TLabel
          Left = 165
          Top = 239
          Width = 46
          Height = 14
          Caption = 'AUT_PRE'
        end
        object Label11: TLabel
          Left = 31
          Top = 239
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label13: TLabel
          Left = 38
          Top = 216
          Width = 173
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator para gera'#231#227'o Pre'#231'o de Custo:'
        end
        object Label10: TLabel
          Left = 69
          Top = 101
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem (Gal'#227'o):'
        end
        object Label7: TLabel
          Left = 76
          Top = 78
          Width = 135
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem (Litro):'
        end
        object Label16: TLabel
          Left = 287
          Top = 78
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item:'
        end
        object Label1: TLabel
          Left = 287
          Top = 101
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item:'
        end
        object lblAutIco: TLabel
          Left = 177
          Top = 124
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem para Copo:'
        end
        object lblAutIsp: TLabel
          Left = 173
          Top = 147
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem para Spray:'
        end
        object Label2: TLabel
          Left = 97
          Top = 262
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object ColorLabel4: TColorLabel
          Left = 277
          Top = 262
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
        object lblAutIla: TLabel
          Left = 181
          Top = 193
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem para Lata:'
        end
        object lblAutItb: TLabel
          Left = 167
          Top = 170
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item embalagem para Tambor:'
        end
        object Label19: TLabel
          Left = 66
          Top = 313
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
        end
        object edtDesProAut: TEditFocus
          Left = 270
          Top = 51
          Width = 308
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
        object edtProAut: TEditFocus
          Tag = 99
          Left = 213
          Top = 51
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 2
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaAut: TCheckBox
          Tag = 99
          Left = 16
          Top = 30
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraAut: TEditFocus
          Tag = 99
          Left = 213
          Top = 235
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFatAut: TEditFocus
          Tag = 99
          Left = 311
          Top = 235
          Width = 57
          Height = 22
          Alignment = taLeftJustify
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
        object edtFatCus: TEditFocus
          Tag = 99
          Left = 213
          Top = 212
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
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesAutIem: TEditFocus
          Left = 369
          Top = 74
          Width = 209
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtDesAutIgl: TEditFocus
          Left = 369
          Top = 97
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
        object edtAutPgl: TEditFocus
          Tag = 99
          Left = 213
          Top = 97
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtAutPlt: TEditFocus
          Tag = 99
          Left = 213
          Top = 74
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 10
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
        object edtAutIem: TEditFocus
          Tag = 99
          Left = 311
          Top = 74
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 5
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtAutIgl: TEditFocus
          Tag = 99
          Left = 311
          Top = 97
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 8
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesAutIco: TEditFocus
          Left = 369
          Top = 120
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
        object edtDesAutIsp: TEditFocus
          Left = 369
          Top = 143
          Width = 209
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
        object edtAutIco: TEditFocus
          Tag = 99
          Left = 311
          Top = 120
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 9
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtAutIsp: TEditFocus
          Tag = 99
          Left = 311
          Top = 143
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 10
          OnKeyPress = edtProAutKeyPress
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
          Left = 213
          Top = 258
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtAutIla: TEditFocus
          Tag = 99
          Left = 311
          Top = 189
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 12
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesAutIla: TEditFocus
          Left = 369
          Top = 189
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
        object edtDesAutItb: TEditFocus
          Left = 369
          Top = 166
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
        object edtAutItb: TEditFocus
          Tag = 99
          Left = 311
          Top = 166
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 11
          OnKeyPress = edtProAutKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object chkUsaFor: TCheckBox
          Left = 192
          Top = 31
          Width = 105
          Height = 17
          Caption = 'Usar formula'#231#227'o'
          TabOrder = 1
        end
        object edtNfmAut: TEditFocus
          Tag = 99
          Left = 213
          Top = 306
          Width = 121
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        inline fraPatAut: TfraDirectoryEditFocus
          Left = 213
          Top = 281
          TabOrder = 17
          Width = 365
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
      ExplicitHeight = 332
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 591
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Autocolor Automotiva'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
    Top = 224
  end
end
