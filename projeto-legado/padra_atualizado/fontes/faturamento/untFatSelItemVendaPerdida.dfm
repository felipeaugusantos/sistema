inherited frmFatSelItemVendaPerdida: TfrmFatSelItemVendaPerdida
  Width = 990
  Height = 623
  BorderIcons = [biSystemMenu]
  Caption = 'Selecionar itens para inserir em vendas perdidas'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 990
  ExplicitHeight = 623
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 550
    Width = 984
    TabOrder = 1
    ExplicitTop = 550
    ExplicitWidth = 984
    inherited FlwBotoes: TFlowPanel
      Width = 980
      TabOrder = 5
      ExplicitWidth = 980
    end
    inherited btnSair: TBitBtnLocked
      Left = 901
      TabOrder = 4
      ExplicitLeft = 901
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 100
      Height = 22
      Caption = '[F10] Gravar'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnDesmarcarTodos: TBitBtnLocked
      Left = 204
      Top = 3
      Width = 120
      Height = 22
      Caption = '[F6] Desmarcar Todos'
      TabOrder = 2
      OnClick = btnDesmarcarTodosClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 104
      Top = 3
      Width = 100
      Height = 22
      Caption = '[F5] Marcar Todos'
      TabOrder = 1
      OnClick = btnMarcarTodosClick
    end
    object btnObservacoes: TBitBtnLocked
      Left = 324
      Top = 3
      Width = 100
      Height = 22
      Caption = '[F9] Observa'#231#245'es'
      TabOrder = 3
      OnClick = btnObservacoesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 578
    Width = 984
    TabOrder = 2
    ExplicitTop = 578
    ExplicitWidth = 984
    inherited pnlNomeForm: TPanel
      Left = 813
      ExplicitLeft = 813
    end
    inherited pnlInfo: TPanel
      Width = 813
      ExplicitWidth = 813
    end
  end
  object grdItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 984
    Height = 550
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdItensTableView1: TcxGridDBTableViewCitel
      OnDblClick = grdItensTableView1DblClick
      OnKeyDown = grdItensTableView1KeyDown
      OnKeyPress = grdItensTableView1KeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdItensTableView1CustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdItensTableViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 83
      end
      object grdItensTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 248
      end
      object grdItensTableViewQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 85
      end
      object grdItensTableViewSIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'SIGUNI'
        Width = 44
      end
      object grdItensTableViewUNITAR: TcxGridDBColumn
        Caption = 'Vlr. Unit'#225'rio'
        DataBinding.FieldName = 'UNITAR'
        Width = 110
      end
      object grdItensTableViewTOTITE: TcxGridDBColumn
        Caption = 'Vlr. Total'
        DataBinding.FieldName = 'TOTITE'
        Width = 120
      end
      object grdItensTableViewNOMMOT: TcxGridDBColumn
        Caption = 'Motivo'
        DataBinding.FieldName = 'NOMMOT'
        Width = 271
      end
      object grdItensTableViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object grdItensLevel1: TcxGridLevel
      GridView = grdItensTableView1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 192
  end
  object dtsDados: TDataSource
    Left = 496
    Top = 104
  end
end
