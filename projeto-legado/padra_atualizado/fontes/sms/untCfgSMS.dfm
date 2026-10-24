inherited frmCfgSMS: TfrmCfgSMS
  Width = 867
  Height = 562
  Caption = 'Gatilhos para disparo de SMS'
  ExplicitWidth = 867
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 491
    Width = 861
    ExplicitTop = 491
    ExplicitWidth = 861
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 782
      Top = 2
      Align = alRight
      ExplicitLeft = 782
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 517
    Width = 861
    ExplicitTop = 517
    ExplicitWidth = 861
    inherited pnlNomeForm: TPanel
      Left = 690
      ExplicitLeft = 690
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 861
    Height = 491
    Align = alClient
    TabOrder = 2
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 859
      Height = 489
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
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
          OnGetProperties = ATIVOGetProperties
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
              LeftAlignment = True
            end>
          Properties.ViewStyle = vsButtonsAutoWidth
          OnGetProperties = EDITORGetProperties
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 160
        end
        object ROBO: TcxGridDBColumn
          Caption = 'Robo'
          DataBinding.FieldName = 'MDROBO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Properties.OnEditValueChanged = ROBOPropertiesEditValueChanged
          OnGetProperties = ROBOGetProperties
          Options.Filtering = False
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 63
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
  object cxEditRepository1: TcxEditRepository
    Left = 544
    Top = 88
    PixelsPerInch = 96
    object cxEditRepositoryBotaoEditarSMS: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar SMS'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepositoryBotaoEditarSMSPropertiesButtonClick
    end
    object cxEditRepositoryBotaoOpcEnvio: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Op'#231#245'es de Envio'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepositoryBotaoOpcEnvioPropertiesButtonClick
    end
    object cxEditRepository1Label: TcxEditRepositoryLabel
    end
    object cxEditRepositoryBotaoEditarSMSPortador: TcxEditRepositoryButtonItem
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
      Properties.OnButtonClick = cxEditRepositoryBotaoEditarSMSPortadorPropertiesButtonClick
    end
  end
end
