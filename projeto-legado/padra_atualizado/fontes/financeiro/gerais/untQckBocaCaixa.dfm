object frmQckBocaCaixa: TfrmQckBocaCaixa
  Left = 0
  Top = 0
  ClientHeight = 144
  ClientWidth = 200
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
  object frxReciboBaixaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.900000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39692.403922164400000000
    ReportOptions.LastChange = 39703.357222754630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin  '
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllDataEmiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDataEmi.Text := '#39'EMISSAO: '#39' + FormatDateTime('#39'dd/mm/yyyy'#39',D' +
        'ate)+'#39'  '#39'+FormatDateTime('#39'hh:mm:ss'#39',Time);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 52
    Top = 20
    Datasets = <
      item
        DataSet = frxDados
        DataSetName = 'frxDados'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 152.929067899977000000
      PaperSize = 256
      OnAfterPrint = 'Page1OnAfterPrint'
      FontStyle = []
      object HeaderRecibo: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        OnAfterPrint = 'HeaderReciboOnAfterPrint'
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPCommand1OnBeforePrint'
          Command = '#27#64#15#27#80'
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."NOMCID"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."FONE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 85.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[IIF(Length(<frxDados."CNPJ">) > 0,'
            
              '    FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxDados."CNPJ">),' +
              #39#39')]'
            '')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."ENDERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."NOMEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 119.000000000000000000
          Width = 1161.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxDados."VENDEDOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'VENDEDOR:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDataEmi: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllDataEmiOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          HAlign = haRight
          Memo.UTF8W = (
            '[Date][Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'EMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 153.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'ITEM')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'UNID')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 153.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 153.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 153.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CNPJ:')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'I.E.S.:')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 85.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."IES"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object DetalheRecibo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'DetalheReciboOnBeforePrint'
        DataSet = frxDados
        DataSetName = 'frxDados'
        RowCount = 0
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."NUMDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAENT'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITEM'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."ITEM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDados."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRTOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object RodapeRecibo: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRTOT">,DetalheRecibo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRCOM">,DetalheRecibo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Sumario: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 340.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo17: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 51.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDados."NOMVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object RodapePagina: TfrxPageFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 425.000000000000000000
        Width = 1276.800000000000000000
        OnAfterPrint = 'PageFooter1OnAfterPrint'
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '  ')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '  ')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '  ')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDados: TfrxDBDataset
    Description = 'Dados do recibo'
    UserName = 'frxDados'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 132
    Top = 76
  end
  object frxReciboBaixaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39692.403922164400000000
    ReportOptions.LastChange = 42654.676132696800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllDataEmiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDataEmi.Text := '#39'EMISS'#195'O: '#39' + FormatDateTime('#39'dd/mm/yyyy'#39',D' +
        'ate)+'#39'  '#39'+FormatDateTime('#39'hh:mm:ss'#39',Time);'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 52
    Top = 76
    Datasets = <
      item
        DataSet = frxDados
        DataSetName = 'frxDados'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.500000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object HeaderRecibo: TfrxPageHeader
        FillType = ftBrush
        Height = 126.543290000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Left = 3.779527560000000000
          Top = 34.000000000000000000
          Width = 702.583920000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779527560000000000
          Top = 49.000000000000000000
          Width = 702.583920000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."FONE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 41.574827560000000000
          Top = 64.472480000000000000
          Width = 153.977240000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxDados."CNPJ">) > 0,'
            
              '    FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxDados."CNPJ">),' +
              ' '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779527560000000000
          Top = 19.000000000000000000
          Width = 482.796350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779527560000000000
          Top = 4.157480310000001000
          Width = 482.881452830000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 74.600000000000000000
          Top = 85.000000000000000000
          Width = 634.053370000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779527560000000000
          Top = 85.000000000000000000
          Width = 67.502350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 493.870497560000000000
          Top = 4.157480310000001000
          Width = 212.492950000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object rllDataEmi: TfrxMemoView
          Left = 493.652007560000000000
          Top = 18.779530000000000000
          Width = 212.711440000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllDataEmiOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date][Time]')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 103.165430000000000000
          Width = 710.551127400000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo8: TfrxMemoView
          Left = 3.645669290000000000
          Top = 105.944960000000000000
          Width = 86.929128979999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 106.228358660000000000
          Top = 105.944960000000000000
          Width = 56.692901180000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 167.385826770000000000
          Top = 105.944960000000000000
          Width = 287.039335910000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 457.984227560000000000
          Top = 105.944960000000000000
          Width = 28.346456690000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 528.866141730000000000
          Top = 105.944960000000000000
          Width = 49.133848500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 580.401574800000000000
          Top = 105.944960000000000000
          Width = 56.692908500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 641.385826770000000000
          Top = 105.944960000000000000
          Width = 71.811028500000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 490.803149610000000000
          Top = 105.944960000000000000
          Width = 32.881884880000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 1.889763780000000000
          Top = 81.149660000000000000
          Width = 714.330657400000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo10: TfrxMemoView
          Left = 3.779527560000000000
          Top = 64.472480000000000000
          Width = 34.015770000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 200.315090000000000000
          Top = 64.472480000000000000
          Width = 34.015770000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'I.E.S.:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 238.110390000000000000
          Top = 64.472480000000000000
          Width = 248.024550000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."IES"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DetalheRecibo: TfrxMasterData
        FillType = ftBrush
        Height = 13.220470000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        DataSet = frxDados
        DataSetName = 'frxDados'
        RowCount = 0
        object Memo18: TfrxMemoView
          Left = 2.779527560000000000
          Width = 102.047248980000000000
          Height = 13.220470000000000000
          DataField = 'NUMDOC'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 107.291338580000000000
          Width = 56.692901180000000000
          Height = 13.220470000000000000
          DataField = 'DTAENT'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 167.385826770000000000
          Width = 287.039335910000000000
          Height = 13.220470000000000000
          DataField = 'ITEM'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."ITEM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 456.984227560000000000
          Width = 28.346456690000000000
          Height = 13.220470000000000000
          DataField = 'UNIDAD'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 527.992101570000100000
          Width = 49.133848500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 580.220448030000000000
          Width = 56.692908500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 641.519660630000000000
          Width = 68.031498500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRCOM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 489.866117320000000000
          Width = 32.881884880000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object RodapeRecibo: TfrxFooter
        FillType = ftBrush
        Height = 22.614100000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        object Memo16: TfrxMemoView
          Left = 428.553000000000000000
          Top = 6.000000000000000000
          Width = 135.230920000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 571.220448030000000000
          Top = 6.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRTOT">,DetalheRecibo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 639.519660630000000000
          Top = 6.000000000000000000
          Width = 68.031498500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRCOM">,DetalheRecibo)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 1.889763780000000000
          Top = 3.338590000000011000
          Width = 714.330657400000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object FooterRecibo: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 404.409710000000000000
        Width = 718.110700000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 328.819110000000000000
        Width = 718.110700000000000000
        object Memo17: TfrxMemoView
          Left = 331.866249130000000000
          Top = 31.236240000000010000
          Width = 375.684910000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDados."NOMVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = True
    Left = 132
    Top = 20
  end
  object frxReciboBaixaJRetrato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39692.403922164400000000
    ReportOptions.LastChange = 42654.676132696800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllDataEmiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDataEmi.Text := '#39'EMISS'#195'O: '#39' + FormatDateTime('#39'dd/mm/yyyy'#39',D' +
        'ate)+'#39'  '#39'+FormatDateTime('#39'hh:mm:ss'#39',Time);'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 52
    Top = 128
    Datasets = <
      item
        DataSet = frxDados
        DataSetName = 'frxDados'
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
      object HeaderRecibo: TfrxPageHeader
        FillType = ftBrush
        Height = 126.543290000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Left = 3.779527560000000000
          Top = 34.000000000000000000
          Width = 702.583920000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779527560000000000
          Top = 49.000000000000000000
          Width = 702.583920000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."FONE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 41.574827560000000000
          Top = 64.472480000000000000
          Width = 153.977240000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[IIF(Length(<frxDados."CNPJ">) > 0,'
            
              '    FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxDados."CNPJ">),' +
              ' '#39#39')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779527560000000000
          Top = 19.000000000000000000
          Width = 482.796350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779527560000000000
          Top = 4.157480310000001000
          Width = 482.881452830000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 74.600000000000000000
          Top = 85.000000000000000000
          Width = 634.053370000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779527560000000000
          Top = 85.000000000000000000
          Width = 67.502350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 493.870497560000000000
          Top = 4.157480310000001000
          Width = 212.492950000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object rllDataEmi: TfrxMemoView
          Left = 493.652007560000000000
          Top = 18.779530000000000000
          Width = 212.711440000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllDataEmiOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date][Time]')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 103.165430000000000000
          Width = 710.551127400000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo8: TfrxMemoView
          Left = 3.779527560000000000
          Top = 105.944960000000000000
          Width = 75.590538980000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 83.228358660000000000
          Top = 105.944960000000000000
          Width = 56.692901180000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 143.828358660000000000
          Top = 105.944960000000000000
          Width = 290.818865910000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 438.984227560000000000
          Top = 105.944960000000000000
          Width = 28.346456690000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 513.992101570000000000
          Top = 105.944960000000000000
          Width = 52.913378500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 571.220448030000000000
          Top = 105.944960000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 639.519660630000000000
          Top = 105.944960000000000000
          Width = 68.031498500000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 470.866117320000000000
          Top = 105.944960000000000000
          Width = 40.440944880000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 1.889763780000000000
          Top = 81.149660000000000000
          Width = 714.330657400000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo10: TfrxMemoView
          Left = 3.779527560000000000
          Top = 64.472480000000000000
          Width = 34.015770000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 200.315090000000000000
          Top = 64.472480000000000000
          Width = 34.015770000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'I.E.S.:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 238.110390000000000000
          Top = 64.472480000000000000
          Width = 248.024550000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."IES"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DetalheRecibo: TfrxMasterData
        FillType = ftBrush
        Height = 13.220470000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        DataSet = frxDados
        DataSetName = 'frxDados'
        RowCount = 0
        object Memo18: TfrxMemoView
          Left = 3.779527560000000000
          Width = 75.590538980000000000
          Height = 13.220470000000000000
          DataField = 'NUMDOC'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 83.600000000000000000
          Width = 56.692901180000000000
          Height = 13.220470000000000000
          DataField = 'DTAENT'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 144.200000000000000000
          Width = 290.818865910000000000
          Height = 13.220470000000000000
          DataField = 'ITEM'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."ITEM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 438.984227560000000000
          Width = 28.346456690000000000
          Height = 13.220470000000000000
          DataField = 'UNIDAD'
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDados."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 513.992101570000000000
          Width = 52.913378500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 571.220448030000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 639.519660630000000000
          Width = 68.031498500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."VLRCOM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 470.866117320000000000
          Width = 40.440944880000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDados."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object RodapeRecibo: TfrxFooter
        FillType = ftBrush
        Height = 22.614100000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        object Memo16: TfrxMemoView
          Left = 428.553000000000000000
          Top = 6.000000000000000000
          Width = 135.230920000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 571.220448030000000000
          Top = 6.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DataSet = frxDados
          DataSetName = 'frxDados'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRTOT">,DetalheRecibo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 639.519660630000000000
          Top = 6.000000000000000000
          Width = 68.031498500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDados."VLRCOM">,DetalheRecibo)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 1.889763780000000000
          Top = 3.338590000000011000
          Width = 714.330657400000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object FooterRecibo: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 404.409710000000000000
        Width = 718.110700000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 328.819110000000000000
        Width = 718.110700000000000000
        object Memo17: TfrxMemoView
          Left = 331.866249130000000000
          Top = 31.236240000000010000
          Width = 375.684910000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDados."NOMVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
