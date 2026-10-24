inherited frmBaiOrdPro: TfrmBaiOrdPro
  Left = 461
  Top = 313
  Width = 358
  Height = 296
  ActiveControl = edtOrdPro
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 225
    Width = 350
    inherited btnSair: TBitBtn
      Left = 269
      TabOrder = 1
    end
    object btnGravar: TBitBtn
      Left = 4
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Baixar'
      TabOrder = 0
      OnClick = btnGravarClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 253
    Width = 350
    inherited pnlNomeForm: TPanel
      Left = 179
    end
    inherited pnlInfo: TPanel
      Width = 179
    end
  end
  object pnlOrdPro: TPanel [2]
    Left = 0
    Top = 0
    Width = 350
    Height = 34
    Align = alTop
    Color = 16770261
    TabOrder = 2
    object Label3: TLabel
      Left = 11
      Top = 11
      Width = 114
      Height = 14
      Caption = 'N'#186' Ordem de Produ'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtOrdPro: TEditFocus
      Tag = 99
      Left = 129
      Top = 6
      Width = 67
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnExit = edtOrdProExit
      OnKeyPress = edtOrdProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttInteiro
      Alignment = taLeftJustify
    end
  end
  object pnlDadCli: TPanel [3]
    Left = 0
    Top = 34
    Width = 350
    Height = 131
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 44
      Top = 13
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 39
      Top = 37
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object Label4: TLabel
      Left = 11
      Top = 61
      Width = 69
      Height = 14
      Caption = 'Observa'#231#245'es:'
    end
    object Label5: TLabel
      Left = 36
      Top = 109
      Width = 43
      Height = 14
      Caption = 'Produzir:'
    end
    object edtCliente: TEditFocus
      Left = 84
      Top = 7
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtProduto: TEditFocus
      Left = 84
      Top = 31
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtObs001: TEditFocus
      Left = 84
      Top = 55
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtObs002: TEditFocus
      Left = 84
      Top = 79
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtProduzir: TEditFocus
      Left = 84
      Top = 103
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
  end
  object pnlConferido: TPanel [4]
    Left = 0
    Top = 165
    Width = 350
    Height = 60
    Align = alClient
    Color = 16770261
    TabOrder = 4
    object Label6: TLabel
      Left = 28
      Top = 13
      Width = 51
      Height = 14
      Caption = 'Produzido:'
    end
    object Label7: TLabel
      Left = 12
      Top = 37
      Width = 69
      Height = 14
      Caption = 'Conferido Por:'
    end
    object edtProduzido: TEditFocus
      Tag = 99
      Left = 84
      Top = 7
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      Color = clWhite
      TabOrder = 0
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtConfPor: TEditFocus
      Left = 84
      Top = 31
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      Color = clWhite
      MaxLength = 30
      TabOrder = 1
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 800
    Top = 544
  end
end
