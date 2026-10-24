inherited frmCfgCupomFiscal: TfrmCfgCupomFiscal
  Left = 433
  Top = 294
  Width = 476
  Height = 296
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#245'es - Cupom Fiscal'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 476
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 225
    Width = 470
    Height = 26
    TabOrder = 1
    ExplicitTop = 225
    ExplicitWidth = 467
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 312
      Height = 22
      TabOrder = 1
      ExplicitTop = 2
      ExplicitWidth = 463
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 391
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 384
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
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
      ExplicitLeft = 3
      ExplicitTop = 3
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 470
    Height = 225
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 467
    ExplicitHeight = 223
    object Label2: TLabel
      Left = 8
      Top = 5
      Width = 125
      Height = 14
      Caption = 'Impressora a ser Utilizada'
    end
    object Label3: TLabel
      Left = 8
      Top = 50
      Width = 106
      Height = 14
      Caption = 'Modelo da Impressora'
    end
    object Label4: TLabel
      Left = 8
      Top = 90
      Width = 108
      Height = 14
      Caption = 'Porta de Comunica'#231#227'o'
    end
    object Label8: TLabel
      Left = 8
      Top = 130
      Width = 55
      Height = 14
      Caption = 'Utiliza TEF?'
    end
    object ColorLabel2: TColorLabel
      Left = 63
      Top = 150
      Width = 61
      Height = 14
      Caption = '(S)im (N)'#227'o  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label1: TLabel
      Left = 128
      Top = 131
      Width = 56
      Height = 14
      Caption = 'Utiliza PAF?'
    end
    object ColorLabel1: TColorLabel
      Left = 183
      Top = 151
      Width = 58
      Height = 14
      Caption = '(S)im (N)'#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 8
      Top = 172
      Width = 452
      Height = 14
      Caption = 
        'Impress'#227'o concomitante de itens no F11? (Somente quando n'#227'o carr' +
        'egar pedido / or'#231'amento)'
    end
    object ColorLabel3: TColorLabel
      Left = 63
      Top = 191
      Width = 58
      Height = 14
      Caption = '(S)im (N)'#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label6: TLabel
      Left = 152
      Top = 90
      Width = 65
      Height = 14
      Caption = 'Qtde Colunas'
    end
    object edtCodEcf: TEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodEcfKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomEcf: TEditFocus
      Left = 72
      Top = 20
      Width = 389
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
    object cmbModEcf: TComboBoxFocus
      Left = 8
      Top = 64
      Width = 209
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Sorted = True
      TabOrder = 2
      Items.Strings = (
        'BEMATECH-MP2100THFI / MP40'
        'DARUMA'
        'DARUMA FS700 OU SUPERIOR'
        'ELGIN 1FIT'
        'EPSON'
        'SCHALTER SCFI 1E'
        'SWEDA ST120'
        'SWEDA-7000'
        'SWEDA-9000')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbPorta: TComboBoxFocus
      Left = 8
      Top = 104
      Width = 113
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Sorted = True
      TabOrder = 4
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtUsaTef: TEditFocus
      Tag = 99
      Left = 8
      Top = 146
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtUsaPaf: TEditFocus
      Tag = 99
      Left = 128
      Top = 146
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCmtF11: TEditFocus
      Tag = 99
      Left = 8
      Top = 186
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object chkMP4200: TCheckBox
      Left = 240
      Top = 67
      Width = 193
      Height = 17
      Caption = 'MP4200 TH FI (apenas Bematech)'
      TabOrder = 3
    end
    object edtQtdCol: TEditFocus
      Tag = 99
      Left = 152
      Top = 104
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  inherited pnlStatus: TPanel
    Top = 251
    Width = 470
    TabOrder = 2
    ExplicitTop = 251
    ExplicitWidth = 467
    inherited pnlNomeForm: TPanel
      Left = 299
      ExplicitLeft = 296
    end
    inherited pnlInfo: TPanel
      Width = 299
      ExplicitWidth = 296
    end
  end
end
