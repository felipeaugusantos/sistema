inherited frmEditorCamposModeloArquivo: TfrmEditorCamposModeloArquivo
  Width = 564
  Height = 632
  Caption = 'Editor: Campos do Modelo do Arquivo'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 564
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 561
    Width = 558
    ExplicitTop = 561
    ExplicitWidth = 558
    inherited FlwBotoes: TFlowPanel
      Width = 554
      ExplicitWidth = 554
      inherited btnConfirma: TBitBtnLocked
        Width = 105
        Caption = '&Confirma [F10]'
        ExplicitWidth = 105
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      Top = 2
      Width = 105
      ExplicitLeft = 450
      ExplicitTop = 2
      ExplicitWidth = 105
    end
  end
  inherited pnlStatus: TPanel
    Top = 587
    Width = 558
    ExplicitTop = 587
    ExplicitWidth = 558
    inherited pnlNomeForm: TPanel
      Left = 351
      Width = 207
      ExplicitLeft = 351
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 351
      ExplicitWidth = 351
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 558
    Height = 49
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 4
      Width = 134
      Height = 14
      Caption = 'Nome do Modelo do Arquivo'
    end
  end
  object cxCampos: TcxGrid [3]
    Left = 0
    Top = 49
    Width = 558
    Height = 512
    Align = alClient
    TabOrder = 4
    object cxCamposTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsCampos
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxCamposCampo: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'CMP_DESCAM'
        MinWidth = 100
        Options.Editing = False
        Width = 372
      end
      object cxCamposColunaExcel: TcxGridDBColumn
        Caption = 'Coluna Excel'
        DataBinding.FieldName = 'CMP_COLCAM'
        HeaderAlignmentHorz = taCenter
        Width = 81
      end
      object cxCamposObrigatorio: TcxGridDBColumn
        Caption = 'Obrigat'#243'rio'
        DataBinding.FieldName = 'CMP_OBRCAM'
        Options.Editing = False
        Width = 71
      end
    end
    object cxCamposLvl: TcxGridLevel
      GridView = cxCamposTableView
    end
  end
  object edtDescricaoModelo: TEdit [4]
    Tag = 99
    Left = 2
    Top = 21
    Width = 426
    Height = 22
    CharCase = ecUpperCase
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 68
    Top = 172
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 244
    Top = 152
  end
  object dtsCampos: TDataSource
    DataSet = cdsCamposArquivo
    Left = 192
    Top = 100
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 148
    Top = 236
  end
  object cdsCamposArquivo: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_SEQARQ'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_DESCAM'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CMP_OBRCAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_TIPCAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_NOMCAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_COLCAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_POSCAM'
        DataType = ftInteger
      end
      item
        Name = 'CMP_CODCAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CMP_TAMCAM'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsCamposArquivoBeforePost
    OnPostError = cdsCamposArquivoPostError
    Left = 104
    Top = 96
    object cdsCamposArquivoAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCamposArquivoCMP_SEQARQ: TStringField
      FieldName = 'CMP_SEQARQ'
    end
    object cdsCamposArquivoCMP_DESCAM: TStringField
      DisplayWidth = 100
      FieldName = 'CMP_DESCAM'
      Size = 100
    end
    object cdsCamposArquivoCMP_OBRCAM: TStringField
      FieldName = 'CMP_OBRCAM'
    end
    object cdsCamposArquivoCMP_TIPCAM: TStringField
      FieldName = 'CMP_TIPCAM'
    end
    object cdsCamposArquivoCMP_NOMCAM: TStringField
      DisplayWidth = 100
      FieldName = 'CMP_NOMCAM'
      Size = 100
    end
    object cdsCamposArquivoCMP_COLCAM: TStringField
      FieldName = 'CMP_COLCAM'
      KeyFields = 'CMP_COLCAM'
      ProviderFlags = []
    end
    object cdsCamposArquivoCMP_POSCAM: TIntegerField
      FieldName = 'CMP_POSCAM'
    end
    object cdsCamposArquivoCMP_CODCAM: TStringField
      FieldName = 'CMP_CODCAM'
    end
    object cdsCamposArquivoCMP_TAMCAM: TIntegerField
      FieldName = 'CMP_TAMCAM'
    end
  end
end
