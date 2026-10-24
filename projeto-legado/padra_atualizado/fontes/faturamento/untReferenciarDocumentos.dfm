inherited frmReferenciarDocumentos: TfrmReferenciarDocumentos
  Width = 508
  Height = 390
  Caption = 'Referenciar Documentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 508
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 502
    ExplicitTop = 319
    ExplicitWidth = 502
    inherited FlwBotoes: TFlowPanel
      Width = 498
      ExplicitWidth = 498
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 419
      ExplicitLeft = 419
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 502
    ExplicitTop = 345
    ExplicitWidth = 502
    inherited pnlNomeForm: TPanel
      Left = 331
      ExplicitLeft = 331
    end
    inherited pnlInfo: TPanel
      Width = 331
      ExplicitWidth = 331
    end
  end
  object pnlDocumento: TPanel [2]
    Left = 0
    Top = 0
    Width = 502
    Height = 37
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblChaveAcesso: TLabel
      Left = 3
      Top = 10
      Width = 89
      Height = 14
      Caption = 'Chave de Acesso:'
    end
    object edtChave: TEditFocus
      Left = 95
      Top = 7
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 50
      TabOrder = 0
      OnKeyPress = edtChaveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttInteiro
    end
    object btnAdicionar: TBitBtnLocked
      Left = 415
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Adicionar'
      TabOrder = 1
      OnClick = btnAdicionarClick
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 296
    Width = 502
    Height = 23
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblLegendaDeletar: TLabel
      Left = 15
      Top = 3
      Width = 105
      Height = 14
      Caption = '* [Delete] para excluir.'
    end
  end
  object grdDocumento: TcxGrid [4]
    Left = 0
    Top = 37
    Width = 502
    Height = 259
    Align = alClient
    TabOrder = 4
    object grdDocumentoDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsChave
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object grdDocumentoCHAVE: TcxGridDBColumn
        Caption = 'Chave Acesso'
        DataBinding.FieldName = 'CHAVE'
      end
    end
    object grdDocumentoLevel: TcxGridLevel
      GridView = grdDocumentoDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 616
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 64
  end
  object cdsChave: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 80
    object cdsChaveCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 50
    end
  end
  object dtsChave: TDataSource
    DataSet = cdsChave
    Left = 152
    Top = 80
  end
end
