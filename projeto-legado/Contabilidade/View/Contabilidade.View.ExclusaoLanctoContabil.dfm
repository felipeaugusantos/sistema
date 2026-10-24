inherited frmExclusaoLanctoContabil: TfrmExclusaoLanctoContabil
  Width = 365
  Height = 326
  BorderIcons = [biSystemMenu]
  Caption = 'Exclus'#227'o de Lan'#231'amentos Cont'#225'beis'
  Position = poMainFormCenter
  ExplicitWidth = 365
  ExplicitHeight = 326
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 359
    Height = 26
    ExplicitTop = 255
    ExplicitWidth = 359
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 75
      Width = 205
      Height = 22
      TabOrder = 2
      ExplicitLeft = 75
      ExplicitWidth = 205
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 280
      Top = 2
      Align = alRight
      ExplicitLeft = 280
      ExplicitTop = 2
    end
    object btnGerar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 73
      Height = 22
      Align = alLeft
      Caption = '&Excluir'
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
      OnClick = btnGerarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 281
    Width = 359
    ExplicitTop = 281
    ExplicitWidth = 359
    inherited pnlNomeForm: TPanel
      Left = 188
      ExplicitLeft = 188
    end
    inherited pnlInfo: TPanel
      Width = 188
      ExplicitWidth = 188
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 359
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label12: TLabel
      Left = 16
      Top = 12
      Width = 39
      Height = 14
      Caption = 'Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 32
      Top = 42
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label2: TLabel
      Left = 27
      Top = 69
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lblCodEmp: TLabel
      Left = 6
      Top = 99
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label3: TLabel
      Left = 9
      Top = 176
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'C. D'#233'bito:'
    end
    object Label4: TLabel
      Left = 5
      Top = 200
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'C. Cr'#233'dito:'
    end
    object Label5: TLabel
      Left = 10
      Top = 228
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 62
      Top = 9
      Width = 85
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 158
      Top = 9
      Width = 88
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtTipLan: TComboBoxFocus
      Tag = 99
      Left = 62
      Top = 37
      Width = 289
      Height = 22
      Style = csDropDownList
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtValor: TCurrencyEditFocus
      Left = 62
      Top = 66
      EditValue = 0.000000000000000000
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 107
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 62
      Top = 96
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesOpe: TEditFocus
      Left = 122
      Top = 96
      Width = 229
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object rdgLancto: TRadioGroup
      Left = 62
      Top = 127
      Width = 257
      Height = 36
      Caption = 'Lan'#231'amentos:'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Manual'
        'Autom'#225'tico')
      TabOrder = 6
    end
    object mskContaDebito: TMaskEditFocus
      Left = 62
      Top = 173
      Width = 126
      Height = 22
      TabOrder = 7
      Text = ''
      OnExit = mskContaDebitoExit
      OnKeyPress = mskContaDebitoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskContaCredito: TMaskEditFocus
      Left = 62
      Top = 197
      Width = 126
      Height = 22
      TabOrder = 9
      Text = ''
      OnExit = mskContaCreditoExit
      OnKeyPress = mskContaCreditoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesContaCRedito: TEditFocus
      Left = 191
      Top = 197
      Width = 158
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesContaDebito: TEditFocus
      Left = 191
      Top = 173
      Width = 158
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 62
      Top = 225
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 11
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 120
      Top = 225
      Width = 229
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
