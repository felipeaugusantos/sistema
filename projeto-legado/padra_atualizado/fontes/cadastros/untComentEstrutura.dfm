inherited frmComentEstrutura: TfrmComentEstrutura
  Left = 328
  Top = 234
  Width = 517
  Height = 158
  BorderIcons = [biSystemMenu]
  Caption = 'Coment'#225'rio'
  Position = poMainFormCenter
  ExplicitWidth = 517
  ExplicitHeight = 158
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 511
    Height = 26
    ExplicitTop = 87
    ExplicitWidth = 511
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 88
      Width = 344
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 507
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 432
      Top = 2
      Align = alRight
      ExplicitLeft = 428
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 86
      Height = 22
      Align = alLeft
      Caption = '&Confirmar'
      Enabled = False
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
      OnClick = btnConfirmarClick
      ExplicitLeft = 6
      ExplicitTop = 3
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 511
    Height = 87
    Align = alClient
    Color = 16770261
    TabOrder = 2
    ExplicitHeight = 79
    object Label1: TLabel
      Left = 31
      Top = 10
      Width = 57
      Height = 14
      Caption = 'Coment'#225'rio:'
    end
    object edtComentario: TEditFocus
      Left = 90
      Top = 5
      Width = 405
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      OnKeyPress = edtComentarioKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object pnlIndustrial: TPanel
      Left = 1
      Top = 29
      Width = 509
      Height = 49
      BevelOuter = bvNone
      TabOrder = 1
      object Label7: TLabel
        Left = 60
        Top = 4
        Width = 27
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fase:'
      end
      object Label17: TLabel
        Left = 4
        Top = 28
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sequ'#234'ncia Geral:'
      end
      object edtCodFas: TEditFocus
        Tag = 99
        Left = 89
        Top = 0
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodFasKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesFas: TEditFocus
        Left = 140
        Top = 0
        Width = 354
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
      object edtSeq: TEditFocus
        Tag = 99
        Left = 89
        Top = 24
        Width = 51
        Height = 22
        Hint = 'N'#227'o Informe a Sequ'#234'ncia para Inserir ao Final da F'#243'rmula'
        Alignment = taRightJustify
        Color = clWhite
        MaxLength = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttInteiro
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 113
    Width = 511
    ExplicitTop = 107
    ExplicitWidth = 511
    inherited pnlNomeForm: TPanel
      Left = 340
      ExplicitLeft = 340
    end
    inherited pnlInfo: TPanel
      Width = 340
      ExplicitWidth = 340
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 388
    Top = 12
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 28
  end
end
