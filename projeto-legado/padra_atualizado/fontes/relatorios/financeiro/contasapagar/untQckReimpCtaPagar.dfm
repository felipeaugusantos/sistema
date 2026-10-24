object frmQckReimpCtaPagar: TfrmQckReimpCtaPagar
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 253
  Width = 324
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 89
    Top = 70
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    OnGetValue = frxGenGetValue
    Left = 139
    Top = 70
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 32
    Top = 70
  end
  object frxReciboM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42997.707318553200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 17 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReciboMUserFunction
    Left = 84
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
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
    object Pagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object rllNomEmp: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 34.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE DOCUMENTOS BAIXADOS')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#18#27#80#15#27#77'
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllNomCli: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
        object rllCodCli: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FONE / FAX:')
          TruncOutboundText = False
        end
        object rllFone01: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NUM. DOC.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. VCTO.')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          TruncOutboundText = False
        end
        object rllFax: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1459.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. PGTO.')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          TruncOutboundText = False
        end
        object rllHist01: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."DTAPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1526.400000000000000000
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object rllAssinatura: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
          TruncOutboundText = False
        end
        object rllRiscoAssinatura: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '_______________________________________________')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllTotValDup: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object rllTotValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 68.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 238.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CUmCheque
        PrintChildIfInvisible = True
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReciboM.Page1
        end
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 255.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CVariosCheques
        PrintChildIfInvisible = True
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 68.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 393.699745735580900000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1488.000000000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 85.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDatasetChqEmi: TfrxDBDataset
    UserName = 'frxDatasetChqEmi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 140
    Top = 128
  end
  object frxReciboJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42997.640509224540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 70 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReciboMUserFunction
    Left = 20
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
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
    object Pagina: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 103.866110000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object Shape1: TfrxShapeView
          Align = baBottom
          Left = 3.000000000000000000
          Top = 86.858235980000000000
          Width = 1096.063700000000000000
          Height = 17.007874020000000000
          Fill.BackColor = clSilver
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 185.046105000000000000
          Top = 5.661410000000000000
          Width = 725.971490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 817.889610000000000000
          Top = 5.661410000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA')
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 171.817750000000000000
          Top = 27.661410000000000000
          Width = 752.428200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE DOCUMENTOS BAIXADOS')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 758.248670000000000000
          Top = 27.661410000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
        end
        object Memo5: TfrxMemoView
          Left = 8.600000000000000000
          Top = 44.661409999999990000
          Width = 103.256710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNomCli: TfrxMemoView
          Left = 203.565430000000000000
          Top = 44.661409999999990000
          Width = 350.891280000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 193.662770000000000000
          Top = 44.661409999999990000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCodCli: TfrxMemoView
          Left = 118.374520000000000000
          Top = 44.661409999999990000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 8.600000000000000000
          Top = 61.661410000000000000
          Width = 82.922820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FONE / FAX:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFone01: TfrxMemoView
          Left = 93.563760000000000000
          Top = 61.661410000000000000
          Width = 104.466110000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 5.820470000000000000
          Top = 86.929116769999990000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M.DOC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 108.333890000000000000
          Top = 86.929116769999990000
          Width = 84.359060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 529.025170000000000000
          Top = 86.929116769999990000
          Width = 92.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. VCTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 724.166941340000000000
          Top = 86.929116769999990000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 1001.952785200000000000
          Top = 86.929116769999990000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFax: TfrxMemoView
          Left = 211.711750000000000000
          Top = 61.661410000000000000
          Width = 100.686580000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 200.070810000000000000
          Top = 61.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 965.669140000000000000
          Top = 27.661410000000000000
          Width = 57.902350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
        end
        object TotalPages: TfrxMemoView
          Left = 1005.330550000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
        end
        object Memo4: TfrxMemoView
          Left = 994.171490000000000000
          Top = 5.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
        end
        object Page: TfrxMemoView
          Left = 972.971490000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
        object Memo1: TfrxMemoView
          Left = 626.567410000000000000
          Top = 86.929190000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. PGTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 820.378480000000000000
          Top = 86.929116769999990000
          Width = 86.551178660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 907.307670000000000000
          Top = 86.929190000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 45.354347800000000000
        Top = 230.551330000000000000
        Width = 1096.063700000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxMemoView
          Left = 5.820470000000000000
          Width = 99.779530000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllHist01: TfrxMemoView
          Left = 106.554360000000000000
          Width = 419.754360000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaVen: TfrxMemoView
          Left = 529.025170000000000000
          Width = 92.522820000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValDup: TfrxMemoView
          Left = 724.015770000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValRec: TfrxMemoView
          Left = 1001.952785200000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 626.567410000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DTAPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 820.378477560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 911.087197560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object sdinheiro3: TfrxShapeView
          Left = 3.779530000000000000
          Top = 26.456710000000000000
          Width = 527.244126220000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object svalor3: TfrxShapeView
          Left = 530.890230000000000000
          Top = 26.456710000000000000
          Width = 128.881899530000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object mvalor1: TfrxMemoView
          Left = 535.252036850000000000
          Top = 31.015770000000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object sportador3: TfrxShapeView
          Left = 659.527559055118100000
          Top = 26.456710000000000000
          Width = 434.645842600000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object mportador1: TfrxMemoView
          Left = 665.858331180000000000
          Top = 30.236240000000000000
          Width = 30.236220470000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object sdinheiro4: TfrxShapeView
          Left = 8.677180000000000000
          Top = 30.236240000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object mdinheiro2: TfrxMemoView
          Left = 25.897650000000000000
          Top = 30.236240000000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dinheiro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memVlrDinheiro: TfrxMemoView
          Left = 568.709030000000000000
          Top = 31.236240000000000000
          Width = 86.929138740000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object memPortDinheiro: TfrxMemoView
          Left = 700.070888110000000000
          Top = 30.236240000000000000
          Width = 385.511998980000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object mdinheiro1: TfrxMemoView
          Left = 9.000000000000000000
          Top = 30.015770000000000000
          Width = 11.338590000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'X')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 498.897960000000000000
        Width = 1096.063700000000000000
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllAssinatura: TfrxMemoView
          Left = 288.000000000000000000
          Top = 47.000000000000000000
          Width = 94.261410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
        end
        object rllRiscoAssinatura: TfrxMemoView
          Left = 384.302350000000000000
          Top = 47.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '_______________________________________________')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 4.800000000000000000
          Top = 8.000000000000000000
          Width = 712.138900000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValDup: TfrxMemoView
          Left = 716.607881340000000000
          Top = 8.000000000000000000
          Width = 97.889768660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValRec: TfrxMemoView
          Left = 994.393725200000000000
          Top = 8.000000000000000000
          Width = 97.889768660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 812.819420000000000000
          Top = 8.000000000000000000
          Width = 94.110238660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 907.307670000000000000
          Top = 8.000000000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 4.800000000000000000
          Top = 7.559059999999988000
          Width = 1088.504640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo40: TfrxMemoView
          Left = 835.276130000000000000
          Top = 45.354360000000000000
          Width = 253.001670000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 1.944960000000000000
        Top = 298.582870000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CUmCheque
        PrintChildIfInvisible = True
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 1096.063700000000000000
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 325.039580000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CVariosCheques
        PrintChildIfInvisible = True
        object rllBanco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.747990000000020000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object rllAgencia: TfrxMemoView
          Left = 339.740260000000000000
          Top = 22.747990000000020000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object rllConta: TfrxMemoView
          Left = 535.850650000000000000
          Top = 22.747990000000020000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object rllFavorecido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.425169999999980000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object rllBomPara: TfrxMemoView
          Left = 535.889920000000000000
          Top = 45.425169999999980000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object rllCodBco: TfrxMemoView
          Left = 53.692950000000000000
          Top = 22.747990000000020000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object rllNumAge: TfrxMemoView
          Left = 400.992270000000000000
          Top = 22.747990000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
        end
        object rllConCor: TfrxMemoView
          Left = 584.764070000000000000
          Top = 22.747990000000020000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
        end
        object rllFacore: TfrxMemoView
          Left = 83.929190000000000000
          Top = 45.425169999999980000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
        end
        object rllDtaBom: TfrxMemoView
          Left = 609.480520000000000000
          Top = 45.425169999999980000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
        end
        object rllCheque: TfrxMemoView
          Left = 786.299630000000000000
          Top = 22.747990000000020000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object rllNumChq: TfrxMemoView
          Left = 842.992580000000000000
          Top = 22.747990000000020000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.291279999999972000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 786.299630000000000000
          Top = 45.425169999999980000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 844.110700000000000000
          Top = 45.425169999999980000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
        end
        object rllDadChq: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.291279999999972000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 415.748300000000000000
        Width = 1096.063700000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReciboJ.Page1
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 339.740260000000000000
          Top = 24.236240000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 535.850650000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 46.913420000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 535.889920000000000000
          Top = 46.913420000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 53.692950000000000000
          Top = 24.236240000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 400.992270000000000000
          Top = 24.236240000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 584.764070000000000000
          Top = 24.236240000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 83.929190000000000000
          Top = 46.913420000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 609.480520000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 786.299630000000000000
          Top = 24.236240000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 842.992580000000000000
          Top = 24.236240000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 786.299630000000000000
          Top = 46.913420000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 844.110700000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 943.662030000000000000
          Top = 46.354360000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 987.236860000000000000
          Top = 46.354360000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.000000000000000000
          Top = 71.811070000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
