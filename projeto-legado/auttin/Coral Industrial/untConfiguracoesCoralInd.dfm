inherited frmConfiguracoesCoralInd: TfrmConfiguracoesCoralInd
  Left = 238
  Top = 258
  Width = 606
  Height = 246
  ActiveControl = chkUsaCor
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Coral Industrial'
  Position = poScreenCenter
  ExplicitWidth = 606
  ExplicitHeight = 246
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 178
    Width = 600
    ExplicitTop = 178
    ExplicitWidth = 600
    DesignSize = (
      600
      28)
    inherited btnSair: TBitBtnLocked
      Left = 517
      TabOrder = 1
      ExplicitLeft = 517
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
    Top = 206
    Width = 600
    ExplicitTop = 206
    ExplicitWidth = 600
    inherited pnlNomeForm: TPanel
      Left = 429
      ExplicitLeft = 429
    end
    inherited pnlInfo: TPanel
      Width = 429
      ExplicitWidth = 429
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 600
    Height = 178
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label3: TLabel
      Left = 91
      Top = 101
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto para venda:'
    end
    object Label4: TLabel
      Left = 9
      Top = 124
      Width = 128
      Height = 14
      Alignment = taRightJustify
      Caption = 'Trava para valor de venda'
    end
    object Label5: TLabel
      Left = 264
      Top = 124
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator'
    end
    object Label20: TLabel
      Left = 140
      Top = 124
      Width = 47
      Height = 14
      Caption = 'COR_PRE'
    end
    object Label8: TLabel
      Left = 42
      Top = 79
      Width = 145
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
    end
    object Label9: TLabel
      Left = 78
      Top = 58
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Path para arquivo TXT:'
    end
    object Label13: TLabel
      Left = 42
      Top = 147
      Width = 146
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem de lucro do colorante:'
    end
    object chkUsaCor: TCheckBox
      Tag = 99
      Left = 24
      Top = 32
      Width = 175
      Height = 18
      Caption = 'Utilizar essa tinta de m'#225'quina'
      TabOrder = 0
    end
    object edtDesCor: TEditFocus
      Left = 248
      Top = 94
      Width = 339
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtProCor: TEditFocus
      Tag = 99
      Left = 191
      Top = 94
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtProCorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTraCor: TEditFocus
      Tag = 99
      Left = 191
      Top = 117
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtFatCor: TEditFocus
      Tag = 99
      Left = 297
      Top = 116
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNfmCor: TEditFocus
      Tag = 99
      Left = 191
      Top = 72
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtMarCor: TEditFocus
      Tag = 99
      Left = 191
      Top = 139
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
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
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 598
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Coral Industrial'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 9
    end
    object chkUsaFor: TCheckBox
      Tag = 99
      Left = 191
      Top = 30
      Width = 175
      Height = 18
      Caption = 'Utilizar Formula'#231#227'o'
      TabOrder = 1
    end
    inline fraTxtCor: TfraDirectoryEditFocus
      Left = 191
      Top = 47
      TabOrder = 2
      Width = 396
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      inherited edtDirectory: TEditFocus
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 184
  end
end
