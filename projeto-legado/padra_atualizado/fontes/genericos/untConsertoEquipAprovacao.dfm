inherited frmConsertoEquipAprovacao: TfrmConsertoEquipAprovacao
  Width = 539
  Height = 225
  BorderIcons = [biSystemMenu]
  Caption = 'Conserto de Equipamentos - Status Aprova'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 539
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 533
    Height = 25
    TabOrder = 4
    ExplicitTop = 155
    ExplicitWidth = 533
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 375
      Height = 21
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 375
      ExplicitHeight = 21
    end
    inherited btnSair: TBitBtnLocked
      Tag = 99
      Left = 454
      Top = 2
      Height = 21
      Align = alRight
      ExplicitLeft = 454
      ExplicitTop = 2
      ExplicitHeight = 21
    end
    object btnConfirma: TBitBtnLocked
      Tag = 99
      Left = 2
      Top = 2
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
  inherited pnlStatus: TPanel
    Top = 180
    Width = 533
    TabOrder = 5
    ExplicitTop = 180
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 362
      ExplicitLeft = 362
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 67
    Width = 533
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblAprPor: TLabel
      Left = 109
      Top = 5
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aprovado por:'
    end
    object lblNumPed: TLabel
      Left = 4
      Top = 29
      Width = 175
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Ordem/Pedido do Cliente:'
    end
    object edtAprPor: TEditFocus
      Tag = 99
      Left = 179
      Top = 2
      Width = 345
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 179
      Top = 26
      Width = 101
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object btnPedCmp: TBitBtnLocked
      Left = 392
      Top = 25
      Width = 132
      Height = 25
      Caption = '&Pedidos de Compra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        F2010000424DF201000000000000F20000002800000010000000100000000100
        08000000000000010000340B0000340B00002F0000002F000000EA8F3100B66A
        5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
        6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
        8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
        A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
        AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
        E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF002D2D0A0A0A0A0A0A0A0A
        0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D1127090909090909
        090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D0D0D0D0D
        0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D0D0D0D0D
        0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E090909090909
        0909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D0D0D0D0D
        0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D0D0D0D0D
        23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A2A2A2A2A
        23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnPedCmpClick
    end
  end
  object rdgTipoAprov: TRadioGroup [3]
    Tag = 99
    Left = 0
    Top = 0
    Width = 533
    Height = 38
    Align = alTop
    Caption = '   Aprova'#231#227'o   '
    Columns = 3
    Items.Strings = (
      'APROVADO CLIENTE'
      'APROVADO GARANTIA'
      'APROVADO CORTESIA')
    TabOrder = 0
  end
  object pnlDigitador: TPanel [4]
    Left = 0
    Top = 38
    Width = 533
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      533
      29)
    object lblDigita: TLabel
      Left = 134
      Top = 10
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 179
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
      Left = 225
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
  object pnlEmpFat: TPanel [5]
    Left = 0
    Top = 117
    Width = 533
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object lblEmpFat: TLabel
      Left = 70
      Top = 5
      Width = 109
      Height = 13
      Alignment = taRightJustify
      Caption = 'Emp. Faturamento PD:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmpFat: TEditFocus
      Tag = 99
      AlignWithMargins = True
      Left = 179
      Top = 0
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpFat: TEditFocus
      Left = 225
      Top = 0
      Width = 299
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
end
