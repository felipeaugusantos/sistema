object frmAnaliseMovRel: TfrmAnaliseMovRel
  Left = 0
  Top = 0
  ClientHeight = 276
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40961.780128935200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 40
    Top = 40
    Datasets = <
      item
        DataSet = frxAnaDet
        DataSetName = 'frxAnaDet'
      end
      item
        DataSet = frxAnaGer
        DataSetName = 'frxAnaGer'
      end
      item
        DataSet = frxCabec
        DataSetName = 'frxCabec'
      end
      item
        DataSet = frxIteAca
        DataSetName = 'frxIteAca'
      end
      item
        DataSet = frxIteFor
        DataSetName = 'frxIteFor'
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
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        DataSet = frxAnaDet
        DataSetName = 'frxAnaDet'
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
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxAnaDet."CODANA"]')
        end
        object Memo8: TfrxMemoView
          Left = 42.692950000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxAnaDet."DESANA"]')
        end
        object Memo9: TfrxMemoView
          Left = 193.519685040000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxAnaDet."OPEANA"]-[frxAnaDet."NOMOPE"]')
        end
        object Memo11: TfrxMemoView
          Left = 308.700990000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxAnaDet."DTAANA"] [frxAnaDet."HORANA"]')
        end
        object Memo12: TfrxMemoView
          Left = 414.236220470000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxAnaDet."LIMMIN"]')
        end
        object Memo13: TfrxMemoView
          Left = 495.874015750000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxAnaDet."LIMMAX"]')
        end
        object Memo14: TfrxMemoView
          Left = 576.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxAnaDet."RESULT"]')
        end
        object Memo15: TfrxMemoView
          Left = 655.370078740157400000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxAnaDet."SITUAC"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 29.322820000000000000
        ParentFont = False
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 650.542240000000000000
          Top = 7.385589999999980000
          Width = 67.568460000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CRQ]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 584.472480000000000000
          Top = 9.267470000000003000
          Width = 64.401670000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[NOMCRQ]')
          ParentFont = False
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
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 717.732056460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DI.')
        end
        object Memo2: TfrxMemoView
          Left = 42.708661420000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
        object Memo3: TfrxMemoView
          Left = 193.511811023622000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'OPERADOR DO LAN'#199'AMENTO')
        end
        object Memo4: TfrxMemoView
          Left = 414.071120000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'LIM. M'#205'NIMO')
        end
        object Memo5: TfrxMemoView
          Left = 496.000310000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'LIM. M'#193'XIMO')
        end
        object Memo6: TfrxMemoView
          Left = 575.929500000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'RESULTADO')
        end
        object Memo7: TfrxMemoView
          Left = 655.299630000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'SITUA'#199#195'O')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 164.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 129.373470000000000000
          Top = 28.000000000000000000
          Width = 459.363760000000000000
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
          Left = 553.020470000000000000
          Top = 51.000000000000000000
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
          Align = baCenter
          Left = 170.116760000000000000
          Top = 51.000000000000000000
          Width = 377.877180000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sequ'#234'ncial da An'#225'lise: [frxAnaGer."SEQANA"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 75.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxCabecfrxCabec: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.370130000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 63.252010000000000000
          Top = 79.590600000000000000
          Width = 483.779840000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabec."DESITE"] ')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 551.811380000000000000
          Top = 79.370130000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Volume (LT):  [frxIteAca."VOLUME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 105.826840000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OP-[frxCabec."CODORD"] [frxCabec."DTACAD"] ')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 200.315090000000000000
          Top = 105.826840000000000000
          Width = 385.512060000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabec."DESETI"] ')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 589.606680000000000000
          Top = 105.826840000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataSet = frmQckOrdProIndustrial.frxDispersao
          DataSetName = 'frxDispersao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              'LOTE [FormatDateTime('#39'DDMMYY'#39', <frxCabec."DTACAD">)]-[frxCabec."' +
              'CODORD"]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 128.504020000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxAnaGerfrxAnaGer: TfrxMemoView
          Left = 188.976500000000000000
          Top = 136.063080000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataSet = frxAnaGer
          DataSetName = 'frxAnaGer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAnaGer."SITUAC"]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Left = 86.929190000000000000
          Top = 2.779530000000001000
          Width = 548.182560000000000000
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
      end
    end
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
      'begin'
      ''
      'end.')
    Left = 128
    Top = 40
    Datasets = <
      item
        DataSetName = 'frxDBItens'
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
      PaperWidth = 337.819781824724200000
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
        Width = 1257.600000000000000000
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo2OnBeforePrint'
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea1: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCusRea1OnBeforePrint'
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac2: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea2: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac3: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea3: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac1: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1257.600000000000000000
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
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO-DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR1]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA1]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR2]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA2]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR3]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA3]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
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
          Left = 1180.800000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1046.400000000000000000
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
          Top = 76.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
      end
    end
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
    Left = 128
    Top = 112
  end
  object rldFiltro: TRLDraftFilter
    DisplayName = 'Impressora Matricial'
    Left = 40
    Top = 112
  end
  object frxIteFor: TfrxDBDataset
    UserName = 'frxIteFor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 232
    Top = 48
  end
  object frxIteAca: TfrxDBDataset
    UserName = 'frxIteAca'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 312
    Top = 48
  end
  object frxCabec: TfrxDBDataset
    UserName = 'frxCabec'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 232
    Top = 104
  end
  object frxAnaGer: TfrxDBDataset
    UserName = 'frxAnaGer'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 320
    Top = 120
  end
  object frxAnaDet: TfrxDBDataset
    UserName = 'frxAnaDet'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 400
    Top = 120
  end
end
