inherited frmConfiguracoesWanda: TfrmConfiguracoesWanda
  Left = 370
  Top = 441
  Width = 626
  Height = 325
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Wanda'
  Position = poMainFormCenter
  OnActivate = FormActivate
  ExplicitWidth = 626
  ExplicitHeight = 325
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 257
    Width = 620
    ExplicitTop = 257
    ExplicitWidth = 620
    DesignSize = (
      620
      28)
    inherited btnSair: TBitBtnLocked
      Left = 537
      TabOrder = 1
      ExplicitLeft = 537
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
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 620
    ExplicitTop = 285
    ExplicitWidth = 620
    inherited pnlNomeForm: TPanel
      Left = 449
      ExplicitLeft = 449
    end
    inherited pnlInfo: TPanel
      Width = 449
      ExplicitWidth = 449
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 620
    Height = 257
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object Label6: TLabel
      Left = 145
      Top = 58
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto para venda:'
    end
    object Label17: TLabel
      Left = 119
      Top = 234
      Width = 124
      Height = 14
      Alignment = taRightJustify
      Caption = 'Path para arquivos (*.txt):'
    end
    object Label9: TLabel
      Left = 313
      Top = 147
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator:'
    end
    object Label20: TLabel
      Left = 190
      Top = 147
      Width = 53
      Height = 14
      Caption = 'WAN_CON'
    end
    object Label11: TLabel
      Left = 8
      Top = 147
      Width = 179
      Height = 14
      Alignment = taRightJustify
      Caption = 'Trava p/ valor de venda concentrado'
    end
    object Label10: TLabel
      Left = 166
      Top = 102
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Gal'#227'o:'
    end
    object Label7: TLabel
      Left = 140
      Top = 80
      Width = 103
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Embalagem:'
    end
    object Label16: TLabel
      Left = 319
      Top = 80
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label1: TLabel
      Left = 319
      Top = 102
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label2: TLabel
      Left = 313
      Top = 169
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator:'
    end
    object Label3: TLabel
      Left = 195
      Top = 169
      Width = 46
      Height = 14
      Caption = 'WAN_DIL'
    end
    object Label4: TLabel
      Left = 43
      Top = 169
      Width = 148
      Height = 14
      Alignment = taRightJustify
      Caption = 'Trava p/ valor de venda diluido'
    end
    object Label5: TLabel
      Left = 133
      Top = 191
      Width = 108
      Height = 14
      Caption = 'Linhas para utiliza'#231#227'o:'
    end
    object Label8: TLabel
      Left = 90
      Top = 213
      Width = 152
      Height = 14
      Caption = 'Linha / Base para pre'#231'o dilu'#237'do:'
    end
    object Label13: TLabel
      Left = 314
      Top = 213
      Width = 28
      Height = 14
      Caption = 'Base:'
    end
    object Label14: TLabel
      Left = 55
      Top = 125
      Width = 187
      Height = 14
      Caption = 'Fator para gera'#231#227'o de pre'#231'o de custo:'
    end
    object edtDesProWan: TEditFocus
      Left = 302
      Top = 51
      Width = 308
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
    object edtProWan: TEditFocus
      Tag = 99
      Left = 245
      Top = 51
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = edtProWanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object chkUsaWan: TCheckBox
      Tag = 99
      Left = 16
      Top = 30
      Width = 175
      Height = 18
      Caption = 'Utilizar essa tinta de m'#225'quina'
      TabOrder = 0
    end
    object pnlCabecalho: TPanel
      Left = 2
      Top = 2
      Width = 616
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Wanda'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
    end
    object edtTraWan: TEditFocus
      Tag = 99
      Left = 245
      Top = 139
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 7
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
      Left = 343
      Top = 139
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesWanIem: TEditFocus
      Left = 401
      Top = 73
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
    object edtDesWanIgl: TEditFocus
      Left = 401
      Top = 95
      Width = 209
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtGalWan: TEditFocus
      Tag = 99
      Left = 245
      Top = 95
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
    object edtEmbWan: TEditFocus
      Tag = 99
      Left = 245
      Top = 73
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
    object edtWanIem: TEditFocus
      Tag = 99
      Left = 343
      Top = 73
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtProWanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtWanIgl: TEditFocus
      Tag = 99
      Left = 343
      Top = 95
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtProWanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTrdWan: TEditFocus
      Tag = 99
      Left = 245
      Top = 161
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 9
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
      Left = 343
      Top = 161
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 10
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
      Left = 245
      Top = 183
      Width = 364
      Height = 22
      EditMask = '999_999_999_999_999_999_999_999_999_999_;0;_'
      MaxLength = 40
      TabOrder = 11
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtLd1Wan: TEditFocus
      Tag = 99
      Left = 245
      Top = 205
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 13
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
      Left = 347
      Top = 205
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 14
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
      Left = 245
      Top = 117
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    inline fraPatWan: TfraDirectoryEditFocus
      Left = 245
      Top = 227
      TabOrder = 15
      Width = 364
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      inherited edtDirectory: TEditFocus
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 40
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 144
  end
end
