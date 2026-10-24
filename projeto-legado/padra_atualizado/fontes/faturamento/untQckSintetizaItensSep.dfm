object frmQckSintetizaItensSep: TfrmQckSintetizaItensSep
  Left = 0
  Top = 0
  ClientHeight = 210
  ClientWidth = 428
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
  object frxItensSintetizados1: TfrxDBDataset
    Description = 'Itens Sintetizados'
    UserName = 'frxItensSintetizados1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 72
    Top = 24
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43649.325596400500000000
    ReportOptions.LastChange = 44963.612331574100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  strCODBAR: String;'
      ''
      'procedure memBAR_CODBAROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strCODBAR := <frxItensSintetizados1."BAR_CODBAR">;'
      '  If (strCODBAR <> '#39#39') Then'
      '  Begin              '
      
        '    memBAR_CODBAR.Text := Copy(strCODBAR,Length(strCODBAR)-3, 4)' +
        ';  '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 192
    Top = 24
    Datasets = <
      item
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
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
      Frame.Typ = [ftTop]
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 158.740260000000000000
        Width = 718.110700000000000000
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."ITE_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 192.000000000000000000
          Top = 1.779530000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 256.433210000000000000
          Top = 1.779530000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 343.181102360000000000
          Top = 1.779530000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_DESCRI"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 582.488560000000000000
          Top = 1.779530000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 616.622450000000000000
          Top = 1.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.133890000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos: [frxItensSintetizados1."DOCUMENTOS"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 85.039370080000000000
          Top = 2.000000000000000000
          Width = 105.826771650000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object memBAR_CODBAR: TfrxMemoView
          Left = 342.937230000000000000
          Top = 21.897650000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'memBAR_CODBAROnBeforePrint'
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."BAR_CODBAR"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 117.165430000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxItensSintetizados1."FGO_SEQSEP"'
        StartNewPage = True
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 241.889995670000000000
          Top = 9.448825000000000000
          Width = 234.330708660000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Itens Sintetizados')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 129.000000000000000000
          Height = 83.149606299212600000
          BarType = bcCode39
          Expression = '<frxItensSintetizados1."FGO_SEQSEP">'
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
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 90.763779530000000000
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc. F'#237'sica')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 191.881889760000000000
          Top = 90.763779530000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 256.251968500000000000
          Top = 90.763779530000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'd. Fabrica')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 343.220472440000000000
          Top = 90.763779530000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 582.425204170000000000
          Top = 90.763779530000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 616.440944880000000000
          Top = 90.763779530000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 85.472480000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 0.779530000000000000
          Top = 115.047310000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Left = 85.039370080000000000
          Top = 90.763779530000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc.Sup.Estoque')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 241.889920000000000000
          Top = 34.015770000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxItensSintetizados1."DTAIMP"] - [frxItensSintetizados1."HORIM' +
              'P"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          Left = 1.779530000000000000
          Top = 3.779530000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.559060000000000000
          Width = 699.213050000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."OPESEP"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 18.897637800000000000
        Top = 336.378170000000000000
        Width = 718.110700000000000000
        object memPagina: TfrxMemoView
          Left = 634.961040000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'p'#225'gina [Page]/[TotalPages]')
          ParentFont = False
        end
        object memSeqSep: TfrxMemoView
          Left = 7.559060000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FGO_SEQSEP"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReport40CJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43649.325596400500000000
    ReportOptions.LastChange = 44963.701169409720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      
        '  strCODBAR: String;                                            ' +
        '         '
      ''
      'procedure memBAR_CODBAROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strCODBAR := <frxItensSintetizados1."BAR_CODBAR">;'
      '  If (strCODBAR <> '#39#39') Then'
      '  Begin              '
      
        '    memBAR_CODBAR.Text := Copy(strCODBAR,Length(strCODBAR)-3, 4)' +
        ';  '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 192
    Top = 80
    Datasets = <
      item
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 72.000000000000000000
      PaperHeight = 327.900000000000000000
      PaperSize = 256
      Frame.Typ = [ftTop]
      EndlessHeight = True
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 102.047261180000000000
        Top = 204.094620000000000000
        Width = 272.126160000000000000
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 272.126160000000000000
          Height = 102.047261180000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 132.283464570000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItensSintetizados1."ITE_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 141.354330710000000000
          Top = 1.779530000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 210.141732280000000000
          Top = 1.779530000000000000
          Width = 56.692913385826800000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779527560000000000
          Top = 39.677180000000000000
          Width = 162.519685040000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_DESCRI"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 167.055118110000000000
          Top = 39.677180000000000000
          Width = 18.897637795275600000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 191.244094490000000000
          Top = 39.685039370000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 3.779527560000000000
          Top = 72.929190000000000000
          Width = 263.433051340000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos: [frxItensSintetizados1."DOCUMENTOS"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.677180000000000000
          Width = 117.165354330000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 191.622047240000000000
          Top = 20.787401570000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object memBAR_CODBAR: TfrxMemoView
          Left = 3.779530000000000000
          Top = 55.692950000000000000
          Width = 162.519685040000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'memBAR_CODBAROnBeforePrint'
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."BAR_CODBAR"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 162.519790000000000000
        Top = 18.897650000000000000
        Width = 272.126160000000000000
        Condition = 'frxItensSintetizados1."FGO_SEQSEP"'
        StartNewPage = True
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 66.141775000000000000
          Top = 5.889765000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Itens Sintetizados')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Align = baCenter
          Left = 71.563080000000000000
          Top = 26.338590000000000000
          Width = 129.000000000000000000
          Height = 52.913420000000000000
          BarType = bcCode39
          Expression = '<frxItensSintetizados1."FGO_SEQSEP">'
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
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 104.377952760000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Localiza'#231#227'o F'#237'sica')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 141.283550000000000000
          Top = 104.472480000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 210.141732280000000000
          Top = 104.252010000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'd.Fabr.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779527560000000000
          Top = 135.149660000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 167.196970000000000000
          Top = 135.370130000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 191.315090000000000000
          Top = 136.149660000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 99.472480000000000000
          Width = 264.566909610000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 3.779527560000000000
          Top = 154.724490000000000000
          Width = 264.566909610000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 79.370130000000000000
          Width = 264.566909610000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo15: TfrxMemoView
          Left = 75.590600000000000000
          Top = 83.370130000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SEPARADOR]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.944960000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc.Super Estoque')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 191.433210000000000000
          Top = 119.944960000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Saldo Disp.')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.889763780000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DATA]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 221.330860000000000000
          Top = 5.889763780000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[HORA]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 83.370130000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Separador:')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 366.614410000000000000
        Width = 272.126160000000000000
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Top = 36.881880000000000000
          Width = 264.566909610000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Pedidos:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 166.299320000000000000
          Top = 3.779530000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."TOTPED"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 19.677180000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Itens:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 264.566909610000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          Left = 166.299212600000000000
          Top = 19.653543310000000000
          Width = 102.047244090000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItensSintetizados1."FDO_QTDITE">,MasterData1,3)]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportWMS: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43649.325596400500000000
    ReportOptions.LastChange = 44998.681365347200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  strCOD_BAR: String;'
      ''
      'procedure memBAR_CODBAROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strCOD_BAR := <frxItensSintetizados1."BAR_CODBAR">;'
      '  If (strCOD_BAR <> '#39#39') Then'
      '  Begin              '
      
        '     memBAR_CODBAR.Text := Copy(strCOD_BAR,Length(strCOD_BAR)-3,' +
        ' 4);  '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 304
    Top = 32
    Datasets = <
      item
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
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
      Frame.Typ = [ftTop]
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779529999999994000
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."LOT_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 192.000000000000000000
          Top = 1.779529999999994000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 256.433210000000000000
          Top = 1.779529999999994000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."ITE_CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 343.181102360000000000
          Top = 1.779529999999994000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_DESCRI"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 582.488560000000000000
          Top = 1.779529999999994000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 616.622450000000000000
          Top = 1.779529999999994000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos: [frxItensSintetizados1."DOCUMENTOS"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 85.039370080000000000
          Top = 2.000000000000000000
          Width = 105.826771650000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."LDO_NUMLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object memBAR_CODBAR: TfrxMemoView
          Left = 342.937230000000000000
          Top = 20.677179999999990000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'memBAR_CODBAROnBeforePrint'
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."BAR_CODBAR"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxItensSintetizados1."FGO_SEQSEP"'
        StartNewPage = True
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 289.134045000000000000
          Top = 9.448825000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Itens Sintetizados')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 129.000000000000000000
          Height = 83.149606299212600000
          BarType = bcCode39
          Expression = '<frxItensSintetizados1."FGO_SEQSEP">'
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
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.763779530000000000
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc. F'#237'sica')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 191.881889760000000000
          Top = 94.763779530000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 256.251968500000000000
          Top = 94.763779530000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'd. Fabrica')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 343.220472440000000000
          Top = 94.763779530000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 582.425204170000000000
          Top = 94.763779530000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 616.440944880000000000
          Top = 94.763779530000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 89.472480000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 0.779530000000000000
          Top = 119.047310000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Left = 85.039370080000000000
          Top = 94.763779530000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
        end
        object memOndaFina: TfrxMemoView
          Align = baCenter
          Left = 207.874247640000000000
          Top = 30.236240000000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Remessa de Pedido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 529.134199999999900000
          Top = 11.338590000000000000
          Width = 181.417440000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItensSintetizados1."OPE_NOMOPE"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 18.897637800000000000
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        object memPagina: TfrxMemoView
          Left = 7.559055120000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FGO_SEQSEP"]')
          ParentFont = False
        end
        object memSeqSep: TfrxMemoView
          Left = 634.960681180000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'p'#225'gina [Page]/[TotalPages]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportWMSOndaGrossa: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43649.325596400500000000
    ReportOptions.LastChange = 45043.748295671300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.  ')
    Left = 304
    Top = 80
    Datasets = <
      item
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
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
      Frame.Typ = [ftTop]
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        DataSet = frxItensSintetizados1
        DataSetName = 'frxItensSintetizados1'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 154.960678740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."LOT_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 167.433070866141700000
          Top = 1.779530000000022000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 243.401574800000000000
          Top = 1.779530000000022000
          Width = 238.110236220000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_DESCRI"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 493.984251970000000000
          Top = 1.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensSintetizados1."FDO_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 707.834645670000000000
          Top = 3.779530000000022000
          Width = 332.598564330000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensSintetizados1."NMVENREMPD"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = [ftBottom]
        Height = 22.677167800000000000
        Top = 257.008040000000000000
        Width = 1046.929810000000000000
        Condition = 'frxItensSintetizados1."SEQOND"'
        StartNewPage = True
        object Memo1: TfrxMemoView
          Top = 2.511769530000009000
          Width = 79.370078740000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 167.614109760000000000
          Top = 2.511769530000009000
          Width = 64.252010000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SKU')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 243.362092440000000000
          Top = 2.511769530000009000
          Width = 238.110390000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 493.905384880000000000
          Top = 2.511769530000009000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 599.354670000000000000
          Top = 2.511769530000009000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REAL')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 707.756340000000000000
          Top = 2.511769530000009000
          Width = 117.165430000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVA'#199#195'O')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = [ftBottom]
        Height = 88.440959530000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 453.543600000000000000
          Top = 9.448825000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Itens Sintetizados')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 5.779530000000000000
          Top = 3.779530000000000000
          Width = 129.000000000000000000
          Height = 83.149606299212600000
          BarType = bcCode39
          Expression = '<frxItensSintetizados1."SEQOND">'
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
        object Memo17: TfrxMemoView
          Align = baCenter
          Left = 372.283802637795300000
          Top = 30.236240000000000000
          Width = 302.362204724409400000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Remessa de Separa'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 842.835190000000000000
          Top = 30.236240000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 941.102970000000000000
          Top = 30.236240000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[DATE]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = [ftBottom]
        Height = 68.031540000000000000
        Top = 166.299320000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo18: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 68.031540000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ''
            
              'Nome: _____________________________ Hora Emiss'#227'o: __________ Hor' +
              'a In'#237'cio: __________ Hora T'#233'rmino: __________ - Confer. ________' +
              '_________ Hora: __________'
            ''
            'Remessas de Pedido: [frxItensSintetizados1."ONDAS_FINAS"]')
          ParentFont = False
        end
      end
    end
  end
end
