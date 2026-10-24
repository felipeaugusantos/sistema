inherited frmCadWanProGeraArquivo: TfrmCadWanProGeraArquivo
  Left = 429
  Top = 268
  Width = 532
  Height = 189
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o do Arquivo - Color Pro '
  Color = clBtnFace
  Position = poScreenCenter
  ExplicitWidth = 532
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 526
    Height = 26
    ExplicitTop = 119
    ExplicitWidth = 526
    ExplicitHeight = 26
    DesignSize = (
      526
      26)
    inherited btnSair: TBitBtnLocked
      Left = 443
      Top = 1
      TabOrder = 1
      ExplicitLeft = 443
      ExplicitTop = 1
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 1
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
      OnClick = btnConfirmaDadosClick
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 32
    Width = 526
    Height = 87
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label7: TLabel
      Left = 5
      Top = 35
      Width = 72
      Height = 14
      Caption = 'Formula'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 59
      Width = 34
      Height = 14
      Caption = 'Cores'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 11
      Width = 60
      Height = 14
      Caption = 'Pigmentos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pgbLayer: TProgressBar
      Left = 1
      Top = 49
      Width = 520
      Height = 11
      Smooth = True
      TabOrder = 0
    end
    object pgbCores: TProgressBar
      Left = 1
      Top = 73
      Width = 520
      Height = 11
      Smooth = True
      TabOrder = 1
    end
    object pgbPigmentos: TProgressBar
      Left = 1
      Top = 25
      Width = 520
      Height = 11
      Smooth = True
      TabOrder = 2
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 526
    Height = 32
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object rdbGerBas: TRadioButton
      Left = 11
      Top = 8
      Width = 113
      Height = 17
      Caption = 'Gerar Bases'
      TabOrder = 0
    end
    object rdbGerFor: TRadioButton
      Left = 131
      Top = 8
      Width = 113
      Height = 17
      Caption = 'Gerar F'#243'rmulas'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 145
    Width = 526
    ExplicitTop = 145
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 355
      ExplicitLeft = 355
    end
    inherited pnlInfo: TPanel
      Width = 355
      ExplicitWidth = 355
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
    Top = 368
  end
  object cdsTonner: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadBas'
    Left = 336
    Top = 24
    object cdsTonnerLinha: TStringField
      FieldName = 'Linha'
      Size = 10
    end
    object cdsTonnerBase: TStringField
      FieldName = 'Base'
      Size = 10
    end
    object cdsTonnerDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object cdsTonnerStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
    object cdsTonnerPreco: TFloatField
      FieldName = 'Preco'
    end
    object cdsTonnerPesoEsp: TFloatField
      FieldName = 'PesoEsp'
    end
    object cdsTonnerTamEmbala: TFloatField
      FieldName = 'TamEmbala'
    end
  end
  object cdsColors: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 24
  end
  object qryLayer: TUniQuery
    Connection = frmModulo.Database
    Left = 416
    Top = 24
  end
  object dspCadBas: TUniDataSetProvider
    DataSet = qryCadBas
    Options = []
    Left = 304
    Top = 24
  end
  object qryCadWan: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM WANPRO_CADWAN LIMIT 0')
    Left = 376
    Top = 24
  end
  object qryCadBas: TUniQuery
    Connection = frmModulo.Database
    Left = 264
    Top = 24
  end
end
