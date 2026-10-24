inherited frmRelEntConferencia: TfrmRelEntConferencia
  Left = 378
  Top = 360
  Width = 302
  Height = 143
  Caption = 'Relat'#243'rio de Confer'#234'ncia de Entrada'
  ExplicitWidth = 302
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 88
    Width = 296
    ExplicitTop = 88
    ExplicitWidth = 296
    inherited FlwBotoes: TFlowPanel
      Width = 215
      ExplicitTop = 2
      ExplicitWidth = 215
    end
    inherited btnSair: TBitBtnLocked
      Left = 217
      ExplicitLeft = 217
    end
  end
  inherited pnlDados: TPanel
    Width = 296
    Height = 88
    ExplicitWidth = 296
    ExplicitHeight = 88
    inherited gpbDestino: TGroupBox
      Left = 145
      Top = 6
      Height = 73
      TabOrder = 1
      ExplicitLeft = 145
      ExplicitTop = 6
      ExplicitHeight = 73
    end
    object rdgOpcao: TRadioGroup
      Left = 6
      Top = 6
      Width = 137
      Height = 73
      Caption = 'Mostrar os itens'
      ItemIndex = 0
      Items.Strings = (
        'Incosistentes'
        'Todos')
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 88
    Width = 296
    Height = 0
    ExplicitTop = 88
    ExplicitWidth = 296
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 125
      Height = 0
      ExplicitLeft = 125
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 125
      Height = 0
      ExplicitWidth = 125
      ExplicitHeight = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 368
    Top = 40
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 304
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 456
    Top = 72
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 424
    Top = 72
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 392
    Top = 72
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 360
    Top = 72
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 256
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 328
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
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
      'procedure DMPMemo3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;         ' +
        '                                                       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 16
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
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
        Top = 221.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object frxdbCriticasCODITE: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasDESITE: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDITE: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDCON: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxdbCriticas."LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 170.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIG')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.PEDIDO')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.CONFER.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD. FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDOS')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERE')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
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
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOJA:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LOJA]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 85.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CONFERENTE]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CONFERENTE:')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42181.575710439810000000
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
      'procedure Memo14OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 96
    Top = 8
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236220472440940000
        ParentFont = False
        Top = 245.669450000000000000
        Width = 730.204700012278100000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Width = 730.204724410000000000
          Height = 30.236220472440940000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 217.094620000000000000
          Width = 510.236550000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 347.716760000000000000
          Top = 15.000000000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 555.590910000000000000
          Top = 15.000000000000000000
          Width = 79.370073860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 638.740570000000000000
          Top = 15.000000000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 52.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 467.661720000000000000
          Top = 15.000000000000000000
          Width = 83.149603860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo18OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          WordWrap = False
        end
        object rllLocFis: TfrxMemoView
          Left = 389.291590000000000000
          Top = 15.000000000000000000
          Width = 71.811048030000000000
          Height = 15.118120000000000000
          OnAfterPrint = 'rllLocFisOnAfterPrint'
          OnBeforePrint = 'Memo21OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."LOCFIS"]')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 147.401670000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 336.378170000000000000
        Width = 730.204700012278100000
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
          Left = 370.922820000000000000
          Top = 17.000000000000000000
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
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 204.094620000000000000
        Width = 730.204700012278100000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 729.449289999999900000
          Height = 15.874015750000000000
          Fill.BackColor = clSilver
        end
        object Memo11: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo12: TfrxMemoView
          Left = 216.874054800000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
        end
        object Memo13: TfrxMemoView
          Left = 347.716759999999900000
          Width = 34.015770000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo14: TfrxMemoView
          Left = 556.031849999999900000
          Width = 75.590543860000010000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PEDIDO')
        end
        object Memo15: TfrxMemoView
          Left = 638.740570000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. CONFER.'
            ''
            '')
        end
        object Memo17: TfrxMemoView
          Left = 52.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.FABRICA')
        end
        object Memo19: TfrxMemoView
          Left = 467.661720000000000000
          Width = 83.149603860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO EST.')
        end
        object Memo20: TfrxMemoView
          Left = 389.291590000000000000
          Width = 71.811069999999990000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISI.')
        end
        object Memo22: TfrxMemoView
          Left = 147.401670000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'REFERE')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 122.779530000000000000
        Top = 18.897650000000000000
        Width = 730.204700012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 0.302350006139050000
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
          Left = 120.302350006139100000
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
          Left = 610.922820000000000000
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
          Left = 658.922820000000000000
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
          Left = 507.666110000000000000
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
          Left = 3.779530000000000000
          Top = 51.000000000000000000
          Width = 498.822140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 122.606370000000000000
          Width = 730.204700012278100000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 105.826840000000000000
          Top = 69.031540000000010000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOJA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 105.826840000000000000
          Top = 86.929190000000000000
          Width = 479.924490000000000000
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
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.811070000000000000
          Width = 71.735249999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOJA:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 105.606370000000000000
          Top = 104.826840000000000000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONFERENTE]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.559060000000000000
          Top = 104.826840000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONFERENTE:')
          ParentFont = False
        end
      end
    end
  end
  object frxdbCriticas: TfrxDBDataset
    UserName = 'frxdbCriticas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 48
  end
  object frxReportJMotorola: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41960.597684004600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  //rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  //rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure Memo14OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 584
    Top = 144
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 79.375000000000000000
      PaperHeight = 86.783333330000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 60.472480000000000000
        Width = 262.204893750000000000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Left = -208.000000000000000000
          Width = 729.449290000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 41.354360000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 131.031850000000000000
          Width = 58.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 188.740570000000000000
          Width = 70.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 42.133890000000000000
          Width = 86.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 262.204893750000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 262.000000000000000000
          Height = 15.874015750000000000
          Fill.BackColor = clSilver
        end
        object Memo11: TfrxMemoView
          Width = 37.574830000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'COD.')
        end
        object Memo14: TfrxMemoView
          Left = 131.031850000000000000
          Width = 58.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PED.')
        end
        object Memo15: TfrxMemoView
          Left = 188.740570000000000000
          Top = 1.000000000000000000
          Width = 70.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. CONF.')
        end
        object Memo17: TfrxMemoView
          Left = 42.133890000000000000
          Width = 86.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.FABRICA')
        end
      end
    end
  end
  object frxReportM_Modelo2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
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
      'procedure DMPMemo3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;         ' +
        '                                                       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 104
    Top = 56
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
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
        Top = 221.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object frxdbCriticasCODITE: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasDESITE: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDITE: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDCON: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDXML"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 170.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIG')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.PEDIDO')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.CONFER.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD. FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. NFE')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERE')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
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
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOJA:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LOJA]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 85.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CONFERENTE]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CONFERENTE:')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ_Modelo2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39988.653113425900000000
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
      'procedure Memo14OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 24
    Top = 56
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236220470000000000
        ParentFont = False
        Top = 249.448980000000000000
        Width = 730.204700012278100000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Width = 730.204724409449000000
          Height = 30.236220470000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 229.433210000000000000
          Width = 495.118430000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 415.748300000000000000
          Top = 15.000000000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 548.031850000000000000
          Top = 15.000000000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 638.740570000000000000
          Top = 15.000000000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 50.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 457.323130000000000000
          Top = 15.000000000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDXML"]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 143.622140000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.157700000000000000
        Width = 730.204700012278100000
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
          Left = 370.922820000000000000
          Top = 17.000000000000000000
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
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 207.874150000000000000
        Width = 730.204700012278100000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 729.449290000000000000
          Height = 15.874015750000000000
          Fill.BackColor = clSilver
        end
        object Memo11: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo12: TfrxMemoView
          Left = 231.433114800000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
        end
        object Memo13: TfrxMemoView
          Left = 415.748300000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo14: TfrxMemoView
          Left = 548.031850000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PEDIDO')
        end
        object Memo15: TfrxMemoView
          Left = 638.740570000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. CONFER.'
            '')
        end
        object Memo17: TfrxMemoView
          Left = 50.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.FABRICA')
        end
        object Memo19: TfrxMemoView
          Left = 457.323130000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE. NFE')
        end
        object Memo21: TfrxMemoView
          Left = 147.401670000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'REFERE')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 126.559060000000000000
        Top = 18.897650000000000000
        Width = 730.204700012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 0.302350006139050000
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
          Left = 120.302350006139100000
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
          Left = 610.922820000000000000
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
          Left = 658.922820000000000000
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
          Left = 507.666110000000000000
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
          Left = 3.779530000000000000
          Top = 51.000000000000000000
          Width = 498.822140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 125.606370000000000000
          Width = 730.204700012278100000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 105.826840000000000000
          Top = 69.031540000000000000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOJA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 105.826840000000000000
          Top = 86.929190000000000000
          Width = 479.924490000000000000
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
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.811070000000000000
          Width = 71.735250000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOJA:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 105.826840000000000000
          Top = 105.826840000000000000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONFERENTE]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 105.826840000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONFERENTE:')
          ParentFont = False
        end
      end
    end
  end
  object frxReportJ_Modelo3: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43224.479980636580000000
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
      'procedure Memo14OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 136
    Top = 65520
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236220470000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 730.204700012278100000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Width = 730.204724409448800000
          Height = 30.236220472440940000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 228.535560000000000000
          Width = 498.897960000000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 438.425480000000000000
          Top = 15.000000000000000000
          Width = 26.456688030000000000
          Height = 15.118120000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 555.590910000000000000
          Top = 15.000000000000000000
          Width = 79.370073860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 638.740570000000000000
          Top = 15.000000000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 51.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 467.661720000000000000
          Top = 15.000000000000000000
          Width = 83.149603860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo18OnBeforePrint'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 147.401670000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 343.937230000000000000
        Width = 730.204700012278100000
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
          Left = 370.922820000000000000
          Top = 17.000000000000000000
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
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 211.653680000000000000
        Width = 730.204700012278100000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 729.449289999999900000
          Height = 15.874015750000000000
          Fill.BackColor = clSilver
        end
        object Memo11: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo12: TfrxMemoView
          Left = 228.535464800000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
        end
        object Memo13: TfrxMemoView
          Left = 438.425480000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo14: TfrxMemoView
          Left = 556.031849999999900000
          Width = 75.590543860000010000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PEDIDO')
        end
        object Memo15: TfrxMemoView
          Left = 638.740570000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo14OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. CONFER.'
            ''
            '')
        end
        object Memo17: TfrxMemoView
          Left = 51.133890000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.FABRICA')
        end
        object Memo19: TfrxMemoView
          Left = 467.661720000000000000
          Width = 83.149603860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO EST.')
        end
        object Memo21: TfrxMemoView
          Left = 147.401670000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'REFERE')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 130.338590000000000000
        Top = 18.897650000000000000
        Width = 730.204700012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 0.302350006139050000
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
          Left = 120.302350006139100000
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
          Left = 610.922820000000000000
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
          Left = 658.922820000000000000
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
          Left = 507.666110000000000000
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
          Left = 3.779530000000000000
          Top = 51.000000000000000000
          Width = 498.822140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 129.606370000000000000
          Width = 730.204700012278100000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 105.826840000000000000
          Top = 69.031540000000010000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOJA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 105.826840000000000000
          Top = 86.929190000000000000
          Width = 479.924490000000000000
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
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.811070000000000000
          Width = 71.735249999999990000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOJA:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 106.047310000000000000
          Top = 106.826840000000000000
          Width = 479.924490000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONFERENTE]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 4.000000000000000000
          Top = 106.826840000000000000
          Width = 98.191960000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONFERENTE:')
          ParentFont = False
        end
      end
    end
  end
  object frxReportM_Modelo3: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
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
      'procedure DMPMemo3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Visible := blnMostraQuantidades;         ' +
        '                                                       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 216
    Top = 65528
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
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
        Top = 221.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object frxdbCriticasCODITE: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasDESITE: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDITE: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDCON: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxdbCriticas."REFERE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 170.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIG')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.PEDIDO')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.CONFER.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD. FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDOS')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERE')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
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
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOJA:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LOJA]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 85.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CONFERENTE]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CONFERENTE:')
          TruncOutboundText = False
        end
      end
    end
  end
end
