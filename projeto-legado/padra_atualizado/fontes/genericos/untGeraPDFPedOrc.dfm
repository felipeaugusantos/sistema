inherited frmGeraPDFPedOrc: TfrmGeraPDFPedOrc
  Left = 443
  Top = 325
  Width = 286
  Height = 389
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o de PDF'
  Position = poMainFormCenter
  ExplicitWidth = 286
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 280
    TabOrder = 3
    ExplicitTop = 316
    ExplicitWidth = 280
    DesignSize = (
      280
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 276
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 276
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 198
      ExplicitLeft = 198
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
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
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 280
    Height = 175
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object gpbOrdem: TGroupBox
      Left = 17
      Top = 9
      Width = 247
      Height = 57
      Caption = 'Ordem'
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 19
        Width = 182
        Height = 14
        Caption = '(1)Digita'#231#227'o  (2)Descri'#231#227'o do Produto'
        CorDestaque = clRed
      end
      object ColorLabel1: TColorLabel
        Left = 29
        Top = 33
        Width = 108
        Height = 14
        Caption = '(3) Unidade de Medida'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 8
        Top = 23
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
    object rdgNomEmp: TRadioGroup
      Left = 17
      Top = 66
      Width = 247
      Height = 53
      Caption = 'Nome da Empresa Imprimir:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Raz'#227'o Social'
        'Nome Fantasia')
      TabOrder = 1
    end
    object gpbPreco: TGroupBox
      Left = 17
      Top = 119
      Width = 247
      Height = 48
      Caption = 'Pre'#231'o'
      TabOrder = 2
      object lbl1: TColorLabel
        Left = 29
        Top = 21
        Width = 129
        Height = 14
        Caption = '(C)om Pre'#231'o   (S)em Pre'#231'o'
        CorDestaque = clRed
      end
      object edtPreco: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  object pnlPaisagem: TPanel [3]
    Left = 0
    Top = 236
    Width = 280
    Height = 78
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 238
    object chkMarca: TCheckBox
      Left = 17
      Top = 6
      Width = 95
      Height = 17
      Caption = 'Imprimir Marca'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkLocFis: TCheckBox
      Left = 114
      Top = 6
      Width = 150
      Height = 17
      Caption = 'Imprimir Localiza'#231#227'o F'#237'sica'
      TabOrder = 1
    end
    object gpbModo: TGroupBox
      Left = 17
      Top = 24
      Width = 247
      Height = 45
      Caption = 'Modo'
      TabOrder = 2
      object lbl2: TColorLabel
        Left = 29
        Top = 20
        Width = 106
        Height = 14
        Caption = '(R)etrato   (P)aisagem'
        CorDestaque = clRed
      end
      object edtModo: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'R'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
  end
  object pnlEmpCab: TPanel [4]
    Left = 0
    Top = 175
    Width = 280
    Height = 61
    Align = alTop
    TabOrder = 1
    ExplicitTop = 177
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 278
      Height = 59
      Align = alClient
      Caption = 'Imprimir dados da empresa referente '#224' empresa do:'
      TabOrder = 0
      ExplicitWidth = 227
      object ColorLabel3: TColorLabel
        Left = 29
        Top = 19
        Width = 86
        Height = 14
        Caption = '(1) Pr'#243'prio Pedido'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 29
        Top = 33
        Width = 31
        Height = 14
        Caption = '(2) CD'
        CorDestaque = clRed
      end
      object edtEmpCab: TEditFocus
        Tag = 99
        Left = 8
        Top = 23
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 280
    TabOrder = 4
    ExplicitTop = 344
    ExplicitWidth = 280
    inherited pnlNomeForm: TPanel
      Left = 109
      ExplicitLeft = 109
    end
    inherited pnlInfo: TPanel
      Width = 109
      ExplicitWidth = 109
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 160
  end
end
