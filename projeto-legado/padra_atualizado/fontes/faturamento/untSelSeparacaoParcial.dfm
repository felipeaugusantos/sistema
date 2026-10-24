inherited frmSelSeparacaoParcial: TfrmSelSeparacaoParcial
  Width = 480
  Height = 260
  Caption = 'Selecione a separa'#231#227'o parcial'
  OnDestroy = FormDestroy
  ExplicitWidth = 480
  ExplicitHeight = 260
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 189
    Width = 474
    TabOrder = 1
    ExplicitTop = 189
    ExplicitWidth = 474
    inherited FlwBotoes: TFlowPanel
      Width = 470
      ExplicitWidth = 470
      object btnLimpaTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 85
        Height = 22
        Caption = '&Limpar tudo'
        TabOrder = 1
        OnClick = btnLimpaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 391
      ExplicitLeft = 391
    end
  end
  inherited pnlStatus: TPanel
    Top = 215
    Width = 474
    TabOrder = 2
    ExplicitTop = 215
    ExplicitWidth = 474
    inherited pnlNomeForm: TPanel
      Left = 303
      ExplicitLeft = 303
    end
    inherited pnlInfo: TPanel
      Width = 303
      ExplicitWidth = 303
    end
  end
  object cxGrdSep: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 474
    Height = 189
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrdSepTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxGrdSepTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsSep
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGrdSepTableViewSEQSEP: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'SEP_SEQSEP'
        Width = 50
      end
      object cxGrdSepTableViewDTASEP: TcxGridDBColumn
        Caption = 'Impresso em'
        DataBinding.FieldName = 'SEP_DTASEP'
        Width = 110
      end
      object cxGrdSepTableViewOPESEP: TcxGridDBColumn
        Caption = 'Impresso por'
        DataBinding.FieldName = 'SEP_OPESEP'
        Width = 200
      end
    end
    object cxGrdSepLevel: TcxGridLevel
      GridView = cxGrdSepTableView
    end
  end
  object dsSep: TDataSource
    Left = 64
    Top = 104
  end
end
