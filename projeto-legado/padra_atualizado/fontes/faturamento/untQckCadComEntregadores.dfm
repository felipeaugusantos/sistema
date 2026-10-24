object frmQckCadComEntregadores: TfrmQckCadComEntregadores
  Left = 0
  Top = 0
  ClientHeight = 225
  ClientWidth = 230
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
  object frxQckEntrega80J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42391.370961168980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Begin          '
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxQckEntrega80MUserFunction
    Left = 48
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
    object Pagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 156.622118030000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object rllFaixa: TfrxMemoView
          Top = 122.606370000000000000
          Width = 1084.724409450000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object rllNomEmp: TfrxMemoView
          Top = 17.000000000000000000
          Width = 1084.724409450000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 851.905511811023600000
          Top = 51.015770000000010000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Top = 34.000000000000000000
          Width = 1084.724409450000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENTREGADORES')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 792.566929133858300000
          Top = 68.015770000000000000
          Width = 212.938590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 68.000000000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENTREGA:')
          ParentFont = False
        end
        object rllProEnt: TfrxMemoView
          Left = 92.220472440000000000
          Top = 68.000000000000000000
          Width = 690.897637795275600000
          Height = 17.000000000000000000
          DataField = 'ENG_PROENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PROENT"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Top = 85.023655000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENTREGADOR:')
          ParentFont = False
        end
        object rllEntregador: TfrxMemoView
          Left = 92.220472440000000000
          Top = 85.000000000000000000
          Width = 991.370078740157400000
          Height = 17.000000000000000000
          DataField = 'ENG_CODENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_CODENT"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Top = 124.346456690000000000
          Width = 88.440944880000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object rllTitCli: TfrxMemoView
          Left = 157.228346460000000000
          Top = 124.346456690000000000
          Width = 317.480314960629900000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 1007.622047244094000000
          Top = 68.015770000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 1065.070866141732000000
          Top = 51.015770000000010000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 1053.354330708661000000
          Top = 51.015770000000010000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
        end
        object Page: TfrxMemoView
          Left = 1030.677165354331000000
          Top = 51.015770000000010000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 89.196850393700790000
          Top = 124.346456690000000000
          Width = 67.653543310000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 102.047310000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VE'#205'CULO:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 92.220472440000000000
          Top = 102.047310000000000000
          Width = 991.370078740157400000
          Height = 17.000000000000000000
          DataField = 'ENG_PLAVEI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PLAVEI"]')
          ParentFont = False
        end
        object rllEndEnt: TfrxMemoView
          Top = 139.732283460000000000
          Width = 177.108720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENDERE'#199'O DE ENTREGA')
          ParentFont = False
        end
        object rllTitCan: TfrxMemoView
          Left = 1042.393700790000000000
          Top = 124.346456690000000000
          Width = 41.196850390000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Q.CAN.')
          ParentFont = False
        end
        object rllTitVlr: TfrxMemoView
          Left = 479.244094488189000000
          Top = 124.346456690000000000
          Width = 65.763779527559070000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 549.543307090000000000
          Top = 124.346456690000000000
          Width = 151.181102360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONDI'#199#195'O PAGTO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 705.259842520000000000
          Top = 124.346456690000000000
          Width = 132.283464566929100000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORMA  PAGTO.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 975.118740000000000000
          Top = 123.724490000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. VOL.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 907.087200000000000000
          Top = 123.724490000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PESO L'#205#141'Q.')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 839.055660000000000000
          Top = 123.724490000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRU.')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 35.905511810000000000
        ParentFont = False
        Top = 234.330860000000000000
        Width = 1084.725110000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllNumDoc: TfrxMemoView
          Width = 88.440944880000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."END_NUMDOC"]')
          WordWrap = False
        end
        object rllHist01: TfrxMemoView
          Left = 157.228346460000000000
          Width = 317.480314960000000000
          Height = 15.118110240000000000
          DataField = 'CLI_CODCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 89.196850393700790000
          Width = 67.653543310000000000
          Height = 15.118110240000000000
          DataField = 'ENG_DTACAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_DTACAD"]')
          WordWrap = False
        end
        object rlbEndEnt: TfrxMemoView
          Top = 15.874015750000010000
          Width = 523.086580000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"] - [frxRelatorio."CLI_CIDADE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdCan: TfrxMemoView
          Left = 1042.393700790000000000
          Width = 41.196850390000000000
          Height = 15.118110240000000000
          DataField = 'END_QTDNOT'
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
            '[frxRelatorio."END_QTDNOT"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVlrTot: TfrxMemoView
          Left = 479.244094488189000000
          Width = 65.763779527559070000
          Height = 15.118110240000000000
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
            '[frxRelatorio."VLRTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object linImpAss: TfrxLineView
          Left = 4.800000000000000000
          Top = 32.881889760000010000
          Width = 1078.299212598425000000
          Visible = False
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo12: TfrxMemoView
          Left = 549.543307090000000000
          Width = 151.181112130000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTitAss: TfrxMemoView
          Left = 526.488220709999900000
          Top = 15.874015750000010000
          Width = 77.102040000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEBIDO POR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 705.259842520000000000
          Width = 132.283464566929100000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FORPAG"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 975.118740000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VOLUME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 907.087200000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESLIQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 839.055660000000000000
          Width = 65.763740470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESBRU"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 51.000000000000000000
        ParentFont = False
        Top = 381.732530000000000000
        Width = 1084.725110000000000000
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1078.299212598425000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 41.500000000000000000
          Width = 1078.299212598425000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 1042.393700790000000000
          Top = 17.007874019999970000
          Width = 41.196850393700790000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbMaster)]')
        end
        object Memo2: TfrxMemoView
          Left = 880.629921259842600000
          Top = 17.007874019999970000
          Width = 159.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DE REGISTROS:')
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 332.598640000000000000
        Width = 1084.725110000000000000
        object Memo22: TfrxMemoView
          Left = 839.055660000000000000
          Top = 3.779527560000020000
          Width = 65.763740470000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESBRU">,rlbMaster)]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 1.284709850000000000
          Top = 3.779527560000020000
          Width = 836.258690000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 907.087200000000000000
          Top = 3.779527560000020000
          Width = 65.763740470000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESLIQ">,rlbMaster)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 975.118740000000000000
          Top = 3.779527560000020000
          Width = 65.763740470000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VOLUME">,rlbMaster)]')
          ParentFont = False
        end
        object linTotGer: TfrxLineView
          Left = 3.779530000000000000
          Width = 1078.223500000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 48
    Top = 152
  end
  object frxQckEntrega80M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42874.615486666670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '  '
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxQckEntrega80MUserFunction
    Left = 48
    Top = 8
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
    object Pagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomEmp: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENTREGADORES')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 85.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGA:')
          TruncOutboundText = False
        end
        object rllProEnt: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 85.000000000000000000
          Width = 1113.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PROENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PROENT"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGADOR:')
          TruncOutboundText = False
        end
        object rllEntregador: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 102.000000000000000000
          Width = 1382.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_CODENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_CODENT"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object rllTitCli: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 153.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object rllLinha: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 195.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1488.000000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1478.400000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1459.200000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#64#27#67#65#15#27#80'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VEICULO:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 119.000000000000000000
          Width = 1411.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PLAVEI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PLAVEI"]')
          TruncOutboundText = False
        end
        object rllEndEnt: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO DE ENTREGA')
          TruncOutboundText = False
        end
        object rllTitCan: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Top = 153.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Q.CAN.')
          TruncOutboundText = False
        end
        object rllTitVlr: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 153.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 153.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORMA PAGTO.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 153.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONDICAO PAGTO.')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Top = 153.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'QT.VOL.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'PESO LIQ.')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'PESO BRU.')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllNumDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."END_NUMDOC"]')
          TruncOutboundText = False
        end
        object rllHist01: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'CLI_CODCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_DTACAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_DTACAD"]')
          TruncOutboundText = False
        end
        object rlbEndEnt: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"] - [frxRelatorio."CLI_CIDADE"]')
          TruncOutboundText = False
        end
        object rllQtdCan: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'END_QTDNOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."END_QTDNOT"]')
          TruncOutboundText = False
        end
        object rllVlrTot: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRTOT"]')
          TruncOutboundText = False
        end
        object linImpAss: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1497.600000000000000000
          Visible = False
          Color = clBlack
        end
        object rllTitAss: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEBIDO POR')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."FORPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESBRU"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESLIQ"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VOLUME"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DE REGISTROS:')
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        object linTotGer: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1132.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESBRU">,rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PESLIQ">,rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VOLUME">,rlbMaster)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 160
    Top = 128
  end
  object frxQckEntrega40M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 44459.427791747690000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Begin          '
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxQckEntrega80MUserFunction
    Left = 160
    Top = 8
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
    object Pagina: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 166.422809185269100000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      EndlessHeight = True
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 17.000000000000000000
        Width = 364.800000000000000000
        object rllNomEmp: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENTREGADORES')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMITIDO EM [<Date>] [Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGA:')
          TruncOutboundText = False
        end
        object rllProEnt: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 85.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PROENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PROENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGADOR:')
          TruncOutboundText = False
        end
        object rllEntregador: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 119.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_CODENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_CODENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object rllLinha: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 280.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
        object TotalPages: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#64#27#67#65#18#27#80'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo8: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VEICULO:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 136.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PLAVEI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PLAVEI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CANHOTOS')
          TruncOutboundText = False
        end
        object rllTitVlr: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 204.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 204.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'F.PGTO.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONDICAO PAGTO.')
          TruncOutboundText = False
        end
        object rllEndEnt: TfrxDMPMemoView
          Top = 255.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO DE ENTREGA')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 221.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MENSAGEM 001')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 238.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MENSAGEM 002')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 357.000000000000000000
        Width = 364.800000000000000000
        Child = frxQckEntrega40M.Child1
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxDMPMemoView
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."END_NUMDOC"]')
          TruncOutboundText = False
        end
        object rlbEndEnt: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"] - [frxRelatorio."CLI_CIDADE"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_DTACAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."END_QTDNOT"]')
          TruncOutboundText = False
        end
        object rllVlrTot: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FORPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRTOT"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
          TruncOutboundText = False
        end
        object rllTitAss: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'RECEBIDO POR')
          TruncOutboundText = False
        end
        object linImpAss: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
        object DMPMemo22: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo23: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MEN002"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxColumnFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 578.000000000000000000
        Width = 364.800000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DE REGISTROS:')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SALTO]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 364.800000000000000000
      end
    end
  end
  object frxQckEntrega40J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 44459.405625949100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxQckEntrega80MUserFunction
    Left = 160
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
    object Pagina: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 245.000000000000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 284.295300000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 260.485220000000000000
        object rllNumPag: TfrxMemoView
          Left = 148.426840000000000000
          Top = 68.000000000000000000
          Width = 59.111750000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
        end
        object rllNomRel: TfrxMemoView
          Top = 34.000000000000000000
          Width = 260.409448820000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENTREGADORES')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Top = 102.000000000000000000
          Width = 257.985900000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITIDO EM [<Date>] [Time]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Top = 85.000000000000000000
          Width = 62.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGA:')
        end
        object rllProEnt: TfrxMemoView
          Left = 66.440940000000000000
          Top = 85.000000000000000000
          Width = 193.138590000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PROENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PROENT"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Top = 119.000000000000000000
          Width = 84.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTREGADOR:')
        end
        object rllEntregador: TfrxMemoView
          Left = 87.461410000000000000
          Top = 119.000000000000000000
          Width = 170.118120000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_CODENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_CODENT"]')
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 1.752845000000000000
          Top = 161.500000000000000000
          Width = 256.979530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo11: TfrxMemoView
          Top = 170.000000000000000000
          Width = 113.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
        end
        object Memo12: TfrxMemoView
          Top = 187.000000000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
        end
        object rllLinha: TfrxLineView
          Left = 1.752845000000000000
          Top = 280.515770000000000000
          Width = 256.979530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object TotalPages: TfrxMemoView
          Left = 239.600000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 229.636240000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
        end
        object Page: TfrxMemoView
          Left = 210.020470000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 117.379530000000000000
          Top = 170.000000000000000000
          Width = 68.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
        end
        object Memo8: TfrxMemoView
          Top = 136.000000000000000000
          Width = 56.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VEICULO:')
        end
        object Memo10: TfrxMemoView
          Left = 58.661410000000000000
          Top = 136.000000000000000000
          Width = 198.697650000000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PLAVEI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PLAVEI"]')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 188.779530000000000000
          Top = 170.000000000000000000
          Width = 67.020470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CANHOTOS')
        end
        object rllTitVlr: TfrxMemoView
          Left = 188.000000000000000000
          Top = 204.000000000000000000
          Width = 67.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
        end
        object Memo16: TfrxMemoView
          Left = 125.461410000000000000
          Top = 204.000000000000000000
          Width = 60.938590000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'F.PGTO.')
        end
        object Memo17: TfrxMemoView
          Top = 204.000000000000000000
          Width = 124.081880000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONDICAO PAGTO.')
        end
        object rllEndEnt: TfrxMemoView
          Top = 258.795300000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO DE ENTREGA')
        end
        object rllNomEmp: TfrxMemoView
          Top = 17.000000000000000000
          Width = 260.409448820000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Top = 241.889920000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MENSAGEM 002')
        end
        object Memo23: TfrxMemoView
          Top = 222.992270000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MENSAGEM 001')
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 151.960730000000000000
        ParentFont = False
        Top = 362.834880000000000000
        Width = 260.485220000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxMemoView
          Width = 113.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."END_NUMDOC"]')
        end
        object rlbEndEnt: TfrxMemoView
          Top = 93.795300000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"] - [frxRelatorio."CLI_CIDADE"]')
        end
        object Memo7: TfrxMemoView
          Left = 117.379530000000000000
          Width = 68.787401570000000000
          Height = 17.000000000000000000
          DataField = 'ENG_DTACAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_DTACAD"]')
        end
        object Memo15: TfrxMemoView
          Left = 188.598425200000000000
          Width = 66.897637800000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."END_QTDNOT"]')
        end
        object Memo18: TfrxMemoView
          Left = 125.480312520000000000
          Top = 36.000000000000000000
          Width = 60.850396140000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."FORPAG"]')
        end
        object rllVlrTot: TfrxMemoView
          Left = 189.000000000000000000
          Top = 36.000000000000000000
          Width = 66.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRTOT"]')
        end
        object Memo19: TfrxMemoView
          Top = 36.000000000000000000
          Width = 124.081880000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
        end
        object Memo21: TfrxMemoView
          Top = 17.000000000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
        end
        object rllTitAss: TfrxMemoView
          Top = 114.165430000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEBIDO POR')
          ParentFont = False
        end
        object linImpAss: TfrxLineView
          Left = 1.752845000000000000
          Top = 148.181200000000000000
          Width = 256.979530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo3: TfrxMemoView
          Top = 56.692950000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"]')
          Formats = <
            item
            end
            item
            end>
        end
        object Memo20: TfrxMemoView
          Top = 75.590600000000000000
          Width = 255.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MEN002"]')
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxColumnFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 85.000000000000000000
        ParentFont = False
        Top = 616.063390000000000000
        Width = 260.485220000000000000
        object Memo1: TfrxMemoView
          Left = 180.000000000000000000
          Top = 17.000000000000000000
          Width = 65.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbMaster)]')
        end
        object Memo2: TfrxMemoView
          Left = 6.000000000000000000
          Top = 17.000000000000000000
          Width = 166.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DE REGISTROS:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 6.000000000000000000
          Top = 50.000000000000000000
          Width = 240.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SALTO]')
        end
        object Line4: TfrxLineView
          Left = 1.738672990000000000
          Top = 8.500000000000000000
          Width = 257.007874020000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 1.738672990000030000
          Top = 42.500000000000000000
          Width = 257.007874020000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 536.693260000000000000
        Width = 260.485220000000000000
      end
    end
  end
  object frxQckEntrega80JRetrato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42391.370961168980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Begin          '
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxQckEntrega80MUserFunction
    Left = 80
    Top = 104
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
    object Pagina: TfrxReportPage
      PaperWidth = 203.200000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 156.622118030000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 730.205196000000000000
        object rllFaixa: TfrxMemoView
          Top = 122.606370000000000000
          Width = 729.448818897637800000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object rllNomEmp: TfrxMemoView
          Top = 17.000000000000000000
          Width = 729.448589450000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 496.905511810000000000
          Top = 51.015770000000010000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Top = 34.000000000000000000
          Width = 729.448589450000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENTREGADORES')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 437.566929129999900000
          Top = 68.015770000000000000
          Width = 212.938590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 68.000000000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENTREGA:')
          ParentFont = False
        end
        object rllProEnt: TfrxMemoView
          Left = 92.220472440000000000
          Top = 68.000000000000000000
          Width = 343.180877800000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PROENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PROENT"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Top = 85.023655000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENTREGADOR:')
          ParentFont = False
        end
        object rllEntregador: TfrxMemoView
          Left = 92.220472440000000000
          Top = 85.000000000000000000
          Width = 636.094258740000000000
          Height = 17.000000000000000000
          DataField = 'ENG_CODENT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_CODENT"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Top = 124.346456690000000000
          Width = 88.440944880000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object rllTitCli: TfrxMemoView
          Left = 157.228346460000000000
          Top = 124.346456690000000000
          Width = 204.094414960000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 652.622047240000000000
          Top = 68.015770000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 710.070866140000000000
          Top = 51.015770000000010000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 698.354330710000100000
          Top = 51.015770000000010000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
        end
        object Page: TfrxMemoView
          Left = 675.677165350000000000
          Top = 51.015770000000010000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 89.196850393700790000
          Top = 124.346456690000000000
          Width = 67.653543310000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 102.047310000000000000
          Width = 86.551181102362200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VE'#205'CULO:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 92.220472440000000000
          Top = 102.047310000000000000
          Width = 636.094258740000000000
          Height = 17.000000000000000000
          DataField = 'ENG_PLAVEI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENG_PLAVEI"]')
          ParentFont = False
        end
        object rllEndEnt: TfrxMemoView
          Top = 139.732283460000000000
          Width = 177.108720000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENDERE'#199'O DE ENTREGA')
          ParentFont = False
        end
        object rllTitCan: TfrxMemoView
          Left = 687.393700789999900000
          Top = 124.346456690000000000
          Width = 41.196850390000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Q.CAN.')
          ParentFont = False
        end
        object rllTitVlr: TfrxMemoView
          Left = 362.244094490000000000
          Top = 124.346456690000000000
          Width = 65.763779530000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 428.763777090000000000
          Top = 124.346456690000000000
          Width = 139.842512360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONDI'#199#195'O PAGTO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 569.259842520000000000
          Top = 124.346456690000000000
          Width = 117.165344570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORMA  PAGTO.')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 35.905511810000000000
        ParentFont = False
        Top = 234.330860000000000000
        Width = 730.205196000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllNumDoc: TfrxMemoView
          Width = 88.440944880000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."END_NUMDOC"]')
          WordWrap = False
        end
        object rllHist01: TfrxMemoView
          Left = 157.228346460000000000
          Width = 204.094414960000000000
          Height = 15.118110240000000000
          DataField = 'CLI_CODCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 89.196850393700790000
          Width = 67.653543310000000000
          Height = 15.118110240000000000
          DataField = 'ENG_DTACAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENG_DTACAD"]')
          WordWrap = False
        end
        object rlbEndEnt: TfrxMemoView
          Top = 15.874015750000010000
          Width = 523.086580000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"] - [frxRelatorio."CLI_CIDADE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdCan: TfrxMemoView
          Left = 687.393700789999900000
          Width = 41.196850390000000000
          Height = 15.118110240000000000
          DataField = 'END_QTDNOT'
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
            '[frxRelatorio."END_QTDNOT"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVlrTot: TfrxMemoView
          Left = 362.244094490000000000
          Width = 65.763779530000000000
          Height = 15.118110240000000000
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
            '[frxRelatorio."VLRTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object linImpAss: TfrxLineView
          Left = 4.800000000000000000
          Top = 32.881889760000010000
          Width = 721.889763779527400000
          Visible = False
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo12: TfrxMemoView
          Left = 432.543307090000000000
          Width = 136.062992130000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CONPAG">)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTitAss: TfrxMemoView
          Left = 526.488220709999900000
          Top = 15.874015750000010000
          Width = 77.102040000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEBIDO POR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 569.259842520000000000
          Width = 117.165344570000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FORPAG"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 51.000000000000000000
        ParentFont = False
        Top = 332.598640000000000000
        Width = 730.205196000000000000
        object Line3: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 721.889763779527400000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 41.500000000000000000
          Width = 721.889763779527400000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 685.393700789999900000
          Top = 17.007874019999970000
          Width = 41.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbMaster)]')
        end
        object Memo2: TfrxMemoView
          Left = 523.629921259999900000
          Top = 17.007874019999970000
          Width = 159.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DE REGISTROS:')
        end
      end
    end
  end
end
