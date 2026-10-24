object frmQckRcxRecBai40cB: TfrmQckRcxRecBai40cB
  Left = 377
  Top = 382
  Caption = 'Impress'#227'o do Recibo de Recebimento - Bobina'
  ClientHeight = 117
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxRecibo: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 40969.395906747680000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxReciboUserFunction
    Left = 16
    Top = 8
    Datasets = <
      item
        DataSet = frxAuxiliar
        DataSetName = 'frxAuxiliar'
      end
      item
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
      end
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
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
      PaperHeight = 256.381084420549700000
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
            'RECIBO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 153.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."NOMCLI"]')
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
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODCLI"]')
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
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 204.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DOCUM')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.RECEB')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[DESCRICAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.JUR')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 340.000000000000000000
        Width = 384.000000000000000000
        Child = frxRecibo.Child1
        DataSet = frxDBRecibo
        DataSetName = 'frxRecibo'
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '[Trim(<frxRecibo."NUMDOC">)][Trim(<frxRecibo."PARCEL">)]-[Trim(<' +
              'frxRecibo."ESPDOC">)]-[Trim(<frxRecibo."SEQBAI">)]')
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALREC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODVEN"]-[fRetNomVendRep(<frxRecibo."CODVEN">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALJUR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          StretchMode = smActualHeight
          Memo.UTF8W = (
            'REF.:[frxRecibo."HIST01"]')
          TruncOutboundText = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 493.000000000000000000
        Width = 384.000000000000000000
        Child = frxRecibo.chiAvisoCheque
        PrintChildIfInvisible = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
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
            
              '[SUM(<frxRecibo."VALREC">,Detalhes)+SUM(<frxRecibo."VALOR_TROCO"' +
              '>,Detalhes)]')
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
      object chiAvisoCheque: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 544.000000000000000000
        Width = 384.000000000000000000
        Child = frxRecibo.chiChePre
        PrintChildIfInvisible = True
        object DMPMemo24: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[COMPENSACAO]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGEN.')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C. CORRENTE')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CNPJ]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
      end
      object chiChePre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 384.000000000000000000
        Child = frxRecibo.chiCheAvi
        PrintChildIfInvisible = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRecibo.pagChePre
        end
      end
      object chiCheAvi: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 384.000000000000000000
        Child = frxRecibo.ChildRodape
        PrintChildIfInvisible = True
        object subCheAvi: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRecibo.pagCheAvi
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 765.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo23: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DATA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAuxiliar."OPERADOR"]')
          TruncOutboundText = False
        end
        object rllSalto: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Align = baCenter
          Left = 62.400000000000000000
          Top = 76.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SEQ. BAIXA: [Trim(<frxRecibo."SEQCON">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CAIXA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 384.000000000000000000
        object rllNosNum: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNosNumOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."NOSNUM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabNosNum: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOSSO NUMERO:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object pagChePre: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxChePre
        DataSetName = 'frxChePre'
        RowCount = 0
        object frxChePrefrxChePre: TfrxDMPMemoView
          ShiftMode = smDontShift
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          ShiftMode = smDontShift
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          ShiftMode = smDontShift
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxChePre."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxChePre."CHQ_C_G_C_">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 268.800000000000000000
          Top = 34.000000000000000000
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
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 384.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
      end
    end
    object pagCheAvi: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
        RowCount = 0
        object DMPMemo40: TfrxDMPMemoView
          ShiftMode = smDontShift
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NOMEMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxCheAvi."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39'), <frxCheAvi."CHQ_C_G_C_">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_VALCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 384.000000000000000000
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
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
    Left = 48
    Top = 8
  end
  object cdsRecibo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRecibo'
    Left = 48
    Top = 56
  end
  object frxDBRecibo: TfrxDBDataset
    UserName = 'frxRecibo'
    CloseDataSource = False
    DataSet = cdsRecibo
    BCDToCurrency = False
    Left = 80
    Top = 56
  end
  object dspRecibo: TUniDataSetProvider
    Options = []
    Left = 16
    Top = 56
  end
  object frxAuxiliar: TfrxUserDataSet
    UserName = 'frxAuxiliar'
    Fields.Strings = (
      'SALTO'
      'OPERADOR')
    OnGetValue = frxAuxiliarGetValue
    Left = 79
    Top = 8
  end
  object frxChePre: TfrxDBDataset
    UserName = 'frxChePre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 56
  end
  object frxCheAvi: TfrxDBDataset
    UserName = 'frxCheAvi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 152
    Top = 56
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
    Left = 120
    Top = 8
  end
end
