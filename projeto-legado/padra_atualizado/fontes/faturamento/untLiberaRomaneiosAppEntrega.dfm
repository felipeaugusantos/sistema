inherited frmLiberaRomaneiosAppEntrega: TfrmLiberaRomaneiosAppEntrega
  Width = 673
  Height = 449
  Caption = 'Libera'#231#227'o dos Romaneios para APP Entrega'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 673
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 667
    ExplicitTop = 376
    ExplicitWidth = 667
    inherited FlwBotoes: TFlowPanel
      Width = 663
      ExplicitWidth = 663
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 124
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 124
        Top = 0
        Width = 124
        Height = 22
        Caption = '[Ctrl + F3] Marca Todos'
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 248
        Top = 0
        Width = 141
        Height = 22
        Caption = '[Ctrl + F4] Desmarca Todos'
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 587
      ExplicitLeft = 587
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 667
    ExplicitTop = 404
    ExplicitWidth = 667
    inherited pnlNomeForm: TPanel
      Left = 496
      ExplicitLeft = 496
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 667
    Height = 376
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel
      OnDblClick = cxgDadosDBTableViewCitel1DblClick
      OnKeyDown = cxgDadosDBTableViewCitel1KeyDown
      OnKeyUp = cxgDadosDBTableViewCitel1KeyUp
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDadosDBTableViewCitel1CustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosGER_MARDES: TcxGridDBColumn
        DataBinding.FieldName = 'GER_MARDES'
        Visible = False
      end
      object cxgDadosGER_SEQATV: TcxGridDBColumn
        Caption = 'Seq. Ativa'#231#227'o'
        DataBinding.FieldName = 'GER_SEQATV'
        Width = 74
      end
      object cxgDadosGER_NUMROM: TcxGridDBColumn
        Caption = 'Num. Romaneio'
        DataBinding.FieldName = 'GER_NUMROM'
        Width = 81
      end
      object cxgDadosGER_DTAROM: TcxGridDBColumn
        Caption = 'Dt. Romaneio'
        DataBinding.FieldName = 'GER_DTAROM'
        Width = 70
      end
      object cxgDadosGER_HORROM: TcxGridDBColumn
        Caption = 'Hr. Romaneio'
        DataBinding.FieldName = 'GER_HORROM'
        Width = 70
      end
      object cxgDadosMOTORISTA: TcxGridDBColumn
        Caption = 'Motorista'
        DataBinding.FieldName = 'MOTORISTA'
        Width = 158
      end
      object cxgDadosGER_PLAVEI: TcxGridDBColumn
        Caption = 'Ve'#237'culo'
        DataBinding.FieldName = 'GER_PLAVEI'
        Width = 61
      end
      object cxgDadosQTDDOCS: TcxGridDBColumn
        Caption = 'Qtd. Docs'
        DataBinding.FieldName = 'QTDDOCS'
        Width = 55
      end
      object cxgDadosGER_PESBRU: TcxGridDBColumn
        Caption = 'Peso Bruto'
        DataBinding.FieldName = 'GER_PESBRU'
        Width = 75
      end
    end
    object cxgDadosLevel1: TcxGridLevel
      GridView = cxgDadosDBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 784
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 788
    Top = 36
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 784
    Top = 152
  end
end
