inherited frmDigEmailPedidoCompra: TfrmDigEmailPedidoCompra
  Left = 287
  Top = 346
  Width = 451
  Height = 204
  Caption = 'Digita'#231#227'o do E-mail'
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 127
    Width = 443
    TabOrder = 1
    inherited btnSair: TBitBtn
      Left = 362
      TabOrder = 1
    end
    object btnConfirma: TBitBtn
      Left = 3
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
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
    Top = 155
    Width = 443
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 272
    end
    inherited pnlInfo: TPanel
      Width = 272
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 443
    Height = 127
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'E-mail:'
    end
    object Label2: TLabel
      Left = 16
      Top = 46
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Contato:'
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 59
      Top = 16
      Width = 371
      Height = 22
      MaxLength = 60
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtContato: TEditFocus
      Tag = 99
      Left = 59
      Top = 38
      Width = 371
      Height = 22
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object gbPreco: TGroupBox
      Left = 9
      Top = 68
      Width = 164
      Height = 48
      Caption = 'Pre'#231'o'
      TabOrder = 2
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
    object gbOrdem: TGroupBox
      Left = 174
      Top = 68
      Width = 153
      Height = 48
      Caption = 'Ordem'
      TabOrder = 3
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
    object gbExporta: TGroupBox
      Left = 328
      Top = 68
      Width = 103
      Height = 48
      Caption = 'Exportar'
      TabOrder = 4
      object ColorLabel1: TColorLabel
        Left = 29
        Top = 21
        Width = 67
        Height = 14
        Caption = '(P)df   (E)xcel'
        CorDestaque = clRed
      end
      object edtTipExp: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'P'
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 104
  end
end
