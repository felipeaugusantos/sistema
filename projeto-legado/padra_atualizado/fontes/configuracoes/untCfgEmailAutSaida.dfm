inherited frmCfgEmailAutSaida: TfrmCfgEmailAutSaida
  Width = 921
  Height = 577
  Caption = 'Gatilhos para disparo de Email'
  ExplicitWidth = 921
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 506
    Width = 915
    TabOrder = 1
    ExplicitTop = 506
    ExplicitWidth = 915
    inherited FlwBotoes: TFlowPanel
      Width = 834
      ExplicitWidth = 834
    end
    inherited btnSair: TBitBtnLocked
      Left = 836
      Top = 2
      Align = alRight
      ExplicitLeft = 836
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 532
    Width = 915
    TabOrder = 2
    ExplicitTop = 532
    ExplicitWidth = 915
    inherited pnlNomeForm: TPanel
      Left = 744
      ExplicitLeft = 744
    end
    inherited pnlInfo: TPanel
      Width = 744
      ExplicitWidth = 744
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 915
    Height = 506
    Align = alClient
    TabOrder = 0
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 41
      Width = 913
      Height = 464
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitelTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEmaSai
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
              Caption = 'Editar Email'
              Default = True
              Kind = bkText
              LeftAlignment = True
            end>
          Properties.ViewStyle = vsButtonsAutoWidth
          Properties.OnButtonClick = EDITORPropertiesButtonClick
          OnGetProperties = EDITORGetProperties
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 237
        end
        object ENVIO: TcxGridDBColumn
          Caption = 'Envio'
          DataBinding.FieldName = 'PROENV'
          PropertiesClassName = 'TcxRadioGroupProperties'
          Properties.DefaultValue = 'O'
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Operador Logado'
              Value = 'O'
            end
            item
              Caption = 'Email Fixo'
              Value = 'F'
            end>
          Properties.OnChange = ENVIOPropertiesChange
          OnGetProperties = ENVIOGetProperties
          Options.Filtering = False
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 237
        end
        object CODEMA: TcxGridDBColumn
          DataBinding.FieldName = 'CODEMA'
          Visible = False
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitelTableView
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 913
      Height = 40
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object chkEmaSai: TCheckBox
        Left = 8
        Top = 13
        Width = 97
        Height = 17
        Caption = 'Utilizar rotina'
        TabOrder = 0
        OnClick = chkEmaSaiClick
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
  object dtsEmaSai: TDataSource
    Left = 208
    Top = 304
  end
  object cxEditRepository1: TcxEditRepository
    Left = 544
    Top = 88
    PixelsPerInch = 96
    object cxEditRepository1Botao: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Email'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepository1BotaoPropertiesButtonClick
    end
    object cxEditRepository2Botoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Email'
          Default = True
          Kind = bkText
        end
        item
          Caption = 'Portadores Autor.'
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepository1BotaoPropertiesButtonClick
    end
    object cxEditRepository3Botoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Email'
          Default = True
          Kind = bkText
        end
        item
          Caption = 'Portadores Autor.'
          Kind = bkText
        end
        item
          Caption = 'Editar Clientes'
          Kind = bkText
        end>
      Properties.OnButtonClick = cxEditRepository1BotaoPropertiesButtonClick
    end
    object cxEditRepository1Label1: TcxEditRepositoryLabel
    end
    object cxEditRepository1BtnOpcEnvioEmailCob: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Op'#231#245'es de envio'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepository1BtnOpcEnvioEmailCobPropertiesButtonClick
    end
    object cxEditRepository1btnEmailFixo: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Configurar'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = cxEditRepository1btnEmailFixoPropertiesButtonClick
    end
    object cxEditRepository1BtnEditarBtnOpcoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Editar Email'
          Default = True
          Kind = bkText
        end
        item
          Caption = 'Op'#231#245'es de Envio'
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnButtonClick = cxEditRepository1BtnEditarBtnOpcoesPropertiesButtonClick
    end
  end
end
