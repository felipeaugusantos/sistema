inherited frmSelCamposExportaEstoqueEmExcesso: TfrmSelCamposExportaEstoqueEmExcesso
  Width = 451
  Height = 599
  Caption = 'frmSelCamposExportaEstoqueEmExcesso'
  ExplicitWidth = 451
  ExplicitHeight = 599
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 445
    ExplicitTop = 528
    ExplicitWidth = 445
    inherited FlwBotoes: TFlowPanel
      Width = 441
      ExplicitWidth = 441
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 362
      ExplicitLeft = 362
    end
  end
  inherited pnlStatus: TPanel
    Top = 554
    Width = 445
    ExplicitTop = 554
    ExplicitWidth = 445
    inherited pnlNomeForm: TPanel
      Left = 184
      Width = 261
      ExplicitLeft = 184
      ExplicitWidth = 261
    end
    inherited pnlInfo: TPanel
      Width = 184
      ExplicitWidth = 184
    end
  end
  object cxDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 445
    Height = 528
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Filter.TranslateLike = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvDadosColumn1: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'ANA_FIEDES'
        Options.Editing = False
        Width = 336
      end
      object cxvDadosColumn2: TcxGridDBColumn
        Caption = 'Exporta?'
        DataBinding.FieldName = 'ANA_EXPORT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object dtsDados: TDataSource
    Left = 272
    Top = 288
  end
end
