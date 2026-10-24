inherited frmCfgProxCodFaturamento: TfrmCfgProxCodFaturamento
  Left = 230
  Top = 197
  Width = 538
  Height = 462
  ActiveControl = dbePro_NF
  Caption = 'Configura'#231#245'es - Pr'#243'ximos C'#243'digos do Faturamento'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 391
    Width = 530
    inherited btnSair: TBitBtn
      Left = 449
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
    Top = 419
    Width = 530
    inherited pnlNomeForm: TPanel
      Left = 359
    end
    inherited pnlInfo: TPanel
      Width = 359
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 530
    Height = 391
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label146: TLabel
      Left = 14
      Top = 14
      Width = 134
      Height = 14
      Caption = 'Sequ'#234'ncial para Nota Fiscal'
    end
    object Label147: TLabel
      Left = 14
      Top = 56
      Width = 191
      Height = 14
      Caption = 'Sequ'#234'ncial para Movimenta'#231#227'o de Itens'
    end
    object Label149: TLabel
      Left = 14
      Top = 96
      Width = 134
      Height = 14
      Caption = 'Sequ'#234'ncial para Or'#231'amento'
    end
    object Label150: TLabel
      Left = 14
      Top = 138
      Width = 113
      Height = 14
      Caption = 'Sequ'#234'ncial para Pedido'
    end
    object Label151: TLabel
      Left = 14
      Top = 180
      Width = 181
      Height = 14
      Caption = 'Sequ'#234'ncial para Troca de Mercadoria'
    end
    object Label152: TLabel
      Left = 13
      Top = 220
      Width = 169
      Height = 14
      Caption = 'Sequ'#234'ncial para Ajuste de Estoque'
    end
    object Label153: TLabel
      Left = 13
      Top = 261
      Width = 112
      Height = 14
      Caption = 'Sequ'#234'ncial para Brinde'
    end
    object Label99: TLabel
      Left = 233
      Top = 14
      Width = 206
      Height = 14
      Caption = 'Sequ'#234'ncial para Transfer'#234'ncia de Estoque'
    end
    object Label100: TLabel
      Left = 233
      Top = 56
      Width = 145
      Height = 14
      Caption = 'Sequ'#234'ncial para Cupom Fiscal'
    end
    object Label107: TLabel
      Left = 233
      Top = 96
      Width = 132
      Height = 14
      Caption = 'Sequ'#234'ncial para Devolu'#231#227'o'
    end
    object Label133: TLabel
      Left = 233
      Top = 138
      Width = 175
      Height = 14
      Caption = 'Sequ'#234'ncial para Faturamento Futuro'
    end
    object Label6: TLabel
      Left = 233
      Top = 180
      Width = 165
      Height = 14
      Caption = 'Sequ'#234'ncial para Cr'#233'dito de Cliente'
    end
    object Label164: TLabel
      Left = 233
      Top = 220
      Width = 283
      Height = 14
      Caption = 'Sequ'#234'ncial para Transfer'#234'ncia de Saldo para Saldo em ML'
    end
    object Label165: TLabel
      Left = 233
      Top = 261
      Width = 184
      Height = 14
      Caption = 'Sequ'#234'ncial para movimenta'#231#227'o em ML'
    end
    object Label1: TLabel
      Left = 13
      Top = 301
      Width = 209
      Height = 14
      Caption = 'Sequ'#234'ncial para cheques devolvidos (CTR)'
    end
    object Label2: TLabel
      Left = 233
      Top = 301
      Width = 178
      Height = 14
      Caption = 'Sequ'#234'ncial para movimenta'#231#227'o em PI'
    end
    object Label3: TLabel
      Left = 13
      Top = 341
      Width = 194
      Height = 14
      Caption = 'Sequ'#234'ncial para Ordem de Produ'#231#227'o OP'
    end
    object dbePro_NF: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 28
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_NF'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_MI: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 70
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_MI'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_OR: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 110
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_OR'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_PD: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 152
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_PD'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_TR: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 194
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_TR'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_AJ: TDBEditFocus
      Tag = 99
      Left = 13
      Top = 234
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_AJ'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_BR: TDBEditFocus
      Tag = 99
      Left = 13
      Top = 275
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_BR'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_Te: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 28
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_TE'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_Cp: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 70
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_IF'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_Dv: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 110
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_DV'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_FF: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 152
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_FF'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeProCco: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 194
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PROCCO'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_TM: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 234
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_TM'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_ML: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 275
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_ML'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeProChq: TDBEditFocus
      Tag = 99
      Left = 13
      Top = 315
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PROCHQ'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_PI: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 315
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_PI'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePro_OP: TDBEditFocus
      Tag = 99
      Left = 13
      Top = 355
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_PRO_OP'
      DataSource = frmModulo.dtsCadCfg
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 8
  end
end
