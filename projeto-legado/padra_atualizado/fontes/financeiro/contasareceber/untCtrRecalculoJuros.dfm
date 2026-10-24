inherited frmCtrRecalculoJuros: TfrmCtrRecalculoJuros
  Left = 145
  Top = 234
  Width = 366
  Height = 160
  BorderIcons = [biSystemMenu]
  Caption = 'Recalculo do Juros'
  Position = poMainFormCenter
  ExplicitWidth = 366
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 360
    ExplicitTop = 87
    ExplicitWidth = 360
    DesignSize = (
      360
      28)
    inherited btnSair: TBitBtnLocked
      Left = 277
      TabOrder = 1
      ExplicitLeft = 277
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 2
      Width = 72
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
      OnClick = btnConfirmaClick
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 360
    Height = 87
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label6: TLabel
      Left = 99
      Top = 35
      Width = 84
      Height = 14
      Caption = 'Percentual Juros:'
    end
    object lblAplicar: TLabel
      Left = 88
      Top = 12
      Width = 95
      Height = 14
      Caption = 'Aplicar Juros/Multa:'
    end
    object ColorLabel1: TColorLabel
      Left = 239
      Top = 12
      Width = 98
      Height = 14
      Caption = '(T)odas (D)up. Atual'
      CorDestaque = clRed
    end
    object lblPerMul: TLabel
      Left = 101
      Top = 58
      Width = 82
      Height = 14
      Caption = 'Percentual Multa:'
    end
    object edtPerJur: TEditFocus
      Tag = 99
      Left = 187
      Top = 32
      Width = 46
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
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAplJur: TEditFocus
      Tag = 99
      Left = 187
      Top = 9
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtPerMul: TEditFocus
      Tag = 99
      Left = 187
      Top = 55
      Width = 46
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
      TabOrder = 2
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
    Top = 115
    Width = 360
    ExplicitTop = 115
    ExplicitWidth = 360
    inherited pnlNomeForm: TPanel
      Left = 189
      ExplicitLeft = 189
    end
    inherited pnlInfo: TPanel
      Width = 189
      ExplicitWidth = 189
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 176
    Top = 108
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 108
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 108
  end
end
