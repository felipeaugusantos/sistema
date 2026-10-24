inherited frmBaixaProfiss: TfrmBaixaProfiss
  Left = 418
  Top = 364
  Width = 401
  Height = 237
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Comiss'#227'o de Profissionais'
  Position = poScreenCenter
  ExplicitWidth = 401
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 29
    Top = 42
    Width = 59
    Height = 14
    Alignment = taRightJustify
    Caption = 'Fornecedor:'
  end
  object Label3: TLabel [1]
    Left = 42
    Top = 138
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Hist'#243'rico:'
  end
  object Label4: TLabel [2]
    Left = 44
    Top = 66
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Portador:'
  end
  object Label28: TLabel [3]
    Left = 52
    Top = 90
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'Evento:'
  end
  inherited pnlBotoes: TPanel
    Top = 164
    Width = 395
    TabOrder = 9
    ExplicitTop = 164
    ExplicitWidth = 395
    DesignSize = (
      395
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 391
      TabOrder = 2
      ExplicitWidth = 391
    end
    inherited btnSair: TBitBtnLocked
      Left = 312
      ModalResult = 2
      ExplicitLeft = 312
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
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 192
    Width = 395
    TabOrder = 10
    ExplicitTop = 192
    ExplicitWidth = 395
    inherited pnlNomeForm: TPanel
      Left = 224
      ExplicitLeft = 224
    end
    inherited pnlInfo: TPanel
      Width = 224
      ExplicitWidth = 224
    end
  end
  object cbxLanCTP: TCheckBox [6]
    Left = 8
    Top = 15
    Width = 149
    Height = 17
    Alignment = taLeftJustify
    Caption = ' Lan'#231'ar no Contas a Pagar '
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = cbxLanCTPClick
  end
  object edtCodFor: TEditFocus [7]
    Tag = 99
    Left = 94
    Top = 38
    Width = 62
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 8
    TabOrder = 1
    OnKeyPress = edtCodForKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtNomFor: TEditFocus [8]
    Left = 158
    Top = 38
    Width = 223
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object edtHisBai: TEditFocus [9]
    Left = 94
    Top = 134
    Width = 287
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtDesPor: TEditFocus [10]
    Left = 158
    Top = 62
    Width = 223
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
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
  object edtCodPor: TEditFocus [11]
    Tag = 99
    Left = 94
    Top = 62
    Width = 62
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 5
    TabOrder = 3
    OnKeyPress = edtCodPorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtCodEve: TEditFocus [12]
    Tag = 99
    Left = 94
    Top = 86
    Width = 62
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 5
    OnKeyPress = edtCodEveKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesEve: TEditFocus [13]
    Left = 158
    Top = 86
    Width = 223
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 6
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inline fraPlanoDeContas: TfraPlanoDeContasMskEdit [14]
    Left = 7
    Top = 110
    Width = 379
    Height = 22
    TabOrder = 7
    ExplicitLeft = 7
    ExplicitTop = 110
    ExplicitWidth = 379
    inherited lblPlaContas: TLabel
      Left = 2
      Width = 81
      Height = 14
      ExplicitLeft = 2
      ExplicitWidth = 81
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 151
      Width = 223
      Height = 22
      ExplicitLeft = 151
      ExplicitWidth = 223
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Left = 87
      Width = 62
      Height = 22
      ExplicitLeft = 87
      ExplicitWidth = 62
      ExplicitHeight = 22
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 8
  end
  inherited mnuAuxiliar: TPopupMenu [16]
    Left = 304
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 8
  end
end
