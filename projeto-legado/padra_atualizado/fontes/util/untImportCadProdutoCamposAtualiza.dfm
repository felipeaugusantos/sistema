inherited frmImportCadProdutoCamposAtualiza: TfrmImportCadProdutoCamposAtualiza
  Width = 500
  Height = 750
  Caption = 'Sele'#231#227'o de Campos para Atualiza'#231#227'o'
  ExplicitWidth = 500
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 679
    Width = 494
    ExplicitTop = 679
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Width = 490
      ExplicitWidth = 490
    end
    inherited btnSair: TBitBtnLocked
      Left = 414
      ExplicitLeft = 414
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 494
    ExplicitTop = 705
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
    end
  end
  object cxGroupBox3: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alClient
    Caption = 'Os campos marcados ser'#227'o atualizados'
    ParentFont = False
    Style.BorderColor = clBlack
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = 14
    Style.Font.Name = 'Arial'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = []
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = True
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    TabOrder = 2
    Height = 679
    Width = 494
    object lblOpSele: TLabel
      Left = 2
      Top = 660
      Width = 487
      Height = 14
      Cursor = crHandPoint
      Align = alBottom
      Caption = 'Op'#231#245'es de Sele'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblOpSeleClick
      ExplicitWidth = 95
    end
    object cxGrid: TcxGrid
      Left = 2
      Top = 19
      Width = 487
      Height = 641
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvCampos: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsCampos
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxvCamposColuna: TcxGridDBColumn
          Caption = 'Coluna'
          DataBinding.FieldName = 'COLUNA'
          Options.Editing = False
          Options.Focusing = False
          Options.Sorting = False
          Width = 20
        end
        object cxvCamposDescricao: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 150
        end
        object cxvCamposMARDES: TcxGridDBColumn
          Caption = 'Selecione:'
          DataBinding.FieldName = 'MARDES'
          RepositoryItem = chkMarDes
          HeaderAlignmentHorz = taCenter
          Options.Filtering = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Width = 30
        end
        object cxvCamposIndex: TcxGridDBColumn
          DataBinding.FieldName = 'INDEX'
          Visible = False
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxvCampos
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 72
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 104
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 8
    Top = 256
  end
  object dtsCampos: TDataSource
    DataSet = cdsCampos
    Left = 104
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 374
    Top = 320
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clMoneyGreen
      TextColor = clBlack
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 438
    Top = 320
    PixelsPerInch = 96
    object chkMarDes: TcxEditRepositoryCheckBoxItem
      Properties.ImmediatePost = True
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 502
    Top = 322
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 320
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object popOpSele: TPopupMenu
    Left = 56
    Top = 200
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
  object cdsCampos: TUniClientDataSet
    PersistDataPacket.Data = {
      930000009619E0BD010000001800000005000000000003000000930006444553
      435249010049000000010005574944544802000200320006434F4C554E410100
      490000000100055749445448020002000300064D415244455301004900000001
      0005574944544802000200010005494E4445580400010000000000054649454C
      440100490000000100055749445448020002000A000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DESCRI'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'COLUNA'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MARDES'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDEX'
        DataType = ftInteger
      end
      item
        Name = 'FIELD'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 8
    Top = 200
    object cdsCamposDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 50
    end
    object cdsCamposCOLUNA: TStringField
      FieldName = 'COLUNA'
      Size = 3
    end
    object cdsCamposMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsCamposINDEX: TIntegerField
      FieldName = 'INDEX'
    end
    object cdsCamposFIELD: TStringField
      FieldName = 'FIELD'
      Size = 10
    end
  end
end
