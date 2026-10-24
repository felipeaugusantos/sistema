inherited frmTabelaPrecoInconsistencia: TfrmTabelaPrecoInconsistencia
  Caption = 'frmTabelaPrecoInconsistencia'
  PixelsPerInch = 96
  TextHeight = 14
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
  end
  object frxReport: TfrxReport
    Version = '4.15'
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
    Left = 256
    Top = 136
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
      object rlbDetalhes: TfrxMasterData
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 35.897650000000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 35.897650000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8 = (
            '[frxRelatorio."CODBAR"]')
        end
        object Memo5: TfrxMemoView
          Top = 15.897650000000000000
          Width = 1031.811690000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8 = (
            '[frxRelatorio."DESCRI"]')
        end
        object Memo2: TfrxMemoView
          Left = 117.165430000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8 = (
            '[frxRelatorio."CODFAB"]')
        end
        object Memo6: TfrxMemoView
          Left = 238.110390000000000000
          Width = 306.141930000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8 = (
            '[frxRelatorio."DESFAB"]')
        end
        object Memo16: TfrxMemoView
          Left = 548.811380000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF01"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 602.548424000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF02"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 656.285468000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF03"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 710.463452000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF04"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 763.420966000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF05"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 816.378480000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."DESF06"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 873.071430000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."PRECOM"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 991.236860000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxRelatorio."IPIENT"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 359.055350000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661410000000000000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baWidth
          Left = 353.322820000000000000
          Top = 5.661410000000000000
          Width = 693.606990000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 35.897650000000000000
        ParentFont = False
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 35.897650000000000000
          ShowHint = False
          Color = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Memo.UTF8 = (
            'C'#195#8220'DIGO DE BARRAS')
        end
        object Memo4: TfrxMemoView
          Top = 17.897650000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Memo.UTF8 = (
            'OCORR'#195#352'NCIA')
        end
        object Memo1: TfrxMemoView
          Left = 117.165430000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Memo.UTF8 = (
            'C'#195#8220'DIGO DE F'#195#129'BRICA')
        end
        object Memo3: TfrxMemoView
          Left = 238.110390000000000000
          Width = 306.141930000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Memo.UTF8 = (
            'DESCRI'#195#8225#195#402'O DO FABRICANTE')
        end
        object Memo7: TfrxMemoView
          Left = 548.811380000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 1')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 602.548424000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 2')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 656.285468000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 3')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 710.463452000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 4')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 763.420966000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 5')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 816.378480000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'DESC. 6')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 873.071430000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'PRE'#195#8225'O DE COMPRA')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 991.236860000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'IPI ENT.')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        Height = 119.000000000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
          Memo.UTF8 = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 354.255505000000000000
          Top = 34.000000000000000000
          Width = 338.418800000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            'RELAT'#195#8220'RIO DE INCONSIST'#195#352'NCIAS DA IMPORTA'#195#8225#195#402'O')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 928.403340000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 976.403340000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 881.839580000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[Date]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 109.606370000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
