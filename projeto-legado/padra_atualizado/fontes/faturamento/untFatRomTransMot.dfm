inherited frmFatRomTransMot: TfrmFatRomTransMot
  Left = 359
  Top = 419
  Width = 582
  Height = 340
  BorderIcons = [biSystemMenu]
  Caption = 'Fechamento do Romaneio'
  Position = poMainFormCenter
  ExplicitWidth = 582
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 271
    Width = 576
    Height = 24
    TabOrder = 1
    ExplicitTop = 271
    ExplicitWidth = 576
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 194
      Width = 303
      Height = 20
      TabOrder = 3
      ExplicitLeft = 194
      ExplicitWidth = 303
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 497
      Top = 2
      Height = 20
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 497
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 20
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
    object btnRoteiro: TBitBtnLocked
      Left = 79
      Top = 2
      Width = 115
      Height = 20
      Align = alLeft
      Caption = '[ F9 ] &Definir Roteiro'
      TabOrder = 1
      OnClick = btnRoteiroClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 576
    TabOrder = 2
    ExplicitTop = 295
    ExplicitWidth = 576
    inherited pnlNomeForm: TPanel
      Left = 405
      ExplicitLeft = 405
    end
    inherited pnlInfo: TPanel
      Width = 405
      ExplicitWidth = 405
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 576
    Height = 271
    Align = alClient
    Color = 16770261
    TabOrder = 0
    TabStop = True
    DesignSize = (
      576
      271)
    object lblTransp: TLabel
      Left = 2
      Top = 18
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object lblMotorista: TLabel
      Left = 33
      Top = 64
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motorista:'
    end
    object lblRegiao: TLabel
      Left = 44
      Top = 179
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object Label1: TLabel
      Left = 42
      Top = 41
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object lbl1: TLabel
      Left = 33
      Top = 202
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vlr. Frete:'
    end
    object lbl3: TLabel
      Left = 309
      Top = 202
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo Frete:'
    end
    object lbl4: TLabel
      Left = 446
      Top = 202
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = '% Frete:'
    end
    object lbl2: TLabel
      Left = 161
      Top = 202
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Adiantamento:'
    end
    object lbl5: TLabel
      Left = 19
      Top = 87
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajudante 01:'
    end
    object lbl6: TLabel
      Left = 19
      Top = 110
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajudante 02:'
    end
    object lblAjudante3: TLabel
      Left = 19
      Top = 133
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajudante 03:'
    end
    object lblAjudante4: TLabel
      Left = 19
      Top = 156
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajudante 04:'
    end
    object lblObs: TLabel
      Left = 17
      Top = 225
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 83
      Top = 15
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
      TabOrder = 0
      OnKeyPress = edtCodTraKeyPress
      OnKeyUp = edtCodTraKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomTra: TEditFocus
      Left = 159
      Top = 15
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 83
      Top = 61
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtCodMotKeyPress
      OnKeyUp = edtCodMotKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 159
      Top = 61
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 83
      Top = 176
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 14
      OnKeyPress = edtCodRegKeyPress
      OnKeyUp = edtCodRegKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesReg: TEditFocus
      Left = 159
      Top = 176
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 15
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
      Left = 83
      Top = 38
      Width = 74
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      EditMask = 'aaa-9a99;0;_'
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
      TabOrder = 2
      Text = ''
      OnKeyPress = mskPlaVeiKeyPress
      OnKeyUp = mskPlaVeiKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesVei: TEditFocus
      Left = 159
      Top = 38
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVlrFrete: TEditFocus
      Tag = 99
      Left = 83
      Top = 199
      Width = 74
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 16
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,0.00'
    end
    object edtVlrAdiant: TEditFocus
      Tag = 99
      Left = 232
      Top = 199
      Width = 74
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 17
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,0.00'
    end
    object edtVlrSaldo: TEditFocus
      Tag = 99
      Left = 369
      Top = 199
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 18
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,0.00'
    end
    object edtPercFrete: TEditFocus
      Tag = 99
      Left = 489
      Top = 199
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 19
      Text = '0,0000'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,0.0000'
    end
    object edtCodAj1: TEditFocus
      Tag = 99
      Left = 83
      Top = 84
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 6
      OnKeyPress = edtCodAj1KeyPress
      OnKeyUp = edtCodAj1KeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomAj1: TEditFocus
      Left = 159
      Top = 84
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodAj2: TEditFocus
      Tag = 99
      Left = 83
      Top = 107
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 8
      OnKeyPress = edtCodAj2KeyPress
      OnKeyUp = edtCodAj2KeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomAj2: TEditFocus
      Left = 159
      Top = 107
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAj3: TEditFocus
      Tag = 99
      Left = 83
      Top = 130
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 10
      OnKeyPress = edtCodAj3KeyPress
      OnKeyUp = edtCodAj3KeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomAj3: TEditFocus
      Left = 159
      Top = 130
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAj4: TEditFocus
      Tag = 99
      Left = 83
      Top = 153
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 12
      OnKeyPress = edtCodAj4KeyPress
      OnKeyUp = edtCodAj4KeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomAj4: TEditFocus
      Left = 159
      Top = 153
      Width = 404
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mmoObsFec: TMemoFocus
      Tag = 99
      Left = 83
      Top = 222
      Width = 480
      Height = 45
      Anchors = [akLeft, akTop, akBottom]
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      ParentFont = False
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
end
