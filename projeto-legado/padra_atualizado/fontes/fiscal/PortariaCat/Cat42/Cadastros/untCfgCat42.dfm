inherited frmCfgCat42: TfrmCfgCat42
  Width = 516
  Height = 199
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o Cat - 42'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 516
  ExplicitHeight = 199
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 124
    Width = 510
    Height = 30
    TabOrder = 1
    ExplicitTop = 124
    ExplicitWidth = 510
    ExplicitHeight = 30
    inherited btnSair: TBitBtn
      Left = 418
      Top = 2
      Width = 90
      Height = 26
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 418
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 26
    end
    object btnConfirma: TBitBtn
      Left = 2
      Top = 2
      Width = 90
      Height = 26
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 154
    Width = 510
    TabOrder = 0
    ExplicitTop = 154
    ExplicitWidth = 510
    inherited pnlNomeForm: TPanel
      Left = 339
      ExplicitLeft = 339
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
      inherited btnShowTrace: TSpeedButton
        Left = 337
      end
      inherited btnHideTrace: TSpeedButton
        Left = 337
      end
    end
  end
  object pnlCfgCat42: TPanel [2]
    Left = 0
    Top = 0
    Width = 510
    Height = 124
    Align = alClient
    TabOrder = 2
    object Label272: TLabel
      Left = 45
      Top = 17
      Width = 119
      Height = 14
      Caption = 'Pre'#231'o Invent'#225'rio sem ST:'
    end
    object LabelCat42ComST: TLabel
      Left = 45
      Top = 45
      Width = 119
      Height = 14
      Caption = 'Pre'#231'o Invent'#225'rio com ST:'
    end
    object cmbPrecoInvCat42: TComboBox
      Left = 168
      Top = 14
      Width = 316
      Height = 22
      ItemIndex = 0
      TabOrder = 0
      Text = 'Compra l'#237'quido (PRECOM l'#237'quido)'
      Items.Strings = (
        'Compra l'#237'quido (PRECOM l'#237'quido)'
        #218'ltima Compra mais impostos l'#237'quido (IMPULT l'#237'quido)'
        'Compra (PRECOM)'
        #218'ltima Compra mais impostos (IMPULT)'
        #218'ltima Compra sem impostos (PREULT)')
    end
    object cmbPrecoInvCat42ComST: TComboBox
      Left = 169
      Top = 42
      Width = 316
      Height = 22
      ItemIndex = 0
      TabOrder = 1
      Text = 'Compra l'#237'quido (PRECOM l'#237'quido)'
      Items.Strings = (
        'Compra l'#237'quido (PRECOM l'#237'quido)'
        #218'ltima Compra mais impostos l'#237'quido (IMPULT l'#237'quido)'
        'Compra (PRECOM)'
        #218'ltima Compra mais impostos (IMPULT)'
        #218'ltima Compra sem impostos (PREULT)')
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 112
  end
end
