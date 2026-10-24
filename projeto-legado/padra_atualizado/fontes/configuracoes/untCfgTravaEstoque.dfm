inherited frmCfgTravaEstoque: TfrmCfgTravaEstoque
  Left = 473
  Top = 259
  Width = 327
  Height = 334
  ActiveControl = dbeSldVn
  Caption = 'Configura'#231#245'es - Trava do Estoque'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 256
    Width = 319
    inherited btnSair: TBitBtn
      Left = 238
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
    Top = 284
    Width = 319
    inherited pnlNomeForm: TPanel
      Left = 148
    end
    inherited pnlInfo: TPanel
      Width = 148
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 319
    Height = 256
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label55: TLabel
      Left = 14
      Top = 14
      Width = 167
      Height = 14
      Caption = 'Saldo de estoque na venda normal'
    end
    object ColorLabel36: TColorLabel
      Left = 63
      Top = 35
      Width = 136
      Height = 14
      Caption = '(A)visa (T)rava (N)'#227'o Avisa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label58: TLabel
      Left = 14
      Top = 136
      Width = 198
      Height = 14
      Caption = 'Saldo de estoque em Or'#231'amento / Pedido'
    end
    object ColorLabel37: TColorLabel
      Left = 63
      Top = 157
      Width = 136
      Height = 14
      Caption = '(A)visa (T)rava (N)'#227'o Avisa'
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
      Left = 14
      Top = 211
      Width = 126
      Height = 14
      Caption = 'Usar controle de entrega?'
    end
    object ColorLabel1: TColorLabel
      Left = 63
      Top = 232
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
    object Label2: TLabel
      Left = 14
      Top = 96
      Width = 299
      Height = 14
      Caption = 'Na Venda Normal, sem estoque, permitir somente Or'#231'amento?'
    end
    object ColorLabel2: TColorLabel
      Left = 63
      Top = 117
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
    object Label3: TLabel
      Left = 14
      Top = 54
      Width = 181
      Height = 14
      Caption = 'Senha para liberar produto sem saldo'
    end
    object Label4: TLabel
      Left = 14
      Top = 174
      Width = 181
      Height = 14
      Caption = 'Senha para liberar produto sem saldo'
    end
    object dbeSldVn: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 28
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_SLD_VN'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnChange = dbeSldVnChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeSldOp: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 150
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_SLD_OP'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnChange = dbeSldOpChange
      OnClick = dbeSldOpClick
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeConEnt: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 225
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_CONENT'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeVseOrc: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 110
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_VSEORC'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeSeSdVn: TDBEditFocus
      Left = 15
      Top = 68
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_SESDVN'
      DataSource = frmModulo.dtsCadCfg
      PasswordChar = '*'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSeSdOp: TDBEditFocus
      Left = 15
      Top = 188
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_SESDOP'
      DataSource = frmModulo.dtsCadCfg
      PasswordChar = '*'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
