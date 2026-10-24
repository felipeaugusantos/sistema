inherited frmRcxInfChqVista: TfrmRcxInfChqVista
  Width = 496
  Height = 162
  Caption = 'Informa'#231#245'es Cheque a Vista'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 496
  ExplicitHeight = 162
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 490
    TabOrder = 1
    ExplicitTop = 93
    ExplicitWidth = 490
    inherited btnSair: TBitBtnLocked
      Left = 407
      TabOrder = 1
      ExplicitLeft = 407
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 6
      Top = 3
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
  inherited pnlStatus: TPanel
    Top = 121
    Width = 490
    TabOrder = 2
    ExplicitTop = 121
    ExplicitWidth = 490
    inherited pnlNomeForm: TPanel
      Left = 319
      ExplicitLeft = 319
    end
    inherited pnlInfo: TPanel
      Width = 319
      ExplicitWidth = 319
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 490
    Height = 93
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label22: TLabel
      Left = 57
      Top = 58
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object Label1: TLabel
      Left = 36
      Top = 32
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador p/ Dep'#243'sito:'
    end
    object Label2: TLabel
      Left = 3
      Top = 7
      Width = 134
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque a vista depositado?'
    end
    object edtChqDep: TEditFocus
      Tag = 99
      Left = 140
      Top = 4
      Width = 20
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 140
      Top = 29
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortador: TEditFocus
      Left = 214
      Top = 29
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCta: TEditFocus
      Left = 214
      Top = 55
      Width = 272
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCodCta: TMaskEditFocus
      Tag = 99
      Left = 140
      Top = 55
      Width = 72
      Height = 22
      EditMask = '99.99.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 3
      Text = ''
      OnKeyPress = mskCodCtaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
end
