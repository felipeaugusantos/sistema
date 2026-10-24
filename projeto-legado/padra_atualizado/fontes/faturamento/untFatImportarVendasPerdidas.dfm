inherited frmFatImportarVendasPerdidas: TfrmFatImportarVendasPerdidas
  Width = 1076
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Selecione os itens das vendas perdidas'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1076
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 1070
    TabOrder = 1
    ExplicitTop = 527
    ExplicitWidth = 1070
    inherited FlwBotoes: TFlowPanel
      Width = 1066
      ExplicitWidth = 1066
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[F10] Gravar'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 100
        Top = 0
        Width = 100
        Height = 22
        Caption = '[F5] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 200
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F6] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 990
      ExplicitLeft = 990
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1070
    TabOrder = 2
    ExplicitTop = 555
    ExplicitWidth = 1070
    inherited pnlNomeForm: TPanel
      Left = 899
      ExplicitLeft = 899
    end
    inherited pnlInfo: TPanel
      Width = 899
      ExplicitWidth = 899
    end
  end
  object grdItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1070
    Height = 527
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdItensTableView: TcxGridDBTableViewCitel
      OnDblClick = grdItensTableViewDblClick
      OnKeyDown = grdItensTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdItensTableViewCustomDrawCell
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
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdItensTableViewCODIGO: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'VPG_CODIGO'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 54
      end
      object grdItensTableViewNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'VPG_NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 67
      end
      object grdItensTableViewESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'VPG_ESPDOC'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 38
      end
      object grdItensTableViewCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'VPG_CODEMP'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 42
      end
      object grdItensTableViewCODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VPG_CODVEN'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 47
      end
      object grdItensTableViewNUMCMP: TcxGridDBColumn
        Caption = 'Pedido de Compra'
        DataBinding.FieldName = 'VPD_NUMCMP'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 90
      end
      object grdItensTableViewDTACMP: TcxGridDBColumn
        Caption = 'Data Ped. Compra'
        DataBinding.FieldName = 'VPD_DTACMP'
        Options.Editing = False
        Options.Moving = False
        Width = 90
      end
      object grdItensTableViewNITCMP: TcxGridDBColumn
        Caption = 'N'#186' Item Ped. Compra'
        DataBinding.FieldName = 'VPD_NITCMP'
        Width = 81
      end
      object grdItensTableViewDTACAD: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'VPG_DTACAD'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 56
      end
      object grdItensTableViewCODITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'VPD_CODITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 55
      end
      object grdItensTableViewCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 62
      end
      object grdItensTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'VPD_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 221
      end
      object grdItensTableViewQTDITE: TcxGridDBColumn
        Caption = 'Qtde'
        DataBinding.FieldName = 'VPD_QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 47
      end
      object grdItensTableViewUNITAR: TcxGridDBColumn
        Caption = 'Vlr. Unit'#225'rio'
        DataBinding.FieldName = 'VPD_UNITAR'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 56
      end
      object grdItensTableViewTOTITE: TcxGridDBColumn
        Caption = 'Vlr. Total'
        DataBinding.FieldName = 'VPD_TOTITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 62
      end
      object grdItensTableViewSelecionado: TcxGridDBColumn
        DataBinding.FieldName = 'SELECIONADO'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
      end
    end
    object grdItensLevel: TcxGridLevel
      GridView = grdItensTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 128
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 64
    Top = 104
  end
  object dtsDados: TDataSource
    Left = 160
    Top = 104
  end
end
