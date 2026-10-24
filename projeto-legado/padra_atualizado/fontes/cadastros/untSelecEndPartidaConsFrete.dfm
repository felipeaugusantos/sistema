inherited frmSelecEndPartidaConsFrete: TfrmSelecEndPartidaConsFrete
  Width = 850
  Height = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecione o endere'#231'o de partida para Consulta de Frete'
  OnDestroy = FormDestroy
  ExplicitWidth = 850
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 289
    Width = 844
    ExplicitTop = 289
    ExplicitWidth = 844
    inherited FlwBotoes: TFlowPanel
      Width = 840
      ExplicitWidth = 840
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 761
      ExplicitLeft = 761
    end
  end
  inherited pnlStatus: TPanel
    Top = 315
    Width = 844
    ExplicitTop = 315
    ExplicitWidth = 844
    inherited pnlNomeForm: TPanel
      Left = 673
      ExplicitLeft = 673
    end
    inherited pnlInfo: TPanel
      Width = 673
      ExplicitWidth = 673
    end
  end
  object cxgEndere: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 844
    Height = 289
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgEndereTableView: TcxGridDBTableViewCitel
      OnDblClick = btnConfirmaClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsEndere
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
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgEndereTableViewEND_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'END_DESCRI'
        Width = 200
      end
      object cxgEndereTableViewEND_ENDERE: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'END_ENDERE'
        Width = 180
      end
      object cxgEndereTableViewEND_BAIRRO: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'END_BAIRRO'
        Width = 160
      end
      object cxgEndereTableViewEND_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'END_NOMCID'
        Width = 160
      end
    end
    object cxgEndereLevel: TcxGridLevel
      GridView = cxgEndereTableView
    end
  end
  object dtsEndere: TDataSource
    Left = 296
    Top = 192
  end
end
