inherited frmEtiOrcPed: TfrmEtiOrcPed
  Left = 568
  Top = 281
  Width = 1067
  Height = 389
  Caption = 'Etiquetas - Produtos do OrcPed'
  Position = poDefault
  ExplicitWidth = 1067
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 318
    Width = 1061
    Height = 26
    TabOrder = 2
    ExplicitTop = 318
    ExplicitWidth = 1061
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 969
      Height = 22
      ExplicitWidth = 969
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 98
        Height = 22
        Caption = '[ F10 ] Imprimir'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnLimFil: TBitBtnLocked
        Left = 98
        Top = 0
        Width = 98
        Height = 22
        Caption = '[ F4 ] Limpa Filtro'
        TabOrder = 1
        OnClick = btnLimFilClick
      end
      object btnConfigurar: TBitBtnLocked
        Left = 196
        Top = 0
        Width = 98
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[F6] &Configurar'
        TabOrder = 2
        OnClick = btnConfigurarClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 294
        Top = 0
        Width = 165
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F9 ] Marcar / Desmarcar Todas'
        TabOrder = 3
        OnClick = btnMarDesClick
      end
      object btnAlterarTodasQtd: TBitBtnLocked
        Left = 459
        Top = 0
        Width = 182
        Height = 22
        Caption = 'Alterar Todas "Qtd. a Imprimir"'
        TabOrder = 4
        OnClick = btnAlterarTodasQtdClick
      end
      object btnRestaurarTodasQtd: TBitBtnLocked
        Left = 641
        Top = 0
        Width = 184
        Height = 22
        Caption = 'Restaurar Todas "Qtd. a Imprimir"'
        TabOrder = 5
        OnClick = btnRestaurarTodasQtdClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 971
      Top = 2
      Width = 88
      Align = alRight
      ExplicitLeft = 971
      ExplicitTop = 2
      ExplicitWidth = 88
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 1061
    TabOrder = 3
    ExplicitTop = 344
    ExplicitWidth = 1061
    inherited pnlNomeForm: TPanel
      Left = 890
      ExplicitLeft = 890
    end
    inherited pnlInfo: TPanel
      Width = 890
      ExplicitWidth = 890
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1061
    Height = 70
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 10
      Width = 69
      Height = 14
      Caption = 'N'#186' Documento'
    end
    object Label2: TLabel
      Left = 107
      Top = 10
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object lblEmpresa: TLabel
      Left = 157
      Top = 10
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 16
      Top = 24
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 107
      Top = 24
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 157
      Top = 24
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 192
      Top = 24
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  object pnlDetalhes: TPanel [3]
    Left = 0
    Top = 70
    Width = 1061
    Height = 248
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object cxgFatDor: TcxGrid
      Left = 0
      Top = 0
      Width = 1061
      Height = 248
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgFatDorView: TcxGridDBTableView
        OnKeyDown = cxgFatDorViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsEtiquetas
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Filter.Active = True
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxgFatDorCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 44
        end
        object cxgFatDorDescricao: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 252
        end
        object cxgFatDorRefere: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Width = 115
        end
        object cxgFatDorLOCSEP: TcxGridDBColumn
          Caption = 'Local de Sep.'
          DataBinding.FieldName = 'LOCSEP'
          Width = 105
        end
        object cxgFatDorLOCFIS: TcxGridDBColumn
          Caption = 'Localiza'#231#227'o F'#237'sica'
          DataBinding.FieldName = 'LOCFIS'
          Width = 110
        end
        object cxgFatDorSigUni: TcxGridDBColumn
          Caption = 'Un.'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Options.Focusing = False
          Width = 36
        end
        object cxgFatDorCODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'CODFAB'
          Width = 98
        end
        object cxgFatDorCODBAR: TcxGridDBColumn
          Caption = 'C'#243'd. Barras'
          DataBinding.FieldName = 'CODBAR'
          Width = 96
        end
        object cxgFatDorQtdEti: TcxGridDBColumn
          Caption = 'Qtd Vendida'
          DataBinding.FieldName = 'QTDETI'
          Options.Editing = False
          Options.Focusing = False
          Width = 72
        end
        object cxgFatDorQtdImp: TcxGridDBColumn
          Caption = 'Qtd a Imprimir'
          DataBinding.FieldName = 'QTDIMP'
          RepositoryItem = spnQtdImp
          Width = 75
        end
        object cxgFatDorImprimir: TcxGridDBColumn
          Caption = 'Imprime?'
          DataBinding.FieldName = 'IMPRME'
          RepositoryItem = chkImprimir
          HeaderAlignmentHorz = taCenter
          Width = 56
        end
        object cxgFatDorViewAutoincrem: TcxGridDBColumn
          DataBinding.FieldName = 'AUTOINCREM'
          Visible = False
        end
        object cxgFatDorViewOrdIte: TcxGridDBColumn
          DataBinding.FieldName = 'ORDITE'
          Visible = False
        end
        object cxgFatDorViewLocFis: TcxGridDBColumn
          DataBinding.FieldName = 'LOCFIS'
          Visible = False
        end
        object cxgFatDorViewDesDep: TcxGridDBColumn
          DataBinding.FieldName = 'DESDEP'
          Visible = False
        end
        object cxgFatDorViewEntRet: TcxGridDBColumn
          DataBinding.FieldName = 'ENTRET'
          Visible = False
        end
      end
      object cxgFatDorLevel1: TcxGridLevel
        GridView = cxgFatDorView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 128
  end
  object frxEtiOrcPed: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.411589062500000000
    ReportOptions.LastChange = 40277.553128252300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 400
    Top = 232
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Gondola: TfrxReportPage
      PaperWidth = 102.000000000000000000
      PaperHeight = 62.000000000000000000
      PaperSize = 256
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 234.330708661417000000
        Top = 18.897650000000000000
        Width = 385.512060000000000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 14.553803340000000000
          Top = 13.102350010000000000
          Width = 354.036796660000000000
          Height = 169.401670000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBImpEti: TfrxDBDataset
    UserName = 'frxDBImpEti'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDOC=NUMDOC'
      'ESPDOC=ESPDOC'
      'CODEMP=CODEMP'
      'NOMEMP=NOMEMP'
      'CODITE=CODITE'
      'DESITE=DESITE'
      'REFERE=REFERE'
      'SIGUNI=SIGUNI'
      'ORDITE=ORDITE'
      'DESMAR=DESMAR'
      'VALITE=VALITE'
      'VALVIS=VALVIS'
      'CODFAB=CODFAB'
      'CODBAR=CODBAR'
      'LOCFIS=LOCFIS'
      'QTDETI=QTDETI'
      'QTDVND=QTDVND')
    DataSet = cdsEtiquetas
    BCDToCurrency = False
    Left = 464
    Top = 232
  end
  object cdsEtiquetas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 176
    object cdsEtiquetasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEtiquetasORDITE: TIntegerField
      FieldName = 'ORDITE'
    end
    object cdsEtiquetasNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object strngfldEtiquetasESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsEtiquetasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEtiquetasNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 40
    end
    object cdsEtiquetasCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsEtiquetasDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsEtiquetasREFERE: TStringField
      FieldName = 'REFERE'
      Size = 50
    end
    object cdsEtiquetasSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsEtiquetasDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsEtiquetasVALITE: TFloatField
      FieldName = 'VALITE'
    end
    object cdsEtiquetasVALVIS: TFloatField
      FieldName = 'VALVIS'
    end
    object cdsEtiquetasCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsEtiquetasCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object cdsEtiquetasLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 10
    end
    object cdsEtiquetasQTDETI: TFloatField
      FieldName = 'QTDETI'
    end
    object cdsEtiquetasQTDIMP: TIntegerField
      FieldName = 'QTDIMP'
    end
    object cdsEtiquetasIMPRME: TStringField
      FieldName = 'IMPRME'
      Size = 1
    end
    object cdsEtiquetasFABITE: TStringField
      FieldName = 'FABITE'
      Size = 25
    end
    object cdsEtiquetasFABCLI: TStringField
      FieldName = 'FABCLI'
      Size = 25
    end
    object cdsEtiquetasAPLICA: TStringField
      FieldName = 'APLICA'
      Size = 255
    end
    object cdsEtiquetasLOCSEP: TStringField
      FieldName = 'LOCSEP'
      Size = 40
    end
    object cdsEtiquetasNUMCMP: TStringField
      FieldName = 'NUMCMP'
      Size = 256
    end
  end
  object dtsEtiquetas: TDataSource
    DataSet = cdsEtiquetas
    Left = 464
    Top = 176
  end
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxEtiquetaItens'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'IMP_EDUARDO'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39377.549029351900000000
    ReportOptions.LastChange = 40547.584824756950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 16
    Top = 264
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 18.897650000000000000
          Top = 56.692949999999990000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Top = 86.929190000000000000
          Width = 230.551330000000000000
          Height = 60.472480000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object cxRepository: TcxEditRepository
    Left = 584
    Top = 158
    PixelsPerInch = 96
    object chkImprimir: TcxEditRepositoryCheckBoxItem
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
    object spnQtdImp: TcxEditRepositorySpinItem
      Properties.AssignedValues.MaxValue = True
      Properties.ImmediatePost = True
      Properties.MinValue = 1.000000000000000000
      Properties.ValueType = vtInt
      Properties.OnValidate = spnQtdImpPropertiesValidate
    end
  end
  object cdsQtdEti: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 184
    object cdsQtdEtiAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsQtdEtiQTDIMP: TIntegerField
      FieldName = 'QTDIMP'
    end
    object cdsQtdEtiIMPRME: TStringField
      FieldName = 'IMPRME'
      Size = 1
    end
  end
end
