object FrameAlteraPrecoIndividual: TFrameAlteraPrecoIndividual
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object cxgTiposAlt: TcxGrid
    Left = 0
    Top = 0
    Width = 893
    Height = 305
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 451
    object cxvTiposAlt: TcxGridDBBandedTableView
      OnKeyPress = cxvTiposAltKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvTiposAltCustomDrawCell
      OnEditKeyDown = cxvTiposAltEditKeyDown
      OnEditKeyPress = cxvTiposAltEditKeyPress
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnCompare = cxvTiposAltDataControllerCompare
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro encontrado>'
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.FixedBandSeparatorWidth = 0
      OnColumnSizeChanged = cxvTiposAltColumnSizeChanged
      Bands = <
        item
          FixedKind = fkLeft
          Width = 354
        end
        item
          Width = 114
        end>
      OnBandSizeChanged = cxvTiposAltBandSizeChanged
      object cxvTiposAltColumn1: TcxGridDBBandedColumn
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgTiposAltLevel1: TcxGridLevel
      GridView = cxvTiposAlt
    end
  end
  object chkSuspendeOrdenacao: TCheckBox
    Left = 32
    Top = 285
    Width = 219
    Height = 17
    Caption = 'N'#227'o reordenar os itens ao editar'
    TabOrder = 1
    Visible = False
    OnClick = chkSuspendeOrdenacaoClick
  end
end
