inherited frmConfirmaAlteracaoRepVen: TfrmConfirmaAlteracaoRepVen
  Width = 1085
  Height = 670
  Caption = 'Confima'#231#227'o - Troca de Vendedores / Representantes'
  Position = poScreenCenter
  OnResize = FormResize
  ExplicitWidth = 1085
  ExplicitHeight = 670
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 558
    Width = 1079
    ExplicitTop = 558
    ExplicitWidth = 1079
    inherited FlwBotoes: TFlowPanel
      Width = 1075
      ExplicitWidth = 1075
    end
  end
  inherited pnlStatus: TPanel
    Top = 625
    Width = 1079
    ExplicitTop = 625
    ExplicitWidth = 1079
    inherited pnlNomeForm: TPanel
      Left = 908
      ExplicitLeft = 908
    end
    inherited pnlInfo: TPanel
      Width = 908
      ExplicitWidth = 908
    end
  end
  inherited pgcDados: TPageControl
    Left = 692
    Top = 128
    Width = 69
    Height = 41
    Align = alNone
    ExplicitLeft = 692
    ExplicitTop = 128
    ExplicitWidth = 69
    ExplicitHeight = 41
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 61
      ExplicitHeight = 9
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 599
    Width = 1079
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      1079
      26)
    object FlowPanel1: TFlowPanel
      Left = 2
      Top = 2
      Width = 1075
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F10] &Confirma'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F5] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 249
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F6] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 996
      Top = 1
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'C&ancela'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 2
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 576
    Width = 1079
    Height = 23
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      1079
      23)
    object shpLegendaSelecionados: TShape
      Left = 12
      Top = 5
      Width = 13
      Height = 14
      Brush.Color = clAqua
    end
    object lblSelecionados: TLabel
      Left = 31
      Top = 5
      Width = 186
      Height = 14
      Caption = 'Registros selecionados para altera'#231#227'o'
    end
    object lblLegendaQtdSel: TLabel
      Left = 810
      Top = 5
      Width = 214
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Quantidade de registros selecionados:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 828
    end
    object lblQtdSel: TLabel
      Left = 1067
      Top = 5
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 1085
    end
  end
  object pnlBottom: TPanel [5]
    Left = 0
    Top = 558
    Width = 1079
    Height = 18
    Align = alBottom
    Caption = '[ENTER] ou Duplo Clique -  Marca / Desmarca Registro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object cxGrid: TcxGridCitel [6]
    Left = 0
    Top = 0
    Width = 1079
    Height = 558
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridTBV: TcxGridDBTableView
      OnKeyDown = cxGridTBVKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridTBVCellDblClick
      OnCustomDrawCell = cxGridTBVCustomDrawCell
      DataController.DataSource = dtsGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar os pedidos'
      FilterRow.ApplyChanges = fracDelayed
      FilterRow.ApplyInputDelay = 500
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideSelection = True
      OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridTBVCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        Width = 70
      end
      object cxGridTBVNOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'NOMCLI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        MinWidth = 300
        Options.Editing = False
        Width = 375
      end
      object cxGridTBVVENREPANT: TcxGridDBColumn
        Caption = 'Vend/Rep Anterior'
        DataBinding.FieldName = 'VENREPANT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        Width = 300
      end
      object cxGridTBVVENREPNOV: TcxGridDBColumn
        Caption = 'Vend/Rep Novo'
        DataBinding.FieldName = 'VENREPNOV'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        Width = 200
      end
      object cxGridTBVULTCOM: TcxGridDBColumn
        Caption = 'Data '#218'ltima Compra'
        DataBinding.FieldName = 'ULTCOM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object cxGridTBVMARDES: TcxGridDBColumn
        Caption = 'Marcado'
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 72
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 24
  end
  object dtsGrid: TDataSource
    Left = 176
    Top = 88
  end
end
