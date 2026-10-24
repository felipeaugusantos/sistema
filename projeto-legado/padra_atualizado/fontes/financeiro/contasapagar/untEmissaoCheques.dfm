inherited frmEmissaoCheques: TfrmEmissaoCheques
  Width = 492
  Height = 228
  BorderIcons = [biSystemMenu]
  Caption = 'Emiss'#227'o de Cheques'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 492
  ExplicitHeight = 228
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 486
    ExplicitTop = 155
    ExplicitWidth = 486
    inherited FlwBotoes: TFlowPanel
      Width = 482
      TabOrder = 2
    end
    object btnGravar: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 72
      Height = 22
      Caption = '&Gravar'
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
      OnClick = btnGravarClick
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 486
    Height = 112
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblCodBco: TLabel
      Left = 27
      Top = 12
      Width = 34
      Height = 14
      Caption = 'Banco:'
    end
    object lblNumAge: TLabel
      Left = 19
      Top = 36
      Width = 43
      Height = 14
      Caption = 'Ag'#234'ncia:'
    end
    object lblConCor: TLabel
      Left = 185
      Top = 36
      Width = 31
      Height = 14
      Caption = 'Conta:'
    end
    object lblNumChq: TLabel
      Left = 355
      Top = 36
      Width = 40
      Height = 14
      Caption = 'Cheque:'
    end
    object lblBomPara: TLabel
      Left = 346
      Top = 60
      Width = 49
      Height = 14
      Caption = 'Bom para:'
    end
    object lblDtaEmi: TLabel
      Left = 173
      Top = 60
      Width = 43
      Height = 14
      Caption = 'Emiss'#227'o:'
    end
    object lblFavorecido: TLabel
      Left = 4
      Top = 84
      Width = 57
      Height = 14
      Caption = 'Favorecido:'
    end
    object Label1: TLabel
      Left = 33
      Top = 60
      Width = 28
      Height = 14
      Caption = 'Valor:'
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 61
      Top = 9
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomBco: TEditFocus
      Left = 142
      Top = 9
      Width = 332
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
    object edtNumAge: TEditFocus
      Tag = 99
      Left = 61
      Top = 33
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConCor: TEditFocus
      Tag = 99
      Left = 216
      Top = 33
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumChq: TEditFocus
      Tag = 99
      Left = 395
      Top = 33
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 10
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskBomPara: TMaskEditFocus
      Tag = 99
      Left = 395
      Top = 57
      Width = 79
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaEmi: TMaskEditFocus
      Tag = 99
      Left = 216
      Top = 57
      Width = 79
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtFavorecido: TEditFocus
      Left = 61
      Top = 81
      Width = 413
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
    object edtValChqEmi: TEditFocus
      Tag = 99
      Left = 61
      Top = 57
      Width = 79
      Height = 22
      Alignment = taRightJustify
      TabOrder = 5
      Text = '0,00'
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
  object pnlTotal: TPanel [3]
    Left = 0
    Top = 111
    Width = 486
    Height = 44
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lbl7: TLabel
      Left = 46
      Top = 16
      Width = 66
      Height = 14
      Caption = 'Total Digitado:'
    end
    object lbl8: TLabel
      Left = 341
      Top = 16
      Width = 54
      Height = 14
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 203
      Top = 16
      Width = 46
      Height = 14
      Caption = 'Restante:'
    end
    object edtTotDig: TEditFocus
      Left = 114
      Top = 12
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotGer: TEditFocus
      Left = 396
      Top = 12
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotRes: TEditFocus
      Left = 251
      Top = 12
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
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
    Top = 183
    Width = 486
    ExplicitTop = 183
    ExplicitWidth = 486
    inherited pnlNomeForm: TPanel
      Left = 315
      ExplicitLeft = 315
    end
    inherited pnlInfo: TPanel
      Width = 315
      ExplicitWidth = 315
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 0
  end
end
