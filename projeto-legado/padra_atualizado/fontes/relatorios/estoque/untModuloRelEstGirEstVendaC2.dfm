object frmModuloRelEstGirEstVendaC2: TfrmModuloRelEstGirEstVendaC2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 139
  Width = 165
  object frxReportC2M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43438.415252106480000000
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
    Left = 63
    Top = 18
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
      PaperWidth = 335.279783465139800000
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
        Width = 1248.000000000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 48.000000000000000000
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
          Left = 57.600000000000000000
          Width = 432.000000000000000000
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
          Left = 499.200000000000000000
          Width = 48.000000000000000000
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
        object DMPMemo3: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRel."NVLGIR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fMediaDiaria]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalculaDuracaoOuDiasAbast]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDOS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(fSugestaoLitros > 0, fSugestaoLitros, '#39#39')]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDCD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."PREULT"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 918.000000000000000000
        Width = 1248.000000000000000000
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
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 489.600000000000000000
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
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'N.GIR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'MED.DIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABACOL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
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
          Left = 873.600000000000000000
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
        object DMPMemo31: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'SUG.LT/KG')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO CD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelEstComparativoPrecosFornec.frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'PR.ULT.COMP.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        OnAfterPrint = 'rlbCabecalhoOnAfterPrint'
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
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
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
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
          Left = 1190.400000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 212.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
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
          Align = baRight
          Left = 614.400000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
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
          Align = baRight
          Left = 614.400000000000000000
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
          Align = baRight
          Left = 614.400000000000000000
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
          Align = baRight
          Left = 614.400000000000000000
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
          Align = baRight
          Left = 614.400000000000000000
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
          Align = baRight
          Left = 614.400000000000000000
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
          Left = 220.800000000000000000
          Top = 51.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Align = baLeft
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ULTCOM]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Align = baRight
          Left = 614.400000000000000000
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
        Width = 1248.000000000000000000
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
        Width = 1248.000000000000000000
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
        Width = 1248.000000000000000000
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
        Width = 1248.000000000000000000
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
        Width = 1248.000000000000000000
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterFornecedor: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 765.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object GroupFooterLinha: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 799.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object GroupHeaderEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 340.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxDBRel."CODEMP"'
        object DMPMemo40: TfrxDMPMemoView
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
        Width = 1248.000000000000000000
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo41: TfrxDMPMemoView
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
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportC2J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43521.487708298610000000
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
    Left = 63
    Top = 74
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
        Height = 17.000000000000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 1046.929810000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 1047.307289210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBRel."CODIGO"]')
        end
        object Memo14: TfrxMemoView
          Left = 56.692950000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRel."DESITE"]')
        end
        object Memo15: TfrxMemoView
          Left = 340.291590000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRel."UNIDAD"]')
        end
        object Memo16: TfrxMemoView
          Left = 382.866420000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBRel."NVLGIR"]')
        end
        object Memo20: TfrxMemoView
          Left = 441.338900000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fMediaDiaria]')
        end
        object Memo21: TfrxMemoView
          Left = 527.929133860000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalculaDuracaoOuDiasAbast]')
        end
        object Memo24: TfrxMemoView
          Left = 614.976810000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDOS"]')
        end
        object Memo29: TfrxMemoView
          Left = 702.921770000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.0f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
        end
        object Memo31: TfrxMemoView
          Left = 789.850960000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(fSugestaoLitros > 0, fSugestaoLitros, '#39#39')]')
        end
        object Memo32: TfrxMemoView
          Left = 962.645669290000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."PREULT"]')
        end
        object Memo33: TfrxMemoView
          Left = 876.850960000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDCD"]')
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
        Top = 884.410020000000000000
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
        Top = 570.709030000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 1046.551166460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo17: TfrxMemoView
          Left = 340.157480314960600000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo18: TfrxMemoView
          Left = 382.866141732283500000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#205'V.GIRO')
        end
        object Memo22: TfrxMemoView
          Left = 441.448818897637800000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'M'#201'DIA DI'#193'RIA')
        end
        object Memo23: TfrxMemoView
          Left = 528.000000000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABACOL]')
        end
        object Memo25: TfrxMemoView
          Left = 614.929133858267600000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ESTOQUE')
        end
        object Memo26: TfrxMemoView
          Left = 702.992125980000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUGEST'#195'O')
        end
        object Memo27: TfrxMemoView
          Left = 962.780150000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PR.'#218'LT.COMP.')
        end
        object Memo28: TfrxMemoView
          Left = 789.921259840000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUGES. LT/KG')
        end
        object Memo34: TfrxMemoView
          Left = 876.850960000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO C.D.')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 221.047310000000000000
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
          Top = 217.212740000000000000
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
        object Memo30: TfrxMemoView
          Top = 195.315090000000000000
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
        object Memo36: TfrxMemoView
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
        Top = 355.275820000000000000
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
        Top = 411.968770000000000000
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
        Top = 464.882190000000000000
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
        Top = 517.795610000000000000
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
        Top = 755.906000000000000000
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
        Top = 687.874460000000000000
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
        Top = 653.858690000000000000
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
        Top = 721.890230000000000000
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
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBRel."CODEMP"'
        object Memo37: TfrxMemoView
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
        Top = 789.921770000000000000
        Width = 1046.929810000000000000
        object Line7: TfrxLineView
          Align = baWidth
          Top = 5.559060000000045000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          Left = 614.929133860000000000
          Top = 8.314960629999973000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 876.850960000000000000
          Top = 8.314960629999973000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 8.338589999999954000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL EMPRESA')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 30.236239999999960000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
