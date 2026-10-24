object frmModuloFatExpedicaoItens: TfrmModuloFatExpedicaoItens
  Left = 0
  Top = 0
  ClientHeight = 125
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxEtiqItens: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39456.445405405100000000
    ReportOptions.LastChange = 40084.421803379600000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 24
    Top = 24
  end
  object frxEtiqCaixa: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41570.623836805560000000
    ReportOptions.LastChange = 41570.646857812500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 93
    Top = 23
    Datasets = <
      item
        DataSet = frxDBEtiqCaixa
        DataSetName = 'frxDBEtiqCaixa'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 150.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object pgHCaixa: TfrxPageHeader
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 18.897650000000000000
        Width = 529.134200000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 1.559060000000000000
          Top = 2.118120000000000000
          Width = 90.708661417322830000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186' Caixa:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 305.582870000000000000
          Top = 2.118120000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Total:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 93.826840000000000000
          Top = 2.118120000000000000
          Width = 209.316294210000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 417.337191050000000000
          Top = 2.118120000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[PESO]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 1.559060000000000000
          Top = 24.795300000000000000
          Width = 90.708661417322830000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedidos.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 93.826840000000000000
          Top = 24.795300000000000000
          Width = 433.116721050000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDOS]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object msdItens: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 177.637910000000000000
        Width = 529.134200000000000000
        DataSet = frxDBEtiqCaixa
        DataSetName = 'frxDBEtiqCaixa'
        RowCount = 0
        object Memo10: TfrxMemoView
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."quantidade"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 109.606370000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          DataField = 'descricao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."descricao"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 476.220780000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'unidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."unidade"]')
          ParentFont = False
        end
      end
      object colHItens: TfrxColumnHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 90.708720000000000000
        Width = 529.134200000000000000
        object Line1: TfrxLineView
          Left = 1.000000000000000000
          Top = 1.866110000000006000
          Width = 525.354670000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo3: TfrxMemoView
          Top = 5.645640000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 109.606370000000000000
          Top = 5.645640000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 1.000000000000000000
          Top = 24.543290000000000000
          Width = 525.354670000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 476.220780000000000000
          Top = 5.645640000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
      end
    end
  end
  object frxListCaixa: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42279.479302037020000000
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
      '              '
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 165
    Top = 23
    Datasets = <
      item
        DataSet = frxDBEtiqCaixa
        DataSetName = 'frxDBEtiqCaixa'
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
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxDBEtiqCaixa
        DataSetName = 'frxDBEtiqCaixa'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 5.559060000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."codfab"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 494.118430000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."unidade"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 68.031540000000000000
          Width = 404.409710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBEtiqCaixa."descricao"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 521.236550000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            '[frxDBEtiqCaixa."quantidade"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 589.606680000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            '[frxDBEtiqCaixa."peso"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 657.638220000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
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
            '[ <frxDBEtiqCaixa."peso"> * <frxDBEtiqCaixa."quantidade"> ]')
          ParentFont = False
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
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 363.363760000000000000
          Top = 5.661409999999989000
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
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Top = 5.661409999999989000
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
        Height = 137.944960000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        Stretched = True
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 1.220469999999999000
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
            'VOLUMES DO PEDIDO')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Left = 3.779530000000000000
          Top = 72.149660000000000000
          Width = 714.331170000000000000
          Height = 56.692950000000000000
          Shape = skRoundRectangle
        end
        object Memo5: TfrxMemoView
          Left = 15.118120000000000000
          Top = 93.220547500000000000
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
        object Memo7: TfrxMemoView
          Left = 15.118120000000000000
          Top = 110.228432500000000000
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
        object Memo9: TfrxMemoView
          Left = 113.385900000000000000
          Top = 93.826840000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 113.385900000000000000
          Top = 110.834725000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TRANSPORTADORA]')
          ParentFont = False
        end
        object imgLogo: TfrxPictureView
          ShiftMode = smDontShift
          Left = 7.559060000000000000
          Top = 0.661410000000000000
          Width = 132.283550000000000000
          Height = 64.252010000000000000
          KeepAspectRatio = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo6: TfrxMemoView
          Left = 15.118120000000000000
          Top = 74.929190000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 113.385900000000000000
          Top = 75.535482500000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDOS]')
          ParentFont = False
        end
      end
      object grhVolume: TfrxGroupHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBEtiqCaixa."SeqCx"'
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
            
              '[IIF(<frxDBEtiqCaixa."SeqCx">=11111,'#39'Itens expedidos fora de cai' +
              'xas'#39','#39'Volume: '#39'+IntToStr(<frxDBEtiqCaixa."SeqCx">))]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 5.559060000000000000
          Top = 22.236240000000010000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 68.031540000000000000
          Top = 22.236240000000010000
          Width = 400.630180000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 494.118430000000000000
          Top = 22.236240000000010000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Apr')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 521.236550000000000000
          Top = 22.236240000000010000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            'Quantidade')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 589.606680000000000000
          Top = 22.236240000000010000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            'Peso')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 657.638220000000000000
          Top = 22.236240000000010000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
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
            'Peso Total')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 279.685220000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 20.015769999999970000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo15: TfrxMemoView
          Left = 657.638220000000000000
          Top = 3.779346930000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
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
            
              '[SUM(<frxDBEtiqCaixa."peso"> * <frxDBEtiqCaixa."quantidade">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 521.236550000000000000
          Top = 3.779346930000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            '[SUM(<frxDBEtiqCaixa."quantidade">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 245.669450000000000000
          Top = 3.779346929999974000
          Width = 226.771800000000000000
          Height = 11.338590000000000000
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
            'Quantidade de Itens: [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 275.905690000000000000
          Top = 3.779530000000022000
          Width = 442.205010000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object rpsSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        object Memo18: TfrxMemoView
          Left = 603.213059760000000000
          Top = 3.198134650000000000
          Width = 111.118110240000000000
          Height = 11.338590000000000000
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
            
              'Bruto : [SUM(<frxDBEtiqCaixa."peso"> * <frxDBEtiqCaixa."quantida' +
              'de">,rlbDetalhes)] Kg')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 301.781004650000000000
          Top = 3.198134650000000000
          Width = 196.535560000000000000
          Height = 11.338590000000000000
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
            
              'Liquido : [SUM(<frxDBEtiqCaixa."peso"> * <frxDBEtiqCaixa."quanti' +
              'dade">,rlbDetalhes) * FATOR ] Kg')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 521.236550000000000000
          Top = 3.198134650000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
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
            '[SUM(<frxDBEtiqCaixa."quantidade">,rlbDetalhes)]')
          ParentFont = False
        end
      end
    end
  end
  object frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    EnviarNomes = False
    Left = 112
    Top = 75
  end
  object frxDBImpEti: TfrxDBDataset
    UserName = 'frxDBImpEti'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODBAR=CODBAR'
      'CODITE=CODITE'
      'DESITE=DESITE'
      'NUMDOC=NUMDOC'
      'QTDITE=QTDITE'
      'UNITAR=UNITAR'
      'TOTITE=TOTITE'
      'UNIDAD=UNIDAD'
      'NOMEMP=NOMEMP'
      'NOMVEN=NOMVEN'
      'NOMCLI=NOMCLI'
      'ENDENT=ENDENT'
      'CIDENT=CIDENT'
      'SIGLA_=SIGLA_'
      'IDEPRO=IDEPRO'
      'DTAENT=DTAENT'
      'DTAVAL=DTAVAL'
      'MENSAG=MENSAG'
      'TIPEMB=TIPEMB'
      'NRODOC=NRODOC'
      'CODVEN=CODVEN'
      'VOLQTE=VOLQTE'
      'LOCFIS=LOCFIS'
      'DESFIS=DESFIS'
      'CODFAB=CODFAB'
      'REFERE=REFERE'
      'CODCLI=CODCLI')
    BCDToCurrency = False
    Left = 24
    Top = 72
  end
  object frxDBEtiqCaixa: TfrxDBDataset
    UserName = 'frxDBEtiqCaixa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id=id'
      'pedido=pedido'
      'codigo=codigo'
      'descricao=descricao'
      'quantidade=quantidade'
      'unidade=unidade'
      'peso=peso'
      'SeqCx=SeqCx'
      'codfab=codfab'
      'fgoinc=fgoinc'
      'fdoinc=fdoinc'
      'pestot=pestot')
    BCDToCurrency = False
    Left = 182
    Top = 72
  end
end
