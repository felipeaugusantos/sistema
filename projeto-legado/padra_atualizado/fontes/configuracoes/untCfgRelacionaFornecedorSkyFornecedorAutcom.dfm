inherited frmCfgRelacionaForncedorSkyFornecedorAutcom: TfrmCfgRelacionaForncedorSkyFornecedorAutcom
  Width = 1004
  Height = 638
  Caption = 'Relaciona Fornecedor Sky Pe'#231'as'
  OnDestroy = FormDestroy
  ExplicitWidth = 1004
  ExplicitHeight = 638
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 567
    Width = 998
    ExplicitTop = 567
    ExplicitWidth = 998
    inherited FlwBotoes: TFlowPanel
      Width = 994
      ExplicitWidth = 994
    end
    inherited btnSair: TBitBtnLocked
      Left = 918
      ExplicitLeft = 918
    end
  end
  inherited pnlStatus: TPanel
    Top = 593
    Width = 998
    ExplicitTop = 593
    ExplicitWidth = 998
    inherited pnlNomeForm: TPanel
      Left = 827
      ExplicitLeft = 827
    end
    inherited pnlInfo: TPanel
      Width = 827
      ExplicitWidth = 827
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 998
    Height = 567
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadosDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Bands = <
        item
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxgDadosDBBandedTableViewCitel1SKYCODIGO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'SKYCODIGO'
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDadosDBBandedTableViewCitel1SKYNOME: TcxGridDBBandedColumn
        DataBinding.FieldName = 'SKYNOME'
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDadosDBBandedTableViewCitel1CIDADE: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CIDADE'
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgDadosDBBandedTableViewCitel1UF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'UF'
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgDadosDBBandedTableViewCitel1FOR_CODFOR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'FOR_CODFOR'
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgDadosDBBandedTableViewCitel1FOR_NOMFOR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'FOR_NOMFOR'
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
    end
    object cxvDados: TcxGridDBBandedTableViewCitel
      OnKeyPress = cxvDadosKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxvDadosEditKeyPress
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Fornecedores SKY'
          Width = 594
        end
        item
          Caption = 'Fornecedor Autcom'
          Width = 372
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxvDadosSKY_FORSKY: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'SKY_FORSKY'
        Options.Editing = False
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvDadosSKY_FORAUT: TcxGridDBBandedColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'SKY_FORAUT'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 77
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvDadosSKY_NOMFOR: TcxGridDBBandedColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'SKY_NOMFOR'
        Options.Editing = False
        Width = 256
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvDadosSKY_CIDADE: TcxGridDBBandedColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'SKY_CIDADE'
        Options.Editing = False
        Width = 162
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvDadosSKY_FOR_UF: TcxGridDBBandedColumn
        Caption = 'UF'
        DataBinding.FieldName = 'SKY_FOR_UF'
        Options.Editing = False
        Width = 23
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvDadosSKY_TELEFO: TcxGridDBBandedColumn
        Caption = 'Telefone'
        DataBinding.FieldName = 'SKY_TELEFO'
        Options.Editing = False
        Width = 93
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvDadosFOR_NOMFOR: TcxGridDBBandedColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.Editing = False
        Width = 295
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 48
  end
  object dtsDados: TDataSource
    Left = 584
    Top = 312
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
end
