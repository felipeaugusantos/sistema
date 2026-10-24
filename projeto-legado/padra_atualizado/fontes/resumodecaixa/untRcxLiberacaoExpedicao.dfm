inherited frmRcxLiberacaoExpedicao: TfrmRcxLiberacaoExpedicao
  Left = 3
  Top = 52
  Width = 796
  Height = 411
  ActiveControl = dbgDocumentos
  Caption = 'Libera'#231#227'o para Expedi'#231#227'o'
  Position = poOwnerFormCenter
  ExplicitWidth = 796
  ExplicitHeight = 411
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 342
    Width = 790
    ExplicitTop = 342
    ExplicitWidth = 790
    DesignSize = (
      790
      28)
    inherited btnSair: TBitBtnLocked
      Left = 709
      TabOrder = 1
      ExplicitLeft = 709
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 105
      Height = 22
      Caption = '[F10] Confirma'
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
      OnClick = btnConfirmaClick
    end
  end
  object dbgDocumentos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 790
    Height = 342
    Align = alClient
    DataSource = dtsDocumentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDocumentosDrawColumnCell
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DTAENT'
        Title.Caption = 'Data'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORENT'
        Title.Caption = 'Hora'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Caption = 'Esp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Emp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Cliente'
        Width = 307
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODVEN'
        Title.Caption = 'Ven.'
        Width = 35
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALDOC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 370
    Width = 790
    ExplicitTop = 370
    ExplicitWidth = 790
    inherited pnlNomeForm: TPanel
      Left = 619
      ExplicitLeft = 619
    end
    inherited pnlInfo: TPanel
      Width = 619
      ExplicitWidth = 619
    end
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentos'
    Left = 448
    Top = 152
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 528
    Top = 152
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    Left = 288
    Top = 152
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 368
    Top = 152
  end
end
