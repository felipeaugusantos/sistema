inherited frmAltVendTemp: TfrmAltVendTemp
  Width = 616
  Height = 231
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Vendedores Tempor'#225'rios'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 616
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 14
  object lblVenAtu: TLabel [0]
    Left = 43
    Top = 35
    Width = 77
    Height = 14
    Alignment = taRightJustify
    Caption = 'Vendedor Atual:'
  end
  object lblVenTemp: TLabel [1]
    Left = 14
    Top = 59
    Width = 106
    Height = 14
    Alignment = taRightJustify
    Caption = 'Vendedor Tempor'#225'rio:'
  end
  object lblPeriodoVig: TLabel [2]
    Left = 21
    Top = 11
    Width = 99
    Height = 14
    Alignment = taRightJustify
    Caption = 'Per'#237'odo de Vig'#234'ncia:'
  end
  object lblAte: TLabel [3]
    Left = 188
    Top = 11
    Width = 22
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'at'#233
  end
  inherited pnlBotoes: TPanel
    Top = 159
    Width = 610
    TabOrder = 7
    ExplicitTop = 159
    ExplicitWidth = 610
    inherited btnSair: TBitBtnLocked
      Left = 527
      TabOrder = 1
      ExplicitLeft = 527
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 4
      Width = 76
      Height = 20
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 610
    TabOrder = 8
    ExplicitTop = 187
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 439
      ExplicitLeft = 439
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
    end
  end
  object edtCodVen: TEditFocus [7]
    Tag = 99
    Left = 124
    Top = 32
    Width = 40
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtCodVenKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesVen: TEditFocus [8]
    Left = 166
    Top = 32
    Width = 435
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object edtCodVenTemp: TEditFocus [9]
    Tag = 99
    Left = 124
    Top = 56
    Width = 40
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 3
    TabOrder = 4
    OnKeyPress = edtCodVenTempKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesVenTemp: TEditFocus [10]
    Left = 166
    Top = 56
    Width = 435
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object mskDtaIni: TMaskEditFocus [11]
    Tag = 99
    Left = 124
    Top = 8
    Width = 61
    Height = 22
    EditMask = '99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaFin: TMaskEditFocus [12]
    Tag = 99
    Left = 211
    Top = 8
    Width = 62
    Height = 22
    EditMask = '99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object rdgVenTempJaExiste: TRadioGroup [13]
    Left = 124
    Top = 80
    Width = 477
    Height = 70
    Caption = 
      '   Clientes com vendedor tempor'#225'rio j'#225' informado para o per'#237'odo ' +
      '  '
    ItemIndex = 2
    Items.Strings = (
      'Substituir vendedor tempor'#225'rio'
      'Deixar vendedor tempor'#225'rio informado anteriormente'
      'Cancelar processamento')
    TabOrder = 6
  end
end
