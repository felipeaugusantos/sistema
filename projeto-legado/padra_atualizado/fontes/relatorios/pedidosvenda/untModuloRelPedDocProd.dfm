object frmModuloRelPedDocProd: TfrmModuloRelPedDocProd
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 130
  Width = 152
  object frxRelPedDocProdM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40836.631501736100000000
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
      '  '
      'end.')
    Left = 60
    Top = 69
    Datasets = <
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
    object qckPaginaAnalitico: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 1142.400000000000000000
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
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Align = baRight
          Left = 1334.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Align = baRight
          Left = 1420.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Align = baRight
          Left = 1324.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#27#67#65#15#27#77'
        end
        object rllCliente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[CLIENTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMarca: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MARCA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllRegiao: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REGIAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDigitador: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DIGITADOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFornecedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllGrupos: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLibCom: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[LibCom]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLibFin: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[LibFin]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCidade: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CIDADE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllRepresentante: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDepartamento: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllOrdem: TfrxDMPMemoView
          Top = 323.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMCMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPOENTREGA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 68.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPATE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FATURAMENTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPODEQTD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPODEOPERACAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAPREVIS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 238.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 238.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[OCORRE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ENTCD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[FASEOBRA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[GRUCMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[LISPED]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 289.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[LISADI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[ORIGEM]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Align = baRight
          Left = 768.000000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDCOR]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 459.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object rllMargem: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaMargemMarkup(<frxRelatorio."MAMKP4">, <frxRelatorio."T' +
              'OTCUS">))]%')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResult: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RESULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTQTD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrIpiTit: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 998.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo7: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MARCA_"]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 345.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 595.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 34.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object lnvReportSummary1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object rllMsg: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '** totais do anal'#237'tico e sint'#233'tico podem n'#227'o bater pois podem ex' +
              'istir baixas parciais de documentos.')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object lnvHeader1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object lnvHeader2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object rllTotalTit: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'SAL. EST.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrIpiTit: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'VR IPI')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrAntecTit: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVTotalTit: TfrxDMPMemoView
          Left = 998.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotCusTit: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR CUSTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResultTit: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'RESULT')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemTit: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PRODUTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERE.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'UN')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MARCA')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 510.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo18: TfrxDMPMemoView
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrIpiTot: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 998.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo35: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo36: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RESULT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo37: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes)' +
              ' , SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))]%')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelPedDocProdJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40840.671687824100000000
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
      '      '
      'end.')
    Left = 60
    Top = 13
    Datasets = <
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
    object qckPaginaAnalitico: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 300.000000000000000000
      PaperHeight = 292.400000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 349.504020000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 177.108720000000000000
          Top = 17.000000000000000000
          Width = 741.846260000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 177.638154095000000000
          Top = 34.000000000000000000
          Width = 740.787391810000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 923.263700000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
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
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 1009.663700000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
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
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 923.263700000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
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
        end
        object rllCliente: TfrxMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarca: TfrxMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          WordWrap = False
        end
        object rllRegiao: TfrxMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REGIAO]')
          ParentFont = False
          WordWrap = False
        end
        object rllEmpresa: TfrxMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllDigitador: TfrxMemoView
          Align = baLeft
          Top = 153.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DIGITADOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllVendedor: TfrxMemoView
          Align = baLeft
          Top = 85.039370080000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllFornecedor: TfrxMemoView
          Align = baLeft
          Top = 170.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllGrupos: TfrxMemoView
          Align = baLeft
          Top = 187.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          ParentFont = False
          WordWrap = False
        end
        object rllLibCom: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 102.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibCom]')
          ParentFont = False
          WordWrap = False
        end
        object rllLibFin: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 119.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibFin]')
          ParentFont = False
          WordWrap = False
        end
        object rllCidade: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 136.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
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
          WordWrap = False
        end
        object rllRepresentante: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 153.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          ParentFont = False
          WordWrap = False
        end
        object rllDepartamento: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 170.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          WordWrap = False
        end
        object rllOrdem: TfrxMemoView
          Top = 330.377994250000000000
          Width = 1096.063700000000000000
          Height = 15.118110240000000000
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
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 85.039370080000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMCMP]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 52.913420000000000000
          Width = 1096.063700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 187.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPOENTREGA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 68.000000000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPATE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 204.094620000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FATURAMENTO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Top = 221.102362200000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPODEQTD]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 204.094620000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPODEOPERACAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 221.102362200000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAPREVIS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 238.110236220000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Top = 256.118110240000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENTCD]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Top = 238.110236220000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OCORRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 256.228510000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FASEOBRA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Top = 273.346630000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 549.695239999999900000
          Top = 274.126160000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LISPED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Top = 291.023810000000000000
          Width = 546.368460000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LISADI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 550.252320000000000000
          Top = 292.023810000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ORIGEM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 551.811380000000000000
          Top = 309.921460000000000000
          Width = 546.368460000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDCOR]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.007874020000000000
        ParentFont = False
        Top = 472.441250000000000000
        Width = 1096.063700000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1096.063700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rllLitragem: TfrxMemoView
          Left = 359.055118110000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMargem: TfrxMemoView
          Left = 1028.031496060000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaMargemMarkup(<frxRelatorio."MAMKP4">, <frxRelatorio."T' +
              'OTCUS">))]%')
          ParentFont = False
          WordWrap = False
        end
        object rllResult: TfrxMemoView
          Left = 941.102350000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RESULT"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbMarca: TfrxMemoView
          Left = 400.630180000000000000
          Width = 136.063001890000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MARCA_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 540.472401890000000000
          Width = 71.811023620000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 616.062955510000000000
          Width = 71.811023620000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTQTD"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbVrIpiTit: TfrxMemoView
          Left = 691.653509130000000000
          Width = 71.811023620000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 767.244062760000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 854.173206380000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Width = 268.648360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 272.125984250000000000
          Width = 83.149616060000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 430.866420000000000000
        Width = 1096.063700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1096.063700000000000000
          Height = 18.897637800000000000
        end
        object rllTotalTit: TfrxMemoView
          Left = 540.472401890000000000
          Width = 71.811023620000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SAL. EST.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVrIpiTit: TfrxMemoView
          Left = 691.653509130000000000
          Width = 71.811023620000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR IPI')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVrAntecTit: TfrxMemoView
          Left = 616.062955510000000000
          Width = 71.811023620000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLitragemTit: TfrxMemoView
          Left = 272.125984250000000000
          Width = 83.149616060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVTotalTit: TfrxMemoView
          Left = 767.244062760000000000
          Width = 83.149606300000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR TOTAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotCusTit: TfrxMemoView
          Left = 854.173206380000000000
          Width = 83.149606300000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR CUSTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllResultTit: TfrxMemoView
          Left = 941.102350000000000000
          Width = 83.149606300000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'RESULT')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMargemTit: TfrxMemoView
          Left = 1028.031496060000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Width = 268.648360000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 359.055118110000000000
          Width = 37.795275590000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 400.630180000000000000
          Width = 136.063001890000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 51.023622047244100000
        Top = 551.811380000000000000
        Width = 1096.063700000000000000
        object Memo18: TfrxMemoView
          Left = -10.885390870000000000
          Width = 698.759370000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lnvReportSummary1: TfrxLineView
          Align = baWidth
          Top = 51.023622047244090000
          Width = 1096.063700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllVrIpiTot: TfrxMemoView
          Left = 691.653509130000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 767.244062760000000000
          Width = 83.149606300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 854.173206380000000000
          Width = 83.149606300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 941.102350000000000000
          Width = 83.149606300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RESULT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 1028.031496060000000000
          Width = 68.031496060000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes)' +
              ' , SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))]%')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = -10.885390870000000000
          Top = 17.007874020000030000
          Width = 698.759370000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 691.653509130000000000
          Top = 17.007874020000030000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = -10.885390870000000000
          Top = 34.015748030000050000
          Width = 698.759370000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 691.653509130000000000
          Top = 34.015748030000050000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object lnvGroupFooter2: TfrxLineView
        Align = baWidth
        Top = 1067.339272000000000000
        Width = 1096.063700000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795275590000000000
        ParentFont = False
        Top = 627.401980000000000000
        Width = 1096.063700000000000000
        object rllNomeForm: TfrxMemoView
          Top = 18.897637799999980000
          Width = 453.618800000000000000
          Height = 18.897637800000000000
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
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 449.405506000000000000
          Top = 18.897637799999980000
          Width = 646.374830000000000000
          Height = 18.897637800000000000
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
            ' [COUNT(rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMsg: TfrxMemoView
          Width = 1096.063700000000000000
          Height = 17.204700000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '** totais do anal'#237'tico e sint'#233'tico podem n'#227'o bater pois podem ex' +
              'istir baixas parciais de documentos.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
end
