inherited frmPedidoCompraImpr: TfrmPedidoCompraImpr
  Left = 292
  Width = 256
  Height = 338
  ActiveControl = nil
  Caption = 'Impress'#227'o - Pedido de Compra'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 261
    Width = 248
    TabOrder = 5
    inherited btnSair: TBitBtn
      Left = 167
      TabOrder = 1
      Visible = False
    end
    object btnConfirmar: TBitBtn
      Left = 166
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
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
    Top = 289
    Width = 248
    TabOrder = 6
    inherited pnlNomeForm: TPanel
      Left = 77
    end
    inherited pnlInfo: TPanel
      Width = 77
    end
  end
  object gbImprimir: TGroupBox [2]
    Left = 15
    Top = 5
    Width = 217
    Height = 48
    Caption = 'Imprimir'
    TabOrder = 0
    object ColorLabel1: TColorLabel
      Left = 29
      Top = 21
      Width = 61
      Height = 14
      Caption = '(S)im   (N)'#227'o'
      CorDestaque = clRed
    end
    object edtImprimir: TEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'S'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
  end
  object gbPreco: TGroupBox [3]
    Left = 15
    Top = 56
    Width = 217
    Height = 48
    Caption = 'Pre'#231'o'
    TabOrder = 1
    object ColorLabel2: TColorLabel
      Left = 29
      Top = 21
      Width = 129
      Height = 14
      Caption = '(C)om Pre'#231'o   (S)em Pre'#231'o'
      CorDestaque = clRed
    end
    object edtPreco: TEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'C'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
  end
  object gbOrdem: TGroupBox [4]
    Left = 15
    Top = 106
    Width = 217
    Height = 48
    Caption = 'Ordem'
    TabOrder = 2
    object ColorLabel3: TColorLabel
      Left = 29
      Top = 21
      Width = 118
      Height = 14
      Caption = '(D)igita'#231#227'o   (A)lfab'#233'tica'
      CorDestaque = clRed
    end
    object edtOrdem: TEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'D'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
  end
  object gbOpcao: TGroupBox [5]
    Left = 15
    Top = 207
    Width = 217
    Height = 48
    Caption = 'Op'#231#227'o'
    TabOrder = 4
    object ColorLabel4: TColorLabel
      Left = 29
      Top = 21
      Width = 178
      Height = 14
      Caption = '(I)mpressora  (S)uvinil-txt  (C)oral-txt'
      CorDestaque = clRed
    end
    object edtOpcao: TEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'I'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
  end
  object GroupBox1: TGroupBox [6]
    Left = 15
    Top = 156
    Width = 217
    Height = 48
    Caption = 'Imprimir Resumo de Litragem por Grupo'
    TabOrder = 3
    object ColorLabel5: TColorLabel
      Left = 29
      Top = 21
      Width = 61
      Height = 14
      Caption = '(S)im   (N)'#227'o'
      CorDestaque = clRed
    end
    object edtResLitragem: TEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 120
  end
end
