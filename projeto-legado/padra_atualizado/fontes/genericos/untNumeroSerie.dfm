inherited frmNumeroSerie: TfrmNumeroSerie
  Width = 556
  Height = 685
  Caption = 'Informe os N'#250'meros de S'#233'rie'
  OnDestroy = FormDestroy
  ExplicitWidth = 556
  ExplicitHeight = 685
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 614
    Width = 550
    ExplicitTop = 614
    ExplicitWidth = 550
    inherited FlwBotoes: TFlowPanel
      Width = 546
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      ExplicitLeft = 467
    end
  end
  inherited pnlStatus: TPanel
    Top = 640
    Width = 550
    ExplicitTop = 640
    ExplicitWidth = 550
    inherited pnlNomeForm: TPanel
      Left = 379
      ExplicitLeft = 379
    end
    inherited pnlInfo: TPanel
      Width = 379
      ExplicitWidth = 379
    end
  end
  object cxDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 550
    Height = 614
    Align = alClient
    TabOrder = 2
    object cxDadosTbl: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxDadosTblEditKeyDown
      OnInitEdit = cxDadosTblInitEdit
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Styles.ContentOdd = cxStyle1
      object cxDadosLinha: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'LINHA'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object cxDadosNUMSER: TcxGridDBColumn
        Caption = 'N'#250'mero de S'#233'rie'
        DataBinding.FieldName = 'SER_NUMSER'
        Width = 397
      end
      object cxDadosMarcado: TcxGridDBColumn
        DataBinding.FieldName = 'MARCADO'
        Visible = False
      end
    end
    object cxDadosLvl: TcxGridLevel
      GridView = cxDadosTbl
    end
  end
  object dtsDados: TDataSource
    Left = 352
    Top = 228
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 68
    Top = 8
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
