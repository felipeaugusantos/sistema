object frmModuloOrdemCarreg: TfrmModuloOrdemCarreg
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 267
  Width = 346
  object frxDocCar80J: TfrxReport
    Version = '5.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41046.605078622680000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 16
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object pghCabecEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 3.779473860000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDocCar80J.ChildTitulo
        PrintChildIfInvisible = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118095590000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object mmoLocFis: TfrxMemoView
          Left = 0.779530000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 185.976500000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoDesIte: TfrxMemoView
          Left = 377.378170000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object mmoDesMar: TfrxMemoView
          Left = 576.913730000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 335.756340000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoQtdIte: TfrxMemoView
          Left = 238.110390000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
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
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoCodFab: TfrxMemoView
          Left = 79.370130000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897623150000000000
        ParentFont = False
        Top = 219.212740000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        ReprintOnNewPage = True
        Stretched = True
        object Shape1: TfrxShapeView
          Width = 718.110700000000000000
          Height = 18.897625590000000000
          Fill.BackColor = clSilver
        end
        object mmoTitLocFis: TfrxMemoView
          Left = 0.779530000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 185.976500000000000000
          Top = 3.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitDesIte: TfrxMemoView
          Left = 377.378170000000000000
          Top = 3.000000000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitDesMar: TfrxMemoView
          Left = 576.913730000000000000
          Top = 3.000000000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 335.756340000000000000
          Top = 3.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoTitCodFab: TfrxMemoView
          Left = 79.370130000000000000
          Top = 3.000000000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.F'#193'BRICA')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456568430000000000
        ParentFont = False
        Top = 377.953000000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxCadSepfrxCadSep4: TfrxMemoView
          Left = 537.961040000000000000
          Top = 7.937007870000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."DTAENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 653.961040000000000000
          Top = 7.937007870000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."HORENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 506.724800000000000000
          Top = 7.937007870000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 622.945270000000000000
          Top = 7.937007870000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787340550000000000
        ParentFont = False
        Top = 90.708720000000000000
        Width = 718.110700000000000000
        Child = frxDocCar80J.ChildLocSep
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.677180000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 423.307360000000000000
          Top = 0.677180000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 94.488250000000000000
          Top = 0.677180000000000000
          Width = 325.039580000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 483.779840000000000000
          Top = 0.677180000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadSep."CODFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 298.582870000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          Left = 41.574830000000000000
          Top = 1.889758900000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE TOTAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 238.110390000000000000
          Top = 1.889758900000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."QTDITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildTitulo: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 45.354360000000000000
        Width = 718.110700000000000000
        Child = frxDocCar80J.ChildDadosCliente
        PrintChildIfInvisible = True
        object Line3: TfrxLineView
          Align = baWidth
          Top = 0.000000000000000007
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object dbTITULO: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.889757670000000000
          Width = 600.945270000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'ORDEM DE CARREGAMENTO - [frxCadSep."NUMDOC"] - [frxCadSep."ESPDO' +
              'C"]')
          ParentFont = False
        end
        object mmoNumPag2: TfrxMemoView
          Left = 645.520100000000000000
          Top = 1.889765000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildLocSep: TfrxChild
        FillType = ftBrush
        Height = 20.787404020000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.944881890000000000
          Width = 706.772110000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Separador: __________________________________________________ Ho' +
              'ra: ______')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 104
    Top = 16
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
    Left = 240
    Top = 16
  end
  object frxCadEmp: TfrxDBDataset
    UserName = 'frxCadEmp'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 160
    Top = 16
  end
  object dtsOrdCar: TDataSource
    Left = 232
    Top = 74
  end
  object frxCadSep: TfrxDBDataset
    UserName = 'frxCadSep'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 104
    Top = 66
  end
  object frxDocCar80M: TfrxReport
    Version = '5.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41052.476396296300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 72
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
      end
      item
        DataSet = frxCadSep
        DataSetName = 'frxCadSep'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object mmoLocFis: TfrxDMPMemoView
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."LOCFIS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo26: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoDesIte: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoDesMar: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo30: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoQtdIte: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoCodFab: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object pghCabecEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 68.000000000000000000
        ParentFont = False
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        Child = frxDocCar80M.ChildDadosCliente
        PrintChildIfInvisible = True
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            
              'ORDEM DE CARREGAMENTO - [frxCadSep."NUMDOC"] - [frxCadSep."ESPDO' +
              'C"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#33'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 134.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 102.000000000000000000
        Width = 1276.800000000000000000
        Child = frxDocCar80M.ChildLocSep
        PrintChildIfInvisible = True
        object Memo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo9: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'Codigo:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxCadSep."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo19: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxCadSep."CODFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object ChildLocSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1276.800000000000000000
        object Memo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            
              'Separador: __________________________________________________ Ho' +
              'ra: ______')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 51.000000000000000000
        ParentFont = False
        Top = 289.000000000000000000
        Width = 1276.800000000000000000
        object Memo2: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE TOTAL:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Line4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object Memo41: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."QTDITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 187.000000000000000000
        Width = 1276.800000000000000000
        object mmoTitLocFis: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo25: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoTitDesIte: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO/REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoTitDesMar: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo28: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo29: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoTitCodFab: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'COD.FABRICA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
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
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
    end
  end
end
