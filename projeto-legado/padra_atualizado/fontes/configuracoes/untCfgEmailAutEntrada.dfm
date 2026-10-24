inherited frmCfgEmailAutEntrada: TfrmCfgEmailAutEntrada
  Width = 867
  Height = 562
  Caption = 'Gatilhos para disparo de Email'
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
        DataController.DataSource = dtsEmaEnt
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
        object DIAS: TcxGridDBColumn
          Caption = 'Dias'
          DataBinding.FieldName = 'QTDIAS'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.AssignedValues.MinValue = True
          Properties.AutoSelect = False
          Properties.ImmediatePost = True
          Properties.ValueType = vtInt
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Sorting = False
          Styles.Header = cxStyle1
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
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 151
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
          Options.Filtering = False
          Options.Sorting = False
          Styles.Header = cxStyle1
          Width = 189
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
  object dtsEmaEnt: TDataSource
    Left = 208
    Top = 304
  end
end
