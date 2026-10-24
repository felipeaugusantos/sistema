inherited frmCadRctDadosMovGro: TfrmCadRctDadosMovGro
  Height = 252
  Caption = 'Impress'#227'o de Receita Agron'#244'mica'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 179
    TabOrder = 1
    ExplicitTop = 179
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 325
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
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
      ExplicitLeft = 4
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 179
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 50
      Top = 68
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 15
      Top = 116
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Inf. Adicionais:'
    end
    object lbl1: TLabel
      Left = 29
      Top = 20
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nota Fiscal:'
    end
    object lbl2: TLabel
      Left = 16
      Top = 44
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data N. Fiscal:'
    end
    object lbl3: TLabel
      Left = 332
      Top = 20
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro. Receita:'
    end
    object lbl4: TLabel
      Left = 19
      Top = 92
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Respons'#225'vel:'
    end
    object lbl5: TLabel
      Left = 17
      Top = 140
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Emiss'#227'o:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 88
      Top = 64
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 170
      Top = 64
      Width = 297
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNotFis: TEditFocus
      Tag = 99
      Left = 88
      Top = 16
      Width = 80
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNotFisExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object mskDtaNot: TMaskEditFocus
      Tag = 99
      Left = 88
      Top = 40
      Width = 80
      Height = 22
      AutoSize = False
      EditMask = '!99/99/0099;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNroRec: TEditFocus
      Tag = 99
      Left = 397
      Top = 16
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodRes: TEditFocus
      Tag = 99
      Left = 88
      Top = 88
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomRes: TEditFocus
      Left = 170
      Top = 88
      Width = 297
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaEmi: TMaskEditFocus
      Tag = 99
      Left = 88
      Top = 136
      Width = 80
      Height = 22
      AutoSize = False
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtInfAdd: TEditFocus
      Left = 88
      Top = 112
      Width = 379
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlDadosFazenda: TPanel
      Left = 1
      Top = 166
      Width = 481
      Height = 12
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Aqui ser'#225' exibido as informa'#231#245'es da Fazenda selecionada '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
  end
  inherited pnlStatus: TPanel
    Top = 207
    TabOrder = 2
    ExplicitTop = 207
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 16
  end
end
