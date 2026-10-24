inherited frmFatSelCliCon: TfrmFatSelCliCon
  Width = 549
  Height = 424
  BorderIcons = [biSystemMenu]
  Caption = 'Cliente Consumidor'
  Position = poMainFormCenter
  ExplicitWidth = 549
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 543
    ParentFont = False
    ExplicitTop = 352
    ExplicitWidth = 543
    object lbl1: TLabel [0]
      Left = 2
      Top = 2
      Width = 539
      Height = 24
      Align = alClient
      Alignment = taCenter
      Caption = 'PRESSIONE [ ENTER ] PARA SELECIONAR O CONSUMIDOR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 296
      ExplicitHeight = 14
    end
    inherited btnSair: TBitBtnLocked
      Left = 460
      ExplicitLeft = 460
    end
  end
  object gridConsumidores: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 543
    Height = 352
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object gridConsumidoresDBTableView1: TcxGridDBTableView
      OnKeyDown = gridConsumidoresDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsCadEmp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' dados para exibir'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object gridConsumidoresDBTableView1CGCCPF: TcxGridDBColumn
        DataBinding.FieldName = 'CGCCPF'
        Visible = False
        Options.Moving = False
      end
      object gridConsumidoresDBTableView1NOMCON: TcxGridDBColumn
        DataBinding.FieldName = 'NOMCON'
        Options.Moving = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 311
      end
      object gridConsumidoresDBTableView1CGCCON: TcxGridDBColumn
        DataBinding.FieldName = 'CGCCON'
        OnGetDisplayText = gridConsumidoresDBTableView1CGCCONGetDisplayText
        Options.Moving = False
      end
      object gridConsumidoresDBTableView1QTDPEN: TcxGridDBColumn
        Caption = 'PEND'#202'NCIAS'
        DataBinding.FieldName = 'QTDPEN'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Moving = False
        Width = 76
      end
    end
    object gridConsumidoresLevel1: TcxGridLevel
      GridView = gridConsumidoresDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 380
    Width = 543
    ExplicitTop = 380
    ExplicitWidth = 543
    inherited pnlNomeForm: TPanel
      Left = 372
      ExplicitLeft = 372
    end
    inherited pnlInfo: TPanel
      Width = 372
      ExplicitWidth = 372
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 32
  end
  object cdsCliCon: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadEmp'
    Left = 424
    Top = 32
    object cdsCliConCGCCPF: TStringField
      FieldName = 'CGCCPF'
      Size = 1
    end
    object cdsCliConCGCCON: TStringField
      DisplayLabel = 'C.N.P.J / C.P.F'
      FieldName = 'CGCCON'
      Size = 18
    end
    object cdsCliConNOMCON: TStringField
      DisplayLabel = 'NOME DO CLIENTE'
      FieldName = 'NOMCON'
      Size = 40
    end
    object cdsCliConQTDDOC: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'QTDE. PEND.'
      FieldName = 'QTDPEN'
    end
  end
  object dtsCadEmp: TDataSource
    DataSet = cdsCliCon
    Left = 456
    Top = 32
  end
end
