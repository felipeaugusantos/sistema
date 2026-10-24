inherited frmDadosCadLoteWMS: TfrmDadosCadLoteWMS
  Width = 491
  Height = 254
  BorderStyle = bsDialog
  Caption = 'Cadastro R'#225'pido Lote - WMS'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 491
  ExplicitHeight = 254
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 182
    Width = 485
    Height = 27
    Enabled = True
    TabOrder = 3
    Visible = True
    ExplicitTop = 182
    ExplicitWidth = 485
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 332
      Height = 23
      TabOrder = 2
      ExplicitLeft = 74
      ExplicitWidth = 332
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 406
      Top = 2
      Height = 23
      Align = alRight
      ExplicitLeft = 406
      ExplicitTop = 2
      ExplicitHeight = 23
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
      Height = 23
      Align = alLeft
      Caption = '&Gravar'
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
      OnClick = btnGravarClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 4
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  inherited pnlStatus: TPanel
    Top = 209
    Width = 485
    TabOrder = 5
    ExplicitTop = 209
    ExplicitWidth = 485
    inherited pnlNomeForm: TPanel
      Left = 314
      ExplicitLeft = 314
    end
    inherited pnlInfo: TPanel
      Width = 314
      ExplicitWidth = 314
    end
  end
  object pnlPrinc: TPanel [4]
    Left = 0
    Top = 55
    Width = 485
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lbl3: TLabel
      Left = 35
      Top = 33
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Validade:'
    end
    object lblLocFis: TLabel
      Left = 27
      Top = 57
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object lblLocSep: TLabel
      Left = 34
      Top = 81
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local Separa'#231#227'o:'
    end
    object Label1: TLabel
      Left = 40
      Top = 9
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Numero do Lote:'
    end
    object shpNumLot: TShape
      Left = 121
      Top = 2
      Width = 7
      Height = 22
    end
    object mskDtaVal: TMaskEditFocus
      Tag = 99
      Left = 121
      Top = 29
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 121
      Top = 53
      Width = 134
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 2
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocSep: TEditFocus
      Tag = 99
      Left = 121
      Top = 77
      Width = 134
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      OnKeyPress = edtLocSepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkAbsAut: TCheckBox
      Left = 5
      Top = 103
      Width = 398
      Height = 17
      Caption = 
        'Permitir abastecimento autom'#225'tico pelo Relat'#243'rio de Itens Abaixo' +
        ' do M'#237'nimo'
      TabOrder = 4
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 129
      Top = 2
      Width = 126
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCodIte: TPanel [5]
    Left = 0
    Top = 29
    Width = 485
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    UseDockManager = False
    TabOrder = 1
    Visible = False
    object lbl1: TLabel
      Left = 61
      Top = 7
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Item:'
    end
    object edtDesIte: TEditFocus
      Left = 178
      Top = 3
      Width = 200
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 121
      Top = 3
      Width = 55
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
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  object pnlCodbar: TPanel [6]
    Left = 0
    Top = 0
    Width = 485
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCodbar'
    TabOrder = 0
    Visible = False
    object lblCodbar: TLabel
      Left = 77
      Top = 11
      Width = 41
      Height = 14
      Caption = 'Etiqueta:'
    end
    object edtCodbar: TEditFocus
      Tag = 99
      Left = 121
      Top = 6
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 16
  end
end
