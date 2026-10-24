inherited frmAltValorEntrega: TfrmAltValorEntrega
  Width = 483
  Height = 346
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Global do Valor de Entrega'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 483
  ExplicitHeight = 346
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 275
    Width = 477
    Height = 26
    TabOrder = 1
    ExplicitTop = 275
    ExplicitWidth = 477
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 159
      Width = 239
      Height = 22
      TabOrder = 3
      ExplicitTop = 2
      ExplicitWidth = 473
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 398
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 394
    end
    object btnConfirma: TBitBtnLocked
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
      OnClick = btnConfirmaClick
      ExplicitLeft = 5
      ExplicitTop = 3
    end
    object btnLimparBusca: TBitBtnLocked
      Left = 79
      Top = 2
      Width = 80
      Height = 22
      Align = alLeft
      Caption = 'Limpar Busca'
      TabOrder = 1
      OnClick = btnLimparBuscaClick
      ExplicitLeft = 83
      ExplicitTop = 3
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 477
    Height = 269
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 267
    object lbl2: TLabel
      Left = 30
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lbl3: TLabel
      Left = 30
      Top = 40
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object lblValEnt: TLabel
      Left = 181
      Top = 82
      Width = 186
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator para aplicar no Valor de Entrega:'
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 67
      Top = 12
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
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
      Left = 109
      Top = 12
      Width = 331
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtEstado: TEditFocus
      Tag = 99
      Left = 67
      Top = 36
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object dbgGrid: TDBGridCitel
      Left = 0
      Top = 113
      Width = 477
      Height = 156
      Align = alBottom
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CID_NOMCID'
          Title.Caption = 'Cidade'
          Width = 245
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CID_VALENT'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Entrega Ant.'
          Width = 100
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CID_VALNOV'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Entrega Novo'
          Width = 100
          Visible = True
        end>
    end
    object rdgTipVal: TRadioGroup
      Tag = 99
      Left = 67
      Top = 60
      Width = 104
      Height = 41
      Caption = 'Alterar Por'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Valor'
        'Fator')
      TabOrder = 3
      OnClick = rdgTipValClick
    end
    object edtValEnt: TEditFocus
      Tag = 99
      Left = 368
      Top = 79
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 10
      TabOrder = 4
      OnEnter = edtValEntEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttNumerico
    end
  end
  object pgbStatus: TProgressBar [3]
    Left = 0
    Top = 269
    Width = 477
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 2
    Visible = False
    ExplicitTop = 267
  end
  inherited pnlStatus: TPanel
    Top = 301
    Width = 477
    TabOrder = 3
    ExplicitTop = 301
    ExplicitWidth = 477
    inherited pnlNomeForm: TPanel
      Left = 306
      ExplicitLeft = 306
    end
    inherited pnlInfo: TPanel
      Width = 306
      ExplicitWidth = 306
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 184
  end
end
