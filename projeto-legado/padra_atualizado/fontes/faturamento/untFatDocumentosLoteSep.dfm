inherited frmFatDocumentosLoteSep: TfrmFatDocumentosLoteSep
  Width = 900
  Height = 500
  Caption = 'Documento em Lote de Separa'#231#227'o'
  ExplicitWidth = 900
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 894
    ExplicitTop = 602
    ExplicitWidth = 777
    inherited FlwBotoes: TFlowPanel
      Width = 890
      ExplicitWidth = 773
      object btnMarcarTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 81
        Height = 22
        Caption = 'Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 156
        Top = 0
        Width = 100
        Height = 22
        Caption = 'Dermarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 811
      ExplicitLeft = 694
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 894
    ExplicitTop = 628
    ExplicitWidth = 777
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 606
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 606
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 777
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 886
      Height = 36
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Documentos vinculados a lote de separa'#231#227'o de romaneios, marque o' +
        's documentos que deseja excluir o pedido do lote de separa'#231#227'o de' +
        ' romaneio:'
      Layout = tlCenter
      ExplicitWidth = 706
      ExplicitHeight = 14
    end
  end
  object grdDados: TcxGridCitel [3]
    Left = 0
    Top = 41
    Width = 894
    Height = 388
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 2
    ExplicitTop = 43
    ExplicitWidth = 777
    ExplicitHeight = 561
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
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
      object grdDadosTvSELECI: TcxGridDBColumn
        DataBinding.FieldName = 'SELECI'
        Width = 72
      end
      object grdDadosTvDOCUME: TcxGridDBColumn
        DataBinding.FieldName = 'DOCUME'
        Options.Editing = False
      end
      object grdDadosTvColumn1: TcxGridDBColumn
        DataBinding.FieldName = 'LOTSEP'
        Options.Editing = False
        Width = 110
      end
      object grdDadosTvCLIENT: TcxGridDBColumn
        DataBinding.FieldName = 'CLIENT'
        Options.Editing = False
      end
      object grdDadosTvDTAENT: TcxGridDBColumn
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Width = 87
      end
    end
    object grdDadosLvl: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 324
    object cdsDadosSELECI: TBooleanField
      DisplayLabel = 'Selecionado'
      FieldName = 'SELECI'
    end
    object cdsDadosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsDadosNUMDOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsDadosESPDOC: TStringField
      DisplayLabel = 'Esp'#233'cie'
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsDadosCODEMP: TStringField
      DisplayLabel = 'Cod.Empresa'
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDadosCODCLI: TStringField
      DisplayLabel = 'C'#243'd.Cliente'
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsDadosNOMCLI: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsDadosDTAENT: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'DTAENT'
    end
    object cdsDadosDOCUME: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DOCUME'
    end
    object cdsDadosCLIENT: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'CLIENT'
      Size = 70
    end
    object cdsDadosLOTSEP: TStringField
      DisplayLabel = 'Lote Separa'#231#227'o'
      FieldName = 'LOTSEP'
      Size = 8
    end
    object cdsDadosAUTINCLOTSEP: TStringField
      FieldName = 'AUTINCLOTSEP'
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 444
    Top = 324
  end
end
