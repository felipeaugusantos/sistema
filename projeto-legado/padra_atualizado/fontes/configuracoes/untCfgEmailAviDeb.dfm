inherited frmCfgEmailAviDeb: TfrmCfgEmailAviDeb
  Width = 921
  Height = 480
  Caption = 'Gatilhos para disparo de e-mails de aviso de D'#233'bito'
  ExplicitWidth = 921
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 409
    Width = 915
    ExplicitTop = 409
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
    Top = 435
    Width = 915
    ExplicitTop = 435
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
    Height = 409
    Align = alClient
    TabOrder = 2
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 913
      Height = 407
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitelTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEmaSAI
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
          Width = 367
        end
        object EDITOR: TcxGridDBColumn
          Caption = 'Editar'
          DataBinding.FieldName = 'EDITOR'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Editar E-mail'
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
          Width = 260
        end
        object ENVIO: TcxGridDBColumn
          Caption = 'Envio'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Configurar'
              Default = True
              Kind = bkText
            end>
          Properties.ViewStyle = vsButtonsAutoWidth
          Properties.OnButtonClick = ENVIOPropertiesButtonClick
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Styles.Header = cxStyle1
          Width = 165
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
  object dtsEmaSAI: TDataSource
    Left = 200
    Top = 264
  end
end
