inherited frmInconsistenciasProspecto: TfrmInconsistenciasProspecto
  Width = 778
  Height = 433
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Inconsist'#234'ncias'
  ExplicitWidth = 778
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 762
    ExplicitTop = 352
    ExplicitWidth = 762
    inherited FlwBotoes: TFlowPanel
      Width = 758
      ExplicitWidth = 758
    end
    inherited btnSair: TBitBtnLocked
      Left = 682
      ExplicitLeft = 682
    end
  end
  inherited pnlStatus: TPanel
    Top = 378
    Width = 762
    ExplicitTop = 378
    ExplicitWidth = 762
    inherited pnlNomeForm: TPanel
      Left = 591
      ExplicitLeft = 591
    end
    inherited pnlInfo: TPanel
      Width = 591
      ExplicitWidth = 591
    end
  end
  object pcInconsistencias: TcxPageControl [2]
    Left = 0
    Top = 0
    Width = 762
    Height = 352
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tsCadastrosGerados
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 348
    ClientRectLeft = 4
    ClientRectRight = 758
    ClientRectTop = 25
    object tsInconsistencias: TcxTabSheet
      Caption = 'Cadastros que n'#227'o ser'#227'o gerados '
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridCitel2: TcxGridCitel
        Left = 0
        Top = 0
        Width = 754
        Height = 323
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitel2: TcxGridDBTableViewCitel
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
          GridView = cxGridDBTableViewCitel2
        end
      end
    end
    object tsCadastrosGerados: TcxTabSheet
      Caption = 'Cadastros que ser'#227'o gerados  '
      ImageIndex = 1
      object cxGridCamposImportados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 754
        Height = 323
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 128
    Top = 160
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
end
