inherited frmAlteraFreteEspelho: TfrmAlteraFreteEspelho
  Width = 698
  Height = 206
  Caption = 'Manuten'#231#227'o dos Dados de Frete/Transportadora no Espelho'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 698
  ExplicitHeight = 206
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 133
    Width = 692
    ExplicitTop = 133
    ExplicitWidth = 692
    inherited FlwBotoes: TFlowPanel
      Width = 688
      ExplicitWidth = 688
      object btnConfirmaDados: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Confirma'
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
        OnClick = btnConfirmaDadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 609
      Top = 2
      ExplicitLeft = 609
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 161
    Width = 692
    ExplicitTop = 161
    ExplicitWidth = 692
    inherited pnlNomeForm: TPanel
      Left = 521
      ExplicitLeft = 521
    end
    inherited pnlInfo: TPanel
      Width = 521
      ExplicitWidth = 521
    end
  end
  object pnlTransportadora: TPanel [2]
    Left = 0
    Top = 0
    Width = 692
    Height = 133
    Align = alClient
    TabOrder = 2
    object lblValorDoFrete: TLabel
      Left = 30
      Top = 7
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do Frete:'
    end
    object lblEspecie: TLabel
      Left = 60
      Top = 30
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object lblQuantidade: TLabel
      Left = 43
      Top = 53
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object lblTransportadora: TLabel
      Left = 23
      Top = 76
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object lblPlacaVeiculo: TLabel
      Left = 34
      Top = 99
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Placa Ve'#237'culo:'
    end
    object lblNumeracao: TLabel
      Left = 196
      Top = 53
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Numera'#231#227'o:'
    end
    object lblMarca: TLabel
      Left = 221
      Top = 30
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblFretePorConta: TLabel
      Left = 183
      Top = 7
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete p/ Conta:'
    end
    object lblPesoBruto: TLabel
      Left = 563
      Top = 30
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
    end
    object lblPesoLiquido: TLabel
      Left = 401
      Top = 30
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso L'#237'quido:'
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 105
      Top = 3
      Width = 61
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtEspTra: TEditFocus
      Tag = 99
      Left = 105
      Top = 26
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdTra: TEditFocus
      Tag = 99
      Left = 105
      Top = 49
      Width = 61
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtQtdTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 105
      Top = 72
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object mskPlaFat: TMaskEditFocus
      Tag = 99
      Left = 105
      Top = 95
      Width = 61
      Height = 22
      AutoSelect = False
      AutoSize = False
      EditMask = 'aaa-9a99;0; '
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomTra: TEditFocus
      Left = 168
      Top = 72
      Width = 225
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNumera: TEditFocus
      Tag = 99
      Left = 257
      Top = 49
      Width = 136
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 14
      TipoTexto = ttAlfanumerico
    end
    object edtMarTra: TEditFocus
      Tag = 99
      Left = 257
      Top = 26
      Width = 136
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object cmbTipFre: TComboBoxFocus
      Tag = 99
      Left = 257
      Top = 3
      Width = 136
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 622
      Top = 26
      Width = 62
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 467
      Top = 26
      Width = 81
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 56
  end
end
