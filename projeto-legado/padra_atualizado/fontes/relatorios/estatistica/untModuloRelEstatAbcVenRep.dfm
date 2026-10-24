object frmModuloRelEstatAbcVenRep: TfrmModuloRelEstatAbcVenRep
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 304
  Width = 215
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 33
    Top = 64
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 33
    Top = 112
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 136
    Top = 112
  end
  object frxExpXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 136
    Top = 160
  end
  object frxExpHtml: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 33
    Top = 160
  end
  object frxExpRTF: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'Citel Software'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 33
    Top = 208
  end
  object frxRelatorioM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41002.646944803200000000
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
      ''
      'begin'
      ''
      'end.')
    Left = 33
    Top = 14
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 330.199786745971100000
      PaperHeight = 278.870653229369800000
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
        Top = 323.000000000000000000
        Width = 1228.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rdbValCod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'CODVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          TruncOutboundText = False
        end
        object rdbValVen: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object rdbValCid: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCID'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCID"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValPra: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRAMED"]')
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
          TruncOutboundText = False
        end
        object rdbValRep: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'PERVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERVEN"]')
          TruncOutboundText = False
        end
        object rdbValAcu: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERACU"]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'QTDCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'QTDMOV'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDMOV"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'PERCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERCLI"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
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
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1228.800000000000000000
        ReprintOnNewPage = True
        object rllTitCod: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitVen: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 230.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'NOME DO VENDEDOR')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object rllTitCid: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 240.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'CIDADE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitPra: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO MED.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitTot: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT. VENDA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitRep: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitAcu: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '% ACUM')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'CLIENTES'
            'CARTEIRA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'CLIENTES'
            'MOVIMENT.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80#15#27#80#18#27#77'
        end
        object rllVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object rllRepresentante: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          TruncOutboundText = False
        end
        object rllProduto: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PRODUTO]')
          TruncOutboundText = False
        end
        object rllFornecedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 68.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCidade: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 85.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 102.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 170.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object rllRedeLoja: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 119.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[REDELOJA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MARCA]')
          TruncOutboundText = False
        end
        object rllDepPro: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 136.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO.PRODUTO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1228.800000000000000000
        object rllTotal_: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOS VENDEDORES:')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbSumPra: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbSumVen: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllSumRep: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PERVEN">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDCLI">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDMOV">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41002.647152048600000000
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
      ''
      'begin'
      ''
      'end.')
    Left = 137
    Top = 14
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 279.400000000000000000
      PaperHeight = 278.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 321.260050000000000000
        Width = 1018.205382000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1018.205382000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rdbValCod: TfrxMemoView
          Left = 8.000000000000000000
          Width = 52.913385826771700000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'CODVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValVen: TfrxMemoView
          Left = 66.000000000000000000
          Width = 188.976377950000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValCid: TfrxMemoView
          Left = 259.600000000000000000
          Width = 207.874015750000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCID'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCID"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValPra: TfrxMemoView
          Left = 472.102350000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRAMED"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValTot: TfrxMemoView
          Left = 571.702350000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValRep: TfrxMemoView
          Left = 671.302350000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'PERVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValAcu: TfrxMemoView
          Left = 733.160617720000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERACU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 794.598950000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'QTDCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 874.866730000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'QTDMOV'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDMOV"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 954.898270000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'PERCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 449.764070000000000000
        Width = 1018.205382000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 17.000000000000000000
          Width = 500.938590000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baWidth
          Left = 500.938590000000000000
          Top = 17.000000000000000000
          Width = 517.266792000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.015748031496100000
        Top = 264.567100000000000000
        Width = 1018.205382000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 1018.205382000000000000
          Height = 34.015748031496100000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object rllTitCod: TfrxMemoView
          Left = 8.000000000000000000
          Width = 52.913385830000000000
          Height = 34.015748031496100000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitVen: TfrxMemoView
          Left = 66.000000000000000000
          Width = 188.976377950000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO VENDEDOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitCid: TfrxMemoView
          Left = 259.600000000000000000
          Width = 207.874015750000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitPra: TfrxMemoView
          Left = 472.102350000000000000
          Width = 94.488188980000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO MED.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitTot: TfrxMemoView
          Left = 571.702350000000000000
          Width = 94.488188980000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT. VENDA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitRep: TfrxMemoView
          Left = 671.302350000000000000
          Width = 56.692913390000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitAcu: TfrxMemoView
          Left = 733.160617720000000000
          Width = 56.692913390000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% ACUM')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 794.598950000000000000
          Width = 75.590551180000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CLIENTES'
            'CARTEIRA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 874.866730000000000000
          Width = 75.590551180000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CLIENTES'
            'MOVIMENT.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 954.898270000000000000
          Width = 56.692913390000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 185.196847950000000000
        Top = 18.897650000000000000
        Width = 1018.205382000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 178.394029585000000000
          Top = 17.000000000000000000
          Width = 661.417322830000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 178.394029585000000000
          Top = 34.000000000000000000
          Width = 661.417322830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 895.005382000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Time: TfrxMemoView
          Left = 943.005382000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Date: TfrxMemoView
          Left = 779.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllVendedor: TfrxMemoView
          Left = 8.000000000000000000
          Top = 73.690697140000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllRepresentante: TfrxMemoView
          Left = 8.000000000000000000
          Top = 90.701961430000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllProduto: TfrxMemoView
          Left = 8.000000000000000000
          Top = 125.724490000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllFornecedor: TfrxMemoView
          Left = 8.000000000000000000
          Top = 107.713225710000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliente: TfrxMemoView
          Left = 511.005382000000000000
          Top = 73.690697140000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCidade: TfrxMemoView
          Left = 511.005382000000000000
          Top = 91.701961430000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEmpresa: TfrxMemoView
          Left = 511.005382000000000000
          Top = 107.713225710000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxMemoView
          Align = baCenter
          Left = 178.394029585000000000
          Top = 165.236240000000000000
          Width = 661.417322830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllRedeLoja: TfrxMemoView
          Left = 511.005382000000000000
          Top = 125.724490000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REDELOJA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 7.559060000000000000
          Top = 142.622140000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDepPro: TfrxMemoView
          Left = 511.236550000000000000
          Top = 143.401670000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO.PRODUTO]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 24.566929130000000000
        Top = 362.834880000000000000
        Width = 1018.205382000000000000
        object rllTotal_: TfrxMemoView
          Left = 227.474025510000000000
          Top = 5.000000000000000000
          Width = 239.999990240000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOS VENDEDORES:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbSumPra: TfrxMemoView
          Left = 472.102350000000000000
          Top = 5.000000000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbSumVen: TfrxMemoView
          Left = 571.702350000000000000
          Top = 5.000000000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSumRep: TfrxMemoView
          Left = 671.302350000000000000
          Top = 5.000000000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PERVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object DMPLine2: TfrxLineView
          Align = baWidth
          Top = 0.283464570000000000
          Width = 1018.205382000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 794.598950000000000000
          Top = 5.000000000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDCLI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 874.866730000000000000
          Top = 5.000000000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDMOV">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
end
