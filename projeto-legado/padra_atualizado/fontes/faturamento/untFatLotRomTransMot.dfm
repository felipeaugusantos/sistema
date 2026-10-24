inherited frmFatLotRomTransMot: TfrmFatLotRomTransMot
  Left = 359
  Top = 419
  Width = 500
  Height = 221
  BorderIcons = [biSystemMenu]
  Caption = 'Fechamento do Romaneio'
  Position = poMainFormCenter
  ExplicitWidth = 500
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 148
    Width = 494
    ExplicitTop = 148
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 336
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 336
    end
    inherited btnSair: TBitBtnLocked
      Left = 415
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 415
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 176
    Width = 494
    ExplicitTop = 176
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 494
    Height = 148
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object lblTransp: TLabel
      Left = 6
      Top = 44
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object lblMotorista: TLabel
      Left = 37
      Top = 90
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motorista:'
    end
    object Label1: TLabel
      Left = 46
      Top = 67
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object Label2: TLabel
      Left = 32
      Top = 19
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 87
      Top = 40
      Width = 74
      Height = 23
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomTra: TEditFocus
      Left = 163
      Top = 41
      Width = 322
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
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 87
      Top = 87
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 163
      Top = 87
      Width = 322
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object mskPlaVei: TMaskEditFocus
      Tag = 99
      Left = 87
      Top = 63
      Width = 74
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      EditMask = 'lll-9999;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = ''
      OnKeyPress = mskPlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesVei: TEditFocus
      Left = 163
      Top = 64
      Width = 322
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
    object edtDesLot: TEditFocus
      Tag = 99
      Left = 87
      Top = 16
      Width = 398
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object pnlBoxLot: TPanel
      Left = 2
      Top = 109
      Width = 489
      Height = 24
      BevelOuter = bvNone
      TabOrder = 7
      object Label3: TLabel
        Left = 60
        Top = 7
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'Box:'
      end
      object edtBoxLot: TEditFocus
        Tag = 99
        Left = 85
        Top = 2
        Width = 398
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 30
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 30
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
end
