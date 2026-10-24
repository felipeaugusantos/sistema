object frmRelConhecimentoFrete: TfrmRelConhecimentoFrete
  Left = 0
  Top = 0
  Caption = 'frmRelConhecimentoFrete'
  ClientHeight = 241
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelatorioConFre: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42412.696928946800000000
    ReportOptions.LastChange = 44657.566436504600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure pfrxChildPageHeader0OnAfterPrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  frxChildPageHeader0.Visible := False;'
      'end;'
      ''
      
        'procedure pmmo502378_18_DTADOCBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      '  If (<frxDadosConnhecimentoFrete."DTADOC"> = 0) Then'
      '    TfrxCustomMemoView(Sender).Text := '#39#39';'
      'end;'
      ''
      
        'procedure pmmo502378_21_VLRENTBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      '  If (<frxDadosConnhecimentoFrete."VLRENT"> = 0) Then'
      '    TfrxCustomMemoView(Sender).Text := '#39#39';'
      'end;'
      ''
      ''
      'Begin'
      ''
      '  frxChildPageHeader0.Visible := True;'
      ''
      'End.')
    Left = 80
    Top = 56
    Datasets = <
      item
        DataSet = frxDadosConnhecimentoFrete
        DataSetName = 'frxDadosConnhecimentoFrete'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object frxPage0: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      PrintIfEmpty = False
      object frxPageHeader0: TfrxPageHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        Child = frxRelatorioConFre.frxChildPageHeader0
        object mmoNomeEmpresa502378: TfrxMemoView
          Align = baCenter
          Left = 90.708903070000000000
          Width = 566.929133860000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOME_EMPRESA]')
          ParentFont = False
        end
        object mmoNomeRelatorio502378: TfrxMemoView
          Align = baCenter
          Left = 116.145115000000000000
          Top = 18.897637800000000000
          Width = 516.056710000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONHECIMENTOS DE FRETE')
          ParentFont = False
        end
        object mmoPagina502378: TfrxMemoView
          Align = baRight
          Left = 667.162710000000000000
          Width = 81.184230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [Page]')
          ParentFont = False
        end
        object mmoData502378: TfrxMemoView
          Align = baRight
          Left = 635.717070000000000000
          Top = 18.881880000000000000
          Width = 60.547990000000000000
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
          WordWrap = False
        end
        object mmoHora502378: TfrxMemoView
          Align = baRight
          Left = 696.265060000000000000
          Top = 18.881880000000000000
          Width = 52.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
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
      end
      object frxChildPageHeader0: TfrxChild
        FillType = ftBrush
        Height = 23.677192200000000000
        Top = 83.149660000000000000
        Width = 748.346940000000000000
        OnAfterPrint = 'pfrxChildPageHeader0OnAfterPrint'
        PrintChildIfInvisible = True
      end
      object frxHeader0: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 34.236220480000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object mmoFundoTitulo502378: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 34.236220480000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Top = 3.000000000000000000
          Width = 109.620000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 114.620000000000000000
          Top = 3.000000000000000000
          Width = 37.800000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'S'#201'RIE')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 157.420000000000000000
          Top = 3.000000000000000000
          Width = 56.700000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'DTA.EMI')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 219.120000000000000000
          Top = 3.000000000000000000
          Width = 378.000000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'FORNECEDOR')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 602.120000000000000000
          Top = 3.000000000000000000
          Width = 49.140000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'CLA.FIS')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 656.260000000000000000
          Top = 3.000000000000000000
          Width = 86.940000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.CON')
          WordWrap = False
        end
        object TfrxLineView
          Top = 18.118110240000000000
          Width = 748.440000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Top = 19.118110240000000000
          Width = 60.480000000000000000
          Height = 15.118110240000000000
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 65.480000000000000000
          Top = 19.118110240000000000
          Width = 567.000000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            
              'DUPLICATA                S'#201'RIE        VENCIMENTO                ' +
              '   VALOR')
          WordWrap = False
        end
      end
      object frxGroupHeader0NUMDOC: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 43.574830000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 748.346940000000000000
        Child = frxRelatorioConFre.frxChildHeaderTitulo0
        Condition = 'frxDadosConnhecimentoFrete."NUMDOC"'
        Stretched = True
        object NUMDOC502378: TfrxMemoView
          Top = 4.779530000000000000
          Width = 109.620000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object SERIEF502378: TfrxMemoView
          Left = 114.620000000000000000
          Top = 4.779530000000000000
          Width = 37.800000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."SERIEF"]')
          ParentFont = False
          WordWrap = False
        end
        object DTAENT502378: TfrxMemoView
          Left = 157.420000000000000000
          Top = 4.779530000000000000
          Width = 56.700000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object NOMFOR502378: TfrxMemoView
          Left = 219.120000000000000000
          Top = 4.779530000000000000
          Width = 378.000000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object CLFSC1502378: TfrxMemoView
          Left = 602.120000000000000000
          Top = 4.779530000000000000
          Width = 49.140000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."CLFSC1"]')
          ParentFont = False
          WordWrap = False
        end
        object VLCON1502378: TfrxMemoView
          Left = 656.260000000000000000
          Top = 4.779530000000000000
          Width = 86.940000000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."VLCON1"]')
          ParentFont = False
          WordWrap = False
        end
        object ESP502378: TfrxMemoView
          Top = 24.677180000000000000
          Width = 60.480000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."ESP"]')
          ParentFont = False
          WordWrap = False
        end
        object DUPLICATAS502378: TfrxMemoView
          Left = 65.480000000000000000
          Top = 24.677180000000000000
          Width = 287.314780000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."DUPLICATAS"]')
          ParentFont = False
        end
      end
      object frxChildHeaderTitulo0: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.118110240000000000
        ParentFont = False
        Top = 291.023810000000000000
        Width = 748.346940000000000000
        object Memo26: TfrxMemoView
          Top = 3.000000000000000000
          Width = 37.800000000000000000
          Height = 15.118110240000000000
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 42.800000000000000000
          Top = 3.000000000000000000
          Width = 109.620000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'DOCUME. DE COMPRA')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 157.420000000000000000
          Top = 3.000000000000000000
          Width = 37.800000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'S'#201'RIE')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 200.220000000000000000
          Top = 3.000000000000000000
          Width = 56.700000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'DTA.DOC')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 261.920000000000000000
          Top = 3.000000000000000000
          Width = 264.600000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'FORNECEDOR')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 531.520000000000000000
          Top = 3.000000000000000000
          Width = 49.140000000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'CLA.FIS')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 585.660000000000000000
          Top = 3.000000000000000000
          Width = 86.940000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.CON')
          WordWrap = False
        end
      end
      object frxMasterData0: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 13.228346460000000000
        ParentFont = False
        Top = 332.598640000000000000
        Width = 748.346940000000000000
        DataSet = frxDadosConnhecimentoFrete
        DataSetName = 'frxDadosConnhecimentoFrete'
        RowCount = 0
        object mmoZebra502378: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
        end
        object mmo502378_15_ESP: TfrxMemoView
          Width = 37.800000000000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."ESP1"]')
          WordWrap = False
        end
        object mmo502378_16_DOCENT: TfrxMemoView
          Left = 42.800000000000000000
          Width = 109.620000000000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."DOCENT"]')
          WordWrap = False
        end
        object mmo502378_17_SERIEE: TfrxMemoView
          Left = 157.420000000000000000
          Width = 37.800000000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."SERIEE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmo502378_18_DTADOC: TfrxMemoView
          Left = 200.220000000000000000
          Width = 56.700000000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'pmmo502378_18_DTADOCBeforePrint'
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."DTADOC"]')
          WordWrap = False
        end
        object mmo502378_19_FORENT: TfrxMemoView
          Left = 261.920000000000000000
          Width = 264.600000000000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."FORENT"]')
          WordWrap = False
        end
        object mmo502378_20_CLFSEN: TfrxMemoView
          Left = 531.520000000000000000
          Width = 49.140000000000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."CLFSEN"]')
          WordWrap = False
        end
        object mmo502378_21_VLRENT: TfrxMemoView
          Left = 585.660000000000000000
          Width = 86.940000000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'pmmo502378_21_VLRENTBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDadosConnhecimentoFrete."VLRENT"]')
          WordWrap = False
        end
      end
      object frxFooter0: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 28.456710000000000000
        ParentFont = False
        Top = 370.393940000000000000
        Width = 748.346940000000000000
        PrintChildIfInvisible = True
        object mmoLinhaFooterInicial502378: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object frxPageFooter0: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.897640240000000000
        ParentFont = False
        Top = 461.102660000000000000
        Width = 748.346940000000000000
        object mmoLinhaFinal502378: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mnoRelatorioEspecifico0502378: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 495.118430000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmRelConhecimentoFrete')
          ParentFont = False
          WordWrap = False
        end
        object mmoContaRegistro0502378: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Top = 2.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(frxMasterData0, 2)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxDadosConnhecimentoFrete: TfrxDBDataset
    UserName = 'frxDadosConnhecimentoFrete'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 184
    Top = 136
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 192
    Top = 56
  end
end
