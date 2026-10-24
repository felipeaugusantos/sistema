inherited frmGNREGuiasPorApuracaoDados: TfrmGNREGuiasPorApuracaoDados
  Width = 264
  Height = 196
  BorderStyle = bsDialog
  Caption = 'Dados do Registro'
  Position = poOwnerFormCenter
  ExplicitWidth = 264
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 29
    Top = 66
    Width = 84
    Height = 14
    Caption = 'Data Vencimento:'
  end
  object Label3: TLabel [1]
    Left = 32
    Top = 94
    Width = 81
    Height = 14
    Caption = 'Data Pagamento:'
  end
  object Label168: TLabel [2]
    Left = 96
    Top = 13
    Width = 16
    Height = 14
    Alignment = taRightJustify
    Caption = 'UF:'
  end
  object Label1: TLabel [3]
    Left = 59
    Top = 39
    Width = 54
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tp.Receita:'
  end
  inherited pnlBotoes: TPanel
    Top = 123
    Width = 258
    TabOrder = 2
    ExplicitTop = 86
    ExplicitWidth = 282
    inherited FlwBotoes: TFlowPanel
      Width = 254
      ExplicitWidth = 278
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F10] Confirma'
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
    inherited btnSair: TBitBtnLocked
      Left = 144
      Top = 2
      Width = 110
      Caption = '[ESC] Cancela'
      ExplicitLeft = 115
      ExplicitTop = 2
      ExplicitWidth = 110
    end
  end
  inherited pnlStatus: TPanel
    Top = 151
    Width = 258
    TabOrder = 3
    ExplicitTop = 114
    ExplicitWidth = 282
    inherited pnlNomeForm: TPanel
      Left = 87
      ExplicitLeft = 111
    end
    inherited pnlInfo: TPanel
      Width = 87
      ExplicitWidth = 111
    end
  end
  object mskDtaVen: TMaskEditFocus [6]
    Tag = 99
    Left = 120
    Top = 63
    Width = 80
    Height = 22
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaPag: TMaskEditFocus [7]
    Tag = 99
    Left = 120
    Top = 91
    Width = 80
    Height = 22
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtEstado: TEditFocus [8]
    Tag = 99
    Left = 120
    Top = 10
    Width = 36
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16770261
    MaxLength = 20
    ReadOnly = True
    TabOrder = 4
    NormalColor = 16770261
    FocusColor = 16770261
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 20
    TipoTexto = ttAlfanumerico
  end
  object edtTipRec: TEditFocus [9]
    Tag = 99
    Left = 120
    Top = 36
    Width = 80
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16770261
    MaxLength = 20
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16770261
    FocusColor = 16770261
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 20
    TipoTexto = ttAlfanumerico
  end
end
