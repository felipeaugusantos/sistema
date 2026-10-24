inherited frmConfiguracoesImportacaoContabil: TfrmConfiguracoesImportacaoContabil
  Width = 865
  Height = 492
  Caption = 'Configurac'#245'es Importa'#231#227'o Cont'#225'bil'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 865
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 419
    Width = 859
    ExplicitTop = 419
    ExplicitWidth = 859
    inherited FlwBotoes: TFlowPanel
      Left = 87
      Width = 770
      ExplicitWidth = 770
    end
    inherited btnSair: TBitBtnLocked
      Left = 775
      TabOrder = 2
      ExplicitLeft = 775
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 85
      Height = 24
      Align = alLeft
      Caption = '&Gravar'
      TabOrder = 1
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 447
    Width = 859
    ExplicitTop = 447
    ExplicitWidth = 859
    inherited pnlNomeForm: TPanel
      Left = 688
      ExplicitLeft = 688
    end
    inherited pnlInfo: TPanel
      Width = 688
      ExplicitWidth = 688
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 859
    Height = 419
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pgcCfgImportacaoContabil: TPageControl
      Left = 0
      Top = 0
      Width = 859
      Height = 419
      ActivePage = tbsFolhaPagamento
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tbsFolhaPagamento: TTabSheet
        Caption = '1 - Folha de Pagamento'
        object cxgDados: TcxGridCitel
          Left = 0
          Top = 0
          Width = 851
          Height = 387
          Align = alClient
          TabOrder = 0
          object cxgDadosDBTableViewFolha: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgDadosDBTableViewFolhaCustomDrawCell
            OnEditing = cxgDadosDBTableViewFolhaEditing
            DataController.DataSource = dtsFolha
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgDadosDBTableViewFolhaLAY_SELECI: TcxGridDBColumn
              Caption = 'Selecionado?'
              DataBinding.FieldName = 'SELECI'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Properties.OnEditValueChanged = cxgDadosDBTableViewFolhaLAY_SELECIPropertiesEditValueChanged
              Width = 81
            end
            object cxgDadosDBTableViewFolhaCON_DTALAN: TcxGridDBColumn
              Caption = 'Campo'
              DataBinding.FieldName = 'NOMCAM'
              Options.Editing = False
              Width = 303
            end
            object cxgDadosDBTableViewFolhaPOSINI: TcxGridDBColumn
              Caption = 'Posi'#231#227'o Inicial'
              DataBinding.FieldName = 'POSINI'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.MaxLength = 4
              SortIndex = 0
              SortOrder = soAscending
              Width = 81
            end
            object cxgDadosDBTableViewFolhaTAMANH: TcxGridDBColumn
              Caption = 'Tamanho'
              DataBinding.FieldName = 'TAMANH'
              Width = 91
            end
            object cxgDadosDBTableViewFolhaCON_CCUSTO: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'OBSERV'
              Options.Editing = False
              Width = 338
            end
          end
          object cxgDadosLevel1: TcxGridLevel
            GridView = cxgDadosDBTableViewFolha
          end
        end
      end
      object tbsPatrimonial: TTabSheet
        Caption = '2 - Patrimonial'
        ImageIndex = 1
        object cxGridCitel1: TcxGridCitel
          Left = 0
          Top = 0
          Width = 851
          Height = 387
          Align = alClient
          TabOrder = 0
          object cxGridDBTableViewPatrimonial: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxGridDBTableViewPatrimonialCustomDrawCell
            OnEditing = cxGridDBTableViewPatrimonialEditing
            DataController.DataSource = dtsPatrimonial
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxGridDBTableViewPatrimonialLAY_SELECI: TcxGridDBColumn
              Caption = 'Selecionado?'
              DataBinding.FieldName = 'SELECI'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Properties.OnEditValueChanged = cxGridDBTableViewPatrimonialLAY_SELECIPropertiesEditValueChanged
              Width = 80
            end
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'Campo'
              DataBinding.FieldName = 'NOMCAM'
              Options.Editing = False
              Width = 303
            end
            object cxgDadosDBTableViewPatrimonialPOSINI: TcxGridDBColumn
              Caption = 'Posi'#231#227'o Inicial'
              DataBinding.FieldName = 'POSINI'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.MaxLength = 4
              SortIndex = 0
              SortOrder = soAscending
              Width = 81
            end
            object cxgDadosDBTableViewPatrimonialTAMANH: TcxGridDBColumn
              Caption = 'Tamanho'
              DataBinding.FieldName = 'TAMANH'
              Width = 91
            end
            object cxGridDBColumn4: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'OBSERV'
              Options.Editing = False
              Width = 338
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableViewPatrimonial
          end
        end
      end
      object tbsDimob: TTabSheet
        Caption = '3 - Dimob'
        ImageIndex = 2
        object cxGridCitelDimob: TcxGridCitel
          Left = 0
          Top = 0
          Width = 851
          Height = 387
          Align = alClient
          TabOrder = 0
          object cxGridDBTableViewDimob: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxGridDBTableViewDimobCustomDrawCell
            OnEditing = cxGridDBTableViewDimobEditing
            DataController.DataSource = dtsDimob
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxGridDBTableViewDimobLAY_SELECI: TcxGridDBColumn
              Caption = 'Selecionado?'
              DataBinding.FieldName = 'SELECI'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Properties.OnEditValueChanged = cxGridDBTableViewDimobLAY_SELECIPropertiesEditValueChanged
              Width = 76
            end
            object cxGridDBColumn5: TcxGridDBColumn
              Caption = 'Campo'
              DataBinding.FieldName = 'NOMCAM'
              Options.Editing = False
              Width = 303
            end
            object cxgDadosDBTableViewDimobPOSINI: TcxGridDBColumn
              Caption = 'Posi'#231#227'o Inicial'
              DataBinding.FieldName = 'POSINI'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.MaxLength = 4
              SortIndex = 0
              SortOrder = soAscending
              Width = 81
            end
            object cxGridDBTableViewDimobTAMANH: TcxGridDBColumn
              Caption = 'Tamanho'
              DataBinding.FieldName = 'TAMANH'
              Width = 91
            end
            object cxGridDBColumn8: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'OBSERV'
              Options.Editing = False
              Width = 338
            end
          end
          object cxGridLevel2: TcxGridLevel
            GridView = cxGridDBTableViewDimob
          end
        end
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 64
  end
  object dtsFolha: TDataSource
    Left = 236
    Top = 212
  end
  object dtsPatrimonial: TDataSource
    Left = 300
    Top = 212
  end
  object dtsDimob: TDataSource
    Left = 364
    Top = 212
  end
end
