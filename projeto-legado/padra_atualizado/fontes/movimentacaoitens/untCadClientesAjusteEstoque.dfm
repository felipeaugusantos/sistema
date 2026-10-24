inherited frmCadClientesAjusteEstoque: TfrmCadClientesAjusteEstoque
  Width = 805
  Height = 528
  BorderStyle = bsSizeable
  Caption = 'Clientes para Ajuste de Estoque'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 805
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 0
    Top = 430
    Width = 789
    Height = 15
    Align = alBottom
    Caption = 
      '  [ Insert ] - Inserir novo Registro     [ Delete ] - Excluir Re' +
      'gistro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 332
  end
  inherited pnlBotoes: TPanel
    Top = 445
    Width = 789
    ExplicitTop = 445
    ExplicitWidth = 789
    inherited FlwBotoes: TFlowPanel
      Width = 785
      ExplicitWidth = 785
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 25
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 708
      ExplicitLeft = 708
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 789
    ExplicitTop = 473
    ExplicitWidth = 789
    inherited pnlNomeForm: TPanel
      Left = 618
      ExplicitLeft = 618
    end
    inherited pnlInfo: TPanel
      Width = 618
      ExplicitWidth = 618
    end
  end
  object cxgClientes: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 789
    Height = 430
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvClientes: TcxGridDBTableView
      OnKeyDown = cxvClientesKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxvClientesEditKeyPress
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique para definir um filtro'
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      object cxvClientesCAJ_CLIPRI: TcxGridDBColumn
        Caption = 'Padr'#227'o'
        DataBinding.FieldName = 'CAJ_CLIPRI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxvClientesCAJ_CODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CAJ_CODCLI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxvClientesCAJ_CODCLIPropertiesValidate
        Width = 87
      end
      object cxvClientesCLI_NOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        OnGetDisplayText = cxvClientesCLI_NOMCLIGetDisplayText
        Options.Editing = False
        Width = 510
      end
    end
    object cxgClientesLevel1: TcxGridLevel
      GridView = cxvClientes
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 176
  end
  object dtsTabela: TDataSource
    Left = 648
    Top = 16
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 176
    Top = 160
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
