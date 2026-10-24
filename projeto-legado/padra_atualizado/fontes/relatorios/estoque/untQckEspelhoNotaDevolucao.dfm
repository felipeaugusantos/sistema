object frmQckEspelhoNotaDevolucao: TfrmQckEspelhoNotaDevolucao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 205
  Width = 193
  object frxRelEspelhoNotaM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40081.724957314820000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotFreD: Double;'
      '  fltTotFreG: Double;'
      ''
      '  fltTotDesD: Double;'
      '  fltTotDesG: Double;'
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">); ' +
        '   '
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotFreD := 0;'
      '  fltTotDesD := 0;      '
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODCLI">);'
      '  If (rllParcelas.Text <> '#39#39') Then           '
      
        '    rllParcelas.Text := rllParcelas.Text + #13#10;              ' +
        '                                                 '
      'End;    '
      ''
      'procedure rlbResumoGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotFreD:= fltTotFreD + <frxRelatorio."TOTFRE"> ;'
      '  fltTotFreG:= fltTotFreG + <frxRelatorio."TOTFRE"> ;'
      '    '
      '  fltTotDesD:= fltTotDesD + <frxRelatorio."DESACE"> ;'
      '  fltTotDesG:= fltTotDesG + <frxRelatorio."DESACE"> ;'
      'end;'
      ''
      'BEGIN'
      'END.          ')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 48
    Top = 64
    Datasets = <
      item
        DataSet = frxGen
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
    object qckPaginaA: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rdbMarca: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdblocFis: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbChqVista: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbChqPre: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbOrdPag: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQICM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo92: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDescri: TfrxDMPMemoView
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbResumoGrupoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 119.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object rllDescri: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOC.FIS.')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.ICM')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.IPI')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.UNIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorioA: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 187.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaM.CVencimentos
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cliente:')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Entrada:')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pagamento:')
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#186' Doc:')
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Serie:')
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP:')
          TruncOutboundText = False
        end
        object DMPMemo93: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]-[frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object DMPMemo129: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          TruncOutboundText = False
        end
        object DMPMemo138: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo140: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
          TruncOutboundText = False
        end
        object rdbCndPag: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object rlbCFOP: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCFOPOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[fFormataCpfCgcInterna(<frxRelatorio."_C_G_C">,<frxRelatorio."CG' +
              'CCPF">)]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor:')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMFAN"]')
          TruncOutboundText = False
        end
        object rllEvento: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Ctr. Custo:')
          TruncOutboundText = False
        end
        object rlbEvento: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODEVE"]-[frxRelatorio."DESEVE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 561.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
          TruncOutboundText = False
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 357.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo26OnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltTotFreD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotD: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltTotDesD]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 476.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltTotFreG]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotG: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltTotDesG]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CVencimentos: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1507.200000000000000000
        Stretched = True
        object DMPMemo70: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vencimento/Valor:')
          TruncOutboundText = False
        end
        object rllParcelas: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 1478.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelEspelhoNotaJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40081.724790578700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);  ' +
        '  '
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '       '
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODCLI">);'
      '  If (rllParcelas.Text <> '#39#39') Then           '
      '    rllParcelas.Text := rllParcelas.Text + #13#10;      '
      'End;  '
      '               '
      '   '
      'BEGIN'
      'END.          ')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 48
    Top = 120
    Datasets = <
      item
        DataSet = frxGen
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
    object qckPaginaA: TfrxReportPage
      PaperWidth = 330.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 347.716760000000000000
        Width = 1171.654300000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo48: TfrxMemoView
          Left = 3.779530000000000000
          Width = 1165.606990000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object rdbDescri: TfrxMemoView
          Left = 5.373160000000000000
          Width = 477.732378660000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          WordWrap = False
        end
        object rdbMarca: TfrxMemoView
          Left = 486.047310000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          WordWrap = False
        end
        object rdblocFis: TfrxMemoView
          Left = 616.667780000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
        end
        object rdbChqVista: TfrxMemoView
          Left = 737.688250000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODFIS"]')
          WordWrap = False
        end
        object rdbChqPre: TfrxMemoView
          Left = 806.929190000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
        end
        object rdbOrdPag: TfrxMemoView
          Left = 887.811070000000000000
          Width = 71.433070870000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 772.308720000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
        end
        object Memo89: TfrxMemoView
          Left = 963.174830000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 1062.878540000000000000
          Width = 50.040940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQICM"]')
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 1118.739950000000000000
          Width = 49.889763780000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 22.645640000000000000
        Top = 147.401670000000000000
        Width = 1171.654300000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Top = 2.118120000000005000
          Width = 1165.984234880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllDescri: TfrxMemoView
          Left = 9.600000000000000000
          Top = 4.000000000000000000
          Width = 470.173470000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxMemoView
          Left = 486.047310000000000000
          Top = 4.000000000000000000
          Width = 124.800000000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxMemoView
          Left = 616.667780000000000000
          Top = 4.000000000000000000
          Width = 115.200000000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FIS.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 737.688250000000000000
          Top = 4.000000000000000000
          Width = 28.800000000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxMemoView
          Left = 806.929190000000000000
          Top = 4.000000000000000000
          Width = 75.061410000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 963.174830000000000000
          Top = 4.000000000000000000
          Width = 92.598425200000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 1062.878540000000000000
          Top = 4.000000000000000000
          Width = 50.040940000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.ICM')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 772.308720000000000000
          Top = 4.000000000000000000
          Width = 28.800000000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 1118.739950000000000000
          Top = 4.000000000000000000
          Width = 50.040940000000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo88: TfrxMemoView
          Left = 887.811070000000000000
          Top = 4.000000000000000000
          Width = 71.433063540000000000
          Height = 15.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 18.897650000000000000
        Width = 1171.654300000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 327.345425000001500000
          Top = 17.000000000000000000
          Width = 516.963449999997000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
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
        object rllNomeRelatorioA: TfrxMemoView
          Align = baCenter
          Left = 327.345425000000000000
          Top = 34.000000000000000000
          Width = 516.963450000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1042.516450000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Time: TfrxMemoView
          Left = 1090.516450000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 959.895980000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 327.345425000001500000
          Top = 51.000000000000000000
          Width = 516.963449999997000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 75.590551180000000000
        Top = 192.756030000000000000
        Width = 1171.654300000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaJ.CVencimentos
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxMemoView
          Left = 9.600000000000000000
          Width = 48.907050000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cliente:')
        end
        object Memo66: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.637806670000000000
          Width = 87.004700000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Entrada:')
        end
        object Memo67: TfrxMemoView
          Left = 9.600000000000000000
          Top = 35.275613330000000000
          Width = 113.763760000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pagamento:')
        end
        object Memo75: TfrxMemoView
          Left = 227.527520000000000000
          Top = 17.000000000000000000
          Width = 63.722820000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
        end
        object Memo76: TfrxMemoView
          Left = 422.475510000000000000
          Top = 17.000000000000000000
          Width = 48.302350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#186' Doc:')
        end
        object Memo80: TfrxMemoView
          Left = 696.188930000000000000
          Top = 17.000000000000000000
          Width = 40.743290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Serie:')
        end
        object Memo86: TfrxMemoView
          Left = 629.669291338582700000
          Top = 35.275613330000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP:')
        end
        object Memo93: TfrxMemoView
          Left = 64.327520000000000000
          Width = 534.425480000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]-[frxRelatorio."NOMCLI"] ')
        end
        object Memo101: TfrxMemoView
          Left = 98.645640000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
        end
        object Memo129: TfrxMemoView
          Left = 293.291280000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
        end
        object Memo138: TfrxMemoView
          Left = 472.818800000000000000
          Top = 17.000000000000000000
          Width = 215.508720000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
        end
        object Memo140: TfrxMemoView
          Left = 738.973160000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
        end
        object rdbCndPag: TfrxMemoView
          Left = 129.184230000000000000
          Top = 35.275613330000000000
          Width = 486.122820000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
        end
        object rlbCFOP: TfrxMemoView
          Left = 696.944881890000000000
          Top = 35.275613330000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo8: TfrxMemoView
          Left = 898.922510000000000000
          Width = 269.858380000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[fFormataCpfCgcInterna(<frxRelatorio."_C_G_C">,<frxRelatorio."CG' +
              'CCPF">)]')
        end
        object Memo9: TfrxMemoView
          Left = 9.600000000000000000
          Top = 52.913420000000000000
          Width = 68.409400000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor:')
        end
        object Memo15: TfrxMemoView
          Left = 81.922820000000000000
          Top = 52.913420000000000000
          Width = 486.122820000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
        end
        object Memo2: TfrxMemoView
          Left = 604.724800000000000000
          Width = 288.756030000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMFAN"] ')
        end
        object rllEvento: TfrxMemoView
          Left = 816.378480000000000000
          Top = 35.275613330000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Ctr. Custo:')
        end
        object rlbEvento: TfrxMemoView
          Left = 877.983920000000000000
          Top = 35.275613330000000000
          Width = 290.796970000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODEVE"]-[frxRelatorio."DESEVE"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 600.945270000000000000
        Width = 1171.654300000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 539.187260000000100000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 520.591960000000000000
          Top = 17.000000000000000000
          Width = 648.188930000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 62.322820000000000000
        Top = 389.291590000000000000
        Width = 1171.654300000000000000
        object Line1: TfrxLineView
          Left = 4.800000000000000000
          Top = 57.500000000000000000
          Width = 1165.303710000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 439.136920000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.031496062992120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.023622047244089000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotD: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.023622050000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 887.200000000000000000
          Top = 20.031496062992120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 20.031496060000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.023622050000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 62.322820000000000000
        Top = 514.016080000000000000
        Width = 1171.654300000000000000
        object Line2: TfrxLineView
          Left = 4.840940000000000000
          Top = 56.499999999999940000
          Width = 1165.303710000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 9.600000000000000000
          Top = 36.999999999999940000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 150.425170000000000000
          Top = 36.999999999999940000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 439.136920000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 298.311750000000000000
          Top = 36.999999999999940000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 439.136920000000000000
          Top = 36.999999999999940000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.031496062992120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 588.000000000000000000
          Top = 36.999999999999940000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 728.825170000000000000
          Top = 36.999999999999940000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.023622047244089000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotG: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.023622050000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 887.200000000000000000
          Top = 20.031496062992120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.023622050000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 20.031496062992120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object CVencimentos: TfrxChild
        FillType = ftBrush
        Height = 33.968460000000000000
        Top = 291.023810000000000000
        Width = 1171.654300000000000000
        Stretched = True
        object Memo70: TfrxMemoView
          Left = 9.600000000000000000
          Width = 114.066110000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vencimento/Valor:')
        end
        object rllParcelas: TfrxMemoView
          Left = 19.200000000000000000
          Top = 18.866110000000000000
          Width = 1153.360420000000000000
          Height = 15.102350000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
        end
      end
    end
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 16
    Top = 8
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 80
    Top = 8
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
    Left = 136
    Top = 8
  end
end
