inherited frmBaixaAnaliticaCheqRepasse: TfrmBaixaAnaliticaCheqRepasse
  Left = 427
  Top = 270
  Width = 400
  Height = 232
  Caption = 'Baixa Anal'#237'tica'
  Position = poMainFormCenter
  ExplicitWidth = 400
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 159
    Width = 394
    TabOrder = 1
    ExplicitTop = 159
    ExplicitWidth = 394
    DesignSize = (
      394
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 390
      TabOrder = 2
      ExplicitWidth = 390
    end
    inherited btnSair: TBitBtnLocked
      Left = 311
      ExplicitLeft = 311
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 4
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
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 394
    Height = 159
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblPorDeb: TLabel
      Left = 41
      Top = 26
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label6: TLabel
      Left = 5
      Top = 5
      Width = 375
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'D'#201'BITO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 85
      Width = 375
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'CR'#201'DITO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPorCred: TLabel
      Left = 40
      Top = 107
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object edtCodPorDeb: TEditFocus
      Left = 152
      Top = 23
      Width = 223
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorDeb: TEditFocus
      Tag = 99
      Left = 88
      Top = 23
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtPorDebKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtPorCred: TEditFocus
      Tag = 99
      Left = 88
      Top = 104
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtPorCredKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodPorCred: TEditFocus
      Left = 152
      Top = 104
      Width = 223
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit
      Left = 5
      Top = 47
      Width = 375
      Height = 22
      TabOrder = 1
      ExplicitLeft = 5
      ExplicitTop = 47
      ExplicitWidth = 375
      inherited lblPlaContas: TLabel
        Left = -1
        Width = 81
        Height = 14
        ExplicitLeft = -1
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 147
        Width = 223
        Height = 22
        ExplicitLeft = 147
        ExplicitWidth = 223
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 83
        Width = 64
        Height = 22
        OnKeyPress = fraPlanoDeContasDebMskCodCtaKeyPress
        ExplicitLeft = 83
        ExplicitWidth = 64
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContasCre: TfraPlanoDeContasMskEdit
      Left = 4
      Top = 128
      Width = 376
      Height = 22
      TabOrder = 5
      ExplicitLeft = 4
      ExplicitTop = 128
      ExplicitWidth = 376
      inherited lblPlaContas: TLabel
        Left = 0
        Width = 81
        Height = 14
        ExplicitLeft = 0
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 148
        Width = 223
        Height = 22
        ExplicitLeft = 148
        ExplicitWidth = 223
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 84
        Width = 64
        Height = 22
        OnKeyPress = fraPlanoDeContasCreMskCodCtaKeyPress
        ExplicitLeft = 84
        ExplicitWidth = 64
        ExplicitHeight = 22
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 394
    TabOrder = 2
    ExplicitTop = 187
    ExplicitWidth = 394
    inherited pnlNomeForm: TPanel
      Left = 223
      ExplicitLeft = 223
    end
    inherited pnlInfo: TPanel
      Width = 223
      ExplicitWidth = 223
    end
  end
end
