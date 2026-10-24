inherited frmCfgBalancas: TfrmCfgBalancas
  Top = 195
  Width = 250
  Height = 306
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#245'es de Balan'#231'as'
  Position = poMainFormCenter
  ExplicitWidth = 250
  ExplicitHeight = 306
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 244
    ExplicitTop = 234
    ExplicitWidth = 244
    DesignSize = (
      244
      28)
    inherited btnSair: TBitBtnLocked
      Left = 161
      TabOrder = 1
      ExplicitLeft = 161
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
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
  inherited pnlStatus: TPanel
    Top = 262
    Width = 244
    ExplicitTop = 262
    ExplicitWidth = 244
    inherited pnlNomeForm: TPanel
      Left = 73
      ExplicitLeft = 73
    end
    inherited pnlInfo: TPanel
      Width = 73
      ExplicitWidth = 73
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 244
    Height = 234
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lbl3: TLabel
      Left = 8
      Top = 8
      Width = 91
      Height = 14
      Caption = 'Modelo da Balan'#231'a'
    end
    object lbl4: TLabel
      Left = 8
      Top = 46
      Width = 108
      Height = 14
      Caption = 'Porta de Comunica'#231#227'o'
    end
    object lbl1: TLabel
      Left = 123
      Top = 46
      Width = 50
      Height = 14
      Caption = 'Baud Rate'
    end
    object lbl2: TLabel
      Left = 8
      Top = 84
      Width = 43
      Height = 14
      Caption = 'Data Bits'
    end
    object lbl5: TLabel
      Left = 123
      Top = 84
      Width = 27
      Height = 14
      Caption = 'Parity'
    end
    object lbl6: TLabel
      Left = 8
      Top = 122
      Width = 43
      Height = 14
      Caption = 'Stop Bits'
    end
    object lbl7: TLabel
      Left = 123
      Top = 122
      Width = 62
      Height = 14
      Caption = 'Handshaking'
    end
    object Label1: TLabel
      Left = 8
      Top = 162
      Width = 157
      Height = 14
      Caption = 'D'#237'gito inicial do C'#243'digo de Barras'
    end
    object cbbModBal: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 225
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Sorted = True
      TabOrder = 0
      Text = 'TOLEDO'
      Items.Strings = (
        'FILIZOLA'
        'LUCASTEC'
        'MAGNA'
        'MICHELETTI'
        'NENHUMA'
        'TOLEDO'
        'TOLEDO 2180'
        'URANO')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbPorta: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 60
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'COM13'
        'COM14'
        'COM15'
        'COM16')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbBaud: TComboBoxFocus
      Tag = 99
      Left = 123
      Top = 60
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      Text = '4800'
      Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbDataBt: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 2
      Sorted = True
      TabOrder = 3
      Text = '7'
      Items.Strings = (
        '5'
        '6'
        '7'
        '8')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbParity: TComboBoxFocus
      Tag = 99
      Left = 123
      Top = 98
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Sorted = True
      TabOrder = 4
      Text = 'EVEN'
      Items.Strings = (
        'EVEN'
        'MARK'
        'NONE'
        'ODD'
        'SPACE')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbStop: TComboBoxFocus
      Tag = 99
      Left = 7
      Top = 134
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 2
      Sorted = True
      TabOrder = 5
      Text = 'S2'
      Items.Strings = (
        'S1'
        'S1,5'
        'S2')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbHandsh: TComboBoxFocus
      Tag = 99
      Left = 123
      Top = 136
      Width = 110
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 1
      Sorted = True
      TabOrder = 6
      Text = 'NENHUM'
      Items.Strings = (
        'DTR/DSR'
        'NENHUM'
        'RTS/CTS'
        'XON/XOFF')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtDigIni: TEditFocus
      Left = 8
      Top = 176
      Width = 33
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 1
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object chkDivQtd: TCheckBox
      Left = 8
      Top = 204
      Width = 225
      Height = 17
      Caption = 'Dividir qtde. da etiqueta por 1000 (caixa)'
      TabOrder = 8
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
  end
end
