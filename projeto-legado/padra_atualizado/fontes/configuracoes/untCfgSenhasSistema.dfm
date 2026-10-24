inherited frmCfgSenhasSistema: TfrmCfgSenhasSistema
  Left = 369
  Top = 145
  Width = 284
  Height = 354
  ActiveControl = edtSenha1
  Caption = 'Configura'#231#245'es - Senhas do Sistema'
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 283
    Width = 276
    DesignSize = (
      276
      28)
    inherited btnSair: TBitBtn
      Left = 195
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
    Top = 311
    Width = 276
    inherited pnlNomeForm: TPanel
      Left = 105
    end
    inherited pnlInfo: TPanel
      Width = 105
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 276
    Height = 283
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label122: TLabel
      Left = 7
      Top = 21
      Width = 89
      Height = 14
      Caption = 'Senhas Principais:'
    end
    object Label123: TLabel
      Left = 98
      Top = 42
      Width = 3
      Height = 14
      Caption = '/'
    end
    object Label124: TLabel
      Left = 7
      Top = 63
      Width = 182
      Height = 14
      Caption = 'Senha para configura'#231#227'o do Sistema:'
    end
    object Label130: TLabel
      Left = 7
      Top = 105
      Width = 164
      Height = 14
      Caption = 'Senha para exclus'#227'o do Senha 2:'
    end
    object Label139: TLabel
      Left = 7
      Top = 145
      Width = 220
      Height = 14
      Caption = 'Senha para mostrar informa'#231#245'es globais 1+2:'
    end
    object Label142: TLabel
      Left = 7
      Top = 185
      Width = 200
      Height = 14
      Caption = 'Senha para Reimpress'#227'o de Documentos'
    end
    object Label1: TLabel
      Left = 7
      Top = 229
      Width = 193
      Height = 14
      Caption = 'Senha para Reimpress'#227'o de Nota Fiscal'
    end
    object edtSenha1: TEditFocus
      Tag = 99
      Left = 7
      Top = 35
      Width = 85
      Height = 22
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtSenha2: TEditFocus
      Tag = 99
      Left = 107
      Top = 35
      Width = 84
      Height = 22
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtSenha3: TEditFocus
      Tag = 99
      Left = 7
      Top = 77
      Width = 85
      Height = 22
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtExcCx2: TEditFocus
      Tag = 99
      Left = 7
      Top = 119
      Width = 85
      Height = 22
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtSenGlo: TEditFocus
      Left = 7
      Top = 159
      Width = 85
      Height = 22
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
    object edtSenRip: TEditFocus
      Left = 7
      Top = 199
      Width = 85
      Height = 22
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
    object edtSeRiNF: TEditFocus
      Left = 7
      Top = 243
      Width = 85
      Height = 22
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
  end
end
