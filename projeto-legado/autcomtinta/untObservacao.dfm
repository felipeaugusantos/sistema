inherited frmObservacao: TfrmObservacao
  Width = 450
  Height = 288
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 450
  ExplicitHeight = 288
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 215
    Width = 444
    ExplicitTop = 215
    ExplicitWidth = 444
    DesignSize = (
      444
      28)
    inherited btnSair: TBitBtnLocked
      Left = 340
      Width = 100
      Caption = '[ ESC ] &Sair'
      TabOrder = 2
      ExplicitLeft = 340
      ExplicitWidth = 100
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 7
      Top = 3
      Width = 90
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
      Visible = False
      OnClick = btnConfirmaDadosClick
    end
    object btnClipBoard: TBitBtnLocked
      Left = 112
      Top = 3
      Width = 221
      Height = 22
      Caption = 'Copiar texto para '#225'rea de transfer'#234'ncia'
      TabOrder = 1
      Visible = False
      OnClick = btnClipBoardClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 243
    Width = 444
    TabOrder = 2
    ExplicitTop = 243
    ExplicitWidth = 444
    inherited pnlNomeForm: TPanel
      Left = 273
      ExplicitLeft = 273
    end
    inherited pnlInfo: TPanel
      Width = 273
      Caption = 'Pressione < ESC> para sair...'
      ExplicitWidth = 273
    end
  end
  object pnlMensagem: TPanel [3]
    Left = 0
    Top = 0
    Width = 444
    Height = 14
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 11
    Padding.Right = 10
    ParentColor = True
    TabOrder = 3
    object lblMensagem: TLabel
      Left = 11
      Top = 0
      Width = 423
      Height = 14
      Align = alTop
      Caption = 'lblMensagem'
      ExplicitWidth = 62
    end
  end
  object pnlTexto: TPanel [4]
    Left = 0
    Top = 14
    Width = 444
    Height = 201
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlTexto'
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentColor = True
    TabOrder = 4
    object memObs: TMemoFocus
      Left = 10
      Top = 0
      Width = 424
      Height = 191
      Align = alClient
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyDown = memObsKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 80
  end
end
