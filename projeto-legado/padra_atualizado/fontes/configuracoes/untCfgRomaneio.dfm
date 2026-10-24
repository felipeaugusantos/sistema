inherited frmCfgRomaneio: TfrmCfgRomaneio
  Left = 319
  Top = 91
  Width = 511
  Height = 400
  ActiveControl = dbeOpcRom
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#245'es - Romaneio'
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 323
    Width = 503
    TabOrder = 1
    inherited btnSair: TBitBtn
      Left = 422
      TabOrder = 1
    end
    object btnGravar: TBitBtn
      Left = 3
      Top = 2
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      TabOrder = 0
      OnClick = btnGravarClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 351
    Width = 503
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 332
    end
    inherited pnlInfo: TPanel
      Width = 332
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 503
    Height = 323
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label5: TLabel
      Left = 12
      Top = 8
      Width = 107
      Height = 14
      Caption = 'Op'#231#227'o para Romaneio'
    end
    object ColorLabel5: TColorLabel
      Left = 50
      Top = 28
      Width = 166
      Height = 14
      Caption = '(1) Pedido do Venda (2) NF, MI, FF'
      CorDestaque = clRed
    end
    object Label1: TLabel
      Left = 12
      Top = 51
      Width = 136
      Height = 14
      Caption = 'Entrar TR e BR no Romaneio'
    end
    object ColorLabel1: TColorLabel
      Left = 50
      Top = 71
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 12
      Top = 99
      Width = 165
      Height = 14
      Caption = 'Quantidade de dias para romaneio'
    end
    object Label3: TLabel
      Left = 12
      Top = 145
      Width = 167
      Height = 14
      Caption = 'Mensagem do Romaneio (1'#170' Linha)'
    end
    object Label4: TLabel
      Left = 12
      Top = 193
      Width = 167
      Height = 14
      Caption = 'Mensagem do Romaneio (2'#170' Linha)'
    end
    object Label6: TLabel
      Left = 12
      Top = 235
      Width = 164
      Height = 14
      Caption = 'Utilizar baixa de romaneio parcial?'
    end
    object ColorLabel2: TColorLabel
      Left = 50
      Top = 255
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label41: TLabel
      Left = 11
      Top = 279
      Width = 149
      Height = 14
      Caption = 'Senha para alterar o Romaneio'
    end
    object dbeOpcRom: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 24
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_OPCROM'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeTrBrRo: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 67
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TRBRRO'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeDiaRom: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 115
      Width = 35
      Height = 22
      HelpType = htKeyword
      CharCase = ecUpperCase
      DataField = 'CFG_DIAROM'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeMesRo1: TDBEditFocus
      Left = 12
      Top = 161
      Width = 487
      Height = 22
      HelpType = htKeyword
      CharCase = ecUpperCase
      DataField = 'CFG_MSGRO1'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMesRo2: TDBEditFocus
      Left = 12
      Top = 209
      Width = 487
      Height = 22
      HelpType = htKeyword
      CharCase = ecUpperCase
      DataField = 'CFG_MSGRO2'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeRomPar: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 251
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_ROMPAR'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object edtSenRom: TEditFocus
      Tag = 99
      Left = 12
      Top = 292
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 8
  end
end
