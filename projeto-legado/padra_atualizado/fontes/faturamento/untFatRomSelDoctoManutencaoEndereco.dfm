inherited frmFatRomSelDoctoManutencaoEndereco: TfrmFatRomSelDoctoManutencaoEndereco
  Width = 976
  Height = 398
  Caption = 'Selecionar documento'
  OnDestroy = FormDestroy
  ExplicitWidth = 976
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 327
    Width = 970
    TabOrder = 1
    inherited FlwBotoes: TFlowPanel
      Width = 966
      object btnMarcaTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 124
        Height = 22
        Caption = '[Ctrl + F3] Marca Todos'
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 199
        Top = 0
        Width = 141
        Height = 22
        Caption = '[Ctrl + F4] Desmarca Todos'
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 887
    end
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 970
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 799
    end
    inherited pnlInfo: TPanel
      Width = 799
    end
  end
  object cxgDocumentos: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 970
    Height = 327
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = -4
    object cxgDocumentosDBTableViewCitel: TcxGridDBTableViewCitel
      OnDblClick = cxgDocumentosDBTableViewCitelDblClick
      OnKeyDown = cxgDocumentosDBTableViewCitelKeyDown
      OnKeyUp = cxgDocumentosDBTableViewCitelKeyUp
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosDBTableViewCitelCustomDrawCell
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
      object GER_ALTEND: TcxGridDBColumn
        DataBinding.FieldName = 'GER_ALTEND'
        Visible = False
      end
      object GER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
      end
      object GER_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
      end
      object GER_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente/Descri'#231#227'o Entr.'
        DataBinding.FieldName = 'GER_NOMCLI'
      end
      object GER_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'GER_NOMCID'
      end
      object GER_ESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'GER_ESTADO'
      end
      object GER_BAIRRO: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'GER_BAIRRO'
      end
      object GER_ENDCON: TcxGridDBColumn
        Caption = 'End. Entrega'
        DataBinding.FieldName = 'GER_ENDCON'
      end
      object GER_CEPCON: TcxGridDBColumn
        Caption = 'CEP Entrega'
        DataBinding.FieldName = 'GER_CEPCON'
      end
      object GER_TRANSP: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'GER_TRANSP'
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosDBTableViewCitel
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 872
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 824
    Top = 65504
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
    Top = 65528
  end
end
