inherited frmCfgNotaFiscal: TfrmCfgNotaFiscal
  Left = 292
  Top = 207
  Width = 302
  Height = 517
  ActiveControl = dbeIteNot
  Caption = 'Configura'#231#245'es - Nota Fiscal'
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 446
    Width = 294
    inherited btnSair: TBitBtn
      Left = 213
      TabOrder = 1
    end
    object btnGravar: TBitBtn
      Left = 3
      Top = 3
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
    Top = 474
    Width = 294
    inherited pnlNomeForm: TPanel
      Left = 123
    end
    inherited pnlInfo: TPanel
      Width = 123
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 294
    Height = 446
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label69: TLabel
      Left = 14
      Top = 14
      Width = 168
      Height = 14
      Caption = 'Quantidade de itens por nota fiscal'
    end
    object Label71: TLabel
      Left = 14
      Top = 56
      Width = 124
      Height = 14
      Caption = 'Transportadora Sugest'#227'o'
    end
    object Label72: TLabel
      Left = 14
      Top = 138
      Width = 218
      Height = 14
      Caption = 'Senha para altera'#231#227'o de Classifica'#231#227'o Fiscal'
    end
    object Label73: TLabel
      Left = 14
      Top = 219
      Width = 199
      Height = 14
      Caption = 'Senha para Emiss'#227'o de NF outras saidas'
    end
    object Label1: TLabel
      Left = 14
      Top = 259
      Width = 182
      Height = 14
      Caption = 'Senha para Emiss'#227'o de Nota Especial'
    end
    object Label2: TLabel
      Left = 14
      Top = 94
      Width = 139
      Height = 14
      Caption = 'Op'#231#227'o de descri'#231#227'o do Cfop'
    end
    object ColorLabel1: TColorLabel
      Left = 59
      Top = 114
      Width = 196
      Height = 14
      Caption = '(1) Natureza da Opera'#231#227'o (2) Descri'#231#227'o'
      CorDestaque = clRed
    end
    object Label3: TLabel
      Left = 14
      Top = 296
      Width = 197
      Height = 14
      Caption = 'Quantidade de mensagens na nota fiscal'
    end
    object Label4: TLabel
      Left = 14
      Top = 337
      Width = 266
      Height = 14
      Caption = 'Quantidade de caracteres para imprimir mensagem nos'
    end
    object Label5: TLabel
      Left = 14
      Top = 349
      Width = 81
      Height = 14
      Caption = 'dados adicionais'
    end
    object Label6: TLabel
      Left = 14
      Top = 392
      Width = 88
      Height = 14
      Caption = 'Tipo de Formul'#225'rio'
    end
    object ColorLabel2: TColorLabel
      Left = 60
      Top = 411
      Width = 119
      Height = 14
      Caption = '(A) Avulso (C) Continuo '
      CorDestaque = clRed
    end
    object Label7: TLabel
      Left = 14
      Top = 179
      Width = 210
      Height = 14
      Caption = 'Senha para Emiss'#227'o de NF outras entradas'
    end
    object dbeIteNot: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 28
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_ITENOT'
      DataSource = frmModulo.dtsCadCfg
      MaxLength = 9
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTraSug: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 70
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TRASUG'
      DataSource = frmModulo.dtsCadCfg
      MaxLength = 9
      TabOrder = 1
      OnKeyPress = dbeTraSugKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtSenCla: TEditFocus
      Tag = 99
      Left = 14
      Top = 151
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtSenNfo: TEditFocus
      Tag = 99
      Left = 14
      Top = 232
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
    object edtTraSug: TEditFocus
      Left = 64
      Top = 70
      Width = 216
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtSenNes: TEditFocus
      Tag = 99
      Left = 14
      Top = 272
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object dbeOpcCfop: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 108
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_OPCCFO'
      DataSource = frmModulo.dtsCadCfg
      MaxLength = 1
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeQtdMsgNota: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 310
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_QTDMSG'
      DataSource = frmModulo.dtsCadCfg
      MaxLength = 9
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdCarac: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 363
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_QTCANF'
      DataSource = frmModulo.dtsCadCfg
      MaxLength = 9
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipFor: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 407
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TIPFOR'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtSenNfe: TEditFocus
      Tag = 99
      Left = 14
      Top = 192
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 5
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
    Left = 256
    Top = 24
  end
end
