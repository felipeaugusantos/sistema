inherited frmDocsRomaneioiLog: TfrmDocsRomaneioiLog
  Width = 1008
  Height = 520
  Caption = 'Documentos do romaneio'
  OnDestroy = FormDestroy
  ExplicitWidth = 1008
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 1002
    ExplicitTop = 447
    ExplicitWidth = 950
    inherited FlwBotoes: TFlowPanel
      Width = 998
      ExplicitWidth = 946
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 862
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 1002
    ExplicitTop = 475
    ExplicitWidth = 950
    inherited pnlNomeForm: TPanel
      Left = 831
      ExplicitLeft = 779
    end
    inherited pnlInfo: TPanel
      Width = 831
      ExplicitWidth = 779
    end
  end
  object cxgDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1002
    Height = 447
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 950
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
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
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgDocumentosSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Width = 109
      end
      object cxgDocumentosDET_DTAOCO: TcxGridDBColumn
        Caption = 'Data status'
        DataBinding.FieldName = 'DET_DTAOCO'
      end
      object cxgDocumentosDET_HOROCO: TcxGridDBColumn
        Caption = 'Hora status'
        DataBinding.FieldName = 'DET_HOROCO'
      end
      object cxgDocumentosGER_DTAROM: TcxGridDBColumn
        Caption = 'Dt.Romaneio'
        DataBinding.FieldName = 'GER_DTAROM'
        Width = 77
      end
      object cxgDocumentosGER_HORROM: TcxGridDBColumn
        Caption = 'Hr.Romaneio'
        DataBinding.FieldName = 'GER_HORROM'
        Width = 75
      end
      object cxgDocumentosGER_DTAENT: TcxGridDBColumn
        Caption = 'Data Entrada'
        DataBinding.FieldName = 'GER_DTAENT'
        Width = 77
      end
      object cxgDocumentosGER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
        Width = 119
      end
      object cxgDocumentosGER_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
        Width = 36
      end
      object cxgDocumentosGER_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'GER_NOMCLI'
        Width = 68
      end
      object cxgDocumentosCID_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Width = 95
      end
      object cxgDocumentosGER_CODVEN: TcxGridDBColumn
        Caption = 'Vend.'
        DataBinding.FieldName = 'GER_CODVEN'
        Width = 116
      end
      object cxgDocumentosTRA_NOMTRA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'TRA_NOMTRA'
        Width = 135
      end
      object cxgDocumentosGER_VLRCON: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'GER_VLRCON'
        Width = 69
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
  object dtsDocumentos: TDataSource
    Left = 464
    Top = 248
  end
end
