object frmQckRcxRecCredPenCli: TfrmQckRcxRecCredPenCli
  Left = 377
  Top = 382
  Caption = 'Impress'#227'o do Recibo de Cr'#233'ditos Pendentes de Clientes - Bobina'
  ClientHeight = 230
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxReciboB: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 40969.395906747700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 16
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelatorio: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549600000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE CREDITOS DO CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 136.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBRecibo
          DataSetName = 'frxRecibo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[TELEFONE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ENDERECO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[CIDADE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 153.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBRecibo
          DataSetName = 'frxRecibo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."NOMCLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 204.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CREDITO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 306.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
        RowCount = 0
        object DMPMemo16: TfrxDMPMemoView
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '[Trim(<frxRecibo."CTR_NUMDUP">)][Trim(<frxRecibo."CTR_PARCEL">)]' +
              '-[Trim(<frxRecibo."CTR_ESPDOC">)]')
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_VALDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DE CREDITO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRecibo."CTR_VALDUP">,Detalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 136
    Top = 16
  end
  object cdsRecibo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 64
    object cdsReciboCTR_NUMDUP: TStringField
      FieldName = 'CTR_NUMDUP'
    end
    object cdsReciboCTR_PARCEL: TStringField
      FieldName = 'CTR_PARCEL'
      Size = 3
    end
    object cdsReciboCTR_ESPDOC: TStringField
      FieldName = 'CTR_ESPDOC'
      Size = 2
    end
    object cdsReciboCTR_CODCLI: TStringField
      FieldName = 'CTR_CODCLI'
      Size = 8
    end
    object cdsReciboCTR_CODEMP: TStringField
      FieldName = 'CTR_CODEMP'
      Size = 3
    end
    object cdsReciboCTR_DTACAD: TDateField
      FieldName = 'CTR_DTACAD'
    end
    object cdsReciboCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object cdsReciboCTR_CODVEN: TStringField
      FieldName = 'CTR_CODVEN'
      Size = 3
    end
    object cdsReciboCTR_VALDUP: TCurrencyField
      FieldName = 'CTR_VALDUP'
    end
    object cdsReciboNOMCLIENTE: TStringField
      FieldName = 'NOMCLIENTE'
      Size = 40
    end
    object cdsReciboCTR_HIST01: TStringField
      FieldName = 'CTR_HIST01'
      Size = 60
    end
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'frxRecibo'
    CloseDataSource = False
    DataSource = dtsRecibo
    BCDToCurrency = False
    Left = 224
    Top = 16
  end
  object dtsRecibo: TDataSource
    DataSet = cdsRecibo
    Left = 224
    Top = 64
  end
  object frxReciboLJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 40157.470926643510000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chiCabec.Visible := False;                                    ' +
        '  '
      'end;'
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    Left = 32
    Top = 64
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 52.866110000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxReciboLJ.chiCabec
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 94.677490000000000000
          Top = 17.000000000000000000
          Width = 528.755720000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 626.976190000000000000
          Top = 17.000000000000000000
          Width = 36.434570000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAG.')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 244.006680000000000000
          Top = 34.000000000000000000
          Width = 230.097340000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE CR'#201'DITOS DO CLIENTE')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 694.251700000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 686.651700000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 13.220470000000000000
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
          Left = 665.451700000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 13.220470000000000000
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
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 13.220470000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
        RowCount = 0
        object rllDtaVen: TfrxMemoView
          Left = 282.385660790000000000
          Width = 71.433075750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 627.023634250000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Width = 177.259915750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRecibo."CTR_NUMDUP"][frxRecibo."CTR_PARCEL"]-[frxRecibo."CTR' +
              '_ESPDOC"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo41: TfrxMemoView
          Left = 214.519790000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 180.873847320000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllHist01: TfrxMemoView
          Left = 361.543536540000000000
          Width = 241.360420000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."CTR_HIST01"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.763760000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        Condition = 'frxRecibo."CTR_CODCLI"'
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 43.409400000000000000
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object rllTotValRec: TfrxMemoView
          Left = 606.456651420000000000
          Top = 7.000000000000000000
          Width = 82.771665750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRecibo."CTR_VALDUP">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 483.409385350000000000
          Top = 7.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baLeft
          Top = 3.779530000000022000
          Width = 718.110700000000100000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 37.795300000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 94.488250000000000000
        Width = 718.110700000000000000
        object Shape1: TfrxShapeView
          Top = 16.929190000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = clSilver
        end
        object Memo12: TfrxMemoView
          Left = 361.702660000000000000
          Top = 16.897650000000000000
          Width = 146.872170000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 282.223500000000000000
          Top = 16.897650000000000000
          Width = 75.212605750000000000
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
        object Memo18: TfrxMemoView
          Left = 627.023622050000000000
          Top = 16.897650000000000000
          Width = 71.433075750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. CR'#201'DITO')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Top = 16.897650000000000000
          Width = 109.228375750000000000
          Height = 13.220470000000000000
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
        object Memo23: TfrxMemoView
          Left = 180.826840000000000000
          Top = 16.897650000000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 214.519790000000000000
          Top = 16.897650000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = clSilver
        end
        object Memo3: TfrxMemoView
          Width = 702.463080000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE: [frxRecibo."CTR_CODCLI"] -  [frxRecibo."NOMCLIENTE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReciboLM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 41003.609577719900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    Left = 32
    Top = 112
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 208.279865485920200000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 787.200000000000000000
        Child = frxReciboLM.chiCabec
        object rllNomEmp: TfrxDMPMemoView
          Align = baCenter
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE CREDITOS DO CLIENTE')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 153.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 787.200000000000000000
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
        RowCount = 0
        object rllDtaVen: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODEMP"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_VALDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '[frxRecibo."CTR_NUMDUP"][frxRecibo."CTR_PARCEL"]-[frxRecibo."CTR' +
              '_ESPDOC"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTACAD"]')
          TruncOutboundText = False
        end
        object rllHist01: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRecibo."CTR_HIST01"]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderDocs: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 787.200000000000000000
        Condition = 'frxRecibo."CTR_CODCLI"'
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 85.000000000000000000
        Width = 787.200000000000000000
        object DMPMemo12: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 68.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.CREDITO')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 68.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'EMP')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CADASTRO')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE: [frxRecibo."CTR_CODCLI"] - [frxRecibo."NOMCLIENTE"]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 255.000000000000000000
        Top = 306.000000000000000000
        Width = 787.200000000000000000
        object rllTotValRec: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 204.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRecibo."CTR_VALDUP">,rlbMaster,2)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReciboT: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44599.339045173610000000
    ReportOptions.LastChange = 44599.352714907410000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 172
    Datasets = <
      item
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      EndlessHeight = True
      LargeDesignHeight = True
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'arial'
        Font.Style = []
        Height = 51.000000000000000000
        ParentFont = False
        Top = 279.685220000000000000
        Width = 283.464750000000000000
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
        RowCount = 0
        object Memo16: TfrxMemoView
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Trim(<frxRecibo."CTR_NUMDUP">)][Trim(<frxRecibo."CTR_PARCEL">)]' +
              '-[Trim(<frxRecibo."CTR_ESPDOC">)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Top = 26.456710000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODEMP"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 34.015748031496060000
          Top = 26.456710000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTAVEN"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 113.385826771653500000
          Top = 26.456710000000000000
          Width = 79.370078740000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_VALDUP"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 196.535433070866100000
          Top = 26.456710000000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."CTR_DTACAD"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 18.897650000000000000
        Width = 283.464750000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
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
        object Memo2: TfrxMemoView
          Top = 22.677180000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TELEFONE]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 60.472480000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 86.929190000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo5: TfrxMemoView
          Top = 90.708720000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 49.133890000000000000
          Top = 90.708720000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."CTR_CODCLI"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 109.606370000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 49.133890000000000000
          Top = 109.606370000000000000
          Width = 215.433210000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRecibo."NOMCLIENTE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 41.574830000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ENDERECO]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 393.071120000000000000
        Width = 283.464750000000000000
        object Line4: TfrxLineView
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Left = 43.913420000000000000
          Top = 7.559060000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total de cr'#233'ditos:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 172.417440000000000000
          Top = 7.559060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRecibo."CTR_VALDUP">,Detalhes)]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 211.653680000000000000
        Width = 283.464750000000000000
        object Line2: TfrxLineView
          Width = 268.346630000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo9: TfrxMemoView
          Top = 3.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 22.677180000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emp')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 34.015770000000000000
          Top = 22.677180000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 113.385900000000000000
          Top = 22.677180000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 196.535560000000000000
          Top = 22.677180000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Top = 41.574830000000000000
          Width = 268.346630000000000000
          Color = clBlack
          Diagonal = True
        end
      end
    end
  end
end
