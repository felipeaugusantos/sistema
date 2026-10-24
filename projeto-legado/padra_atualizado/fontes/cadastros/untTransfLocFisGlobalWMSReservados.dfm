object frmTransfLocFisGlobalWMSReservados: TfrmTransfLocFisGlobalWMSReservados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 223
  Width = 297
  object frxReport: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42515.607448101900000000
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
    Left = 32
    Top = 56
    Datasets = <
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.500000000000000000
      RightMargin = 5.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 38.133890000000000000
        Top = 283.464750000000000000
        Width = 752.126470000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 752.126470000000000000
          Height = 33.984230000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
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
        object Memo1: TfrxMemoView
          Left = 2.040940000000000000
          Width = 67.275510000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"] [frxRelatorio."HRACAD"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 117.711750000000000000
          Width = 27.061410000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODOPE"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 150.593630000000000000
          Width = 111.495980000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 265.130550000000000000
          Width = 284.900680000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"] - [frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 553.072170000000000000
          Width = 160.327520000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 717.220160000000000000
          Width = 32.881880000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 2.040940000000000000
          Top = 16.102350000000000000
          Width = 168.188930000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCATU"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 172.491280000000000000
          Top = 16.102350000000000000
          Width = 168.188930000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCNOV"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 345.280210000000000000
          Top = 16.102350000000000000
          Width = 62.362090000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVAL"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 413.683240000000000000
          Top = 16.102350000000000000
          Width = 96.377860000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
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
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 518.881570000000000000
          Top = 16.102350000000000000
          Width = 111.495980000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
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
            '[frxRelatorio."QTDTRA"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 68.711750000000000000
          Width = 45.959060000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = 'hh:nn:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."HRACAD"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 36.354360000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo5: TfrxMemoView
          Left = 638.401980000000000000
          Top = 16.015770000000000000
          Width = 111.495980000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
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
            '[frxRelatorio."QTDPED"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 381.732530000000000000
        Width = 752.126470000000000000
        object rllNomeForm: TfrxMemoView
          Left = 2.040940000000000000
          Top = 13.220470000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmTransfLocFisGlobalWMSReservados')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 394.902040000000000000
          Top = 13.220470000000000000
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
        object Line2: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 32.086580000000000000
        Top = 226.771800000000000000
        Width = 752.126470000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 752.126470000000000000
          Height = 32.086580000000000000
          Fill.BackColor = clScrollBar
        end
        object Memo9: TfrxMemoView
          Left = 2.040940000000000000
          Top = 1.881880000000000000
          Width = 112.629870000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 117.711750000000000000
          Top = 1.881880000000000000
          Width = 27.061410000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPE')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 150.593630000000000000
          Top = 1.881880000000000000
          Width = 111.495980000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 265.130550000000000000
          Top = 1.881880000000000000
          Width = 284.900680000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 553.072170000000000000
          Top = 1.881880000000000000
          Width = 160.327520000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 717.220160000000000000
          Top = 1.881880000000000000
          Width = 32.881880000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 2.040940000000000000
          Top = 16.984230000000000000
          Width = 168.188930000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZACAO ORIGEM')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 172.491280000000000000
          Top = 16.984230000000000000
          Width = 168.188930000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZACAO DESTINO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 345.280210000000000000
          Top = 16.984230000000000000
          Width = 62.362090000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALIDADE')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 413.683240000000000000
          Top = 16.984230000000000000
          Width = 96.377860000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD ESTOQUE')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 515.102040000000000000
          Top = 16.984230000000000000
          Width = 115.275510000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD TRANSFERIDO')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 634.622450000000000000
          Top = 16.897650000000000000
          Width = 115.275510000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD PEDIDO VENDA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 60.409400000000000000
        Top = 18.897650000000000000
        Width = 752.126470000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 11.263235000000000000
          Top = 5.661410000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 156.472790000000000000
          Top = 22.661410000000000000
          Width = 439.180890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REQUERIMENTO DE TRANSFER'#202'NCIA PARA PEDIDOS RESERVADOS')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 639.681570000000000000
          Top = 22.661410000000000000
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
          Left = 694.635930000000000000
          Top = 39.661410000000000000
          Width = 60.245640000000000000
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
          Left = 609.631230000000000000
          Top = 39.661410000000000000
          Width = 83.225170000000000000
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
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 139.842610000000000000
        Width = 752.126470000000000000
        Condition = 'frxRelatorio."NOMEXP"'
        StartNewPage = True
        object Memo2: TfrxMemoView
          Top = 3.000000000000000000
          Width = 751.370440000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SEPARADOR: [frxRelatorio."SEPEXP"] - [frxRelatorio."NOMEXP"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 185.196970000000000000
        Width = 752.126470000000000000
        Condition = 'frxRelatorio."PEDIDO"'
        object Memo3: TfrxMemoView
          Left = 11.338590000000000000
          Width = 751.370440000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'DOCUMENTO: [frxRelatorio."PEDIDO"] - [frxRelatorio."CODCLI"] - [' +
              'frxRelatorio."NOMCLI"]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 64
  end
end
