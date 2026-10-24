inherited frmNfeInutilizacao: TfrmNfeInutilizacao
  Width = 548
  Height = 209
  Caption = 'Inutiliza'#231#227'o de Notas'
  Position = poOwnerFormCenter
  ExplicitWidth = 548
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 16
    Width = 73
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Ano:'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 40
    Width = 73
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'S'#233'rie:'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 64
    Width = 73
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'N'#250'mero inicial:'
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 88
    Width = 73
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'N'#250'mero final:'
  end
  object Label5: TLabel [4]
    Left = 8
    Top = 112
    Width = 73
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Motivo:'
  end
  inherited pnlBotoes: TPanel
    Top = 136
    Width = 542
    ExplicitTop = 136
    ExplicitWidth = 542
    DesignSize = (
      542
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 538
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      ExplicitLeft = 459
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
  object edtAno: TEditFocus [7]
    Tag = 99
    Left = 87
    Top = 8
    Width = 66
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 4
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object edtSerie: TEditFocus [8]
    Tag = 99
    Left = 87
    Top = 32
    Width = 66
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object edtDocumentoInicial: TEditFocus [9]
    Tag = 99
    Left = 87
    Top = 56
    Width = 82
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 12
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object edtDocumentoFinal: TEditFocus [10]
    Tag = 99
    Left = 87
    Top = 80
    Width = 82
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 12
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object edtMotivo: TEditFocus [11]
    Tag = 99
    Left = 87
    Top = 104
    Width = 445
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 250
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 164
    Width = 542
    ExplicitTop = 164
    ExplicitWidth = 542
    inherited pnlNomeForm: TPanel
      Left = 371
      ExplicitLeft = 371
    end
    inherited pnlInfo: TPanel
      Width = 371
      ExplicitWidth = 371
    end
  end
end
