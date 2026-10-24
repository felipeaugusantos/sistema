inherited frmRcxFecCaixa: TfrmRcxFecCaixa
  Left = 287
  Top = 268
  Width = 246
  Height = 157
  BorderIcons = [biSystemMenu]
  Caption = 'Fechamento de Caixa'
  Position = poMainFormCenter
  ExplicitWidth = 246
  ExplicitHeight = 157
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 88
    Width = 240
    Height = 24
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 88
    ExplicitWidth = 240
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 87
      Height = 20
      TabOrder = 2
      ExplicitLeft = 74
      ExplicitWidth = 87
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 161
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 161
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
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
      OnClick = btnConfirmaClick
      ExplicitLeft = -3
      ExplicitTop = 0
    end
  end
  inherited pgcDados: TPageControl
    Width = 240
    Height = 88
    TabOrder = 2
    ExplicitWidth = 240
    ExplicitHeight = 88
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 232
      ExplicitHeight = 56
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 240
    Height = 88
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 31
      Top = 19
      Width = 100
      Height = 14
      Caption = 'Senha Respons'#225'vel:'
    end
    object lblSaldoFechamento: TLabel
      Left = 24
      Top = 43
      Width = 107
      Height = 14
      Caption = 'Saldo de Fechamento:'
    end
    object lblFundoDeCaixa: TLabel
      Left = 53
      Top = 91
      Width = 78
      Height = 14
      Caption = 'Fundo de Caixa:'
      Visible = False
    end
    object edtSenRes: TEditFocus
      Tag = 99
      Left = 135
      Top = 16
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSalFec: TEditFocus
      Tag = 99
      Left = 135
      Top = 40
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 10
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object pnlLacre: TPanel
      Left = 0
      Top = 64
      Width = 239
      Height = 24
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object Label2: TLabel
        Left = 45
        Top = 3
        Width = 86
        Height = 14
        Caption = 'N'#250'mero do Lacre:'
      end
      object edtNumeroLacre: TEditFocus
        Tag = 99
        Left = 135
        Top = 0
        Width = 81
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtFundoDeCaixa: TEditFocus
      Tag = 99
      Left = 135
      Top = 88
      Width = 81
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited pnlStatus: TPanel
    Top = 112
    Width = 240
    TabOrder = 3
    ExplicitTop = 112
    ExplicitWidth = 240
    inherited pnlNomeForm: TPanel
      Left = 75
      Width = 165
      ExplicitLeft = 75
      ExplicitWidth = 165
    end
    inherited pnlInfo: TPanel
      Width = 75
      ExplicitWidth = 75
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 112
  end
end
