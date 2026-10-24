object frmQckCtpTitContasAno: TfrmQckCtpTitContasAno
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 223
  Width = 262
  object frxQckCtpTitContasAnoM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40326.679900891210000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '    '
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
      ''
      'begin'
      'end.')
    Left = 48
    Top = 8
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRel
        DataSetName = 'frxRel'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 589.279619423579100000
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
        Top = 391.000000000000000000
        Width = 2208.000000000000000000
        DataSet = frxRel
        DataSetName = 'frxRel'
        RowCount = 0
        object rdbMes01: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA1"]')
          TruncOutboundText = False
        end
        object rdbMes02: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA2"]')
          TruncOutboundText = False
        end
        object rdbMes03: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA3"]')
          TruncOutboundText = False
        end
        object rdbMes04: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA4"]')
          TruncOutboundText = False
        end
        object rdbMes05: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA5"]')
          TruncOutboundText = False
        end
        object rdbMes06: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA6"]')
          TruncOutboundText = False
        end
        object rdbMes07: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA7"]')
          TruncOutboundText = False
        end
        object rdbMes08: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA8"]')
          TruncOutboundText = False
        end
        object rdbMes09: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA9"]')
          TruncOutboundText = False
        end
        object rdbMes10: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA10"]')
          TruncOutboundText = False
        end
        object rdbMes11: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA11"]')
          TruncOutboundText = False
        end
        object rdbMes12: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA12"]')
          TruncOutboundText = False
        end
        object rdbDescri: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRel."CONTA"]-[frxRel."DESCTA"]')
          TruncOutboundText = False
        end
        object rdbTotal: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRel."VALPAG">/QTDMES]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 629.000000000000000000
        Width = 2208.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 1084.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2198.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 187.000000000000000000
        Width = 2208.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object rllMes01: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES01')
          TruncOutboundText = False
        end
        object rllMes02: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES02')
          TruncOutboundText = False
        end
        object rllMes03: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES03')
          TruncOutboundText = False
        end
        object rllMes04: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES04')
          TruncOutboundText = False
        end
        object rllMes05: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES05')
          TruncOutboundText = False
        end
        object rllMes06: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES06')
          TruncOutboundText = False
        end
        object rllMes07: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES07')
          TruncOutboundText = False
        end
        object rllMes08: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES08')
          TruncOutboundText = False
        end
        object rllMes09: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES09')
          TruncOutboundText = False
        end
        object rllMes10: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES10')
          TruncOutboundText = False
        end
        object rllMes11: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES11')
          TruncOutboundText = False
        end
        object rllMes12: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MES12')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2198.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2198.400000000000000000
          Color = clBlack
        end
        object rllTotal: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 2208.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 1353.600000000000000000
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
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 1286.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 2083.200000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 2131.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 2016.000000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CONTA]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 85.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EVENTOS]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 102.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CONTAS]')
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CONTAF]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 561.000000000000000000
        Width = 2208.000000000000000000
        object rdbTot01: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot02: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot03: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot04: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot05: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot06: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot07: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot08: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot09: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot10: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot11: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTot12: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          TruncOutboundText = False
        end
        object rdbTotalGer: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2198.400000000000000000
          Color = clBlack
        end
        object DMPMemo18: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          TruncOutboundText = False
        end
      end
      object rlbCabLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 2208.000000000000000000
        Condition = 'frxRel."LINHA"'
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRel."LINHA"]-[frxRel."DESLIN"]')
          TruncOutboundText = False
        end
      end
      object rlbRodLinha: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 493.000000000000000000
        Width = 2208.000000000000000000
        object DMPMemo11: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
          TruncOutboundText = False
        end
        object rdbLin01: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin02: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin03: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin04: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin05: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin06: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin07: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin08: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin09: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin10: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin11: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbLin12: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTotalLin: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          TruncOutboundText = False
        end
      end
      object rlbCabGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 2208.000000000000000000
        Condition = 'frxRel."GRUPO"'
        object DMPMemo9: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRel."GRUPO"]-[frxRel."DESGRU"]')
          TruncOutboundText = False
        end
      end
      object rlbRodGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 459.000000000000000000
        Width = 2208.000000000000000000
        object DMPMemo10: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
          TruncOutboundText = False
        end
        object rdbGru01: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru02: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru03: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru04: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru05: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru06: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru07: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru08: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru09: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru10: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru11: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbGru12: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbTotalGru: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          TruncOutboundText = False
        end
      end
      object rlbCabEvento: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 2208.000000000000000000
        Condition = 'frxRel."CODEVE"'
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EVENTO: [frxRel."DESEVE"]')
          TruncOutboundText = False
        end
      end
      object rlbCabConta: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 2208.000000000000000000
        Condition = 'frxRel."CODCTA"'
        object DMPMemo21: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRel."DESCON"]')
          TruncOutboundText = False
        end
      end
      object rlbRodConta: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 2208.000000000000000000
        object DMPMemo23: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DO PLANO DE CONTAS:')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          TruncOutboundText = False
        end
      end
      object rlbRodEvento: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 2208.000000000000000000
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DO EVENTO:')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 1574.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1699.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1824.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Align = baLeft
          Left = 2064.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Align = baLeft
          Left = 1939.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Align = baLeft
          Left = 1948.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRel: TfrxDBDataset
    UserName = 'frxRel'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 136
    Top = 8
  end
  object frxQckCtpTitContasAnoJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40326.679403020830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '    '
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
      ''
      'begin'
      'end.')
    Left = 48
    Top = 64
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRel
        DataSetName = 'frxRel'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 362.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 430.866420000000000000
        Width = 1330.394560000000000000
        DataSet = frxRel
        DataSetName = 'frxRel'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1330.394560000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rdbMes01: TfrxMemoView
          Left = 253.748031500000000000
          Top = 1.889763780000010000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA1"]')
          ParentFont = False
        end
        object rdbMes02: TfrxMemoView
          Left = 330.344650000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA2"]')
          ParentFont = False
        end
        object rdbMes03: TfrxMemoView
          Left = 406.790290000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA3"]')
          ParentFont = False
        end
        object rdbMes04: TfrxMemoView
          Left = 483.235930000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA4"]')
          ParentFont = False
        end
        object rdbMes05: TfrxMemoView
          Left = 559.681569999999900000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA5"]')
          ParentFont = False
        end
        object rdbMes06: TfrxMemoView
          Left = 636.127210000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA6"]')
          ParentFont = False
        end
        object rdbMes07: TfrxMemoView
          Left = 713.352380000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA7"]')
          ParentFont = False
        end
        object rdbMes08: TfrxMemoView
          Left = 789.798020000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA8"]')
          ParentFont = False
        end
        object rdbMes09: TfrxMemoView
          Left = 866.023190000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA9"]')
          ParentFont = False
        end
        object rdbMes10: TfrxMemoView
          Left = 943.248360000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA10"]')
          ParentFont = False
        end
        object rdbMes11: TfrxMemoView
          Left = 1020.473530000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA11"]')
          ParentFont = False
        end
        object rdbMes12: TfrxMemoView
          Left = 1096.919170000000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPA12"]')
          ParentFont = False
        end
        object rdbDescri: TfrxMemoView
          Left = 26.456688030000000000
          Top = 2.000000000000000000
          Width = 226.242300000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel."CONTA"]-[frxRel."DESCTA"]')
          ParentFont = False
        end
        object rdbTotal: TfrxMemoView
          Align = baLeft
          Left = 1253.920742360000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel."VALPAG"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 1172.509721180000000000
          Top = 2.000000000000000000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 1178.330191180000000000
          Top = 2.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRel."VALPAG">/QTDMES]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 729.449290000000000000
        Width = 1330.394560000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 508.572850000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 558.009090000000000000
          Top = 17.000000000000000000
          Width = 763.539950000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line2: TfrxLineView
          Top = 8.500000000000000000
          Width = 1325.328570000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 215.433210000000000000
        Width = 1330.394560000000000000
        ReprintOnNewPage = True
        object Memo8: TfrxMemoView
          Align = baClient
          Width = 1330.394560000000000000
          Height = 20.763760000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13421772
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 3.881879999999996000
          Width = 248.919480000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
        end
        object rllMes01: TfrxMemoView
          Left = 253.899010000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES01')
          ParentFont = False
        end
        object rllMes02: TfrxMemoView
          Left = 330.344650000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES02')
          ParentFont = False
        end
        object rllMes03: TfrxMemoView
          Left = 406.790290000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES03')
          ParentFont = False
        end
        object rllMes04: TfrxMemoView
          Left = 483.235930000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES04')
          ParentFont = False
        end
        object rllMes05: TfrxMemoView
          Left = 559.681569999999900000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES05')
          ParentFont = False
        end
        object rllMes06: TfrxMemoView
          Left = 636.127210000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES06')
          ParentFont = False
        end
        object rllMes07: TfrxMemoView
          Left = 713.352380000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES07')
          ParentFont = False
        end
        object rllMes08: TfrxMemoView
          Left = 789.798020000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES08')
          ParentFont = False
        end
        object rllMes09: TfrxMemoView
          Left = 866.023190000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES09')
          ParentFont = False
        end
        object rllMes10: TfrxMemoView
          Left = 943.248360000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES10')
          ParentFont = False
        end
        object rllMes11: TfrxMemoView
          Left = 1020.473530000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES11')
          ParentFont = False
        end
        object rllMes12: TfrxMemoView
          Left = 1096.919170000000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MES12')
          ParentFont = False
        end
        object rllTotal: TfrxMemoView
          Align = baLeft
          Left = 1253.769561260000000000
          Top = 3.881879999999996000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 1172.509721180000000000
          Top = 3.881879999999996000
          Width = 5.669288899999999000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 1178.179010080000000000
          Top = 3.779529999999994000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#201'DIA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 18.897650000000000000
        Width = 1330.394560000000000000
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 134.783550000000000000
          Width = 1321.549040000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -11.602720000000000000
          Top = 17.000000000000000000
          Width = 1353.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 21.997280000000000000
          Top = 34.000000000000000000
          Width = 1286.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1206.349040000000000000
          Top = 48.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1254.349040000000000000
          Top = 65.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1139.149040000000000000
          Top = 65.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 117.997280000000000000
          Top = 51.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 11.338590000000000000
          Top = 81.149660000000000000
          Width = 653.858690000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CONTA]')
        end
        object Memo3: TfrxMemoView
          Left = 11.338590000000000000
          Top = 117.047310000000000000
          Width = 653.858690000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo4: TfrxMemoView
          Left = 668.976810000000000000
          Top = 81.149660000000000000
          Width = 653.858690000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[EVENTOS]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 668.976810000000000000
          Top = 99.047310000000000000
          Width = 653.858690000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CONTAS]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 11.338590000000000000
          Top = 99.047310000000000000
          Width = 653.858690000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[CONTAF]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 638.740570000000000000
        Width = 1330.394560000000000000
        object rdbTot01: TfrxMemoView
          Left = 253.899010000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot02: TfrxMemoView
          Left = 330.344650000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot03: TfrxMemoView
          Left = 406.790290000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot04: TfrxMemoView
          Left = 483.235930000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot05: TfrxMemoView
          Left = 559.681569999999900000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot06: TfrxMemoView
          Left = 636.127210000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot07: TfrxMemoView
          Left = 713.352380000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot08: TfrxMemoView
          Left = 789.798020000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot09: TfrxMemoView
          Left = 866.023190000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot10: TfrxMemoView
          Left = 943.370078740000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot11: TfrxMemoView
          Left = 1020.473530000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbTot12: TfrxMemoView
          Left = 1096.919170000000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 9.600000000000000000
          Top = 11.338582677165280000
          Width = 237.580890000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object rdbTotalGer: TfrxMemoView
          Align = baLeft
          Left = 1253.920742360000000000
          Top = 12.000000000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 1172.509721180000000000
          Top = 12.000000000000000000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 4.800000000000000000
          Top = 3.500000000000000000
          Width = 1321.549040000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 1178.330191180000000000
          Top = 12.094488190000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          ParentFont = False
        end
      end
      object rlbCabLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 306.141930000000000000
        Width = 1330.394560000000000000
        Condition = 'frxRel."LINHA"'
        object Memo10: TfrxMemoView
          Top = 1.889763780000010000
          Width = 248.919480000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel."LINHA"]-[frxRel."DESLIN"]')
          ParentFont = False
        end
      end
      object rlbRodLinha: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 555.590910000000000000
        Width = 1330.394560000000000000
        object rdbLin01: TfrxMemoView
          Left = 253.748031500000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin02: TfrxMemoView
          Left = 330.496062990000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin03: TfrxMemoView
          Left = 406.866141730000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin04: TfrxMemoView
          Left = 483.236220470000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin05: TfrxMemoView
          Left = 559.984251969999900000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin06: TfrxMemoView
          Left = 636.354330710000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin07: TfrxMemoView
          Left = 713.196850390000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin08: TfrxMemoView
          Left = 789.921259840000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin09: TfrxMemoView
          Left = 865.889763780000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin10: TfrxMemoView
          Left = 943.370078740000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin11: TfrxMemoView
          Left = 1020.472440940000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbLin12: TfrxMemoView
          Left = 1097.070866140000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.889763779999953000
          Width = 237.580890000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DA LINHA:')
          ParentFont = False
        end
        object rdbTotalLin: TfrxMemoView
          Align = baLeft
          Left = 1254.072438500000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 1172.661417320000000000
          Top = 1.889763780000000000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 1178.481887320000000000
          Top = 1.779530000000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          ParentFont = False
        end
      end
      object rlbCabGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 347.716760000000000000
        Width = 1330.394560000000000000
        Condition = 'frxRel."GRUPO"'
        object Memo11: TfrxMemoView
          Left = 15.118120000000000000
          Top = 1.889763780000010000
          Width = 237.580890000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel."GRUPO"]-[frxRel."DESGRU"]')
          ParentFont = False
        end
      end
      object rlbRodGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 514.016080000000000000
        Width = 1330.394560000000000000
        object rdbGru01: TfrxMemoView
          Left = 253.748031500000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru02: TfrxMemoView
          Left = 330.496290000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru03: TfrxMemoView
          Left = 406.941930000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru04: TfrxMemoView
          Left = 483.387570000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru05: TfrxMemoView
          Left = 559.833210000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru06: TfrxMemoView
          Left = 636.278850000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru07: TfrxMemoView
          Left = 713.196850390000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru08: TfrxMemoView
          Left = 789.921259840000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru09: TfrxMemoView
          Left = 865.889763780000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru10: TfrxMemoView
          Left = 943.400000000000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru11: TfrxMemoView
          Left = 1020.472440940000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          ParentFont = False
        end
        object rdbGru12: TfrxMemoView
          Left = 1097.070810000000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.889763779999953000
          Width = 226.242300000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DO GRUPO:')
          ParentFont = False
        end
        object rdbTotalGru: TfrxMemoView
          Align = baLeft
          Left = 1254.072382360000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 1172.661361180000000000
          Top = 1.889763780000000000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 1178.481831180000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          ParentFont = False
        end
      end
      object rlbCabEvento: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 260.787570000000000000
        Width = 1330.394560000000000000
        Condition = 'frxRel."CODEVE"'
        object Memo21: TfrxMemoView
          Top = 3.779530000000000000
          Width = 566.400000000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EVENTO: [frxRel."DESEVE"]')
          ParentFont = False
        end
      end
      object rlbRodEvento: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 597.165740000000000000
        Width = 1330.394560000000000000
        object Memo23: TfrxMemoView
          Left = 253.748031500000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 330.496062990000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 406.866141730000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 483.236220470000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 559.984251970000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 636.354330710000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 713.196850390000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 789.921259840000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 865.889763780000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 943.370078740000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 1020.472440940000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 1097.070866140000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.889763779999953000
          Width = 237.580890000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DO EVENTO:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 1254.803911180000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Align = baLeft
          Left = 1172.661417320000000000
          Top = 1.889763780000067000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 1179.213360000000000000
          Top = 1.779530000000022000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          ParentFont = False
        end
      end
      object rlbCabConta: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 389.291590000000000000
        Width = 1330.394560000000000000
        Condition = 'frxRel."CODCTA"'
        object Memo39: TfrxMemoView
          Left = 26.456710000000000000
          Width = 460.573160000000000000
          Height = 13.220470000000000000
          DataSet = frxRel
          DataSetName = 'frxRel'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel."DESCON"]')
          ParentFont = False
        end
      end
      object rlbRodConta: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 472.441250000000000000
        Width = 1330.394560000000000000
        object Memo40: TfrxMemoView
          Left = 253.748031500000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA1">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 330.496290000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA2">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 406.941930000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA3">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 483.387570000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA4">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 559.833210000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA5">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 636.278850000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA6">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 713.196850390000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA7">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 789.921259840000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA8">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 865.889763780000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA9">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 943.400000000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA10">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 1020.472440940000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA11">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 1097.070810000000000000
          Top = 1.889763780000067000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPA12">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.889763780000010000
          Width = 226.242300000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DO PLANO DE CONTAS:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Align = baLeft
          Left = 1254.072382360000000000
          Top = 1.889763780000000000
          Width = 75.590551180000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Align = baLeft
          Left = 1172.661361180000000000
          Top = 1.889763780000067000
          Width = 5.820470000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Align = baLeft
          Left = 1178.481831180000000000
          Top = 1.889763780000010000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel."VALPAG">,rlbDetalhes) /  QTDMES]')
          ParentFont = False
        end
      end
    end
  end
  object dtsRelatorio: TDataSource
    Left = 152
    Top = 128
  end
end
