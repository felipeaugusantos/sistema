object frmQckReciboCtaReceber: TfrmQckReciboCtaReceber
  Left = 0
  Top = 0
  ClientHeight = 181
  ClientWidth = 408
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
  object frxReciboCtr_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Compressed = True
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 43201.446007349540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValDoc: Double;'
      '  fltValJur: Double;'
      '  fltValDes: Double;'
      '  fltValRec: Double;'
      '//  fltValCre: Double;                                         '
      '  '
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(rllFone01.Text) = '#39#39') then'
      '    rllFone01.Text := '#39#39'  '
      '  else                     '
      
        '    rllFone01.Text := fFormataFonePaisInterna(rllFone01.Text);  ' +
        '      '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(rllFax.Text) = '#39#39') then'
      '    rllFax.Text := '#39#39'  '
      '  else                     '
      '    rllFax.Text := fFormataFonePaisInterna(rllFax.Text);      '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValDoc:= 0;'
      '  fltValJur:= 0;'
      '  fltValDes:= 0;'
      '  fltValRec:= 0;'
      'end;'
      ''
      'procedure rlbMasterOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDataset."DUPLICATA_TROCO"> = '#39'S'#39') then'
      '      Exit;                                '
      '    '
      '  fltValDoc := fltValDoc + <frxDataset."VALDOC">;'
      '  fltValJur := fltValJur + <frxDataset."VALJUR">;'
      '  fltValDes := fltValDes + <frxDataset."VALDES">;'
      '  fltValRec := fltValRec + <frxDataset."VALREC">;'
      
        '                                                                ' +
        '             '
      'end;   '
      ''
      'begin'
      ''
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxReciboCtr_MUserFunction
    Left = 40
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
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
      PaperWidth = 337.819781824724200000
      PaperHeight = 184.414464232325200000
      PaperSize = 256
      HGuides.Strings = (
        '221')
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        object rllNomEmp: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1056.000000000000000000
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
          Align = baCenter
          Left = 326.400000000000000000
          Top = 34.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DTEMISSAO]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[RECEBIDO]')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'rlbMasterOnBeforePrint'
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
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object rllHist01: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."HIST01"] [frxDataset."HIST02"]')
          TruncOutboundText = False
        end
        object rllNosNum: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NOSNUM'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDataset."DTAREC"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          TruncOutboundText = False
        end
        object rllValDes: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          TruncOutboundText = False
        end
        object rllValJur: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 119.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxDataset."CODCLI"'
        StartNewPage = True
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE:')
          TruncOutboundText = False
        end
        object rllNomCli: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."CODCLI"] - [frxDataset."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FONE / FAX:')
          TruncOutboundText = False
        end
        object rllFone01: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataField = 'FONE01'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FONE01"]')
          TruncOutboundText = False
        end
        object rllFax: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataField = 'F_A_X_'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."F_A_X_"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 357.000000000000000000
        Width = 1276.800000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TOTALGERAL]')
          TruncOutboundText = False
        end
        object rllTotValDup: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltValDoc]')
          TruncOutboundText = False
        end
        object rllTotValDes: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltValDes]')
          TruncOutboundText = False
        end
        object rllTotValJur: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltValJur]')
          TruncOutboundText = False
        end
        object rllTotValRec: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fltValRec]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object TOTDINHEIRO: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'DINHEIRO: [<frxDataset."CTR_DINHEI">]')
          TruncOutboundText = False
        end
        object TOTCHEQUE: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            ' [<frxDataset."CTR_CHQAVI">]')
          TruncOutboundText = False
        end
        object TOTCHEQUEPRE: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '       CHEQUE PRE: [<frxDataset."CTR_CHQPRE">]')
          TruncOutboundText = False
        end
        object TOTCARTAO: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '  CARTAO: [<frxDataset."CTR_CARTAO">]')
          TruncOutboundText = False
        end
        object TOTORDEMPGTO: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            ' [<frxDataset."CTR_ORDPAG">]')
          TruncOutboundText = False
        end
        object TOTCRED: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 85.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'CREDITO UTILIZADO: [<frxDataset."CTR_CREDITO">]')
          TruncOutboundText = False
        end
        object rlbOrdemPagamento: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 85.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'ORDEM DE PGTO: [<frxDataset."CTR_ORDPAG">]')
          TruncOutboundText = False
        end
        object rblCheque: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE:')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object TOTBOLETO: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'BOLETO: [<frxDataset."VALOR_BOLETO">]')
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 170.000000000000000000
        Width = 1276.800000000000000000
        Condition = 'frxDataset."SEQCON"'
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOSSONUMER]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[DTAREC]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object rllSeqBaixa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."SEQCON"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 51.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[EMP]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 51.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1276.800000000000000000
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TOTAL POR SEQUENCIAL DE BAIXA:')
          TruncOutboundText = False
        end
        object rllTotalDocSeqBaixa: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALDOC">,rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALDES">,rlbMaster)]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALJUR">,rlbMaster)]')
          TruncOutboundText = False
        end
        object rllTotalRecSeqBaixa: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALREC">,rlbMaster)]')
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 527.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMPRESA:[CODEMP]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PORTADOR:[CODPOR]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPERADOR:[CODOPE]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HIST'#211'RICO:[HISTOR]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Align = baCenter
          Left = 355.200000000000000000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:_______________________________________________')
          TruncOutboundText = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 680.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo32: TfrxDMPMemoView
          Align = baCenter
          Left = 355.200000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:_______________________________________________')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[CAIXA]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReciboCtr_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42698.727234884260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValDoc: Double;'
      '  fltValJur: Double;'
      '  fltValDes: Double;'
      '  fltValRec: Double;'
      '  '
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(rllFone01.Text) = '#39#39') then'
      '    rllFone01.Text := '#39#39'  '
      '  else                     '
      
        '    rllFone01.Text := fFormataFonePaisInterna(rllFone01.Text);  ' +
        '      '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(rllFax.Text) = '#39#39') then'
      '    rllFax.Text := '#39#39'  '
      '  else                     '
      '    rllFax.Text := fFormataFonePaisInterna(rllFax.Text);      '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValDoc:= 0;'
      '  fltValJur:= 0;'
      '  fltValDes:= 0;'
      '  fltValRec:= 0;'
      'end;'
      ''
      'procedure rlbMasterOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDataset."DUPLICATA_TROCO"> = '#39'S'#39') then'
      '      Exit;                    '
      '                          '
      '  fltValDoc := fltValDoc + <frxDataset."VALDOC">;'
      '  fltValJur := fltValJur + <frxDataset."VALJUR">;'
      '  fltValDes := fltValDes + <frxDataset."VALDES">;'
      '  fltValRec := fltValRec + <frxDataset."VALREC">;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxReciboCtr_MUserFunction
    Left = 128
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      HGuides.Strings = (
        '570,70903'
        '359,05535'
        '291,02381'
        '272,12616')
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 16.000000000000000000
        Width = 755.906000000000000000
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 292.762710000000000000
          Top = 16.661410000000000000
          Width = 170.380580000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 614.642300000000000000
          Top = 15.661410000000000000
          Width = 80.655040000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [DTEMISSAO]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 699.676870000000000000
          Top = 15.661410000000000000
          Width = 50.343290000000010000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 198.274460000000000000
          Top = 2.661410000000000000
          Width = 359.357080000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 669.062770000000000000
          Top = 1.661410000000000000
          Width = 28.875510000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 730.779220000000000000
          Top = 1.661410000000000000
          Width = 19.200000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 720.620160000000000000
          Top = 1.661410000000000000
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
          Left = 699.420160000000000000
          Top = 1.661410000000000000
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
        object Memo1: TfrxMemoView
          Left = 530.661719999999900000
          Top = 15.661410000000000000
          Width = 84.434570000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [RECEBIDO]')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 13.220470000000000000
        Top = 224.000000000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbMasterOnBeforePrint'
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxMemoView
          Left = 0.779530000000000000
          Width = 104.314960630000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllHist01: TfrxMemoView
          Left = 106.877180000000000000
          Width = 119.055088820000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."HIST01"] [frxDataset."HIST02"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNosNum: TfrxMemoView
          Left = 285.603030000000000000
          Width = 91.388930000000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 378.591960000000000000
          Width = 58.507050000000000000
          Height = 13.220470000000000000
          DataField = 'DTAVEN'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDup: TfrxMemoView
          Left = 499.960420000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDes: TfrxMemoView
          Left = 565.365120000000000000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValJur: TfrxMemoView
          Left = 626.769820000000000000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 689.174520000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 439.071120000000000000
          Top = 0.118120000000004700
          Width = 58.507050000000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 226.992270000000000000
          Width = 25.700784960000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 254.228510000000000000
          Width = 29.480314960000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015733390000000000
        Top = 112.000000000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxDataset."CODCLI"'
        StartNewPage = True
        object Memo5: TfrxMemoView
          Left = 1.779530000000000000
          Top = 3.779529999999994000
          Width = 76.800000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object rllNomCli: TfrxMemoView
          Left = 80.730711099999990000
          Top = 3.779529999999994000
          Width = 626.796970000000000000
          Height = 13.220470000000000000
          AutoWidth = True
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODCLI"] - [frxDataset."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 1.779530000000000000
          Top = 19.779530000000040000
          Width = 76.800000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FONE / FAX:')
          ParentFont = False
        end
        object rllFone01: TfrxMemoView
          Left = 80.730711099999990000
          Top = 19.779530000000040000
          Width = 104.466110000000000000
          Height = 13.220470000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataField = 'FONE01'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FONE01"]')
          ParentFont = False
        end
        object rllFax: TfrxMemoView
          Left = 199.042461100000000000
          Top = 19.779530000000040000
          Width = 100.686580000000000000
          Height = 13.220470000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataField = 'F_A_X_'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."F_A_X_"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 186.968466100000000000
          Top = 19.779530000000040000
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
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 86.929190000000000000
        Top = 292.000000000000000000
        Width = 755.906000000000000000
        object Line3: TfrxLineView
          Left = 0.779530000000000000
          Top = 7.559059999999988000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 0.779530000000000000
          Top = 24.559059999999990000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo21: TfrxMemoView
          Left = 256.082190000000000000
          Top = 10.059059999999990000
          Width = 194.343290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTALGERAL]')
          ParentFont = False
        end
        object rllTotValDup: TfrxMemoView
          Left = 460.960420000000000000
          Top = 10.059059999999990000
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
            '[fltValDoc]')
          ParentFont = False
        end
        object rllTotValDes: TfrxMemoView
          Left = 526.365120000000100000
          Top = 10.059059999999990000
          Width = 60.094485750000000000
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
            '[fltValDes]')
          ParentFont = False
        end
        object rllTotValJur: TfrxMemoView
          Left = 587.769820000000000000
          Top = 10.059059999999990000
          Width = 60.094485750000000000
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
            '[fltValJur]')
          ParentFont = False
        end
        object rllTotValRec: TfrxMemoView
          Left = 650.003008030000000000
          Top = 10.059060000000000000
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
            '[fltValRec]')
          ParentFont = False
        end
        object TOTDINHEIRO: TfrxMemoView
          Left = 9.795300000000000000
          Top = 31.236240000000010000
          Width = 221.102359760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DINHEIRO: [<frxDataset."CTR_DINHEI">]')
          ParentFont = False
          WordWrap = False
        end
        object TOTCHEQUE: TfrxMemoView
          Left = 344.449057500000000000
          Top = 31.370078740000000000
          Width = 134.173169760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' [<frxDataset."CTR_CHQAVI">]')
          ParentFont = False
          WordWrap = False
        end
        object TOTCHEQUEPRE: TfrxMemoView
          Left = 523.583025000000000000
          Top = 31.370078740000000000
          Width = 190.866119760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CHEQUE PR'#201':  [<frxDataset."CTR_CHQPRE">]')
          ParentFont = False
          WordWrap = False
        end
        object TOTCARTAO: TfrxMemoView
          Left = 10.063002500000000000
          Top = 52.913419999999970000
          Width = 221.102359760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CART'#195'O:  [<frxDataset."CTR_CARTAO">]')
          ParentFont = False
          WordWrap = False
        end
        object TOTORDEMPGTO: TfrxMemoView
          Left = 342.937230000000000000
          Top = 52.913419999999970000
          Width = 137.952699760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' [<frxDataset."CTR_ORDPAG">]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 0.779530000000000000
          Top = 49.133890000000010000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object TOTCRED: TfrxMemoView
          Left = 489.559370000000000000
          Top = 52.913419999999970000
          Width = 224.881889760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CR'#201'DITO UTILIZADO: [frxDataset."CTR_CREDITO"]')
          ParentFont = False
          WordWrap = False
        end
        object Line6: TfrxLineView
          Left = -0.220470000000000000
          Top = 68.031540000000010000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rlbCheque: TfrxMemoView
          Left = 287.244280000000000000
          Top = 31.370078740000000000
          Width = 51.023509760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          WordWrap = False
        end
        object rlbOrdemPagamento: TfrxMemoView
          Left = 234.330860000000000000
          Top = 52.913419999999970000
          Width = 103.936929760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORDEM DE PGTO.:')
          ParentFont = False
          WordWrap = False
        end
        object TOTBOLETO: TfrxMemoView
          Left = 10.338590000000000000
          Top = 71.811069999999970000
          Width = 221.102359760000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'BOLETO: [<frxDataset."VALOR_BOLETO">]')
          ParentFont = False
          WordWrap = False
        end
        object Line7: TfrxLineView
          Top = 85.929190000000010000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015770000000010000
        Top = 168.000000000000000000
        Width = 755.906000000000000000
        Condition = 'frxDataset."SEQCON"'
        object Shape1: TfrxShapeView
          Left = -1.220470000000000000
          Top = 20.488179210000000000
          Width = 755.906000000000000000
          Height = 13.228344020000000000
        end
        object Memo11: TfrxMemoView
          Left = 0.779530000000000000
          Top = 19.779529999999990000
          Width = 73.322819999999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NUM.DOC.')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 106.877180000000000000
          Top = 19.779529999999990000
          Width = 73.020470000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HISTORICO')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 285.603030000000000000
          Top = 19.779529999999990000
          Width = 91.388930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NOSSONUMER]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 378.591960000000000000
          Top = 19.779529999999990000
          Width = 58.507050000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENC]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 499.960420000000000000
          Top = 19.779529999999990000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOC.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 565.365120000000100000
          Top = 19.779529999999990000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 626.769820000000000000
          Top = 19.779529999999990000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 689.174520000000000000
          Top = 19.779529999999990000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = -1.220470000000000000
          Top = 2.779529999999994000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 439.071120000000000000
          Top = 19.897650000000000000
          Width = 58.507050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 254.228510000000000000
          Top = 19.559059999999990000
          Width = 29.480314960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 227.023612280000000000
          Top = 19.559059999999990000
          Width = 25.700784960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
        end
        object rllSeqBaixa: TfrxMemoView
          Left = 1.779530000000000000
          Top = 3.779529999999994000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 87.063080000000000000
          Top = 3.779529999999994000
          Width = 94.488249999999990000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataset."SEQCON"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 256.000000000000000000
        Width = 755.906000000000000000
        object Memo20: TfrxMemoView
          Left = 289.110390000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL POR SEQUENCIAL DE BAIXA:')
          ParentFont = False
        end
        object rllTotalDocSeqBaixa: TfrxMemoView
          Left = 499.960420000000000000
          Width = 63.874015750000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALDOC">,rlbMaster)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 565.365120000000000000
          Width = 60.094485750000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALDES">,rlbMaster)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 626.769820000000000000
          Width = 60.094485750000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALJUR">,rlbMaster)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalRecSeqBaixa: TfrxMemoView
          Left = 689.174520000000000000
          Width = 63.874015750000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALREC">,rlbMaster)]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = -0.220470000000000000
          Width = 755.905323860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 400.000000000000000000
        Width = 755.906000000000000000
        object rllRiscoAssinatura: TfrxMemoView
          Left = 9.826771650000000000
          Top = 85.933890000000020000
          Width = 260.182560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ASSINATURA:_______________________________')
          ParentFont = False
        end
        object EMPRESA: TfrxMemoView
          Left = 9.826771650000000000
          Top = 4.661409999999989000
          Width = 719.244094490000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA: [CODEMP]')
          ParentFont = False
        end
        object PORTADOR: TfrxMemoView
          Left = 9.826771650000000000
          Top = 21.338590000000010000
          Width = 719.244094490000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PORTADOR: [CODPOR]')
          ParentFont = False
        end
        object OPERADOR: TfrxMemoView
          Left = 9.826771650000000000
          Top = 38.015769999999980000
          Width = 719.320100000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OPERADOR: [CODOPE]')
          ParentFont = False
        end
        object HIST01: TfrxMemoView
          Left = 9.826771650000000000
          Top = 53.692950000000000000
          Width = 719.320100000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HIST'#211'RICO: [HISTOR]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 532.000000000000000000
        Width = 755.906000000000000000
        object Memo10: TfrxMemoView
          Left = 9.826771653543310000
          Top = 1.897649999999999000
          Width = 260.182560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ASSINATURA:_______________________________')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 502.677490000000000000
          Top = 3.779530000000022000
          Width = 247.029870000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
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
    SaveToFile = False
    UseIniSettings = True
    Left = 104
    Top = 120
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 40
    Top = 120
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Left = 160
    Top = 120
  end
  object frxReciboRcx_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Compressed = True
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42331.390527905100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chiCabec.Visible := False;  '
      'end;'
      ''
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    OnUserFunction = frxReciboCtr_MUserFunction
    Left = 40
    Top = 56
    Datasets = <
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
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
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        Child = frxReciboRcx_M.chiCabec
        object rllNomEmp: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1056.000000000000000000
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
          Align = baCenter
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."HORREC"]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1238.400000000000000000
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
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[RECEBIDO]')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        object rllDtaVen: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          TruncOutboundText = False
        end
        object rllValDes: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          TruncOutboundText = False
        end
        object rllValJur: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODCTA"] - [frxDataset."DESCTA"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[PLANO]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderDocs: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1276.800000000000000000
        Condition = 'frxDataset."DESCRI"'
        Stretched = True
        object rllHist01: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1257.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."DESCRI"][NOMECLI]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ReportSummaryDocs: TfrxReportSummary
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 306.000000000000000000
        Width = 1276.800000000000000000
        Child = frxReciboRcx_M.chiAssinatura
        PrintChildIfInvisible = True
        object rllTotValRec: TfrxDMPMemoView
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
            
              '[SUM(<frxDataset."VALREC">,rlbMaster,2)+SUM(<frxDataset."VALOR_T' +
              'ROCO">,rlbMaster,2)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTDINHEI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = -9.600000000000000000
          Top = 17.000000000000000000
          Width = 1142.400000000000000000
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
        object DMPMemo7: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DINHEIRO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTCARTAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[CARTAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTCHQVIS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTCHQPRE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 34.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[CHQPRE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTORDPAG]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 979.200000000000000000
          Color = clBlack
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 68.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[CREDITO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[FLTCREDITO]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chiAssinatura: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 442.000000000000000000
        Width = 1276.800000000000000000
        PrintChildIfInvisible = True
        object rllRiscoAssinatura: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[STROPERAD]')
          TruncOutboundText = False
        end
        object rllSeqBaixa: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllOperador: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR1]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[CAIXA]')
          TruncOutboundText = False
        end
      end
      object fooChePre: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'fooChePreOnBeforePrint'
        AllowSplit = True
        Stretched = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReciboRcx_M.pagChePre
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 85.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1257.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[DESCRICAO]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[EMP]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'NOSSO NUMER.')
          TruncOutboundText = False
        end
      end
    end
    object pagChePre: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 119.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 556.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[COMPENSACAO]')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxChePre
        DataSetName = 'frxChePre'
        RowCount = 0
        object frxChePreCHQ_NUMAGE: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_CONCOR: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_NUMCHQ: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_DTAVEN: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_VALCHQ: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxChePre."CHQ_VALCHQ"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_NOMEMI: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NOMEMI'
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_C_G_C_: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_C_G_C_'
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          Memo.UTF8W = (
            '[frxChePre."CHQ_C_G_C_"]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGEN.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C. CORRENTE')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CNPJ]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReciboRcx_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 45089.569738171300000000
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
    OnUserFunction = frxReciboCtr_MUserFunction
    Left = 128
    Top = 56
    Datasets = <
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 75.543290000000000000
        Top = 16.000000000000000000
        Width = 755.906000000000000000
        Child = frxReciboRcx_J.chiCabec
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 113.575140000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 664.771490000000000000
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
          Left = 262.904330000000000000
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
            '[RELACAO]')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 623.130550000000000000
          Top = 34.000000000000000000
          Width = 76.875510000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [frxDataset."DTAREC"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 702.944650000000000000
          Top = 34.000000000000000000
          Width = 48.302350000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [frxDataset."HORREC"]')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 732.047000000000000000
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
          Left = 724.447000000000000000
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
          Left = 703.247000000000000000
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
        object Memo44: TfrxMemoView
          Left = 522.795610000000000000
          Top = 34.000000000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[RECEBIDO]')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 248.000000000000000000
        Width = 755.906000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        object rllDtaVen: TfrxMemoView
          Left = 438.963760000000000000
          Top = 1.000000000000000000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDup: TfrxMemoView
          Left = 502.070810000000000000
          Top = 1.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataField = 'VALDOC'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDes: TfrxMemoView
          Left = 568.916450000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DataField = 'VALDES'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValJur: TfrxMemoView
          Left = 626.762090000000000000
          Top = 1.000000000000000000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DataField = 'VALJUR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 690.780890000000000000
          Top = 1.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataField = 'VALREC'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 338.159060000000000000
          Top = 1.000000000000000000
          Width = 97.889785750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 273.905690000000000000
          Top = 1.000000000000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 306.141930000000000000
          Top = 1.000000000000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 77.472480000000000000
          Top = 1.000000000000000000
          Width = 116.787435750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODCTA"] - [frxDataset."DESCTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 3.600000000000000000
          Top = 1.000000000000000000
          Width = 71.433075750000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PLANO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 196.299320000000000000
          Top = 1.000000000000000000
          Width = 75.212598430000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 208.000000000000000000
        Width = 755.906000000000000000
        Condition = 'frxDataset."DESCRI"'
        Stretched = True
        object rllHist01: TfrxMemoView
          Left = 3.600000000000000000
          Top = 3.000000000000000000
          Width = 710.022140000000000000
          Height = 13.220470000000000000
          StretchMode = smActualHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DESCRI"][NOMECLI]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 69.866110000000000000
        Top = 368.000000000000000000
        Width = 755.906000000000000000
        Child = frxReciboRcx_J.chiAssinatura
        PrintChildIfInvisible = True
        object rllTotValRec: TfrxMemoView
          Left = 688.780890000000000000
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
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDataset."VALREC">,rlbMaster,2)+SUM(<frxDataset."VALOR_T' +
              'ROCO">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 78.999631420000000000
          Top = 22.220469999999980000
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
            '[FLTDINHEI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 619.472465350000000000
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
        object Memo7: TfrxMemoView
          Left = 10.968135350000000000
          Top = 22.220469999999980000
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
            '[DINHEIRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 79.377672050000000000
          Top = 41.897650000000000000
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
            '[FLTCARTAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 11.346175980000000000
          Top = 41.897650000000000000
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
            '[CARTAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 375.181099920000000000
          Top = 22.220469999999980000
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
            '[FLTCHQVIS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 305.149603860000000000
          Top = 22.220469999999980000
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
            'CHQ.VISTA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 688.203340000000000000
          Top = 22.220469999999980000
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
            '[FLTCHQPRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 617.137230000000000000
          Top = 22.220469999999980000
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
            '[CHQPRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 376.669450000000000000
          Top = 41.897650000000000000
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
            '[FLTORDPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 280.300990000000000000
          Top = 41.897650000000000000
          Width = 90.330725750000000000
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
            '[ORDEM]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baLeft
          Top = 3.779530000000022000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 558.811380000000000000
          Top = 37.795300000000000000
          Width = 124.346495750000000000
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
            '[CREDITO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 688.094930000000000000
          Top = 37.795300000000000000
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
            '[FLTCREDITO]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chiAssinatura: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 456.000000000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object Memo22: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.692928030000020000
          Width = 320.654730000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STROPERAD]:_____________________________________')
          ParentFont = False
        end
        object rllSeqBaixa: TfrxMemoView
          Left = 585.428199999999900000
          Top = 22.692928030000020000
          Width = 163.880210000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 333.132530000000000000
          Top = 22.677180000000020000
          Width = 247.029870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR1]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 7.559060000000000000
          Top = 42.354359999999990000
          Width = 318.840940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
        end
      end
      object fooChePre: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 284.000000000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'fooChePreOnBeforePrint'
        object subChePre: TfrxSubreport
          Left = 3.000000000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReciboRcx_J.pagChePre
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 112.000000000000000000
        Width = 755.906000000000000000
        object Shape1: TfrxShapeView
          Left = 2.000000000000000000
          Top = 1.031540000000007000
          Width = 752.126470000000000000
          Height = 26.456710000000000000
          Fill.BackColor = clSilver
        end
        object Memo12: TfrxMemoView
          Left = 3.426840000000000000
          Top = 1.000000000000000000
          Width = 146.872170000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 438.963760000000000000
          Top = 14.000000000000010000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENC]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 502.070810000000000000
          Top = 14.000000000000010000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOC.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 568.916450000000100000
          Top = 14.000000000000010000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 626.762090000000000000
          Top = 14.000000000000010000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 689.607730000000000000
          Top = 14.000000000000010000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 338.159060000000000000
          Top = 14.000000000000010000
          Width = 97.889785750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMEN.')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 306.141930000000000000
          Top = 13.999999999999990000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 273.937032280000000000
          Top = 13.999999999999990000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 196.299320000000000000
          Top = 14.000000000000010000
          Width = 75.212605750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
      end
    end
    object pagChePre: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787404020000000000
        ParentFont = False
        Top = 60.000000000000000000
        Width = 755.906000000000000000
        DataSet = frxChePre
        DataSetName = 'frxChePre'
        RowCount = 0
        object frxChePrefrxChePre: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.000000000000000000
          Width = 42.330701340000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 47.622047240000000000
          Top = 1.000000000000000000
          Width = 83.905494720000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 135.685039370000000000
          Top = 1.000000000000000000
          Width = 99.023578110000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 393.448818900000000000
          Top = 1.000000000000000000
          Width = 170.834601730000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 567.307086610000000000
          Top = 1.000000000000000000
          Width = 144.378011340000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_C_G_C_"]')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 238.488188980000000000
          Top = 1.000000000000000000
          Width = 72.566919370000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 314.078740160000000000
          Top = 1.000000000000000000
          Width = 76.346427400000000000
          Height = 15.118120000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxChePre."CHQ_VALCHQ"]')
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 100.000000000000000000
        Width = 755.906000000000000000
        object Line4: TfrxLineView
          Left = 2.000000000000000000
          Top = 3.779530000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo26: TfrxMemoView
          Left = 2.000000000000000000
          Top = 7.559060000000000000
          Width = 570.709030000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPENSACAO]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 2.000000000000000000
          Top = 27.236240000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 16.000000000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Memo25: TfrxMemoView
          Left = 2.000000000000000000
          Width = 748.346940000000000000
          Height = 17.007849610000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object Memo27: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.779530000000000000
          Width = 42.330708660000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AG'#202'N.')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 135.866144170000000000
          Top = 1.779529999999994000
          Width = 99.023622050000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M. CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 393.630180000000000000
          Top = 1.779529999999994000
          Width = 170.985900000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 567.488560000000000000
          Top = 1.779530000000000000
          Width = 148.308720000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 238.669450000000000000
          Top = 1.779530000000000000
          Width = 72.566929130000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 314.259844960000000000
          Top = 1.779529999999994000
          Width = 76.346456690000000000
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
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 47.803152050000000000
          Top = 1.779529999999994000
          Width = 83.905511809999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxChePre: TfrxDBDataset
    UserName = 'frxChePre'
    CloseDataSource = False
    DataSet = cdsCadChq
    BCDToCurrency = False
    Left = 208
    Top = 56
  end
  object cdsCadChq: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 219
    Top = 122
    object cdsCadChqCHQ_CONCOR: TStringField
      FieldName = 'CHQ_CONCOR'
      Size = 12
    end
    object cdsCadChqCHQ_NUMCHQ: TStringField
      FieldName = 'CHQ_NUMCHQ'
      Size = 10
    end
    object cdsCadChqCHQ_NOMEMI: TStringField
      FieldName = 'CHQ_NOMEMI'
      Size = 40
    end
    object cdsCadChqCHQ_C_G_C_: TStringField
      FieldName = 'CHQ_C_G_C_'
      Size = 18
    end
    object cdsCadChqCHQ_DTAVEN: TDateField
      FieldName = 'CHQ_DTAVEN'
    end
    object cdsCadChqCHQ_VALCHQ: TFloatField
      FieldName = 'CHQ_VALCHQ'
    end
    object cdsCadChqCHQ_NUMAGE: TStringField
      FieldName = 'CHQ_NUMAGE'
      Size = 5
    end
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 328
    Top = 121
  end
end
