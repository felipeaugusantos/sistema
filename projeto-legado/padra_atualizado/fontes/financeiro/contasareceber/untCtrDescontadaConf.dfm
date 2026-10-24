inherited frmCtrDescontadaConf: TfrmCtrDescontadaConf
  Left = 403
  Top = 305
  Width = 403
  Height = 190
  Caption = 
    'Altera'#231#227'o de Portador / Descontada / Centro de Custos / Plano de' +
    ' Contas'
  OnClose = FormClose
  ExplicitWidth = 403
  ExplicitHeight = 190
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel [0]
    Left = 28
    Top = 41
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador:'
  end
  object Label1: TLabel [1]
    Left = 11
    Top = 17
    Width = 61
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descontada:'
  end
  object ColorLabel2: TColorLabel [2]
    Left = 134
    Top = 17
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object edtDescon: TEditFocus [3]
    Tag = 99
    Left = 75
    Top = 13
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 1
    TipoTexto = ttAlfanumerico
  end
  object edtNomPor: TEditFocus [7]
    Left = 135
    Top = 37
    Width = 250
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  inline fraCentroCusto: TfraCentroCustoEditFocus [8]
    Left = -19
    Top = 61
    Width = 414
    Height = 22
    TabOrder = 3
    ExplicitLeft = -19
    ExplicitTop = 61
    ExplicitWidth = 414
    inherited lblEventos: TLabel
      Left = 35
      Width = 56
      Height = 14
      Caption = 'Ctr. Custos:'
      ExplicitLeft = 35
      ExplicitWidth = 56
      ExplicitHeight = 14
    end
    inherited edtCodEve: TEditFocus
      Width = 57
      Height = 22
      OnExit = fraCentroCustoedtCodEveExit
      ExplicitWidth = 57
      ExplicitHeight = 22
    end
    inherited edtDesEve: TEditFocus
      Left = 154
      Width = 250
      Height = 22
      ExplicitLeft = 154
      ExplicitWidth = 250
      ExplicitHeight = 22
    end
  end
  object edtCodPor: TEditFocus [6]
    Tag = 99
    Left = 75
    Top = 37
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 1
    OnExit = edtCodPorExit
    OnKeyPress = edtCodPorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  inherited pnlBotoes: TPanel [8]
    Top = 119
    Width = 397
    Height = 26
    TabOrder = 6
    ExplicitTop = 119
    ExplicitWidth = 397
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 107
      Width = 188
      Height = 22
      TabOrder = 2
      ExplicitLeft = 107
      ExplicitWidth = 188
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 295
      Top = 2
      Width = 100
      Align = alRight
      ExplicitLeft = 295
      ExplicitTop = 2
      ExplicitWidth = 100
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 105
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
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
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel [9]
    Top = 145
    Width = 397
    TabOrder = 7
    ExplicitTop = 145
    ExplicitWidth = 397
    inherited pnlNomeForm: TPanel
      Left = 226
      ExplicitLeft = 226
    end
    inherited pnlInfo: TPanel
      Width = 226
      ExplicitWidth = 226
    end
  end
  inline fraPlanoDeContas: TfraPlanoDeContasMskEdit [10]
    Left = 6
    Top = 85
    Width = 383
    Height = 22
    TabOrder = 4
    ExplicitLeft = 6
    ExplicitTop = 85
    ExplicitWidth = 383
    inherited lblPlaContas: TLabel
      Left = 0
      Width = 66
      Height = 14
      Caption = 'Plano Contas:'
      ExplicitLeft = 0
      ExplicitWidth = 66
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 129
      Width = 250
      Height = 22
      ExplicitLeft = 129
      ExplicitWidth = 250
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Left = 69
      Width = 57
      Height = 22
      OnExit = fraPlanoDeContasMskCodCtaExit
      OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
      ExplicitLeft = 69
      ExplicitWidth = 57
      ExplicitHeight = 22
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 8
  end
  inherited mnuAuxiliar: TPopupMenu [14]
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade [15]
  end
end
