inherited frmPedePendenciasNota: TfrmPedePendenciasNota
  Height = 427
  BorderStyle = bsSizeable
  Caption = 'Motivos da Pend'#234'ncia Fiscal'
  ExplicitHeight = 427
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 346
    Width = 473
    inherited FlwBotoes: TFlowPanel
      Width = 469
      inherited btnConfirma: TBitBtnLocked
        Width = 129
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 129
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 393
    end
  end
  inherited pnlStatus: TPanel
    Top = 372
    Width = 473
    inherited pnlNomeForm: TPanel
      Left = 302
    end
    inherited pnlInfo: TPanel
      Width = 302
    end
  end
  object cxgPendencias: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 473
    Height = 346
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 40
    ExplicitTop = 64
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxvPendencias: TcxGridDBTableView
      OnKeyDown = cxvPendenciasKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhuma pend'#234'ncia cadastrada no Cadastro de Pend'#234'ncia Fiscal>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvPendenciasMarcado: TcxGridDBColumn
        Caption = 'Marcar'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object cxvPendenciasColumn2: TcxGridDBColumn
        Caption = 'Motivo'
        DataBinding.FieldName = 'PEN_DESCRI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 393
      end
    end
    object cxgPendenciasLevel1: TcxGridLevel
      GridView = cxvPendencias
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 208
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 64
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
