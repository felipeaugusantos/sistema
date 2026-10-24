inherited frmRcxDigDesconto: TfrmRcxDigDesconto
  Left = 350
  Top = 217
  Width = 408
  Height = 232
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o do Desconto'
  Position = poMainFormCenter
  ExplicitWidth = 408
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 163
    Width = 402
    Height = 24
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 163
    ExplicitWidth = 402
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 244
      Height = 20
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 244
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 323
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 323
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 20
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 402
    TabOrder = 3
    ExplicitTop = 187
    ExplicitWidth = 402
    inherited pnlNomeForm: TPanel
      Left = 281
      Width = 121
      ExplicitLeft = 281
      ExplicitWidth = 121
    end
    inherited pnlInfo: TPanel
      Width = 281
      ExplicitWidth = 281
    end
  end
  inherited pgcDados: TPageControl
    Width = 402
    Height = 163
    TabOrder = 2
    ExplicitWidth = 402
    ExplicitHeight = 163
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 394
      ExplicitHeight = 131
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 402
    Height = 163
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 75
      Top = 19
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 52
      Top = 42
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = '% de Desconto:'
    end
    object Label3: TLabel
      Left = 6
      Top = 65
      Width = 123
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral - % Desconto:'
    end
    object Label4: TLabel
      Left = 37
      Top = 88
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto Especial:'
    end
    object Label5: TLabel
      Left = 67
      Top = 111
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Liquido:'
    end
    object lblMotivo: TLabel
      Left = 46
      Top = 134
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo Desconto:'
    end
    object edtTotGer: TEditFocus
      Left = 130
      Top = 12
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtPerDes: TEditFocus
      Tag = 99
      Left = 130
      Top = 35
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      OnChange = edtPerDesChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotDes: TEditFocus
      Left = 130
      Top = 58
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtDesEsp: TEditFocus
      Tag = 99
      Left = 130
      Top = 81
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      OnChange = edtPerDesChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotLiq: TEditFocus
      Left = 130
      Top = 104
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtMotivo: TEditFocus
      Left = 130
      Top = 127
      Width = 263
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      OnExit = edtMotivoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 64
  end
end
