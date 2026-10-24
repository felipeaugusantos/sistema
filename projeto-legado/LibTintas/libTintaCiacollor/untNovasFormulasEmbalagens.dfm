inherited frmNovasFormulasEmbalagens: TfrmNovasFormulasEmbalagens
  BorderIcons = [biSystemMenu]
  Caption = 'Embalagens Diferenciadas'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    TabOrder = 1
    inherited btnSair: TBitBtnLocked
      Left = 402
      Top = 4
      TabOrder = 1
      ExplicitLeft = 402
      ExplicitTop = 4
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 77
      Height = 22
      Caption = '&Gravar'
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
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
  object grpEmbDif: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 190
    Align = alClient
    Caption = '     Embalagens diferenciadas     '
    TabOrder = 0
    object dbgrdEmbDif: TDBGridCitel
      Left = 2
      Top = 16
      Width = 479
      Height = 172
      Align = alClient
      DataSource = dsCadEmb
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'BAU_CODUNI'
          Title.Caption = 'Unidade'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNI_DESUNI'
          Title.Caption = 'Descri'#231#227'o'
          Width = 171
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NFM_VOLUME'
          Title.Alignment = taRightJustify
          Title.Caption = 'Volume'
          Width = 88
          Visible = True
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 152
  end
  object dsCadEmb: TDataSource
    DataSet = cdsEmbDif
    Left = 440
    Top = 152
  end
  object cdsEmbDif: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmbDif'
    Left = 408
    Top = 152
    object cdsEmbDifBAU_CODFML: TStringField
      FieldName = 'BAU_CODFML'
      Size = 4
    end
    object cdsEmbDifBAU_CODBAS: TStringField
      FieldName = 'BAU_CODBAS'
      Size = 6
    end
    object cdsEmbDifBAU_CODUNI: TStringField
      FieldName = 'BAU_CODUNI'
      Size = 2
    end
    object cdsEmbDifUNI_DESUNI: TStringField
      FieldName = 'UNI_DESUNI'
      Size = 15
    end
    object cdsEmbDifNFM_VOLUME: TFloatField
      FieldName = 'NFM_VOLUME'
    end
  end
end
