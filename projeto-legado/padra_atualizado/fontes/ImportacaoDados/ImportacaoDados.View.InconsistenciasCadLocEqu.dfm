inherited frmInconsistenciasCadLocEqu: TfrmInconsistenciasCadLocEqu
  Width = 818
  Height = 437
  Caption = 'Inconsist'#234'ncias'
  ExplicitWidth = 818
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 366
    Width = 812
    ExplicitTop = 366
    ExplicitWidth = 812
    inherited FlwBotoes: TFlowPanel
      Width = 808
      ExplicitWidth = 808
    end
    inherited btnSair: TBitBtnLocked
      Left = 729
      ExplicitLeft = 729
    end
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 812
    ExplicitTop = 392
    ExplicitWidth = 812
    inherited pnlNomeForm: TPanel
      Left = 641
      ExplicitLeft = 641
    end
    inherited pnlInfo: TPanel
      Width = 641
      ExplicitWidth = 641
    end
  end
  object pcInconsistencias: TcxPageControl [2]
    Left = 0
    Top = 0
    Width = 812
    Height = 366
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tsCadastrosGerados
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 362
    ClientRectLeft = 4
    ClientRectRight = 808
    ClientRectTop = 25
    object tsInconsistencias: TcxTabSheet
      Caption = 'Cadastros que n'#227'o ser'#227'o gerados '
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridCitelInconsistencias: TcxGridCitel
        Left = 0
        Top = 0
        Width = 804
        Height = 337
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewInconsistencias: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsInconsistencias
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridInconsistenciaTableViewLinha: TcxGridDBColumn
            Caption = 'Linha'
            DataBinding.FieldName = 'NROLINHA'
            Width = 58
          end
          object cxGridInconsistenciaTableViewColuna: TcxGridDBColumn
            Caption = 'Coluna'
            DataBinding.FieldName = 'COLUNA'
            Width = 57
          end
          object cxGridInconsistenciaTableViewCampo: TcxGridDBColumn
            Caption = 'Campo'
            DataBinding.FieldName = 'CAMPO'
            Width = 151
          end
          object cxGridInconsistenciaTableViewDescricao: TcxGridDBColumn
            Caption = 'Inconsist'#234'ncia'
            DataBinding.FieldName = 'INCONSISTENCIA'
            MinWidth = 400
            Width = 505
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableViewInconsistencias
        end
      end
    end
    object tsCadastrosGerados: TcxTabSheet
      Caption = 'Cadastros que ser'#227'o gerados  '
      ImageIndex = 1
      object cxGridCamposImportados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 804
        Height = 337
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxCamposImportadosTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = cxCamposImportadosTableViewEditKeyPress
          DataController.DataSource = dtsCadastros
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.CancelOnExit = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object cxGridCamposImportadosDBTableViewAcessorios: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsAcessorios
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object cxGridCamposImportadosDBTableViewNegociacao: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsNegociacao
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object cxGridAcessorios: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Visible = True
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Visible = True
          Navigator.Buttons.Edit.Visible = True
          Navigator.Buttons.Post.Visible = True
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.CancelOnExit = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object cxGridCadastroEql: TcxGridLevel
          Caption = 'Cadastro do Equipamento'
          GridView = cxCamposImportadosTableView
          object cxGridCamposImportadosLevel1: TcxGridLevel
            Caption = 'Acess'#243'rios'
            GridView = cxGridCamposImportadosDBTableViewAcessorios
          end
        end
        object cxGridCamposImportadosLevel2: TcxGridLevel
          Caption = 'Negocia'#231#227'o'
          object cxGridCamposImportadosLevel3: TcxGridLevel
            GridView = cxGridCamposImportadosDBTableViewNegociacao
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 112
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 80
  end
  object cdsInconsistencias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NROLINHA'
        DataType = ftInteger
      end
      item
        Name = 'COLUNA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CAMPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'INCONSISTENCIA'
        DataType = ftString
        Size = 400
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 412
    Top = 65
    object cdsInconsistenciasCOLUNA: TStringField
      FieldName = 'COLUNA'
    end
    object cdsInconsistenciasCAMPO: TStringField
      FieldName = 'CAMPO'
    end
    object cdsInconsistenciasINCONSISTENCIA: TStringField
      DisplayWidth = 300
      FieldName = 'INCONSISTENCIA'
      Size = 300
    end
    object cdsInconsistenciasNROLINHA: TIntegerField
      FieldName = 'NROLINHA'
    end
  end
  object dtsInconsistencias: TUniDataSource
    DataSet = cdsInconsistencias
    Left = 540
    Top = 65
  end
  object cdsCadastros: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsCadastrosBeforePost
    Left = 412
    Top = 137
  end
  object dtsCadastros: TUniDataSource
    DataSet = cdsCadastros
    Left = 540
    Top = 137
  end
  object cdsAcessorios: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsCadastrosBeforePost
    Left = 644
    Top = 65
  end
  object dtsAcessorios: TUniDataSource
    DataSet = cdsAcessorios
    Left = 644
    Top = 137
  end
  object cdsNegociacao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsCadastrosBeforePost
    Left = 740
    Top = 65
  end
  object dtsNegociacao: TUniDataSource
    DataSet = cdsNegociacao
    Left = 740
    Top = 137
  end
end
