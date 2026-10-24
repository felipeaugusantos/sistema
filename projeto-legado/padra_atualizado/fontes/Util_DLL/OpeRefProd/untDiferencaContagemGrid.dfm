inherited frmDiferencaContagemGrid: TfrmDiferencaContagemGrid
  Width = 1024
  Height = 548
  BorderStyle = bsSizeable
  Caption = 'Mapa das Contagens com Diferen'#231'as'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 465
    Width = 1008
    ExplicitTop = 465
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
    Top = 493
    Width = 1008
    ExplicitTop = 493
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
  object cxgProdutos: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 382
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvProdutos: TcxGridDBBandedTableView
      OnKeyDown = cxvProdutosKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnFocusedItemChanged = cxvProdutosFocusedItemChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtto'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxsZebra
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
        end
        item
          Caption = 'Contagens'
          HeaderAlignmentHorz = taLeftJustify
        end
        item
          Caption = 'Diferen'#231'a'
          FixedKind = fkRight
        end>
      object cxvProdutosColumn1: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 51
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosColumn2: TcxGridDBBandedColumn
        Caption = 'N'#250'mero do Lote'
        DataBinding.FieldName = 'NUMLOT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 74
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosColumn3: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 234
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutoSALCON: TcxGridDBBandedColumn
        Caption = #218'ltima Contagem'
        DataBinding.FieldName = 'SALCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        OnCustomDrawCell = cxvProdutoSALCONCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 85
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosColumn5: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a'
        DataBinding.FieldName = 'DIFSAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosColumn6: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 45
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosColumn7: TcxGridDBBandedColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvProdutosGMLCON: TcxGridDBBandedColumn
        Caption = #218'ltima Contagem ML/GR'
        DataBinding.FieldName = 'GMLCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        OnCustomDrawCell = cxvProdutoSALCONCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 85
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosDIFML: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a ML/GR'
        DataBinding.FieldName = 'DIF_ML'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosSAL_ML: TcxGridDBBandedColumn
        Caption = 'Saldo ML/GR'
        DataBinding.FieldName = 'SAL_ML'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvProdutosRESGAR: TcxGridDBBandedColumn
        Caption = 'Sado em Garantia'
        DataBinding.FieldName = 'RESGAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvProdutosESTMAN: TcxGridDBBandedColumn
        Caption = 'Sado em Manuten'#231#227'o'
        DataBinding.FieldName = 'SALMAN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvProdutosBEACSS: TcxGridDBBandedColumn
        Caption = 'Sado Em Expedi'#231#227'o'
        DataBinding.FieldName = 'BEACCS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
    end
    object cxgProdutosLevel1: TcxGridLevel
      GridView = cxvProdutos
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 382
    Width = 1008
    Height = 83
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object grbContagem: TGroupBox
      Left = 8
      Top = 9
      Width = 425
      Height = 65
      Caption = 'Detalhe da Contagem'
      Enabled = False
      TabOrder = 0
      object Label2: TLabel
        Left = 9
        Top = 18
        Width = 22
        Height = 14
        Caption = 'Data'
      end
      object Label3: TLabel
        Left = 84
        Top = 18
        Width = 23
        Height = 14
        Caption = 'Hora'
      end
      object Label4: TLabel
        Left = 148
        Top = 18
        Width = 46
        Height = 14
        Caption = 'Operador'
      end
      object dbeDtaCon: TDBEditFocus
        Left = 9
        Top = 32
        Width = 73
        Height = 22
        DataSource = dtsProdutos
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeHorCon: TDBEditFocus
        Left = 84
        Top = 32
        Width = 62
        Height = 22
        DataSource = dtsProdutos
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodOpe: TDBEditFocus
        Left = 148
        Top = 32
        Width = 35
        Height = 22
        DataSource = dtsProdutos
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNomOpe: TDBEditFocus
        Left = 185
        Top = 32
        Width = 224
        Height = 22
        DataSource = dtsProdutos
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlLegenda: TPanel
      Left = 456
      Top = 52
      Width = 201
      Height = 22
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object shpAltera: TShape
        Left = 2
        Top = 2
        Width = 18
        Height = 18
        Brush.Color = 8454143
      end
      object Label1: TLabel
        Left = 24
        Top = 4
        Width = 160
        Height = 14
        Caption = 'Valores que podem ser alterados'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 288
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 576
    Top = 268
    PixelsPerInch = 96
    object cxsZebra: TcxStyle
      AssignedValues = [svColor]
      Color = 15066597
    end
  end
  object dtsProdutos: TDataSource
    Left = 656
    Top = 230
  end
end
