object frmModuloRelEstGirEstVendaR3: TfrmModuloRelEstGirEstVendaR3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 143
  Width = 156
  object frxReportR3J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43438.426160682870000000
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
      'procedure rlbCabecalhoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbCabecalho.Visible := False;                                ' +
        '                  '
      'end;'
      '    '
      'begin'
      ''
      'end.')
    Left = 63
    Top = 78
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 616.063390000000000000
        Width = 718.110700000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 718.488179210000000000
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
        object frxDBRelfrxDBRel: TfrxMemoView
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBRel."CODIGO"]')
        end
        object Memo13: TfrxMemoView
          Left = 55.354360000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBRel."DESITE"]')
        end
        object Memo15: TfrxMemoView
          Left = 469.779840000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
        end
        object Memo16: TfrxMemoView
          Left = 403.189240000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDBRel."SALDOS">]')
        end
        object Memo17: TfrxMemoView
          Left = 324.378170000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalculaDuracaoOuDiasAbast]')
        end
        object Memo18: TfrxMemoView
          Left = 232.110390000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fTotalMeses] ')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 207.433210000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SIGUNI"]')
        end
        object Memo34: TfrxMemoView
          Left = 551.149970000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDCD"]')
        end
        object Memo36: TfrxMemoView
          Left = 630.079160000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."DTAULT"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 937.323440000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 1.881880000000024000
          Width = 355.502350000000000000
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
          Left = 363.363760000000000000
          Top = 1.881880000000024000
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
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 15.118120000000000000
        ParentFont = False
        Top = 309.921460000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = -2.338590000000000000
          Width = 721.511586460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo22: TfrxMemoView
          Width = 204.094620000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo24: TfrxMemoView
          Left = 232.110390000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL VENDA')
        end
        object Memo25: TfrxMemoView
          Left = 324.378170000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABACOL]')
        end
        object Memo31: TfrxMemoView
          Left = 207.433210000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'UN')
        end
        object Memo14: TfrxMemoView
          Left = 403.189240000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'ESTOQUE')
        end
        object Memo26: TfrxMemoView
          Left = 469.779840000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'NECESSIDADE')
        end
        object Memo27: TfrxMemoView
          Left = 551.149970000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO CD')
        end
        object Memo33: TfrxMemoView
          Left = 630.079160000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            'ULT. COMPRA')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 228.606370000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
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
          Left = 114.255350000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
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
          Left = 599.584230000000000000
          Top = 34.000000000000000000
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
          Left = 647.584230000000000000
          Top = 51.000000000000000000
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
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 87.004700000000000000
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
          Align = baCenter
          Left = 164.447465000000000000
          Top = 51.000000000000000000
          Width = 389.215770000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 81.259842520000010000
          Width = 349.984230000000000000
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
          Left = 353.310700000000000000
          Top = 81.220470000000000000
          Width = 364.800000000000000000
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
          Top = 99.047310000000000000
          Width = 349.984230000000000000
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
          Top = 169.858380000000000000
          Width = 349.984230000000000000
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
          Top = 116.944960000000000000
          Width = 349.984230000000000000
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
          Top = 134.842610000000000000
          Width = 349.984230000000000000
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
          Top = 151.740260000000000000
          Width = 349.984230000000000000
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
          Left = 353.310700000000000000
          Top = 116.944960000000000000
          Width = 364.800000000000000000
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
        object Memo10: TfrxMemoView
          Align = baRight
          Left = 353.310700000000000000
          Top = 99.047310000000000000
          Width = 364.800000000000000000
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
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 353.310700000000000000
          Top = 134.842610000000000000
          Width = 364.800000000000000000
          Height = 16.629921259842520000
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
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 353.310700000000000000
          Top = 151.740260000000000000
          Width = 364.800000000000000000
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
          Left = 353.310700000000000000
          Top = 169.858380000000000000
          Width = 364.800000000000000000
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
        object Memo29: TfrxMemoView
          Left = 491.338900000000000000
          Top = 3.779530000000001000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Visible = False
          Memo.UTF8W = (
            '[OPCAO]')
        end
        object Memo30: TfrxMemoView
          Top = 189.976500000000000000
          Width = 349.984230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TABELA]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baRight
          Left = 353.310700000000000000
          Top = 189.976500000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ULTCOM]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baRight
          Left = 353.310700000000000000
          Top = 207.874150000000000000
          Width = 364.800000000000000000
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
      object rlbTotal: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236240000000000000
        ParentFont = False
        Top = 846.614720000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 26.897650000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Left = 243.448980000000000000
          Top = 6.779530000000023000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(fTotalMeses , rlbDetalhes)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Top = 6.779530000000023000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL GERAL')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 403.275590550000000000
          Top = 6.803149609999991000
          Width = 64.251968500000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 551.055118109999900000
          Top = 6.803149609999991000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">, rlbDetalhes)]')
          ParentFont = False
        end
      end
      object GroupHeaderLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015755350000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
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
            
              'LINHA: [frxDBRel."LINHA"].00 - [fRetNomeLinhaGrupo(<frxDBRel."LI' +
              'NHA"> + '#39'00'#39')]')
          ParentFont = False
        end
      end
      object GroupHeaderGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 457.323130000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBRel."GRUPO"'
        object rdbGrupo: TfrxMemoView
          Left = 17.763762440000000000
          Top = 6.000000000000000000
          Width = 665.197280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'GRUPO: [FormatMaskText('#39'99.99;0;_'#39', <frxDBRel."GRUPO">)] - [fRet' +
              'NomeSoGrupo(<frxDBRel."GRUPO">)]')
          ParentFont = False
        end
      end
      object GroupHeaderFornecedor: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 510.236550000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBRel."CODFOR"'
        object rdbFornecedor: TfrxMemoView
          Left = 2.779530000000000000
          Top = 8.000000000000056000
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
        Top = 563.149970000000000000
        Width = 718.110700000000000000
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
        Width = 718.110700000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterFornecedor: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 691.653990000000000000
        Width = 718.110700000000000000
        object Line5: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterMarca: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 657.638220000000000000
        Width = 718.110700000000000000
        object Line6: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 725.669760000000000000
        Width = 718.110700000000000000
        object Line7: TfrxLineView
          Align = baWidth
          Top = 7.559060000000045000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeaderEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 347.716760000000000000
        Width = 718.110700000000000000
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
        Height = 30.236220470000000000
        Top = 793.701300000000000000
        Width = 718.110700000000000000
        object Line8: TfrxLineView
          Align = baWidth
          Top = 3.779527559055168000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo38: TfrxMemoView
          Left = 243.401574800000000000
          Top = 6.803149609999991000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(fTotalMeses , rlbDetalhes)]')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 26.834645669291380000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo39: TfrxMemoView
          Left = 403.275590550000000000
          Top = 6.803149609999991000
          Width = 64.251968500000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 551.055118109999900000
          Top = 6.803149609999991000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Top = 6.803149609999991000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL EMPRESA')
          ParentFont = False
        end
      end
    end
  end
  object frxReportR3M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43006.574068854170000000
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
      'procedure rlbCabecalhoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbCabecalho.Visible := False;                                ' +
        '                  '
      'end;'
      '        '
      'begin'
      ''
      'end.')
    Left = 63
    Top = 22
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
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frmRelEstGirEstVenda.frxDBRel
        DataSetName = 'frxDBRel'
        RowCount = 0
        object frxRelatoriofrxRelatorio: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBRel."CODIGO"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBRel."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fTotalMeses] ')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalculaDuracaoOuDiasAbast]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDBRel."SALDOS">]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."ESTSUG"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBRel."SIGUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."SALDCD"]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRel."DTAULT"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 986.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
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
          Left = 892.800000000000000000
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
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo20: TfrxDMPMemoView
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO - DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VENDA TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[DIAABACOL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'ESTOQUE ATUAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'NECESSIDADE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO CD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'DT. ULT. COMPRA')
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
          Left = 374.400000000000000000
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
          Left = 1171.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
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
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 614.400000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 212.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[UNIDADE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
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
        object DMPMemo6: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NIVELGIRO]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
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
        object DMPMemo8: TfrxDMPMemoView
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
        object DMPMemo9: TfrxDMPMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENCIA]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Align = baLeft
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
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
        object DMPMemo12: TfrxDMPMemoView
          Align = baLeft
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
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
        object DMPMemo29: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          Memo.UTF8W = (
            '[OPCAO]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Align = baLeft
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ULTCOM]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
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
      object rlbTotal: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 901.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(fTotalMeses, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'TOTAL GERAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">, rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxDBRel."LINHA"'
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'LINHA: [frxDBRel."LINHA"].00 - [fRetNomeLinhaGrupo(<frxDBRel."LI' +
              'NHA"> + '#39'00'#39')]')
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
            
              'GRUPO: [FormatMaskText('#39'99.99;0;_'#39', <frxDBRel."GRUPO">)] - [fRet' +
              'NomeSoGrupo(<frxDBRel."GRUPO">)]')
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
        object DMPLine6: TfrxDMPLineView
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
        object DMPLine7: TfrxDMPLineView
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
        object DMPLine9: TfrxDMPLineView
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
        Top = 323.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxDBRel."CODEMP"'
        object DMPMemo39: TfrxDMPMemoView
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
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(fTotalMeses, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'TOTAL EMPRESA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDOS">, rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBRel."SALDCD">, rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
end
