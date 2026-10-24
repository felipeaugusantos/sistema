inherited frmRcxSelClienteCred: TfrmRcxSelClienteCred
  Left = 226
  Top = 344
  Width = 708
  Height = 517
  BorderIcons = [biSystemMenu]
  Caption = 'Informe o cliente para cr'#233'dito'
  Position = poMainFormCenter
  ExplicitWidth = 708
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 448
    Width = 702
    Height = 24
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 448
    ExplicitWidth = 702
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 549
      Height = 20
      TabOrder = 2
      ExplicitLeft = 74
      ExplicitWidth = 549
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 623
      Top = 2
      Height = 20
      Align = alRight
      Visible = False
      ExplicitLeft = 623
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
      Height = 20
      Align = alLeft
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 472
    Width = 702
    TabOrder = 3
    ExplicitTop = 472
    ExplicitWidth = 702
    inherited pnlNomeForm: TPanel
      Left = 547
      Width = 155
      ExplicitLeft = 547
      ExplicitWidth = 155
    end
    inherited pnlInfo: TPanel
      Width = 547
      ExplicitWidth = 547
    end
  end
  inherited pgcDados: TPageControl
    Width = 702
    Height = 448
    TabOrder = 2
    ExplicitWidth = 702
    ExplicitHeight = 448
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 694
      ExplicitHeight = 416
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 702
    Height = 448
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object gridSelClientesCredito: TcxGrid
      Left = 1
      Top = 1
      Width = 700
      Height = 446
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object gridSelClientesCreditoDBTableView1: TcxGridDBTableView
        OnKeyDown = gridSelClientesCreditoDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.DataSource = dtsCadCli
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object gridSelClientesCreditoCLI_CODCLI: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CLI_CODCLI'
          Width = 80
        end
        object gridSelClientesCreditoCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Options.Editing = False
          Width = 400
        end
        object gridSelClientesCreditoCLI_C_G_C_: TcxGridDBColumn
          Caption = 'CNPJ'
          DataBinding.FieldName = 'CLI_C_G_C_'
          Options.Editing = False
          Width = 170
        end
      end
      object gridSelClientesCreditoLevel1: TcxGridLevel
        GridView = gridSelClientesCreditoDBTableView1
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 8
  end
  object dtsCadCli: TDataSource
    DataSet = cdsCadCli
    Left = 512
    Top = 88
  end
  object cdsCadCli: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqryCli'
    Left = 456
    Top = 88
  end
  object dspqryCli: TUniDataSetProvider
    DataSet = qryCredCli
    Options = []
    Left = 400
    Top = 88
  end
  object qryCredCli: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 336
    Top = 88
  end
end
