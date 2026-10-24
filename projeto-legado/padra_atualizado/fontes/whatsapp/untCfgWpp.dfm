inherited frmCfgWpp: TfrmCfgWpp
  Width = 1080
  Height = 493
  Caption = 'Gatilhos para disparo de Whatsapp'
  ExplicitWidth = 1080
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 422
    Width = 1074
    ExplicitTop = 422
    ExplicitWidth = 1074
    inherited FlwBotoes: TFlowPanel
      Width = 1070
      ExplicitWidth = 1070
    end
    inherited btnSair: TBitBtnLocked
      Left = 991
      ExplicitLeft = 991
    end
  end
  inherited pnlStatus: TPanel
    Top = 448
    Width = 1074
    ExplicitTop = 448
    ExplicitWidth = 1074
    inherited pnlNomeForm: TPanel
      Left = 903
      ExplicitLeft = 903
    end
    inherited pnlInfo: TPanel
      Width = 903
      ExplicitWidth = 903
    end
  end
  object cxGridCitel1: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1074
    Height = 422
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridCitelTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsWPPSAI
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
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'A'
        Properties.ValueUnchecked = 'I'
        Properties.OnEditValueChanged = ATIVOPropertiesEditValueChanged
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
        Width = 428
      end
      object EDITOR: TcxGridDBColumn
        Caption = 'Editar'
        DataBinding.FieldName = 'EDITOR'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Editar Mensagem'
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
        Width = 190
      end
      object FAIXAIN: TcxGridDBColumn
        Caption = 'Hr. Ini. Envio'
        DataBinding.FieldName = 'FXHRIN'
        OnGetProperties = FAIXAINGetProperties
        Styles.Header = cxStyle1
        Width = 80
      end
      object FAIXAFN: TcxGridDBColumn
        Caption = 'Hr. Fin. Envio'
        DataBinding.FieldName = 'FXHRFN'
        OnGetProperties = FAIXAFNGetProperties
        Styles.Header = cxStyle1
        Width = 80
      end
      object FILA: TcxGridDBColumn
        Caption = 'Fila'
        DataBinding.FieldName = 'FILWPP'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'AUTOINCREM'
        Properties.ListColumns = <
          item
            FieldName = 'FIL_IDFILA'
          end
          item
            FieldName = 'FIL_DESFIL'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dtsFilas
        Properties.ReadOnly = False
        MinWidth = 215
        Options.Filtering = False
        Options.IncSearch = False
        Options.ShowEditButtons = isebAlways
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Styles.Header = cxStyle1
        Width = 215
      end
      object CODWPP: TcxGridDBColumn
        DataBinding.FieldName = 'CODWPP'
        Visible = False
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitelTableView
    end
  end
  object dtsWPPSAI: TDataSource
    Left = 208
    Top = 304
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
  object cxEditRepository1: TcxEditRepository
    Left = 544
    Top = 88
    PixelsPerInch = 96
    object cxEditRepositoryBotaoEditarWPP: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Mensagem'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepositoryBotaoEditarWPPPropertiesButtonClick
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
    object cxEditRepositoryBotaoEditarWPPPortador: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Mensagem'
          Default = True
          Kind = bkText
        end
        item
          Caption = 'Portadores Autor.'
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepositoryBotaoEditarWPPPortadorPropertiesButtonClick
    end
    object cxEditRepositoryMskHora: TcxEditRepositoryMaskItem
      Properties.EditMask = '90:00;1;_'
      Properties.ValidationOptions = []
    end
    object cxEditRepositoryTxtHoraDisable: TcxEditRepositoryTextItem
      Properties.ReadOnly = True
    end
    object cxEditRepositoryBotaoEditarWPPOpcEnvio: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Mensagem'
          Kind = bkText
        end
        item
          Caption = 'Op'#231#245'es de Envio'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepositoryBotaoEditarWPPOpcEnvioPropertiesButtonClick
    end
  end
  object dtsFilas: TDataSource
    Left = 104
    Top = 212
  end
end
