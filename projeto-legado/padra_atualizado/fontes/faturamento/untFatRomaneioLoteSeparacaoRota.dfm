inherited frmFatRomaneioLoteSeparacaoRota: TfrmFatRomaneioLoteSeparacaoRota
  Width = 742
  Height = 428
  Caption = 'Lote de Separa'#231#227'o para Romaneios - Rota'
  WindowState = wsMaximized
  ExplicitWidth = 742
  ExplicitHeight = 428
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 355
    Width = 736
    ExplicitTop = 355
    ExplicitWidth = 736
    inherited FlwBotoes: TFlowPanel
      Width = 0
      Align = alNone
      ExplicitWidth = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 657
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 657
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 655
      Height = 24
      Align = alClient
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      ShowCaption = False
      TabOrder = 2
      object Label1: TLabel
        Left = 8
        Top = 5
        Width = 362
        Height = 14
        Caption = '[CTRL + SETA] - Movimenta os documento para cima ou para baixo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 383
    Width = 736
    ExplicitTop = 383
    ExplicitWidth = 736
    inherited pnlNomeForm: TPanel
      Left = 565
      ExplicitLeft = 565
    end
    inherited pnlInfo: TPanel
      Width = 565
      ExplicitWidth = 565
    end
  end
  object cxgDocumentos: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 736
    Height = 355
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsRotas
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
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgSEQUEN: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'SEQUEN'
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxgDocumentosTableViewColumn1: TcxGridDBColumn
        Caption = 'Dt. Entrada'
        DataBinding.FieldName = 'DTAENT'
      end
      object cxgDocumentosTableViewColumn2: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'HORENT'
      end
      object cxgDocumentosTableViewColumn3: TcxGridDBColumn
        Caption = 'Dt. Entrega'
        DataBinding.FieldName = 'DTENTR'
      end
      object cxgDocumentosTableViewColumn4: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
      end
      object cxgDocumentosTableViewColumn5: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
      end
      object cxgDocumentosTableViewColumn6: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
      end
      object cxgDocumentosTableViewColumn7: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
      end
      object cxgDocumentosTableViewColumn8: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
      end
      object cxgDocumentosTableViewColumn9: TcxGridDBColumn
        Caption = 'Regi'#227'o'
        DataBinding.FieldName = 'DESREG'
      end
      object cxgDocumentosTableViewColumn10: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'NOMCID'
      end
      object cxgDocumentosTableViewColumn11: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'BAIENT'
      end
      object cxgDocumentosTableViewColumn12: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDENT'
      end
      object cxgDocumentosTableViewColumn13: TcxGridDBColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'PESBRU'
      end
      object cxgDocumentosTableViewColumn14: TcxGridDBColumn
        Caption = 'Forma de Pagamento'
        DataBinding.FieldName = 'DESFPG'
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
  object cdsRotas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 184
  end
  object dtsRotas: TDataSource
    DataSet = cdsRotas
    Left = 336
    Top = 232
  end
end
