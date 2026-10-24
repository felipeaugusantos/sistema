inherited frmAltNumLote: TfrmAltNumLote
  Width = 445
  Height = 175
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o do N'#250'mero do Lote'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 445
  ExplicitHeight = 175
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 102
    Width = 439
    Height = 28
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 102
    ExplicitWidth = 439
    ExplicitHeight = 28
    DesignSize = (
      439
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 435
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 358
      Top = 3
      ExplicitLeft = 358
      ExplicitTop = 3
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
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
  inherited pnlStatus: TPanel
    Top = 130
    Width = 439
    TabOrder = 3
    ExplicitTop = 130
    ExplicitWidth = 439
    inherited pnlNomeForm: TPanel
      Left = 268
      ExplicitLeft = 268
    end
    inherited pnlInfo: TPanel
      Width = 268
      ExplicitWidth = 268
    end
  end
  inherited pgcDados: TPageControl
    Width = 439
    Height = 102
    TabOrder = 2
    ExplicitWidth = 439
    ExplicitHeight = 102
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 431
      ExplicitHeight = 70
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 439
    Height = 102
    Align = alClient
    ParentColor = True
    TabOrder = 0
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    object lblLotAtu: TLabel
      Left = 8
      Top = 46
      Width = 48
      Height = 14
      Caption = 'Lote Atual'
    end
    object lblLotNov: TLabel
      Left = 229
      Top = 46
      Width = 49
      Height = 14
      Caption = 'Novo Lote'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 59
      Top = 22
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLotAtu: TEditFocus
      Tag = 99
      Left = 8
      Top = 60
      Width = 200
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 2
      OnKeyPress = edtLotAtuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object edtLotNov: TEditFocus
      Tag = 99
      Left = 229
      Top = 60
      Width = 200
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 8
  end
end
