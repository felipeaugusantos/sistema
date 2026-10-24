inherited frmConsControleProducao: TfrmConsControleProducao
  Width = 800
  Height = 447
  Caption = 'Programa'#231#227'o de Produ'#231#227'o'
  ExplicitWidth = 800
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 794
    TabOrder = 4
    ExplicitTop = 376
    ExplicitWidth = 794
    DesignSize = (
      794
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
      inherited btnConfirma: TBitBtnLocked
        Width = 179
        ExplicitWidth = 179
      end
      object btnDisponivel: TBitBtnLocked
        Left = 179
        Top = 0
        Width = 179
        Height = 22
        Caption = '&Alterar Pedido Para Dispon'#237'vel'
        Enabled = False
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnDisponivelClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 714
      ExplicitLeft = 714
    end
  end
  object dbgHorarios: TcxGrid [2]
    Left = 0
    Top = 38
    Width = 794
    Height = 213
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgHorariosDBTableView1: TcxGridDBTableView
      OnDblClick = dbgHorariosDBTableView1DblClick
      OnKeyDown = dbgHorariosDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgHorariosDBTableView1CustomDrawCell
      DataController.DataSource = dtsHorarios
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Click aqui para definir um filtro'
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideSelection = True
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
      OptionsView.GroupByBox = False
      object dbgHorariosDBTableView1FGO_PREVIS: TcxGridDBColumn
        Caption = 'Data de Produ'#231#227'o'
        DataBinding.FieldName = 'FGO_PREVIS'
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object dbgHorariosDBTableView1FGO_HPREVI: TcxGridDBColumn
        Caption = 'Hor'#225'rio'
        DataBinding.FieldName = 'FGO_HPREVI'
        SortIndex = 1
        SortOrder = soAscending
        Width = 70
      end
      object dbgHorariosDBTableView1FGO_NUMDOC: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Width = 119
      end
      object dbgHorariosDBTableView1FGO_NOMCLI: TcxGridDBColumn
        Caption = 'Nome do Cliente do Pedido'
        DataBinding.FieldName = 'FGO_NOMCLI'
        Width = 225
      end
      object dbgHorariosDBTableView1FGO_RESERV: TcxGridDBColumn
        Caption = 'Informa'#231#245'es de Reserva'
        DataBinding.FieldName = 'FGO_RESERV'
        Width = 261
      end
      object dbgHorariosDBTableView1FGO_DISPON: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_DISPON'
        Visible = False
      end
      object dbgHorariosDBTableView1FGO_SELECI: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_SELECI'
        Visible = False
      end
      object dbgHorariosDBTableView1FGO_ESPDOC: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_ESPDOC'
        Visible = False
      end
      object dbgHorariosDBTableView1FGO_CODEMP: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_CODEMP'
        Visible = False
      end
    end
    object dbgHorariosLevel1: TcxGridLevel
      GridView = dbgHorariosDBTableView1
    end
  end
  object pnlFiltro: TPanel [3]
    Left = 0
    Top = 304
    Width = 794
    Height = 72
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object rdgFiltro: TRadioGroup
      Left = 1
      Top = 1
      Width = 248
      Height = 70
      Align = alLeft
      Caption = 'Mostrar'
      Columns = 2
      Items.Strings = (
        'Todos'
        'Apenas Dispon'#237'veis')
      TabOrder = 0
      OnClick = rdgFiltroClick
    end
    object grbLegenda: TGroupBox
      Left = 657
      Top = 1
      Width = 136
      Height = 70
      Align = alRight
      Caption = 'Legenda'
      TabOrder = 1
      object Label1: TLabel
        Left = 7
        Top = 17
        Width = 13
        Height = 14
        AutoSize = False
        Color = clWhite
        ParentColor = False
        Transparent = False
      end
      object Label2: TLabel
        Left = 7
        Top = 34
        Width = 13
        Height = 14
        AutoSize = False
        Color = clBlue
        ParentColor = False
        Transparent = False
      end
      object Label3: TLabel
        Left = 28
        Top = 19
        Width = 49
        Height = 14
        Caption = 'Dispon'#237'vel'
      end
      object Label4: TLabel
        Left = 28
        Top = 36
        Width = 71
        Height = 14
        Caption = 'N'#227'o Dispon'#237'vel'
      end
      object Label5: TLabel
        Left = 7
        Top = 51
        Width = 13
        Height = 14
        AutoSize = False
        Color = clGreen
        ParentColor = False
        Transparent = False
      end
      object Label6: TLabel
        Left = 28
        Top = 53
        Width = 59
        Height = 14
        Caption = 'Selecionado'
      end
    end
  end
  object pnlReserv: TPanel [4]
    Left = 0
    Top = 251
    Width = 794
    Height = 53
    Align = alBottom
    ParentColor = True
    TabOrder = 2
    object lbl1: TLabel
      Left = 5
      Top = 7
      Width = 719
      Height = 14
      Caption = 
        'Digite aqui o nome do cliente, informa'#231#245'es e pressione [ Enter ]' +
        ' para reservar o hor'#225'rio selecionado ou limpe esta campo para di' +
        'sponibilizar o hor'#225'rio:'
    end
    object edtReserv: TEditFocus
      Tag = 99
      Left = 3
      Top = 23
      Width = 780
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 80
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDtaPPR: TPanel [5]
    Left = 0
    Top = 0
    Width = 794
    Height = 38
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object lblPreVis: TLabel
      Left = 16
      Top = 16
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Caption = 'Informe a Data de Produ'#231#227'o:'
    end
    object mskDtaPPR: TMaskEditFocus
      Tag = 99
      Left = 159
      Top = 8
      Width = 80
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 402
    Width = 794
    TabOrder = 5
    ExplicitTop = 402
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 64
  end
  object dtsHorarios: TDataSource
    DataSet = cdsHorarios
    Left = 48
    Top = 48
  end
  object cdsHorarios: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsHorariosAfterScroll
    Left = 80
    Top = 48
    object cdsHorariosFGO_PREVIS: TDateField
      FieldName = 'FGO_PREVIS'
    end
    object cdsHorariosFGO_HPREVI: TTimeField
      FieldName = 'FGO_HPREVI'
    end
    object cdsHorariosFGO_NUMDOC: TStringField
      FieldName = 'FGO_NUMDOC'
      Size = 12
    end
    object cdsHorariosFGO_NOMCLI: TStringField
      FieldName = 'FGO_NOMCLI'
      Size = 80
    end
    object cdsHorariosFGO_DISPON: TStringField
      FieldName = 'FGO_DISPON'
      Size = 1
    end
    object cdsHorariosFGO_SELECI: TStringField
      FieldName = 'FGO_SELECI'
      Size = 1
    end
    object cdsHorariosFGO_ESPDOC: TStringField
      FieldName = 'FGO_ESPDOC'
      Size = 2
    end
    object cdsHorariosFGO_CODEMP: TStringField
      FieldName = 'FGO_CODEMP'
      Size = 3
    end
    object cdsHorariosFGO_RESERV: TStringField
      FieldName = 'FGO_RESERV'
      Size = 80
    end
  end
end
