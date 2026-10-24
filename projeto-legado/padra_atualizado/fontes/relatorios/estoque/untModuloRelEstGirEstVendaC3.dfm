object frmModuloRelEstGirEstVendaC3: TfrmModuloRelEstGirEstVendaC3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 147
  Width = 149
  object frxReportC3M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41057.665690463000000000
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
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbCabecalhoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCabecalho.Visible := False;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 61
    Top = 79
    Datasets = <
      item
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 411.479734252671600000
      PaperHeight = 283.368566991133800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1536.000000000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."CODIGO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."UNIDAD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDOS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."PRECUS"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."QTDUCO"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBRel."DTAULT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES001"]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES002"]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES003"]')
          TruncOutboundText = False
        end
        object mmoMes04: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES004"]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fMediaMensal]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 918.000000000000000000
        Width = 1536.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
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
          Left = 1171.200000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
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
          Width = 1516.800000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 272.000000000000000000
        Width = 1536.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO-DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'ESTOQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'SUGESTAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            'PR.CUSTO')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            'QT.ULT.COM.')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DT.ULT.COM.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            '[MES01]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            '[MES02]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            '[MES03]')
          TruncOutboundText = False
        end
        object mmoMes04Tit: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            '[MES04]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 17.000000000000000000
        Width = 1536.000000000000000000
        OnAfterPrint = 'rlbCabecalhoOnAfterPrint'
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 1200.000000000000000000
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
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 1200.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1411.200000000000000000
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
          Left = 1468.800000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 212.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object DMPMemo18: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[UNIDADE]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PRODUTO]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NIVELGIRO]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[MARCA]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 136.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DESCRICAO]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENCIA]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Align = baLeft
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 153.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABA]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Align = baLeft
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 170.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[LOCFIS]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 51.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Align = baLeft
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ULTCOM]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 187.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CODDEP]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 408.000000000000000000
        Width = 1536.000000000000000000
        Condition = 'frxDBRel."LINHA"'
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'LINHA: [frxDBRel."LINHA"].000 - [fRetNomeLinhaGrupo(<frxDBRel."L' +
              'INHA"> + '#39'000'#39')]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeaderGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 459.000000000000000000
        Width = 1536.000000000000000000
        Condition = 'frxDBRel."GRUPO"'
        object DMPMemo35: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'GRUPO: [FormatMaskText('#39'999.999;0;_'#39', <frxDBRel."GRUPO">)] - [fR' +
              'etNomeSoGrupo(<frxDBRel."GRUPO">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeaderFornecedor: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 527.000000000000000000
        Width = 1536.000000000000000000
        Condition = 'frxDBRel."CODFOR"'
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FORNECEDOR: [frxDBRel."CODFOR"] - [frxDBRel."NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeaderMarca: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 595.000000000000000000
        Width = 1536.000000000000000000
        Condition = 'frxDBRel."CODMAR"'
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA: [frxDBRel."CODMAR"] - [frxDBRel."DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooterMarca: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1536.000000000000000000
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterFornecedor: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 1536.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 765.000000000000000000
        Width = 1536.000000000000000000
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterLinha: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 799.000000000000000000
        Width = 1536.000000000000000000
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
      end
      object GroupHeaderEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 340.000000000000000000
        Width = 1536.000000000000000000
        Condition = 'frxDBRel."CODEMP"'
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'EMPRESA: [frxDBRel."CODEMP"] - [frxDBRel."NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupFooterEmpresa: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 833.000000000000000000
        Width = 1536.000000000000000000
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'TOTAL EMPRESA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportC3J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43438.422180636570000000
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
    Left = 65
    Top = 21
    Datasets = <
      item
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 13.220470000000000000
        ParentFont = False
        Top = 619.842920000000000000
        Width = 1046.929810000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 1047.307289210000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."CODIGO"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 45.354360000000000000
          Width = 230.551330000000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."DESITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 612.653990000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."UNIDAD"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 921.425790000000000000
          Width = 52.913366300000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDOS"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 983.370750000000000000
          Width = 56.692896300000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 479.220189290000000000
          Width = 64.251956300000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."QTDUCO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 279.598859690000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."REFERE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 338.850869690000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."CODFAB"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 411.000529690000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."PRECUS"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 548.063390000000000000
          Width = 60.472426300000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRel."DTAULT"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 644.520100000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES001"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 701.382345000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES002"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 758.465060000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES003"]')
          ParentFont = False
        end
        object mmoMes04: TfrxMemoView
          Left = 813.547775000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."MES004"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 870.426009690000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fMediaMensal]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 888.189550000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661410000000046000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 692.182870000000000000
          Top = 5.661410000000046000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 578.268090000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = -0.692950000000000000
          Width = 1046.551166460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 275.905690000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 612.519880310000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 921.378113860000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ESTOQUE')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 983.441105980000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUGEST'#195'O')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 479.354670000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QT.'#218'LT.COMP.')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 279.464750000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 338.716760000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D. FABRICA')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 410.866420000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRE'#199'O CUSTO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 548.197870710000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.'#218'LT.COMP.')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 644.520100000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES01]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 701.382345000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES02]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 758.465060000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES03]')
          ParentFont = False
        end
        object mmoMes04Tit: TfrxMemoView
          Left = 813.547775000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES04]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 870.426009690000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MED.')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 228.606370000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
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
          Left = 174.727830000000000000
          Top = 44.456710000000000000
          Width = 697.474150000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 928.403340000000000000
          Top = 18.102350000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 976.403340000000000000
          Top = 44.338590000000010000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 881.839580000000000000
          Top = 44.559060000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Top = 68.527559060000000000
          Width = 525.278850000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 219.212740000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Top = 87.425196850000000000
          Width = 527.622140000000000000
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
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 87.590600000000000000
          Width = 508.422140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 105.188976377952800000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 176.244094490000000000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 123.330708661417300000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NIVELGIRO]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 141.094488188976400000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Top = 158.102362204724400000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 123.315090000000000000
          Width = 508.422140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 105.173228350000000000
          Width = 508.422140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 140.944881890000000000
          Width = 508.422140000000000000
          Height = 16.629921260000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 158.110390000000000000
          Width = 508.422140000000000000
          Height = 17.007874020000000000
          ShowHint = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABA]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 176.228510000000000000
          Width = 508.422140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LOCFIS]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Top = 195.535560000000000000
          Width = 527.622140000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ULTCOM]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Align = baRight
          Left = 538.507670000000000000
          Top = 196.535560000000000000
          Width = 508.422140000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CODDEP]')
          ParentFont = False
        end
      end
      object GroupHeaderLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015755350000000000
        Top = 362.834880000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."LINHA"'
        ShowFooterIfDrillDown = True
        object rdbLinha: TfrxMemoView
          Top = 7.000000000000000000
          Width = 710.551640000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'LINHA: [frxDBRel."LINHA"].000 - [fRetNomeLinhaGrupo(<frxDBRel."L' +
              'INHA"> + '#39'000'#39')]')
          ParentFont = False
        end
      end
      object GroupHeaderGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 419.527830000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."GRUPO"'
        object rdbGrupo: TfrxMemoView
          Left = 44.220472440000000000
          Top = 6.000000000000000000
          Width = 665.197280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'GRUPO: [FormatMaskText('#39'999.999;0;_'#39', <frxDBRel."GRUPO">)] - [fR' +
              'etNomeSoGrupo(<frxDBRel."GRUPO">)]')
          ParentFont = False
        end
      end
      object GroupHeaderFornecedor: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 472.441250000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."CODFOR"'
        object rdbFornecedor: TfrxMemoView
          Left = 2.779530000000000000
          Top = 8.000000000000000000
          Width = 865.512370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR: [frxDBRel."CODFOR"] - [frxDBRel."NOMFOR"]')
          ParentFont = False
        end
      end
      object GroupHeaderMarca: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 525.354670000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."CODMAR"'
        object Memo35: TfrxMemoView
          Left = 2.779530000000000000
          Top = 7.000000000000000000
          Width = 865.512370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA: [frxDBRel."CODMAR"] - [frxDBRel."DESMAR"]')
          ParentFont = False
        end
      end
      object GroupFooterLinha: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 759.685530000000000000
        Width = 1046.929810000000000000
        object Line3: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterFornecedor: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 691.653990000000000000
        Width = 1046.929810000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterMarca: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 657.638220000000000000
        Width = 1046.929810000000000000
        object Line5: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 725.669760000000000000
        Width = 1046.929810000000000000
        object Line6: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeaderEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 309.921460000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."CODEMP"'
        object Memo40: TfrxMemoView
          Left = 2.779530000000000000
          Top = 8.000000000000000000
          Width = 865.512370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA: [frxDBRel."CODEMP"] - [frxDBRel."NOMEMP"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupFooterEmpresa: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 793.701300000000000000
        Width = 1046.929810000000000000
        object Line7: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          Left = 921.448818900000000000
          Top = 11.338589999999950000
          Width = 52.913385830000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">,rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 11.338589999999950000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL EMPRESA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 30.015769999999970000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
