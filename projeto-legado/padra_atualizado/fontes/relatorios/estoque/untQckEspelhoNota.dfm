object frmQckEspelhoNota: TfrmQckEspelhoNota
  Left = 0
  Top = 0
  ClientHeight = 258
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelEspelhoNotaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44949.712441724500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltBasIcmFor: Double;'
      '  fltValIcmFor: Double;'
      '  fltBasIcmTot: Double;'
      '  fltValIcmTot: Double;'
      '  blnTemConFre: Boolean;'
      ''
      'procedure rdbTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      '    rdbTotal.DataField := '#39'UNITAR_IMP'#39';'
      '  End'
      ''
      '  Else If strTipCalc = '#39'C'#39' Then'
      '  Begin'
      '    If intOpcVariacao = 1 Then'
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39', <frxRelatorio."' +
        'PRECOM">)'
      '    Else'
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39',fCalculaValorCom' +
        'pra(<frxRelatorio."PRECOM">,<frxRelatorio."DESF01">,<frxRelatori' +
        'o."DESF02">,<frxRelatorio."DESF03">,<frxRelatorio."DESF04">,<frx' +
        'Relatorio."DESF05">,<frxRelatorio."DESF06">,<frxRelatorio."ACRFI' +
        'N">));'
      '    rdbTotal.DataField := '#39#39
      '  end'
      ''
      '  Else rdbTotal.DataField := '#39'UNIPED'#39';'
      'end;'
      ''
      'procedure rdbValPerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."UNITAR_IMP">);'
      '  End'
      '  Else If intOpcVariacao = 3 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."PRECOM">);'
      '  End Else'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(<frxRelatorio."PRECO' +
        'M">,<frxRelatorio."DESF01">,<frxRelatorio."DESF02">,<frxRelatori' +
        'o."DESF03">,<frxRelatorio."DESF04">,<frxRelatorio."DESF05">,<frx' +
        'Relatorio."DESF06">,<frxRelatorio."ACRFIN">,<frxRelatorio."UNITA' +
        'R">,<frxRelatorio."UNIPED">);'
      '  End;'
      'end;'
      ''
      'procedure rdbValorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbValor.Text := FormatFloat('#39'###,#0.00'#39', fVariacao);'
      'end;'
      ''
      ''
      'procedure rdbTotvarDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarD.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoD);'
      'end;'
      ''
      'procedure rdbTotvarFOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarF.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoF);'
      'end;'
      ''
      'procedure rdbTotvarGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarG.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoG);'
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  If <frxRelatorio."PEDCOM"> <> '#39#39' Then'
      '  Begin'
      '    rllPedCom.Visible  := True;'
      '    rllConPag2.Visible := True;'
      '    rdbConPag2.Visible := True;'
      '  End'
      '  Else'
      '  Begin'
      '    rllConPag2.Visible := False;'
      '    rdbConPag2.Visible := False;'
      '    rllPedCom.Visible  := False;'
      '  End;'
      ''
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODFOR">);'
      '  mmoCentroCusto.Text := fRetCentroCustoDoc;'
      ''
      '  ChildGNRE.Visible := fMontaGNRE;'
      'End;'
      ''
      'procedure rlbResumoGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := fltBasIcmFor + <frxRelatorio."GER_BASICM">;'
      '  fltValIcmFor := fltValIcmFor + <frxRelatorio."GER_TOTICM">;'
      '  fltBasIcmTot := fltBasIcmTot + <frxRelatorio."GER_BASICM">;'
      '  fltValIcmTot := fltValIcmTot + <frxRelatorio."GER_TOTICM">;'
      'end;'
      ''
      'procedure ChildFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildFrete.Visible := fTemConhecimentoFrete(<frxRelatorio."AUT' +
        'GER">, <frxRelatorio."ESPDOC">);'
      'end;'
      ''
      'procedure rlbDetGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure qckPaginaAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;'
      '  fltValIcmFor := 0.0;'
      '  fltBasIcmTot := 0.0;'
      '  fltValIcmTot := 0.0;'
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;'
      '  fltValIcmFor := 0.0;'
      'end;'
      ''
      'procedure mmoCodIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildNumLote.Visible := <frxRelatorio."NUMLOT"> <> '#39#39';'
      'end;'
      ''
      
        'procedure childParcelasConFreteOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'begin'
      
        '  childParcelasConFrete.Visible := (fDuplicatasConhecimentoFrete' +
        '(<frxDBDConFre."NUMDOC">, <frxDBDConFre."ESPDOC">, <frxDBDConFre' +
        '."SERIE_">, <frxDBDConFre."CODTRA">)  <> '#39#39');'
      'end;'
      ''
      'procedure ChildVendorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildVendor.Visible := fRetVenDor <> '#39#39';'
      'end;'
      ''
      
        'procedure childOutrasDespesasOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  childOutrasDespesas.Visible := fRetOutrasDespesas <> '#39#39';'
      'end;'
      ''
      'procedure ChildICMAntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  childICMAnt.Visible := fRetICMSAntecipado <> '#39#39';'
      'end;'
      ''
      'procedure ChildICMAntSepOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  childICMAntSep.Visible := fRetICMSAntecipado <> '#39#39';'
      'end;'
      ''
      'procedure rlbTotGeralOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure mmoMsg1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoMsg1.Visible := blnTemConFre;'
      'end;'
      ''
      'procedure mmoTitValPropOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  blnTemConFre := True;'
      'end;'
      ''
      'procedure masConFreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  memModFre.Memo.clear;'
      
        '  memModFre.Memo.Add(fRetModalidadeFrete(<frxRelatorio."MODFRE">' +
        '));'
      'end;'
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);'
      'end;'
      ''
      'BEGIN'
      '  blnTemConFre := False;'
      'END.')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 48
    Top = 64
    Datasets = <
      item
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
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
    object qckPaginaA: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      OnBeforePrint = 'qckPaginaAOnBeforePrint'
      FontStyle = [fsx12cpi]
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaM.ChildNumLote
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rdbMarca: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdblocFis: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbChqVista: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbQtdIte: TfrxDMPMemoView
          Left = 748.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbOrdPag: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotal: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999.99')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValPer: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValPerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '100.00%')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValor: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValorOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '99,999,999,99')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQICM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo92: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoCodIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCodIteOnBeforePrint'
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoPcgObs: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1497.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'OBS.PEDIDO COMPRA: [frxRelatorio."PCGOBS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 119.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object rllDescri: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 34.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FIS.')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'PR.COMP')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VARIAC'
            'PORC.     VALOR')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.ICM')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 1440.000000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.IPI')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.UNIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
        object rllNomeRelatorioA: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 221.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fornecedor:')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Entrada:')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pgto (NF):')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vencimento/Valor:')
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 480.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#186' Doc:')
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Serie:')
          TruncOutboundText = False
        end
        object rllPedCom: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Ped. Compra: [<frxRelatorio."PEDCOM">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 998.400000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP:')
          TruncOutboundText = False
        end
        object DMPMemo93: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]-[frxRelatorio."NOMFOR"]')
          TruncOutboundText = False
        end
        object rllDtaEnt: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object rllDtaDoc: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          TruncOutboundText = False
        end
        object DMPMemo138: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."ESPDOC"]-[frxRelatorio."C' +
              'ODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo140: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
          TruncOutboundText = False
        end
        object rdbCndPag: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object rlbCFOP: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 34.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCFOPOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          TruncOutboundText = False
        end
        object rllParcelas: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1488.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[fFormataCpfCgc(<frxRelatorio."_C_G_C">,<frxRelatorio."CGCCPF">)' +
              ']')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Operador:')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object rllConPag2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pgto (Ped.Compra):')
          TruncOutboundText = False
        end
        object rdbConPag2: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1257.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[fFormataConPag]')
          TruncOutboundText = False
        end
        object mmoCentroCusto: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 68.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 1088.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
          TruncOutboundText = False
        end
        object rllMensagemRodape: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 864.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '*Esta impress'#227'o '#233' a pr'#233'via da Nota de Entrada. '
            
              '**Os dados somente ser'#227'o efetivados ap'#243's confirma'#231#227'o e grava'#231#227'o ' +
              'da entrada de mercadorias.')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoMsg1: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoMsg1OnBeforePrint'
          Memo.UTF8W = (
            
              '[IIF(blnDedFre,  '#39'(1) Total do Conhecimento de Frete com deducao' +
              ' de ICMS'#39', '#39#39')')
          TruncOutboundText = False
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbResumoGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaM.ChildFrete
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcm: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo26OnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcm: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitDocDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoDocDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarD: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotD: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Perc. de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercFrete(SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo),  SUM(<' +
              'frxRelatorio."TOTFRE">,rlbDetGrupo) , SUM(<frxRelatorio."FRECON"' +
              '>,rlbDetGrupo), SUM(<frxRelatorio."VAFRAN">,rlbDetGrupo) )]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 85.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '%')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 986.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'rlbTotGeralOnAfterPrint'
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcmTot: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcmTot: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitTotDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTotDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarG: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarGOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotG: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo105: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo106: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 204.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODFOR"'
        ReprintOnNewPage = True
      end
      object GroupFooterFor: TfrxGroupFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 867.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcmFor: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcmFor: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitForDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoForDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo82: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarF: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarFOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Fornecedor:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotF: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo95: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo97: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'ChildFreteOnBeforePrint'
        Child = frxRelEspelhoNotaM.ChildGNRE
        PrintChildIfInvisible = True
        object subConFre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelEspelhoNotaM.pagConFre
        end
      end
      object ChildGNRE: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelEspelhoNotaM.ChildVendor
        PrintChildIfInvisible = True
        object subrepGNRE: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelEspelhoNotaM.Page1
        end
      end
      object ChildNumLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE: [frxRelatorio."NUMLOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildVendor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'ChildVendorOnBeforePrint'
        Child = frxRelEspelhoNotaM.ChildSeparadorVendor
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Vendor: ')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 1411.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetVendor]')
          TruncOutboundText = False
        end
      end
      object ChildSeparadorVendor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelEspelhoNotaM.ChildICMAnt
        PrintChildIfInvisible = True
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object childOutrasDespesas: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 799.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'childOutrasDespesasOnBeforePrint'
        Child = frxRelEspelhoNotaM.childSepadorOutDesp
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo62: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Outras Despesas: ')
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetOutrasDespesas]')
          TruncOutboundText = False
        end
      end
      object childSepadorOutDesp: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 833.000000000000000000
        Width = 1507.200000000000000000
        PrintChildIfInvisible = True
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object ChildICMAnt: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'ChildICMAntOnBeforePrint'
        Child = frxRelEspelhoNotaM.ChildICMAntSep
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo74: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetICMSAntecipado]')
          TruncOutboundText = False
        end
        object DMPMemo90: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ICMS Antecipado:')
          TruncOutboundText = False
        end
      end
      object ChildICMAntSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 765.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'ChildICMAntSepOnBeforePrint'
        Child = frxRelEspelhoNotaM.childOutrasDespesas
        PrintChildIfInvisible = True
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
    end
    object pagConFre: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object heaConFre: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo94: TfrxDMPMemoView
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONHECIMENTO DE FRETE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo96: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo98: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR'
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONDICAO DE PAGAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object mmoTitValProp: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 144.000000000000000000
          Height = 34.000000000000000000
          OnAfterPrint = 'mmoTitValPropOnAfterPrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR PROPORCIONAL'
            'AO DOCUMENTO[IIF(blnDedFre, '#39'(1)'#39', '#39#39')]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object masConFre: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 85.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'masConFreOnBeforePrint'
        Child = frxRelEspelhoNotaM.childParcelasConFrete
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
        RowCount = 0
        object frxDBDConFrefrxDBDConFre: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBConFre
          DataSetName = 'frxDBDConFre'
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxDBDConFre."NUMDOC"]-[frxDBDConFre."ESPDOC"]-[frxDBDConFre."C' +
              'ODEMP"]-[frxDBDConFre."SERIE_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBDConFre."CODTRA"]-[frxDBDConFre."NOMTRA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDConFre."VALCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[fCondPagtoConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCon' +
              'Fre."SERIE_">, <frxDBDConFre."CODTRA">, <frxDBDConFre."CODEMP">,' +
              ' <frxDBDConFre."DTADOC">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo102: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fretSomaConhecimento(<frxDBDConFre."VALCON">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object memModFre: TfrxDMPMemoView
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object childParcelasConFrete: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'childParcelasConFreteOnBeforePrint'
        Child = frxRelEspelhoNotaM.chiSeparador
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo100: TfrxDMPMemoView
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            
              '[fDuplicatasConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCo' +
              'nFre."ESPDOC">, <frxDBDConFre."SERIE_">, <frxDBDConFre."CODTRA">' +
              ')]')
          TruncOutboundText = False
        end
      end
      object chiSeparador: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
        RowCount = 0
        object DMPMemo84: TfrxDMPMemoView
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'GNRE:')
          TruncOutboundText = False
        end
        object frxGNREGNR_NUMGNR: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_NUMGNR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Memo.UTF8W = (
            '[frxGNRE."GNR_NUMGNR"]')
          TruncOutboundText = False
        end
        object frxGNREGNR_VALGNR: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_VALGNR"]')
          TruncOutboundText = False
        end
        object frxGNREGNR_CODFOR: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_CODFOR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Memo.UTF8W = (
            '[frxGNRE."GNR_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DT.VENC.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 51.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxRelEspelhoNotaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44949.750147685180000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltBasIcmFor: Double;'
      '  fltValIcmFor: Double;'
      '  fltBasIcmTot: Double;'
      '  fltValIcmTot: Double;'
      
        '  blnTemConFre: Boolean;                                        ' +
        '         '
      ''
      'procedure rdbTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      '    rdbTotal.DataField := '#39'UNITAR_IMP'#39';      '
      '  End'
      '    '
      '  Else If strTipCalc = '#39'C'#39' Then'
      '  Begin                                      '
      '    If intOpcVariacao = 1 Then'
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39', <frxRelatorio."' +
        'PRECOM">) '
      '    Else              '
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39',fCalculaValorCom' +
        'pra(<frxRelatorio."PRECOM">,<frxRelatorio."DESF01">,<frxRelatori' +
        'o."DESF02">,<frxRelatorio."DESF03">,<frxRelatorio."DESF04">,<frx' +
        'Relatorio."DESF05">,<frxRelatorio."DESF06">,<frxRelatorio."ACRFI' +
        'N">));'
      
        '    rdbTotal.DataField := '#39#39'                                    ' +
        '      '
      '  end'
      '    '
      '  Else rdbTotal.DataField := '#39'UNIPED'#39';'
      'end;'
      ''
      'procedure rdbValPerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."UNITAR_IMP">);'
      '  End '
      '  Else If intOpcVariacao = 3 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."PRECOM">);'
      '  End Else'
      '  Begin              '
      
        '    rdbValPer.Text := fCalculaValPercentual(<frxRelatorio."PRECO' +
        'M">,<frxRelatorio."DESF01">,<frxRelatorio."DESF02">,<frxRelatori' +
        'o."DESF03">,<frxRelatorio."DESF04">,<frxRelatorio."DESF05">,<frx' +
        'Relatorio."DESF06">,<frxRelatorio."ACRFIN">,<frxRelatorio."UNITA' +
        'R">,<frxRelatorio."UNIPED">);'
      '  End;            '
      ''
      '  If blnVariacao Then'
      '  Begin              '
      '    If (fStrToFloat(rdbValPer.Text) > 0) Then'
      '      rdbValPer.Font.Color := clBlue'
      '    Else If (fStrToFloat(rdbValPer.Text) < 0) Then'
      '      rdbValPer.Font.Color := clRed'
      '    Else'
      '      rdbValPer.Font.Color := clBlack;'
      '  End;      '
      'end;'
      ''
      'procedure rdbValorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbValor.Text := FormatFloat('#39'###,#0.00'#39', fVariacao);'
      ''
      '  If (blnVariacao) Then'
      '  Begin              '
      '    If (fStrToFloat(rdbValor.Text) > 0) Then'
      '      rdbValor.Font.Color := clBlue'
      '    Else If (fStrToFloat(rdbValor.Text) < 0) Then'
      '      rdbValor.Font.Color := clRed'
      '    Else'
      '      rdbValor.Font.Color := clBlack;'
      '  End;        '
      'end;'
      ''
      ''
      'procedure rdbTotvarDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotVarD.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoD);      ' +
        '                                                      '
      'end;'
      ''
      'procedure rdbTotvarFOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarF.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoF);  '
      'end;'
      ''
      'procedure rdbTotvarGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarG.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoG);  '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  If <frxRelatorio."PEDCOMDOC"> <> '#39#39' Then'
      '  Begin'
      '    rllPedCom.Visible  := True;'
      '    rllConPag2.Visible := True;'
      '    rdbConPag2.Visible := True;  '
      '  End'
      '  Else                      '
      '  Begin'
      '    rllConPag2.Visible := False;'
      '    rdbConPag2.Visible := False;'
      '    rllPedCom.Visible  := False;'
      '  End;'
      '    '
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODFOR">);'
      
        '  mmoCentroCusto.Text := fRetCentroCustoDoc;                    ' +
        '                              '
      ''
      '  ChildGNRE.Visible := fMontaGNRE;'
      'End;'
      '               '
      'procedure rlbResumoGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltBasIcmFor := fltBasIcmFor + <frxRelatorio."GER_BASICM">;   ' +
        '   '
      '  fltValIcmFor := fltValIcmFor + <frxRelatorio."GER_TOTICM">;'
      '  fltBasIcmTot := fltBasIcmTot + <frxRelatorio."GER_BASICM">;'
      '  fltValIcmTot := fltValIcmTot + <frxRelatorio."GER_TOTICM">;'
      'end;'
      '   '
      'procedure ChildFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildFrete.Visible := fTemConhecimentoFrete(<frxRelatorio."AUT' +
        'GER">, <frxRelatorio."ESPDOC">);  '
      'end;'
      ''
      'procedure rlbDetGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      ''
      'procedure qckPaginaAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;      '
      '  fltValIcmFor := 0.0;'
      '  fltBasIcmTot := 0.0;'
      '  fltValIcmTot := 0.0;  '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;            '
      '  fltValIcmFor := 0.0;  '
      'end;'
      ''
      'procedure rdbDescriOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildNumLote.Visible := <frxRelatorio."NUMLOT"> <> '#39#39';        ' +
        '                                   '
      'end;'
      ''
      'procedure ChildVendorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildVendor.Visible := fRetVenDor <> '#39#39';                      ' +
        '                     '
      'end;'
      ''
      
        'procedure childOutrasDespesasOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  childOutrasDespesas.Visible := fRetOutrasDespesas <> '#39#39';      ' +
        '                                     '
      'end;'
      ''
      'procedure ChildICMAntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  childICMAnt.Visible := fRetICMSAntecipado <> '#39#39';              ' +
        '                             '
      'end;'
      ''
      
        'procedure childParcelasConFreteOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'begin'
      
        '  childParcelasConFrete.Visible := (fDuplicatasConhecimentoFrete' +
        '(<frxDBDConFre."NUMDOC">, <frxDBDConFre."ESPDOC">, <frxDBDConFre' +
        '."SERIE_">, <frxDBDConFre."CODTRA">)  <> '#39#39');  '
      'end;'
      ''
      'procedure mmoTitValPropOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  blnTemConFre := True;                   '
      'end;'
      ''
      'procedure mmoMsg1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoMsg1.Visible := blnTemConFre;                              ' +
        '                                   '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memModFre.Text :=  fRetModalidadeFrete(<frxRelatorio."MODFRE">' +
        ');                        '
      'end;'
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);  ' +
        '  '
      'end;'
      '    '
      'BEGIN'
      '  blnTemConFre := False;                            '
      'END.          ')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 288
    Top = 64
    Datasets = <
      item
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
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
    object qckPaginaA: TfrxReportPage
      PaperWidth = 365.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaAOnBeforePrint'
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 49.015770000000000000
        Top = 427.086890000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'rlbDetGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaJ.ChildNumLote
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1303.937850000000000000
          Height = 49.015770000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object mmoCodIte: TfrxMemoView
          Left = 5.593630000000000000
          Width = 368.126008660000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rdbDescriOnAfterPrint'
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object rdbMarca: TfrxMemoView
          Left = 378.677180000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          WordWrap = False
        end
        object rdblocFis: TfrxMemoView
          Left = 506.620470000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
        end
        object rdbChqVista: TfrxMemoView
          Left = 625.640940000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODFIS"]')
          WordWrap = False
        end
        object rdbQtdIte: TfrxMemoView
          Left = 727.559060000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
        end
        object rdbOrdPag: TfrxMemoView
          Left = 808.440940000000000000
          Width = 71.433070870000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          WordWrap = False
        end
        object rdbTotal: TfrxMemoView
          Left = 980.409400000000000000
          Width = 71.584230000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999.99')
          WordWrap = False
        end
        object rdbValPer: TfrxMemoView
          Left = 1057.814100000000000000
          Width = 55.861410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValPerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '100.00%')
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 658.261410000000000000
          Width = 66.595300000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
        end
        object Memo89: TfrxMemoView
          Left = 883.804700000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
        end
        object rdbValor: TfrxMemoView
          Left = 1119.495980000000000000
          Width = 69.845640000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValorOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '99,999,999,99')
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 1195.162090000000000000
          Width = 50.040940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQICM"]')
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 1251.023500000000000000
          Width = 49.889763780000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]')
          WordWrap = False
        end
        object mmoPcgObs: TfrxMemoView
          Left = 5.889761340000000000
          Top = 29.677180000000000000
          Width = 1286.551798660000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBS.PEDIDO COMPRA: [frxRelatorio."PCGOBS"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 45.322820000000000000
        Top = 147.401670000000000000
        Width = 1303.937850000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Top = 6.118120000000005000
          Width = 1298.267784880000000000
          Height = 34.015770000000000000
          Fill.BackColor = clSilver
        end
        object rllDescri: TfrxMemoView
          Left = 9.600000000000000000
          Top = 8.000000000000000000
          Width = 364.346630000000000000
          Height = 30.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxMemoView
          Left = 378.677180000000000000
          Top = 8.000000000000000000
          Width = 121.020470000000000000
          Height = 30.220470000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxMemoView
          Left = 503.281880000000000000
          Top = 8.000000000000000000
          Width = 115.200000000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FIS.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 620.522820000000000000
          Top = 8.000000000000000000
          Width = 28.800000000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxMemoView
          Left = 727.559060000000000000
          Top = 8.000000000000000000
          Width = 75.061410000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 883.804700000000000000
          Top = 8.000000000000000000
          Width = 92.598425200000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 980.409400000000000000
          Top = 8.000000000000000000
          Width = 71.433063540000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PR.COMP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 1057.814100000000000000
          Top = 8.000000000000000000
          Width = 131.527520000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VARIAC'
            'PORC.     VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 1195.162090000000000000
          Top = 8.000000000000000000
          Width = 50.040940000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.ICM')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 654.600000000000000000
          Top = 8.000000000000000000
          Width = 66.595300000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 1251.023500000000000000
          Top = 8.000000000000000000
          Width = 50.040940000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo88: TfrxMemoView
          Left = 808.440940000000000000
          Top = 8.000000000000000000
          Width = 71.433063540000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Left = 1059.032160000000000000
          Top = 25.015770000000000000
          Width = 129.712490000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 18.897650000000000000
        Width = 1303.937850000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 393.487200000001500000
          Top = 17.000000000000000000
          Width = 516.963449999997000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
        object rllNomeRelatorioA: TfrxMemoView
          Align = baCenter
          Left = 393.487200000000000000
          Top = 34.000000000000000000
          Width = 516.963450000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1174.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Time: TfrxMemoView
          Left = 1222.800000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1092.179530000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 393.487200000001500000
          Top = 51.000000000000000000
          Width = 516.963449999997000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 164.409478110000000000
        Top = 238.110390000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxMemoView
          Left = 9.600000000000000000
          Width = 79.143290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fornecedor:')
        end
        object Memo66: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 87.004700000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Entrada:')
        end
        object Memo67: TfrxMemoView
          Left = 9.448818900000000000
          Top = 34.000000000000000000
          Width = 102.425170000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pgto (NF):')
        end
        object Memo70: TfrxMemoView
          Left = 9.600000000000000000
          Top = 70.299212599999970000
          Width = 114.066110000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vencimento/Valor:')
        end
        object Memo75: TfrxMemoView
          Left = 227.527520000000000000
          Top = 17.000000000000000000
          Width = 63.722820000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
        end
        object Memo76: TfrxMemoView
          Left = 398.798330000000000000
          Top = 17.000000000000000000
          Width = 52.081880000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#186' Doc:')
        end
        object Memo80: TfrxMemoView
          Left = 639.495980000000000000
          Top = 17.000000000000000000
          Width = 40.743290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Serie:')
        end
        object rllPedCom: TfrxMemoView
          Left = 801.637795280000000000
          Width = 497.763779530000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPedComOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Pedido de Compra: [<frxRelatorio."PEDCOM">]')
          WordWrap = False
        end
        object Memo86: TfrxMemoView
          Left = 771.529190000000000000
          Top = 34.779530000000030000
          Width = 46.261410000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP:')
        end
        object Memo93: TfrxMemoView
          Left = 90.784230000000000000
          Width = 507.968770000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]-[frxRelatorio."NOMFOR"] ')
        end
        object rllDtaEnt: TfrxMemoView
          Left = 98.645640000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
        end
        object rllDtaDoc: TfrxMemoView
          Left = 293.291280000000000000
          Top = 17.000000000000000000
          Width = 98.343290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
        end
        object Memo138: TfrxMemoView
          Left = 451.141620000000000000
          Top = 17.000000000000000000
          Width = 185.272480000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."ESPDOC"]-[frxRelatorio."C' +
              'ODEMP"]')
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo140: TfrxMemoView
          Left = 682.280210000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
        end
        object rdbCndPag: TfrxMemoView
          Left = 114.066110000000000000
          Top = 34.000000000000000000
          Width = 644.863080000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
        end
        object rlbCFOP: TfrxMemoView
          Left = 820.611070000000000000
          Top = 34.000000000000000000
          Width = 475.993940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo8: TfrxMemoView
          Left = 604.724800000000000000
          Width = 194.267716535433100000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[fFormataCpfCgc(<frxRelatorio."_C_G_C">,<frxRelatorio."CGCCPF">)' +
              ']')
        end
        object Memo9: TfrxMemoView
          Left = 813.244116460000000000
          Top = 17.118120000000000000
          Width = 79.143290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Operador:')
        end
        object Memo57: TfrxMemoView
          Left = 894.503958980000000000
          Top = 17.118120000000000000
          Width = 402.141930000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"] ')
        end
        object rllParcelas: TfrxMemoView
          Left = 10.640940000000000000
          Top = 88.062992130000000000
          Width = 1285.643970000000000000
          Height = 71.795300000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
        end
        object rllConPag2: TfrxMemoView
          Left = 9.448818900000000000
          Top = 51.913419999999970000
          Width = 162.897650000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond.Pgto (Ped. Compra):')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbConPag2: TfrxMemoView
          Left = 176.393744720000000000
          Top = 51.913419999999970000
          Width = 1121.083860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataConPag]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCentroCusto: TfrxMemoView
          Left = 370.393940000000000000
          Top = 70.299212599999970000
          Width = 922.885530000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 60.456710000000000000
        Top = 1141.418060000000000000
        Width = 1303.937850000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.000000000000000000
          Width = 709.266110000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 713.347990000000000000
          Top = 1.000000000000000000
          Width = 587.716450000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
        end
        object rllMensagemRodape: TfrxMemoView
          Left = 9.600000000000000000
          Top = 21.795299999999770000
          Width = 578.267999690000000000
          Height = 35.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '*Esta impress'#227'o '#233' a pr'#233'via da Nota de Entrada. '
            
              '**Os dados somente ser'#227'o efetivados ap'#243's confirma'#231#227'o e grava'#231#227'o ' +
              'da entrada de mercadorias.')
          WordWrap = False
        end
        object mmoMsg1: TfrxMemoView
          Left = 612.283860000000000000
          Top = 18.897649999999880000
          Width = 491.338900000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoMsg1OnBeforePrint'
          Memo.UTF8W = (
            
              '[IIF(blnDedFre,  '#39'(1) Total do Conhecimento de Frete com dedu'#231#227'o' +
              ' de ICMS'#39', '#39#39')')
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 73.661410000000000000
        Top = 559.370440000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'rlbResumoGrupoOnBeforePrint'
        Child = frxRelEspelhoNotaJ.ChildFrete
        object Memo6: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000114000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
        end
        object rlbBasIcm: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000120000
          Width = 92.598425199999990000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object rlbValIcm: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object mmoTitDocDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object mmoDocDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
        end
        object rdbTotvarD: TfrxMemoView
          Left = 1039.363760000000000000
          Top = 3.000000000000114000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 887.200000000000000000
          Top = 37.897649999999880000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotD: TfrxMemoView
          Left = 1039.363760000000000000
          Top = 38.897649999999880000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 887.200000000000000000
          Top = 54.897649999999880000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 1039.363760000000000000
          Top = 55.897649999999880000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.000000000000114000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]'
            ''
            '')
          WordWrap = False
        end
        object Memo102: TfrxMemoView
          Left = 1156.536180000000000000
          Top = 37.039370078740150000
          Width = 60.472389690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '% Frete:')
          WordWrap = False
        end
        object Memo104: TfrxMemoView
          Left = 1217.770750000000000000
          Top = 37.039370078740150000
          Width = 39.685005200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercFrete(SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo),  SUM(<' +
              'frxRelatorio."TOTFRE">,rlbDetGrupo) , SUM(<frxRelatorio."FRECON"' +
              '>,rlbDetGrupo), SUM(<frxRelatorio."VAFRAN">,rlbDetGrupo) )]')
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 1259.142550000000000000
          Top = 37.039370078740150000
          Width = 18.897559690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '%')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 887.189550000000000000
          Top = 19.897649999999880000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 1039.353310000000000000
          Top = 19.897649999999880000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 438.425480000000000000
          Top = 2.779530000000022000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 77.440940000000000000
        Top = 1039.370750000000000000
        Width = 1303.937850000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 72.500000000000230000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
        end
        object rlbBasIcmTot: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000000000
          Width = 92.598425199999990000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object rlbValIcmTot: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object mmoTitTotDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object mmoTotDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
        end
        object rdbTotvarG: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.000000000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarGOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 887.200000000000000000
          Top = 38.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotG: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 38.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 887.200000000000000000
          Top = 55.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 55.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 887.189550000000000000
          Top = 20.677179999999910000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 1029.794250000000000000
          Top = 20.677179999999910000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 438.425480000000000000
          Top = 2.779530000000022000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 215.433210000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODFOR"'
        ReprintOnNewPage = True
      end
      object GroupFooterFor: TfrxGroupFooter
        FillType = ftBrush
        Height = 81.220470000000000000
        Top = 895.748610000000000000
        Width = 1303.937850000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object Line3: TfrxLineView
          Align = baWidth
          Top = 76.397650000000000000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo51: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 150.425170000000000000
          Top = 5.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 9.600000000000000000
          Top = 22.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 150.425170000000000000
          Top = 22.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 9.600000000000000000
          Top = 39.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
        end
        object rlbBasIcmFor: TfrxMemoView
          Left = 150.425170000000000000
          Top = 39.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 298.311750000000000000
          Top = 5.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo71: TfrxMemoView
          Left = 298.311750000000000000
          Top = 22.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 439.136920000000000000
          Top = 22.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 298.311750000000000000
          Top = 39.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object rlbValIcmFor: TfrxMemoView
          Left = 439.136920000000000000
          Top = 39.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo77: TfrxMemoView
          Left = 588.000000000000000000
          Top = 5.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object mmoTitForDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 22.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object mmoForDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 22.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 588.000000000000000000
          Top = 39.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 728.825170000000000000
          Top = 39.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo83: TfrxMemoView
          Left = 887.200000000000000000
          Top = 5.000000000000114000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
        end
        object rdbTotvarF: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 5.000000000000114000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarFOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
        end
        object Memo85: TfrxMemoView
          Left = 888.200000000000000000
          Top = 41.677180000000020000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Fornecedor:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotF: TfrxMemoView
          Left = 1029.025170000000000000
          Top = 41.677180000000020000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo95: TfrxMemoView
          Left = 888.200000000000000000
          Top = 58.677180000000030000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo97: TfrxMemoView
          Left = 728.825170000000000000
          Top = 5.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 1029.025170000000000000
          Top = 58.677180000000030000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 887.189550000000000000
          Top = 22.677180000000020000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 1029.794250000000000000
          Top = 22.677180000000020000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 438.425480000000000000
          Top = 4.913385830000038000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 657.638220000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'ChildFreteOnBeforePrint'
        Child = frxRelEspelhoNotaJ.ChildGNRE
        PrintChildIfInvisible = True
        object subConFre: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelEspelhoNotaJ.pagConFre
        end
      end
      object ChildGNRE: TfrxChild
        FillType = ftBrush
        Height = 22.677158030000000000
        Top = 699.213050000000000000
        Width = 1303.937850000000000000
        Child = frxRelEspelhoNotaJ.ChildVendor
        PrintChildIfInvisible = True
        Stretched = True
        object subrepGNRE: TfrxSubreport
          Left = 5.000000000000000000
          Top = 1.220469999999977000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelEspelhoNotaJ.Page1
        end
      end
      object ChildNumLote: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 498.897960000000000000
        Width = 1303.937850000000000000
        object Memo19: TfrxMemoView
          Left = 10.338590000000000000
          Width = 394.582718660000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE: [frxRelatorio."NUMLOT"]')
          WordWrap = False
        end
      end
      object ChildVendor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 744.567410000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'ChildVendorOnBeforePrint'
        Child = frxRelEspelhoNotaJ.ChildICMAnt
        PrintChildIfInvisible = True
        Stretched = True
        object Memo21: TfrxMemoView
          Left = 83.708720000000000000
          Top = 0.779530000000022500
          Width = 1217.008660000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetVendor]')
        end
        object Memo48: TfrxMemoView
          Left = 11.338590000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'Vendor:')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 22.677180000000020000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object childOutrasDespesas: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 28.346456690000000000
        ParentFont = False
        Top = 842.835190000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'childOutrasDespesasOnBeforePrint'
        Stretched = True
        object Line5: TfrxLineView
          Align = baWidth
          Top = 24.677180000000020000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo62: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.779530000000022000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'Outras despesas:')
        end
        object Memo63: TfrxMemoView
          Left = 136.842610000000000000
          Top = 1.779530000000022000
          Width = 1160.315710000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetOutrasDespesas]')
        end
      end
      object ChildICMAnt: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 793.701300000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'ChildICMAntOnBeforePrint'
        Child = frxRelEspelhoNotaJ.childOutrasDespesas
        PrintChildIfInvisible = True
        Stretched = True
        object Line7: TfrxLineView
          Align = baWidth
          Top = 22.897650000000000000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo74: TfrxMemoView
          Left = 10.338590000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'ICMS Antecipado:')
        end
        object Memo84: TfrxMemoView
          Left = 135.842610000000000000
          Width = 1164.095240000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetIcmsAntecipado]')
        end
      end
    end
    object pagConFre: TfrxReportPage
      PaperWidth = 365.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 35.905524020000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1303.937850000000000000
        object Memo98: TfrxMemoView
          Top = 2.000000000000000000
          Width = 257.008040000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'CONHECIMENTO DE FRETE')
        end
        object Memo99: TfrxMemoView
          Left = 264.567100000000000000
          Top = 2.000000000000000000
          Width = 158.740260000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'FORNECEDOR')
        end
        object Memo100: TfrxMemoView
          Left = 650.094419840000000000
          Top = 2.000000000000000000
          Width = 79.370086060000000000
          Height = 31.748041260000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR'
            'TOTAL')
        end
        object Memo101: TfrxMemoView
          Left = 884.410020000000000000
          Top = 2.000000000000000000
          Width = 419.527786060000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'CONDI'#199#195'O DE PAGAMENTO')
        end
        object mmoTitValProp: TfrxMemoView
          Left = 735.787880000000000000
          Top = 2.000000000000000000
          Width = 143.622096060000000000
          Height = 31.748041260000000000
          OnAfterPrint = 'mmoTitValPropOnAfterPrint'
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PROPORCIONAL'
            'AO DOCUMENTO [IIF(blnDedFre, '#39'(1)'#39', '#39#39')]')
        end
        object Line9: TfrxLineView
          Align = baWidth
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 39.685054020000000000
        Top = 79.370130000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxRelEspelhoNotaJ.childParcelasConFrete
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
        RowCount = 0
        object Memo33: TfrxMemoView
          Top = 21.118120000000000000
          Width = 257.008040000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            
              '[frxDBDConFre."NUMDOC"]-[frxDBDConFre."ESPDOC"]-[frxDBDConFre."C' +
              'ODEMP"]-[frxDBDConFre."SERIE_"]')
        end
        object Memo60: TfrxMemoView
          Left = 264.567100000000000000
          Top = 21.118120000000000000
          Width = 370.393940000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            '[frxDBDConFre."CODTRA"]-[frxDBDConFre."NOMTRA"]')
        end
        object Memo90: TfrxMemoView
          Left = 650.078740160000000000
          Top = 21.118120000000000000
          Width = 79.370078740000000000
          Height = 16.629921260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDConFre."VALCON"]')
        end
        object Memo96: TfrxMemoView
          Left = 884.410020000000000000
          Top = 21.118120000000000000
          Width = 419.527830000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            
              '[fCondPagtoConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCon' +
              'Fre."SERIE_">, <frxDBDConFre."CODTRA">, <frxDBDConFre."CODEMP">,' +
              ' <frxDBDConFre."DTADOC">)]')
        end
        object Memo103: TfrxMemoView
          Left = 735.874015750000000000
          Top = 21.118120000000000000
          Width = 143.622088740000000000
          Height = 16.629921260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fretSomaConhecimento(<frxDBDConFre."VALCON">)]')
        end
        object memModFre: TfrxMemoView
          Top = 1.779529999999994000
          Width = 1300.158320000000000000
          Height = 18.897650000000000000
        end
      end
      object childParcelasConFrete: TfrxChild
        FillType = ftBrush
        Height = 20.409451260000000000
        Top = 143.622140000000000000
        Width = 1303.937850000000000000
        OnBeforePrint = 'childParcelasConFreteOnBeforePrint'
        Child = frxRelEspelhoNotaJ.Child2
        PrintChildIfInvisible = True
        Stretched = True
        object Memo31: TfrxMemoView
          Width = 1300.158320000000000000
          Height = 16.629921260000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            
              '[fDuplicatasConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCo' +
              'nFre."ESPDOC">, <frxDBDConFre."SERIE_">, <frxDBDConFre."CODTRA">' +
              ')]')
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 185.196970000000000000
        Width = 1303.937850000000000000
        object Line8: TfrxLineView
          Align = baWidth
          Top = 3.779529999999994000
          Width = 1303.937850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
        RowCount = 0
        object Memo94: TfrxMemoView
          Left = 7.559060000000000000
          Top = 0.779530000000000000
          Width = 79.370039690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'GNRE:')
          WordWrap = False
        end
        object frxGNREGNR_NUMGNR: TfrxMemoView
          Left = 90.708720000000000000
          Top = 1.559060000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          DataField = 'GNR_NUMGNR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGNRE."GNR_NUMGNR"]')
          ParentFont = False
        end
        object frxGNREGNR_VALGNR: TfrxMemoView
          Left = 355.275820000000000000
          Top = 0.779530000000000000
          Width = 158.740260000000000000
          Height = 17.007874020000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_VALGNR"]')
          ParentFont = False
        end
        object frxGNREGNR_CODFOR: TfrxMemoView
          Left = 525.354670000000000000
          Top = 0.779530000000000000
          Width = 476.220780000000000000
          Height = 17.007874020000000000
          DataField = 'GNR_CODFOR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGNRE."GNR_CODFOR"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 263.008040000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGNRE."GNR_DTAVEN"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 177.417440000000000000
          Top = 1.000000000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA VENC.')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 60.472480000000000000
        Width = 1046.929810000000000000
        object Line6: TfrxLineView
          Align = baWidth
          Top = 7.559060000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 48
    Top = 8
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 168
    Top = 8
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 288
    Top = 8
  end
  object cdsGNRE: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 64
    object cdsGNREGNR_CODFOR: TStringField
      DisplayWidth = 100
      FieldName = 'GNR_CODFOR'
      Size = 100
    end
    object cdsGNREGNR_NUMGNR: TStringField
      FieldName = 'GNR_NUMGNR'
    end
    object cdsGNREGNR_VALGNR: TFloatField
      FieldName = 'GNR_VALGNR'
    end
    object cdsGNREGNR_DTAVEN: TDateField
      FieldName = 'GNR_DTAVEN'
    end
  end
  object frxGNRE: TfrxDBDataset
    UserName = 'frxGNRE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'GNR_CODFOR=GNR_CODFOR'
      'GNR_NUMGNR=GNR_NUMGNR'
      'GNR_VALGNR=GNR_VALGNR'
      'GNR_DTAVEN=GNR_DTAVEN')
    DataSet = cdsGNRE
    BCDToCurrency = False
    Left = 168
    Top = 120
  end
  object frxRelEspelhoComPrecosJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44949.750881006940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltBasIcmFor: Double;'
      '  fltValIcmFor: Double;'
      '  fltBasIcmTot: Double;'
      '  fltValIcmTot: Double;      '
      
        '  blnTemConFre: Boolean;                                        ' +
        '         '
      '    '
      'procedure rdbTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      '    rdbTotal.DataField := '#39'UNITAR_IMP'#39';      '
      '  End'
      '    '
      '  Else If strTipCalc = '#39'C'#39' Then'
      '  Begin                                      '
      '    If intOpcVariacao = 1 Then'
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39', <frxRelatorio."' +
        'PRECOM">) '
      '    Else              '
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39',fCalculaValorCom' +
        'pra(<frxRelatorio."PRECOM">,<frxRelatorio."DESF01">,<frxRelatori' +
        'o."DESF02">,<frxRelatorio."DESF03">,<frxRelatorio."DESF04">,<frx' +
        'Relatorio."DESF05">,<frxRelatorio."DESF06">,<frxRelatorio."ACRFI' +
        'N">));'
      
        '    rdbTotal.DataField := '#39#39'                                    ' +
        '      '
      '  End'
      '  Else            '
      '    rdbTotal.DataField := '#39'UNIPED'#39';'
      'end;'
      ''
      'procedure rdbValPerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."UNITAR_IMP">);'
      '  End '
      '  Else If intOpcVariacao = 3 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."PRECOM">);'
      '  End Else'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(<frxRelatorio."PRECO' +
        'M">,<frxRelatorio."DESF01">,<frxRelatorio."DESF02">,<frxRelatori' +
        'o."DESF03">,<frxRelatorio."DESF04">,<frxRelatorio."DESF05">,<frx' +
        'Relatorio."DESF06">,<frxRelatorio."ACRFIN">,<frxRelatorio."UNITA' +
        'R">,<frxRelatorio."UNIPED">);'
      '  End;              '
      ''
      '  If (blnVariacao) Then'
      '  Begin      '
      '    If (fStrToFloat(rdbValPer.Text) > 0) Then'
      '      rdbValPer.Font.Color := clBlue'
      '    Else If (fStrToFloat(rdbValPer.Text) < 0) Then'
      '      rdbValPer.Font.Color := clRed'
      '    Else'
      '      rdbValPer.Font.Color := clBlack;'
      '  End;      '
      'end;'
      ''
      'procedure rdbValorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbValor.Text := FormatFloat('#39'###,#0.00'#39', fVariacao);'
      ''
      '  If (blnVariacao) Then'
      '  Begin              '
      '    If (fStrToFloat(rdbValor.Text) > 0) Then'
      '      rdbValor.Font.Color := clBlue'
      '    Else If (fStrToFloat(rdbValor.Text) < 0) Then'
      '      rdbValor.Font.Color := clRed'
      '    Else'
      '      rdbValor.Font.Color := clBlack;'
      '  End;        '
      'end;'
      ''
      ''
      'procedure rdbTotvarDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotVarD.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoD);      ' +
        '                                                      '
      'end;'
      ''
      'procedure rdbTotvarFOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarF.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoF);  '
      'end;'
      ''
      'procedure rdbTotvarGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarG.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoG);  '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  If <frxRelatorio."PEDCOM"> <> '#39#39' Then'
      '  Begin'
      '    rllPedCom.Visible  := True;'
      '    rllConPag2.Visible := True;'
      '    rdbConPag2.Visible := True;  '
      '  End'
      '  Else                      '
      '  Begin'
      '    rllConPag2.Visible := False;'
      '    rdbConPag2.Visible := False;'
      '    rllPedCom.Visible  := False;'
      '  End;'
      '    '
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODFOR">);    '
      
        '  mmoCentroCusto.Text := fRetCentroCustoDoc;                    ' +
        '                              '
      '  '
      '  ChildGNRE.Visible := fMontaGNRE;'
      'End;'
      '               '
      'procedure rlbResumoGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltBasIcmFor := fltBasIcmFor + <frxRelatorio."GER_BASICM">;   ' +
        '   '
      '  fltValIcmFor := fltValIcmFor + <frxRelatorio."GER_TOTICM">;'
      '  fltBasIcmTot := fltBasIcmTot + <frxRelatorio."GER_BASICM">;'
      
        '  fltValIcmTot := fltValIcmTot + <frxRelatorio."GER_TOTICM">;   ' +
        ' '
      'end;'
      '   '
      'procedure ChildFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildFrete.Visible := fTemConhecimentoFrete(<frxRelatorio."AUT' +
        'GER">, <frxRelatorio."ESPDOC">);    '
      'end;'
      ''
      'procedure rlbDetGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure qckPaginaAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;      '
      '  fltValIcmFor := 0.0;'
      '  fltBasIcmTot := 0.0;'
      '  fltValIcmTot := 0.0;  '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;            '
      '  fltValIcmFor := 0.0;  '
      'end;'
      ''
      'procedure rdbDescriOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildNumLote.Visible := <frxRelatorio."NUMLOT"> <> '#39#39';        ' +
        '                                   '
      'end;'
      ''
      
        'procedure childParcelasConFreteOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'begin'
      
        '  childParcelasConFrete.Visible := (fDuplicatasConhecimentoFrete' +
        '(<frxDBDConFre."NUMDOC">, <frxDBDConFre."ESPDOC">, <frxDBDConFre' +
        '."SERIE_">, <frxDBDConFre."CODTRA">)  <> '#39#39');                  '
      'end;'
      ''
      'procedure ChildVendorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildVendor.Visible := fRetVenDor <> '#39#39';                      ' +
        '                     '
      'end;'
      ''
      
        'procedure childOutrasDespesasOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  childOutrasDespesas.Visible := fRetOutrasDespesas <> '#39#39';      ' +
        '                                     '
      'end;'
      ''
      'procedure ChildICMAntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  childICMAnt.Visible := fRetICMSAntecipado <> '#39#39';              ' +
        '                             '
      'end;'
      ''
      'procedure mmoMsg1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoMsg1.Visible := blnTemConFre;  '
      'end;'
      ''
      'procedure mmoTitValPropOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  blnTemConFre := True;                   '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memModFre.Text :=  fRetModalidadeFrete(<frxRelatorio."MODFRE">' +
        ');                        '
      'end;'
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);  ' +
        '  '
      'end;'
      '    '
      'begin        '
      '  blnTemConFre := False;                   '
      'end.')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 288
    Top = 118
    Datasets = <
      item
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
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
    object qckPaginaA: TfrxReportPage
      PaperWidth = 422.500000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaAOnBeforePrint'
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 45.236240000000000000
        Top = 404.409710000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'rlbDetGrupoOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.ChildNumLote
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1521.260825000000000000
          Height = 45.236240000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object mmoCodIte: TfrxMemoView
          Left = 9.373160000000000000
          Top = 0.948818900000000000
          Width = 368.126008660000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rdbDescriOnAfterPrint'
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMarca: TfrxMemoView
          Left = 382.559060000000000000
          Top = 0.948818899999992100
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdblocFis: TfrxMemoView
          Left = 511.620470000000000000
          Top = 0.948818899999992100
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbChqVista: TfrxMemoView
          Left = 631.640940000000000000
          Top = 0.948818899999992100
          Width = 28.800000000000000000
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
            '[frxRelatorio."CODFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbQtdIte: TfrxMemoView
          Left = 735.118120000000000000
          Top = 0.948818899999992100
          Width = 67.502350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbOrdPag: TfrxMemoView
          Left = 808.440940000000000000
          Top = 0.948818899999992100
          Width = 71.433070870000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotal: TfrxMemoView
          Left = 980.409400000000000000
          Top = 0.948818899999992100
          Width = 71.584230000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999.99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValPer: TfrxMemoView
          Left = 1057.814100000000000000
          Top = 0.948818899999992100
          Width = 55.861410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValPerOnBeforePrint'
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
            '100.00%')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo87: TfrxMemoView
          Left = 662.702350000000000000
          Top = 0.948818899999992100
          Width = 70.374830000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotOrdPag: TfrxMemoView
          Left = 883.804700000000000000
          Top = 0.948818899999992100
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValor: TfrxMemoView
          Left = 1119.495980000000000000
          Top = 0.948818899999992100
          Width = 69.845640000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValorOnBeforePrint'
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
            '99,999,999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbAlqIpi: TfrxMemoView
          Left = 1194.023500000000000000
          Top = 0.948818899999992100
          Width = 49.889763780000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]%')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbPreVen: TfrxMemoView
          Left = 1249.575760000000000000
          Top = 0.948818899999992100
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbMarBru: TfrxMemoView
          Left = 1444.843540000000000000
          Top = 0.948818899999992100
          Width = 71.433070870000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(intOpcVariacao = 2, fCalculaMargem(<frxRelatorio."UNITAR"> ' +
              ', <frxRelatorio."PREVEN">), IIF(blnPrecoCustoCadastro, <frxRelat' +
              'orio."MARBRU">, fCalculaMargem(<frxRelatorio."PRECUS"> , <frxRel' +
              'atorio."PREVEN">) ))]%')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo98: TfrxMemoView
          Left = 1347.205630000000000000
          Top = 0.948818899999992100
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbQtdCmp: TfrxMemoView
          Left = 808.440940000000000000
          Top = 0.948818899999992100
          Width = 71.433070870000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."QTDCMP"> = 0, '#39#39',<frxRelatorio."QTDCMP">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoPcgObs: TfrxMemoView
          Left = 9.448818900000000000
          Top = 25.897650000000000000
          Width = 1501.985008660000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBS.PEDIDO COMPRA: [frxRelatorio."PCGOBS"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.015748030000000000
        Top = 147.401670000000000000
        Width = 1521.260825000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1521.260825000000000000
          Height = 34.015748030000000000
          Fill.BackColor = clSilver
        end
        object rllDescri: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.897639020000014000
          Width = 368.126160000000000000
          Height = 30.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxMemoView
          Left = 382.559060000000000000
          Top = 1.897639020000014000
          Width = 124.800000000000000000
          Height = 30.220470000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxMemoView
          Left = 512.400000000000000000
          Top = 1.897639020000014000
          Width = 115.200000000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FIS.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 633.640940000000000000
          Top = 1.897639020000014000
          Width = 28.800000000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxMemoView
          Left = 730.559060000000000000
          Top = 1.897639020000014000
          Width = 71.281880000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotOrdPag: TfrxMemoView
          Left = 883.804700000000000000
          Top = 1.897639020000014000
          Width = 92.598425200000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotal: TfrxMemoView
          Left = 980.409400000000000000
          Top = 1.897639020000014000
          Width = 71.433063540000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PR.COMP')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllVariacao: TfrxMemoView
          Left = 1057.814100000000000000
          Top = 1.897639020000014000
          Width = 131.527520000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VARIACAO'
            'PORC.     VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 666.481880000000000000
          Top = 1.897639020000014000
          Width = 59.036240000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllAlqIpi: TfrxMemoView
          Left = 1194.023500000000000000
          Top = 1.897639020000014000
          Width = 50.040940000000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            'AL.IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllOrdPag: TfrxMemoView
          Left = 808.440940000000000000
          Top = 1.897639020000014000
          Width = 71.433063540000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.UNIT')
          ParentFont = False
          VAlign = vaCenter
        end
        object linVariacao: TfrxLineView
          Left = 1059.032160000000000000
          Top = 17.007874020000000000
          Width = 129.712490000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPreVen: TfrxMemoView
          Left = 1249.575760000000000000
          Top = 1.897639020000014000
          Width = 92.598425200000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PR. VENDA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo100: TfrxMemoView
          Left = 1444.843540000000000000
          Top = 1.897639020000014000
          Width = 71.433070870000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM'
            'BRUTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo96: TfrxMemoView
          Left = 1347.205630000000000000
          Top = 1.897639020000014000
          Width = 92.598425200000000000
          Height = 30.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PR. CUSTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdCmp: TfrxMemoView
          Left = 808.440940000000000000
          Top = 1.897639020000014000
          Width = 71.433063540000000000
          Height = 30.220470000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD COMP.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 18.897650000000000000
        Width = 1521.260825000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 502.148687500000000000
          Top = 17.000000000000000000
          Width = 516.963450000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
        object rllNomeRelatorioA: TfrxMemoView
          Align = baCenter
          Left = 502.148687500000000000
          Top = 34.000000000000000000
          Width = 516.963450000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1391.476610870000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Time: TfrxMemoView
          Left = 1439.476610870000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Date: TfrxMemoView
          Left = 1314.179530000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 502.148687500000000000
          Top = 51.000000000000000000
          Width = 516.963450000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 153.070888110000000000
        Top = 226.771800000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxMemoView
          Left = 9.600000000000000000
          Width = 79.143290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.694882500000010000
          Width = 87.004700000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Entrada:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 9.448818900000000000
          Top = 35.389764999999980000
          Width = 102.425170000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond.Pgto (NF):')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 9.600000000000000000
          Top = 70.677165350000030000
          Width = 114.066110000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento/Valor:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Left = 227.527520000000000000
          Top = 17.694882500000010000
          Width = 63.722820000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
        end
        object Memo76: TfrxMemoView
          Left = 408.475510000000000000
          Top = 17.694882500000010000
          Width = 48.302350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#186' Doc:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo80: TfrxMemoView
          Left = 626.377860000000000000
          Top = 17.694882500000010000
          Width = 40.743290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Serie:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllPedCom: TfrxMemoView
          Left = 801.637795280000000000
          Width = 716.976377950000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedido de Compra: [<frxRelatorio."PEDCOM">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo86: TfrxMemoView
          Left = 891.137230000000000000
          Top = 35.389764999999980000
          Width = 48.302350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CFOP:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo93: TfrxMemoView
          Left = 90.784230000000000000
          Width = 507.968770000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]-[frxRelatorio."NOMFOR"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllDtaEnt: TfrxMemoView
          Left = 98.645640000000000000
          Top = 17.694882500000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllDtaDoc: TfrxMemoView
          Left = 293.291280000000000000
          Top = 17.694882500000010000
          Width = 105.902350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
        end
        object Memo138: TfrxMemoView
          Left = 461.889300000000000000
          Top = 17.694882500000010000
          Width = 158.815770000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."ESPDOC"]-[frxRelatorio."C' +
              'ODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo140: TfrxMemoView
          Left = 669.162090000000000000
          Top = 17.694882500000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbCndPag: TfrxMemoView
          Left = 114.066110000000000000
          Top = 35.389764999999980000
          Width = 746.910390000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbCFOP: TfrxMemoView
          Left = 933.212430000000000000
          Top = 35.389764999999980000
          Width = 585.600310000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 604.724800000000000000
          Width = 194.267716540000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[fFormataCpfCgc(<frxRelatorio."_C_G_C">,<frxRelatorio."CGCCPF">)' +
              ']')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 799.125996460000000000
          Top = 17.694882500000010000
          Width = 79.143290000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 881.339950000000000000
          Top = 17.694882500000010000
          Width = 636.472790000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllParcelas: TfrxMemoView
          Left = 9.600000000000000000
          Top = 88.440944880000000000
          Width = 1508.636240000000000000
          Height = 60.456710000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
        end
        object rllConPag2: TfrxMemoView
          Left = 9.448818900000000000
          Top = 52.913420000000000000
          Width = 162.897650000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond.Pgto (Ped. Compra):')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbConPag2: TfrxMemoView
          Left = 175.056722200000000000
          Top = 52.913420000000000000
          Width = 1344.076130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataConPag]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoCentroCusto: TfrxMemoView
          Left = 294.803340000000000000
          Top = 70.677165350000030000
          Width = 922.885530000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 49.133877800000000000
        Top = 1088.504640000000000000
        Width = 1521.260825000000000000
        object Memo48: TfrxMemoView
          Align = baClient
          Width = 1521.260825000000000000
          Height = 49.133877800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          ParentFont = False
        end
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 0.948818899999878500
          Width = 709.266110000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 928.560160870000000000
          Top = 0.948818899999878500
          Width = 587.716450000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
          ParentFont = False
        end
        object rllMensagemRodape: TfrxMemoView
          Left = 9.600000000000000000
          Top = 18.897649999999880000
          Width = 574.488469690000000000
          Height = 28.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '*Esta impress'#227'o '#233' a pr'#233'via da Nota de Entrada. '
            
              '**Os dados somente ser'#227'o efetivados ap'#243's confirma'#231#227'o e grava'#231#227'o ' +
              'da entrada de mercadorias.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMsg1: TfrxMemoView
          Left = 612.283860000000000000
          Top = 22.677179999999680000
          Width = 491.338900000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoMsg1OnBeforePrint'
          Memo.UTF8W = (
            
              '[IIF(blnDedFre,  '#39'(1) Total do Conhecimento de Frete com dedu'#231#227'o' +
              ' de ICMS'#39', '#39#39')')
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 73.661410000000010000
        Top = 514.016080000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'rlbResumoGrupoOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.ChildFrete
        object Memo6: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Itens:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de IPI:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. ICMS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbBasIcm: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 439.136920000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
        end
        object rlbValIcm: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
        end
        object mmoTitDocDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
        end
        object mmoDocDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variacao:')
          WordWrap = False
        end
        object rdbTotvarD: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.000000000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 887.200000000000000000
          Top = 38.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
        end
        object rdbTotD: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 38.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 887.200000000000000000
          Top = 55.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 55.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
        end
        object Memo102: TfrxMemoView
          Left = 1160.315710000000000000
          Top = 37.039370078740150000
          Width = 60.472389690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '% Frete:')
          WordWrap = False
        end
        object Memo104: TfrxMemoView
          Left = 1221.550280000000000000
          Top = 37.039370078740150000
          Width = 39.685005200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercFrete(SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo),  SUM(<' +
              'frxRelatorio."TOTFRE">,rlbDetGrupo) , SUM(<frxRelatorio."FRECON"' +
              '>,rlbDetGrupo), SUM(<frxRelatorio."VAFRAN">,rlbDetGrupo) )]')
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 1262.922080000000000000
          Top = 37.039370078740150000
          Width = 18.897559690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '%')
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 887.189550000000000000
          Top = 21.677180000000020000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 1029.794250000000000000
          Top = 21.677180000000020000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 73.661410000000010000
        Top = 990.236860000000000000
        Width = 1521.260825000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 73.346468899999870000
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Itens:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de IPI:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. ICMS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbBasIcmTot: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Subst:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 439.136920000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Frete:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vr. ICMS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbValIcmTot: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desp Acesso:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitTotDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconto:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTotDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. Subst:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000120000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Variacao:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotvarG: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.000000000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarGOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 887.200000000000000000
          Top = 37.897650000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotG: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 37.897650000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 887.200000000000000000
          Top = 54.897650000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. IPI:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 54.897650000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 887.189550000000000000
          Top = 19.897650000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 1029.794250000000000000
          Top = 19.897650000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 204.094620000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODFOR"'
        ReprintOnNewPage = True
      end
      object GroupFooterFor: TfrxGroupFooter
        FillType = ftBrush
        Height = 77.440940000000000000
        Top = 850.394250000000000000
        Width = 1521.260825000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object Line3: TfrxLineView
          Align = baWidth
          Top = 76.346468900000100000
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo51: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Itens:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 150.425170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 9.600000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de IPI:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 150.425170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 9.600000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. ICMS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbBasIcmFor: TfrxMemoView
          Left = 150.425170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 298.311750000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Subst:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 439.136920000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Left = 298.311750000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Frete:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 439.136920000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 298.311750000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vr. ICMS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbValIcmFor: TfrxMemoView
          Left = 439.136920000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 588.000000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desp Acesso:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoTitForDesEsp: TfrxMemoView
          Left = 588.000000000000000000
          Top = 20.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconto:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoForDesEsp: TfrxMemoView
          Left = 728.825170000000000000
          Top = 20.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo81: TfrxMemoView
          Left = 588.000000000000000000
          Top = 37.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. Subst:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 728.825170000000000000
          Top = 37.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo83: TfrxMemoView
          Left = 887.200000000000000000
          Top = 3.000000000000000000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Variacao:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotvarF: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 3.000000000000000000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarFOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo85: TfrxMemoView
          Left = 887.200000000000000000
          Top = 38.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Fornecedor:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotF: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 38.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo95: TfrxMemoView
          Left = 887.200000000000000000
          Top = 55.897650000000120000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bc. IPI:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          Left = 728.825170000000000000
          Top = 3.000000000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 1028.025170000000000000
          Top = 55.897650000000120000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 887.189550000000000000
          Top = 21.677179999999910000
          Width = 139.842519690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 1029.794250000000000000
          Top = 21.677179999999910000
          Width = 111.496075200000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'ChildFreteOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.ChildGNRE
        PrintChildIfInvisible = True
        object subConfre: TfrxSubreport
          Width = 94.488250000000000000
          Height = 17.007874015748030000
          Page = frxRelEspelhoComPrecosJ.pagConFre
        end
      end
      object ChildGNRE: TfrxChild
        FillType = ftBrush
        Height = 26.456688030000000000
        Top = 653.858690000000000000
        Width = 1521.260825000000000000
        Child = frxRelEspelhoComPrecosJ.ChildVendor
        PrintChildIfInvisible = True
        Stretched = True
        object subrepGNRE: TfrxSubreport
          Left = 2.000000000000000000
          Top = 3.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelEspelhoComPrecosJ.Page1
        end
      end
      object ChildNumLote: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 472.441250000000000000
        Width = 1521.260825000000000000
        object Memo19: TfrxMemoView
          Left = 10.338590000000000000
          Width = 394.582718660000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE: [frxRelatorio."NUMLOT"]')
          WordWrap = False
        end
      end
      object ChildVendor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 702.992580000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'ChildVendorOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.ChildICMAnt
        PrintChildIfInvisible = True
        Stretched = True
        object Memo21: TfrxMemoView
          Left = 83.708720000000000000
          Top = 0.779530000000022500
          Width = 1428.662340000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetVendor]')
        end
        object Memo2: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'Vendor:')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 22.677180000000020000
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object childOutrasDespesas: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 801.260360000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'childOutrasDespesasOnBeforePrint'
        Stretched = True
        object Line4: TfrxLineView
          Align = baWidth
          Top = 22.897650000000000000
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo3: TfrxMemoView
          Left = 11.338590000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'Outras despesas:')
        end
        object Memo14: TfrxMemoView
          Left = 136.842610000000000000
          Width = 1375.748920000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetOutrasDespesas]')
        end
      end
      object ChildICMAnt: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 752.126470000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'ChildICMAntOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.childOutrasDespesas
        PrintChildIfInvisible = True
        Stretched = True
        object Line7: TfrxLineView
          Align = baWidth
          Top = 22.897650000000000000
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo74: TfrxMemoView
          Left = 10.338590000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            'ICMS Antecipado:')
        end
        object Memo84: TfrxMemoView
          Left = 135.842610000000000000
          Width = 1171.654300000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetIcmsAntecipado]')
        end
      end
    end
    object pagConFre: TfrxReportPage
      PaperWidth = 422.500000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 35.905524020000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1521.260825000000000000
        object Memo15: TfrxMemoView
          Top = 1.000000000000000000
          Width = 257.008040000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'CONHECIMENTO DE FRETE')
        end
        object Memo99: TfrxMemoView
          Left = 264.567100000000000000
          Top = 1.000000000000000000
          Width = 158.740260000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'FORNECEDOR')
        end
        object Memo101: TfrxMemoView
          Left = 967.559680000000000000
          Top = 1.000000000000000000
          Width = 419.527786060000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            'CONDI'#199#195'O DE PAGAMENTO')
        end
        object Memo31: TfrxMemoView
          Left = 741.921259840000000000
          Top = 1.000000000000000000
          Width = 68.031496060000000000
          Height = 31.748041260000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR'
            'TOTAL')
        end
        object mmoTitValProp: TfrxMemoView
          Left = 816.377952760000000000
          Top = 1.000000000000000000
          Width = 143.622096060000000000
          Height = 31.748041260000000000
          OnAfterPrint = 'mmoTitValPropOnAfterPrint'
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PROPORCIONAL'
            'AO DOCUMENTO [IIF(blnDedFre, '#39'(1)'#39', '#39#39')]')
        end
        object Line5: TfrxLineView
          Align = baWidth
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 39.685054020000000000
        Top = 79.370130000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.childParcelasConFrete
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
        RowCount = 0
        object Memo33: TfrxMemoView
          Top = 21.677180000000000000
          Width = 257.008040000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            
              '[frxDBDConFre."NUMDOC"]-[frxDBDConFre."ESPDOC"]-[frxDBDConFre."C' +
              'ODEMP"]-[frxDBDConFre."SERIE_"]')
        end
        object Memo60: TfrxMemoView
          Left = 264.567100000000000000
          Top = 21.677180000000000000
          Width = 472.441250000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            '[frxDBDConFre."CODTRA"]-[frxDBDConFre."NOMTRA"]')
        end
        object Memo90: TfrxMemoView
          Left = 742.008350000000000000
          Top = 21.677180000000000000
          Width = 68.031540000000000000
          Height = 16.629921260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDConFre."VALCON"]')
        end
        object Memo62: TfrxMemoView
          Left = 967.559680000000000000
          Top = 21.677180000000000000
          Width = 548.031850000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            
              '[fCondPagtoConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCon' +
              'Fre."SERIE_">, <frxDBDConFre."CODTRA">, <frxDBDConFre."CODEMP">,' +
              ' <frxDBDConFre."DTADOC">)]')
        end
        object Memo103: TfrxMemoView
          Left = 816.378480000000000000
          Top = 21.677180000000000000
          Width = 143.622088740000000000
          Height = 16.629921260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fretSomaConhecimento(<frxDBDConFre."VALCON">)]')
        end
        object memModFre: TfrxMemoView
          Width = 1515.591530000000000000
          Height = 18.897650000000000000
        end
      end
      object childParcelasConFrete: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 143.622140000000000000
        Width = 1521.260825000000000000
        OnBeforePrint = 'childParcelasConFreteOnBeforePrint'
        Child = frxRelEspelhoComPrecosJ.Child2
        PrintChildIfInvisible = True
        object Memo63: TfrxMemoView
          Width = 1300.158320000000000000
          Height = 16.629921260000000000
          Memo.UTF8W = (
            
              '[fDuplicatasConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCo' +
              'nFre."ESPDOC">, <frxDBDConFre."SERIE_">, <frxDBDConFre."CODTRA">' +
              ')]')
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 185.196970000000000000
        Width = 1521.260825000000000000
        object Line8: TfrxLineView
          Align = baWidth
          Width = 1521.260825000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
        RowCount = 0
        object Memo94: TfrxMemoView
          Left = 1.600000000000000000
          Top = 0.779530000000000000
          Width = 94.488159690000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'GNRE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxGNREGNR_NUMGNR: TfrxMemoView
          Left = 99.606370000000000000
          Top = 0.779530000000000000
          Width = 86.929190000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_NUMGNR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGNRE."GNR_NUMGNR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxGNREGNR_VALGNR: TfrxMemoView
          Left = 351.055350000000000000
          Top = 0.779530000000000000
          Width = 158.740260000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_VALGNR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxGNREGNR_CODFOR: TfrxMemoView
          Left = 521.134200000000000000
          Top = 0.779530000000000000
          Width = 982.677800000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_CODFOR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGNRE."GNR_CODFOR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 272.905690000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 190.535560000000000000
          Top = 0.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DTA. VENC.')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 60.472480000000000000
        Width = 1046.929810000000000000
        object Line6: TfrxLineView
          Align = baWidth
          Top = 6.559060000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxRelEspelhoComPrecosM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43746.350209768520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltBasIcmFor: Double;'
      '  fltValIcmFor: Double;'
      '  fltBasIcmTot: Double;'
      '  fltValIcmTot: Double;  '
      
        '  blnTemConFre: Boolean;                                        ' +
        '         '
      '      '
      'procedure rdbTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      '    rdbTotal.DataField := '#39'UNITAR_IMP'#39';      '
      '  End'
      '    '
      '  Else If strTipCalc = '#39'C'#39' Then'
      '  Begin                                      '
      '    If intOpcVariacao = 1 Then'
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39', <frxRelatorio."' +
        'PRECOM">) '
      '    Else              '
      
        '      rdbTotal.Text :=  FormatFloat('#39'###,#0.00'#39',fCalculaValorCom' +
        'pra(<frxRelatorio."PRECOM">,<frxRelatorio."DESF01">,<frxRelatori' +
        'o."DESF02">,<frxRelatorio."DESF03">,<frxRelatorio."DESF04">,<frx' +
        'Relatorio."DESF05">,<frxRelatorio."DESF06">,<frxRelatorio."ACRFI' +
        'N">));'
      
        '    rdbTotal.DataField := '#39#39'                                    ' +
        '      '
      '  End'
      '    '
      '  Else rdbTotal.DataField := '#39'UNIPED'#39';'
      'end;'
      ''
      'procedure rdbValPerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intOpcVariacao = 2 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."UNITAR_IMP">);'
      '  End '
      '  Else If intOpcVariacao = 3 Then'
      '  Begin'
      
        '    rdbValPer.Text := fCalculaValPercentual(0, 0, 0, 0, 0, 0, 0,' +
        ' 0, <frxRelatorio."UNITAR">, <frxRelatorio."PRECOM">);'
      '  End Else'
      '  Begin              '
      
        '    rdbValPer.Text := fCalculaValPercentual(<frxRelatorio."PRECO' +
        'M">,<frxRelatorio."DESF01">,<frxRelatorio."DESF02">,<frxRelatori' +
        'o."DESF03">,<frxRelatorio."DESF04">,<frxRelatorio."DESF05">,<frx' +
        'Relatorio."DESF06">,<frxRelatorio."ACRFIN">,<frxRelatorio."UNITA' +
        'R">,<frxRelatorio."UNIPED">);'
      '  End;              '
      'end;'
      ''
      'procedure rdbValorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbValor.Text := FormatFloat('#39'###,#0.00'#39', fVariacao);  '
      'end;'
      ''
      'procedure rdbTotvarDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotVarD.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoD);      ' +
        '                                                      '
      'end;'
      ''
      'procedure rdbTotvarFOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarF.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoF);  '
      'end;'
      ''
      'procedure rdbTotvarGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbTotVarG.Text := FormatFloat('#39'###,#0.00'#39', fVariacaoG);  '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  If <frxRelatorio."PEDCOM"> <> '#39#39' Then'
      '  Begin'
      '    rllPedCom.Visible  := True;'
      '    rllConPag2.Visible := True;'
      '    rdbConPag2.Visible := True;  '
      '  End'
      '  Else                      '
      '  Begin'
      '    rllConPag2.Visible := False;'
      '    rdbConPag2.Visible := False;'
      '    rllPedCom.Visible  := False;'
      '  End;'
      '    '
      
        '  rllParcelas.Text := fVisualizaParcela( <frxRelatorio."ESPDOC">' +
        ', <frxRelatorio."NUMDOC">, <frxRelatorio."SERIE_">, <frxRelatori' +
        'o."CODFOR">);'
      
        '  mmoCentroCusto.Text := fRetCentroCustoDoc;                    ' +
        '                              '
      '  '
      '  ChildGNRE.Visible := fMontaGNRE;'
      'End;'
      ''
      'procedure rlbResumoGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltBasIcmFor := fltBasIcmFor + <frxRelatorio."GER_BASICM">;   ' +
        '   '
      '  fltValIcmFor := fltValIcmFor + <frxRelatorio."GER_TOTICM">;'
      '  fltBasIcmTot := fltBasIcmTot + <frxRelatorio."GER_BASICM">;'
      
        '  fltValIcmTot := fltValIcmTot + <frxRelatorio."GER_TOTICM">;   ' +
        ' '
      'end;'
      ''
      'procedure ChildFreteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildFrete.Visible := fTemConhecimentoFrete(<frxRelatorio."AUT' +
        'GER">, <frxRelatorio."ESPDOC">);                           '
      'end;'
      ''
      'procedure rlbDetGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      '  '
      'procedure qckPaginaAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;      '
      '  fltValIcmFor := 0.0;'
      '  fltBasIcmTot := 0.0;'
      '  fltValIcmTot := 0.0;  '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltBasIcmFor := 0.0;            '
      '  fltValIcmFor := 0.0;  '
      'end;'
      ''
      'procedure mmoCodIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildNumLote.Visible := <frxRelatorio."NUMLOT"> <> '#39#39';        ' +
        '                                   '
      'end;'
      ''
      'procedure ChildVendorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildVendor.Visible := fRetVenDor <> '#39#39';  '
      'end;'
      ''
      
        'procedure childOutrasDespesasOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  childOutrasDespesas.Visible := fRetOutrasDespesas <> '#39#39';      ' +
        '                                     '
      'end;'
      ''
      'procedure ChildICMAntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  childICMAnt.Visible := fRetICMSAntecipado <> '#39#39';              ' +
        '                             '
      'end;'
      ''
      'procedure ChildICMAntSepOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  childICMAntSep.Visible := fRetICMSAntecipado <> '#39#39';           ' +
        '                                '
      'end;'
      ''
      
        'procedure childParcelasConFreteOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'begin'
      
        '  childParcelasConFrete.Visible := (fDuplicatasConhecimentoFrete' +
        '(<frxDBDConFre."NUMDOC">, <frxDBDConFre."ESPDOC">, <frxDBDConFre' +
        '."SERIE_">, <frxDBDConFre."CODTRA">)  <> '#39#39');                   ' +
        ' '
      'end;'
      ''
      'procedure DMPMemo101OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoMsg1.Visible := blnTemConFre;  '
      'end;'
      ''
      'procedure mmoTitValPropOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  blnTemConFre := True;                   '
      'end;'
      ''
      'procedure masConFreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  memModFre.Memo.clear;  '
      
        '  memModFre.Memo.Add(fRetModalidadeFrete(<frxRelatorio."MODFRE">' +
        '));'
      'end;'
      ''
      'procedure rdbCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '   rdbCndPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);  ' +
        '  '
      'end;'
      '    '
      'begin'
      '  blnTemConFre := False;                   '
      'end.')
    OnUserFunction = frxRelEspelhoNotaMUserFunction
    Left = 48
    Top = 120
    Datasets = <
      item
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
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
    object qckPaginaA: TfrxDMPPage
      PaperWidth = 406.399737533502800000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      OnBeforePrint = 'qckPaginaAOnBeforePrint'
      FontStyle = [fsx12cpi]
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'rlbDetGrupoOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.ChildNumLote
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rdbMarca: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'DESMAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdblocFis: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbChqVista: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbQtdIte: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbOrdPag: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotal: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999.99')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValPer: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValPerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '100.00%')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotOrdPag: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValor: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbValorOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '99,999,999,99')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbAlqIpi: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQIPI"]%')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoCodIte: TfrxDMPMemoView
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCodIteOnBeforePrint'
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object rlbPreVen: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo94: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo98: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(intOpcVariacao = 2, fCalculaMargem(<frxRelatorio."UNITAR"> ' +
              ', <frxRelatorio."PREVEN">), IIF(blnPrecoCustoCadastro, <frxRelat' +
              'orio."MARBRU">, fCalculaMargem(<frxRelatorio."PRECUS"> , <frxRel' +
              'atorio."PREVEN">) ))]%')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbQtdCmp: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          ShowHint = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."QTDCMP"> = 0, '#39#39',<frxRelatorio."QTDCMP">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoPcgObs: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'OBS.PEDIDO COMPRA: [frxRelatorio."PCGOBS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 119.000000000000000000
        Width = 1516.800000000000000000
        ReprintOnNewPage = True
        object rllDescri: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO / DESCRICAO')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FIS.')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'SIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTotOrdPag: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTotal: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PR.COMP')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllVariacao: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VARIAC'
            'PORC.     VALOR')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllPreVen: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PR.VENDA')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllAlqIpi: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'AL.IPI')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllOrdPag: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo90: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PR.CUSTO')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllMarca: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo96: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM'
            'BRUTA')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object rllQtdCmp: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 34.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            'QTD COMP.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1516.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
        object rllNomeRelatorioA: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 221.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fornecedor:')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Entrada:')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pgto (NF):')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vencimento/Valor:')
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data Doc:')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#186' Doc:')
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Serie:')
          TruncOutboundText = False
        end
        object rllPedCom: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Ped. Compra: [<frxRelatorio."PEDCOM">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP:')
          TruncOutboundText = False
        end
        object DMPMemo93: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]-[frxRelatorio."NOMFOR"]')
          TruncOutboundText = False
        end
        object rllDtaEnt: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object rllDtaDoc: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          TruncOutboundText = False
        end
        object DMPMemo138: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."ESPDOC"]-[frxRelatorio."C' +
              'ODEMP"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo140: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'SERIE_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SERIE_"]')
          TruncOutboundText = False
        end
        object rdbCndPag: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 34.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCndPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object rlbCFOP: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbCFOPOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          TruncOutboundText = False
        end
        object rllParcelas: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 1488.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[fFormataCpfCgc(<frxRelatorio."_C_G_C">,<frxRelatorio."CGCCPF">)' +
              ']')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Operador:')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo93OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object rllConPag2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cond.Pgto (Ped.Compra):')
          TruncOutboundText = False
        end
        object rdbConPag2: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1267.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[fFormataConPag]')
          TruncOutboundText = False
        end
        object mmoCentroCusto: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 68.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 1071.000000000000000000
        Width = 1516.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
          TruncOutboundText = False
        end
        object rllMensagemRodape: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 864.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '*Esta impress'#227'o '#233' a pr'#233'via da Nota de Entrada. '
            
              '**Os dados somente ser'#227'o efetivados ap'#243's confirma'#231#227'o e grava'#231#227'o ' +
              'da entrada de mercadorias.')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoMsg1: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo101OnBeforePrint'
          Memo.UTF8W = (
            
              '[IIF(blnDedFre,  '#39'(1) Total do Conhecimento de Frete com deducao' +
              ' de ICMS'#39', '#39#39')')
          TruncOutboundText = False
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 442.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'rlbResumoGrupoOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.ChildFrete
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcm: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo26OnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcm: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitDocDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoDocDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarD: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarDOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Documento:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotD: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Perc. de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercFrete(SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo),  SUM(<' +
              'frxRelatorio."TOTFRE">,rlbDetGrupo) , SUM(<frxRelatorio."FRECON"' +
              '>,rlbDetGrupo), SUM(<frxRelatorio."VAFRAN">,rlbDetGrupo) )]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 68.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '%')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 969.000000000000000000
        Width = 1516.800000000000000000
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcmTot: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcmTot: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitTotDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTotDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarG: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarGOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotG: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 204.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODFOR"'
        ReprintOnNewPage = True
      end
      object GroupFooterFor: TfrxGroupFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 850.000000000000000000
        Width = 1516.800000000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Itens:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE_TOT">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbBasIcmFor: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total de Frete:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTFRE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Vr. ICMS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbValIcmFor: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALICM">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desp Acesso:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitForDesEsp: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Desconto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoForDesEsp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESESP">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. Subst:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo82: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASRET">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Total Variac:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotvarF: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotvarFOnBeforePrint'
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Total Fornecedor:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotF: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRCON_TOT">,rlbDetGrupo)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo95: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Bc. IPI:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo97: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DESACE">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASIPI">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'Fund.Comb.Pobr.ST:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VFCPST">,rlbDetGrupo)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 578.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'ChildFreteOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.ChildGNRE
        PrintChildIfInvisible = True
        object subConFre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelEspelhoComPrecosM.pagConfre
        end
      end
      object ChildGNRE: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 612.000000000000000000
        Width = 1516.800000000000000000
        Child = frxRelEspelhoComPrecosM.ChildVendor
        PrintChildIfInvisible = True
        object subrepGNRE: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelEspelhoComPrecosM.Page1
        end
      end
      object ChildNumLote: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 1516.800000000000000000
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE: [frxRelatorio."NUMLOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildVendor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 646.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'ChildVendorOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.ChildSeparadorVendor
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Vendor: ')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 1411.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetVendor]')
          TruncOutboundText = False
        end
      end
      object ChildSeparadorVendor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 680.000000000000000000
        Width = 1516.800000000000000000
        Child = frxRelEspelhoComPrecosM.ChildICMAnt
        PrintChildIfInvisible = True
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
      object childOutrasDespesas: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 782.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'childOutrasDespesasOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.childOutrasDespesasSep
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Outras Despesas: ')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetOutrasDespesas]')
          TruncOutboundText = False
        end
      end
      object childOutrasDespesasSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 816.000000000000000000
        Width = 1516.800000000000000000
        PrintChildIfInvisible = True
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
      object ChildICMAnt: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 714.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'ChildICMAntOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.ChildICMAntSep
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo62: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[fRetICMSAntecipado]')
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ICMS Antecipado:')
          TruncOutboundText = False
        end
      end
      object ChildICMAntSep: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 748.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'ChildICMAntSepOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.childOutrasDespesas
        PrintChildIfInvisible = True
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
    end
    object pagConfre: TfrxDMPPage
      PaperWidth = 406.399737533502800000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = []
      object heaConFre: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1516.800000000000000000
        object DMPMemo14: TfrxDMPMemoView
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONHECIMENTO DE FRETE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONDICAO DE PAGAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR'
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoTitValProp: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 144.000000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'mmoTitValPropOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR PROPORCIONAL'
            'AO DOCUMENTO[IIF(blnDedFre, '#39'(1)'#39', '#39#39')]'
            '')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object masConFre: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 85.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'masConFreOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.childParcelasConFrete
        DataSet = frxDBConFre
        DataSetName = 'frxDBDConFre'
        RowCount = 0
        object frxDBDConFrefrxDBDConFre: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBConFre
          DataSetName = 'frxDBDConFre'
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxDBDConFre."NUMDOC"]-[frxDBDConFre."ESPDOC"]-[frxDBDConFre."C' +
              'ODEMP"]-[frxDBDConFre."SERIE_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBDConFre."CODTRA"]-[frxDBDConFre."NOMTRA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDConFre."VALCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[fCondPagtoConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCon' +
              'Fre."SERIE_">, <frxDBDConFre."CODTRA">, <frxDBDConFre."CODEMP">,' +
              ' <frxDBDConFre."DTADOC">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo102: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fretSomaConhecimento(<frxDBDConFre."VALCON">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object memModFre: TfrxDMPMemoView
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object childParcelasConFrete: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1516.800000000000000000
        OnBeforePrint = 'childParcelasConFreteOnBeforePrint'
        Child = frxRelEspelhoComPrecosM.chiSeparador
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo100: TfrxDMPMemoView
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            
              '[fDuplicatasConhecimentoFrete(<frxDBDConFre."NUMDOC">, <frxDBDCo' +
              'nFre."ESPDOC">, <frxDBDConFre."SERIE_">, <frxDBDConFre."CODTRA">' +
              ')]')
          TruncOutboundText = False
        end
      end
      object chiSeparador: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1516.800000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
      end
    end
    object Page1: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 211.401946802909400000
      PaperSize = 9
      LeftMargin = 4.497913761764029000
      RightMargin = 4.497913761764029000
      TopMargin = 2.539998359584393000
      BottomMargin = 2.539998359584393000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1089.200000000000000000
        DataSet = frxGNRE
        DataSetName = 'frxGNRE'
        RowCount = 0
        object DMPMemo84: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'GNRE:')
          TruncOutboundText = False
        end
        object frxGNREGNR_NUMGNR: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_NUMGNR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Memo.UTF8W = (
            '[frxGNRE."GNR_NUMGNR"]')
          TruncOutboundText = False
        end
        object frxGNREGNR_VALGNR: TfrxDMPMemoView
          Left = 326.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_VALGNR"]')
          TruncOutboundText = False
        end
        object frxGNREGNR_CODFOR: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataField = 'GNR_CODFOR'
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          Memo.UTF8W = (
            '[frxGNRE."GNR_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxGNRE
          DataSetName = 'frxGNRE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGNRE."GNR_DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DTA.VENC.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 51.000000000000000000
        Width = 1089.200000000000000000
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1075.200000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxDBConFre: TfrxDBDataset
    UserName = 'frxDBDConFre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 288
    Top = 184
  end
end
