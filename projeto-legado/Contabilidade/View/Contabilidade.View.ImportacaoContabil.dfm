inherited frmImportacaoContabil: TfrmImportacaoContabil
  Width = 957
  Height = 660
  BorderIcons = [biSystemMenu]
  Caption = 'Importa'#231#227'o Cont'#225'bil'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 957
  ExplicitHeight = 660
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 587
    Width = 951
    ExplicitTop = 587
    ExplicitWidth = 954
    inherited FlwBotoes: TFlowPanel
      Left = 185
      Width = 687
      TabOrder = 2
      ExplicitLeft = 185
      ExplicitWidth = 690
    end
    inherited btnSair: TBitBtnLocked
      Left = 872
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 875
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGerar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 183
      Height = 24
      Align = alLeft
      Caption = '&Gravar Lan'#231'amentos V'#225'lidos'
      Enabled = False
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
      OnClick = btnGerarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 615
    Width = 951
    ExplicitTop = 615
    ExplicitWidth = 954
    inherited pnlNomeForm: TPanel
      Left = 780
      ExplicitLeft = 783
    end
    inherited pnlInfo: TPanel
      Width = 780
      ExplicitWidth = 783
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 951
    Height = 587
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 954
    object lbl1: TLabel
      Left = 10
      Top = 14
      Width = 98
      Height = 14
      Caption = 'Caminho do arquivo:'
    end
    object Shape1: TShape
      Left = 10
      Top = 552
      Width = 65
      Height = 6
      Brush.Color = clBlue
    end
    object Shape2: TShape
      Left = 10
      Top = 564
      Width = 65
      Height = 6
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 81
      Top = 548
      Width = 83
      Height = 14
      Caption = 'Registros v'#225'lidos'
    end
    object Label2: TLabel
      Left = 81
      Top = 560
      Width = 91
      Height = 14
      Caption = 'Registros inv'#225'lidos'
    end
    object lblInfoDetal: TLabel
      Left = 695
      Top = 548
      Width = 246
      Height = 14
      Caption = '(Clicar na celula "detalhes" para mais informa'#231#245'es)'
      Visible = False
    end
    object rdgLancto: TRadioGroup
      Left = 10
      Top = 59
      Width = 263
      Height = 40
      Caption = 'Tipo de Informa'#231#245'es:'
      Columns = 3
      Items.Strings = (
        'Folha'
        'Patrimonial'
        'Dimob')
      TabOrder = 1
    end
    object cxgDados: TcxGridCitel
      Left = 10
      Top = 108
      Width = 933
      Height = 438
      TabOrder = 3
      object cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgDadosDBTableViewCitel1CustomDrawCell
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgDadosDBTableViewCitel1CON_DTALAN: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CON_DTALAN'
          Options.Editing = False
          Width = 63
        end
        object cxgDadosDBTableViewCitel1CON_EMPLAN: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CON_EMPLAN'
          Options.Editing = False
          Width = 38
        end
        object cxgDadosDBTableViewCitel1CON_CONDEB: TcxGridDBColumn
          Caption = 'Conta D'#233'bito'
          DataBinding.FieldName = 'CON_CONDEB'
          Options.Editing = False
          Width = 102
        end
        object cxgDadosDBTableViewCitel1CON_CCUSTO: TcxGridDBColumn
          Caption = 'C.Custo D'#233'bito'
          DataBinding.FieldName = 'CON_CCUSTO'
          Options.Editing = False
          Width = 80
        end
        object cxgDadosDBTableViewCitel1CON_CONCRE: TcxGridDBColumn
          Caption = 'Conta Cr'#233'dito'
          DataBinding.FieldName = 'CON_CONCRE'
          Options.Editing = False
          Width = 112
        end
        object cxgDadosDBTableViewCitel1CON_CCUSCR: TcxGridDBColumn
          Caption = 'C.Custo Cr'#233'dito'
          DataBinding.FieldName = 'CON_CCUSCR'
          Options.Editing = False
          Width = 87
        end
        object cxgDadosDBTableViewCitel1CON_VALLAN: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CON_VALLAN'
          Options.Editing = False
          Width = 84
        end
        object cxgDadosDBTableViewCitel1CON_HISTOR: TcxGridDBColumn
          Caption = 'Hist'#243'rico'
          DataBinding.FieldName = 'CON_HISTOR'
          Options.Editing = False
          Width = 138
        end
        object cxgDadosDBTableViewCitel1CON_CODHIP: TcxGridDBColumn
          Caption = 'C.Hist. Padr'#227'o'
          DataBinding.FieldName = 'CON_CODHIP'
          Options.Editing = False
          Width = 76
        end
        object cxgDadosDBTableViewCitel1CON_C_G_C_: TcxGridDBColumn
          Caption = 'CNPJ'
          DataBinding.FieldName = 'CON_C_G_C_'
          Options.Editing = False
          Width = 87
        end
        object cxgDadosDBTableViewCitel1CON_VALIDO: TcxGridDBColumn
          DataBinding.FieldName = 'CON_VALIDO'
          Visible = False
        end
        object cxgDadosDBTableViewCitel1Column1: TcxGridDBColumn
          Caption = 'Detalhes'
          DataBinding.FieldName = 'detalh'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = cxgDadosDBTableViewCitel1Column1PropertiesButtonClick
          Width = 47
        end
      end
      object cxgDadosLevel1: TcxGridLevel
        GridView = cxgDadosDBTableViewCitel1
      end
    end
    object edtArquivo: TFilenameEditFocus
      Left = 10
      Top = 28
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000004020FF406040FF406040FF4060
            40FF004020FF0000000000000000000000000000000000000000806040FFC080
            60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
            80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
            FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
            60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
            FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
            60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
            FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
            60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
            60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
            80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
            A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
            FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
            80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
            80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
            80FFC0A080FF808060FF000000000000000000000000}
          Kind = bkGlyph
        end>
      Properties.OnChange = edtArquivoPropertiesChange
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Width = 931
    end
    object btnCarregarDados: TBitBtnLocked
      Left = 279
      Top = 76
      Width = 135
      Height = 25
      Caption = 'Carregar Dados'
      Enabled = False
      TabOrder = 2
      OnClick = btnCarregarDadosClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 564
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 620
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 592
    Top = 0
  end
  object dtsDados: TDataSource
    Left = 696
  end
end
