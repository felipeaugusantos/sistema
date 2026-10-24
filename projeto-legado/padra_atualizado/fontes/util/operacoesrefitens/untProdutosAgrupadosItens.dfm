inherited frmProdutosAgrupadosItens: TfrmProdutosAgrupadosItens
  Left = 561
  Top = 302
  Height = 355
  Caption = 'Selecione o agrupamento a ser modificado'
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 282
    ExplicitTop = 282
    inherited FlwBotoes: TFlowPanel
      Left = 113
      Width = 291
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = 'Confirma [ENTER]'
      TabOrder = 1
      OnClick = btnConfirmaClick
      ExplicitLeft = 3
      ExplicitTop = 4
      ExplicitHeight = 21
    end
  end
  object dbgAgr: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 282
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgAgrDBTableView1: TcxGridDBTableView
      OnDblClick = dbgAgrDBTableView1DblClick
      OnKeyPress = dbgAgrDBTableView1KeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = dbgAgrDBTableView1CellDblClick
      OnCustomDrawCell = dbgAgrDBTableView1CustomDrawCell
      OnEditDblClick = dbgAgrDBTableView1EditDblClick
      DataController.DataSource = dtsAgr
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object dbgAgrDBTableView1CODAGR: TcxGridDBColumn
        Caption = 'Agrupamento'
        DataBinding.FieldName = 'CODAGR'
        Visible = False
        GroupIndex = 0
      end
      object dbgAgrDBTableView1CODITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'CODITE'
        GroupIndex = 1
        VisibleForCustomization = False
        Width = 50
      end
      object dbgAgrDBTableView1DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
      end
      object dbgAgrDBTableView1PAIFIL: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'PAIFIL'
        SortIndex = 0
        SortOrder = soDescending
      end
    end
    object dbgAgrLevel1: TcxGridLevel
      GridView = dbgAgrDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    ExplicitTop = 310
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 64
  end
  object dtsAgr: TDataSource
    AutoEdit = False
    DataSet = cdsAgr
    OnDataChange = dtsAgrDataChange
    Left = 248
    Top = 96
  end
  object cdsAgr: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 96
    object cdsAgrCODAGR: TStringField
      FieldName = 'CODAGR'
      Size = 6
    end
    object cdsAgrCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsAgrDESITE: TStringField
      FieldName = 'DESITE'
      Size = 50
    end
    object cdsAgrPAIFIL: TStringField
      FieldName = 'PAIFIL'
      Size = 8
    end
  end
end
