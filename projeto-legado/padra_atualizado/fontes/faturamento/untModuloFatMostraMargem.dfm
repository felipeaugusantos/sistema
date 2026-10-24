object frmModuloFatMostraMargem: TfrmModuloFatMostraMargem
  Left = 0
  Top = 0
  ClientHeight = 170
  ClientWidth = 199
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
  object frxImpF4: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44592.641775127320000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;'
      'end;'
      ''
      'begin'
      'end.')
    Left = 31
    Top = 14
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
      PaperWidth = 323.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 207.874150000000000000
        Width = 1145.197590000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllMarIde2: TfrxMemoView
          Align = baRight
          Left = 981.921999450000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARIDE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPreIde2: TfrxMemoView
          Align = baRight
          Left = 1028.032235670000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_PREIDE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMKPPRO2: TfrxMemoView
          Align = baRight
          Left = 936.189715990000000000
          Width = 45.732283460000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MKPPRO"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARLIQ_IMPULT2: TfrxMemoView
          Align = baRight
          Left = 875.339322290000000000
          Width = 60.850393700000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARLIQ_IMPULT"]')
          ParentFont = False
          WordWrap = False
        end
        object rllCusImp2: TfrxMemoView
          Align = baRight
          Left = 788.788141190000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_CUSIMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARLIQ_PREMED2: TfrxMemoView
          Align = baRight
          Left = 724.536172690000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARLIQ_PREMED"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPreMed2: TfrxMemoView
          Align = baRight
          Left = 648.567668750000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_PREMED"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARCAT2: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARCAT"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARPRA_PRECUS2: TfrxMemoView
          Align = baRight
          Left = 595.654282920000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARPRA_PRECUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARPRO_PRECUS2: TfrxMemoView
          Align = baRight
          Left = 542.740897090000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARPRO_PRECUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarMin2: TfrxMemoView
          Align = baRight
          Left = 476.977117560000000000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_MARMIN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllResult2: TfrxMemoView
          Align = baRight
          Left = 409.701527010000000000
          Width = 67.275590550000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_RESULT"]')
          ParentFont = False
          WordWrap = False
        end
        object lblPreCus2: TfrxMemoView
          Align = baRight
          Left = 353.008613620000000000
          Width = 56.692913390000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_PRECUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPerDes2: TfrxMemoView
          Align = baRight
          Left = 296.693652990000000000
          Width = 56.314960630000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_PERDES"]')
          ParentFont = False
          WordWrap = False
        end
        object rllUnitar2: TfrxMemoView
          Align = baRight
          Left = 232.441684490000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_UNITAR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllUniOri2: TfrxMemoView
          Align = baRight
          Left = 168.189715990000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_UNIORI"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte2: TfrxMemoView
          Align = baRight
          Left = 103.937747490000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."ITE_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllCodigo: TfrxMemoView
          Align = baWidth
          Width = 103.937747490000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"] - [frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 336.378170000000000000
        Width = 1145.197590000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.000000000000000000
          Width = 678.727520000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 687.613313620000000000
          Top = 5.000000000000000000
          Width = 455.584230000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 43.440940000000000000
        Top = 139.842610000000000000
        Width = 1145.197590000000000000
        ReprintOnNewPage = True
        object rllTitSin: TfrxMemoView
          Align = baWidth
          Top = 6.669291340000000000
          Width = 103.937879310000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMARPRA_PRECUS1: TfrxMemoView
          Align = baRight
          Left = 595.654387890000000000
          Top = 6.669291340000000000
          Width = 52.913373620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. Praticada')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPreMed1: TfrxMemoView
          Align = baRight
          Left = 648.567761510000000000
          Top = 6.669291340000000000
          Width = 75.968496610000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pre'#231'o M'#233'dio')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCusImp1: TfrxMemoView
          Align = baRight
          Left = 788.788221740000000000
          Top = 6.669291340000000000
          Width = 86.551181100000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pre'#231'o Ult+Imp')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarIde1: TfrxMemoView
          Align = baRight
          Left = 981.922045830000000000
          Top = 6.669291340000000000
          Width = 46.110216690000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. Ideal')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMARLIQ_IMPULT1: TfrxMemoView
          Align = baRight
          Left = 875.339402840000000000
          Top = 6.669291340000000000
          Width = 60.850376610000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '%Marg. Pr.Ult+Imp')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMARPRO_PRECUS1: TfrxMemoView
          Align = baRight
          Left = 542.740994740000000000
          Top = 6.669291340000000000
          Width = 52.913393150000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. Proposta')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarMin1: TfrxMemoView
          Align = baRight
          Left = 476.977215210000000000
          Top = 6.669291340000000000
          Width = 65.763779530000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. M'#237'nima')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllResult1: TfrxMemoView
          Align = baRight
          Left = 409.701624660000000000
          Top = 6.669291340000000000
          Width = 67.275590550000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Resultado $')
          ParentFont = False
          VAlign = vaCenter
        end
        object lblPreCus1: TfrxMemoView
          Align = baRight
          Left = 353.008723480000000000
          Top = 6.669291340000000000
          Width = 56.692901180000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '$ Custo $')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdIte1: TfrxMemoView
          Align = baRight
          Left = 103.937879310000000000
          Top = 6.669291340000000000
          Width = 64.251961180000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPreIde1: TfrxMemoView
          Align = baRight
          Left = 1028.032262520000000000
          Top = 6.669291340000000000
          Width = 71.811013860000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pre'#231'o Ideal')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMARLIQ_PREMED1: TfrxMemoView
          Align = baRight
          Left = 724.536258120000000000
          Top = 6.669291340000000000
          Width = 64.251963620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. Pr. M'#233'dio')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMKPPRO1: TfrxMemoView
          Align = baRight
          Left = 936.189779450000000000
          Top = 6.669291340000000000
          Width = 45.732266380000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Markup')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMARCAT1: TfrxMemoView
          Align = baRight
          Left = 1099.843276380000000000
          Top = 6.669291340000000000
          Width = 45.354313620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Marg. CAT17')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPerDes1: TfrxMemoView
          Align = baRight
          Left = 296.693762850000000000
          Top = 6.669291340000000000
          Width = 56.314960630000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '% Desconto')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUnitar1: TfrxMemoView
          Align = baRight
          Left = 232.441801670000000000
          Top = 6.669291340000000000
          Width = 64.251961180000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '$ Unit'#225'rio $')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUniOri1: TfrxMemoView
          Align = baRight
          Left = 168.189840490000000000
          Top = 6.669291340000000000
          Width = 64.251961180000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vr.Tabela $')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 59.472480000000000000
        Top = 18.897650000000000000
        Width = 1145.197590000000000000
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.000000000000000000
          Width = 1132.573160000000000000
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
          Left = 9.600000000000000000
          Top = 19.000000000000000000
          Width = 1135.370130000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'F4 - CUSTO / MARGEM DE PRODUTOS')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 969.373160000000000000
          Top = 19.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1055.773160000000000000
          Top = 38.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Top = 38.000000000000000000
          Width = 1059.250340000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 291.023810000000000000
        Width = 1145.197590000000000000
        object rllMarIde3: TfrxMemoView
          Align = baRight
          Left = 981.921999450000000000
          Top = 2.000000000000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARIDE'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllPreIde3: TfrxMemoView
          Align = baRight
          Left = 1028.032235670000000000
          Top = 2.000000000000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_PREIDE'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMKPPRO3: TfrxMemoView
          Align = baRight
          Left = 936.189715990000000000
          Top = 2.000000000000000000
          Width = 45.732283460000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MKPPRO'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARLIQ_IMPULT3: TfrxMemoView
          Align = baRight
          Left = 875.339322290000000000
          Top = 2.000000000000000000
          Width = 60.850393700000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARLIQ_IMPULT'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllCusImp3: TfrxMemoView
          Align = baRight
          Left = 788.788141190000000000
          Top = 2.000000000000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_CUSIMP'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARLIQ_PREMED3: TfrxMemoView
          Align = baRight
          Left = 724.536172690000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARLIQ_PREMED'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllPreMed3: TfrxMemoView
          Align = baRight
          Left = 648.567668750000000000
          Top = 2.000000000000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_PREMED'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARCAT3: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Top = 2.000000000000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARCAT'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARPRA_PRECUS3: TfrxMemoView
          Align = baRight
          Left = 595.654282920000000000
          Top = 2.000000000000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARPRA_PRECUS'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMARPRO_PRECUS3: TfrxMemoView
          Align = baRight
          Left = 542.740897090000000000
          Top = 2.000000000000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARPRO_PRECUS'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarMin3: TfrxMemoView
          Align = baRight
          Left = 476.977117560000000000
          Top = 2.000000000000000000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_MARMIN'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllResult3: TfrxMemoView
          Align = baRight
          Left = 409.701527010000000000
          Top = 2.000000000000000000
          Width = 67.275590550000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_RESULT'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object lblPreCus3: TfrxMemoView
          Align = baRight
          Left = 353.008613620000000000
          Top = 2.000000000000000000
          Width = 56.692913390000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_PRECUS'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllPerDes3: TfrxMemoView
          Align = baRight
          Left = 296.693652990000000000
          Top = 2.000000000000000000
          Width = 56.314960630000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_PERDES'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllUnitar3: TfrxMemoView
          Align = baRight
          Left = 232.441684490000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_UNITAR'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllUniOri3: TfrxMemoView
          Align = baRight
          Left = 168.189715990000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_UNIORI'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIte3: TfrxMemoView
          Align = baRight
          Left = 103.937747490000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[fTotalDouble('#39'ITE_QTDITE'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          Top = 2.000000000000000000
          Width = 103.937747490000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 40
    Top = 88
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 136
    Top = 88
  end
  object frxImpF4Tinta: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41659.630683402800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;      '
      'end;'
      ''
      'begin'
      'end.')
    Left = 135
    Top = 14
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
      PaperWidth = 323.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 298.582870000000000000
        Width = 1145.197590000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllCodigo: TfrxMemoView
          Align = baWidth
          Width = 397.984957400000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '          [frxRelatorio."Produto"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarIde2: TfrxMemoView
          Align = baRight
          Left = 876.095205830000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."Margem"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoMedio2: TfrxMemoView
          Align = baRight
          Left = 922.205442050000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."PrecoCustoMedio"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarImp2: TfrxMemoView
          Align = baRight
          Left = 796.347162130000000000
          Width = 79.748043700000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."DespesasOperacionais"]')
          ParentFont = False
          WordWrap = False
        end
        object rllCusImp2: TfrxMemoView
          Align = baRight
          Left = 709.795981030000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."ImpostosFederais"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarMed2: TfrxMemoView
          Align = baRight
          Left = 645.544012530000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."IcmsSaida"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPreMed2: TfrxMemoView
          Align = baRight
          Left = 569.575508590000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."OutrosValores"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoReal2: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."PrecoCustoReal"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 516.662122760000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."PrecoCusto"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Align = baRight
          Left = 463.748736930000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."PrecoVenda"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidade2: TfrxMemoView
          Align = baRight
          Left = 397.984957400000000000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Quantidade"]')
          ParentFont = False
          WordWrap = False
        end
        object rllUltimoPrecoCompraImpostos2: TfrxMemoView
          Align = baRight
          Left = 994.016465670000000000
          Width = 105.826793620000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."UltimoPrecoCompraImpostos"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 510.236550000000000000
        Width = 1145.197590000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.000000000000000000
          Width = 678.727520000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 687.613313620000000000
          Top = 5.000000000000000000
          Width = 455.584230000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 43.440940000000000000
        Top = 230.551330000000000000
        Width = 1145.197590000000000000
        ReprintOnNewPage = True
        object rllTitSin: TfrxMemoView
          Align = baWidth
          Top = 6.669291340000000000
          Width = 397.985047730000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 516.662220410000000000
          Top = 6.669291340000000000
          Width = 52.913373620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Custo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPreMed1: TfrxMemoView
          Align = baRight
          Left = 569.575594030000000000
          Top = 6.669291340000000000
          Width = 75.968496610000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Outros Valores')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCusImp1: TfrxMemoView
          Align = baRight
          Left = 709.796054260000000000
          Top = 6.669291340000000000
          Width = 86.551181100000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Impostos Federais')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarIde1: TfrxMemoView
          Align = baRight
          Left = 876.095261970000000000
          Top = 6.669291340000000000
          Width = 46.110216690000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Margem')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarImp1: TfrxMemoView
          Align = baRight
          Left = 796.347235360000000000
          Top = 6.669291340000000000
          Width = 79.748026610000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Despesas Operacionais')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Align = baRight
          Left = 463.748827260000000000
          Top = 6.669291340000000000
          Width = 52.913393150000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Venda')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQuantidade1: TfrxMemoView
          Align = baRight
          Left = 397.985047730000000000
          Top = 6.669291340000000000
          Width = 65.763779530000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPrecoCustoMedio1: TfrxMemoView
          Align = baRight
          Left = 922.205478660000000000
          Top = 6.669291340000000000
          Width = 71.811013860000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Custo M'#233'dio')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarMed1: TfrxMemoView
          Align = baRight
          Left = 645.544090640000000000
          Top = 6.669291340000000000
          Width = 64.251963620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Icms Sa'#237'da')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPrecoCustoReal1: TfrxMemoView
          Align = baRight
          Left = 1099.843276380000000000
          Top = 6.669291340000000000
          Width = 45.354313620000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Custo Real')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUltimoPrecoCompraImpostos1: TfrxMemoView
          Align = baRight
          Left = 994.016492520000000000
          Top = 6.669291340000000000
          Width = 105.826783860000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #218'ltimo Pre'#231'o de Compra + Impostos')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 59.472480000000000000
        Top = 18.897650000000000000
        Width = 1145.197590000000000000
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.000000000000000000
          Width = 1132.573160000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
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
          Left = 9.600000000000000000
          Top = 19.000000000000000000
          Width = 1135.370130000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'F4 - CUSTO / MARGEM DAS TINTAS')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 969.373160000000000000
          Top = 19.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1055.773160000000000000
          Top = 38.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 9.600000000000000000
          Top = 38.000000000000000000
          Width = 1047.911750000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 468.661720000000000000
        Width = 1145.197590000000000000
        object Memo20: TfrxMemoView
          Align = baWidth
          Width = 397.984991570000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoReal5: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoReal">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllUltimoPrecoCompraImpostos5: TfrxMemoView
          Align = baRight
          Left = 994.016487640000000000
          Width = 105.826771650000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UltimoPrecoCompraImpostos">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoMedio5: TfrxMemoView
          Align = baRight
          Left = 922.205464020000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoMedio">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Align = baRight
          Left = 876.095227800000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[GetMargem(SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."IcmsSaida">,rlbDetalhes), SUM(<frxRelatorio."Imposto' +
              'sFederais">,rlbDetalhes), SUM(<frxRelatorio."DespesasOperacionai' +
              's">,rlbDetalhes), SUM(<frxRelatorio."OutrosValores">,rlbDetalhes' +
              '), SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes), '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Align = baRight
          Left = 796.347196300000000000
          Width = 79.748031500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DespesasOperacionais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Align = baRight
          Left = 709.796015200000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ImpostosFederais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Align = baRight
          Left = 645.544046700000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."IcmsSaida">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Align = baRight
          Left = 569.575542760000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OutrosValores">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Align = baRight
          Left = 516.662156930000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Align = baRight
          Left = 463.748771100000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidade5: TfrxMemoView
          Align = baRight
          Left = 397.984991570000000000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Quantidade">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 139.842610000000000000
        Width = 1145.197590000000000000
        Condition = 'frxRelatorio."Descricao"'
        object Memo6: TfrxMemoView
          Align = baWidth
          Top = 1.000000000000000000
          Width = 1145.197590000000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o: [frxRelatorio."Descricao"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 340.157700000000000000
        Width = 1145.197590000000000000
        object rllPrecoCustoReal3: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoReal">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllUltimoPrecoCompraImpostos3: TfrxMemoView
          Align = baRight
          Left = 994.016487640000000000
          Width = 105.826771650000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UltimoPrecoCompraImpostos">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoMedio3: TfrxMemoView
          Align = baRight
          Left = 922.205464020000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoMedio">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 876.095227800000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[GetMargem(SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."IcmsSaida">,rlbDetalhes), SUM(<frxRelatorio."Imposto' +
              'sFederais">,rlbDetalhes), SUM(<frxRelatorio."DespesasOperacionai' +
              's">,rlbDetalhes), SUM(<frxRelatorio."OutrosValores">,rlbDetalhes' +
              '), SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes), '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 796.347196300000000000
          Width = 79.748031500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DespesasOperacionais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Align = baRight
          Left = 709.796015200000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ImpostosFederais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Align = baRight
          Left = 645.544046700000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."IcmsSaida">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 569.575542760000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OutrosValores">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Align = baRight
          Left = 516.662156930000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 463.748771103228400000
          Width = 52.913385826771650000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidade3: TfrxMemoView
          Align = baRight
          Left = 397.984991573228400000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Quantidade">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 326.174158343228400000
          Width = 71.810833230000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL TIPO:')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 1145.197590000000000000
        Condition = 'frxRelatorio."Tipo"'
        object Memo4: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1145.197590000000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '          Tipo: [frxRelatorio."Tipo"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 385.512060000000000000
        Width = 1145.197590000000000000
        object rllPrecoCustoReal4: TfrxMemoView
          Align = baRight
          Left = 1099.843259290000000000
          Top = 3.779530000000000000
          Width = 45.354330710000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoReal">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllUltimoPrecoCompraImpostos4: TfrxMemoView
          Align = baRight
          Left = 994.016487640000000000
          Top = 3.779530000000000000
          Width = 105.826771650000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UltimoPrecoCompraImpostos">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllPrecoCustoMedio4: TfrxMemoView
          Align = baRight
          Left = 922.205464020000000000
          Top = 3.779530000000000000
          Width = 71.811023620000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCustoMedio">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Align = baRight
          Left = 876.095227800000000000
          Top = 3.779530000000000000
          Width = 46.110236220000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[GetMargem(SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."IcmsSaida">,rlbDetalhes), SUM(<frxRelatorio."Imposto' +
              'sFederais">,rlbDetalhes), SUM(<frxRelatorio."DespesasOperacionai' +
              's">,rlbDetalhes), SUM(<frxRelatorio."OutrosValores">,rlbDetalhes' +
              '), SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes), '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Align = baRight
          Left = 796.347196300000000000
          Top = 3.779530000000000000
          Width = 79.748031500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DespesasOperacionais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 709.796015200000000000
          Top = 3.779530000000000000
          Width = 86.551181100000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ImpostosFederais">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 645.544046700000000000
          Top = 3.779530000000000000
          Width = 64.251968500000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."IcmsSaida">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Align = baRight
          Left = 569.575542760000000000
          Top = 3.779530000000000000
          Width = 75.968503940000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OutrosValores">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Align = baRight
          Left = 516.662156930000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoCusto">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Align = baRight
          Left = 463.748771100000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 17.007874020000000000
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
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PrecoVenda">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidade4: TfrxMemoView
          Align = baRight
          Left = 397.984991570000000000
          Top = 3.779530000000000000
          Width = 65.763779530000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Quantidade">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 397.984991570000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PRODUTO:')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
