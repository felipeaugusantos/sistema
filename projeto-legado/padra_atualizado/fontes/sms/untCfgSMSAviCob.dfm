inherited frmCfgSMSAviCob: TfrmCfgSMSAviCob
  Width = 642
  Height = 355
  Caption = 'Gatilhos para disparo de SMS'
  ExplicitWidth = 642
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 284
    Width = 636
    ExplicitTop = 277
    ExplicitWidth = 596
    inherited FlwBotoes: TFlowPanel
      Width = 555
      ExplicitWidth = 515
    end
    inherited btnSair: TBitBtnLocked
      Left = 557
      Top = 2
      Align = alRight
      ExplicitLeft = 517
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    Width = 636
    ExplicitTop = 303
    ExplicitWidth = 596
    inherited pnlNomeForm: TPanel
      Left = 465
      ExplicitLeft = 425
    end
    inherited pnlInfo: TPanel
      Width = 465
      ExplicitWidth = 425
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 636
    Height = 284
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 596
    ExplicitHeight = 277
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 634
      Height = 282
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 594
      ExplicitHeight = 275
      object cxGridCitelTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsSMSSAI
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object GRUPO: TcxGridDBColumn
          Caption = 'Grupos'
          DataBinding.FieldName = 'GRUPOS'
          PropertiesClassName = 'TcxLabelProperties'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          Options.Filtering = False
          Options.CellMerging = True
          Options.Sorting = False
          Styles.Content = cxStyle1
          Styles.GroupSummary = cxStyle1
          Styles.Header = cxStyle1
          Width = 328
        end
        object ATIVO: TcxGridDBColumn
          Caption = 'Ativo'
          DataBinding.FieldName = 'STATUS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'A'
          Properties.ValueUnchecked = 'I'
          Options.Filtering = False
          Options.Sorting = False
          Styles.Header = cxStyle1
        end
        object DESCRIÇÃO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Options.Editing = False
          Options.Filtering = False
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 343
        end
        object EDITOR: TcxGridDBColumn
          Caption = 'Editar'
          DataBinding.FieldName = 'EDITOR'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Editar SMS'
              Default = True
              Kind = bkText
            end
            item
              Caption = 'Portadores Autor.'
              Kind = bkText
            end>
          Properties.ViewStyle = vsButtonsAutoWidth
          Properties.OnButtonClick = EDITORPropertiesButtonClick
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 190
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitelTableView
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 432
    Top = 88
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsSMSSAI: TDataSource
    Left = 208
    Top = 304
  end
end
