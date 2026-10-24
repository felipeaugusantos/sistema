object frmQckRcxCompTransf: TfrmQckRcxCompTransf
  Left = 414
  Top = 364
  Caption = 'frmQckRcxCompTransf'
  ClientHeight = 209
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxQckRcxCompTransf40Col_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39534.649656585700000000
    ReportOptions.LastChange = 40073.248917638890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 105
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 89.958275235280580000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxCompTransf40Col_M.rlbDados
        object rllNomEmp: TfrxDMPMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."NOMEMP"]')
          TruncOutboundText = False
        end
        object rllFone001: TfrxDMPMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'FONE01'
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."FONE01"]')
          TruncOutboundText = False
        end
        object rllCidEmp: TfrxDMPMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'CIDEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."CIDEMP"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 76.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object dmpComando: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object rlbDados: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 119.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxCompTransf40Col_M.rllFinalizar
        Stretched = True
        object rllTitulo: TfrxDMPMemoView
          Align = baWidth
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPROVANTE DE TRANSFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllDados: TfrxDMPMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'RESULT'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."RESULT"]')
          TruncOutboundText = False
        end
      end
      object rllFinalizar: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 187.000000000000000000
        Width = 384.000000000000000000
        Stretched = True
        object DMPLine2: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object rllOperador: TfrxDMPMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'OPERAD'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."OPERAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 52.800000000000000000
          Top = 93.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
        end
        object rllResponsavel: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 102.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RESPONSAVEL')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DTACAD'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxGen."DTACAD"]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'HORCAD'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.FormatStr = 'hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxGen."HORCAD"]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'SEQCON'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."SEQCON"]')
          TruncOutboundText = False
        end
        object rllSalto: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CAIXA'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."CAIXA"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = False
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 104
    Top = 56
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'NOMEMP'
      'FONE01'
      'CIDEMP'
      'OPERAD'
      'RESULT'
      'CAIXA'
      'CODEMPTRF'
      'NOMEMPTRF'
      'CIDEMPTRF'
      'FONEMPTRF'
      'ESTEMPTRF'
      'RECIBO')
    OnGetValue = frxGenGetValue
    Left = 24
    Top = 56
  end
  object frxQckRcxCompTransf40Col_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39534.649656585700000000
    ReportOptions.LastChange = 45041.609072025470000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 153
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 72.000000000000000000
      PaperHeight = 90.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 18.897650000000000000
        Width = 272.126160000000000000
        Child = frxQckRcxCompTransf40Col_J.rlbDados
        object rllNomEmp: TfrxMemoView
          Left = 15.118110240000000000
          Top = 14.220470000000000000
          Width = 253.228346460000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."NOMEMP"]')
          ParentFont = False
        end
        object rllFone001: TfrxMemoView
          Left = 15.118110240000000000
          Top = 31.220470000000000000
          Width = 253.228346460000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'FONE01'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."FONE01"]')
          ParentFont = False
        end
        object rllCidEmp: TfrxMemoView
          Left = 15.118110240000000000
          Top = 48.220470000000000000
          Width = 253.228346460000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'CIDEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."CIDEMP"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = -4.800000000000000000
          Top = 76.500000000000000000
          Width = 283.691280000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDados: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 128.504020000000000000
        Width = 272.126160000000000000
        Child = frxQckRcxCompTransf40Col_J.rllFinalizar
        Stretched = True
        object rllTitulo: TfrxMemoView
          Left = 15.118110240000000000
          Width = 249.448818897637800000
          Height = 17.000000000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPROVANTE DE TRANSFERENCIA')
          ParentFont = False
        end
        object rllDados: TfrxMemoView
          Left = 17.385826770000000000
          Top = 34.000000000000000000
          Width = 245.669291340000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'RESULT'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."RESULT"]')
          ParentFont = False
        end
      end
      object rllFinalizar: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 204.094620000000000000
        Width = 272.126160000000000000
        Stretched = True
        object Line2: TfrxLineView
          Left = -4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllOperador: TfrxMemoView
          Left = 17.385826770000000000
          Top = 35.000000000000000000
          Width = 244.913385830000000000
          Height = 17.000000000000000000
          DataField = 'OPERAD'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."OPERAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 38.800000000000000000
          Top = 93.500000000000000000
          Width = 198.727520000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllResponsavel: TfrxMemoView
          Left = 17.385826771653540000
          Top = 102.000000000000000000
          Width = 244.913385826771700000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESPONSAVEL')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 17.385826770000000000
          Top = 17.000000000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."DTACAD"]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 104.400000000000000000
          Top = 17.007874020000000000
          Width = 66.368460000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.FormatStr = 'hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."HORCAD"]')
          ParentFont = False
        end
        object rllSalto: TfrxMemoView
          Top = 119.000000000000000000
          Width = 272.125984250000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 174.419110000000000000
          Top = 17.007874020000000000
          Width = 85.266110000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."SEQCON"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 17.385826770000000000
          Top = 54.692950000000000000
          Width = 244.913385830000000000
          Height = 17.000000000000000000
          DataField = 'CAIXA'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."CAIXA"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReport80M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 256
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40205.367536701400000000
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
      
        ' // rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 104
    Top = 104
    Datasets = <
      item
        DataSet = frxDBCarcre
        DataSetName = 'frxDBCarCre'
      end
      item
        DataSet = frxDBCheAvi
        DataSetName = 'frxDBCheAvi'
      end
      item
        DataSet = frxDBChePre
        DataSetName = 'frxDBChePre'
      end
      item
        DataSet = frxUserDataSet
        DataSetName = 'frxUserDataSet'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1207.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMROD]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
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
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
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
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
      end
      object ChildChePre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 544.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxReport80M.ChildCarCreCabec
        PrintChildIfInvisible = True
        Stretched = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80M.Page1
        end
      end
      object ChildDinheiro: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 170.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildCheAviCabec
        PrintChildIfInvisible = True
        object DMPMemo45: TfrxDMPMemoView
          Align = baCenter
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFERENCIA [TRANSFERENCIA_FECHAMENTO]EM DINHEIRO')
          TruncOutboundText = False
        end
        object DMPLine12: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORDINHEI]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALDINHEI]')
          TruncOutboundText = False
        end
        object DMPLine13: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object ChildOrdemPagto: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 731.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildOrdemPagtoPix
        PrintChildIfInvisible = True
        object DMPLine14: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine15: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo57: TfrxDMPMemoView
          Align = baCenter
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSFERENCIA EM ORDEM DE PAGAMENTO')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORORDPAG]')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORDPAG]')
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object ChildCarCre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1248.000000000000000000
        AllowSplit = True
        Child = frxReport80M.ChildOrdemPagto
        PrintChildIfInvisible = True
        Stretched = True
        object subCarCre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80M.pagCarCre
        end
      end
      object ChildChePreCabec: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 425.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildChePre
        PrintChildIfInvisible = True
        object DMPMemo25: TfrxDMPMemoView
          Align = baCenter
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSFERENCIA DE CHEQUES A PRAZO')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCHEPRE]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCHEPRE]')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object ChildCheAviCabec: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildCheAvi
        PrintChildIfInvisible = True
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSFERENCIA DE CHEQUES A VISTA')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCHEAVI]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCHEAVI]')
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
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object ChildCarCreCabec: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 578.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildCarCre
        PrintChildIfInvisible = True
        object DMPMemo46: TfrxDMPMemoView
          Align = baCenter
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSFERENCIA EM CARTAO DE CREDITO')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCARCRE]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCARCRE]')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxUserDataSet
        DataSetName = 'frxUserDataSet'
        RowCount = 0
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildDinheiro
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 1071.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTADOC]')
          TruncOutboundText = False
        end
        object DMPLine16: TfrxDMPLineView
          Left = 561.600000000000000000
          Top = 59.500000000000000000
          Width = 451.200000000000000000
          Color = clBlack
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 68.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RESPONSAVEL')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[HORDOC]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SEQCON]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CAIXA]')
          TruncOutboundText = False
        end
      end
      object ChildCheAvi: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildChePreCabec
        PrintChildIfInvisible = True
        object SubCheAvi: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80M.pagCheAvi
        end
      end
      object ChildFinanc: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 969.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildRodape
        PrintChildIfInvisible = True
        object DMPMemo32: TfrxDMPMemoView
          Align = baCenter
          Left = 480.000000000000000000
          Top = 17.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TRANSFERENCIA EM FINANCIAMENTO')
          TruncOutboundText = False
        end
        object DMPLine18: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORFIN]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALFIN]')
          TruncOutboundText = False
        end
        object DMPLine19: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
      object ChildOrdemPagtoPix: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 850.000000000000000000
        Width = 1248.000000000000000000
        Child = frxReport80M.ChildFinanc
        PrintChildIfInvisible = True
        object DMPLine20: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine21: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo75: TfrxDMPMemoView
          Align = baCenter
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TRANSFERENCIA EM ORDEM DE PAGAMENTO - PIX')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORORDPAG]')
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORDPAGPIX]')
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
      end
    end
    object pagCarCre: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUMERO DA LIBERACAO')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.CLI.')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 68.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxDBCarcre
        DataSetName = 'frxDBCarCre'
        RowCount = 0
        object DMPMemo49: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."CODCAR"]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."NUMCCD"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBCarCre."NOMEMI">)]')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCarCre."VALOR"]')
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."DTAVEN"]')
          TruncOutboundText = False
        end
      end
    end
    object pagCheAvi: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 777.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo68: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BANCO-AGENCIA-CONTA')
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.CLI.')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIAS CHEQUE')
          TruncOutboundText = False
        end
        object DMPLine17: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 68.000000000000000000
        Width = 777.600000000000000000
        DataSet = frxDBCheAvi
        DataSetName = 'frxDBCheAvi'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."BANCO"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."AGENCIA"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."CONTA"]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."NUMERO"]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBCheAvi."NOMEMI">)]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCheAvi."VALOR"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCheAvi."QTDDIA"]')
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 296.862308276425900000
      PaperSize = 9
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 777.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BANCO-AGENCIA-CONTA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.CLI.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIAS CHEQUE')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 68.000000000000000000
        Width = 777.600000000000000000
        DataSet = frxDBChePre
        DataSetName = 'frxDBChePre'
        RowCount = 0
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."BANCO"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."AGENCIA"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."CONTA"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."NUMERO"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBChePre."NOMEMI">)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBChePre."VALOR"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBChePre."QTDDIA"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDBCheAvi: TfrxDBDataset
    UserName = 'frxDBCheAvi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 24
    Top = 8
  end
  object frxDBChePre: TfrxDBDataset
    UserName = 'frxDBChePre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 24
    Top = 104
  end
  object frxDBCarcre: TfrxDBDataset
    UserName = 'frxDBCarCre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 24
    Top = 152
  end
  object frxReport80J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40205.367857708300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 104
    Top = 152
    Datasets = <
      item
        DataSet = frxDBCarcre
        DataSetName = 'frxDBCarCre'
      end
      item
        DataSet = frxDBCheAvi
        DataSetName = 'frxDBCheAvi'
      end
      item
        DataSet = frxDBChePre
        DataSetName = 'frxDBChePre'
      end
      item
        DataSet = frxUserDataSet
        DataSetName = 'frxUserDataSet'
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
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1244.000000000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 5.820470000000000000
          Top = 5.661410000000160000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMROD]')
        end
        object Line11: TfrxLineView
          Align = baWidth
          Top = 3.779530000000020000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 16.000000000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 114.255350000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 601.624860000000000000
          Top = 56.677180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 640.024860000000000000
          Top = 73.677180000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 511.445330000000000000
          Top = 73.677180000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
      end
      object ChildChePre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 592.000000000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxReport80J.ChildCarCreCabec
        PrintChildIfInvisible = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80J.pagChqPre
        end
      end
      object ChildDinheiro: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 236.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildCheAviCabec
        PrintChildIfInvisible = True
        object Memo45: TfrxMemoView
          Align = baCenter
          Left = 88.283705000000000000
          Top = 17.000000000000000000
          Width = 541.543290000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA [TRANSFERENCIA_FECHAMENTO]EM DINHEIRO')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 9.600000000000000000
          Top = 50.999999999999900000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORDINHEI]')
        end
        object Memo52: TfrxMemoView
          Left = 501.014100000000000000
          Top = 50.999999999999900000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALDINHEI]')
        end
        object Memo60: TfrxMemoView
          Left = 430.034570000000000000
          Top = 50.999999999999900000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 7.559059999999990000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 79.370129999999900000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildOrdemPagto: TfrxChild
        FillType = ftBrush
        Height = 90.661410000000000000
        Top = 772.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildOrdemPagtoPix
        PrintChildIfInvisible = True
        object Memo57: TfrxMemoView
          Align = baCenter
          Left = 191.055350000000000000
          Top = 15.118110240000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA EM ORDEM DE PAGAMENTO')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.023622050000000000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORORDPAG]')
        end
        object Memo59: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.023622047244100000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORDPAG]')
        end
        object Memo61: TfrxMemoView
          Left = 430.034570000000000000
          Top = 51.023622047244100000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 7.559055118110220000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Align = baWidth
          Top = 79.370078740157500000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildCarCre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 736.000000000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxReport80J.ChildOrdemPagto
        PrintChildIfInvisible = True
        object subCarCre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80J.pagCarCre
        end
      end
      object ChildCheAvi: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 448.000000000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxReport80J.ChildChePreCabec
        PrintChildIfInvisible = True
        object subCheAvi: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReport80J.pagCheAvi
        end
      end
      object ChildChePreCabec: TfrxChild
        FillType = ftBrush
        Height = 86.881880000000000000
        Top = 484.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildChePre
        PrintChildIfInvisible = True
        object Memo25: TfrxMemoView
          Align = baCenter
          Left = 205.455350000000000000
          Top = 15.102350000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA DE CHEQUES A PRAZO')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.023622047244200000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCHEPRE]')
        end
        object Memo27: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.023622047244200000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCHEPRE]')
        end
        object Memo63: TfrxMemoView
          Left = 430.034570000000000000
          Top = 51.023622047244200000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 7.559055118110170000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 79.370078740157500000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildCheAviCabec: TfrxChild
        FillType = ftBrush
        Height = 86.881880000000000000
        Top = 340.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildCheAvi
        PrintChildIfInvisible = True
        object Memo17: TfrxMemoView
          Align = baCenter
          Left = 205.455350000000000000
          Top = 15.118110240000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA DE CHEQUES A VISTA')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.023622047244100000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCHEAVI]')
        end
        object Memo36: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.023622047244100000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCHEAVI]')
        end
        object Memo62: TfrxMemoView
          Left = 430.034570000000000000
          Top = 51.023622047244100000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 7.559060000000040000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildCarCreCabec: TfrxChild
        FillType = ftBrush
        Height = 86.881880000000000000
        Top = 628.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildCarCre
        PrintChildIfInvisible = True
        object Memo46: TfrxMemoView
          Align = baCenter
          Left = 195.855350000000000000
          Top = 15.118110240000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA EM CART'#195'O DE CR'#201'DITO')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.023622047244100000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCARCRE]')
        end
        object Memo48: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.023622047244100000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCARCRE]')
        end
        object Memo64: TfrxMemoView
          Left = 430.034570000000000000
          Top = 51.023622047244100000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 7.559055118110220000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 79.370078740157500000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 176.000000000000000000
        Width = 718.110700000000000000
        DataSet = frxUserDataSet
        DataSetName = 'frxUserDataSet'
        RowCount = 0
        object frxUserDataSetfrxUserDataSet: TfrxMemoView
          Width = 79.370130000000000000
          Height = 7.559060000000000000
          DataSet = frxUserDataSet
          DataSetName = 'frxUserDataSet'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet."VAZIO"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 208.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildDinheiro
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 1100.000000000000000000
        Width = 718.110700000000000000
        object Memo16: TfrxMemoView
          Left = 11.338590000000000000
          Top = 34.354360000000000000
          Width = 304.403030000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object Memo66: TfrxMemoView
          Left = 11.338590000000000000
          Top = 13.677179999999900000
          Width = 85.190290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTADOC]')
        end
        object Memo67: TfrxMemoView
          Left = 105.826840000000000000
          Top = 13.677179999999900000
          Width = 92.749350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[HORDOC]')
        end
        object Line12: TfrxLineView
          Left = 362.834880000000000000
          Top = 49.133889999999800000
          Width = 325.039580000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo68: TfrxMemoView
          Left = 480.000310000000000000
          Top = 52.913419999999900000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RESPONS'#193'VEL')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 211.653680000000000000
          Top = 13.677179999999900000
          Width = 92.749350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SEQCON]')
        end
        object Memo74: TfrxMemoView
          Left = 11.338590000000000000
          Top = 54.913420000000000000
          Width = 304.403030000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CAIXA]')
        end
      end
      object ChildFinanc: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 996.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildRodape
        PrintChildIfInvisible = True
        object Memo70: TfrxMemoView
          Align = baCenter
          Left = 197.480520000000000000
          Top = 17.000000000000000000
          Width = 323.149660000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA EM FINANCIAMENTO')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORFIN]')
        end
        object Memo72: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALFIN]')
        end
        object Memo73: TfrxMemoView
          Left = 430.034570000000000000
          Top = 50.999999999999900000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line13: TfrxLineView
          Align = baWidth
          Top = 7.559060000000040000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line14: TfrxLineView
          Align = baWidth
          Top = 79.370129999999900000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildOrdemPagtoPix: TfrxChild
        FillType = ftBrush
        Height = 90.661410000000000000
        Top = 884.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport80J.ChildFinanc
        PrintChildIfInvisible = True
        object Memo75: TfrxMemoView
          Align = baCenter
          Left = 179.716760000000000000
          Top = 15.118110240000000000
          Width = 358.677180000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA EM ORDEM DE PAGAMENTO - PIX')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.023622050000000000
          Width = 407.055040000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORORDPAG]')
        end
        object Memo77: TfrxMemoView
          Left = 501.014100000000000000
          Top = 51.023622050000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORDPAGPIX]')
        end
        object Memo78: TfrxMemoView
          Left = 430.034570000000000000
          Top = 51.023622047244100000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
        end
        object Line15: TfrxLineView
          Align = baWidth
          Top = 7.559055118110220000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line16: TfrxLineView
          Align = baWidth
          Top = 79.370078740157500000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object pagCheAvi: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object Header3: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.102350000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Width = 718.110700000000000000
          Height = 15.133890000000000000
          Fill.BackColor = clSilver
        end
        object Memo1: TfrxMemoView
          Left = 2.040940000000000000
          Width = 162.066110000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'BANCO-AGENCIA-CONTA')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 166.147990000000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NUM.CHEQUE')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 252.850340000000000000
          Width = 50.343290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD.CLI.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 305.234570000000000000
          Width = 180.963760000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 488.087940000000000000
          Width = 104.163760000000000000
          Height = 13.220470000000000000
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
          Left = 594.292640000000000000
          Width = 77.102350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 677.215460000000000000
          Width = 39.609400000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DIAS')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 56.692950000000000000
        Width = 718.110700000000000000
        DataSet = frxDBCheAvi
        DataSetName = 'frxDBCheAvi'
        RowCount = 0
        object mmoZebraAvi: TfrxMemoView
          Width = 718.110700000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 2.040940000000000000
          Width = 21.240940000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."BANCO"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 26.102350000000000000
          Width = 48.000000000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."AGENCIA"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 78.143290000000000000
          Width = 84.963760000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."CONTA"]')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 166.147990000000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."NUMERO"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 252.850340000000000000
          Width = 50.343290000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."CODCLI"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 305.234570000000000000
          Width = 180.812430000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBCheAvi."NOMEMI">)]')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 484.308410000000000000
          Width = 107.943290000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCheAvi."VALOR"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 594.292640000000000000
          Width = 77.102350000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCheAvi."DTAVEN"]')
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 677.215460000000000000
          Width = 39.609400000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCheAvi."QTDDIA"]')
          WordWrap = False
        end
      end
    end
    object pagChqPre: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.102350000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 15.133890000000000000
          Fill.BackColor = clSilver
        end
        object Memo18: TfrxMemoView
          Left = 2.040940000000000000
          Width = 162.066110000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'BANCO-AGENCIA-CONTA')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 166.147990000000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NUM.CHEQUE')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 252.850340000000000000
          Width = 50.343290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD.CLI.')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 305.234570000000000000
          Width = 180.963760000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 488.087940000000000000
          Width = 104.163760000000000000
          Height = 13.220470000000000000
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
        object Memo23: TfrxMemoView
          Left = 594.292640000000000000
          Width = 77.102350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 677.215460000000000000
          Width = 39.609400000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DIAS')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 56.692950000000000000
        Width = 718.110700000000000000
        DataSet = frxDBChePre
        DataSetName = 'frxDBChePre'
        RowCount = 0
        object mmoZebraPre: TfrxMemoView
          Width = 718.110700000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 2.040940000000000000
          Width = 21.240940000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."BANCO"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 26.102350000000000000
          Width = 48.000000000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."AGENCIA"]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 78.143290000000000000
          Width = 84.963760000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."CONTA"]')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 166.147990000000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."NUMERO"]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 252.850340000000000000
          Width = 50.343290000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."CODCLI"]')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 305.234570000000000000
          Width = 180.812430000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBChePre."NOMEMI">)]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 484.308410000000000000
          Width = 107.943290000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBChePre."VALOR"]')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 594.292640000000000000
          Width = 77.102350000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBChePre."DTAVEN"]')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 677.215460000000000000
          Width = 39.609400000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBChePre."QTDDIA"]')
          WordWrap = False
        end
      end
    end
    object pagCarCre: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.102350000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 718.110700000000000000
          Height = 15.133890000000000000
          Fill.BackColor = clSilver
        end
        object Memo39: TfrxMemoView
          Left = 2.040940000000000000
          Width = 76.800000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CARTAO')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 84.661410000000000000
          Width = 162.368460000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NUMERO DA LIBERACAO')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 252.850393700000000000
          Width = 50.267716535433100000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD.CLI.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 305.385826770000000000
          Width = 177.184230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 487.937007870000000000
          Width = 104.314960629921000000
          Height = 13.220470000000000000
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
        object Memo44: TfrxMemoView
          Left = 594.141732283465000000
          Width = 80.881880000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 56.692950000000000000
        Width = 718.110700000000000000
        DataSet = frxDBCarcre
        DataSetName = 'frxDBCarCre'
        RowCount = 0
        object mmoZebraCre: TfrxMemoView
          Width = 718.110700000000000000
          Height = 13.228346460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 2.040940000000000000
          Width = 76.800000000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."CODCAR"]')
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 84.661410000000000000
          Width = 162.368460000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."NUMCCD"]')
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 252.850340000000000000
          Width = 54.122820000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."CODCLI"]')
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 305.385826770000000000
          Width = 177.032900000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Trim(<frxDBCarCre."NOMEMI">)]')
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 487.937007870000000000
          Width = 104.314960629921000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCarCre."VALOR"]')
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 594.141732283465000000
          Width = 80.881880000000000000
          Height = 13.220470000000000000
          DataSetName = 'frxUserCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBCarCre."DTAVEN"]')
          WordWrap = False
        end
      end
    end
  end
  object frxUserDataSet: TfrxUserDataSet
    UserName = 'frxUserDataSet'
    OnCheckEOF = frxUserDataSetCheckEOF
    OnFirst = frxUserDataSetFirst
    OnNext = frxUserDataSetNext
    OnGetValue = frxUserDataSetGetValue
    Left = 104
    Top = 8
  end
  object frxQckRcxCompTransf40Col_Epson: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43788.433577465280000000
    ReportOptions.LastChange = 43788.433577465280000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 236
    Top = 16
    Datasets = <>
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
    end
  end
end
