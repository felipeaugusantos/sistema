inherited frmProdAgrpAddLinhaGrupo: TfrmProdAgrpAddLinhaGrupo
  Width = 673
  Height = 503
  Caption = 'Inserir itens por grupo/linha'
  ExplicitWidth = 673
  ExplicitHeight = 503
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 432
    Width = 667
    ExplicitTop = 432
    ExplicitWidth = 667
    inherited FlwBotoes: TFlowPanel
      Width = 663
      ExplicitWidth = 663
      object btnMarDes: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 145
        Height = 22
        Caption = '[SPACE] Marcar/Desmarca'
        TabOrder = 3
        OnClick = btnMarDesClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F2] Marcar todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarTodosClick
      end
      object btnDesmarTodos: TBitBtnLocked
        Left = 354
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F3] Desmarcar todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 584
      ExplicitLeft = 584
    end
  end
  inherited pnlStatus: TPanel
    Top = 458
    Width = 667
    ExplicitTop = 458
    ExplicitWidth = 667
    inherited pnlNomeForm: TPanel
      Left = 496
      ExplicitLeft = 496
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 667
    Height = 53
    Align = alTop
    TabOrder = 2
    object Label8: TLabel
      Left = 68
      Top = 20
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 142
      Top = 16
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 191
      Top = 16
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TcxGrid [3]
    AlignWithMargins = True
    Left = 3
    Top = 56
    Width = 661
    Height = 349
    Align = alClient
    TabOrder = 3
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 8
    ExplicitTop = 57
    object dbgItensDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.Visible = True
      OnCustomDrawCell = dbgItensDBTableViewCustomDrawCell
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems.OnSummary = dbgItensDBTableViewDataControllerSummaryFooterSummaryItemsSummary
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Total de registros selecionados: 0'
          Kind = skCount
          FieldName = 'ITE_CODITE'
          Column = dbgItensDBTableViewDESITE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object dbgItensDBTableViewIMPORT: TcxGridDBColumn
        Caption = 'Importar?'
        DataBinding.FieldName = 'IMPORT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = 'S'
        Properties.DisplayUnchecked = 'N'
        Properties.FullFocusRect = True
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = dbgItensDBTableViewIMPORTPropertiesChange
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
        Width = 55
      end
      object dbgItensDBTableViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 60
      end
      object dbgItensDBTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        BestFitMaxWidth = 528
        Options.Editing = False
        Width = 584
      end
      object dbgItensDBTableViewLINGRU: TcxGridDBColumn
        Caption = 'Linha/Grupo'
        DataBinding.FieldName = 'GRUPO_'
        Visible = False
        GroupIndex = 0
      end
    end
    object dbgItensLevel: TcxGridLevel
      GridView = dbgItensDBTableView
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 408
    Width = 667
    Height = 24
    Align = alBottom
    TabOrder = 4
    object shpMarcados: TShape
      AlignWithMargins = True
      Left = 76
      Top = 4
      Width = 20
      Height = 16
      Margins.Left = 75
      Align = alLeft
      Brush.Color = clMoneyGreen
      Pen.Color = clMoneyGreen
    end
    object lblLegMarcados: TLabel
      AlignWithMargins = True
      Left = 102
      Top = 5
      Width = 168
      Height = 18
      Margins.Top = 4
      Align = alLeft
      Caption = 'Grupos marcados para importa'#231#227'o'
      ExplicitHeight = 14
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 52
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 100
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 248
    Top = 96
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 280
    Top = 96
    object cdsItensCODAGR: TStringField
      FieldName = 'IMPORT'
      Size = 6
    end
    object cdsItensCODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      FieldName = 'ITE_DESITE'
      Size = 50
    end
    object cdsItensPAIFIL: TStringField
      FieldName = 'GRUPO_'
      Size = 8
    end
  end
end
