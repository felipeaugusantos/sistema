object frmSeparacaoPedidoEstrutura: TfrmSeparacaoPedidoEstrutura
  Left = 0
  Top = 0
  ClientHeight = 218
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42285.673852048600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbDetalhes.Visible := ( <frxRelatorio."QTDDET"> > 0);        ' +
        '      '
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportUserFunction
    Left = 224
    Top = 80
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
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 377.953000000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 29.456710000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[frxRelatorio."QTDDET"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 94.488250000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SGUDET"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 137.401670000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FABDET"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 197.756030000000000000
          Width = 272.126160000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESDET"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 476.220780000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DEUDET"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 563.149970000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCDET"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 634.961040000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[frxRelatorio."SALDET"]')
          ParentFont = False
        end
        object Line13: TfrxLineView
          Left = 86.929190000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line14: TfrxLineView
          Left = 136.063080000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line15: TfrxLineView
          Left = 627.401980000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line16: TfrxLineView
          Left = 196.196970000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line17: TfrxLineView
          Left = 559.370440000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Shape3: TfrxShapeView
          Left = 7.559060000000000000
          Top = 1.000000000000000000
          Width = 11.338550940000000000
          Height = 11.338590000000000000
          Shape = skRoundRectangle
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
        Top = 793.701300000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 363.363760000000000000
          Top = 5.661410000000000000
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
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'P'#225'gina [<Page#>] de [<TotalPages>]')
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
        Height = 198.417440000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child1
        ReprintOnNewPage = True
        Stretched = True
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 1.220470000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          HAlign = haCenter
          Memo.UTF8W = (
            'ROMANEIO DE SEPARA'#199#195'O')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 22.677180000000000000
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
            
              'VENDA N'#186' [frxRelatorio."FDO_NUMDOC"] - [frxRelatorio."FDO_ESPDOC' +
              '"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 37.795300000000000000
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
            'PREVIS'#195'O DE ENTREGA [frxRelatorio."FGO_DTENTR"]')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 608.504330000000000000
          Top = 3.779530000000000000
          Width = 103.000000000000000000
          Height = 68.031540000000000000
          BarType = bcCodeEAN13
          CalcCheckSum = True
          DataField = 'BARDOC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Shape2: TfrxShapeView
          Left = 3.779530000000000000
          Top = 89.708720000000000000
          Width = 714.331170000000000000
          Height = 83.149660000000000000
          Shape = skRoundRectangle
        end
        object Memo5: TfrxMemoView
          Left = 15.118120000000000000
          Top = 93.881957500000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 15.118120000000000000
          Top = 108.055195000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 15.118120000000000000
          Top = 138.126082500000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 15.118120000000000000
          Top = 152.299320000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 113.385900000000000000
          Top = 93.881957500000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 113.385900000000000000
          Top = 108.055195000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."CLI_ENDERE"] [frxRelatorio."CLI_ENDNUM"]  [frxRel' +
              'atorio."CLI_ENDCOM"]  ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 113.385900000000000000
          Top = 138.732375000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FGO_CODTRA"] - [frxRelatorio."TRA_NOMTRA"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 113.385900000000000000
          Top = 152.905612500000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CLI_MARCA_"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 7.559060000000000000
          Top = 173.858380000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Observa'#231#245'es: [frxRelatorio."FGO_MEN001"] [frxRelatorio."FGO_MEN0' +
              '02"] [frxRelatorio."FGO_MEN003"] [frxRelatorio."FGO_MEN004"] [fr' +
              'xRelatorio."FGO_MEN005"]')
          ParentFont = False
        end
        object imgLogo: TfrxPictureView
          ShiftMode = smDontShift
          Left = 7.559060000000000000
          Top = 0.661410000000000000
          Width = 166.299320000000000000
          Height = 86.929190000000000000
          KeepAspectRatio = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo61: TfrxMemoView
          Left = 287.244280000000000000
          Top = 122.724490000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 336.378170000000000000
          Top = 122.724490000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CID_NOMCID"] - [frxRelatorio."CID_ESTADO"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 593.386210000000000000
          Top = 122.724490000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 631.181510000000000000
          Top = 122.724490000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCEP(<frxRelatorio."CLI_C_E_P_">)]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 15.118120000000000000
          Top = 122.724490000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 113.385900000000000000
          Top = 122.724490000000000000
          Width = 170.078850000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_BAIRRO"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."AUTOINCREM"'
        Stretched = True
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Left = 33.236240000000000000
          Top = 1.000000000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDGER"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 94.488250000000000000
          Top = 1.000000000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."SGUGER"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 137.401670000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."FABGER"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 197.756030000000000000
          Top = 1.000000000000000000
          Width = 272.126160000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."DESGER"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 476.220780000000000000
          Top = 1.000000000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."DEUGER"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 563.149970000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."LOCGER"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 634.961040000000000000
          Top = 1.000000000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALGER"]')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Left = 86.929190000000000000
          Top = 1.000000000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line9: TfrxLineView
          Left = 136.063080000000000000
          Top = 1.000000000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 627.401980000000000000
          Top = 1.000000000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line11: TfrxLineView
          Left = 196.196970000000000000
          Top = 1.000000000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line12: TfrxLineView
          Left = 559.370440000000000000
          Top = 1.000000000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line18: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line19: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Shape4: TfrxShapeView
          Left = 7.559060000000000000
          Top = 1.779530000000000000
          Width = 11.338550940000000000
          Height = 11.338590000000000000
          Shape = skRoundRectangle
        end
      end
      object grhSetor: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."SETOR_"'
        StartNewPage = True
        object Memo47: TfrxMemoView
          Left = 7.559060000000000000
          Width = 702.992580000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."SETOR_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 415.748300000000000000
        Width = 718.110700000000000000
        object Memo48: TfrxMemoView
          Left = 4.559060000000000000
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 1.000000000000000000
          Top = 5.000000000000000000
          Width = 15.118120000000000000
          Height = 15.118120000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000019
            000000190806000000C4E98563000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC61050000020C49444154484BD5D63F48D6411CC7F15F2918
            626A84085A418B221AD1D0A0120E1641BB9834884336A54E82A083E0D0A42188
            9151412604823535898352B838980D15E962840E25F6474BC3DE9FF30EEE397D
            FE2A411F78F13C77CFEFB9F37EBFEF7367F42F538F297CC13B0CA30087961AFC
            C10E7ED85779832C1C4A46A0417B90832A7CB07D57914ECEE20E5EE3A37D5F89
            6815BF91AB86CD2D689247A6953C47D08E4DB83BE12C207A651B97D5B0E987FA
            064C2B718AF112FEC0CE044E20BA693B3EA31B7DF8869F2843A25CC30AC2C1B5
            A2DB88C90DFC827FA126EA4036C21CC320FCEB9DF7B8807D730E0F114E368F4B
            705161A8CFBFC619451E92E614EE6203FE004FD085B05F54FA2D483BFA81EAB9
            840386B4AA0A649C2BF0CBF285F75EEE41CFE7C099861BF4B97D5D43038A70E0
            F4C24DE0CCE23CC6B18E266494123C863FF816B44DD462C9F6390FE0EF180973
            064308B707EDD0660F22F7E17FE6BC85CA3B6E54DB63D886FFC5655C4798467C
            857FADA81A5BB127BA3573D045DFE1CA561B673EE245ABF68BC2F70C31DF7D0A
            7DA02DFF384E62C6F6695F4B149D373A22C23B20DAEA2FC2E413B4D5179AD66E
            DC56AF3F2095546311E1441AB70DA624D551AE868D3BC83A4D2BB5E8F6E8D856
            15BA495440DA8ECC96AC0E95A596AEFAD7F275249722DDE896EB446D86394B14
            FDC3300937BB6899C99E47DA398A3AE8FEE9177C1AFF53A2E82F5A1ACFB8FAE5
            0C5E0000000049454E44AE426082}
          HightQuality = False
          Transparent = True
          TransparentColor = clWhite
        end
      end
      object grfSetor: TfrxGroupFooter
        FillType = ftBrush
        Height = 91.708720000000000000
        Top = 461.102660000000000000
        Width = 718.110700000000000000
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 91.708720000000000000
          Shape = skRoundRectangle
        end
        object Line21: TfrxLineView
          Left = 362.834880000000000000
          Top = 1.000000000000000000
          Height = 90.708720000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo49: TfrxMemoView
          Left = 18.897650000000000000
          Top = 2.779530000000000000
          Width = 336.378170000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Separador: _____________________________________________________' +
              '___________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 18.897650000000000000
          Top = 25.456710000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde. produtos:')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 18.897650000000000000
          Top = 48.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde. itens:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 18.897650000000000000
          Top = 70.811070000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pagto:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 374.173470000000000000
          Top = 2.779530000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Estoque em: [FormatDateTime('#39'dd/mm/yyyy'#39',<Date>)] [FormatDateTim' +
              'e('#39'hh:nn:ss'#39',fTime(False)) ]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo54: TfrxMemoView
          Left = 374.173470000000000000
          Top = 19.787415000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Conferente _____________________________________________________' +
              '___________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 374.173470000000000000
          Top = 36.795300000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Volumes ________________________________________________________' +
              '________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 374.173470000000000000
          Top = 53.803185000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Bruto __________________________________________________________' +
              '______________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 374.173470000000000000
          Top = 70.811070000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Liquido ________________________________________________________' +
              '________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 117.165430000000000000
          Top = 25.456710000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 117.165430000000000000
          Top = 48.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDDET">,rlbDetalhes,2)]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 117.165430000000000000
          Top = 70.811070000000000000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CND_DESCRI"]')
          ParentFont = False
        end
      end
      object rpsSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child2
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 94.488250000000000000
          Shape = skRoundRectangle
        end
        object Line20: TfrxLineView
          Left = 362.834880000000000000
          Top = 1.000000000000000000
          Height = 90.708720000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 18.897650000000000000
          Top = 2.779530000000000000
          Width = 336.378170000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Separador: _____________________________________________________' +
              '___________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 18.897650000000000000
          Top = 25.456710000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde. produtos:')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 18.897650000000000000
          Top = 48.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde. itens:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 18.897650000000000000
          Top = 70.811070000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pagto:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 374.173470000000000000
          Top = 2.779530000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Estoque em: [FormatDateTime('#39'dd/mm/yyyy'#39',<Date>)] [FormatDateTim' +
              'e('#39'hh:nn:ss'#39',fTime(False)) ]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo38: TfrxMemoView
          Left = 374.173470000000000000
          Top = 19.787415000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Conferente _____________________________________________________' +
              '___________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 374.173470000000000000
          Top = 36.795300000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Volumes ________________________________________________________' +
              '________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 374.173470000000000000
          Top = 53.803185000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Bruto __________________________________________________________' +
              '______________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 374.173470000000000000
          Top = 70.811070000000000000
          Width = 332.598640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Liquido ________________________________________________________' +
              '________________________')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 117.165430000000000000
          Top = 25.456710000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes,2)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 117.165430000000000000
          Top = 48.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDDET">,rlbDetalhes,2)]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 117.165430000000000000
          Top = 70.811070000000000000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CND_DESCRI"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.976375510000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Un.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 33.236240000000000000
          Top = 0.976375510000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 94.488250000000000000
          Top = 0.976375510000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Apr.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 137.401670000000000000
          Top = 0.976375510000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo Fab.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 197.756030000000000000
          Top = 0.976375510000000000
          Width = 272.126160000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 476.220780000000000000
          Top = 0.976375510000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emb.')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 563.149970000000000000
          Top = 0.976375510000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 634.961040000000000000
          Top = 0.976375510000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dispon'#237'vel')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 86.929190000000000000
          Top = 0.220470000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Left = 136.063080000000000000
          Top = 0.220470000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 627.401980000000000000
          Top = 0.220470000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 196.196970000000000000
          Top = 0.220470000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line7: TfrxLineView
          Left = 559.370440000000000000
          Top = 0.220470000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 729.449290000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo67: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 41.574830000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Observa'#231#245'es: [frxRelatorio."FGO_MENEXP"] [frxRelatorio."FGO_MENE' +
              'X2"] [frxRelatorio."FGO_MENEX3"] [frxRelatorio."FGO_MENEX4"]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 224
    Top = 136
  end
end
