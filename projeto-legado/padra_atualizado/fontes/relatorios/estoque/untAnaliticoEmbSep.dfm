object frmAnaliticoEmbSep: TfrmAnaliticoEmbSep
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 183
  Width = 192
  object frxAnaliticoPaisagemJEmbSep: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43514.625734212960000000
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
      'procedure mmoDtaDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      
        '  ChildMsgPed.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'N001"> +'
      
        '                                          <frxRelatorio."MEN002"' +
        '>) <> '#39#39');'
      ''
      
        '  ChildMsgExp.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'NEXP"> +'
      
        '                                          <frxRelatorio."MENEX2"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX3"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX4"' +
        '>) <> '#39#39');      '
      '      '
      '  ChildLote.Visible   := <frxRelatorio."NUMLOT"> <> '#39#39';'
      ''
      '  mmoQtdEmb.Visible   := <frxRelatorio."QTDEMB"> > 0;'
      ''
      '  ChildMetragem.Visible :=Trim(<frxRelatorio."APAREL">+  '
      
        '                               <frxRelatorio."BENEFI">) <> '#39#39';  ' +
        '    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllMetragem.Text := fDadosMetragem(<frxRelatorio."APAREL">,'
      '                                     <frxRelatorio."BENEFI">, '
      '                                     <frxRelatorio."QTDPEC">, '
      '                                     <frxRelatorio."COMPEC">, '
      '                                     <frxRelatorio."LARPEC">, '
      '                                     <frxRelatorio."ESPPEC">);'
      '                                       '
      
        '  childDocBaixa.Visible := <DOCBAI> And (Trim(<frxRelatorio."DOC' +
        'BAI">) <> '#39#39');                                                  ' +
        '     '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 81
    Top = 12
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
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 300.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 16.251968500000000000
        ParentFont = False
        Top = 498.897960000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxAnaliticoPaisagemJEmbSep.childDocBaixa
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 16.251968500000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmoCndPag: TfrxMemoView
          Left = 199.559055120000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Visible = False
          OnBeforePrint = 'mmoDtaDocOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CNDPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDesCnd: TfrxMemoView
          Left = 0.755905510000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Visible = False
          OnBeforePrint = 'mmoDtaDocOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCND"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDtaDoc: TfrxMemoView
          Left = 0.779530000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmoDtaDocOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 61.252010000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
          WordWrap = False
        end
        object rUniClientDataSete: TfrxMemoView
          Left = 156.740260000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 348.008040000000000000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbItem: TfrxMemoView
          Left = 258.149613620000000000
          Width = 86.929082600000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 496.425255430000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 735.118244490000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 793.480830000000000000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 846.614720000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDAEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 527.134200000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 1033.252630000000000000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
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
            '[<frxRelatorio."SALEXI"> + fQtdPendenteEntregaFuturaRel]')
          ParentFont = False
          WordWrap = False
        end
        object rdbUltCom: TfrxMemoView
          Left = 676.535870000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAULT"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbQtdUco: TfrxMemoView
          Left = 612.283860000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDUCO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 419.764070000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdEmb: TfrxMemoView
          Left = 969.000620000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDEMB"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoVrVenda: TfrxMemoView
          Left = 912.866730000000000000
          Top = 0.425169999999980000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
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
            '[frxRelatorio."VRVENDA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 820.158010000000000000
        Width = 1084.725110000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
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
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 359.584230000000000000
          Top = 17.000000000000000000
          Width = 638.664750000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401574803150000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 1084.725110000000000000
        ReprintOnNewPage = True
        object shpTitulo: TfrxShapeView
          Left = -0.559060000000000000
          Top = 1.000000000000000000
          Width = 1084.725110000000000000
          Height = 18.141732280000000000
          Fill.BackColor = clSilver
        end
        object Memo4: TfrxMemoView
          Top = 2.204700000000003000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 61.252010000000000000
          Top = 2.204700000000003000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 156.740260000000000000
          Top = 2.204700000000003000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 347.905511810000000000
          Top = 2.204700000000003000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 258.149613620000000000
          Top = 2.204700000000003000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 496.354670000000000000
          Top = 2.204700000000003000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 735.228820000000000000
          Top = 2.204700000000003000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 793.480830000000000000
          Top = 2.204700000000003000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGUE')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 846.614720000000000000
          Top = 2.204700000000003000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTREGAR')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 527.134200000000000000
          Top = 2.267716539999981000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
        end
        object rllTitSal: TfrxMemoView
          Left = 1033.252630000000000000
          Top = 2.267716539999981000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          WordWrap = False
        end
        object rllUltCom: TfrxMemoView
          Left = 676.535870000000000000
          Top = 2.267716539999981000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ULT.COM.')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdUco: TfrxMemoView
          Left = 612.283860000000000000
          Top = 2.267716539999981000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD.ULT.COM.')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 419.764070000000000000
          Top = 3.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 969.000620000000000000
          Top = 2.000000000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALAG.')
          ParentFont = False
          WordWrap = False
        end
        object lblVrVenda2: TfrxMemoView
          Left = 911.087200000000000000
          Top = 3.000000000000000000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          ParentFont = False
          WordWrap = False
        end
        object rllDesCnd: TfrxMemoView
          Left = 0.755905510000000000
          Top = 18.897650000000000000
          Width = 196.535433070000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O PAGAMENTO')
          ParentFont = False
          WordWrap = False
        end
        object rllCndPag: TfrxMemoView
          Left = 199.559055118110200000
          Top = 18.897650000000000000
          Width = 192.755905510000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONDI'#199#195'O PAGAMENTO')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 248.330860000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 1.814410000000043000
          Top = 17.000000000000000000
          Width = 1081.096290000000000000
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
          Left = 118.034880000000000000
          Top = 34.000000000000000000
          Width = 848.655350000000000000
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
          Left = 969.525110000000000000
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
          Left = 994.847930000000000000
          Top = 51.000000000000000000
          Width = 89.877180000000000000
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
          Left = 902.737230000000000000
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
          Left = 183.345115000000100000
          Top = 51.000000000000000000
          Width = 718.034880000000000000
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
          Align = baLeft
          Top = 85.000000000000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 546.050960000000000000
          Top = 85.220470000000000000
          Width = 538.658380000000000000
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
        object Memo22: TfrxMemoView
          Align = baLeft
          Top = 102.047244094488200000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 546.050960000000000000
          Top = 102.047244090000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Top = 119.055118110000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Top = 187.086614170000000000
          Width = 1084.724646220000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Top = 153.070866141732300000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENTRADA]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Top = 170.078740157480300000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAISAGEM]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 546.050960000000000000
          Top = 136.062992130000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTA ENTRADA]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 546.050960000000000000
          Top = 153.070866141732300000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ATENDIDOS]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 204.094488190000000000
          Width = 1084.724646220000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FALTA]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Top = 221.102362200000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOCFIS]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Top = 136.062992125984300000
          Width = 538.658380000000000000
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
        object Memo59: TfrxMemoView
          Left = 546.050960000000000000
          Top = 170.078740160000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 546.050960000000000000
          Top = 221.102362200000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIBUS]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 546.050960000000000000
          Top = 119.055118110000000000
          Width = 538.658380000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
        end
      end
      object grhQuebra: TfrxGroupHeader
        FillType = ftBrush
        Height = 52.913385826771660000
        Top = 374.173470000000000000
        Width = 1084.725110000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object shpQuebra: TfrxShapeView
          Top = 30.236240000000010000
          Width = 1084.725110000000000000
          Height = 18.141732280000000000
          Fill.BackColor = clSilver
        end
        object Memo36: TfrxMemoView
          Top = 31.440940000000010000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 61.252010000000000000
          Top = 31.440940000000010000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object rllCliente: TfrxMemoView
          Left = 156.740260000000000000
          Top = 31.440940000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 348.008040000000000000
          Top = 31.440940000000010000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
        end
        object rllItem: TfrxMemoView
          Left = 258.275820000000000000
          Top = 31.440940000000010000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 496.354670000000000000
          Top = 31.440940000000010000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 735.228820000000000000
          Top = 31.440940000000010000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 793.480830000000000000
          Top = 31.440940000000010000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGUE')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 846.614720000000000000
          Top = 31.440940000000010000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTREGAR')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 527.134200000000000000
          Top = 31.503956539999990000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 1033.252630000000000000
          Top = 31.503956539999990000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 676.535870000000000000
          Top = 31.503956539999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ULT.COM.')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 612.283860000000000000
          Top = 31.503956539999990000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD.ULT.COM.')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 419.764070000000000000
          Top = 31.236240000000010000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          WordWrap = False
        end
        object mmoNomFor: TfrxMemoView
          Left = 1.779530000000000000
          Top = 9.000000000000000000
          Width = 795.591027170000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR: [frxRelatorio."NOMFOR"]')
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 969.000620000000000000
          Top = 31.236240000000010000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALAG.')
          ParentFont = False
          WordWrap = False
        end
        object lblVrVenda1: TfrxMemoView
          Left = 910.866730000000000000
          Top = 31.236240000000010000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          ParentFont = False
          WordWrap = False
        end
        object rllDesCnd2: TfrxMemoView
          Left = 0.755905511811023600
          Top = 49.133890000000010000
          Width = 196.535433070000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O PAGAMENTO')
          ParentFont = False
          WordWrap = False
        end
        object rllCndPag2: TfrxMemoView
          Left = 199.559055118110200000
          Top = 49.133890000000010000
          Width = 192.755905510000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONDI'#199#195'O PAGAMENTO')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildMsgPed: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 653.858690000000000000
        Width = 1084.725110000000000000
        AllowSplit = True
        Child = frxAnaliticoPaisagemJEmbSep.ChildMsgExp
        PrintChildIfInvisible = True
        Stretched = True
        object Memo51: TfrxMemoView
          Left = 18.897650000000000000
          Width = 81.259857170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM:')
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 105.826840000000000000
          Width = 969.449407170000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"] [frxRelatorio."MEN002"]')
          WordWrap = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 691.653990000000000000
        Width = 1084.725110000000000000
        AllowSplit = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo53: TfrxMemoView
          Left = 18.897650000000000000
          Width = 81.259857170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS. EXPED:')
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 105.826840000000000000
          Width = 969.449407170000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."MENEXP"] [frxRelatorio."MENEX2"] [frxRelatorio."M' +
              'ENEX3"] [frxRelatorio."MENEX4"]')
          WordWrap = False
        end
      end
      object ChildLote: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 616.063390000000000000
        Width = 1084.725110000000000000
        AllowSplit = True
        Child = frxAnaliticoPaisagemJEmbSep.ChildMsgPed
        PrintChildIfInvisible = True
        Stretched = True
        object Memo13: TfrxMemoView
          Left = 343.937007874016000000
          Width = 35.905497170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE:')
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 383.512060000000000000
          Width = 410.078967170000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          WordWrap = False
        end
      end
      object ChildMetragem: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 574.488560000000000000
        Width = 1084.725110000000000000
        AllowSplit = True
        Child = frxAnaliticoPaisagemJEmbSep.ChildLote
        PrintChildIfInvisible = True
        Stretched = True
        object rllMetragem: TfrxMemoView
          Left = 0.779530000000000000
          Width = 1080.945580000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object childDocBaixa: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 536.693260000000000000
        Width = 1084.725110000000000000
        Child = frxAnaliticoPaisagemJEmbSep.ChildMetragem
        PrintChildIfInvisible = True
        Stretched = True
        object rllZebraDocBai: TfrxMemoView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 64.252010000000000000
          Width = 1012.914040000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Docs de Baixa:[frxRelatorio."DOCBAI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object grfTotais: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236240000000000000
        ParentFont = False
        Top = 729.449290000000000000
        Width = 1084.725110000000000000
        object Memo62: TfrxMemoView
          Left = 735.118244490000000000
          Top = 6.000000000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object Memo63: TfrxMemoView
          Left = 793.701300000000000000
          Top = 6.000000000000000000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDENT">,rlbDetalhes)]')
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 846.614720000000000000
          Top = 6.000000000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDAEN">,rlbDetalhes)]')
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 4.559060000000045000
          Width = 1084.725110000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo65: TfrxMemoView
          Left = 668.976810000000000000
          Top = 6.000000000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          WordWrap = False
        end
        object mmoTotVrVenda: TfrxMemoView
          Left = 912.646260000000000000
          Top = 5.779530000000023000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VRVENDA">,rlbDetalhes)]')
          WordWrap = False
        end
      end
      object grhQbrSep: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 449.764070000000000000
        Width = 1084.725110000000000000
        Condition = 'frxRelatorio."QBRSEP"'
        object Memo77: TfrxMemoView
          Left = 1.779530000000000000
          Top = 5.220469999999978000
          Width = 795.591027170000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."QBRSEP"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxAnaliticoMEmbSep: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40837.476839004600000000
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
      ''
      'procedure mmoDtaDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildMsgPed.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'N001"> +'
      
        '                                          <frxRelatorio."MEN002"' +
        '>) <> '#39#39');'
      ''
      
        '  ChildMsgExp.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'NEXP"> +'
      
        '                                          <frxRelatorio."MENEX2"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX3"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX4"' +
        '>) <> '#39#39');'
      ''
      '  ChildLote.Visible   := <frxRelatorio."NUMLOT"> <> '#39#39';'
      ''
      '  mmoQtdEmb.Visible   := <frxRelatorio."QTDEMB"> > 0;'
      ''
      '  ChildMetragem.Visible :=Trim(<frxRelatorio."APAREL">+  '
      
        '                               <frxRelatorio."BENEFI">) <> '#39#39';  ' +
        '    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllMetragem.Text := fDadosMetragem(<frxRelatorio."APAREL">,'
      '                                     <frxRelatorio."BENEFI">, '
      '                                     <frxRelatorio."QTDPEC">, '
      '                                     <frxRelatorio."COMPEC">, '
      '                                     <frxRelatorio."LARPEC">, '
      '                                     <frxRelatorio."ESPPEC">);'
      '                                       '
      
        '  childDocBaixa.Visible := <DOCBAI> And (Trim(<frxRelatorio."DOC' +
        'BAI">) <> '#39#39');                                                  ' +
        '     '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 81
    Top = 68
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
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
        Top = 527.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxAnaliticoMEmbSep.childDocBaixa
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintChildIfInvisible = True
        RowCount = 0
        object mmoDtaDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoDtaDocOnBeforePrint'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rUniClientDataSete: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbItem: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDAEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoQtdEmb: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDEMB"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoVrVenda: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VRVENDA"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 799.000000000000000000
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
          Left = 883.200000000000000000
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
        Height = 51.000000000000000000
        Top = 289.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGU')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTR.')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALA.')
          TruncOutboundText = False
        end
        object lblVrVenda2: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VEND')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
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
          Left = 384.000000000000000000
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
          Left = 1113.600000000000000000
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
          Left = 1161.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1017.600000000000000000
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
          Left = 393.600000000000000000
          Top = 51.000000000000000000
          Width = 470.400000000000000000
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
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ENTRADA]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 1238.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PRODUTO]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ENTRADA]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PAISAGEM]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FALTA]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTA ENTRADA]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ATENDIDOS]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LOCFIS]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MARCA]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CLIBUS]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[GRUCMP]')
          TruncOutboundText = False
        end
      end
      object grhQuebra: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 357.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 68.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object rllItem: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGU')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTR.')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object mmoNomFor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FORNECEDOR: [frxRelatorio."NOMFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALA.')
          TruncOutboundText = False
        end
        object lblVrVenda1: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VEND')
          TruncOutboundText = False
        end
      end
      object childMsgPed: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxAnaliticoMEmbSep.ChildMsgExp
        Stretched = True
        object DMPMemo44: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"] [frxRelatorio."MEN002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM :')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Stretched = True
        object DMPMemo46: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."MENEXP"] [frxRelatorio."MENEX2"] [frxRelatorio."M' +
              'ENEX3"] [frxRelatorio."MENEX4"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS.EXPE:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1248.000000000000000000
        Child = frxAnaliticoMEmbSep.childMsgPed
        PrintChildIfInvisible = True
        object DMPMemo8: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildMetragem: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxAnaliticoMEmbSep.ChildLote
        PrintChildIfInvisible = True
        Stretched = True
        object rllMetragem: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object childDocBaixa: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 561.000000000000000000
        Width = 1248.000000000000000000
        Child = frxAnaliticoMEmbSep.ChildMetragem
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo53: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 1132.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Docs de Baixa:[frxRelatorio."DOCBAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object grfTotais: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 731.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo55: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDENT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDAEN">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTotVrVenda: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VRVENDA">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object grhQbrSep: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxRelatorio."QBRSEP"'
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."QBRSEP"]')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxAnaliticoJEmbSep: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43514.647553680550000000
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
      'procedure mmoDtaDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildMsgPed.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'N001"> +'
      
        '                                          <frxRelatorio."MEN002"' +
        '>) <> '#39#39');'
      ''
      
        '  ChildMsgExp.Visible := <blnImpObs> And (Trim(<frxRelatorio."ME' +
        'NEXP"> +'
      
        '                                          <frxRelatorio."MENEX2"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX3"' +
        '> +'
      
        '                                          <frxRelatorio."MENEX4"' +
        '>) <> '#39#39');      '
      '  '
      '  ChildLote.Visible   := <frxRelatorio."NUMLOT"> <> '#39#39';'
      ''
      '  mmoQtdEmb.Visible   := <frxRelatorio."QTDEMB"> > 0;'
      ''
      '  ChildMetragem.Visible :=Trim(<frxRelatorio."APAREL">+  '
      
        '                               <frxRelatorio."BENEFI">) <> '#39#39';  ' +
        '    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllMetragem.Text := fDadosMetragem(<frxRelatorio."APAREL">,'
      '                                     <frxRelatorio."BENEFI">, '
      '                                     <frxRelatorio."QTDPEC">, '
      '                                     <frxRelatorio."COMPEC">, '
      '                                     <frxRelatorio."LARPEC">, '
      '                                     <frxRelatorio."ESPPEC">);'
      '                                       '
      
        '  childDocBaixa.Visible := <DOCBAI> And (Trim(<frxRelatorio."DOC' +
        'BAI">) <> '#39#39');                                                  ' +
        '     '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 81
    Top = 124
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 15.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.007874020000000000
        ParentFont = False
        Top = 506.457020000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxAnaliticoJEmbSep.childDocBaixa
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmoDtaDoc: TfrxMemoView
          Left = 0.779530000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmoDtaDocOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 60.913420000000000000
          Width = 92.598425196850390000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
          WordWrap = False
        end
        object rUniClientDataSete: TfrxMemoView
          Left = 155.960730000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 308.921247640000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbItem: TfrxMemoView
          Left = 238.244280000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 399.141705430000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 431.755844490000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 488.559370000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 544.252320000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDAEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 334.944845280000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdEmb: TfrxMemoView
          Left = 665.197280000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
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
            '[frxRelatorio."QTDEMB"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoVrVenda: TfrxMemoView
          Left = 609.724800000000000000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
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
            '[frxRelatorio."VRVENDA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 835.276130000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 2.000000000000000000
          Width = 374.400000000000000000
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
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 359.584230000000000000
          Top = 2.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.779530000000000000
        ParentFont = False
        Top = 336.378170000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = -1.000000000000000000
          Top = 1.000000000000000000
          Width = 721.890230000000000000
          Height = 18.141732280000000000
          Fill.BackColor = clSilver
        end
        object Memo4: TfrxMemoView
          Top = 3.204700000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 60.850393700000000000
          Top = 3.204700000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 155.897652440000000000
          Top = 3.204700000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 308.921247640000000000
          Top = 3.204700000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 238.385834090000000000
          Top = 3.204700000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 399.141712760000000000
          Top = 3.204700000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 431.755881100000000000
          Top = 3.204700000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 488.559023390000000000
          Top = 3.204700000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGU')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 544.251931890000000000
          Top = 3.204700000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTRE.')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 334.944881890000000000
          Top = 4.000000000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 665.197280000000000000
          Top = 3.000000000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALA')
          ParentFont = False
          WordWrap = False
        end
        object lblVrVenda2: TfrxMemoView
          Left = 607.945270000000000000
          Top = 3.000000000000000000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 256.008018030000000000
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
          Left = 595.804700000000000000
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
          Left = 643.804700000000000000
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
          Left = 511.445640000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
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
          Left = 181.455350000000000000
          Top = 51.000000000000000000
          Width = 355.200000000000000000
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
          Align = baLeft
          Top = 85.000000000000000000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 360.310700000000000000
          Top = 85.000000000000000000
          Width = 357.240940000000000000
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
        object Memo22: TfrxMemoView
          Align = baLeft
          Top = 102.047244094488200000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 360.310700000000000000
          Top = 102.047244090000000000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Top = 119.055118110000000000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 0.779530000000000000
          Top = 187.086614173228300000
          Width = 718.110236220000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Top = 153.070866141732300000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENTRADA]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 170.078740157480300000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PAISAGEM]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 360.310700000000000000
          Top = 136.062992125984300000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTA ENTRADA]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 360.310700000000000000
          Top = 153.070866141732300000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ATENDIDOS]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 0.779530000000000000
          Top = 204.094488188976400000
          Width = 718.110236220000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FALTA]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Top = 221.102362204724400000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOCFIS]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Align = baLeft
          Top = 136.062992125984300000
          Width = 357.240940000000000000
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
        object Memo52: TfrxMemoView
          Left = 360.310700000000000000
          Top = 170.078740160000000000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 360.310700000000000000
          Top = 221.102362204724400000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIBUS]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 360.310700000000000000
          Top = 119.055118110000000000
          Width = 357.240940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
        end
      end
      object grhQuebra: TfrxGroupHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 381.732530000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object Shape2: TfrxShapeView
          Top = 30.236240000000000000
          Width = 718.110700000000000000
          Height = 18.141732280000000000
          Fill.BackColor = clSilver
        end
        object Memo33: TfrxMemoView
          Top = 31.677180000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 60.850393700000000000
          Top = 31.677180000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object rllCliente: TfrxMemoView
          Left = 155.897652440000000000
          Top = 31.677180000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 308.771800000000000000
          Top = 31.677180000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
          WordWrap = False
        end
        object rllItem: TfrxMemoView
          Left = 238.385834090000000000
          Top = 31.677180000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 399.141712760000000000
          Top = 31.677180000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 431.755881100000000000
          Top = 31.677180000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VEN')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 488.559023390000000000
          Top = 31.677180000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTREGU')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 544.251931890000000000
          Top = 31.677180000000000000
          Width = 56.692910940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A ENTRE.')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 334.944881890000000000
          Top = 32.472480000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          WordWrap = False
        end
        object mmoNomFor: TfrxMemoView
          Left = 1.779530000000000000
          Top = 9.559060000000000000
          Width = 704.882307170000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR: [frxRelatorio."NOMFOR"]')
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 665.197280000000000000
          Top = 31.236240000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EMBALA')
          ParentFont = False
          WordWrap = False
        end
        object lblVrVenda1: TfrxMemoView
          Left = 607.724800000000000000
          Top = 31.236240000000000000
          Width = 52.031500940000000000
          Height = 14.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildMsgPed: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 665.197280000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxAnaliticoJEmbSep.ChildMsgExp
        PrintChildIfInvisible = True
        Stretched = True
        object Memo44: TfrxMemoView
          Left = 18.897650000000000000
          Width = 81.259857170000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENSAGEM:')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 105.826840000000000000
          Width = 610.394057170000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."MEN001"] [frxRelatorio."MEN002"]')
          WordWrap = False
        end
      end
      object ChildMsgExp: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 706.772110000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo46: TfrxMemoView
          Left = 18.897650000000000000
          Width = 81.259857170000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MENS. EXPED:')
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 105.826840000000000000
          Width = 610.394057170000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."MENEXP"] [frxRelatorio."MENEX2"] [frxRelatorio."M' +
              'ENEX3"] [frxRelatorio."MENEX4"]')
          WordWrap = False
        end
      end
      object ChildLote: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 627.401980000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxAnaliticoJEmbSep.ChildMsgPed
        PrintChildIfInvisible = True
        Stretched = True
        object Memo13: TfrxMemoView
          Left = 278.929133860000000000
          Width = 35.905497170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE:')
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 317.819110000000000000
          Width = 213.543407170000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          WordWrap = False
        end
      end
      object ChildMetragem: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 585.827150000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxAnaliticoJEmbSep.ChildLote
        PrintChildIfInvisible = True
        Stretched = True
        object rllMetragem: TfrxMemoView
          Left = 0.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object childDocBaixa: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 548.031850000000000000
        Width = 718.110700000000000000
        Child = frxAnaliticoJEmbSep.ChildMetragem
        PrintChildIfInvisible = True
        Stretched = True
        object rllZebraDocBai: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 60.850393700000000000
          Width = 650.079160000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Docs de Baixa:[frxRelatorio."DOCBAI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object grfTotais: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456710000000000000
        ParentFont = False
        Top = 748.346940000000000000
        Width = 718.110700000000000000
        object Memo55: TfrxMemoView
          Left = 431.755844490000000000
          Top = 2.000000000000000000
          Width = 52.913380940000000000
          Height = 18.897650000000000000
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
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 496.338900000000000000
          Top = 2.000000000000000000
          Width = 45.354320940000000000
          Height = 18.897650000000000000
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
            '[SUM(<frxRelatorio."QTDENT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 544.252320000000000000
          Top = 2.000000000000000000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
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
            '[SUM(<frxRelatorio."QTDAEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 0.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo58: TfrxMemoView
          Left = 365.834880000000000000
          Top = 2.000000000000000000
          Width = 60.472440940000000000
          Height = 18.897650000000000000
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
            'TOTAIS')
          ParentFont = False
          WordWrap = False
        end
        object mmoTotVrVenda: TfrxMemoView
          Left = 605.504330000000000000
          Top = 2.000000000000000000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
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
            '[SUM(<frxRelatorio."VRVENDA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object grhQbrSep: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 457.323130000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."QBRSEP"'
        object Memo77: TfrxMemoView
          Left = 1.779530000000000000
          Top = 5.220470000000000000
          Width = 795.591027170000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."QBRSEP"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
