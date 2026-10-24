object frmQckRcxReciboCB: TfrmQckRcxReciboCB
  Left = 584
  Top = 343
  Caption = 'frmQckRcxReciboCB'
  ClientHeight = 81
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 72
    Top = 8
  end
  object frxGenRec: TfrxUserDataSet
    UserName = 'frxGenRec'
    Fields.Strings = (
      'NOMEMP'
      'FONE01'
      'CIDEMP'
      'DOCUME'
      'FORPAG')
    OnGetValue = frxGenRecGetValue
    Left = 104
    Top = 8
  end
  object frxQckRcxReciboCBM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39534.649656585700000000
    ReportOptions.LastChange = 40141.680019525500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 8
    Datasets = <
      item
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
      end
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
      item
        DataSet = frxGenRec
        DataSetName = 'frxGenRec'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 224.895688088201400000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        object rllNomEmp: TfrxDMPMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'NOMEMP'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGenRec."NOMEMP"]')
          TruncOutboundText = False
        end
        object rllFone001: TfrxDMPMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'FONE01'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGenRec."FONE01"]')
          TruncOutboundText = False
        end
        object rllCidEmp: TfrxDMPMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'CIDEMP'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGenRec."CIDEMP"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
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
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 272.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            
              '[Trim(<frxRelatorio."NUMDOC">)][Trim(<frxRelatorio."PARCEL">)]-[' +
              'Trim(<frxRelatorio."ESPDOC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"] ')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbDescricao: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          TruncOutboundText = False
        end
        object rlbNomCta: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[PLANO_CONTAS]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDados: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxReciboCBM.chiAvisoCheque
        PrintChildIfInvisible = True
        Stretched = True
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object rllFormPag: TfrxDMPMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FORPAG'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          Memo.UTF8W = (
            '[frxGenRec."FORPAG"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQBAI]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxReciboCBM.rlbCab
        object rllTitulo: TfrxDMPMemoView
          Align = baWidth
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbAssinatura: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 663.000000000000000000
        Width = 384.000000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 52.800000000000000000
          Top = 42.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
        end
        object rllResponsavel: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 51.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[RESPONSAVEL]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Align = baBottom
          Left = 278.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            ' ')
          TruncOutboundText = False
        end
      end
      object rlbCab: TfrxChild
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 170.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo6: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DOC')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.REC')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbTitDescri: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DESCRICAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbDesCta: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CUSTO]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chiAvisoCheque: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 442.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxReciboCBM.chiChePre
        PrintChildIfInvisible = True
        object DMPMemo2: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[COMPENSACAO]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
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
          Width = 364.800000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 364.800000000000000000
          Color = clBlack
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C. CORRENTE')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CNPJ]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
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
          Width = 364.800000000000000000
          Color = clBlack
        end
      end
      object chiChePre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxReciboCBM.chiCheAvi
        PrintChildIfInvisible = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxQckRcxReciboCBM.pagChePre
        end
      end
      object chiCheAvi: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 384.000000000000000000
        Child = frxQckRcxReciboCBM.rlbAssinatura
        PrintChildIfInvisible = True
        object subCheAvi: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxQckRcxReciboCBM.pagCheAvi
        end
      end
    end
    object pagChePre: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 179.916550470561200000
      PaperSize = 256
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
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxChePre."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxChePre."CHQ_C_G_C_">)]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
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
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
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
      PaperHeight = 179.916550470561200000
      PaperSize = 256
      FontStyle = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
        RowCount = 0
        object DMPMemo26: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMAGE"]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_CONCOR"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMCHQ"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NOMEMI"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxCheAvi."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxCheAvi."CHQ_C_G_C_">)]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
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
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
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
  object frxQckRcxReciboCBJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39534.649656585700000000
    ReportOptions.LastChange = 40149.430560069440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 8
    Top = 8
    Datasets = <
      item
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
      end
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
      item
        DataSet = frxGenRec
        DataSetName = 'frxGenRec'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelat: TfrxReportPage
      PaperWidth = 105.000000000000000000
      PaperHeight = 200.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 81.220470000000000000
        Top = 18.897650000000000000
        Width = 396.850650000000000000
        object rllNomEmp: TfrxMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 396.850650000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'NOMEMP'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."NOMEMP"]')
        end
        object rllFone001: TfrxMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 396.850650000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'FONE01'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."FONE01"]')
        end
        object rllCidEmp: TfrxMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 396.850650000000000000
          Height = 17.000000000000000000
          GroupIndex = 1
          DataField = 'CIDEMP'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."CIDEMP"]')
        end
        object Line1: TfrxLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 385.738590000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 77.472480000000000000
        Top = 313.700990000000000000
        Width = 396.850650000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Memo1: TfrxMemoView
          Width = 393.978170000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[Trim(<frxRelatorio."NUMDOC">)][Trim(<frxRelatorio."PARCEL">)]-[' +
              'Trim(<frxRelatorio."ESPDOC">)]')
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = -0.226840000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 101.593630000000000000
          Top = 18.897650000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 184.214100000000000000
          Top = 18.897650000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDescricao: TfrxMemoView
          Top = 56.692949999999990000
          Width = 390.803340000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
        object rlbNomCta: TfrxMemoView
          Top = 39.574830000000020000
          Width = 371.905690000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CUSTO]')
          WordWrap = False
        end
      end
      object rlbDados: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 415.748300000000000000
        Width = 396.850650000000000000
        Child = frxQckRcxReciboCBJ.chiAvisoCheque
        PrintChildIfInvisible = True
        Stretched = True
        object Line2: TfrxLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 385.738590000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllFormPag: TfrxMemoView
          Align = baWidth
          Top = 34.000000000000000000
          Width = 396.850650000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FORPAG'
          DataSet = frxGenRec
          DataSetName = 'frxGenRec'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."FORPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Top = 16.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Date]')
        end
        object Time: TfrxMemoView
          Left = 138.179530000000000000
          Top = 16.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo12: TfrxMemoView
          Left = 257.008040000000000000
          Top = 16.118119999999980000
          Width = 138.179530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQBAI]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 162.519790000000000000
        Width = 396.850650000000000000
        Child = frxQckRcxReciboCBJ.rlbCab
        object rllTitulo: TfrxMemoView
          Align = baWidth
          Width = 396.850650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          ParentFont = False
        end
      end
      object rlbAssinatura: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 684.094930000000000000
        Width = 396.850650000000000000
        object Line3: TfrxLineView
          Left = 52.800000000000000000
          Top = 42.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllResponsavel: TfrxMemoView
          Left = 48.000000000000000000
          Top = 51.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[RESPONSAVEL]')
        end
      end
      object rlbCab: TfrxChild
        FillType = ftBrush
        Height = 81.259859610000000000
        Top = 207.874150000000000000
        Width = 396.850650000000000000
        object Memo6: TfrxMemoView
          Align = baClient
          Width = 396.850650000000000000
          Height = 81.259859610000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object Memo7: TfrxMemoView
          Top = 1.881879999999995000
          Width = 118.072480000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = -0.226840000000000000
          Top = 22.779529999999990000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 101.593630000000000000
          Top = 22.779529999999990000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DOC')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 184.214100000000000000
          Top = 22.779529999999990000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.REC')
          ParentFont = False
          WordWrap = False
        end
        object rlbTitDescri: TfrxMemoView
          Top = 61.905511810000010000
          Width = 386.419110000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DESCRICAO]')
          WordWrap = False
        end
        object rlBDesCta: TfrxMemoView
          Top = 42.897637799999990000
          Width = 182.324490000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CUSTO]')
          WordWrap = False
        end
      end
      object chiAvisoCheque: TfrxChild
        FillType = ftBrush
        Height = 79.370130000000030000
        Top = 491.338900000000000000
        Width = 396.850650000000000000
        Child = frxQckRcxReciboCBJ.chiChePre
        PrintChildIfInvisible = True
        object Memo20: TfrxMemoView
          Top = 37.795300000000050000
          Width = 396.850650000000000000
          Height = 39.685029610000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Width = 396.850650000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPENSACAO]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 40.574830000000080000
          Width = 42.330708660000000000
          Height = 17.000000000000000000
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
        object Memo22: TfrxMemoView
          Left = 139.086614170000000000
          Top = 40.574830000000080000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
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
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692949999999940000
          Width = 239.017440000000000000
          Height = 17.000000000000000000
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
        object Memo24: TfrxMemoView
          Left = 245.669450000000000000
          Top = 55.692949999999940000
          Width = 148.308720000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 241.889920000000000000
          Top = 40.574830000000080000
          Width = 72.566929130000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMEN.'
            '')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 317.480314960000000000
          Top = 40.574830000000080000
          Width = 76.346456690000000000
          Height = 17.000000000000000000
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
        object Memo8: TfrxMemoView
          Left = 51.023622050000000000
          Top = 40.574830000000080000
          Width = 83.905511809999990000
          Height = 17.000000000000000000
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
      object chiCheAvi: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 638.740570000000000000
        Width = 396.850650000000000000
        Child = frxQckRcxReciboCBJ.rlbAssinatura
        PrintChildIfInvisible = True
        object subCheAvi: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxQckRcxReciboCBJ.pagCheAvi
        end
      end
      object chiChePre: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 593.386210000000000000
        Width = 396.850650000000000000
        Child = frxQckRcxReciboCBJ.chiCheAvi
        PrintChildIfInvisible = True
        object subChePre: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxQckRcxReciboCBJ.pagChePre
        end
      end
    end
    object pagChePre: TfrxReportPage
      PaperWidth = 105.000000000000000000
      PaperHeight = 150.000000000000000000
      PaperSize = 256
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 41.574830000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 396.850650000000000000
        DataSet = frxChePre
        DataSetName = 'frxChePre'
        RowCount = 0
        object frxChePrefrxChePre: TfrxMemoView
          Left = 3.779530000000000000
          Width = 42.330701340000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 51.023614720000000000
          Width = 83.905494719999990000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 139.086589760000000000
          Width = 99.023578110000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 238.866141730000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 245.669450000000000000
          Top = 18.897650000000000000
          Width = 144.378011340000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxChePre."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxChePre."CHQ_C_G_C_">)]')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 241.889920000000000000
          Width = 72.566919370000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 317.480456540000000000
          Width = 76.346427400000000000
          Height = 18.897650000000000000
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
        Height = 7.559060000000000000
        Top = 83.149660000000000000
        Width = 396.850650000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 396.850650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object pagCheAvi: TfrxReportPage
      PaperWidth = 105.000000000000000000
      PaperHeight = 150.000000000000000000
      PaperSize = 256
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 41.574830000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 396.850650000000000000
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
        RowCount = 0
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Width = 42.330708661417320000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMAGE"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 51.023622047244090000
          Width = 83.905511811023630000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_CONCOR"]')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 139.086614173228300000
          Width = 99.023622047244110000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMCHQ"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 238.866141730000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NOMEMI"]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 245.669450000000000000
          Top = 18.897650000000000000
          Width = 144.378011340000000000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxCheAvi."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxCheAvi."CHQ_C_G_C_">)]')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 241.889920000000000000
          Width = 72.566929133858270000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_DTAVEN"]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 317.480456540000000000
          Width = 76.346456692913380000
          Height = 18.897650000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_VALCHQ"]')
          WordWrap = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 83.149660000000000000
        Width = 396.850650000000000000
        object Line5: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 396.850650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 136
    Top = 8
  end
  object frxChePre: TfrxDBDataset
    UserName = 'frxChePre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 104
    Top = 40
  end
  object frxCheAvi: TfrxDBDataset
    UserName = 'frxCheAvi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 136
    Top = 40
  end
end
