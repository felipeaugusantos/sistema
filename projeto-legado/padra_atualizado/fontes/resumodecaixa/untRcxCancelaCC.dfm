inherited frmRcxCancelaCC: TfrmRcxCancelaCC
  Width = 732
  Height = 389
  Caption = 'Cancelamento de lan'#231'amento de cr'#233'dito'
  Position = poScreenCenter
  ExplicitWidth = 732
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 726
    TabOrder = 1
    ExplicitTop = 316
    ExplicitWidth = 726
    inherited FlwBotoes: TFlowPanel
      Width = 722
      ExplicitWidth = 722
    end
    inherited btnSair: TBitBtnLocked
      Left = 643
      TabOrder = 2
      ExplicitLeft = 643
    end
    object btnCancelaCC: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 101
      Height = 22
      Caption = '[F10] &Confirma'
      TabOrder = 1
      OnClick = btnCancelaCCClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 726
    TabOrder = 2
    ExplicitTop = 344
    ExplicitWidth = 726
    inherited pnlNomeForm: TPanel
      Left = 555
      ExplicitLeft = 555
    end
    inherited pnlInfo: TPanel
      Width = 555
      ExplicitWidth = 555
    end
  end
  object grdCredito: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 726
    Height = 316
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdCreditoTableView: TcxGridDBTableView
      OnKeyPress = grdCreditoTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnCellDblClick = grdCreditoTableViewCellDblClick
      OnCustomDrawCell = grdCreditoTableViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ColumnHeaderHints = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object grdCreditoTableViewRCX_DTACAD: TcxGridDBColumn
        Caption = 'Dt. lan'#231'amento'
        DataBinding.FieldName = 'RCX_DTACAD'
        Width = 100
      end
      object grdCreditoTableViewRCX_HORCAD: TcxGridDBColumn
        Caption = 'Hr. lan'#231'amento'
        DataBinding.FieldName = 'RCX_HORCAD'
        Width = 100
      end
      object grdCreditoTableViewRCX_SEQCON: TcxGridDBColumn
        Caption = 'Sequ'#234'ncia'
        DataBinding.FieldName = 'RCX_SEQCON'
        Width = 90
      end
      object grdCreditoTableViewCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Width = 300
      end
      object grdCreditoTableViewRCX_VALDOC: TcxGridDBColumn
        Caption = 'Valor cr'#233'dito'
        DataBinding.FieldName = 'RCX_VALDOC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00'
        Width = 120
      end
      object grdCreditoTableViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object grdCreditoLevel1: TcxGridLevel
      GridView = grdCreditoTableView
    end
  end
end
