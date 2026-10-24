inherited frmConsertoEquipFinalizacao: TfrmConsertoEquipFinalizacao
  Width = 437
  Height = 209
  Caption = 'Conserto de Equipamentos - Finaliza'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 437
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 136
    Width = 431
    TabOrder = 2
    ExplicitTop = 136
    ExplicitWidth = 431
    inherited FlwBotoes: TFlowPanel
      Width = 427
      ExplicitWidth = 427
      object btnConfirma: TBitBtnLocked
        Tag = 99
        Left = 0
        Top = 0
        Width = 77
        Height = 21
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
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 348
      ExplicitLeft = 348
    end
  end
  inherited pnlStatus: TPanel
    Top = 164
    Width = 431
    TabOrder = 3
    ExplicitTop = 164
    ExplicitWidth = 431
    inherited pnlNomeForm: TPanel
      Left = 260
      ExplicitLeft = 260
    end
    inherited pnlInfo: TPanel
      Width = 260
      ExplicitWidth = 260
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 29
    Width = 431
    Height = 107
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lblReaPor: TLabel
      Left = 10
      Top = 31
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Retirado por:'
    end
    object Label1: TLabel
      Left = 28
      Top = 81
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone:'
    end
    object Label2: TLabel
      Left = 205
      Top = 81
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Retirada:'
    end
    object lblRea_RG: TLabel
      Left = 54
      Top = 56
      Width = 18
      Height = 14
      Alignment = taRightJustify
      Caption = 'RG:'
    end
    object lblLocFis: TLabel
      Left = 17
      Top = 6
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. F'#237'sica:'
    end
    object edtReaPor: TEditFocus
      Tag = 99
      Left = 74
      Top = 28
      Width = 345
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object mskReaTel: TMaskEditTelefone
      Tag = 99
      Left = 74
      Top = 78
      Width = 93
      Height = 22
      CharCase = ecUpperCase
      EditMask = '!\(99\)9999-9999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
      Pais = opcBrasil
    end
    object mskSitDtr: TMaskEditFocus
      Tag = 99
      Left = 289
      Top = 78
      Width = 77
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtRea_RG: TEditFocus
      Tag = 99
      Left = 74
      Top = 53
      Width = 93
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Left = 74
      Top = 3
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLoc: TEditFocus
      Tag = 99
      Left = 74
      Top = 3
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesLoc: TEditFocus
      Left = 124
      Top = 3
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
  end
  object pnlDigitador: TPanel [3]
    Left = 0
    Top = 0
    Width = 431
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      431
      29)
    object lblDigita: TLabel
      Left = 27
      Top = 12
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 74
      Top = 7
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 120
      Top = 7
      Width = 299
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 0
  end
end
