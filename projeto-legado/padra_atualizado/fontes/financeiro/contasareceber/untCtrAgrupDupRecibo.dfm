object frmCtrAgrupDupRecibo: TfrmCtrAgrupDupRecibo
  Left = 0
  Top = 0
  ClientHeight = 289
  ClientWidth = 502
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
  object frxComandos: TfrxUserDataSet
    UserName = 'frxComandos'
    Fields.Strings = (
      'UM_OITAVO_ON'
      'UM_OITAVO_OFF'
      'NEGRITO_ON'
      'NEGRITO_OFF'
      'EXPANDIDO_ON'
      'EXPANDIDO_OFF'
      'ITALICO_ON'
      'ITALICO_OFF'
      'COND_10CPI_ON'
      'COND_10CPI_OFF'
      'COND_12CPI_ON'
      'COND_12CPI_OFF'
      'RESETA')
    OnGetValue = frxComandosGetValue
    Left = 24
    Top = 16
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 79
    Top = 16
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 134
    Top = 17
  end
  object frxComprovanteM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42340.639554108800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotal : Double;'
      '  strConPag: String;'
      
        '  intQtdGrp: Integer;                                           ' +
        '                      '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      '  Var '
      '    intNroPag : Integer;'
      'begin'
      '//  intNroPag := (intQtdGrp + 1) div 2;                        '
      '  intQtdGrp := intQtdGrp + 1;                          '
      '  rllPagina.Text := '#39'PAGINA: '#39' + intToStr(intQtdGrp);'
      '        '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotal := fltTotal + <frxRelatorio."CTR_VALDUP">;'
      ''
      
        '  //GroupFooter1.Height := GroupFooter1.Height - 1;             ' +
        '      '
      '    '
      'end;'
      ''
      'procedure rllTotGerSintOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotal.Text := FormatFloat('#39'#,##0.00'#39', fltTotal);'
      '  fltTotal       := 0;                              '
      '    '
      'end;'
      ''
      'procedure rllConPagOnBeforePrint(Sender: TfrxComponent);'
      'begin               '
      '  rllConPag.Text := fFormataCondPag(strConPag);'
      '  strConPag := '#39#39';'
      '    '
      'end;'
      ''
      'procedure grpHCodCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strConPag := <frxRelatorio."CTR_CONPAG">;'
      '    '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure qckPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure grpHCodCliOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  intQtdGrp := 0;                  '
      'end;'
      ''
      'procedure rllVencimentosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllVencimentos.Text := fMontaVencimentos(<frxRelatorio."CTR_NU' +
        'MAGR">, '
      '                                           '#39'AG'#39','
      
        '                                           <frxRelatorio."CTR_EM' +
        'PAGR">);  '
      'end;'
      ''
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCOMAGR.Text := CFG_COMAGR;  '
      'end;'
      ''
      'begin'
      '  fltTotal  := 0;'
      '  intQtdGrp := 0;                 '
      '    '
      'end.')
    OnUserFunction = frxComprovanteMUserFunction
    Left = 48
    Top = 80
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxVariaveis'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 139.435326614684900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      ColumnPositions.Strings = (
        '0')
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1219.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Columns = 2
        ColumnWidth = 585.120000000000000000
        ColumnGap = 28.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo4: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine16: TfrxDMPLineView
          Left = 1214.400000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine17: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
      end
      object grpHCodCli: TfrxGroupHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1219.200000000000000000
        OnAfterPrint = 'grpHCodCliOnAfterPrint'
        OnBeforePrint = 'grpHCodCliOnBeforePrint'
        Child = frxComprovanteM.chdTitulo
        Condition = 'frxRelatorio."NUMAGR"'
        ReprintOnNewPage = True
        StartNewPage = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 51.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 68.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 950.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA : [frxRelatorio."NOMEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 950.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE : [frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 950.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGRUPAM : [frxRelatorio."NUMAGR"]'
            ' ')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGE MANUAL')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllLinVE: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Height = 238.000000000000000000
          Color = clBlack
        end
        object DMPLine14: TfrxDMPLineView
          Left = 1214.400000000000000000
          Top = 25.500000000000000000
          Height = 238.000000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Left = 1214.400000000000000000
          Top = 25.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object chdTitulo: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 204.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo11: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'VENC.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object rllLinMeio: TfrxDMPLineView
          Left = 619.200000000000000000
          Top = 8.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'VENC.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine15: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 306.000000000000000000
        Width = 1219.200000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object DMPMemo28: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
        object rllTotal: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotGerSintOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          TruncOutboundText = False
        end
        object rllConPag: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllConPagOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COND. PAGTO:')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 102.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Left = 1214.400000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
        object DMPLine13: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 25.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Color = clBlack
        end
        object DMPLine12: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTOS:')
          TruncOutboundText = False
        end
        object rllVencimentos: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 34.000000000000000000
          Width = 1065.600000000000000000
          Height = 51.000000000000000000
          OnBeforePrint = 'rllVencimentosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo17: TfrxDMPMemoView
          Left = -105.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '.')
          TruncOutboundText = False
        end
        object rlbCOMAGR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1190.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComprovanteJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45034.606887407400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotal : Double;'
      '  fltTotDesc : Double;'
      '  fltValDup : Double;'
      '  fltJurSuj : Double;      '
      '  fltValJur : Double;      '
      '  strConPag: String;'
      '  intQtdGrp: Integer;'
      '  strAntDup: String;      '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + intToStr(intQtdGrp);'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotal := fltTotal + <frxRelatorio."CTR_VALDUP">;'
      
        '  fltTotDesc := fltTotDesc + <frxRelatorio."CTR_VALDES">;       ' +
        '                        '
      'end;'
      ''
      'procedure rllTotGerSintOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   fltValJur := <frxRelatorio."CTR_TOTJUR">;    '
      
        '  rllTotal.Text := FormatFloat('#39'#,##0.00'#39', (fltTotal - fltValJur' +
        '));'
      'end;'
      ''
      'procedure rllConPagOnBeforePrint(Sender: TfrxComponent);'
      'begin               '
      '  rllConPag.Text := fFormataCondPag(strConPag);'
      '  strConPag := '#39#39';'
      'end;'
      ''
      'procedure grpHCodCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strConPag := <frxRelatorio."CTR_CONPAG">;'
      '  '
      '  If (strAntDup = <frxRelatorio."NUMAGR">) Or'
      '     (strAntDup = '#39'Primeiro'#39')   Then'
      '    intQtdGrp := intQtdGrp + 1'
      '  Else'
      '  Begin              '
      '    intQtdGrp := 1;'
      '    strAntDup := <frxRelatorio."NUMAGR">;  '
      '  End;                                   '
      '      '
      '  strAntDup := <frxRelatorio."NUMAGR">;      '
      '               '
      'end;'
      ''
      'procedure rllVencimentosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllVencimentos.Text := fMontaVencimentos(<frxRelatorio."CTR_NU' +
        'MAGR">, '
      '                                           '#39'AG'#39','
      
        '                                           <frxRelatorio."CTR_EM' +
        'PAGR">);  '
      'end;'
      ''
      'procedure rllDescontoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllDesconto.Text := FormatFloat('#39'#,##0.00'#39', fltTotDesc);'
      'end;'
      ''
      'procedure rllLiquidoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValJur := <frxRelatorio."CTR_TOTJUR">;    '
      
        '  rllLiquido.Text := FormatFloat('#39'#,##0.00'#39', ( fltTotal - fltTot' +
        'Desc ) );'
      '  fltTotDesc      := 0;                              '
      '  fltTotal        := 0;      '
      'end;'
      ''
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbCOMAGR.Text := CFG_COMAGR;                                 ' +
        '                                          '
      'end;'
      ''
      'procedure Memo9OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   fltValJur := <frxRelatorio."CTR_TOTJUR">;    '
      '  Memo9.Text := FormatFloat('#39'#,##0.00'#39', fltValJur);  '
      'end;'
      ''
      'procedure DMPMemo7OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValDup := <frxRelatorio."CTR_VALDUP">;             '
      '  fltJurSuj := <frxRelatorio."CTR_JURSUJ">;'
      
        '  DMPMemo7.Text := FormatFloat('#39'#,##0.00'#39', (fltValDup + fltJurSu' +
        'j));  '
      'end;'
      ''
      'begin'
      '  fltTotal   := 0;'
      '  fltValDup := 0;            '
      '  fltJurSuj := 0;      '
      '  fltTotDesc := 0;'
      '  fltValJur  := 0;      '
      '  intQtdGrp  := 0;'
      '  strAntDup  := '#39'Primeiro'#39';      '
      '    '
      'end.')
    OnUserFunction = frxComprovanteJUserFunction
    Left = 136
    Top = 80
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxMensagem'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
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
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 219.212740000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Columns = 2
        ColumnWidth = 351.496062992126000000
        ColumnGap = 10.204724409448800000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo4: TfrxMemoView
          Left = 159.992125980000000000
          Width = 60.472443390000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo5: TfrxMemoView
          Left = 220.960629920000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo7: TfrxMemoView
          Left = 279.307086610000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo7OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo9: TfrxMemoView
          Left = 2.157480310000000000
          Width = 156.850418110000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line9: TfrxLineView
          Left = 0.779530000000000000
          Height = 24.566929133858300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line1: TfrxLineView
          Left = 717.354330710000000000
          Height = 24.566929133858300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object grpHCodCli: TfrxGroupHeader
        FillType = ftBrush
        Height = 130.322820000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'grpHCodCliOnBeforePrint'
        AllowSplit = True
        Child = frxComprovanteJ.chdTitulo
        Condition = 'frxRelatorio."NUMAGR"'
        ReprintOnNewPage = True
        StartNewPage = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 115.200310000000000000
          Top = 3.763760000000001000
          Width = 487.710080000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
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
          Left = 114.255350000000000000
          Top = 20.763760000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object DMPMemo2: TfrxMemoView
          Left = 4.040940000000000000
          Top = 54.763760000000000000
          Width = 543.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA : [frxRelatorio."NOMEMP"]'
            ' ')
          ParentFont = False
        end
        object DMPMemo3: TfrxMemoView
          Left = 4.040940000000000000
          Top = 94.440940000000000000
          Width = 543.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGRUP.    : [frxRelatorio."NUMAGR"]'
            ' ')
          ParentFont = False
        end
        object DMPMemo16: TfrxMemoView
          Left = 4.040940000000000000
          Top = 73.645640000000000000
          Width = 543.722820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE.  : [frxRelatorio."NOMCLI"]'
            ' ')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 599.281570000000000000
          Top = 41.543290000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 656.276870000000000000
          Top = 58.543290000000000000
          Width = 58.204700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
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
          Left = 555.892640000000000000
          Top = 58.543290000000000000
          Width = 94.563760000000000000
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
        object Line3: TfrxLineView
          Left = 0.755905511811024000
          Height = 132.283550000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 717.110700000000000000
          Height = 132.283550000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 0.755905510000000000
          Width = 717.354330708661000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object chdTitulo: TfrxChild
        FillType = ftBrush
        Height = 20.822820000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        object rllFundoHeader: TfrxMemoView
          Left = 0.881880000000000000
          Top = 0.645669290000000600
          Width = 715.842519690000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object DMPMemo11: TfrxMemoView
          Left = 2.040940000000000000
          Top = 3.401574799999992000
          Width = 156.850418110000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo12: TfrxMemoView
          Left = 160.147990000000000000
          Top = 3.401574799999992000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo6: TfrxMemoView
          Left = 221.075510000000000000
          Top = 3.401574799999992000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENC.')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo8: TfrxMemoView
          Left = 279.173235670000000000
          Top = 3.401574799999992000
          Width = 69.921257400000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOC')
          ParentFont = False
          WordWrap = False
        end
        object DMPLine3: TfrxLineView
          Left = 361.710080000000000000
          Top = 1.000000000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 364.614410000000000000
          Top = 3.401574799999992000
          Width = 156.850418110000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 523.721460000000000000
          Top = 3.401574799999992000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 583.546630000000000000
          Top = 3.401574799999992000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENC.')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 641.746705670000000000
          Top = 3.401574803149600000
          Width = 69.921257400000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOC')
          ParentFont = False
          WordWrap = False
        end
      end
      object grpFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 133.826840000000000000
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        object DMPMemo28: TfrxMemoView
          Left = 531.779527560000000000
          Top = 8.881880000000024000
          Width = 100.157480314960600000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL BRUTO:')
          ParentFont = False
        end
        object rllTotal: TfrxMemoView
          Left = 634.204724410000000000
          Top = 8.881880000000024000
          Width = 79.747990000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotGerSintOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTGER]')
          ParentFont = False
        end
        object rllConPag: TfrxMemoView
          Left = 120.188976377952700000
          Top = 8.881880000000024000
          Width = 411.968503937007900000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllConPagOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
        end
        object DMPMemo1: TfrxMemoView
          Left = 3.040940000000000000
          Top = 8.881880000000024000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COND. PAGTO:')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 498.897960000000000000
          Top = 89.677180000000000000
          Width = 212.107050000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.755905510000000000
          Top = 86.590600000000000000
          Width = 717.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Left = 0.755905510000000000
          Top = 111.047310000000000000
          Width = 717.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 0.755905510000000000
          Height = 111.496104490000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 717.331170000000000000
          Height = 111.496104490000000000
          Color = clBlack
          Diagonal = True
        end
        object Line12: TfrxLineView
          Left = 0.755905510000000000
          Top = 7.000000000000000000
          Width = 717.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Left = 2.779530000000000000
          Top = 26.456710000000040000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTOS:')
          ParentFont = False
        end
        object rllVencimentos: TfrxMemoView
          Left = 120.188976380000000000
          Top = 26.456710000000000000
          Width = 411.968503940000000000
          Height = 43.456710000000000000
          OnBeforePrint = 'rllVencimentosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 531.779527560000000000
          Top = 26.456710000000000000
          Width = 100.157480310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          ParentFont = False
        end
        object rllDesconto: TfrxMemoView
          Left = 634.204724410000000000
          Top = 26.456710000000000000
          Width = 79.747990000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllDescontoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTDES')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 531.779527560000000000
          Top = 65.354360000000000000
          Width = 100.157480310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL L'#205'QUIDO:')
          ParentFont = False
        end
        object rllLiquido: TfrxMemoView
          Left = 634.204724410000000000
          Top = 65.354360000000000000
          Width = 79.747990000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllLiquidoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTLIQ')
          ParentFont = False
        end
        object rlbCOMAGR: TfrxMemoView
          Left = 3.779530000000000000
          Top = 113.047310000000000000
          Width = 712.441328110000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 529.134200000000000000
          Top = 45.354360000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 634.961040000000000000
          Top = 45.354360000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo9OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 453.543600000000000000
        Width = 718.110700000000000000
        PrintOnLastPage = False
        object Line6: TfrxLineView
          Left = 0.755905510000000000
          Width = 717.354330708661000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = True
    Left = 218
    Top = 17
  end
  object frxCompMod3J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41580.366402442100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValOri: Double;'
      '  fltValDes: Double;                                         '
      '  fltTotOri: Double;'
      '  fltTotDes: Double;'
      '  fltTotDup: Double;      '
      
        '  intTotReg: Integer;                                           ' +
        '        '
      ''
      ''
      
        'procedure rllValOriOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                                ' +
        '    '
      'begin'
      
        '  fltValOri := <frxrelatorio."CTR_VALDUP"> / ((100 - <frxrelator' +
        'io."CLI_DESCON">) / 100);'
      ''
      
        '  rllValOri.Text := FormatFloat('#39'#,##0.00'#39', fltValOri);         ' +
        '                                                                ' +
        ' '
      '    '
      '  fltTotOri := fltTotOri + fltValOri;'
      'end;'
      ''
      
        'procedure rllValDesOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                                ' +
        '  '
      'begin'
      ''
      
        '  fltValDes := (<frxrelatorio."CTR_VALDUP"> - (<frxrelatorio."CT' +
        'R_VALDUP"> / ((100 - <frxrelatorio."CLI_DESCON">) / 100))) * (- ' +
        '1);'
      ''
      '  rllValDes.Text := FormatFloat('#39'#,##0.00'#39', fltValDes);'
      ''
      
        '  fltTotDes := fltTotDes + fltValDes;                           ' +
        '                                                            '
      'end;'
      ''
      'procedure rllTotOriOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotOri.Text := FormatFloat('#39'#,##0.00'#39', fltTotOri);         ' +
        '                                                             '
      'end;'
      ''
      'procedure rllTotDesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotDes.Text := FormatFloat('#39'#,##0.00'#39', fltTotDes);  '
      'end;'
      ''
      'procedure rlbRodapeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intTotReg = fRetQtdReg Then'
      '  Begin                          '
      
        '    rlbSubTot.Visible   := False;                               ' +
        '                                                '
      '    rllTotal.Visible    := True;'
      '    rllTotOri.Visible   := True;'
      '    rllTotDes.Visible   := True;'
      '    rllTotDup.Visible   := True;'
      '    rllMensagem.Visible := True;'
      '    rllCidDta.Visible   := True;'
      '    rllLinAss.Visible   := True;         '
      '  End;            '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  intTotReg := intTotReg + 1;                                   ' +
        '                               '
      'end;'
      ''
      'procedure rllValDupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotDup := fltTotDup + <frxrelatorio."CTR_VALDUP">;         ' +
        '                                                     '
      'end;'
      ''
      'procedure rllTotDupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotDup.Text := FormatFloat('#39'#,##0.00'#39', fltTotDup);         ' +
        '                                                               '
      'end;'
      ''
      ''
      'procedure rllTotDup2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotDup2.Text := FormatFloat('#39'#,##0.00'#39', fltTotDup - <frxrel' +
        'atorio."CTR_VALDUP">);  '
      'end;'
      ''
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCOMAGR.Text := CFG_COMAGR;  '
      'end;'
      ''
      'begin                             '
      '  fltTotOri := 0;'
      '  fltTotDes := 0;'
      '  fltTotDup := 0;                                    '
      '  intTotReg := 0;            '
      'end.')
    OnUserFunction = frxCompMod3JUserFunction
    Left = 139
    Top = 185
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxVariaveis'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
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
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      ColumnPositions.Strings = (
        '0')
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 158.740260000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Columns = 1
        ColumnWidth = 585.120000000000000000
        ColumnGap = 28.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo4: TfrxMemoView
          Left = 203.000000000000000000
          Width = 69.845640000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 275.800000000000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDup: TfrxMemoView
          Left = 586.000000000000000000
          Width = 128.881889763779500000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValDupOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 1.200000000000000000
          Width = 177.637836770000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDes: TfrxMemoView
          Left = 481.600000000000000000
          Width = 102.425196850393700000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValDesOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALDES]')
          ParentFont = False
          WordWrap = False
        end
        object rllValOri: TfrxMemoView
          Left = 349.984251970000000000
          Width = 128.881880000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValOriOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 180.704020000000000000
          Width = 19.577860000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_PARCEL"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxGroupHeader
        FillType = ftBrush
        Height = 115.204700000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NUMAGR"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Shape1: TfrxShapeView
          Left = -0.240940000000000000
          Top = 94.929190000000010000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Memo2: TfrxMemoView
          Left = 95.800000000000000000
          Top = 39.000000000000000000
          Width = 413.328880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ENDCLI]')
        end
        object Memo3: TfrxMemoView
          Left = 95.800000000000000000
          Top = 3.000000000000000000
          Width = 617.876870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMCLI]')
        end
        object Memo16: TfrxMemoView
          Left = 586.843970000000000000
          Top = 56.000000000000000000
          Width = 129.486580000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."NUMAGR"]')
        end
        object Date: TfrxMemoView
          Left = 95.800000000000000000
          Top = 73.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Date]')
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Color = clBlack
        end
        object Memo19: TfrxMemoView
          Left = 95.800000000000000000
          Top = 56.000000000000000000
          Width = 186.783920000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TELCLI]')
        end
        object Memo20: TfrxMemoView
          Left = 510.043970000000000000
          Top = 39.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA :')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 404.443970000000000000
          Top = 56.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'NOTA DE D'#201'BITO N'#186' :')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 8.200000000000000000
          Top = 56.000000000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TELEFONE  :')
        end
        object Memo23: TfrxMemoView
          Left = 8.200000000000000000
          Top = 39.000000000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ENDERE'#199'O : ')
        end
        object Memo24: TfrxMemoView
          Left = 8.200000000000000000
          Top = 3.000000000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CLIENTE      :')
        end
        object Memo25: TfrxMemoView
          Left = 8.200000000000000000
          Top = 73.000000000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMISS'#195'O     :')
        end
        object Memo26: TfrxMemoView
          Left = 471.643970000000000000
          Top = 73.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIMENTO :')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 586.843970000000000000
          Top = 73.000000000000000000
          Width = 129.486580000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]'
            ' ')
        end
        object Memo11: TfrxMemoView
          Left = 1.200000000000000000
          Top = 96.000000000000000000
          Width = 181.417366770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 203.000000000000000000
          Top = 96.000000000000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISS'#195'O')
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 275.800000000000000000
          Top = 96.000000000000000000
          Width = 69.845640000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'VENC.')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 586.000000000000000000
          Top = 96.000000000000000000
          Width = 128.881880000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. LIQUIDO')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 481.600000000000000000
          Top = 96.000000000000000000
          Width = 102.425170000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DESCONTO')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 349.800000000000000000
          Top = 96.000000000000000000
          Width = 128.881880000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. ORIGINAL')
          WordWrap = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 597.858690000000000000
          Top = 37.897650000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PAGE#]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 92.379530000000000000
          Top = 20.897650000000000000
          Width = 617.876870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMFAN]')
        end
        object Memo14: TfrxMemoView
          Left = 8.559060000000000000
          Top = 20.897650000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FANTASIA    :')
        end
      end
      object rlbRodape: TfrxReportSummary
        FillType = ftBrush
        Height = 170.078767010000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbRodapeOnBeforePrint'
        object rllShpTot: TfrxShapeView
          Left = -0.240940000000000000
          Top = 1.779529999999994000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object rllTotal: TfrxMemoView
          Left = 245.574830000000000000
          Top = 1.779529999999994000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL :')
        end
        object rllTotOri: TfrxMemoView
          Left = 349.984251968503900000
          Top = 1.779529999999994000
          Width = 127.747990000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotOriOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTORI]')
        end
        object rllTotDes: TfrxMemoView
          Left = 481.600000000000000000
          Top = 1.779529999999994000
          Width = 102.425196850393700000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotDesOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTDES]')
        end
        object rllTotDup: TfrxMemoView
          Left = 586.000000000000000000
          Top = 1.779529999999994000
          Width = 128.881889763779500000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotDupOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTDUP]')
        end
        object rllMensagem: TfrxMemoView
          Left = 5.759060000000000000
          Top = 34.779530000000020000
          Width = 710.399690000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'VALOR QUE LEVAMOS A D'#201'BITO DE SUA CONTA REFERENTE AO(S) [QTDREG]' +
              ' PEDIDO(S) ACIMA.'
            '[MSGAGR]')
          ParentFont = False
        end
        object rllCidDta: TfrxMemoView
          Left = 298.820470000000000000
          Top = 82.779530000000030000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTAEXT]')
          ParentFont = False
        end
        object rllLinAss: TfrxLineView
          Left = 295.424120000000000000
          Top = 124.944960000000000000
          Width = 419.527830000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 295.496290000000000000
          Top = 128.504020000000000000
          Width = 417.561780000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
        end
        object rlbCOMAGR: TfrxMemoView
          Left = 15.118120000000000000
          Top = 150.401670000000000000
          Width = 691.275590549999900000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbSubTot: TfrxPageFooter
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 430.866420000000000000
        Width = 718.110700000000000000
        object Shape2: TfrxShapeView
          Left = -0.240940000000000000
          Top = 1.000000000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object rllSubTot: TfrxMemoView
          Left = 472.040940000000000000
          Top = 1.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'SUBTOTAL :')
        end
        object rllContinua: TfrxMemoView
          Left = 13.606299210000000000
          Top = 22.677180000000020000
          Width = 691.275590550000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'I M P R E S S '#195' O   C O N T I N U A   N A   P R '#211' X I M A   P '#193' ' +
              'G I N A')
          ParentFont = False
        end
        object rllTotDup2: TfrxMemoView
          Left = 569.354360000000000000
          Top = 1.000000000000000000
          Width = 146.645640000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotDup2OnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTDUP2]')
        end
      end
    end
  end
  object frxCompMod3M2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41582.726294849500000000
    ReportOptions.LastChange = 41583.364415682910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValOri: Double;'
      '  fltValDes: Double;                                         '
      '  fltTotOri: Double;'
      '  fltTotDes: Double;'
      '  fltTotDup: Double;      '
      
        '  intTotReg: Integer;                                           ' +
        '        '
      ''
      ''
      
        'procedure rllValOriOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                                ' +
        '    '
      'begin'
      
        '  fltValOri := <frxrelatorio."CTR_VALDUP"> / ((100 - <frxrelator' +
        'io."CLI_DESCON">) / 100);'
      ''
      
        '  rllValOri.Text := FormatFloat('#39'#,##0.00'#39', fltValOri);         ' +
        '                                                                ' +
        ' '
      '    '
      '  fltTotOri := fltTotOri + fltValOri;'
      'end;'
      ''
      
        'procedure rllValDesOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                                ' +
        '  '
      'begin'
      ''
      
        '  fltValDes := (<frxrelatorio."CTR_VALDUP"> - (<frxrelatorio."CT' +
        'R_VALDUP"> / ((100 - <frxrelatorio."CLI_DESCON">) / 100))) * (- ' +
        '1);'
      ''
      '  rllValDes.Text := FormatFloat('#39'#,##0.00'#39', fltValDes);'
      ''
      
        '  fltTotDes := fltTotDes + fltValDes;                           ' +
        '                                                            '
      'end;'
      ''
      'procedure rllTotOriOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotOri.Text := FormatFloat('#39'#,##0.00'#39', fltTotOri);         ' +
        '                                                             '
      'end;'
      ''
      'procedure rllTotDesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotDes.Text := FormatFloat('#39'#,##0.00'#39', fltTotDes);  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  intTotReg := intTotReg + 1;                                   ' +
        '                               '
      'end;'
      ''
      'procedure rllValDupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotDup := fltTotDup + <frxrelatorio."CTR_VALDUP">;         ' +
        '                                                     '
      'end;'
      ''
      'procedure rllTotDupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotDup.Text := FormatFloat('#39'#,##0.00'#39', fltTotDup);         ' +
        '                                                               '
      'end;'
      ''
      'procedure qckPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin     '
      '    '
      'end;'
      ''
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCOMAGR.Text := CFG_COMAGR;  '
      'end;'
      ''
      'begin                             '
      '  fltTotOri := 0;'
      '  fltTotDes := 0;'
      '  fltTotDup := 0;                                    '
      '  intTotReg := 0;            '
      'end.')
    OnUserFunction = frxCompMod3JUserFunction
    Left = 48
    Top = 185
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxVariaveis'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 139.435326614684900000
      PaperSize = 256
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 796.800000000000000000
        object DMPCommand1: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 124.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
      object rlbTitulo: TfrxGroupHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 68.000000000000000000
        Width = 796.800000000000000000
        Condition = 'frxRelatorio."NUMAGR"'
        ReprintOnNewPage = True
        StartNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 34.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ENDCLI]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMCLI]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."NUMAGR"]'
            ' ')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TELCLI]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PAGINA :')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NOTA DE DEBITO No :')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TELEFONE :')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ENDERECO : ')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CLIENTE  :')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMISSAO  :')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VENCIMENTO :')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]'
            ' ')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'VENCIM.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. LIQUIDO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DESCONTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ORIGINAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMFAN]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FANTASIA :')
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 796.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Columns = 1
        ColumnWidth = 585.120000000000000000
        ColumnGap = 28.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo4: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValDupOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValDes: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValDesOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VALDES')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValOri: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValOriOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VALORI')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_PARCEL"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTotGer: TfrxPageFooter
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 272.000000000000000000
        Width = 796.800000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object rllTotal: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL :')
          TruncOutboundText = False
        end
        object rllLinha1: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object rllLinha2: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '|')
          TruncOutboundText = False
        end
        object rllTotOri: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotOriOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'TOTORI')
          TruncOutboundText = False
        end
        object rllTotDes: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotDesOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'TOTDES')
          TruncOutboundText = False
        end
        object rllTotDup: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotDupOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TESTE')
          TruncOutboundText = False
        end
        object rllMensagem: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 729.600000000000000000
          Height = 51.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'VALOR QUE LEVAMOS A DEBITO DE SUA CONTA REFERENTE AO(S) [QTDREG]' +
              ' PEDIDO(S) ACIMA.'
            '[MSGAGR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCidDta: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 119.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTAEXT]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllLinAss: TfrxDMPLineView
          Left = 321.600000000000000000
          Top = 161.500000000000000000
          Width = 422.400000000000000000
          Color = clBlack
        end
        object rllrazsoc: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 170.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMCLI]')
          TruncOutboundText = False
        end
        object rlbCOMAGR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxCadRec: TfrxDBDataset
    UserName = 'frxCadRec'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 305
    Top = 16
  end
  object frxCompMod2J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41563.614705428200000000
    ReportOptions.LastChange = 41564.664954386570000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotal : Double;'
      '  fltTotDesc : Double;'
      '    '
      'procedure rlbDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotal := fltTotal + <frxRelatorio."CTR_VALDUP">;'
      
        '  fltTotDesc := fltTotDesc + <frxRelatorio."CTR_VALDES">;       ' +
        '                        '
      'end;'
      ''
      'procedure rllTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotal.Text := FormatFloat('#39'#,##0.00'#39', fltTotal);'
      'end;'
      ''
      'procedure rllDescontoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllDesconto.Text := FormatFloat('#39'#,##0.00'#39', fltTotDesc);'
      'end;'
      ''
      'procedure rllLiquidoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllLiquido.Text := FormatFloat('#39'#,##0.00'#39', ( fltTotal - fltTot' +
        'Desc ) );'
      '  fltTotDesc      := 0;                              '
      '  fltTotal        := 0;      '
      'end;'
      ''
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCOMAGR.Text := CFG_COMAGR;  '
      'end;'
      ''
      'begin'
      '  fltTotal   := 0;'
      '  fltTotDesc := 0;'
      '    '
      'end.')
    OnUserFunction = frxCompMod2JUserFunction
    Left = 138
    Top = 128
    Datasets = <
      item
        DataSet = frxCadRec
        DataSetName = 'frxCadRec'
      end
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxVariaveis'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      BottomMargin = 2.500000000000000000
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 109.500000000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object frxGenEMP_NOMEMP: TfrxMemoView
          Left = 18.600000000000000000
          Top = 34.000000000000000000
          Width = 436.081880000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
        end
        object Memo1: TfrxMemoView
          Left = 508.400000000000000000
          Top = 34.000000000000000000
          Width = 267.666110000000100000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TELEMP]')
        end
        object Memo2: TfrxMemoView
          Left = 18.600000000000000000
          Top = 51.000000000000000000
          Width = 436.081880000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ENDEMP]')
        end
        object Memo3: TfrxMemoView
          Left = 467.400000000000000000
          Top = 51.000000000000000000
          Width = 309.240940000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[BAIEMP]')
        end
        object Memo4: TfrxMemoView
          Left = 17.600000000000000000
          Top = 68.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CEPEMP]')
        end
        object Memo5: TfrxMemoView
          Left = 259.200000000000000000
          Top = 68.000000000000000000
          Width = 447.874150000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CIDEMP]')
        end
        object Memo6: TfrxMemoView
          Left = 711.156030000000000000
          Top = 68.000000000000000000
          Width = 64.705380000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[ESTEMP]')
        end
        object Memo7: TfrxMemoView
          Left = 17.600000000000000000
          Top = 85.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CNPJ: [CGCEMP]')
        end
        object Memo8: TfrxMemoView
          Left = 259.200000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'IE: [IESEMP]')
        end
        object Memo9: TfrxMemoView
          Left = 518.400000000000000000
          Top = 85.000000000000000000
          Width = 257.461410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Data de Emiss'#227'o: [DTAEMI]')
        end
        object Line1: TfrxLineView
          Left = 16.800000000000000000
          Top = 109.500000000000000000
          Width = 764.598425200000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 16.800000000000000000
          Top = 25.500000000000000000
          Width = 764.522820000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo13: TfrxMemoView
          Left = 467.661720000000000000
          Top = 34.015770000000010000
          Width = 40.894310000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TEL:')
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 270.149660000000000000
        Top = 604.724800000000000000
        Width = 793.701300000000000000
        object Line7: TfrxLineView
          Left = 16.800000000000000000
          Top = 245.413420000000000000
          Width = 764.598425200000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo50: TfrxMemoView
          Left = 550.799999999999900000
          Top = 67.913419999999970000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'P/ Aval do Sacado')
        end
        object Line8: TfrxLineView
          Left = 546.000000000000000000
          Top = 126.413420000000000000
          Width = 230.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo54: TfrxMemoView
          Left = 512.097650000000100000
          Top = 128.913420000000000000
          Width = 29.102350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Aval.')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 469.918120000000000000
          Top = 145.913420000000000000
          Width = 71.281880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CPF/CNPJ.')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Left = 22.400000000000000000
          Top = 195.413420000000000000
          Width = 230.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Left = 546.000000000000000000
          Top = 195.413420000000000000
          Width = 230.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo56: TfrxMemoView
          Left = 36.800000000000000000
          Top = 203.913420000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Assinatura do Sacado')
        end
        object Memo57: TfrxMemoView
          Left = 326.400000000000000000
          Top = 203.913420000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Data do Aceite')
        end
        object Memo58: TfrxMemoView
          Left = 493.200000000000000000
          Top = 203.913420000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Conj.')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 493.200000000000000000
          Top = 220.913420000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CPF.')
          ParentFont = False
        end
        object Line16: TfrxLineView
          Left = 304.803340000000000000
          Top = 195.413420000000000000
          Width = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 351.378170000000000000
          Top = 195.413420000000000000
          Width = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line18: TfrxLineView
          Left = 396.512060000000000000
          Top = 195.413420000000000000
          Width = 83.149660000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line19: TfrxLineView
          Left = 346.716760000000000000
          Top = 193.637910000000000000
          Width = 11.338590000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line20: TfrxLineView
          Left = 393.071120000000000000
          Top = 193.637910000000000000
          Width = 11.338590000000000000
          Height = -22.677180000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line13: TfrxLineView
          Left = 17.897650000000000000
          Top = 67.913419999999970000
          Width = 761.952755910000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 18.897650000000000000
          Top = 4.338589999999954000
          Width = 761.952755910000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotal: TfrxMemoView
          Left = 687.874460000000000000
          Top = 8.118119999999976000
          Width = 91.388930000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTGER]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 563.149970000000100000
          Top = 8.118119999999976000
          Width = 121.625170000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL BRUTO:')
          ParentFont = False
        end
        object rllDesconto: TfrxMemoView
          Left = 687.874460000000000000
          Top = 27.015769999999980000
          Width = 91.388930000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllDescontoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTALDESC')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 563.149970000000100000
          Top = 27.015769999999980000
          Width = 121.625170000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          ParentFont = False
        end
        object rllLiquido: TfrxMemoView
          Left = 687.874460000000000000
          Top = 45.913419999999970000
          Width = 91.388930000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllLiquidoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTALLIQ')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 563.149970000000100000
          Top = 45.913419999999970000
          Width = 121.625170000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL L'#205'QUIDO:')
          ParentFont = False
        end
        object rlbCOMAGR: TfrxMemoView
          Left = 15.118120000000000000
          Top = 245.669450000000000000
          Width = 767.924800000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 525.354670000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'rlbDuplicatasOnBeforePrint'
        Columns = 2
        ColumnWidth = 389.291338582677200000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo51: TfrxMemoView
          Left = 192.163915000000000000
          Width = 66.066110000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 260.951020000000000000
          Width = 116.484910000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 16.600000000000000000
          Width = 171.439270000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCadRec: TfrxHeader
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 188.976500000000000000
        Width = 793.701300000000000000
        Child = frxCompMod2J.rlbCliente
        object Memo10: TfrxMemoView
          Left = 74.897650000000000000
          Top = 9.279529999999994000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FATURA')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 55.697650000000000000
          Top = 26.279529999999990000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 113.600000000000000000
          Top = 26.279529999999990000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'mero')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 113.297650000000000000
          Top = 43.279529999999990000
          Width = 126.236240000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMAGR]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 18.697650000000000000
          Top = 43.279529999999990000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTGER]')
          ParentFont = False
        end
        object subParcelas: TfrxSubreport
          Left = 246.615770000000000000
          Top = 42.330711100000000000
          Width = 530.343290000000000000
          Height = 18.897637800000000000
          Page = frxCompMod2J.Page2
        end
        object Memo18: TfrxMemoView
          Left = 374.137230000000000000
          Top = 9.279529999999994000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 315.137230000000000000
          Top = 26.279529999999990000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 420.737230000000000000
          Top = 26.279529999999990000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'mero')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 669.825480000000000000
          Top = 9.279529999999994000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Data do'
            'Vencimento')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 18.118120000000000000
          Top = 41.574829999999990000
          Width = 761.952755910000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbCliente: TfrxChild
        FillType = ftBrush
        Height = 222.992270000000000000
        Top = 279.685220000000000000
        Width = 793.701300000000000000
        object Memo29: TfrxMemoView
          Left = 18.897650000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Sacado:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 18.897650000000000000
          Top = 17.000000000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 18.897650000000000000
          Top = 34.000000000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 18.897650000000000000
          Top = 51.000000000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Telefone:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 18.897650000000000000
          Top = 68.000000000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'RG/IE:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 88.897650000000000000
          Width = 670.261410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[NOMCLI]')
        end
        object Memo35: TfrxMemoView
          Left = 88.897650000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ENDCLI]')
        end
        object Memo36: TfrxMemoView
          Left = 88.897650000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CIDCLI]')
        end
        object Memo37: TfrxMemoView
          Left = 88.897650000000000000
          Top = 51.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TELCLI]')
        end
        object Memo38: TfrxMemoView
          Left = 88.897650000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[IESCLI]')
        end
        object Memo39: TfrxMemoView
          Left = 488.897650000000000000
          Top = 17.000000000000000000
          Width = 48.302350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 540.097650000000000000
          Top = 17.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[BAICLI]')
        end
        object Memo41: TfrxMemoView
          Left = 488.897650000000000000
          Top = 34.000000000000000000
          Width = 48.302350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estado:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 540.097650000000000000
          Top = 34.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ESTCLI]')
        end
        object Memo43: TfrxMemoView
          Left = 450.497650000000000000
          Top = 51.000000000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pra'#231'a pgto:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 540.097650000000000000
          Top = 51.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CEPCLI]')
        end
        object Memo45: TfrxMemoView
          Left = 450.497650000000000000
          Top = 68.000000000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CPF/CNPJ:')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 540.097650000000000000
          Top = 68.000000000000000000
          Width = 219.061410000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CGCCLI]')
        end
        object Memo47: TfrxMemoView
          Left = 18.897650000000000000
          Top = 102.000000000000000000
          Width = 754.922820000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[VALEXT]')
        end
        object Memo48: TfrxMemoView
          Left = 18.897650000000000000
          Top = 136.000000000000000000
          Width = 754.922820000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            
              'Reconhe'#231'o(emos) a exatid'#227'o desta duplicata de venda mercantil na' +
              ' import'#226'ncia acima que pagarei(emos) '#224' empresa, ou a sua ordem n' +
              'a pra'#231'a e vencimentos acima indicados.')
        end
        object Memo49: TfrxMemoView
          Left = 316.097650000000000000
          Top = 204.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERENTE FATURAS')
        end
        object Line6: TfrxLineView
          Left = 18.118120000000000000
          Top = 222.992270000000000000
          Width = 761.952755910000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line11: TfrxLineView
          Left = 17.897650000000000000
          Width = 761.952755910000000000
          Color = clBlack
          TagStr = '#FR3 clipboard#'#10'#FR3 clipboard#'#10
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 152.399901580000000000
      PaperHeight = 10.000000000000000000
      PaperSize = 256
      object rlbDupAgr: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 18.897650000000000000
        Width = 576.000000018657400000
        DataSet = frxCadRec
        DataSetName = 'frxCadRec'
        RowCount = 0
        object Memo17: TfrxMemoView
          Left = 189.400000000000000000
          Width = 224.504020000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadRec."NUMDOC"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 24.688250000000000000
          Width = 155.111750000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCadRec."VALDUP"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 420.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCadRec."DTAVEN"]')
          ParentFont = False
        end
      end
    end
  end
  object frxCompMod2M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41563.614705428200000000
    ReportOptions.LastChange = 41564.515489305600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbCOMAGROnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbCOMAGR.Text := CFG_COMAGR;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxCompMod2MUserFunction
    Left = 48
    Top = 128
    Datasets = <
      item
        DataSet = frxCadRec
        DataSetName = 'frxCadRec'
      end
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' frxVariaveis'
        Value = Null
      end
      item
        Name = 'CFG_COMAGR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelatorio: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 296.862308276425900000
      PaperSize = 9
      FontStyle = []
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 796.800000000000000000
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object frxGenEMP_NOMEMP: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TELEMP]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ENDEMP]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[BAIEMP]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CEPEMP]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 68.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CIDEMP]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[ESTEMP]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CNPJ: [CGCEMP]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'IE: [IESEMP]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 85.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Data de Emissao: [DTAEMI]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TEL:')
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 544.000000000000000000
        Width = 796.800000000000000000
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'P/ Aval do Sacado')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Left = 552.000000000000000000
          Top = 59.500000000000000000
          Width = 220.800000000000000000
          Color = clBlack
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Aval.')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 85.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CPF/CNPJ.')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Width = 230.400000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Left = 552.000000000000000000
          Top = 127.500000000000000000
          Width = 220.800000000000000000
          Color = clBlack
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 136.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Assinatura do Sacado')
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 136.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Data do Aceite')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Conj.')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 153.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CPF.')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 119.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '___ /___ /_______')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
        object rlbCOMAGR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCOMAGROnBeforePrint'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 493.000000000000000000
        Width = 796.800000000000000000
        Columns = 2
        ColumnWidth = 393.600000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo51: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCadRec: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 153.000000000000000000
        Width = 796.800000000000000000
        Child = frxCompMod2M.rlbCliente
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FATURA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Valor')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Numero')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMAGR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTGER]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Numero')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Data do'
            'Vencimento')
          TruncOutboundText = False
        end
        object subParcelas: TfrxSubreport
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          Page = frxCompMod2M.Page1
        end
      end
      object rlbCliente: TfrxChild
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 238.000000000000000000
        Width = 796.800000000000000000
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Sacado...: ')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Endereco.:')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Municipio:')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Telefone.:')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'RG/IE....:')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[NOMCLI]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 34.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ENDCLI]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CIDCLI]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 68.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TELCLI]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 85.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[IESCLI]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 480.000000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Bairro:')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[BAICLI]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 480.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Estado:')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[ESTCLI]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Praca pgto:')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 68.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CEPCLI]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CPF/CNPJ..:')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 85.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CGCCLI]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 758.400000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[VALEXT]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 758.400000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            
              'Reconheco(emos) a exatidao desta duplicata de venda mercantil na' +
              ' importancia acima que pagarei(emos) a empresa ou a sua ordem na' +
              ' praca e vencimentos acima indicados')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 204.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REFERENTE FATURAS')
          TruncOutboundText = False
        end
        object DMPLine11: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 229.500000000000000000
          Width = 768.000000000000000000
          Color = clBlack
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 152.399901575063600000
      PaperHeight = 8.995827523528058000
      PaperSize = 256
      FontStyle = []
      object rlbDupAgr: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 576.000000000000000000
        DataSet = frxCadRec
        DataSetName = 'frxCadRec'
        RowCount = 0
        object DMPMemo17: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCadRec."NUMDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCadRec."VALDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCadRec."DTAVEN"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxComprovante: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43678.651363310200000000
    ReportOptions.LastChange = 43678.651363310200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxComprovanteUserFunction
    Left = 236
    Top = 82
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
  object frxCompMod4_40c: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 43809.388845821760000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxCompMod4_40cUserFunction
    Left = 248
    Top = 182
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'CIDEMP'
        Value = #39'RIBEIR'#195'O PRETO'#39
      end
      item
        Name = 'VALEXT'
        Value = #39'152,54'#39
      end
      item
        Name = 'NOMEMP'
        Value = #39'EMPRESSA 001'#39
      end
      item
        Name = 'DTAEMI'
        Value = #39'01/01/2019'#39
      end
      item
        Name = 'IESEMP'
        Value = #39'562039002114'#39
      end
      item
        Name = 'TELCLI'
        Value = #39'16993335992'#39
      end
      item
        Name = 'BAICLI'
        Value = #39'HOPE'#39
      end
      item
        Name = 'NOMCLI'
        Value = #39'JULIANO HIROSHI ENDO'#39
      end
      item
        Name = 'CGCCLI'
        Value = #39'08346159000174'#39
      end
      item
        Name = 'ENDCLI'
        Value = #39'RUA DAS FLORES'#39
      end
      item
        Name = 'ESTEMP'
        Value = #39'SP'#39
      end
      item
        Name = 'CEPEMP'
        Value = #39'14270000'#39
      end
      item
        Name = 'NUMAGR'
        Value = #39'4569823571258'#39
      end
      item
        Name = 'VS_Date'
        Value = #39'09/12/2019'#39
      end
      item
        Name = 'BAIEMP'
        Value = #39'NOVA ROMA'#39
      end
      item
        Name = 'CIDCLI'
        Value = #39'S'#195'O SIM'#195'O'#39
      end
      item
        Name = 'QTDREG'
        Value = #39'1'#39
      end
      item
        Name = 'CFG_COMAGR'
        Value = #39'MATHEUS ALACRINO TESTE'#39
      end
      item
        Name = 'IESCLI'
        Value = #39'582034600111'#39
      end
      item
        Name = 'MSGAGR'
        Value = #39'MENSAGEM AGRUPAMENTO'#39
      end
      item
        Name = 'DTAEXT'
        Value = #39'01/01/2001'#39
      end
      item
        Name = 'CEPCLI'
        Value = #39'14270000'#39
      end
      item
        Name = 'NOMFAN'
        Value = #39'JULIANO HIROSHI ENDO'#39
      end
      item
        Name = 'TOTGER'
        Value = #39'12,54'#39
      end
      item
        Name = 'ESTCLI'
        Value = #39'SP'#39
      end
      item
        Name = 'TELEMP'
        Value = #39'1639545998'#39
      end
      item
        Name = 'CGCEMP'
        Value = #39'52688892000169'#39
      end
      item
        Name = 'ENDEMP'
        Value = #39'RUA DAS FLORES'#39
      end>
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
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'AGRUP...: [frxRelatorio."NUMAGR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CLIENTE.: [frxRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baCenter
          Top = 153.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'AGRUPAMENTO DE T'#205'TULOS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA:[DATE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPROVANTE DE AGRUPAMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Top = 85.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'EMPRESA.: [frxRelatorio."NOMEMP"]'
            ' ')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo8: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOC.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxDMPMemoView
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[Trim(<frxRelatorio."NUMDOC">)]')
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
        object DMPMemo10: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTR_VALDUP">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 340.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL BRUTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."CTR_VALDUP">)- SUM(<frxRelatorio."CTR_VALDES' +
              '">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL L'#205'QUIDO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalto: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 51.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
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
    PdfA = True
    Left = 376
    Top = 184
  end
  object frxDupJun: TfrxDBDataset
    UserName = 'frxDupJun'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 376
    Top = 16
  end
end
