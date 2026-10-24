inherited frmMapeiaParametrosEdicao: TfrmMapeiaParametrosEdicao
  Width = 1024
  Height = 505
  BorderStyle = bsSizeable
  Caption = 'Mapeia Filtros do Relat'#243'rio'
  ExplicitWidth = 1024
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 424
    Width = 1008
    ExplicitTop = 424
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 450
    Width = 1008
    ExplicitTop = 450
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgParametros: TcxGrid [2]
    Left = 0
    Top = 41
    Width = 1008
    Height = 383
    Align = alClient
    TabOrder = 2
    object cxvParametros: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Relat'#243'rio sem par'#226'metros>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentOdd = cxStyle4
      object cxvParametrosNOMPAR: TcxGridDBColumn
        Caption = 'Par'#226'metro'
        DataBinding.FieldName = 'MAP_NOMPAR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 103
      end
      object cxvParametrosDESPAR: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESPAR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 232
      end
      object cxvParametrosEXIBIR: TcxGridDBColumn
        Caption = 'Exibir'
        DataBinding.FieldName = 'MAP_EXIBIR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxvParametrosEDITAV: TcxGridDBColumn
        Caption = 'Edit'#225'vel'
        DataBinding.FieldName = 'MAP_EDITAV'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 66
      end
      object cxvParametrosTIPATR: TcxGridDBColumn
        Caption = 'Tipo de Atribui'#231#227'o'
        DataBinding.FieldName = 'MAP_TIPATR'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'TIPATR'
        Properties.ListColumns = <
          item
            FieldName = 'DESATR'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        HeaderAlignmentHorz = taCenter
        Width = 108
      end
      object cxvParametrosVALORC: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'MAP_VALORC'
        HeaderAlignmentHorz = taCenter
        Width = 142
      end
      object cxvParametrosPARPAI: TcxGridDBColumn
        Caption = 'Par'#226'metro Pai'
        DataBinding.FieldName = 'MAP_PARPAI'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'PAR_NOMPAR'
        Properties.ListColumns = <
          item
            Width = 80
            FieldName = 'PAR_NOMPAR'
          end
          item
            Width = 200
            FieldName = 'PAR_DESPAR'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxvParametrosNOMCAM: TcxGridDBColumn
        Caption = 'Campo do Relat'#243'rio Pai'
        DataBinding.FieldName = 'MAP_NOMCAM'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CAM_NOMCAM'
        Properties.ListColumns = <
          item
            Width = 80
            FieldName = 'CAM_NOMCAM'
          end
          item
            Width = 200
            FieldName = 'CAM_DESCAM'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
    end
    object cxgParametrosLevel1: TcxGridLevel
      GridView = cxvParametros
    end
  end
  object pnlRotina: TPanel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlRotina'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 344
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 616
    Top = 238
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16770736
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = 14674687
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14548923
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = 14737632
    end
  end
end
