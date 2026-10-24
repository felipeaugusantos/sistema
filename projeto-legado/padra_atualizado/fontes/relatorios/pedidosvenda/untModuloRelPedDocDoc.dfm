object frmModuloRelPedDocDoc: TfrmModuloRelPedDocDoc
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 137
  Width = 158
  object frxRelPedDocDocM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42101.678169143520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '    strNumDoc : String;'
      '    fltTopReferencia : Real;'
      '    fltAlturaInicial : Real;        '
      '    strDocAnt : String;                              '
      '    fltTotDes : Real;                      '
      '  '
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
      ''
      'procedure rllNumDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllNumDoc.Text := strNumDoc;                              '
      'end;'
      ''
      'procedure rllCodigoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strNumDoc := '#39'('#39' + <frxRelatorio."NUMDOC"> + '#39')'#39';  '
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      '  Var '
      
        '   fltTopAux: Real;                                             ' +
        '    '
      'begin'
      '  ChildPagAnt.Visible := (<frxRelatorio."VPGANT"> > 0);'
      '  ChildDesFin.Visible := (<frxRelatorio."DESFIN"> > 0);'
      
        '  ChildTotDoc.Visible := ChildPagAnt.Visible Or ChildDesFin.Visi' +
        'ble;'
      ''
      '  If (ChildTotDoc.Visible) Then                          '
      '    rllSubTot.Text := '#39'SUB-TOTAL DO DOCUMENTO:'#39
      '  Else'
      '    rllSubTot.Text := '#39'TOTAL DO DOCUMENTO:'#39';            '
      '  '
      '  rlbGrupo.Height :=  fltAlturaInicial;'
      
        '  fltTopAux       :=  fltTopReferencia;                         ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                 '
      '    '
      '  If (Trim(<frxRelatorio."MOTBAI">) <> '#39#39') Then'
      '  Begin'
      '    rllMotBai.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMotBai.Height;'
      
        '    fltTopAux := fltTopAux + rllMotBai.Height;                  ' +
        '               '
      '  End;              '
      '  If (Trim(<frxRelatorio."MSGPED">) <> '#39#39') Then'
      '  Begin              '
      '    rllMsgPed.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMsgPed.Height;'
      
        '    fltTopAux := fltTopAux + rllMsgPed.Height;                  ' +
        '               '
      '  End;'
      '  If (Trim(<frxRelatorio."MSGEXP">) <> '#39#39') Then'
      '  Begin              '
      '    rllMsgExp.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMsgExp.Height;'
      
        '    fltTopAux := fltTopAux + rllMsgExp.Height;                  ' +
        '               '
      '  End;  '
      '  If (Trim(<frxRelatorio."CODTPA">) <> '#39#39') Then'
      '  Begin              '
      '    rllTipAte.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllTipAte.Height;'
      
        '    fltTopAux := fltTopAux + rllTipAte.Height;                  ' +
        '               '
      '  End;'
      '  If (Trim(<frxRelatorio."HORAINICIAL">) <> '#39#39') Then'
      '  Begin'
      '    If (rlbGrupo.Height = fltAlturaInicial) Then'
      
        '      rlbGrupo.Height := rlbGrupo.Height + rllHoraInicial.Height' +
        ';'
      '  End;'
      '    '
      '  If strDocAnt <> <frxRelatorio."NUMDOC"> Then'
      '  Begin'
      
        '    fltTotDes := fltTotDes + (<frxRelatorio."DESFIN"> + <frxRela' +
        'torio."VPGANT">);'
      '  End;'
      ''
      '  strDocAnt := <frxRelatorio."NUMDOC">;'
      ''
      '  if Trim(<frxRelatorio."NUMPOK">) <> '#39#39' then'
      '  begin'
      '    lbTablet.visible   := true;'
      '    edTablet.visible   := true;'
      '    lbTabletDt.visible := true;'
      
        '    edTabletDt.visible := true;                                 ' +
        '                                     '
      '  end'
      '  else'
      '  begin'
      '    lbTablet.visible   := false;'
      '    edTablet.visible   := false;'
      '    lbTabletDt.visible := false;'
      '    edTabletDt.visible := false;  '
      '  end;            '
      '                 '
      'end;'
      ''
      'procedure rllNumDocTotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllNumDocTot.Text := strNumDoc;                              '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdServico.Visible := (Pos(<frxRelatorio."CODITE">, ITESER) > ' +
        '0);                                                             ' +
        '           '
      'end;'
      '           '
      'procedure DMPMemo18OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo18.Text := Copy(<frxRelatorio."DESSER">, 1, Length(<frx' +
        'Relatorio."DESSER">) - 7);  '
      'end;'
      ''
      'procedure DMPMemo25OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    sTemp: String;                                            '
      'begin'
      
        '  sTemp := Copy(<frxRelatorio."VALSER">, 1, Length(<frxRelatorio' +
        '."VALSER">) - 7);'
      ''
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39'.'#39', '#39'#'#39');'
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39','#39', '#39'.'#39');'
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39'#'#39', '#39','#39');'
      ''
      '  DMPMemo25.Text := sTemp;  '
      'end;'
      ''
      'begin'
      '  strNumDoc := '#39#39';                    '
      '  strDocAnt := '#39#39';                         '
      '  fltTotDes := 0;'
      '  fltTopReferencia := rllMotBai.Top;      '
      
        '  fltAlturaInicial := (rlbGrupo.Height - (rlbGrupo.Height - rllM' +
        'otBai.Top)) + 10;'
      'end.')
    Left = 63
    Top = 73
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaAnalitico: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 1113.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMarca: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllRegiao: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[REGIAO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDigitador: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[DIGITADOR]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFornecedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllGrupos: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLibCom: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibCom]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLibFin: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibFin]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCidade: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllRepresentante: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDepartamento: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllOrdem: TfrxDMPMemoView
          Align = baCenter
          Left = 9.600000000000000000
          Top = 323.000000000000000000
          Width = 1478.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo13: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMCMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#27#67#65#15#27#77'
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPOENTREGA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 68.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPATE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[FATURAMENTO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[TIPODEQTD]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPODEOPERACAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAPREVIS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 238.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 238.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[OCORRE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[ENTCD]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 255.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[FASEOBRA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 272.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[LISPED]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[LISADI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[ORIGEM]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 306.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDCOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 289.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[LISATE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 595.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxRelPedDocDocM.chdServico
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxDMPMemoView
          Align = baClient
          Width = 1507.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCodigo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllCodigoOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmp: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargem: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrIpiTit: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldQtdOri: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDORI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo4: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbLitragem: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo6: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."ENTRET"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldTotCusto: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldMargem: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaMargemMarkup(<frxRelatorio."MAMKP4">, <frxRelatorio."T' +
              'OTCUS">))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbSaldos: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 901.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 68.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes,2)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object rllInfEmp: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '** Nao foi informado o codigo da empresa, o sistema ira somar o ' +
              'saldo de estoque de todas as empresas para verificar se o produt' +
              'o pode ser atendido.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMsg: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '** totais do anal'#237'tico e sint'#233'tico podem n'#227'o bater pois podem ex' +
              'istir baixas parciais de documentos.')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object rllNumDocTit: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLitragem: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrIpiTit: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. IPI')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTitQtd: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrAntecTit: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PR. UNIT.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtdOri: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE. ORIG.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPrevisaoTit: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVTotalTit: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PROD.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'ENT.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotCusTit: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR CUSTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemTit: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaldos: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LOC.FIS.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 425.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."NUMDOC"'
        object Memo3: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DOCUMENTO..:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo9: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo10: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DT. ENTRADA:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo11: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."PREVIS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DT. PREVIS'#195'O:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo14: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo15: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbConPag: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[(fFormataCondPag(<frxRelatorio."CONPAG">))]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo17: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'COND. PGTO.:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo23: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 17.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."PESBRU"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo29: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'PESO BRUTO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo30: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE....:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo32: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMCMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo33: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'PED. COMPRA:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMotBai: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MOTBAI">) = '#39#39','#39#39','#39'MOTIVO BAIXA: '#39'+<frx' +
              'Relatorio."MOTBAI">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo7: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo8: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'EMPRESA:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCFAT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DOC.FAT....:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."DTAFAT"> = '#39'0'#39', '#39#39', <frxRelatorio."DTAFAT">)' +
              ']')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DTA. FAT...:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."EMPFAT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMP.FAT:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object edTablet: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 51.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPOK"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object lbTablet: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 51.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'PEDIDO NO TABLET/SITE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object edTabletDt: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 51.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DATAIMPORTACAO"]  [frxRelatorio."HORAIMPORTACAO"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object lbTabletDt: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 51.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DT:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbDigitadorDoc: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllNumDocOnAfterPrint'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODDIG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDigitadorDoc: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DIGITADOR:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMsgPed: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MSGPED">) = '#39#39','#39#39','#39'MENSAGEM PEDIDO: '#39'+<' +
              'frxRelatorio."MSGPED">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMsgExp: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MSGEXP">) = '#39#39','#39#39','#39'MENSAGEM EXPEDICAO: ' +
              #39'+<frxRelatorio."MSGEXP">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllHoraInicial: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."HORAINICIAL"> <> '#39#39', '#39'HORA SITE:'#39', '#39#39')]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbHoraInicial: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."HORAINICIAL"> <> '#39#39', <frxRelatorio."HORAINIC' +
              'IAL">, '#39#39')]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object rllTipAte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."CODTPA">) = '#39#39','#39#39','#39'TIPO DE ATENDIMENTO:' +
              ' '#39'+<frxRelatorio."CODTPA">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupSubTot: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1507.200000000000000000
        OnAfterPrint = 'rlbRodapGroupVendOnAfterPrint'
        Child = frxRelPedDocDocM.ChildPagAnt
        object rllSubTot: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUB-TOTAL DO DOCUMENTO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotIpiResumo: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDoc: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'rllNumDoc')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo20: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldTotCustosUB: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldTotMargemSub: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes) ' +
              ', SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))] ')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 816.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object Memo18: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesFinGer: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotIpiSumario: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbTotIteGeral: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo1OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."V' +
              'PGANT">,rlbDetalhes)  - SUM(<frxRelatorio."DESFIN">, rlbDetalhes' +
              ')]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 51.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldTotCustoGer: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rldTotMargemGer: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes) ' +
              ', SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildPagAnt: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 697.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelPedDocDocM.ChildDesFin
        PrintChildIfInvisible = True
        object Memo16: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGAMENTO ANTECIPADO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo21: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VPGANT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildDesFin: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelPedDocDocM.ChildTotDoc
        PrintChildIfInvisible = True
        object Memo22: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO FINANCEIRO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo24: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DESFIN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildTotDoc: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 765.000000000000000000
        Width = 1507.200000000000000000
        object Memo25: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDocTot: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocTotOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'rllNumDoc')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo26: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo26OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)-<frxRelatorio."VPGANT"' +
              '>-<frxRelatorio."DESFIN">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdServico: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 629.000000000000000000
        Width = 1507.200000000000000000
        Stretched = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo18OnBeforePrint'
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DESSER"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo25OnBeforePrint'
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."VALSER"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelPedDocDocJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43018.400684398150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '    strNumDoc : String;'
      '    fltTopReferencia : Real;'
      '    fltAlturaInicial : Real;        '
      '    strDocAnt : String;                              '
      '    fltTotDes : Real;                    '
      '  '
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
      ''
      'procedure rllNumDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllNumDoc.Text := strNumDoc;                              '
      'end;'
      ''
      'procedure rllCodigoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strNumDoc := '#39'('#39' + <frxRelatorio."NUMDOC"> + '#39')'#39';  '
      'end;'
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      '  Var '
      '   fltTopAux: Real;'
      'begin'
      '  ChildPagAnt.Visible := (<frxRelatorio."VPGANT"> > 0);'
      '  ChildDesFin.Visible := (<frxRelatorio."DESFIN"> > 0);'
      
        '  ChildTotDoc.Visible := ChildPagAnt.Visible Or ChildDesFin.Visi' +
        'ble;'
      ''
      '  If (ChildTotDoc.Visible) Then                          '
      '    rllSubTot.Text := '#39'SUB-TOTAL DO DOCUMENTO:'#39
      '  Else'
      '    rllSubTot.Text := '#39'TOTAL DO DOCUMENTO:'#39';            '
      '  '
      '  rlbGrupo.Height := fltAlturaInicial;'
      
        '  fltTopAux       := fltTopReferencia;                          ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                '
      '    '
      '  If (Trim(<frxRelatorio."MOTBAI">) <> '#39#39') Then'
      '  Begin'
      '    rllMotBai.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMotBai.Height;'
      
        '    fltTopAux := fltTopAux + rllMotBai.Height;                  ' +
        '               '
      '  End;              '
      '  If (Trim(<frxRelatorio."MSGPED">) <> '#39#39') Then'
      '  Begin              '
      '    rllMsgPed.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMsgPed.Height;'
      
        '    fltTopAux := fltTopAux + rllMsgPed.Height;                  ' +
        '               '
      '  End;'
      '  If (Trim(<frxRelatorio."MSGEXP">) <> '#39#39') Then'
      '  Begin              '
      '    rllMsgExp.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllMsgExp.Height;'
      
        '    fltTopAux := fltTopAux + rllMsgExp.Height;                  ' +
        '               '
      '  End;'
      '  If (Trim(<frxRelatorio."CODTPA">) <> '#39#39') Then'
      '  Begin              '
      '    rllTipAte.Top := fltTopAux;                          '
      '    rlbGrupo.Height := rlbGrupo.Height + rllTipAte.Height;'
      
        '    fltTopAux := fltTopAux + rllTipAte.Height;                  ' +
        '               '
      '  End;'
      '  If (Trim(<frxRelatorio."HORAINICIAL">) <> '#39#39') Then'
      '  Begin'
      '    If (rlbGrupo.Height = fltAlturaInicial) Then'
      
        '      rlbGrupo.Height := rlbGrupo.Height + rllHoraInicial.Height' +
        ';'
      '  End;            '
      ''
      '  If strDocAnt <> <frxRelatorio."NUMDOC"> Then'
      '  Begin'
      
        '    fltTotDes := fltTotDes + (<frxRelatorio."DESFIN"> + <frxRela' +
        'torio."VPGANT">);'
      '  End;'
      ''
      '  strDocAnt := <frxRelatorio."NUMDOC">;'
      ''
      '  if Trim(<frxRelatorio."NUMPOK">) <> '#39#39' then'
      '  begin'
      
        '    lbTablet.visible   := true;                                 ' +
        '                                            '
      '    edTablet.visible   := true;'
      '    lbTabletDt.visible := true;'
      '    edTabletDt.visible := true;        '
      '  end'
      '  else'
      '  begin'
      
        '    lbTablet.visible   := false;                                ' +
        '                                             '
      '    edTablet.visible   := false;'
      '    lbTabletDt.visible := false;'
      '    edTabletDt.visible := false;  '
      '  end;'
      '    '
      'end;'
      ''
      'procedure rllNumDocTotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllNumDocTot.Text := strNumDoc;                              '
      'end;'
      ''
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdServico.Visible := (Pos(<frxRelatorio."CODITE">, ITESER) > ' +
        '0);                                                             ' +
        '                          '
      'end;'
      ''
      'procedure Memo52OnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    sTemp: String;                                            '
      'begin'
      
        '  sTemp := Copy(<frxRelatorio."VALSER">, 1, Length(<frxRelatorio' +
        '."VALSER">) - 7);'
      ''
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39'.'#39', '#39'#'#39');'
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39','#39', '#39'.'#39');'
      
        '  sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, L' +
        'ength(sTemp)), '#39'#'#39', '#39','#39');'
      ''
      '  Memo52.Text := sTemp;  '
      'end;'
      ''
      'procedure Memo46OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo46.Text := Copy(<frxRelatorio."DESSER">, 1, Length(<frxRel' +
        'atorio."DESSER">) - 7);           '
      'end;'
      ''
      'begin'
      '  strNumDoc := '#39#39';                    '
      '  strDocAnt := '#39#39';                         '
      '  fltTotDes := 0;'
      '  fltTopReferencia := rllMotBai.Top;      '
      
        '  fltAlturaInicial := (rlbGrupo.Height - (rlbGrupo.Height - rllM' +
        'otBai.Top)) + 5;'
      'end.')
    Left = 63
    Top = 16
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaAnalitico: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 292.400000000000000000
      PaperHeight = 300.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 349.504020000000000000
        Top = 18.897650000000000000
        Width = 1067.339272000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -128.730364000000000000
          Top = 17.000000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 0.000344659999968577
          Top = 34.000000000000000000
          Width = 1067.338582680000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 894.539272000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 980.939272000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 894.539272000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object rllCliente: TfrxMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarca: TfrxMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          WordWrap = False
        end
        object rllRegiao: TfrxMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REGIAO]')
          ParentFont = False
          WordWrap = False
        end
        object rllEmpresa: TfrxMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllDigitador: TfrxMemoView
          Align = baLeft
          Top = 153.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DIGITADOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllVendedor: TfrxMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllFornecedor: TfrxMemoView
          Align = baLeft
          Top = 170.000000000000000000
          Width = 527.470810000000000000
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
          WordWrap = False
        end
        object rllGrupos: TfrxMemoView
          Align = baLeft
          Top = 187.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHA/GRUPO]')
          ParentFont = False
          WordWrap = False
        end
        object rllLibCom: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 102.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibCom]')
          ParentFont = False
          WordWrap = False
        end
        object rllLibFin: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 119.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LibFin]')
          ParentFont = False
          WordWrap = False
        end
        object rllCidade: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 136.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object rllRepresentante: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 153.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          ParentFont = False
          WordWrap = False
        end
        object rllDepartamento: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 170.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
          WordWrap = False
        end
        object rllOrdem: TfrxMemoView
          Align = baWidth
          Top = 329.598464250000000000
          Width = 1067.339272000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 85.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMCMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 187.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPOENTREGA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 68.000000000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPATE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Align = baLeft
          Top = 204.094620000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FATURAMENTO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Top = 221.102362200000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPODEQTD]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 204.094620000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPODEOPERACAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 221.102362200000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAPREVIS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 238.110236220000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Align = baLeft
          Top = 238.110236220000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OCORRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Align = baLeft
          Top = 255.118110240000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENTCD]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Align = baRight
          Left = 543.647991999999900000
          Top = 256.008040000000000000
          Width = 523.691280000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FASEOBRA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Top = 272.126160000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 273.126160000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LISPED]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Align = baLeft
          Top = 310.023810000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LISADI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 291.023810000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ORIGEM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Align = baRight
          Left = 539.868461999999900000
          Top = 309.700990000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDCOR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          Align = baLeft
          Top = 291.102350000000000000
          Width = 527.470810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LISATE]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 19.007874020000000000
        ParentFont = False
        Top = 650.079160000000000000
        Width = 1067.339272000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        AllowSplit = True
        Child = frxRelPedDocDocJ.chdServico
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1067.339272000000000000
          Height = 19.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rllCodigo: TfrxMemoView
          Width = 34.015735830000000000
          Height = 17.007874020000000000
          OnAfterPrint = 'rllCodigoOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllEmp: TfrxMemoView
          Left = 37.692913390000000000
          Width = 267.905641180000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMargem: TfrxMemoView
          Left = 891.850422990000000000
          Top = 0.220469999999977500
          Width = 71.811026060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbVrIpiTit: TfrxMemoView
          Left = 835.275646690000000000
          Width = 56.692906060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."TOTIPI"]')
          ParentFont = False
          WordWrap = False
        end
        object rldQtdOri: TfrxMemoView
          Left = 590.283586610000000000
          Top = 0.220469999999977500
          Width = 56.692906060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."QTDORI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 650.299305350000000000
          Width = 60.472436060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLitragem: TfrxMemoView
          Left = 714.330742830000000000
          Width = 60.472436060000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 777.582750390000000000
          Width = 56.692906060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 406.173470000000000000
          Width = 53.606316300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENTRET"]')
          ParentFont = False
          WordWrap = False
        end
        object rldMargem: TfrxMemoView
          Left = 1029.795273150000000000
          Width = 34.015726060000000000
          Height = 17.007874020000000000
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
            
              '[(fCalculaMargemMarkup(<frxRelatorio."MAMKP4">, <frxRelatorio."T' +
              'OTCUS">))]')
          ParentFont = False
          WordWrap = False
        end
        object rldTotCusto: TfrxMemoView
          Left = 967.338614410000000000
          Width = 60.472436060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbSaldos: TfrxMemoView
          Left = 526.354670000000000000
          Width = 60.472436060000000000
          Height = 17.007874020000000000
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
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 461.205010000000000000
          Width = 62.047256300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENTREG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 310.000000000000000000
          Width = 90.606316300000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 66.338590000000000000
        Top = 1039.370750000000000000
        Width = 1067.339272000000000000
        object rllNomeForm: TfrxMemoView
          Left = 0.000689320000000000
          Top = 44.440939999999960000
          Width = 1067.338582680000000000
          Height = 20.984230000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 620.149970000000000000
          Top = 44.440939999999960000
          Width = 445.984540000000000000
          Height = 20.984230000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes,2)]')
          ParentFont = False
          WordWrap = False
        end
        object rllInfEmp: TfrxMemoView
          Width = 1065.827460000000000000
          Height = 18.897637800000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '** N'#227'o foi informado o c'#243'digo da empresa, o sistema ir'#225' somar o ' +
              'saldo de estoque de todas as empresas para verificar se o produt' +
              'o pode ser atendido.')
          ParentFont = False
          WordWrap = False
        end
        object rllMsg: TfrxMemoView
          Top = 18.897637799999980000
          Width = 1065.827460000000000000
          Height = 18.897637795275600000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '** totais do anal'#237'tico e sint'#233'tico podem n'#227'o bater pois podem ex' +
              'istir baixas parciais de documentos.')
          ParentFont = False
          WordWrap = False
        end
        object lnvGroupFooter2: TfrxLineView
          Align = baBottom
          Top = 66.338590000000000000
          Width = 1507.199999985190000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object lnvReportSummary1: TfrxLineView
          Align = baBottom
          Top = 66.338590000000000000
          Width = 1507.199999990000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 430.866420000000000000
        Width = 1067.339272000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1067.339272000000000000
          Height = 18.897637800000000000
          Fill.BackColor = clSilver
        end
        object rllNumDocTit: TfrxMemoView
          Width = 34.015735830000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLitragem: TfrxMemoView
          Left = 706.771682830000000000
          Width = 60.472436060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LT./KG.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVrIpiTit: TfrxMemoView
          Left = 827.716586690000000000
          Width = 56.692906060000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. IPI')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTitQtd: TfrxMemoView
          Left = 646.740245350000000000
          Width = 60.472436060000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVrAntecTit: TfrxMemoView
          Left = 768.244160390000000000
          Width = 60.472436060000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PR. UNIT.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllQtdOri: TfrxMemoView
          Left = 585.826876610000000000
          Width = 60.472436060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QT.ORI.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllPrevisaoTit: TfrxMemoView
          Left = 36.692913390000000000
          Width = 269.464701180000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVTotalTit: TfrxMemoView
          Left = 885.409482990000000000
          Width = 75.590556060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT. PRO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 411.173470000000000000
          Width = 46.047256300000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENT.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMargemTit: TfrxMemoView
          Left = 1029.795273150000000000
          Width = 34.015726060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MAR')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotCusTit: TfrxMemoView
          Left = 963.763784410000000000
          Width = 64.251966060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CUS.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaldos: TfrxMemoView
          Left = 522.472790000000000000
          Width = 60.472436060000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 461.205010000000000000
          Width = 65.826786300000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. ENTREGA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 310.000000000000000000
          Top = 0.133579999999994900
          Width = 98.267726300000010000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC. FIS.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 155.385851180000000000
        Top = 472.441250000000000000
        Width = 1067.339272000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio."NUMDOC"'
        object shpCab: TfrxShapeView
          Align = baClient
          Width = 1067.339272000000000000
          Height = 155.385851180000000000
          Fill.BackColor = 14342874
        end
        object Memo3: TfrxMemoView
          Left = 102.488250000000000000
          Width = 116.636240000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 11.338590000000000000
          Width = 86.400000000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 495.897960000000000000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 401.409710000000000000
          Width = 90.179530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. ENTRADA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 697.874460000000000000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PREVIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 603.386210000000000000
          Width = 90.179530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. PREVIS'#195'O:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 892.748610000000000000
          Width = 169.549660000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 793.701300000000000000
          Width = 90.179530000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbConPag: TfrxMemoView
          Left = 103.488250000000000000
          Top = 18.897637799999980000
          Width = 408.786210000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(fFormataCondPag(<frxRelatorio."CONPAG">))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 11.338590000000000000
          Top = 18.897637799999980000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COND. PGTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 892.748610000000000000
          Top = 18.897637799999980000
          Width = 169.549660000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PESBRU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 793.701300000000000000
          Top = 18.897637795275610000
          Width = 90.179530000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PESO BRUTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 103.488250000000000000
          Top = 37.795275590000020000
          Width = 679.786210000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 11.338590000000000000
          Top = 37.795275590000020000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 614.748610000000000000
          Top = 18.897637799999980000
          Width = 169.549660000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMCMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 515.701299999999900000
          Top = 18.897637799999980000
          Width = 90.179530000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PED. COMPRA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMotBai: TfrxMemoView
          Left = 11.338590000000000000
          Top = 75.590563390000000000
          Width = 873.180150000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MOTBAI">) = '#39#39','#39#39','#39'MOTIVO BAIXA: '#39'+<frx' +
              'Relatorio."MOTBAI">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 294.700990000000000000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 226.551330000000000000
          Width = 71.281880000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMPRESA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 11.338590000000000000
          Top = 56.692950000000050000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOC.FAT.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 223.771800000000000000
          Top = 56.692950000000050000
          Width = 67.502350000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP.FAT.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 380.291590000000000000
          Top = 56.692950000000050000
          Width = 63.722820000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DTA.FAT.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 103.047310000000000000
          Top = 56.692950000000050000
          Width = 116.636240000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCFAT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 296.582870000000000000
          Top = 56.692950000000050000
          Width = 82.620470000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMPFAT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 446.740125750000000000
          Top = 56.692950000000050000
          Width = 86.400000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."DTAFAT"> = '#39'0'#39', '#39#39', <frxRelatorio."DTAFAT">)' +
              ']')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object edTablet: TfrxMemoView
          Left = 698.331170000000000000
          Top = 56.692950000000050000
          Width = 188.976377950000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPOK"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lbTablet: TfrxMemoView
          Left = 536.811380000000000000
          Top = 56.692950000000050000
          Width = 158.211070000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO NO TABLET/SITE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object lbTabletDt: TfrxMemoView
          Left = 889.969080000000000000
          Top = 56.692950000000050000
          Width = 41.045640000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object edTabletDt: TfrxMemoView
          Left = 935.323440000000000000
          Top = 56.692950000000050000
          Width = 124.195300000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DATAIMPORTACAO"]  [frxRelatorio."HORAIMPORTACAO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbDigitadorDoc: TfrxMemoView
          Left = 893.047310000000000000
          Top = 39.558749999999970000
          Width = 169.549660000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllDigitadorDoc: TfrxMemoView
          Left = 794.000000000000000000
          Top = 39.558749999999970000
          Width = 90.179530000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DIGITADOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllMsgPed: TfrxMemoView
          Left = 11.338590000000000000
          Top = 94.558749999999970000
          Width = 1050.180150000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MSGPED">) = '#39#39','#39#39','#39'MENSAGEM PEDIDO: '#39'+<' +
              'frxRelatorio."MSGPED">)]')
          ParentFont = False
          WordWrap = False
        end
        object rllMsgExp: TfrxMemoView
          Left = 11.338590000000000000
          Top = 113.558750000000000000
          Width = 1050.180150000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."MSGEXP">) = '#39#39','#39#39','#39'MENSAGEM EXPEDI'#199#195'O: ' +
              #39'+<frxRelatorio."MSGEXP">)]')
          ParentFont = False
          WordWrap = False
        end
        object rllHoraInicial: TfrxMemoView
          Left = 892.000000000000000000
          Top = 75.590563390000000000
          Width = 77.045640000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."HORAINICIAL"> <> '#39#39', '#39'HORA SITE:'#39', '#39#39')] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbHoraInicial: TfrxMemoView
          Left = 972.000000000000000000
          Top = 75.590563390000000000
          Width = 88.195300000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              ' [IIF(<frxRelatorio."HORAINICIAL"> <> '#39#39', <frxRelatorio."HORAINI' +
              'CIAL">, '#39#39')]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTipAte: TfrxMemoView
          Left = 11.338590000000000000
          Top = 132.558750000000000000
          Width = 1050.180150000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(Trim(<frxRelatorio."CODTPA">) = '#39#39','#39#39','#39'TIPO DE ATENDIMENTO:' +
              ' '#39'+<frxRelatorio."CODTPA">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupSubTot: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 733.228820000000000000
        Width = 1067.339272000000000000
        Child = frxRelPedDocDocJ.ChildPagAnt
        object rllSubTot: TfrxMemoView
          Left = 321.764070000000000000
          Width = 180.963760000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB-TOTAL DO DOCUMENTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotIpiResumo: TfrxMemoView
          Left = 832.275646690000000000
          Width = 56.692913390000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNumDoc: TfrxMemoView
          Left = 514.299630000000000000
          Width = 90.708666300000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'rllNumDocOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'rllNumDoc')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 892.307132990000000000
          Width = 71.811023620000000000
          Height = 18.897637800000000000
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
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rldTotCustoSub: TfrxMemoView
          Left = 966.440964410000000000
          Width = 60.472440940000000000
          Height = 18.897637800000000000
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
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rldTotMargemSub: TfrxMemoView
          Left = 1028.795273150000000000
          Width = 34.015748030000000000
          Height = 18.897637800000000000
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
            
              '[(fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes)' +
              ' , SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 66.141732280000000000
        Top = 948.662030000000000000
        Width = 1067.339272000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object Memo18: TfrxMemoView
          Left = 321.897637800000000000
          Width = 180.963760000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbDesFinGer: TfrxMemoView
          Left = 514.299212600000000000
          Width = 90.708666300000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotIpiSumario: TfrxMemoView
          Left = 782.362226690000000000
          Width = 68.031496060000000000
          Height = 18.897637795275600000
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
            '[SUM(<frxRelatorio."TOTIPI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbTotIteGeral: TfrxMemoView
          Left = 854.173242990000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
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
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxRelatorio."V' +
              'PGANT">,rlbDetalhes)  - SUM(<frxRelatorio."DESFIN">, rlbDetalhes' +
              ')]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 321.897637800000000000
          Top = 18.897637799999980000
          Width = 180.963760000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 514.299212600000000000
          Top = 18.897637799999980000
          Width = 90.708666300000000000
          Height = 18.897637800000000000
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
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 321.897637800000000000
          Top = 37.795275589999960000
          Width = 180.963760000000000000
          Height = 18.897637795275600000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 514.299212600000000000
          Top = 37.795275589999960000
          Width = 90.708666300000000000
          Height = 18.897637795275600000
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
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rldTotCustoGer: TfrxMemoView
          Left = 925.984254410000000000
          Width = 68.031496060000000000
          Height = 18.897637795275600000
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
            '[SUM(<frxRelatorio."TOTCUS">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rldTotMargemGer: TfrxMemoView
          Left = 997.795273150000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
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
            
              '[(fCalculaMargemMarkup( SUM(<frxRelatorio."MAMKP4">,rlbDetalhes)' +
              ' , SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baClient
          Width = 1067.339272000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildPagAnt: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 774.803650000000000000
        Width = 1067.339272000000000000
        Child = frxRelPedDocDocJ.ChildDesFin
        PrintChildIfInvisible = True
        object Memo16: TfrxMemoView
          Left = 321.897637800000000000
          Width = 180.963760000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PAGAMENTO ANTECIPADO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 854.173242990000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
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
            '[frxRelatorio."VPGANT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildDesFin: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 816.378480000000000000
        Width = 1067.339272000000000000
        Child = frxRelPedDocDocJ.ChildTotDoc
        PrintChildIfInvisible = True
        object Memo22: TfrxMemoView
          Left = 321.897637800000000000
          Width = 180.963760000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO FINANCEIRO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 854.173242990000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
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
            '[frxRelatorio."DESFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildTotDoc: TfrxChild
        FillType = ftBrush
        Height = 28.346456690000000000
        Top = 857.953310000000000000
        Width = 1067.339272000000000000
        object Memo25: TfrxMemoView
          Left = 321.897637800000000000
          Width = 180.963760000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNumDocTot: TfrxMemoView
          Left = 514.299212600000000000
          Width = 90.708666300000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'rllNumDocTotOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'rllNumDoc')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 854.173242990000000000
          Width = 68.031496060000000000
          Height = 18.897637800000000000
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
            
              '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)-<frxRelatorio."VPGANT"' +
              '>-<frxRelatorio."DESFIN">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object chdServico: TfrxChild
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 691.653990000000000000
        Width = 1067.339272000000000000
        Stretched = True
        object rllZebraSer: TfrxMemoView
          Align = baClient
          Width = 1067.339272000000000000
          Height = 17.007874020000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Width = 642.519685040000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'Memo46OnBeforePrint'
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESSER"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Align = baRight
          Left = 651.591240499999900000
          Width = 415.748031500000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'Memo52OnBeforePrint'
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VALSER"]')
          ParentFont = False
        end
      end
    end
  end
end
