inherited frmCadBrasimixAutomotivaBasesEmp: TfrmCadBrasimixAutomotivaBasesEmp
  Width = 909
  Height = 600
  Caption = 'Brasimix Automotiva - Cadastro de Bases por Empresas'
  Position = poScreenCenter
  ExplicitWidth = 909
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 520
    Width = 903
    Height = 35
    ExplicitTop = 520
    ExplicitWidth = 903
    ExplicitHeight = 35
    inherited FlwBotoes: TFlowPanel
      Width = 899
      Height = 31
      ExplicitWidth = 899
      ExplicitHeight = 31
    end
    inherited btnSair: TBitBtnLocked
      Left = 823
      Top = 7
      TabOrder = 2
      ExplicitLeft = 823
      ExplicitTop = 7
    end
    object btnGravar: TBitBtnLocked
      Left = 3
      Top = 7
      Width = 72
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
      TabOrder = 1
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 903
    ExplicitTop = 555
    ExplicitWidth = 903
    inherited pnlNomeForm: TPanel
      Left = 732
      ExplicitLeft = 732
    end
    inherited pnlInfo: TPanel
      Width = 732
      ExplicitWidth = 732
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 903
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object cxGrid1: TcxGrid
      Left = 0
      Top = 0
      Width = 903
      Height = 520
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitLeft = -32
      ExplicitTop = -136
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsBasEmp
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1CODBAS: TcxGridDBColumn
          Caption = 'Base'
          DataBinding.FieldName = 'CODBAS'
          Options.Editing = False
        end
        object cxGrid1DBTableView1DESBAS: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESBAS'
          Options.Editing = False
          Width = 150
        end
        object cxGrid1DBTableView1CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Options.Editing = False
          Width = 50
        end
        object cxGrid1DBTableView1NOMEMP: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'NOMEMP'
          Options.Editing = False
          Width = 200
        end
        object cxGrid1DBTableView1CODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
          RepositoryItem = btnProduto
          Width = 70
        end
        object cxGrid1DBTableView1DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 200
        end
        object cxGrid1DBTableView1EMBALA: TcxGridDBColumn
          Caption = 'Embalagem'
          DataBinding.FieldName = 'EMBALA'
          Width = 74
        end
        object cxGrid1DBTableView1PESESP: TcxGridDBColumn
          Caption = 'Peso Especifico'
          DataBinding.FieldName = 'PESESP'
          Width = 93
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 96
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 624
    Top = 64
  end
  object dtsBasEmp: TDataSource
    DataSet = cdsBasEmp
    Left = 152
    Top = 96
  end
  object cxRepositorio: TcxEditRepository
    Left = 480
    Top = 112
    PixelsPerInch = 96
    object btnProduto: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = '...'
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = btnProdutoPropertiesButtonClick
      Properties.OnValidate = btnProdutoPropertiesValidate
    end
  end
  object cdsBasEmp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 184
    object cdsBasEmpCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsBasEmpNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 100
    end
    object cdsBasEmpCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsBasEmpDESITE: TStringField
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsBasEmpCODBAS: TStringField
      FieldName = 'CODBAS'
      Size = 10
    end
    object cdsBasEmpDESBAS: TStringField
      FieldName = 'DESBAS'
      Size = 50
    end
    object cdsBasEmpEMBALA: TFloatField
      FieldName = 'EMBALA'
    end
    object cdsBasEmpPESESP: TFloatField
      FieldName = 'PESESP'
    end
  end
end