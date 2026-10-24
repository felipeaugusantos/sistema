inherited frmRcxDigDadConsumidor: TfrmRcxDigDadConsumidor
  Width = 490
  Height = 285
  Caption = 'Dados do Consumidor'
  Position = poMainFormCenter
  ExplicitWidth = 490
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 212
    Width = 484
    ExplicitTop = 212
    ExplicitWidth = 484
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 326
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitTop = 2
      ExplicitWidth = 326
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 405
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 405
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
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 484
    Height = 212
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 67
      Top = 37
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 48
      Top = 60
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label3: TLabel
      Left = 65
      Top = 83
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label5: TLabel
      Left = 320
      Top = 129
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone:'
    end
    object Label6: TLabel
      Left = 74
      Top = 129
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label7: TLabel
      Left = 364
      Top = 106
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label9: TLabel
      Left = 21
      Top = 14
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = '1-CNPJ / 2-CPF:'
    end
    object lblIncEst: TLabel
      Left = 273
      Top = 152
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'Inscri'#231#227'o Estadual:'
      Visible = False
    end
    object lblRg: TLabel
      Left = 79
      Top = 152
      Width = 18
      Height = 14
      Alignment = taRightJustify
      Caption = 'RG:'
    end
    object lbl1: TLabel
      Left = 66
      Top = 175
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'E-mail:'
    end
    object Label4: TLabel
      Left = 61
      Top = 106
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 102
      Top = 33
      Width = 364
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEndere: TEditFocus
      Tag = 99
      Left = 102
      Top = 56
      Width = 364
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 102
      Top = 79
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskTelCon: TMaskEditFocus
      Tag = 99
      Left = 369
      Top = 125
      Width = 97
      Height = 22
      EditMask = '(99)9999-9999;0;_'
      MaxLength = 13
      TabOrder = 9
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskNumCep: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 125
      Width = 64
      Height = 22
      EditMask = '99999-999;0;_'
      MaxLength = 9
      TabOrder = 8
      Text = ''
      OnKeyPress = mskNumCepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCgcCpf: TEditFocus
      Tag = 99
      Left = 102
      Top = 10
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      OnChange = edtCgcCpfChange
      OnExit = edtCgcCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtInsEst: TEditFocus
      Tag = 99
      Left = 369
      Top = 148
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 20
      TabOrder = 11
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 404
      Top = 102
      Width = 62
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRgCli: TEditFocus
      Left = 102
      Top = 148
      Width = 163
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskNumCgc: TMaskEditFocus
      Tag = 99
      Left = 141
      Top = 10
      Width = 134
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 1
      Text = ''
      OnKeyPress = mskNumCgcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 102
      Top = 171
      Width = 364
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecLowerCase
      MaxLength = 40
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 103
      Top = 102
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 167
      Top = 102
      Width = 191
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
  end
  inherited pnlStatus: TPanel
    Top = 240
    Width = 484
    ExplicitTop = 240
    ExplicitWidth = 484
    inherited pnlNomeForm: TPanel
      Left = 313
      ExplicitLeft = 313
    end
    inherited pnlInfo: TPanel
      Width = 313
      ExplicitWidth = 313
    end
  end
end
