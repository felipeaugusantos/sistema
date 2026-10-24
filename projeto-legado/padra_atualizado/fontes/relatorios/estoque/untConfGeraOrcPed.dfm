inherited frmConfGeraOrcPed: TfrmConfGeraOrcPed
  Left = 333
  Top = 323
  Width = 557
  Height = 432
  BorderIcons = [biSystemMenu]
  Caption = 'Or'#231'amento/Pedido'
  Position = poMainFormCenter
  ExplicitWidth = 557
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 361
    Width = 551
    Height = 26
    TabOrder = 2
    ExplicitTop = 361
    ExplicitWidth = 551
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 393
      Height = 22
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 393
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 472
      Top = 2
      Align = alRight
      ExplicitLeft = 472
      ExplicitTop = 2
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
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
      OnClick = btnConfirmaDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 387
    Width = 551
    TabOrder = 3
    ExplicitTop = 387
    ExplicitWidth = 551
    inherited pnlNomeForm: TPanel
      Left = 380
      ExplicitLeft = 380
    end
    inherited pnlInfo: TPanel
      Width = 380
      ExplicitWidth = 380
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 151
    Width = 551
    Height = 210
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 71
      Top = 15
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem:'
    end
    object Label2: TLabel
      Left = 48
      Top = 61
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object Label3: TLabel
      Left = 55
      Top = 84
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do Frete:'
    end
    object Label4: TLabel
      Left = 42
      Top = 107
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete para Conta:'
    end
    object lblEntFat: TLabel
      Left = 8
      Top = 130
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entrega no Faturamento:'
    end
    object ColorLabel3: TColorLabel
      Left = 155
      Top = 130
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblPreVis: TLabel
      Left = 231
      Top = 130
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Previs'#227'o:'
    end
    object edtMens01: TEditFocus
      Left = 128
      Top = 11
      Width = 406
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 70
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens02: TEditFocus
      Left = 128
      Top = 34
      Width = 406
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 70
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 128
      Top = 57
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 128
      Top = 80
      Width = 48
      Height = 22
      Alignment = taRightJustify
      MaxLength = 7
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtNomTra: TEditFocus
      Left = 177
      Top = 57
      Width = 357
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
    object gpbTipFat: TGroupBox
      Left = 88
      Top = 152
      Width = 416
      Height = 47
      Caption = 'Tipo de Faturamento:'
      TabOrder = 8
      object ColorLabel2: TColorLabel
        Left = 48
        Top = 23
        Width = 297
        Height = 14
        AutoSize = False
        Caption = '(A) - Nota Fiscal    (B) - Fat. Futuro    (C) - Cupom Fiscal'
        CorDestaque = clRed
      end
      object edtTipFat: TEditFocus
        Tag = 99
        Left = 8
        Top = 19
        Width = 33
        Height = 22
        Alignment = taCenter
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtEntFat: TEditFocus
      Tag = 99
      Left = 128
      Top = 126
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 5
      Text = 'S'
      OnChange = edtEntFatChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipFre: TComboBoxFocus
      Tag = 99
      Left = 128
      Top = 103
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskPreVis: TMaskEditFocus
      Tag = 99
      Left = 279
      Top = 126
      Width = 61
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pnlOpcoes: TPanel [3]
    Left = 0
    Top = 0
    Width = 551
    Height = 151
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object rdgConfirma: TRadioGroup
      Tag = 99
      Left = 8
      Top = 8
      Width = 526
      Height = 50
      Caption = 
        'Confirma gera'#231#227'o dos Or'#231'amentos/Pedidos de Transfer'#234'ncia de Esto' +
        'que?'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 0
      OnClick = rdgConfirmaClick
    end
    object rdgTipo: TRadioGroup
      Tag = 99
      Left = 8
      Top = 60
      Width = 526
      Height = 50
      Caption = 'Tipo de Documento'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Or'#231'amento'
        'Pedido')
      TabOrder = 1
      OnClick = rdgTipoClick
    end
    object pnlEmpCD: TPanel
      Left = 0
      Top = 117
      Width = 551
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lblEmpresa: TLabel
        Left = 12
        Top = 11
        Width = 68
        Height = 14
        Caption = 'Empresa C.D.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 82
        Top = 3
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnEnter = edtCodEmpresaEnter
        OnExit = edtCodEmpresaExit
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 140
        Top = 3
        Width = 393
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 184
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 384
    Top = 176
  end
end
