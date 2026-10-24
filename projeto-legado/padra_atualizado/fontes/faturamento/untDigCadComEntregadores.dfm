inherited frmDigCadComEntregadores: TfrmDigCadComEntregadores
  Width = 350
  Height = 215
  ActiveControl = edtImpCom
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 350
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 142
    Width = 344
    TabOrder = 1
    ExplicitTop = 92
    ExplicitWidth = 344
    DesignSize = (
      344
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 340
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 340
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 262
      ExplicitLeft = 262
    end
    object btnConfirma: TBitBtnLocked
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
      OnClick = btnConfirmaClick
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 344
    Height = 142
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 92
    object lblFinPed: TLabel
      Left = 21
      Top = 16
      Width = 164
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Imprimir Comprovante de Entrega?'
    end
    object ColorLabel2: TColorLabel
      Left = 215
      Top = 16
      Width = 58
      Height = 14
      Caption = '(S)im  (N)'#227'o'
      CorDestaque = clRed
    end
    object lbl1: TLabel
      Left = 21
      Top = 40
      Width = 164
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Imprimir Endere'#231'o de Entrega?'
    end
    object ColorLabel1: TColorLabel
      Left = 215
      Top = 40
      Width = 58
      Height = 14
      Caption = '(S)im  (N)'#227'o'
      CorDestaque = clRed
    end
    object Label1: TLabel
      Left = 21
      Top = 61
      Width = 164
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Imprimir Assinatura:'
    end
    object ColorLabel3: TColorLabel
      Left = 215
      Top = 62
      Width = 58
      Height = 14
      Caption = '(S)im  (N)'#227'o'
      CorDestaque = clRed
    end
    object edtImpCom: TEditFocus
      Tag = 99
      Left = 191
      Top = 12
      Width = 21
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 0
      Text = 'S'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtImpEnd: TEditFocus
      Tag = 99
      Left = 191
      Top = 36
      Width = 21
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 1
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtImpAss: TEditFocus
      Tag = 99
      Left = 191
      Top = 59
      Width = 21
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 2
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object rdgTipImp: TRadioGroup
      Tag = 99
      Left = 18
      Top = 83
      Width = 185
      Height = 49
      Caption = 'Tipo de impress'#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Paisagem'
        'Retrato')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 170
    Width = 344
    TabOrder = 2
    ExplicitTop = 120
    ExplicitWidth = 344
    inherited pnlNomeForm: TPanel
      Left = 173
      ExplicitLeft = 173
    end
    inherited pnlInfo: TPanel
      Width = 173
      ExplicitWidth = 173
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 8
  end
end
