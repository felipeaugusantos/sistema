inherited frmInconsistenciasItemFatVenda: TfrmInconsistenciasItemFatVenda
  Width = 871
  Height = 432
  Caption = 'Inconsist'#234'ncias'
  ExplicitWidth = 871
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 361
    Width = 865
    ExplicitTop = 361
    ExplicitWidth = 865
    inherited FlwBotoes: TFlowPanel
      Width = 861
      ExplicitWidth = 861
    end
    inherited btnSair: TBitBtnLocked
      Left = 782
      ExplicitLeft = 782
    end
  end
  inherited pnlStatus: TPanel
    Top = 387
    Width = 865
    ExplicitTop = 387
    ExplicitWidth = 865
    inherited pnlNomeForm: TPanel
      Left = 694
      ExplicitLeft = 694
    end
    inherited pnlInfo: TPanel
      Width = 694
      ExplicitWidth = 694
    end
  end
  object pcInconsistencias: TcxPageControl [2]
    Left = 0
    Top = 0
    Width = 865
    Height = 361
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tsInconsistencias
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 357
    ClientRectLeft = 4
    ClientRectRight = 861
    ClientRectTop = 25
    object tsInconsistencias: TcxTabSheet
      Caption = 'Cadastros que n'#227'o ser'#227'o gerados '
      ImageIndex = 0
      object cxGridInconsistencia: TcxGridCitel
        Left = 0
        Top = 0
        Width = 857
        Height = 332
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridInconsistenciaTableView: TcxGridDBTableViewCitel
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
            Width = 461
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridInconsistenciaTableView
        end
      end
    end
    object tsCadastrosGerados: TcxTabSheet
      Caption = 'Cadastros que ser'#227'o gerados  '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridCamposImportados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 857
        Height = 332
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
        object cxGridLevel1: TcxGridLevel
          GridView = cxCamposImportadosTableView
        end
      end
    end
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
  object dtsCadastros: TUniDataSource
    DataSet = cdsCadastros
    Left = 540
    Top = 137
  end
  object cdsCadastros: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsCadastrosBeforePost
    Left = 412
    Top = 137
  end
end
