inherited frmAgrupamentoDeOndaDeSeparacao: TfrmAgrupamentoDeOndaDeSeparacao
  Width = 1000
  Height = 555
  Caption = 'Painel de Remessa de Separa'#231#227'o'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1000
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 482
    Width = 994
    TabOrder = 4
    ExplicitTop = 482
    ExplicitWidth = 994
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
      object btnAgrupar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '[F10] Agrupar'
        TabOrder = 0
        OnClick = btnAgruparClick
      end
      object btnGerarRemessaDeSeparacao: TBitBtnLocked
        Left = 90
        Top = 0
        Width = 193
        Height = 22
        Caption = '[F10] Gerar Remessa de Separa'#231#227'o'
        TabOrder = 1
        OnClick = btnGerarRemessaDeSeparacaoClick
      end
      object btnDesagrupar: TBitBtnLocked
        Left = 283
        Top = 0
        Width = 135
        Height = 22
        Caption = '[F6] Cancelar Remessa'
        TabOrder = 2
        OnClick = btnDesagruparClick
      end
      object btnReimpressao: TBitBtnLocked
        Left = 418
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F7] Imprimir Remessa'
        TabOrder = 3
        OnClick = btnReimpressaoClick
      end
      object btnAlterarLocalizacao: TBitBtnLocked
        Left = 554
        Top = 0
        Width = 168
        Height = 22
        Caption = '[F8] Alterar Loc. de Separa'#231#227'o'
        TabOrder = 4
        OnClick = btnAlterarLocalizacaoClick
      end
      object btnPesquisarPedido: TBitBtnLocked
        Left = 722
        Top = 0
        Width = 168
        Height = 22
        Caption = '[F9] Pesquisar Pedido'
        TabOrder = 5
        OnClick = btnPesquisarPedidoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 914
    end
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 994
    TabOrder = 5
    ExplicitTop = 510
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 694
      Width = 300
      ExplicitLeft = 694
      ExplicitWidth = 300
    end
    inherited pnlInfo: TPanel
      Width = 694
      ExplicitWidth = 694
    end
  end
  object pnlLegendas: TPanel [2]
    Left = 0
    Top = 426
    Width = 994
    Height = 26
    Align = alBottom
    TabOrder = 2
    object lblOndaKits: TLabel
      Left = 275
      Top = 6
      Width = 28
      Height = 14
      Caption = 'Kits'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpOndaKits: TShape
      Left = 257
      Top = 7
      Width = 12
      Height = 12
      Brush.Color = clMoneyGreen
    end
    object lblOndaUnitario: TLabel
      Left = 162
      Top = 6
      Width = 63
      Height = 14
      Caption = 'Unit'#225'rios'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpOndaUnitario: TShape
      Left = 144
      Top = 7
      Width = 12
      Height = 12
    end
    object shpOndaCarrinho: TShape
      Left = 333
      Top = 7
      Width = 12
      Height = 12
      Brush.Color = 15128731
    end
    object lblOndaCarrinho: TLabel
      Left = 351
      Top = 6
      Width = 63
      Height = 14
      Caption = 'Carrinhos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblRemessaPedido: TLabel
      Left = 7
      Top = 6
      Width = 126
      Height = 14
      Caption = 'Remessa de pedido:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlRemessaDeSeparacao_01: TPanel [3]
    Left = 0
    Top = 0
    Width = 994
    Height = 30
    Align = alTop
    Caption = 'Remessa de Separa'#231#227'o - 000000000000 '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Visible = False
  end
  object pnlRemessaDeSeparacao_02: TPanel [4]
    Left = 0
    Top = 452
    Width = 994
    Height = 30
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    object btnMarcarTodos: TBitBtnLocked
      Left = 2
      Top = 4
      Width = 136
      Height = 22
      Caption = 'Marcar Todos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarcarTodos: TBitBtnLocked
      Left = 144
      Top = 4
      Width = 136
      Height = 22
      Caption = 'Desmarcar Todos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDesmarcarTodosClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 286
      Top = 4
      Width = 136
      Height = 22
      Caption = 'Imprimir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnImprimirClick
    end
  end
  object cxgOndas: TcxGrid [5]
    Left = 0
    Top = 30
    Width = 994
    Height = 396
    Align = alClient
    TabOrder = 1
    object cxgOndasDBTableView: TcxGridDBTableView
      OnKeyPress = cxgOndasDBTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxgOndasDBTableViewCellClick
      OnCellDblClick = cxgOndasDBTableViewCellDblClick
      OnCustomDrawCell = cxgOndasDBTableViewCustomDrawCell
      DataController.DataSource = dtsOndas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
      OptionsView.ShowEditButtons = gsebAlways
      object cxgOndasDBTableViewONDFIN: TcxGridDBColumn
        Caption = 'N'#186' Remessa de Pedido'
        DataBinding.FieldName = 'ONDFIN'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 140
      end
      object cxgOndasDBTableViewONDGRO: TcxGridDBColumn
        Caption = 'N'#186' Remessa de Separa'#231#227'o'
        DataBinding.FieldName = 'ONDGRO'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 140
      end
      object cxgOndasDBTableViewTIPPED: TcxGridDBColumn
        Caption = 'Tipo de Pedido'
        DataBinding.FieldName = 'TIPPED'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
      end
      object cxgOndasDBTableViewBUTTON: TcxGridDBColumn
        Caption = 'Docs. Remessa de Pedidos'
        DataBinding.FieldName = 'BUTTON'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DefaultImageIndex = 0
        Properties.Images = cxiImagens
        Properties.ImmediateDropDownWhenKeyPressed = False
        Properties.Items = <>
        Properties.ReadOnly = True
        Properties.ShowDescriptions = False
        Options.Editing = False
        Options.Filtering = False
        Options.ShowEditButtons = isebNever
        Options.SortByDisplayText = isbtOff
        Width = 138
      end
      object cxgOndasDBTableViewDTAOND: TcxGridDBColumn
        Caption = 'Data de Gera'#231#227'o'
        DataBinding.FieldName = 'DTAOND'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 90
      end
      object cxgOndasDBTableViewNOMOPE: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'NOMOPE'
        Options.Editing = False
        Width = 300
      end
      object cxgOndasDBTableViewTOTQIT: TcxGridDBColumn
        DataBinding.FieldName = 'TOTQIT'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object cxgOndasDBTableViewDESSTA: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'DESSTA'
        Options.Editing = False
        Width = 130
      end
      object cxgOndasDBTableViewONDADT: TcxGridDBColumn
        Caption = 'Data de Gera'#231#227'o'
        DataBinding.FieldName = 'ONDADT'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
      end
      object cxgOndasDBTableViewONDAHR: TcxGridDBColumn
        Caption = 'Hora de Gera'#231#227'o'
        DataBinding.FieldName = 'ONDAHR'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 110
      end
      object cxgOndasDBTableViewONDAOP: TcxGridDBColumn
        Caption = 'Operador de Gera'#231#227'o'
        DataBinding.FieldName = 'ONDAOP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 200
      end
      object cxgOndasDBTableViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxgOndasLevel: TcxGridLevel
      GridView = cxgOndasDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 648
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 616
    Top = 200
  end
  object dtsOndas: TDataSource
    DataSet = cdsOndas
    Left = 424
    Top = 200
  end
  object cdsOndas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOndas'
    OnCalcFields = cdsOndasCalcFields
    Left = 456
    Top = 200
    object cdsOndasONDFIN: TStringField
      Alignment = taCenter
      FieldName = 'ONDFIN'
      Size = 12
    end
    object cdsOndasONDGRO: TStringField
      Alignment = taCenter
      FieldName = 'ONDGRO'
      Size = 12
    end
    object cdsOndasNOMOPE: TStringField
      FieldName = 'NOMOPE'
      Size = 100
    end
    object cdsOndasTOTQIT: TFloatField
      DisplayLabel = 'Qtd. Itens'
      FieldName = 'TOTQIT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsOndasMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsOndasONDKIT: TStringField
      Alignment = taCenter
      FieldName = 'ONDKIT'
      Size = 1
    end
    object cdsOndasONDAOP: TStringField
      Alignment = taCenter
      FieldName = 'ONDAOP'
      Size = 3
    end
    object cdsOndasONDAHR: TStringField
      Alignment = taCenter
      FieldName = 'ONDAHR'
      Size = 8
    end
    object cdsOndasBUTTON: TStringField
      FieldName = 'BUTTON'
      Size = 1
    end
    object cdsOndasSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object cdsOndasDESSTA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'DESSTA'
      Size = 100
    end
    object cdsOndasTIPPED: TStringField
      FieldName = 'TIPPED'
      Size = 1
    end
    object cdsOndasDTAOND: TDateField
      Alignment = taCenter
      FieldName = 'DTAOND'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = 'dd/mm/yyyy'
    end
    object cdsOndasONDADT: TDateField
      Alignment = taCenter
      FieldName = 'ONDADT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = 'dd/mm/yyyy'
    end
  end
  object dspOndas: TUniDataSetProvider
    DataSet = qryOndas
    Options = [poDisableInserts, poDisableDeletes]
    Left = 488
    Top = 200
  end
  object qryOndas: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 520
    Top = 200
  end
  object cxiImagens: TcxImageList
    SourceDPI = 96
    Height = 20
    Width = 37
    FormatVersion = 1
    DesignInfo = 13107776
    ImageInfo = <
      item
        Image.Data = {
          C60B0000424DC60B000000000000360000002800000025000000140000000100
          200000000000900B000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          700070707000707070007070700070707000707070007070700070707000FFFF
          FF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFF
          FF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD0000000000DDDDDD00DDDDDD0000000000DDDDDD00DDDD
          DD0000000000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD007070
          7000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF007070
          7000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFF
          FF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFF
          FF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD007070
          7000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFFFF00FFFFFF007070
          7000DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD0070707000FFFFFF00FFFFFF0070707000DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
          DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD0070707000FFFF
          FF00FFFFFF007070700070707000707070007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          7000707070007070700070707000707070007070700070707000707070007070
          700070707000707070007070700070707000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end>
  end
end
