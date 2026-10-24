inherited frmFatManPedCortadoFaltaEstoque: TfrmFatManPedCortadoFaltaEstoque
  Width = 981
  Height = 546
  Caption = 'Manuten'#231#227'o de Pedidos Cortados por Falta de Estoque'
  OnDestroy = FormDestroy
  ExplicitWidth = 981
  ExplicitHeight = 546
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 473
    Width = 975
    ExplicitTop = 473
    ExplicitWidth = 975
    inherited FlwBotoes: TFlowPanel
      Width = 971
      ExplicitWidth = 971
    end
    inherited btnSair: TBitBtnLocked
      Left = 892
      ExplicitLeft = 892
    end
  end
  inherited pnlStatus: TPanel
    Top = 501
    Width = 975
    ExplicitTop = 501
    ExplicitWidth = 975
    inherited pnlNomeForm: TPanel
      Left = 804
      ExplicitLeft = 804
    end
    inherited pnlInfo: TPanel
      Width = 804
      ExplicitWidth = 804
    end
  end
  object dbgGrid: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 975
    Height = 448
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgGridTBV: TcxGridDBTableView
      OnKeyDown = dbgGridTBVKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = dbgGridTBVCellDblClick
      DataController.DataSource = dtsGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object dbgMensagensDTAENT: TcxGridDBColumn
        Caption = 'Data Emiss'#227'o'
        DataBinding.FieldName = 'DTAENT'
        Width = 90
      end
      object dbgMensagensPEDMKT: TcxGridDBColumn
        Caption = 'Num. PD Marketplace'
        DataBinding.FieldName = 'PEDMKT'
        Width = 120
      end
      object dbgMensagensNUMDOC: TcxGridDBColumn
        Caption = 'Num. Documento'
        DataBinding.FieldName = 'NUMDOC'
        Width = 120
      end
      object dbgMensagensESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 37
      end
      object dbgMensagensVENDED: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CODVEN'
        Width = 235
      end
      object dbgMensagensREMSEP: TcxGridDBColumn
        Caption = 'Remessa Separa'#231#227'o'
        DataBinding.FieldName = 'REMSEP'
        Width = 120
      end
      object dbgMensagensREMPED: TcxGridDBColumn
        Caption = 'Remessa Pedido'
        DataBinding.FieldName = 'REMPED'
        Width = 120
      end
      object dbgMensagensMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object dbgGridLevel1: TcxGridLevel
      GridView = dbgGridTBV
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 448
    Width = 975
    Height = 25
    Align = alBottom
    Caption = '[ENTER] ou duplo clique para visualizar os itens do pedido'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 40
  end
  object dtsGrid: TDataSource
    Left = 488
    Top = 40
  end
end
