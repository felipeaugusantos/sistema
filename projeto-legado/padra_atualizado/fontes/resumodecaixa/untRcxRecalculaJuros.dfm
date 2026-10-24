inherited frmRcxRecalculaJuros: TfrmRcxRecalculaJuros
  Left = 249
  Top = 214
  Width = 285
  Height = 149
  Caption = 'Recalculo do Juros'
  Position = poMainFormCenter
  ExplicitWidth = 285
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 80
    Width = 279
    Height = 24
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 80
    ExplicitWidth = 279
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 126
      Height = 20
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 275
      ExplicitHeight = 26
    end
    inherited btnSair: TBitBtnLocked
      Left = 200
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 197
      ExplicitTop = 5
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
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitHeight = 22
    end
  end
  inherited pgcDados: TPageControl
    Width = 279
    Height = 80
    TabOrder = 2
    ExplicitWidth = 279
    ExplicitHeight = 74
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 271
      ExplicitHeight = 42
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 279
    Height = 80
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 74
    object Label6: TLabel
      Left = 12
      Top = 18
      Width = 171
      Height = 14
      Caption = 'Percentual para recalculo do Juros:'
    end
    object Label1: TLabel
      Left = 12
      Top = 46
      Width = 169
      Height = 14
      Caption = 'Percentual para recalculo da Multa:'
    end
    object edtPerJur: TEditFocus
      Tag = 99
      Left = 189
      Top = 15
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnEnter = edtPerJurEnter
      OnExit = edtPerJurExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPerMul: TEditFocus
      Tag = 99
      Left = 189
      Top = 43
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
      OnEnter = edtPerJurEnter
      OnExit = edtPerJurExit
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
    Top = 104
    Width = 279
    TabOrder = 3
    ExplicitTop = 104
    ExplicitWidth = 279
    inherited pnlNomeForm: TPanel
      Left = 130
      Width = 149
      ExplicitLeft = 130
      ExplicitWidth = 149
    end
    inherited pnlInfo: TPanel
      Width = 130
      ExplicitWidth = 130
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 48
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 327
    Top = 45
  end
end
