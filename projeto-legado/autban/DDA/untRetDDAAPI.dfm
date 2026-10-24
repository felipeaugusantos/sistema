inherited frmRetDDAAPI: TfrmRetDDAAPI
  Width = 504
  Height = 330
  BorderIcons = [biSystemMenu]
  Caption = 'Arquivo de Retorno Banco'
  Position = poMainFormCenter
  ExplicitWidth = 504
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 498
    Height = 26
    ExplicitTop = 259
    ExplicitWidth = 498
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 417
      Height = 22
      ExplicitWidth = 417
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Tag = 1
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
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
        ParentFont = False
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 419
      Top = 2
      Align = alRight
      ExplicitLeft = 419
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 498
    ExplicitTop = 285
    ExplicitWidth = 498
    inherited pnlNomeForm: TPanel
      Left = 327
      ExplicitLeft = 327
    end
    inherited pnlInfo: TPanel
      Width = 327
      ExplicitWidth = 327
    end
  end
  object frxDBNaoGra: TfrxDBDataset
    UserName = 'frxDBNaoGra'
    CloseDataSource = False
    DataSet = cdsNaoGra
    BCDToCurrency = False
    Left = 176
    Top = 96
  end
  object cdsNaoGra: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 96
    object cdsNaoGraCODBCO: TStringField
      FieldName = 'CODBCO'
      Size = 9
    end
    object cdsNaoGraCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsNaoGraCODAGE: TStringField
      FieldName = 'CODAGE'
      Size = 18
    end
    object cdsNaoGraCODCTA: TStringField
      FieldName = 'CODCTA'
      Size = 36
    end
    object cdsNaoGraDTAARQ: TDateTimeField
      FieldName = 'DTAARQ'
    end
    object cdsNaoGraCODLOT: TStringField
      FieldName = 'CODLOT'
      Size = 21
    end
    object cdsNaoGraDIGCBR: TStringField
      FieldName = 'DIGCBR'
      Size = 3
    end
    object cdsNaoGraFATVEN: TStringField
      FieldName = 'FATVEN'
      Size = 12
    end
    object cdsNaoGraVALBAR: TFloatField
      FieldName = 'VALBAR'
    end
    object cdsNaoGraCNPCPF: TStringField
      FieldName = 'CNPCPF'
      Size = 3
    end
    object cdsNaoGraCNPJ__: TStringField
      FieldName = 'CNPJ__'
      Size = 42
    end
    object cdsNaoGraNOMCED: TStringField
      FieldName = 'NOMCED'
      Size = 90
    end
    object cdsNaoGraDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object cdsNaoGraVALTIT: TFloatField
      FieldName = 'VALTIT'
    end
    object cdsNaoGraCODMOE: TStringField
      FieldName = 'CODMOE'
      Size = 6
    end
    object cdsNaoGraNUMDUP: TStringField
      FieldName = 'NUMDUP'
    end
    object cdsNaoGraAGECOB: TStringField
      FieldName = 'AGECOB'
      Size = 15
    end
    object cdsNaoGraMODCAR: TStringField
      FieldName = 'MODCAR'
      Size = 3
    end
    object cdsNaoGraESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsNaoGraDTAEMI: TDateField
      FieldName = 'DTAEMI'
    end
    object cdsNaoGraCODMOV: TStringField
      FieldName = 'CODMOV'
      Size = 6
    end
    object cdsNaoGraBCOCOM: TStringField
      FieldName = 'BCOCOM'
      Size = 9
    end
    object cdsNaoGraCAMLIV: TStringField
      FieldName = 'CAMLIV'
      Size = 75
    end
    object cdsNaoGraCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 24
    end
    object cdsNaoGraLINDIG: TStringField
      FieldName = 'LINDIG'
      Size = 141
    end
    object cdsNaoGraCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 144
    end
    object cdsNaoGraDUPCOR: TStringField
      FieldName = 'DUPCOR'
      Size = 45
    end
  end
end
