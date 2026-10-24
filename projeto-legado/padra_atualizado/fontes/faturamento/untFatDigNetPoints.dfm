inherited frmFatDigNetPoints: TfrmFatDigNetPoints
  Left = 481
  Top = 397
  Width = 250
  Height = 212
  BorderIcons = [biSystemMenu]
  Caption = 'Netpoints'
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 250
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 141
    Width = 244
    Height = 26
    TabOrder = 1
    ExplicitTop = 141
    ExplicitWidth = 244
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 163
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 240
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 165
      Top = 2
      Align = alRight
      ExplicitLeft = 161
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
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
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 244
    Height = 141
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 139
    object Label1: TLabel
      Left = 8
      Top = 54
      Width = 22
      Height = 14
      Caption = 'CPF:'
    end
    object Label5: TLabel
      Left = 8
      Top = 83
      Width = 36
      Height = 14
      Caption = 'Celular:'
    end
    object ColorLabel7: TColorLabel
      Left = 126
      Top = 22
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 8
      Top = 22
      Width = 115
      Height = 14
      Caption = 'Quer ganhar Netpoints?'
    end
    object lblSldNps: TLabel
      Left = 4
      Top = 112
      Width = 234
      Height = 16
      AutoSize = False
      Caption = 'Saldo antes desta compra: 0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object edtNpsS_N: TEditFocus
      Tag = 99
      Left = 187
      Top = 19
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'S'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object mskCpfNps: TMaskEditC_G_C_
      Tag = 99
      Left = 68
      Top = 47
      Width = 138
      Height = 22
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 1
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskTelNps: TMaskEditFocus
      Tag = 99
      Left = 68
      Top = 77
      Width = 138
      Height = 22
      EditMask = '(99)9999-9999;0;_'
      MaxLength = 13
      TabOrder = 2
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 167
    Width = 244
    TabOrder = 2
    ExplicitTop = 167
    ExplicitWidth = 244
    inherited pnlNomeForm: TPanel
      Left = 73
      ExplicitLeft = 73
    end
    inherited pnlInfo: TPanel
      Width = 73
      ExplicitWidth = 73
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 16
  end
end
