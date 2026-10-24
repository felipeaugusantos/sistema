inherited frmFatDigDadosUsoConsumo: TfrmFatDigDadosUsoConsumo
  Height = 179
  Caption = 'Dados para Uso / Consumo'
  Position = poScreenCenter
  ExplicitHeight = 179
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    ExplicitTop = 93
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 325
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 325
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 404
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
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
    Top = 134
    ExplicitTop = 121
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 106
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 93
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 1
      Top = 30
      Width = 481
      Height = 23
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 31
      ExplicitWidth = 481
      ExplicitHeight = 23
      inherited lblPlaContas: TLabel
        Left = 4
        Top = 3
        Width = 81
        Height = 14
        ExplicitLeft = 4
        ExplicitTop = 3
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 161
        Width = 306
        Height = 22
        ExplicitLeft = 161
        ExplicitWidth = 306
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 88
        Width = 72
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 88
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
    end
    object pnlForncedor: TPanel
      Left = 1
      Top = 1
      Width = 481
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 26
        Top = 9
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 88
        Top = 6
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 161
        Top = 6
        Width = 306
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    end
    object pnlEvento: TPanel
      Left = 1
      Top = 53
      Width = 481
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 55
      object lblEvento: TLabel
        Left = 49
        Top = 3
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Evento:'
      end
      object edtCodEve: TEditFocus
        Tag = 99
        Left = 88
        Top = 0
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = edtCodEveKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesEve: TEditFocus
        Left = 161
        Top = 0
        Width = 306
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    end
    object Panel1: TPanel
      Left = 1
      Top = 75
      Width = 481
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 3
      object Label2: TLabel
        Left = 40
        Top = 4
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object edtHistor: TEditFocus
        Left = 88
        Top = 1
        Width = 379
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 50
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
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 104
  end
end
