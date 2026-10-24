inherited frmFatDocsPendentesRemessaDevolucao: TfrmFatDocsPendentesRemessaDevolucao
  Width = 807
  Height = 577
  Caption = 'Documentos Pendentes de Remessa de Devolu'#231#227'o'
  ExplicitWidth = 807
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 504
    Width = 801
    ExplicitTop = 504
    ExplicitWidth = 801
    inherited FlwBotoes: TFlowPanel
      Width = 797
      ExplicitWidth = 797
    end
    inherited btnSair: TBitBtnLocked
      Left = 721
      ExplicitLeft = 721
    end
  end
  inherited pnlStatus: TPanel
    Top = 532
    Width = 801
    ExplicitTop = 532
    ExplicitWidth = 801
    inherited pnlNomeForm: TPanel
      Left = 581
      Width = 220
      ExplicitLeft = 591
      ExplicitWidth = 220
    end
    inherited pnlInfo: TPanel
      Width = 581
      ExplicitWidth = 630
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 801
    Height = 77
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblDataInicial: TLabel
      Left = 26
      Top = 17
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object lblDataFinal: TLabel
      Left = 164
      Top = 17
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object lblEmp: TLabel
      Left = 311
      Top = 17
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = -5
      Top = 45
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Item:'
    end
    object btnPesquisar: TBitBtnLocked
      Left = 661
      Top = 41
      Width = 111
      Height = 22
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 6
      OnClick = btnPesquisarClick
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 83
      Top = 13
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 217
      Top = 13
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 359
      Top = 13
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 439
      Top = 13
      Width = 333
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 83
      Top = 41
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 154
      Top = 41
      Width = 501
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object grdDocumentos: TcxGrid [3]
    Left = 0
    Top = 77
    Width = 801
    Height = 417
    Align = alClient
    TabOrder = 3
    object grdDocumentosDBTvDoc: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.DataSource = dtsDocumentos
      DataController.KeyFieldNames = 'DOCUMENTO'
      DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CellHints = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdDocumentosDBTvDocDTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DET_DTAENT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 70
      end
      object grdDocumentosDBTvDocHORENT: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'DET_HORENT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 64
      end
      object grdDocumentosDBTvDocDOCUMENTO: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUMENTO'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 130
      end
      object grdDocumentosDBTvDocCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 270
      end
      object grdDocumentosDBTvDocFIS_ACESSO: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'FIS_ACESSO'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 230
      end
    end
    object grdDocumentosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object grdDocumentosDBTvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.DataSource = dtsItens
      DataController.DetailKeyFieldNames = 'DOCUMENTO'
      DataController.KeyFieldNames = 'DET_CODITE'
      DataController.MasterKeyFieldNames = 'DOCUMENTO'
      DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.DragDropText = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdDocumentosDBTvItensPRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUTO'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 600
      end
      object grdDocumentosDBTvItensDET_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'DET_QTDITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 80
      end
      object grdDocumentosDBTvItensDET_CLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'DET_CLAFIS'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
      end
    end
    object grdDocumentosLevel1: TcxGridLevel
      GridView = grdDocumentosDBTvDoc
      object grdDocumentosLevel2: TcxGridLevel
        GridView = grdDocumentosDBTvItens
      end
    end
  end
  object pgbStatus: TProgressBar [4]
    Left = 0
    Top = 494
    Width = 801
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 129
    object cdsDocumentosDET_DTAENT: TDateField
      FieldName = 'DET_DTAENT'
    end
    object cdsDocumentosDET_HORENT: TTimeField
      FieldName = 'DET_HORENT'
    end
    object cdsDocumentosDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Size = 12
    end
    object cdsDocumentosDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object cdsDocumentosDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Size = 3
    end
    object cdsDocumentosDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 30
    end
    object cdsDocumentosDET_CODCLI: TStringField
      FieldName = 'DET_CODCLI'
      Size = 8
    end
    object cdsDocumentosCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsDocumentosCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 80
    end
    object cdsDocumentosFIS_ACESSO: TStringField
      FieldName = 'FIS_ACESSO'
      Size = 50
    end
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 48
    Top = 177
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 129
    object cdsItensPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsItensDET_QTDITE: TFloatField
      FieldName = 'DET_QTDITE'
      DisplayFormat = ',0.00'
    end
    object cdsItensDET_CLAFIS: TStringField
      FieldName = 'DET_CLAFIS'
      Size = 4
    end
    object cdsItensDET_CODITE: TStringField
      FieldName = 'DET_CODITE'
      Size = 8
    end
    object cdsItensDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 30
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 136
    Top = 177
  end
end
