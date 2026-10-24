inherited frmDemonstracaoFluxoCaixaContasContabeis: TfrmDemonstracaoFluxoCaixaContasContabeis
  Width = 619
  Height = 287
  Caption = 'Plano Cont'#225'bil'
  ExplicitWidth = 619
  ExplicitHeight = 287
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 216
    Width = 613
    TabOrder = 1
    ExplicitTop = 216
    ExplicitWidth = 613
    inherited FlwBotoes: TFlowPanel
      Width = 609
      ExplicitWidth = 609
    end
    inherited btnSair: TBitBtnLocked
      Left = 533
      ExplicitLeft = 533
    end
  end
  inherited pnlStatus: TPanel
    Top = 242
    Width = 613
    TabOrder = 2
    ExplicitTop = 242
    ExplicitWidth = 613
    inherited pnlNomeForm: TPanel
      Left = 442
      ExplicitLeft = 442
    end
    inherited pnlInfo: TPanel
      Width = 442
      Font.Height = 16
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 442
    end
  end
  object GridPlanco: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 613
    Height = 216
    Align = alClient
    TabOrder = 0
    object GridPlancoView: TcxGridDBTableViewCitel
      OnKeyPress = GridPlancoViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsPlanco
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridPlancoViewSEQLAN: TcxGridDBColumn
        DataBinding.FieldName = 'DFC_SEQLAN'
        Visible = False
        VisibleForCustomization = False
      end
      object GridPlancoViewCODCON: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DFC_CODCON'
        Width = 109
      end
      object GridPlancoViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'NCO_DESCRI'
        Width = 468
      end
    end
    object GridPlancoLevel: TcxGridLevel
      GridView = GridPlancoView
    end
  end
  object dsPlanco: TDataSource
    Left = 392
    Top = 16
  end
end
