inherited frmFatLoteRapido: TfrmFatLoteRapido
  Width = 589
  Height = 387
  Caption = 'Lotes'
  OnDestroy = FormDestroy
  ExplicitWidth = 589
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 583
    ExplicitTop = 316
    ExplicitWidth = 583
    inherited FlwBotoes: TFlowPanel
      Width = 579
      ExplicitWidth = 579
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 503
      ExplicitLeft = 503
    end
  end
  inherited pnlStatus: TPanel
    Top = 342
    Width = 583
    ExplicitTop = 342
    ExplicitWidth = 583
    inherited pnlNomeForm: TPanel
      Left = 412
      ExplicitLeft = 412
    end
    inherited pnlInfo: TPanel
      Width = 412
      ExplicitWidth = 412
    end
  end
  object grdLotes: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 583
    Height = 316
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdLotesTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsLotes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdLotesTvLOT_CODBAR: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_CODLOT'
        Options.Editing = False
        Width = 126
      end
      object grdLotesTvSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
      end
      object grdLotesTvSALPED: TcxGridDBColumn
        Caption = 'Res.Ped.Venda'
        DataBinding.FieldName = 'SALPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Visible = False
        Options.Editing = False
        Width = 80
      end
      object grdLotesTvENTPRE: TcxGridDBColumn
        Caption = 'Ent.Fut Previs'#227'o'
        DataBinding.FieldName = 'ENTPRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Visible = False
        Options.Editing = False
        Width = 84
      end
      object grdLotesTvENTAGU: TcxGridDBColumn
        Caption = 'Ent.Fut.Ag'
        DataBinding.FieldName = 'ENTAGU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Visible = False
        Options.Editing = False
      end
      object grdLotesTvSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Visible = False
        Options.Editing = False
        Width = 85
      end
      object grdLotesTvQTDE: TcxGridDBColumn
        Caption = 'Qtd.Venda'
        DataBinding.FieldName = 'QTDE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
      end
    end
    object grdLotesLv: TcxGridLevel
      GridView = grdLotesTv
    end
  end
  object dsLotes: TDataSource
    Left = 120
    Top = 184
  end
end
