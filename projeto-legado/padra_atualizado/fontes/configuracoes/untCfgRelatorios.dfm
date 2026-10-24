inherited frmCfgRelatorios: TfrmCfgRelatorios
  Left = 452
  Top = 274
  Width = 298
  Height = 216
  ActiveControl = dbeTipImp
  Caption = 'Configura'#231#245'es de Relat'#243'rios'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 290
    inherited btnSair: TBitBtn
      Left = 209
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
    Top = 173
    Width = 290
    inherited pnlNomeForm: TPanel
      Left = 119
    end
    inherited pnlInfo: TPanel
      Width = 119
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 290
    Height = 145
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label8: TLabel
      Left = 14
      Top = 14
      Width = 92
      Height = 14
      Caption = 'Tipo de impressora'
    end
    object ColorLabel8: TColorLabel
      Left = 69
      Top = 32
      Width = 119
      Height = 14
      Caption = '(J)ato de Tinta (M)atricial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label148: TLabel
      Left = 14
      Top = 54
      Width = 137
      Height = 14
      Caption = 'Listar FF no Fluxo de Caixa?'
    end
    object ColorLabel55: TColorLabel
      Left = 69
      Top = 72
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
    object Label1: TLabel
      Left = 14
      Top = 94
      Width = 128
      Height = 14
      Caption = 'Zoom inicial dos Relat'#243'rios'
    end
    object dbeTipImp: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 28
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_TIPIMP'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFFFlux: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 68
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_FFFLUX'
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
    object dbeZOOINI: TDBEditFocus
      Tag = 99
      Left = 14
      Top = 108
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CFG_ZOOINI'
      DataSource = frmModulo.dtsCadCfg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
end
