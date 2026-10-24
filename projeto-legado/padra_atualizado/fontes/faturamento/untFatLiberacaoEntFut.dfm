inherited frmFatLiberacaoEntFut: TfrmFatLiberacaoEntFut
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Libera'#231#227'o de Entega Futura mediante Entrada de Mercadorias'
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 784
    ExplicitTop = 519
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 703
      ExplicitWidth = 703
      inherited btnConfirma: TBitBtnLocked
        Width = 117
        Caption = '[ F10 ] Confirma'
        ModalResult = 0
        ExplicitWidth = 117
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Align = alRight
      ExplicitLeft = 705
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 40
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label1: TLabel
      Left = 336
      Top = 15
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 10
      Top = 15
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 253
      Top = 15
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label4: TLabel
      Left = 175
      Top = 15
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 69
      Top = 36
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 140
      Top = 36
      Width = 553
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 383
      Top = 11
      Width = 34
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
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
      Left = 419
      Top = 11
      Width = 274
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 11
      Width = 101
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
      Left = 296
      Top = 11
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
    end
    object rdgAtender: TRadioGroup
      Tag = 99
      Left = 69
      Top = 64
      Width = 317
      Height = 48
      Caption = 'Atender entregas futuras'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'somente desta empresa'
        'de todas as empresas')
      TabOrder = 6
      OnExit = rdgAtenderExit
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 206
      Top = 11
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 121
    Width = 784
    Height = 398
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTab: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsul
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensCodIte: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        Width = 54
      end
      object cxgItensDecri: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESCRI'
        Width = 179
      end
      object cxgItensRefere: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 77
      end
      object cxgItensSigUni: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Width = 47
      end
      object cxgItensNumDoc: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Width = 115
      end
      object cxgItensEspDoc: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 28
      end
      object cxgItensCodEmp: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
        Width = 32
      end
      object cxgItensDtaFut: TcxGridDBColumn
        Caption = 'Previs'#227'o'
        DataBinding.FieldName = 'DTAFUT'
        Width = 56
      end
      object cxgItensQtdIte: TcxGridDBColumn
        Caption = 'Qtd. Pendente'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object cxgItensQtdNot: TcxGridDBColumn
        Caption = 'Qtd. Nota'
        DataBinding.FieldName = 'QTDNOT'
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTab
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 200
  end
  object dtsConsul: TDataSource
    Left = 464
    Top = 208
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40681.508389930550000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 352
    Top = 232
    Datasets = <
      item
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 748.800000000000100000
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESCRI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."DESCRI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'SIGUNI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDITE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSet."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'MOTFUT'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."MOTFUT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAFUT'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."DTAFUT"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 748.800000000000100000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 170.000000000000000000
        Width = 748.800000000000100000
        ReprintOnNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DTA. PREV.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 748.800000000000100000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[DADOS_NOTA]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 748.800000000000100000
        Condition = 'frxDataSet."QUEBRA"'
        object DMPMemo12: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."NUMDOC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPDOC'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."ESPDOC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."CODEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMCLI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."NOMCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMVEN'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSet."NOMVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDataSet: TfrxDBDataset
    UserName = 'frxDataSet'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 432
    Top = 256
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40681.632306134270000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 384
    Top = 232
    Datasets = <
      item
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.126160000000000000
        Width = 748.800000012278100000
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
        RowCount = 0
        object DMPMemo10: TfrxMemoView
          Left = 96.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."CODITE"]')
          ParentFont = False
        end
        object DMPMemo11: TfrxMemoView
          Left = 153.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESCRI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."DESCRI"]')
          ParentFont = False
        end
        object DMPMemo15: TfrxMemoView
          Left = 384.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'SIGUNI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."SIGUNI"]')
          ParentFont = False
        end
        object DMPMemo16: TfrxMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDITE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSet."QTDITE"]')
        end
        object DMPMemo17: TfrxMemoView
          Left = 537.600000000000000000
          Width = 63.118120000000000000
          Height = 17.000000000000000000
          DataField = 'MOTFUT'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSet."MOTFUT"]')
          ParentFont = False
        end
        object DMPMemo18: TfrxMemoView
          Left = 610.318120000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAFUT'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."DTAFUT"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 381.732530000000000000
        Width = 748.800000012278100000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 385.738590000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 347.640940000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 185.196970000000000000
        Width = 748.800000012278100000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 748.800000012278100000
          Height = 18.881880000000000000
          Fill.BackColor = clActiveBorder
        end
        object DMPMemo4: TfrxMemoView
          Left = 96.000000000000000000
          Top = 1.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object DMPMemo5: TfrxMemoView
          Left = 151.559060000000000000
          Top = 1.000000000000000000
          Width = 223.596970000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object DMPMemo7: TfrxMemoView
          Left = 447.722820000000000000
          Top = 1.000000000000000000
          Width = 79.823500000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 385.512060000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 540.472790000000000000
          Width = 61.077180000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 608.504330000000000000
          Width = 98.872480000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. PREV.')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 103.881880000000000000
        Top = 18.897650000000000000
        Width = 748.800000012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 9.600000006139060000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 129.600000006139100000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 626.040940000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 674.040940000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 549.240940000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object DMPMemo1: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[DADOS_NOTA]')
        end
        object DMPMemo3: TfrxMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 226.771800000000000000
        Width = 748.800000012278100000
        Condition = 'frxDataSet."QUEBRA"'
        object DMPMemo12: TfrxMemoView
          Left = 107.867780000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."NUMDOC"]')
          ParentFont = False
        end
        object DMPMemo13: TfrxMemoView
          Left = 194.267780000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPDOC'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."ESPDOC"]')
          ParentFont = False
        end
        object DMPMemo14: TfrxMemoView
          Left = 242.267780000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."CODEMP"]')
          ParentFont = False
        end
        object DMPMemo8: TfrxMemoView
          Left = 290.267780000000000000
          Width = 234.784230000000000000
          Height = 17.000000000000000000
          DataField = 'NOMCLI'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."NOMCLI"]')
          ParentFont = False
        end
        object DMPMemo9: TfrxMemoView
          Left = 530.872480000000000000
          Width = 208.327520000000000000
          Height = 17.000000000000000000
          DataField = 'NOMVEN'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSet."NOMVEN"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Width = 95.092950000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 7.559059999999999000
        Top = 313.700990000000000000
        Width = 748.800000012278100000
      end
    end
  end
end
