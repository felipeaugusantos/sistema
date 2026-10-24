inherited frmLiberacaoCNPJ: TfrmLiberacaoCNPJ
  Width = 1036
  Height = 825
  Caption = 
    'Libera'#231#227'o de CNPJ status N'#195'O HABILITADO para emiss'#227'o de document' +
    'os fiscais'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1036
  ExplicitHeight = 825
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 751
    Width = 1030
    Height = 29
    Enabled = True
    Visible = True
    ExplicitTop = 694
    ExplicitWidth = 1360
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 1026
      Height = 25
      ExplicitWidth = 1356
      ExplicitHeight = 25
      object btnLibCNPJ: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 185
        Height = 25
        Caption = '[F10]Liberar CNPJ para faturamento'
        TabOrder = 0
        OnClick = btnLibCNPJClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 947
      Top = 5
      ExplicitLeft = 1277
      ExplicitTop = 5
    end
  end
  inherited pnlStatus: TPanel
    Top = 780
    Width = 1030
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 859
      ExplicitLeft = 1189
    end
    inherited pnlInfo: TPanel
      Width = 859
      ExplicitWidth = 1189
    end
  end
  inherited pgcDados: TPageControl
    Width = 1030
    Height = 751
    ExplicitWidth = 1360
    ExplicitHeight = 694
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1352
      ExplicitHeight = 662
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 1030
    Height = 751
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 1360
    ExplicitHeight = 694
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1028
      Height = 749
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 1358
      ExplicitHeight = 692
      object cxgrdLibCNPJ: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsLibCNPJ
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
        object cxgrdLibCNPJ_DATAHORA: TcxGridDBColumn
          Caption = 'Dt. Consulta'
          DataBinding.FieldName = 'DATAHORA'
        end
        object cxgrdLibCNPJ_CODCLI: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'CODCLI'
          Width = 68
        end
        object cxgrdLibCNPJ_C_G_C_: TcxGridDBColumn
          Caption = 'CNPJ'
          DataBinding.FieldName = 'C_G_C_'
          Width = 147
        end
        object cxgrdLibCNPJ_NOMCLI: TcxGridDBColumn
          Caption = 'Raz'#227'o Social'
          DataBinding.FieldName = 'NOMCLI'
          Width = 332
        end
        object cxgrdLibCNPJ_FANSOB: TcxGridDBColumn
          Caption = 'Nome Fantasia'
          DataBinding.FieldName = 'FANSOB'
          Width = 239
        end
        object cxgrdLibCNPJ_NOMCID: TcxGridDBColumn
          Caption = 'Cidade'
          DataBinding.FieldName = 'NOMCID'
        end
        object cxgrdLibCNPJ_ESTADO: TcxGridDBColumn
          Caption = 'UF'
          DataBinding.FieldName = 'ESTADO'
          Width = 34
        end
        object cxgrdLibCNPJ_DESSIT: TcxGridDBColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'DESSIT'
          Width = 127
        end
        object cxgrdLibCNPJ_OBSERV: TcxGridDBColumn
          Caption = 'Observa'#231#245'es'
          DataBinding.FieldName = 'OBSERV'
          Width = 600
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxgrdLibCNPJ
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1080
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1048
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 976
  end
  object cdsLibCNPJ: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 992
    Top = 640
    object cdsLibCNPJDATAHORA: TStringField
      FieldName = 'DATAHORA'
    end
    object cdsLibCNPJCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsLibCNPJC_G_C_: TStringField
      FieldName = 'C_G_C_'
    end
    object cdsLibCNPJNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsLibCNPJFANSOB: TStringField
      FieldName = 'FANSOB'
      Size = 60
    end
    object cdsLibCNPJNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 40
    end
    object cdsLibCNPJESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsLibCNPJDESSIT: TStringField
      FieldName = 'DESSIT'
      Size = 255
    end
    object cdsLibCNPJOBSERV: TStringField
      FieldName = 'OBSERV'
      Size = 255
    end
    object cdsLibCNPJAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object dtsLibCNPJ: TDataSource
    DataSet = cdsLibCNPJ
    Left = 1056
    Top = 640
  end
end
