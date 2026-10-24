inherited frmCadControleProducao: TfrmCadControleProducao
  Width = 353
  Height = 450
  Caption = 'Controle de Programa'#231#227'o de Produ'#231#227'o'
  ExplicitWidth = 353
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 347
    TabOrder = 1
    ExplicitTop = 379
    ExplicitWidth = 347
    inherited FlwBotoes: TFlowPanel
      Width = 283
      ExplicitWidth = 343
      inherited btnConfirma: TBitBtnLocked
        Width = 115
        ModalResult = 0
        ExplicitWidth = 115
      end
      object btnHeranca: TBitBtnLocked
        Left = 115
        Top = 0
        Width = 115
        Height = 22
        Caption = '&Heran'#231'a de Produ'#231#227'o'
        Enabled = False
        TabOrder = 1
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 285
      Top = 2
      Width = 60
      Align = alRight
      Caption = 'S&air'
      ExplicitLeft = 284
      ExplicitWidth = 60
    end
  end
  object dbgHorarios: TcxGrid [2]
    Left = 0
    Top = 38
    Width = 347
    Height = 341
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgHorariosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Append.Visible = True
      DataController.DataSource = dtsHorarios
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      NewItemRow.InfoText = 'Click aqui para adicionar um novo registro'
      NewItemRow.Visible = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Appending = True
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum hor'#225'rio programado>'
      OptionsView.GroupByBox = False
      object dbgHorariosDBTableView1PPR_HORPPR: TcxGridDBColumn
        Caption = 'Hor'#225'rios de Produ'#231#227'o'
        DataBinding.FieldName = 'PPR_HORPPR'
        Width = 150
      end
      object dbgHorariosDBTableView1PPR_QTDPPR: TcxGridDBColumn
        Caption = 'Quantidade Produ'#231#227'o'
        DataBinding.FieldName = 'PPR_QTDPPR'
        Width = 150
      end
      object dbgHorariosDBTableView1PPR_CODEMP: TcxGridDBColumn
        DataBinding.FieldName = 'PPR_CODEMP'
        Visible = False
      end
      object dbgHorariosDBTableView1AUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
    end
    object dbgHorariosLevel1: TcxGridLevel
      GridView = dbgHorariosDBTableView1
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 347
    Height = 38
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object lblPreVis: TLabel
      Left = 9
      Top = 16
      Width = 136
      Height = 14
      Alignment = taRightJustify
      Caption = 'Informe a data de Produ'#231#227'o:'
    end
    object mskDtaPPR: TMaskEditFocus
      Tag = 99
      Left = 148
      Top = 9
      Width = 80
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnEnter = mskDtaPPREnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 347
    TabOrder = 2
    ExplicitTop = 405
    ExplicitWidth = 347
    inherited pnlNomeForm: TPanel
      Left = 176
      ExplicitLeft = 176
    end
    inherited pnlInfo: TPanel
      Width = 176
      ExplicitWidth = 176
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 160
  end
  object dtsHorarios: TDataSource
    DataSet = cdsHorarios
    Left = 216
    Top = 160
  end
  object dspHorarios: TUniDataSetProvider
    DataSet = qryHorarios
    Options = []
    Left = 280
    Top = 160
  end
  object cdsHorarios: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspHorarios'
    BeforePost = cdsHorariosBeforePost
    AfterPost = cdsHorariosAfterPost
    AfterDelete = cdsHorariosAfterDelete
    Left = 312
    Top = 160
    object cdsHorariosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsHorariosPPR_CODEMP: TStringField
      FieldName = 'PPR_CODEMP'
      Size = 3
    end
    object cdsHorariosPPR_HORPPR: TTimeField
      FieldName = 'PPR_HORPPR'
    end
    object cdsHorariosPPR_QTDPPR: TFloatField
      FieldName = 'PPR_QTDPPR'
      DisplayFormat = '###,##0.00'
      EditFormat = '###,##0.00'
    end
    object dtfldHorariosPPR_DTAPPR1: TDateField
      FieldName = 'PPR_DTAPPR'
    end
  end
  object qryHorarios: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 248
    Top = 160
    object qryHorariosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryHorariosPPR_CODEMP: TStringField
      FieldName = 'PPR_CODEMP'
      Size = 3
    end
    object qryHorariosPPR_HORPPR: TTimeField
      FieldName = 'PPR_HORPPR'
    end
    object qryHorariosPPR_QTDPPR: TFloatField
      FieldName = 'PPR_QTDPPR'
    end
    object dtfldHorariosPPR_DTAPPR: TDateField
      FieldName = 'PPR_DTAPPR'
    end
  end
end
