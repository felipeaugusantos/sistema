inherited frmSelecionaPedidoRep: TfrmSelecionaPedidoRep
  Width = 419
  Height = 410
  BorderStyle = bsSizeable
  Caption = 'Selecione de qual empresa '#233' o pedido em conflito'
  ExplicitWidth = 419
  ExplicitHeight = 410
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 403
    ExplicitTop = 328
    ExplicitWidth = 403
    inherited btnSair: TBitBtnLocked
      Left = 320
      ExplicitLeft = 320
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 1
      ExplicitLeft = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 403
    ExplicitTop = 356
    ExplicitWidth = 403
    inherited pnlNomeForm: TPanel
      Left = 232
      ExplicitLeft = 232
    end
    inherited pnlInfo: TPanel
      Width = 232
      ExplicitWidth = 232
    end
  end
  object cxgItensPed: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 403
    Height = 328
    Align = alClient
    TabOrder = 3
    object cxvItensPed: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxvItensPedNUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'NUMPED'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 136
      end
      object cxvItensPedCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CODEMP'
        Properties.ListColumns = <
          item
            HeaderAlignment = taCenter
            FieldName = 'CODEMP'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dtsEmpresas
        HeaderAlignmentHorz = taCenter
        Width = 94
      end
    end
    object cxgItensPedLevel1: TcxGridLevel
      GridView = cxvItensPed
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 80
  end
  object dtsEmpresas: TDataSource
    Left = 208
    Top = 88
  end
end
