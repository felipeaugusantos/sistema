object frmRelRcxResumoCaixaMod: TfrmRelRcxResumoCaixaMod
  Left = 0
  Top = 0
  ClientHeight = 195
  ClientWidth = 454
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
  object frxRelRcxResumoCaixaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45553.637080046300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltSaldo: Double;'
      '  fltSomaValDoc: Double;'
      '  blnZebra: Boolean;'
      '  intSeqAnt: Integer;'
      '  intSeqAnt1: Integer;'
      '  fltSomaSeq: Double;'
      '  fltTotalSeq: Double;'
      '  blnCheques: Boolean;      '
      '  '
      'procedure rllSaliniAOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  rllSaliniA.visible := False;'
      '  rllTitSalIniA.Visible := False;'
      '  rllCarIniA.Visible := False;'
      '  rllDinIniA.Visible := False;'
      '  rllChaIniA.Visible := False;'
      '  rllchpIniA.Visible := False;'
      
        '  rllOrdIniA.Visible := False;                                  ' +
        '            '
      'end;'
      '     '
      'procedure rlbDetGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildTroFpg.Visible := <frxRelatorio_RelRcx."TROSEQ"> <> '#39#39';'
      '  '
      '  if (<frxRelatorio_RelRcx."JURDES"> = '#39#39') Then'
      '  Begin                      '
      ''
      
        '    If (Not fAdicionaCheques(<frxRelatorio_RelRcx."RCX_DOCUME">,' +
        ' <frxRelatorio_RelRcx."RCX_CODEMP">, <frxRelatorio_RelRcx."SEQCO' +
        'N">, <frxRelatorio_RelRcx."DTACAD">)) Or'
      
        '       ((<frxRelatorio_RelRcx."CHQAVI"> = 0 ) And (<frxRelatorio' +
        '_RelRcx."CHQPRE"> = 0 )) Or ((<frxRelatorio_RelRcx."ESPDOC"> = '#39 +
        'CC'#39') And (<SEQBAI> = '#39'S'#39')) Or                 '
      
        '       ((<frxRelatorio_RelRcx."DINHEI"> + <frxRelatorio_RelRcx."' +
        'CARREC"> + <frxRelatorio_RelRcx."CHQAVI"> + <frxRelatorio_RelRcx' +
        '."CHQPRE"> + <frxRelatorio_RelRcx."ORDREC">) = 0) '
      '       Then'
      '    Begin              '
      '      rlbChqs.Visible := False;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbMotDes;            '
      '      End Else'
      '      Begin'
      
        '        if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN             ' +
        '                                                                ' +
        '               '
      '          rlbDetGrupo.Child := rlbMotDes'
      '        else'
      '        begin'
      
        '          rllbEstorno.Highlight.Color := rllZebra.Highlight.Colo' +
        'r;                                                              ' +
        '                                                   '
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbMotDes;                      ' +
        '                    '
      '        end;                  '
      '      End;                  '
      '    End'
      '    Else'
      '    Begin'
      '      rlbChqs.Visible := True;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbChqs;            '
      '      End Else'
      '      Begin                    '
      
        '        if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN             ' +
        '                                                                ' +
        '               '
      '          rlbDetGrupo.Child := rlbChqs'
      '        else'
      '        begin'
      '                      '
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbChqs;                        ' +
        '                  '
      '        end;'
      '      End;                  '
      '    End;'
      '  End'
      '  Else'
      '  Begin'
      '    rlbChqs.Visible := False;'
      '    If ChildTroFpg.Visible Then'
      '    Begin'
      '      rlbDetGrupo.Child := ChildTroFpg;'
      '      ChildTroFpg.Child := rlbMotDes;            '
      '    End  Else'
      '    Begin                    '
      
        '      if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN               ' +
        '                                                                ' +
        '             '
      '        rlbDetGrupo.Child := rlbMotDes'
      '      else'
      '      begin'
      '        rlbDetGrupo.Child  := ChildEstorno;'
      
        '        ChildEstorno.Child := rlbMotDes;                        ' +
        '                  '
      '      end;'
      '    End;                  '
      '  End;'
      ''
      '  If (<SEQBAI> = '#39'S'#39') And (<MODRCX> = '#39'1'#39') Then'
      '  Begin'
      '    rdbDin.Visible := (<frxRelatorio_RelRcx."DINHEI"> <> 0);'
      '    rdbCart.Visible := (<frxRelatorio_RelRcx."CARREC"> <> 0);'
      
        '    rdbChqVista.Visible := (<frxRelatorio_RelRcx."CHQAVI"> <> 0)' +
        ';'
      '    rdbChqPre.Visible := (<frxRelatorio_RelRcx."CHQPRE"> <> 0);'
      '    rdbOrdPag.Visible := (<frxRelatorio_RelRcx."ORDREC"> <> 0);'
      '    rdbValCre.Visible := (<frxRelatorio_RelRcx."VALCRE"> <> 0);'
      '      '
      
        '    rdbValor.Visible := ((<frxRelatorio_RelRcx."DINHEI"> + <frxR' +
        'elatorio_RelRcx."CARREC"> + '
      
        '                          <frxRelatorio_RelRcx."CHQAVI"> + <frxR' +
        'elatorio_RelRcx."CHQPRE"> + '
      '                          <frxRelatorio_RelRcx."ORDREC">) <> 0);'
      '                                '
      '    rdbSaldo.Visible := rdbValor.Visible;'
      ''
      '    If intSeqAnt <> <frxRelatorio_RelRcx."SEQCON"> Then'
      '    Begin'
      '      intSeqAnt := <frxRelatorio_RelRcx."SEQCON">;'
      
        '      //blnZebra := not blnZebra;                               ' +
        '                              '
      '    End;      '
      '  End'
      '  Else'
      '  Begin'
      '    rdbDin.Visible      := True;'
      '    rdbCart.Visible     := True;'
      '    rdbChqVista.Visible := True;'
      '    rdbChqPre.Visible   := True;'
      '    rdbOrdPag.Visible   := True;'
      '    rdbValCre.Visible   := True;'
      '    rdbValor.Visible    := True;'
      '    rdbSaldo.Visible    := True;  '
      ''
      '    //blnZebra := not blnZebra;'
      '  End;'
      ''
      '  {************************************************}'
      '  {* Exibir cheques apenas no '#250'ltimo doc da baixa *}'
      
        '  {* quando estiver no Modelo 2                   *}            ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                              '
      '  {*********************************************AJ*}          '
      
        '  If (intSeqAnt1 <> <frxRelatorio_RelRcx."SEQCON">) And (<SEQBAI' +
        '> = '#39'S'#39')  Then'
      '  Begin            '
      
        '    intSeqAnt1 := <frxRelatorio_RelRcx."SEQCON">;               ' +
        '          '
      '    blnZebra := Not blnZebra;'
      '    fltSomaSeq := 0;'
      
        '    blnCheques := False;                                        ' +
        '        '
      
        '    fltTotalSeq := fTotalSeq(<frxRelatorio_RelRcx."RCX_CODEMP">,' +
        ' <frxRelatorio_RelRcx."SEQCON">, <frxRelatorio_RelRcx."DTACAD">)' +
        ';'
      '  End;'
      '    '
      '  If (<SEQBAI> = '#39'S'#39') And (<MODRCX> = '#39'2'#39') Then'
      '  Begin              '
      '   '
      '    fltSomaSeq := fltSomaSeq + <frxRelatorio_RelRcx."VALDOC">;'
      '        '
      '    rlbChqs.Visible := False;'
      
        '    If fAdicionaCheques(<frxRelatorio_RelRcx."RCX_DOCUME">, <frx' +
        'Relatorio_RelRcx."RCX_CODEMP">, <frxRelatorio_RelRcx."SEQCON">, ' +
        '<frxRelatorio_RelRcx."DTACAD">) Then'
      
        '      blnCheques := True;                                       ' +
        '                                                                ' +
        '                                      '
      '    If (blnCheques) And (fltSomaSeq = (fltTotalSeq)) Then'
      
        '    Begin                                                       ' +
        '          '
      '      rlbChqs.Visible := True;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbChqs;            '
      '      End Else'
      '      Begin                    '
      '        rlbDetGrupo.Child := rlbChqs;'
      '      End;                 '
      '    End'
      '    Else'
      '    Begin'
      '      rlbChqs.Visible := False;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbMotDes;            '
      '      End Else'
      '      Begin                    '
      
        '        if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN             ' +
        '                                                                ' +
        '               '
      '          rlbDetGrupo.Child := rlbMotDes'
      '        else'
      '        begin'
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbMotDes;                      ' +
        '                    '
      '        end;'
      '      End;                 '
      '    End;  '
      '  End;  '
      
        '                          {*************************************' +
        '****************}'
      
        '                          {* MANTER A MESMA ZEBRA QUANDO TEM JUR' +
        'OS OU DESCONTO *}                                               ' +
        '                                                                ' +
        '                                                       '
      
        '                          {************************08/03/2018***' +
        'Req.60352***WS**}'
      
        '  If (<SEQBAI> <> '#39'S'#39') And (<frxRelatorio_RelRcx."JURDES"> = '#39#39')' +
        ' Then'
      '    blnZebra := not blnZebra;      '
      '    '
      
        '  rllZebra.Visible := blnZebra;                                 ' +
        '                               '
      
        '  rllZebra1.Visible := True;                                    ' +
        '                            '
      'end;'
      ''
      'procedure rllSalIniAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <Page> > 1 Then'
      '  Begin                '
      '    rllSalIniA.visible := False;'
      '    rllTitSalIniA.Visible := False;'
      '    rllCarIniA.Visible := False;'
      '    rllDinIniA.Visible := False;'
      '    rllChaIniA.Visible := False;'
      '    rllchpIniA.Visible := False;'
      '    rllOrdIniA.Visible := False;'
      '  End                '
      '  Else'
      '  Begin              '
      '    rllSalIniA.visible := True;'
      '    rllTitSalIniA.Visible := True;'
      '    rllCarIniA.Visible := True;'
      '    rllDinIniA.Visible := True;'
      '    rllChaIniA.Visible := True;'
      '    rllchpIniA.Visible := True;'
      '    rllOrdIniA.Visible := True;        '
      '  End;  '
      'end;'
      ''
      'procedure rllSaliniSOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <Page> > 1 Then'
      '    rllSalIniS.visible := False'
      '  Else'
      '    rllSalIniS.visible := True;  '
      'end;'
      ''
      'procedure rlbMotDesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio_RelRcx."MOTDES"> = '#39#39') Or (<frxRelatorio_Rel' +
        'Rcx."JURDES"> <> '#39'D'#39') Then'
      '    rlbMotDes.Visible := False'
      '  Else'
      '    rlbMotDes.Visible := True;'
      
        '  rllZebra3.Visible := blnZebra;                                ' +
        '                                            '
      'end;'
      ''
      'procedure mmoTitPg1SOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoTitPg1S.Visible := <TOTPAG> <> 0;'
      '  linPGS.Visible := (<TOTPAG> <> 0);        '
      'end;'
      ''
      'procedure mmoValPg1SOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoValPg1S.Visible := <TOTPAG> <> 0;  '
      'end;'
      ''
      'procedure mmoTitPg1AOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoTitPg1A.Visible := <TOTPAG> <> 0;'
      ''
      '  linPG.Visible := (<TOTPAG> <> 0);        '
      'end;'
      ''
      'procedure mmoValPg1AOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoValPg1A.Visible := <TOTPAG> <> 0;  '
      'end;'
      ''
      'procedure childCabInformAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxResumo."VENENT">) = '#39'0,00'#39' then'
      '  Begin'
      '    rllFaturadoA.Visible  := False;'
      '    rllFaturadoS.Visible  := False;'
      '    rllVenPreEntA.Visible := False;'
      
        '    rllVenPreEntS.Visible := False;                             ' +
        '                             '
      '  End'
      '  Else'
      '  Begin'
      '    rllFaturadoA.Visible  := True;'
      '    rllFaturadoS.Visible  := True;'
      '    rllVenPreEntA.Visible := True;'
      '    rllVenPreEntS.Visible := True;  '
      '  End;  '
      'end;'
      ''
      'procedure rllCodFpgOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDupJus."CTR_DINHEI"> > 0 Then'
      '    rllCodFpg.Text := '#39'DINHEIRO'#39
      ''
      '  Else If <frxDupJus."CTR_CHQAVI"> > 0 Then'
      '    rllCodFpg.Text := '#39'CHEQUE A VISTA'#39
      ''
      '  Else If <frxDupJus."CTR_CHQPRE"> > 0 Then'
      '    rllCodFpg.Text := '#39'CHEQUE A PRAZO'#39
      ''
      '  Else If <frxDupJus."CTR_CARTAO"> > 0 Then'
      '    rllCodFpg.Text := '#39'CARTAO'#39
      ''
      '  Else If <frxDupJus."CTR_ORDPAG"> > 0 Then'
      '    rllCodFpg.Text := '#39'ORDEM DE PAGAMENTO'#39'            '
      ''
      '  Else'
      '    rllCodFpg.Text := '#39#39';  '
      'end;      '
      ''
      'procedure ChildPGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildPG.Visible := (<TOTPAG> <> 0);  '
      'end;'
      ''
      'procedure ChildPGSOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildPGS.Visible := (<TOTPAG> <> 0);  '
      'end;'
      ''
      'procedure rdbSaldoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltSaldo := fltSaldo + <frxRelatorio_RelRcx."SOMSLD">;'
      
        '  fltSomaValDoc := fltSomaValDoc + <frxRelatorio_RelRcx."VALDOC"' +
        '>;                           '
      
        '  rdbSaldo.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);          ' +
        '                        '
      'end;'
      ''
      'procedure rdbSaldoTotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbSaldoTot.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);  '
      'end;'
      ''
      'procedure rdbSaldoGerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbSaldoGer.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);    '
      'end;'
      ''
      'procedure Memo156OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo156.Text := FormatFloat('#39'###,#0.00'#39', fltSomaValDoc + fltSa' +
        'ldo);                                        '
      'end;'
      ''
      'procedure ChildTroFpgOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllZebra2.Visible := blnZebra;  '
      'end;'
      ''
      '  '
      ''
      'procedure Memo213OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   If <frxPagamento."CTP_HIST01"> = '#39#39' Then Begin             '
      '    Memo213.Visible := False;'
      '    rlbPagamentoS.Height := 19;'
      '    rllZebraPGS.Height := 19;                            '
      '  End Else Begin             '
      '    Memo213.Visible := True;'
      '    rlbPagamentoS.Height := 38;'
      '    rllZebraPGS.Height := 38;        '
      '  End;  '
      'end;  '
      ''
      'procedure Memo219OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxPagamento."CTP_HIST01"> = '#39#39' Then Begin             '
      '    Memo219.Visible := False;'
      '    rlbPagamento.Height := 19;'
      '    rllZebraPg.Height := 19;                            '
      '  End Else Begin             '
      '    Memo219.Visible := True;'
      '    rlbPagamento.Height := 38;'
      '    rllZebraPg.Height := 38;        '
      '  End;  '
      'end;'
      ''
      'procedure ChildEstornoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllbEstorno.Visible := blnZebra;  '
      'end;    '
      ''
      'procedure memTotVendasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memTotVendas.Text := FormatFloat('#39'###,#0.00'#39', (<frxResFat."VD_' +
        'VIS"> + <frxResFat."VD_VIS015"> + <frxResFat."VD_FAT"> + <frxRes' +
        'Fat."VD_CAR">));'
      
        '  Memo408.Text      := FormatFloat('#39'###,#0.00'#39', (<frxResFat."VD_' +
        'VIS"> + <frxResFat."VD_VIS015"> + <frxResFat."VD_FAT"> + <frxRes' +
        'Fat."VD_CAR">));'
      
        '  memTotVendasFreA.Text := FormatFloat('#39'###,#0.00'#39', (<frxResFat.' +
        '"VD_VISFRE"> + <frxResFat."VD_VISFRE015"> + <frxResFat."VD_FATFR' +
        'E"> + <frxResFat."VD_CARFRE">));'
      
        '  memTotVendasFreB.Text := FormatFloat('#39'###,#0.00'#39', (<frxResFat.' +
        '"VD_VISFRE"> + <frxResFat."VD_VISFRE015"> + <frxResFat."VD_FATFR' +
        'E"> + <frxResFat."VD_CARFRE">));      '
      'end;'
      ''
      'BEGIN'
      '  fltSaldo := <SALINI>;'
      '  fltSomaValDoc := 0;'
      '  fltSomaSeq := 0;'
      
        '  fltTotalSeq := fTotalSeq(<frxRelatorio_RelRcx."RCX_CODEMP">, <' +
        'frxRelatorio_RelRcx."SEQCON">, <frxRelatorio_RelRcx."DTACAD">); ' +
        '                                       '
      '  blnZebra := True;'
      '  intSeqAnt := <frxRelatorio_RelRcx."SEQCON">;'
      '  If (<MODRCX> = '#39'1'#39') Then '
      '    intSeqAnt1 := 0'
      '  Else                  '
      '    intSeqAnt1 := <frxRelatorio_RelRcx."SEQCON">;'
      '  blnCheques := False;'
      '  rlbDetGrupo.OnBeforePrint := '#39'rlbDetGrupoOnBeforePrint'#39';      '
      'END.          ')
    OnNewGetValue = frxRelRcxResumoCaixaMNewGetValue
    Left = 64
    Top = 88
    Datasets = <
      item
        DataSet = frmRelRcxResumoCaixa.frxCheques
        DataSetName = 'frxCheques'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxCredito
        DataSetName = 'frxCredito'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDetOutrosFpg
        DataSetName = 'frxDetOutrosFpg'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDupJus
        DataSetName = 'frxDupJus'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxFechamentos
        DataSetName = 'frxFechamentos'
      end
      item
        DataSet = frxGen_RelRcx
        DataSetName = 'frxGen_RelRcx'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
        DataSetName = 'frxLacresMalotes'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxListVenPraz
        DataSetName = 'frxListVenPraz'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
      end
      item
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResFat
        DataSetName = 'frxResFat'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumoEspecies
        DataSetName = 'frxResumoEspecies'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumofPG
        DataSetName = 'frxResumoFpg'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumoVendas
        DataSetName = 'frxResumoVendas'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
      end>
    Variables = <
      item
        Name = ' Resumo'
        Value = Null
      end
      item
        Name = 'fltQtdDia'
        Value = Null
      end
      item
        Name = 'fltQtdDoc'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      BackPicturePrintable = False
      BackPictureStretched = False
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 370.393940000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'rlbDetGrupoOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.ChildTroFpg
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'True'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object rllDesDoc: TfrxMemoView
          Left = 146.645669290000000000
          Width = 113.385863390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDescri: TfrxMemoView
          Left = 261.921259840000000000
          Width = 124.724409448818900000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DESCRI"]')
          ParentFont = False
        end
        object rdbDin: TfrxMemoView
          Left = 389.669291340000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DINHEI"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbCart: TfrxMemoView
          Left = 452.031496060000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CARREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbChqVista: TfrxMemoView
          Left = 514.771653540000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQAVI"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbChqPre: TfrxMemoView
          Left = 577.889763780000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQPRE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbOrdPag: TfrxMemoView
          Left = 637.606299210000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."ORDREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValCre: TfrxMemoView
          Left = 753.748031500000000000
          Width = 62.362194960000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALCRE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValor: TfrxMemoView
          Left = 816.110236220000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbSaldo: TfrxMemoView
          Left = 876.204724410000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllDtaCad: TfrxMemoView
          Left = 99.401574800000000000
          Width = 45.354328270000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object rllSeqBai: TfrxMemoView
          Left = 33.637795280000000000
          Width = 64.251966060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."SEQCON"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDesCodOpe: TfrxMemoView
          Left = 4.157480310000000000
          Width = 26.456692910000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CODOPE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo525: TfrxMemoView
          Left = 697.322834650000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."PIXREC"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 32.125984260000000000
        Top = 200.315090000000000000
        Width = 944.882500000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 0.645640000000000000
          Width = 942.992125980000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object rllTitDoc: TfrxMemoView
          Left = 146.645669290000000000
          Width = 60.472443390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUME.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitHis: TfrxMemoView
          Left = 261.921259840000000000
          Width = 124.724404570000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 389.669291340000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 452.031496060000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 514.771653540000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLHIST: TfrxMemoView
          Left = 577.889763780000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.PR'#201)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 637.606299210000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PAG.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 753.748031500000000000
          Width = 62.362194960000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.CRED.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 816.110236220000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 876.204724410000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitSalIniA: TfrxMemoView
          Left = 4.157477870000000000
          Top = 17.007874020000000000
          Width = 278.400000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllSalIniAOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SALDO INICIAL: [SALINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitDta: TfrxMemoView
          Left = 99.401574800000000000
          Width = 45.354328270000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDinIniA: TfrxMemoView
          Left = 389.669291340000000000
          Top = 17.007874020000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DININI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCarIniA: TfrxMemoView
          Left = 452.031496060000000000
          Top = 17.007874020000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CARINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllChaIniA: TfrxMemoView
          Left = 514.771653540000000000
          Top = 17.007874020000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CHAINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllChpIniA: TfrxMemoView
          Left = 577.889763780000000000
          Top = 17.007874020000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CHPINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllOrdIniA: TfrxMemoView
          Left = 637.606299210000000000
          Top = 17.007874020000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSalIniA: TfrxMemoView
          Left = 876.204724410000000000
          Top = 17.007874020000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitSeqBai: TfrxMemoView
          Left = 33.637795280000000000
          Width = 64.251966060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SEQBAI')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitCodOpe: TfrxMemoView
          Left = 4.157480310000000000
          Width = 26.456692910000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo523: TfrxMemoView
          Left = 697.322834650000000000
          Top = 15.118120000000010000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PIXINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo524: TfrxMemoView
          Left = 697.322834650000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PIX')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 120.944881890000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 24.983025000000000000
          Width = 894.916450000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object rllNomeRelatorioA: TfrxMemoView
          Align = baCenter
          Left = 200.731170000000000000
          Top = 35.905511810000000000
          Width = 543.420160000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 831.421090000000000000
          Top = 17.007874020000000000
          Width = 113.461410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 868.082500000000000000
          Top = 35.905511810000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 773.518740000000000000
          Top = 35.905511810000000000
          Width = 94.563760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object rllOrdemA: TfrxMemoView
          Align = baCenter
          Left = 18.897942915000000000
          Top = 102.047244090000000000
          Width = 907.086614170000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          WordWrap = False
        end
        object rllSqFcRxA: TfrxMemoView
          Align = baLeft
          Top = 85.039370080000000000
          Width = 440.617130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[SQFCRX]')
          ParentFont = False
        end
        object rllOperadorA: TfrxMemoView
          Align = baLeft
          Top = 68.031496060000000000
          Width = 440.617130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[OPERADOR]')
          ParentFont = False
        end
        object rllVisualizacao: TfrxMemoView
          Align = baRight
          Left = 504.265370000000000000
          Top = 85.039370080000000000
          Width = 440.617130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
          ParentFont = False
        end
        object rllEspecieA: TfrxMemoView
          Align = baRight
          Left = 504.265370000000000000
          Top = 68.031496060000000000
          Width = 440.617130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          ParentFont = False
        end
        object rllNomeFantasia: TfrxMemoView
          Align = baCenter
          Left = 145.927985000000000000
          Top = 17.007874020000000000
          Width = 653.026530000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 332.598640000000000000
        Width = 944.882500000000000000
        Condition = 'frxRelatorio_RelRcx."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxMemoView
          Left = 7.937007874015750000
          Width = 60.245640000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESP.DOC:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbEspecie: TfrxMemoView
          Left = 71.886580000000000000
          Width = 817.133890000000000000
          Height = 15.118110240000000000
          DataField = 'QUEBRA'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."QUEBRA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1946.457950000000000000
        Width = 944.882500000000000000
        object rllNomeForm: TfrxMemoView
          Top = 17.000000000000000000
          Width = 418.242300000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 413.858426380000000000
          Top = 17.000000000000000000
          Width = 527.243970000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 563.149970000000000000
        Width = 944.882500000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 15.118110239999960000
          Width = 944.882500000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          Left = 120.081880000000000000
          Width = 269.404700000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOCUMENTOS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 389.669291340000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."DINHEI">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 452.031496060000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CARREC">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 514.771653540000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQAVI">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 577.889763780000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQPRE">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 637.606299210000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."ORDREC">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 753.748031500000000000
          Width = 62.362194960000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALCRE">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbValTot: TfrxMemoView
          Left = 816.110236220000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbSaldoTot: TfrxMemoView
          Left = 876.204724410000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rdbSaldoTotOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
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
        object Memo526: TfrxMemoView
          Left = 697.322834650000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."PIXREC">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object chilOperacoesA: TfrxChild
        FillType = ftBrush
        Height = 234.330750160000000000
        Top = 737.008350000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.childCabInformA
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Left = 176.960730000000000000
          Top = 41.236239999999960000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DINHEIRO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntDin: TfrxMemoView
          Left = 486.882190000000000000
          Top = 41.236239999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'DINENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."DINENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiDin: TfrxMemoView
          Left = 585.149970000000000000
          Top = 41.236239999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'DINSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."DINSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalDin: TfrxMemoView
          Left = 683.417750000000000000
          Top = 41.236239999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<DININI>+<frxResumo."DINENT">+<frxResumo."DINSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 176.960730000000000000
          Top = 58.622077999999990000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CHEQUE '#192' VISTA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntChqVis: TfrxMemoView
          Left = 486.882190000000000000
          Top = 58.622077999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQENT_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CHQENT_AVI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiChqVis: TfrxMemoView
          Left = 585.149970000000000000
          Top = 58.622077999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQSAI_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CHQSAI_AVI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalChqVis: TfrxMemoView
          Left = 682.417750000000000000
          Top = 60.622077999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<CHAINI>+<frxResumo."CHQENT_AVI">+<frxResumo."CHQSAI_AVI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 176.960730000000000000
          Top = 76.007916000000030000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CHEQUE PR'#201':')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntChqPre: TfrxMemoView
          Left = 486.882190000000000000
          Top = 76.007916000000030000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CHQENT_PRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiChqPre: TfrxMemoView
          Left = 585.149970000000000000
          Top = 76.007916000000030000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQSAI_PRE'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CHQSAI_PRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalChqPre: TfrxMemoView
          Left = 683.417750000000000000
          Top = 76.007916000000030000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<CHPINI>+<frxResumo."CHQENT_PRE">+<frxResumo."CHQSAI_PRE">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 176.960730000000000000
          Top = 93.393753999999950000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ORDEM DE PAGAMENTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntOrdPag: TfrxMemoView
          Left = 486.882190000000000000
          Top = 93.393753999999950000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."ORDENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiOrdPag: TfrxMemoView
          Left = 585.149970000000000000
          Top = 93.393753999999950000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'ORDSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."ORDSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalOrdPag: TfrxMemoView
          Left = 683.417750000000000000
          Top = 93.393753999999950000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<ORDINI>+<frxResumo."ORDENT">+<frxResumo."ORDSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 176.960730000000000000
          Top = 110.779592000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CART'#195'O DE CR'#201'DITO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntCarCre: TfrxMemoView
          Left = 486.882190000000000000
          Top = 110.779592000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CARENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CARENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiCarCre: TfrxMemoView
          Left = 585.149970000000000000
          Top = 110.779592000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CARSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."CARSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalCarCre: TfrxMemoView
          Left = 683.417750000000000000
          Top = 110.779592000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<CARINI>+<frxResumo."CARENT">+<frxResumo."CARSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 176.960730000000000000
          Top = 166.063080000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OUTROS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntOutros: TfrxMemoView
          Left = 486.882190000000000000
          Top = 166.063080000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'OUTENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."OUTENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiOutros: TfrxMemoView
          Left = 585.149970000000000000
          Top = 166.063080000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."OUTSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalOutros: TfrxMemoView
          Left = 683.417750000000000000
          Top = 166.063080000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<frxResumo."OUTENT">+<frxResumo."OUTSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 176.960730000000000000
          Top = 194.299320000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllEntTotA: TfrxMemoView
          Left = 486.882190000000000000
          Top = 194.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."OUTENT">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaiTotA: TfrxMemoView
          Left = 585.149970000000000000
          Top = 194.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."PIXSAI">+'
            '<frxResumo."OUTSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalTotalA: TfrxMemoView
          Left = 683.417750000000000000
          Top = 194.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
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
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."OUTENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."OUTSAI">+'
            '<frxResumo."PIXSAI">+'
            '<SALINI>]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line9: TfrxLineView
          Left = 176.960730000000000000
          Top = 33.677180000000020000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Left = 176.960730000000000000
          Top = 186.740260000000000000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllOutIni: TfrxMemoView
          Left = 377.275820000000000000
          Top = 166.063080000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '0,00')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCarIni: TfrxMemoView
          Left = 377.275820000000000000
          Top = 110.779592000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[CARINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo161: TfrxMemoView
          Left = 377.275820000000000000
          Top = 93.393753999999950000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[ORDINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo162: TfrxMemoView
          Left = 377.275820000000000000
          Top = 76.007916000000030000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[CHPINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo163: TfrxMemoView
          Left = 377.275820000000000000
          Top = 58.622077999999990000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[CHAINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo164: TfrxMemoView
          Left = 377.275820000000000000
          Top = 41.236239999999960000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[DININI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSalIniResA: TfrxMemoView
          Left = 377.275820000000000000
          Top = 194.299320000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[SALINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 176.960730000000000000
          Top = 146.842610000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FINANCIAMENTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 486.882190000000000000
          Top = 146.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."FINENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 585.149970000000000000
          Top = 146.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."FINSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 683.417750000000000000
          Top = 146.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<FININI>+<frxResumo."FINENT">+<frxResumo."FINSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 377.275820000000000000
          Top = 146.842610000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[FININI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 176.960730000000000000
          Top = 11.000000000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPERA'#199#213'ES')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 486.882190000000000000
          Top = 11.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 585.149970000000000000
          Top = 11.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SA'#205'DAS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 683.417750000000000000
          Top = 11.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO FINAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 377.275820000000000000
          Top = 11.000000000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Left = 177.637910000000000000
          Top = 217.094620000000000000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 176.637910000000000000
          Top = 6.559060000000045000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo528: TfrxMemoView
          Left = 176.637910000000000000
          Top = 128.504020000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PIX:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo529: TfrxMemoView
          Left = 486.559370000000000000
          Top = 128.504020000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."PIXENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo530: TfrxMemoView
          Left = 584.827150000000000000
          Top = 128.504020000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."PIXSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo531: TfrxMemoView
          Left = 683.094930000000000000
          Top = 128.504020000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<PIXINI>+<frxResumo."PIXENT">+<frxResumo."PIXSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo532: TfrxMemoView
          Left = 376.953000000000000000
          Top = 128.504020000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[PIXINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbMotDes: TfrxChild
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 525.354670000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'rlbMotDesOnBeforePrint'
        object rllZebra3: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'True'
          Highlight.FillType = ftBrush
          WordWrap = False
        end
        object rllTitMotDerc: TfrxMemoView
          Left = 7.937007874015750000
          Width = 133.266110000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MOTIVO DO DESCONTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbMotDes: TfrxMemoView
          Left = 147.628619840000000000
          Width = 738.670500000000000000
          Height = 15.118110240000000000
          DataField = 'MOTDES'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOTDES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 684.094930000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.chilOperacoesA
        object Memo13: TfrxMemoView
          Left = 560.357521810000000000
          Width = 249.902350000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotValGer: TfrxMemoView
          Left = 814.110236220000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbSaldoGer: TfrxMemoView
          Left = 876.204724410000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rdbSaldoGerOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line8: TfrxLineView
          Left = 1.559060000000000000
          Top = 17.677180000000020000
          Width = 944.882500000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbChqs: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 483.779840000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.rlbMotDes
        object SubRepChqs: TfrxSubreport
          Align = baClient
          Width = 944.882500000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.qckPaginaC
        end
      end
      object ChildTroFpg: TfrxChild
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 445.984540000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'ChildTroFpgOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.rlbChqs
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'True'
          Highlight.FillType = ftBrush
          WordWrap = False
        end
        object Memo215: TfrxMemoView
          Left = 389.669291340000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TRODIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo216: TfrxMemoView
          Left = 452.031496060000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROCAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo217: TfrxMemoView
          Left = 514.771653540000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo218: TfrxMemoView
          Left = 577.889763780000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROPRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo514: TfrxMemoView
          Left = 637.606299210000000000
          Width = 58.582677170000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROORD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo515: TfrxMemoView
          Left = 697.322834650000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROPIX"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo214: TfrxMemoView
          Left = 139.842610000000000000
          Width = 246.652010000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORMA DE PAGAMENTO ANTERIOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildCancelados: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 1341.733150000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.ChildPG
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object rllQdeCanA: TfrxMemoView
          Left = 223.748031496063000000
          Top = 3.598330000000033000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'QUANTIDADE DE DOCS CANCELADOS:..................................' +
              '..')
          WordWrap = False
        end
        object rlbQdeCanA: TfrxMemoView
          Left = 638.740157480315000000
          Top = 3.598330000000033000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[QTDCAN]')
          WordWrap = False
        end
        object rllVlrCanA: TfrxMemoView
          Left = 223.748031496063000000
          Top = 20.598330000000030000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR TOTAL DOS DOCS CANCELADOS:................................')
          WordWrap = False
        end
        object rlbVlrCanA: TfrxMemoView
          Left = 638.740157480315000000
          Top = 20.598330000000030000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCAN]')
          WordWrap = False
        end
        object linhaQdeCanA: TfrxLineView
          Left = 223.748031500000000000
          Top = 1.118120000000090000
          Width = 509.480314960630000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ChildPG: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1405.985160000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'ChildPGOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.Child3
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object linPg: TfrxLineView
          Left = 223.748031500000000000
          Width = 509.480314960630000000
          Color = clBlack
          Diagonal = True
        end
        object mmoTitPg1A: TfrxMemoView
          Left = 223.748031496063000000
          Top = 3.779530000000022000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitPg1AOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'TOTAL DE PG *:..................................................' +
              '........................')
          WordWrap = False
        end
        object mmoValPg1A: TfrxMemoView
          Left = 638.740157480315000000
          Top = 3.779530000000022000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoValPg1AOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTPAG]')
          WordWrap = False
        end
      end
      object childCabInformA: TfrxChild
        FillType = ftBrush
        Height = 96.377952760000000000
        Top = 994.016390000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'childCabInformAOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.childFpgVenPraA
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo223: TfrxMemoView
          Left = 223.748031496063000000
          Width = 509.480329610000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS INFORMATIVOS')
          ParentFont = False
          WordWrap = False
        end
        object rllFaturadoA: TfrxMemoView
          Left = 223.748031496063000000
          Top = 18.897650000000000000
          Width = 393.977860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'FATURADO:.......................................................' +
              '................................................................' +
              '....................')
          WordWrap = False
        end
        object Memo226: TfrxMemoView
          Left = 223.748031496063000000
          Top = 37.795275589999850000
          Width = 393.977860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'DESCONTO:.......................................................' +
              '................................................................' +
              '.......')
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 223.748031496063000000
          Top = 56.692913389999830000
          Width = 393.977860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'JUROS:..........................................................' +
              '................................................................' +
              '.............')
          WordWrap = False
        end
        object rllVenPreEntA: TfrxMemoView
          Left = 638.740157480000000000
          Top = 18.897650000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VENENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VENENT"]')
          WordWrap = False
        end
        object rllDesconto: TfrxMemoView
          Left = 638.740157480000000000
          Top = 37.795275589999850000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALDES"]')
          WordWrap = False
        end
        object rllJuros: TfrxMemoView
          Left = 638.740157480315000000
          Top = 56.692913389999830000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALJUR"]')
          WordWrap = False
        end
        object Line16: TfrxLineView
          Left = 223.748031500000000000
          Top = 75.590600000000000000
          Width = 509.480314960630000000
          Color = clBlack
          Diagonal = True
        end
        object rllVenPraA: TfrxMemoView
          Left = 223.748031500000000000
          Top = 77.480314959999760000
          Width = 393.977860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDAS '#192' PRAZO:.................................................' +
              '................................................................' +
              '.......')
          WordWrap = False
        end
        object rlbVenPraA: TfrxMemoView
          Left = 638.740157480000000000
          Top = 77.480314959999760000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPRA]')
          WordWrap = False
        end
      end
      object childFpgVenPraA: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 1114.961350000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.childTotVenVisA
        KeepChild = True
        PrintChildIfInvisible = True
        object subVenPraA: TfrxSubreport
          Top = -0.000006100000064180
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page1
        end
      end
      object childTotVenVisA: TfrxChild
        FillType = ftBrush
        Height = 60.472467800000000000
        Top = 1156.536180000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.childFpgVenVisA
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object rllVenVisA: TfrxMemoView
          Left = 223.748031500000000000
          Top = 0.948818900000105700
          Width = 393.977860000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDAS '#192' VISTA:.................................................' +
              '................................................................' +
              '.....')
          WordWrap = False
        end
        object rlbVenVisA: TfrxMemoView
          Left = 638.740157480000000000
          Top = 0.948818900000105700
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENVIS]')
          WordWrap = False
        end
        object linhaVenVisA: TfrxLineView
          Left = 223.748031500000000000
          Width = 509.480314960630000000
          Color = clBlack
          Diagonal = True
        end
      end
      object childFpgVenVisA: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 1239.685840000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.childRodInformA
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object subVenVisA: TfrxSubreport
          Top = -0.000006100000064180
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page2
        end
      end
      object childRodInformA: TfrxChild
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 1281.260670000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.ChildCancelados
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object rllTroDevA: TfrxMemoView
          Left = 223.748031496063000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'TROCAS E DEVOLUCOES:............................................' +
              '................................................................' +
              '......')
          WordWrap = False
        end
        object rlbTroDevA: TfrxMemoView
          Left = 638.740157480315000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TRODEV]')
          WordWrap = False
        end
        object rllVenDiaA: TfrxMemoView
          Left = 223.748031496063000000
          Top = 18.897637799999980000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'VENDAS DO PERIODO:..............................................' +
              '................................................................' +
              '....')
          WordWrap = False
        end
        object rlbVenDiaA: TfrxMemoView
          Left = 638.740157480315000000
          Top = 18.897637799999980000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPER]')
          WordWrap = False
        end
        object linhaTroDevA: TfrxLineView
          Left = 223.748031500000000000
          Width = 509.480314960630000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1814.174400000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.rlbFechamentosA
        KeepChild = True
        PrintChildIfInvisible = True
        object subPagamento: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page5
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 340.157700000000000000
        Top = 1451.339520000000000000
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.Child1
        KeepChild = True
        Stretched = True
        object Memo356: TfrxMemoView
          Left = 223.748031500000000000
          Top = 6.220469999999977000
          Width = 509.480314960000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO LOJA PR'#211'PRIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo357: TfrxMemoView
          Left = 223.748031500000000000
          Top = 28.897650000000120000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA A VISTA:..................................................' +
              '................................................................' +
              '.........................')
          WordWrap = False
        end
        object Memo358: TfrxMemoView
          Left = 643.740157480000000000
          Top = 28.897650000000120000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo359: TfrxMemoView
          Left = 223.748031500000000000
          Top = 67.795300000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo360: TfrxMemoView
          Left = 643.740157480000000000
          Top = 67.795300000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo361: TfrxMemoView
          Left = 223.748031500000000000
          Top = 87.472479999999910000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '................................................................' +
              '...................................')
          WordWrap = False
        end
        object Memo362: TfrxMemoView
          Left = 643.740157480000000000
          Top = 87.472479999999910000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo363: TfrxMemoView
          Left = 223.748031500000000000
          Top = 225.299320000000100000
          Width = 509.480314960000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTREGA PELO CD')
          ParentFont = False
          WordWrap = False
        end
        object Memo364: TfrxMemoView
          Left = 223.748031500000000000
          Top = 247.976500000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA A VISTA:..................................................' +
              '................................................................' +
              '.........................')
          WordWrap = False
        end
        object Memo366: TfrxMemoView
          Left = 223.748031500000000000
          Top = 285.874150000000100000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo368: TfrxMemoView
          Left = 223.748031500000000000
          Top = 305.551330000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '................................................................' +
              '...................................')
          WordWrap = False
        end
        object Memo370: TfrxMemoView
          Left = 223.748031500000000000
          Top = 146.488250000000100000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO A VISTA:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo372: TfrxMemoView
          Left = 223.748031500000000000
          Top = 184.385900000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO FATURADO:................................................' +
              '................................................................' +
              '...........................')
          WordWrap = False
        end
        object Memo374: TfrxMemoView
          Left = 223.748031500000000000
          Top = 204.063079999999900000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO CARTAO DE CREDITO:.......................................' +
              '................................................................' +
              '....................................')
          WordWrap = False
        end
        object Memo365: TfrxMemoView
          Left = 643.740157480000000000
          Top = 146.488250000000100000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo367: TfrxMemoView
          Left = 643.740157480000000000
          Top = 184.385900000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo369: TfrxMemoView
          Left = 643.740157480000000000
          Top = 204.063079999999900000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo371: TfrxMemoView
          Left = 643.740157480000000000
          Top = 247.976500000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo373: TfrxMemoView
          Left = 643.740157480000000000
          Top = 285.874150000000100000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo375: TfrxMemoView
          Left = 643.740157480000000000
          Top = 305.551330000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo406: TfrxMemoView
          Left = 222.992270000000000000
          Top = 106.929190000000100000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'TOTAL DE VENDA:.................................................' +
              '...................')
          ParentFont = False
          WordWrap = False
        end
        object memTotVendas: TfrxMemoView
          Left = 643.740157480000000000
          Top = 106.929190000000100000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memTotVendasOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo415: TfrxMemoView
          Left = 737.008350000000000000
          Top = 28.897650000000120000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo416: TfrxMemoView
          Left = 737.008350000000000000
          Top = 67.795300000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FATFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo417: TfrxMemoView
          Left = 737.008350000000000000
          Top = 87.472479999999910000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CARFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object memTotVendasFreA: TfrxMemoView
          Left = 737.008350000000000000
          Top = 106.929190000000100000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo418: TfrxMemoView
          Left = 737.008350000000000000
          Top = 6.559060000000045000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE')
          ParentFont = False
          WordWrap = False
        end
        object Memo420: TfrxMemoView
          Left = 223.992270000000000000
          Top = 48.133890000000060000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA A VISTA (015-[FORMAPAGAMENTO015]):........................' +
              '................................................................' +
              '.....................')
          WordWrap = False
        end
        object Memo421: TfrxMemoView
          Left = 643.984395980000000000
          Top = 48.133890000000060000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo435: TfrxMemoView
          Left = 737.252588500000000000
          Top = 48.133890000000060000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo436: TfrxMemoView
          Left = 223.992270000000000000
          Top = 165.401670000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO A VISTA (015-[FORMAPAGAMENTO015]):.......................' +
              '................................................................' +
              '.')
          WordWrap = False
        end
        object Memo437: TfrxMemoView
          Left = 643.984395980000000000
          Top = 165.401670000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo438: TfrxMemoView
          Left = 223.992270000000000000
          Top = 267.228509999999900000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA A VISTA (015-[FORMAPAGAMENTO015]):........................' +
              '............................................................')
          WordWrap = False
        end
        object Memo439: TfrxMemoView
          Left = 643.984395980000000000
          Top = 267.228509999999900000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo533: TfrxMemoView
          Left = 222.992270000000000000
          Top = 126.504020000000100000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'DESP.ACESS'#211'RIA:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo534: TfrxMemoView
          Left = 642.984395980000000000
          Top = 126.504020000000100000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_DESACE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object gphTipRec: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.102350000000000000
        Top = 294.803340000000000000
        Width = 944.882500000000000000
        Condition = 'frxRelatorio_RelRcx."TIPREC"'
        ReprintOnNewPage = True
        object Memo220: TfrxMemoView
          Left = 7.937007874015750000
          Width = 150.954360000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TIPO DE RECEBIMENTO:')
          ParentFont = False
          WordWrap = False
        end
        object Memo229: TfrxMemoView
          Left = 164.374830000000000000
          Width = 760.440940000000000000
          Height = 13.220470000000000000
          DataField = 'TIPREC'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TIPREC"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object gpfTipRec: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 600.945270000000000000
        Width = 944.882500000000000000
        object Memo231: TfrxMemoView
          Left = 119.244087170000000000
          Width = 269.480314960000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [frxRelatorio_RelRcx."TIPREC"]:')
          ParentFont = False
          WordWrap = False
        end
        object Memo245: TfrxMemoView
          Left = 389.669291340000000000
          Width = 60.472440940000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."DINHEI">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo267: TfrxMemoView
          Left = 452.031496060000000000
          Width = 60.472421420000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CARREC">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo268: TfrxMemoView
          Left = 514.771653540000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQAVI">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo399: TfrxMemoView
          Left = 577.889763780000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQPRE">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo400: TfrxMemoView
          Left = 637.606299210000000000
          Width = 58.582677170000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."ORDREC">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo401: TfrxMemoView
          Left = 753.748031500000000000
          Width = 62.362194960000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALCRE">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo402: TfrxMemoView
          Left = 816.110236220000000000
          Width = 60.472421420000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo403: TfrxMemoView
          Left = 876.204724410000000000
          Width = 68.031496060000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'Memo403OnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Line17: TfrxLineView
          Align = baWidth
          Top = 21.322819999999980000
          Width = 944.882500000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo527: TfrxMemoView
          Left = 697.322834650000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."PIXREC">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object gphMovDia: TfrxGroupHeader
        FillType = ftBrush
        Height = 13.228346460000000000
        Top = 257.008040000000000000
        Width = 944.882500000000000000
        Condition = 'frxRelatorio_RelRcx."MOVDIA"'
        object Memo404: TfrxMemoView
          Left = 7.937007874015750000
          Width = 438.425480000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOVDIA"]')
          ParentFont = False
        end
      end
      object ChildEstorno: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 408.189240000000000000
        Width = 944.882500000000000000
        OnBeforePrint = 'ChildEstornoOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.ChildTroFpg
        object rllbEstorno: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'True'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object Memo405: TfrxMemoView
          Left = 275.905690000000000000
          Width = 665.197184800000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOTEST"]')
          ParentFont = False
        end
      end
      object rlbFechamentosA: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1855.749230000000000000
        Visible = False
        Width = 944.882500000000000000
        Child = frxRelRcxResumoCaixaJ.rlbLacresMalotesA
        Stretched = True
        object subFechamentos: TfrxSubreport
          Left = 1.779530000000000000
          Top = 3.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page7
        end
      end
      object rlbLacresMalotesA: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1901.103590000000000000
        Visible = False
        Width = 944.882500000000000000
        object subLacresMalotes: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.qckLacresMalotes
        end
      end
    end
    object qckPaginaS: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 134.118120000000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object rllNmEmPs: TfrxMemoView
          Align = baCenter
          Left = 311.849352000000000000
          Top = 9.440940000000001000
          Width = 577.435930000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object rllNomeRelatorioS: TfrxMemoView
          Align = baCenter
          Left = 311.849352000000000000
          Top = 45.338589999999990000
          Width = 577.435930000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 1062.878540000000000000
          Top = 28.338590000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
        end
        object Memo72: TfrxMemoView
          Left = 1122.217130000000000000
          Top = 49.118120000000010000
          Width = 65.461410000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo74: TfrxMemoView
          Left = 991.596660000000000000
          Top = 49.118120000000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object rllOrdemS: TfrxMemoView
          Align = baCenter
          Left = 330.898332000000000000
          Top = 113.338590000000000000
          Width = 539.337970000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object rllSqFcRxS: TfrxMemoView
          Left = 9.600000000000000000
          Top = 79.338590000000000000
          Width = 792.566480000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
        end
        object rllOperadorS: TfrxMemoView
          Left = 11.338590000000000000
          Top = 62.338590000000000000
          Width = 1578.708720000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object rllEspecieS: TfrxMemoView
          Left = 9.600000000000000000
          Top = 96.338590000000000000
          Width = 790.374830000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ESPECIE]')
        end
        object rllNmFnPs: TfrxMemoView
          Align = baCenter
          Left = 311.849352000000000000
          Top = 26.456710000000000000
          Width = 577.435930000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1647.875080000000000000
        Width = 1201.134634000000000000
        object Memo82: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 747.061410000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo83: TfrxMemoView
          Left = 754.922820000000000000
          Top = 17.000000000000000000
          Width = 432.755720000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetSint)]')
        end
      end
      object chilOperacoesS: TfrxChild
        FillType = ftBrush
        Height = 262.677219060000000000
        Top = 461.102660000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.childCabInformS
        object Memo92: TfrxMemoView
          Left = 279.685220000000000000
          Top = 16.677179999999960000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPERA'#199#213'ES')
          ParentFont = False
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 589.606680000000000000
          Top = 16.677179999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
          WordWrap = False
        end
        object Memo94: TfrxMemoView
          Left = 687.874460000000000000
          Top = 16.677179999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SA'#205'DAS')
          ParentFont = False
          WordWrap = False
        end
        object Memo95: TfrxMemoView
          Left = 786.142240000000000000
          Top = 16.677179999999960000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          WordWrap = False
        end
        object Memo100: TfrxMemoView
          Left = 279.685220000000000000
          Top = 46.913419999999920000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DINHEIRO:')
          WordWrap = False
        end
        object Memo101: TfrxMemoView
          Left = 589.606680000000000000
          Top = 46.913419999999920000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'DINENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINENT"]')
          WordWrap = False
        end
        object Memo102: TfrxMemoView
          Left = 687.874460000000000000
          Top = 46.913419999999920000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'DINSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINSAI"]')
          WordWrap = False
        end
        object Memo103: TfrxMemoView
          Left = 786.142240000000000000
          Top = 46.913419999999920000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<DININI>+<frxResumo."DINENT">+<frxResumo."DINSAI">]')
          WordWrap = False
        end
        object Memo104: TfrxMemoView
          Left = 279.685220000000000000
          Top = 65.811069999999970000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Memo.UTF8W = (
            'CHEQUE '#192' VISTA:')
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 589.606680000000000000
          Top = 65.811069999999970000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQENT_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_AVI"]')
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 687.874460000000000000
          Top = 65.811069999999970000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQSAI_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_AVI"]')
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 786.142240000000000000
          Top = 65.811069999999970000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHAINI>+<frxResumo."CHQENT_AVI">+<frxResumo."CHQSAI_AVI">]')
          WordWrap = False
        end
        object Memo108: TfrxMemoView
          Left = 279.685220000000000000
          Top = 84.708719999999860000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Memo.UTF8W = (
            'CHEQUE PR'#201':')
          WordWrap = False
        end
        object Memo109: TfrxMemoView
          Left = 589.606680000000000000
          Top = 84.708719999999860000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_PRE"]')
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 687.874460000000000000
          Top = 84.708719999999860000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CHQSAI_PRE'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_PRE"]')
          WordWrap = False
        end
        object Memo111: TfrxMemoView
          Left = 786.142240000000000000
          Top = 84.708719999999860000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHPINI>+<frxResumo."CHQENT_PRE">+<frxResumo."CHQSAI_PRE">]')
          WordWrap = False
        end
        object Memo112: TfrxMemoView
          Left = 279.685220000000000000
          Top = 103.606370000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ORDEM DE PAGAMENTO:')
          WordWrap = False
        end
        object Memo113: TfrxMemoView
          Left = 589.606680000000000000
          Top = 103.606370000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDENT"]')
          WordWrap = False
        end
        object Memo114: TfrxMemoView
          Left = 687.874460000000000000
          Top = 103.606370000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'ORDSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDSAI"]')
          WordWrap = False
        end
        object Memo115: TfrxMemoView
          Left = 786.142240000000000000
          Top = 103.606370000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<ORDINI>+<frxResumo."ORDENT">+<frxResumo."ORDSAI">]')
          WordWrap = False
        end
        object Memo116: TfrxMemoView
          Left = 279.685220000000000000
          Top = 122.504019999999800000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Memo.UTF8W = (
            'CART'#195'O DE CR'#201'DITO:')
          WordWrap = False
        end
        object Memo117: TfrxMemoView
          Left = 589.606680000000000000
          Top = 122.504019999999800000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CARENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARENT"]')
          WordWrap = False
        end
        object Memo118: TfrxMemoView
          Left = 687.874460000000000000
          Top = 122.504019999999800000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'CARSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARSAI"]')
          WordWrap = False
        end
        object Memo119: TfrxMemoView
          Left = 786.142240000000000000
          Top = 122.504019999999800000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CARINI>+<frxResumo."CARENT">+<frxResumo."CARSAI">]')
          WordWrap = False
        end
        object Memo120: TfrxMemoView
          Left = 279.685220000000000000
          Top = 178.299320000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OUTROS:')
          WordWrap = False
        end
        object Memo121: TfrxMemoView
          Left = 589.606680000000000000
          Top = 178.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataField = 'OUTENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTENT"]')
          WordWrap = False
        end
        object Memo122: TfrxMemoView
          Left = 687.874460000000000000
          Top = 178.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTSAI"]')
          WordWrap = False
        end
        object Memo123: TfrxMemoView
          Left = 786.142240000000000000
          Top = 178.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."OUTENT">+<frxResumo."OUTSAI">]')
          WordWrap = False
        end
        object Memo124: TfrxMemoView
          Left = 279.685220000000000000
          Top = 204.535560000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo125: TfrxMemoView
          Left = 589.606680000000000000
          Top = 204.535560000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."OUTENT">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo126: TfrxMemoView
          Left = 687.874460000000000000
          Top = 204.535560000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI"> +'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."PIXSAI">+'
            '<frxResumo."OUTSAI">]')
          ParentFont = False
          WordWrap = False
        end
        object rllSalTotalS: TfrxMemoView
          Left = 786.142240000000000000
          Top = 204.535560000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
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
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."OUTENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."OUTSAI">+'
            '<frxResumo."PIXSAI">+'
            '<SALINI>]')
          ParentFont = False
          WordWrap = False
        end
        object Line11: TfrxLineView
          Left = 275.905690000000000000
          Top = 39.354359999999990000
          Width = 600.945270000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line12: TfrxLineView
          Left = 279.685220000000000000
          Top = 199.976500000000000000
          Width = 600.945270000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo165: TfrxMemoView
          Left = 480.000310000000000000
          Top = 16.677179999999960000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo98: TfrxMemoView
          Left = 480.000310000000000000
          Top = 178.299320000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          WordWrap = False
        end
        object Memo96: TfrxMemoView
          Left = 480.000310000000000000
          Top = 122.504019999999800000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CARINI]')
          WordWrap = False
        end
        object Memo97: TfrxMemoView
          Left = 480.000310000000000000
          Top = 103.606370000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDINI]')
          WordWrap = False
        end
        object Memo99: TfrxMemoView
          Left = 480.000310000000000000
          Top = 84.708719999999860000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHPINI]')
          WordWrap = False
        end
        object Memo166: TfrxMemoView
          Left = 480.000310000000000000
          Top = 69.590600000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHAINI]')
          WordWrap = False
        end
        object Memo167: TfrxMemoView
          Left = 480.000310000000000000
          Top = 46.913419999999920000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[DININI]')
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 480.000310000000000000
          Top = 204.535560000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[SALINI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo70: TfrxMemoView
          Left = 279.685220000000000000
          Top = 160.299320000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FINANCIAMENTO:')
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 589.606680000000000000
          Top = 160.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINENT"]')
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 687.874460000000000000
          Top = 160.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINSAI"]')
          WordWrap = False
        end
        object Memo77: TfrxMemoView
          Left = 786.142240000000000000
          Top = 160.299320000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<FININI>+<frxResumo."FINENT">+<frxResumo."FINSAI">]')
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 480.000310000000000000
          Top = 160.299320000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[FININI]')
          WordWrap = False
        end
        object Line14: TfrxLineView
          Left = 279.685220000000000000
          Top = 229.330860000000000000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line15: TfrxLineView
          Left = 279.685220000000000000
          Top = 11.338590000000010000
          Width = 597.165740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo516: TfrxMemoView
          Left = 279.685220000000000000
          Top = 141.842610000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PIX:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo517: TfrxMemoView
          Left = 589.606680000000000000
          Top = 141.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."PIXENT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo518: TfrxMemoView
          Left = 687.874460000000000000
          Top = 141.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[frxResumo."PIXSAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo519: TfrxMemoView
          Left = 786.142240000000000000
          Top = 141.842610000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[<PIXINI>+<frxResumo."PIXENT">+<frxResumo."PIXSAI">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo520: TfrxMemoView
          Left = 480.000310000000000000
          Top = 141.842610000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
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
            '[PIXINI]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 215.433210000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Left = 7.937007874015750000
          Top = 15.118120000000010000
          Width = 1184.881884880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo151: TfrxMemoView
          Left = 28.799690000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTOS')
        end
        object Memo152: TfrxMemoView
          Left = 903.609400000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
        end
        object rllSaliniS: TfrxMemoView
          Left = 7.937007870000000000
          Top = 51.000000000000030000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSaliniSOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SALDO INICIAL: [SALINI]')
        end
        object Memo350: TfrxMemoView
          Left = 219.212740000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO')
        end
        object Memo351: TfrxMemoView
          Left = 315.817440000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O')
        end
        object Memo352: TfrxMemoView
          Left = 412.422140000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA')
        end
        object Memo353: TfrxMemoView
          Left = 509.026840000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.PR'#201)
        end
        object Memo354: TfrxMemoView
          Left = 605.631540000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PAG.')
        end
        object Memo355: TfrxMemoView
          Left = 800.504020000000000000
          Top = 17.000000000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR.CRED.')
        end
        object Memo521: TfrxMemoView
          Left = 702.992580000000000000
          Top = 15.118120000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PIX')
        end
      end
      object rlbDetSint: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.141930000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
        RowCount = 0
        object Memo128: TfrxMemoView
          Left = 7.937007874015750000
          Width = 1180.195920000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
        end
        object Memo154: TfrxMemoView
          Left = 28.618490000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'TOTAL( [frxRelatorio_RelRcx."ESPDOC"] ):')
        end
        object Memo155: TfrxMemoView
          Left = 903.428200000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataField = 'VALDOC'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALDOC"]')
        end
        object Memo344: TfrxMemoView
          Left = 222.992270000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DINHEI"]')
          WordWrap = False
        end
        object Memo345: TfrxMemoView
          Left = 319.596970000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CARREC"]')
          WordWrap = False
        end
        object Memo346: TfrxMemoView
          Left = 416.201670000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQAVI"]')
          WordWrap = False
        end
        object Memo347: TfrxMemoView
          Left = 512.806370000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQPRE"]')
          WordWrap = False
        end
        object Memo348: TfrxMemoView
          Left = 609.411070000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."ORDREC"]')
          WordWrap = False
        end
        object Memo349: TfrxMemoView
          Left = 804.283550000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALCRE"]')
          WordWrap = False
        end
        object Memo522: TfrxMemoView
          Left = 702.992580000000000000
          Width = 98.267721420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."PIXREC"]')
          WordWrap = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 385.512060000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.chilOperacoesS
        object Memo156: TfrxMemoView
          Left = 903.428200000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo156OnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo157: TfrxMemoView
          Left = 687.692950000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
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
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 8.800000000000000000
          Top = 42.500000000000000000
          Width = 1174.299010000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildCanceladosS: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 1054.488870000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.ChildPGS
        PrintChildIfInvisible = True
        Stretched = True
        object rllQdeCanS: TfrxMemoView
          Left = 334.685220000000000000
          Top = 2.598330000000033000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'QUANTIDADE DE DOCS CANCELADOS:..................................' +
              '..')
          WordWrap = False
        end
        object rlbQdeCanS: TfrxMemoView
          Left = 730.704020000000000000
          Top = 2.598330000000033000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[QTDCAN]')
          WordWrap = False
        end
        object rllVlrCanS: TfrxMemoView
          Left = 334.685220000000000000
          Top = 19.598329999999920000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR TOTAL DOS DOCS CANCELADOS:................................')
          WordWrap = False
        end
        object rlbVlrCanS: TfrxMemoView
          Left = 730.704020000000000000
          Top = 19.598329999999920000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCAN]')
          WordWrap = False
        end
        object linhaQdeCanS: TfrxLineView
          Left = 333.953000000000000000
          Top = 1.000000000000000000
          Width = 486.803149610000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ChildPGS: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1114.961350000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'ChildPGSOnBeforePrint'
        Child = frxRelRcxResumoCaixaJ.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object mmoTitPg1S: TfrxMemoView
          Left = 335.378170000000000000
          Top = 3.779530000000022000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitPg1SOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'TOTAL DE PG *:..................................................' +
              '........................')
          WordWrap = False
        end
        object mmoValPg1S: TfrxMemoView
          Left = 731.396970000000000000
          Top = 3.779530000000022000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoValPg1SOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTPAG]')
          WordWrap = False
        end
        object linPGS: TfrxLineView
          Left = 333.598640000000000000
          Top = 2.000000000000000000
          Width = 486.803149610000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object childCabInformS: TfrxChild
        FillType = ftBrush
        Height = 96.377952760000000000
        Top = 748.346940000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.childFpgVenPraS
        PrintChildIfInvisible = True
        object Memo57: TfrxMemoView
          Left = 332.598640010000000000
          Width = 486.803149610000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS INFORMATIVOS')
          ParentFont = False
          WordWrap = False
        end
        object rllFaturadoS: TfrxMemoView
          Left = 332.598640010000000000
          Top = 18.897650000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'FATURADO:.......................................................' +
              '................................................................' +
              '....................')
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 332.598640000000000000
          Top = 37.795275589999960000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'DESCONTO:.......................................................' +
              '................................................................' +
              '.......')
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 332.598640000000000000
          Top = 56.692913389999940000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'JUROS:..........................................................' +
              '................................................................' +
              '.............')
          WordWrap = False
        end
        object rllVenPreEntS: TfrxMemoView
          Left = 728.693128200000000000
          Top = 18.897650000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VENENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VENENT"]')
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 728.693128200000000000
          Top = 37.795275589999960000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALDES"]')
          WordWrap = False
        end
        object Memo85: TfrxMemoView
          Left = 728.693128200000000000
          Top = 56.692913389999940000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALJUR"]')
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 332.598640000000000000
          Top = 75.590600000000000000
          Width = 486.803149610000000000
          Color = clBlack
          Diagonal = True
        end
        object rllVenPraS: TfrxMemoView
          Left = 332.598640000000000000
          Top = 77.480314959999990000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDAS '#192' PRAZO:.................................................' +
              '................................................................' +
              '.......')
          WordWrap = False
        end
        object rlbVenPraS: TfrxMemoView
          Left = 728.693128200000000000
          Top = 77.480314959999990000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPRA]')
          WordWrap = False
        end
      end
      object childFpgVenPraS: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 869.291900000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.childTotVenVisS
        PrintChildIfInvisible = True
        Stretched = True
        object subVenPraS: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page3
        end
      end
      object childTotVenVisS: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 910.866730000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.childFpgVenVisS
        PrintChildIfInvisible = True
        Stretched = True
        object rllVenVisS: TfrxMemoView
          Left = 332.598640000000000000
          Top = 0.948818899999992100
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDAS '#192' VISTA:.................................................' +
              '................................................................' +
              '.....')
          WordWrap = False
        end
        object rlbVenVisS: TfrxMemoView
          Left = 728.693128200000000000
          Top = 0.948818899999992100
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENVIS]')
          WordWrap = False
        end
        object linhaVenVisS: TfrxLineView
          Left = 332.598640000000000000
          Width = 486.803149610000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object childFpgVenVisS: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 952.441560000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.childRodInformS
        PrintChildIfInvisible = True
        Stretched = True
        object subVenVisS: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page4
        end
      end
      object childRodInformS: TfrxChild
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 994.016390000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.ChildCanceladosS
        PrintChildIfInvisible = True
        Stretched = True
        object rllTroDevS: TfrxMemoView
          Left = 332.598640000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'TROCAS E DEVOLU'#199#213'ES:............................................' +
              '................................................................' +
              '......')
          WordWrap = False
        end
        object rlbTroDevS: TfrxMemoView
          Left = 728.693128190000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TRODEV]')
          WordWrap = False
        end
        object rllVenDiaS: TfrxMemoView
          Left = 332.598640000000000000
          Top = 18.897637799999980000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDAS DO PER'#205'ODO:..............................................' +
              '................................................................' +
              '....')
          WordWrap = False
        end
        object rlbVenDiaS: TfrxMemoView
          Left = 728.693128190000000000
          Top = 18.897637799999980000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPER]')
          WordWrap = False
        end
        object linhaTroDevS: TfrxLineView
          Left = 332.598640000000000000
          Width = 486.803149610000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1515.591530000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.rlbFechamentosS
        PrintChildIfInvisible = True
        object subPagamentoS: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page6
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 332.598640000000000000
        Top = 1160.315710000000000000
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.Child2
        Stretched = True
        object Memo377: TfrxMemoView
          Left = 335.244094490000000000
          Top = 24.897650000000110000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA '#192' VISTA:..................................................' +
              '................................................................' +
              '.........................')
          WordWrap = False
        end
        object Memo378: TfrxMemoView
          Left = 732.590778190000000000
          Top = 24.897650000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo379: TfrxMemoView
          Left = 335.244094488189000000
          Top = 62.795300000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo380: TfrxMemoView
          Left = 732.590778190000000000
          Top = 62.795300000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo381: TfrxMemoView
          Left = 335.244094488189000000
          Top = 82.472479999999910000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA CART'#195'O DE CR'#201'DITO:........................................' +
              '................................................................' +
              '...................................')
          WordWrap = False
        end
        object Memo382: TfrxMemoView
          Left = 732.590778190000000000
          Top = 82.472479999999910000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo383: TfrxMemoView
          Left = 335.244094490000000000
          Top = 221.299320000000000000
          Width = 486.803149610000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTREGA PELO CD')
          ParentFont = False
          WordWrap = False
        end
        object Memo384: TfrxMemoView
          Left = 335.244094490000000000
          Top = 243.976500000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA '#192' VISTA:..................................................' +
              '................................................................' +
              '.........................')
          WordWrap = False
        end
        object Memo385: TfrxMemoView
          Left = 335.244094490000000000
          Top = 281.874150000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo386: TfrxMemoView
          Left = 335.244094490000000000
          Top = 301.551330000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA CART'#195'O DE CR'#201'DITO:........................................' +
              '................................................................' +
              '...................................')
          WordWrap = False
        end
        object Memo387: TfrxMemoView
          Left = 335.244094490000000000
          Top = 141.488250000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO '#192' VISTA:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo388: TfrxMemoView
          Left = 335.244094490000000000
          Top = 179.385900000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO FATURADO:................................................' +
              '................................................................' +
              '...........................')
          WordWrap = False
        end
        object Memo389: TfrxMemoView
          Left = 335.244094490000000000
          Top = 199.063080000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO CART'#195'O DE CR'#201'DITO:.......................................' +
              '................................................................' +
              '....................................')
          WordWrap = False
        end
        object Memo390: TfrxMemoView
          Left = 732.590778190000000000
          Top = 141.488250000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo391: TfrxMemoView
          Left = 732.590778190000000000
          Top = 179.385900000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo392: TfrxMemoView
          Left = 732.590778190000000000
          Top = 199.063080000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo393: TfrxMemoView
          Left = 732.590778190000000000
          Top = 243.976500000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo394: TfrxMemoView
          Left = 732.590778190000000000
          Top = 281.874150000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_FAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo395: TfrxMemoView
          Left = 732.590778190000000000
          Top = 301.551330000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_CAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo376: TfrxMemoView
          Left = 335.244094490000000000
          Top = 2.220469999999978000
          Width = 486.803149610000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO LOJA PR'#211'PRIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo407: TfrxMemoView
          Left = 335.244094490000000000
          Top = 101.149660000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'TOTAL DE VENDA:.................................................' +
              '...................')
          ParentFont = False
          WordWrap = False
        end
        object Memo408: TfrxMemoView
          Left = 732.590778190000000000
          Top = 101.149660000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memTotVendasOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo412: TfrxMemoView
          Left = 826.835190000000000000
          Top = 24.897650000000110000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo413: TfrxMemoView
          Left = 826.835190000000000000
          Top = 62.795300000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FATFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo414: TfrxMemoView
          Left = 826.835190000000000000
          Top = 82.472479999999910000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CARFRE"]')
          ParentFont = False
          WordWrap = False
        end
        object memTotVendasFreB: TfrxMemoView
          Left = 826.835190000000000000
          Top = 101.149660000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo419: TfrxMemoView
          Left = 826.835190000000000000
          Top = 2.220469999999978000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE')
          ParentFont = False
          WordWrap = False
        end
        object Memo440: TfrxMemoView
          Left = 334.598640000000000000
          Top = 44.354360000000040000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA '#192' VISTA (015-[FORMAPAGAMENTO015]):........................' +
              '................................................................' +
              '...')
          WordWrap = False
        end
        object Memo441: TfrxMemoView
          Left = 731.945323700000000000
          Top = 44.354360000000040000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo442: TfrxMemoView
          Left = 826.189735510000000000
          Top = 44.354360000000040000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo443: TfrxMemoView
          Left = 335.378170000000000000
          Top = 159.842610000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO '#192' VISTA (015-[FORMAPAGAMENTO015]):.......................' +
              '................................................................' +
              '.........')
          WordWrap = False
        end
        object Memo444: TfrxMemoView
          Left = 732.724853700000000000
          Top = 159.842610000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo445: TfrxMemoView
          Left = 335.378170000000000000
          Top = 263.669450000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA '#192' VISTA (015-[FORMAPAGAMENTO015]):........................' +
              '................................................................' +
              '.....')
          WordWrap = False
        end
        object Memo446: TfrxMemoView
          Left = 732.724853700000000000
          Top = 263.669450000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS015"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo535: TfrxMemoView
          Left = 335.244094488189000000
          Top = 120.944960000000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'DESP.ACESS'#211'RIA:.................................................' +
              '................................................................' +
              '..........................')
          WordWrap = False
        end
        object Memo536: TfrxMemoView
          Left = 732.472440940000000000
          Top = 120.944960000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_DESACE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbFechamentosS: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1557.166360000000000000
        Visible = False
        Width = 1201.134634000000000000
        Child = frxRelRcxResumoCaixaJ.rlbLacresMalotesS
        object Subreport1: TfrxSubreport
          Left = 1.779530000000000000
          Top = 3.779530000000022000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.Page7
        end
      end
      object rlbLacresMalotesS: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1602.520720000000000000
        Visible = False
        Width = 1201.134634000000000000
        object Subreport2: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRcxResumoCaixaJ.qckLacresMalotes
        end
      end
    end
    object qckPaginaC: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Top = 18.897650000000000000
        Width = 944.882500000000000000
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 79.370130000000000000
        Width = 944.882500000000000000
      end
      object MSDCHEQUES: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 41.574830000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object rllZebra1: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'True'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'Memo1OnBeforePrint'
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM.CHQ: [frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 137.952690000000000000
          Width = 340.157504720000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE: [frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 487.785590000000000000
          Width = 162.292950000000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA VENC.: [frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 695.374520000000000000
          Width = 68.031481420000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo212: TfrxMemoView
          Left = 767.244590000000000000
          Width = 120.944901420000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DIAS CHEQUE: [frxCheques."CHQ_DIACHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo88: TfrxMemoView
          Left = 652.079160000000000000
          Width = 41.347990000000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object qckResumoVendas: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader3: TfrxPageHeader
        FillType = ftBrush
        Height = 134.118120000000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object rllNmEmRv: TfrxMemoView
          Align = baCenter
          Left = 349.644652000000000000
          Top = 9.440940000000001000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baCenter
          Left = 268.384757000000000000
          Top = 45.338589999999990000
          Width = 664.365120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 1062.878540000000000000
          Top = 28.338590000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
        end
        object Memo51: TfrxMemoView
          Left = 1110.878540000000000000
          Top = 45.338589999999990000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo56: TfrxMemoView
          Left = 980.258070000000000000
          Top = 45.338589999999990000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo61: TfrxMemoView
          Align = baCenter
          Left = 123.024182000000000000
          Top = 113.338590000000000000
          Width = 955.086270000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object Memo129: TfrxMemoView
          Left = 9.600000000000000000
          Top = 96.338590000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
        end
        object Memo130: TfrxMemoView
          Left = 9.600000000000000000
          Top = 79.338590000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object Memo131: TfrxMemoView
          Left = 438.878540000000000000
          Top = 96.338590000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
        end
        object Memo132: TfrxMemoView
          Left = 438.878540000000000000
          Top = 79.338590000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
        end
        object rllNmFnRv: TfrxMemoView
          Align = baCenter
          Left = 349.644652000000000000
          Top = 26.456710000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 457.323130000000000000
        Width = 1201.134634000000000000
        object Memo133: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 372.887940000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo134: TfrxMemoView
          Left = 380.749350000000000000
          Top = 17.000000000000000000
          Width = 806.929190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData1)]')
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 39.677180000000000000
        Top = 215.433210000000000000
        Width = 1201.134634000000000000
        object Memo135: TfrxMemoView
          Left = 694.299212600000000000
          Top = 21.921259840000000000
          Width = 60.094456460000000000
          Height = 17.007874020000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'REP (%)')
          ParentFont = False
          WordWrap = False
        end
        object Memo136: TfrxMemoView
          Left = 521.338582680000000000
          Top = 21.921259840000000000
          Width = 60.094456460000000000
          Height = 17.007874020000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'REP (%)')
          ParentFont = False
          WordWrap = False
        end
        object Memo137: TfrxMemoView
          Left = 223.748031500000000000
          Top = 22.015770000000000000
          Width = 71.281880000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'ESP'#201'CIE')
          ParentFont = False
          WordWrap = False
        end
        object Memo144: TfrxMemoView
          Left = 295.378170000000000000
          Top = 22.015770000000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.DOCS')
          ParentFont = False
          WordWrap = False
        end
        object Memo145: TfrxMemoView
          Left = 408.385814570000000000
          Top = 21.921259840000000000
          Width = 113.007876460000000000
          Height = 17.007874020000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VENDAS DO DIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo146: TfrxMemoView
          Left = 581.291338580000000000
          Top = 22.015770000000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'ACUMULADO')
          ParentFont = False
          WordWrap = False
        end
        object Memo147: TfrxMemoView
          Left = 754.039384720000000000
          Top = 22.015770000000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'M'#201'DIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo148: TfrxMemoView
          Left = 866.984266610000000000
          Top = 22.015770000000000000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TICKET M'#201'DIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo138: TfrxMemoView
          Left = 223.748031496063000000
          Top = 5.007874020000003000
          Width = 754.015748031496100000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE VENDAS')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 321.260050000000000000
        Width = 1201.134634000000000000
        object Memo178: TfrxMemoView
          Left = 759.685530000000000000
          Top = 50.133890000000010000
          Width = 41.196806460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          ParentFont = False
          WordWrap = False
        end
        object Memo177: TfrxMemoView
          Left = 759.685530000000000000
          Top = 34.015769999999970000
          Width = 41.196806460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          ParentFont = False
          WordWrap = False
        end
        object Memo149: TfrxMemoView
          Left = 223.748031496063000000
          Top = 16.118119999999980000
          Width = 754.015748031496100000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'QUANTIDADE DE DIAS UTEIS: [(<fltQtdDia>)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo143: TfrxMemoView
          Left = 223.748031500000000000
          Width = 71.281880000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
          WordWrap = False
        end
        object Memo150: TfrxMemoView
          Left = 408.385814570000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENDIA">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo153: TfrxMemoView
          Left = 581.291338580000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo158: TfrxMemoView
          Left = 753.976392600000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">/<fltQtdDia>,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo159: TfrxMemoView
          Left = 867.023622050000000000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">/<fltQtdDoc>,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo160: TfrxMemoView
          Left = 295.378170000000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."QTDDOC">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo139: TfrxMemoView
          Left = 521.338582680000000000
          Width = 60.094456460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          ParentFont = False
          WordWrap = False
        end
        object Memo140: TfrxMemoView
          Left = 694.299212600000000000
          Width = 60.094456460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          ParentFont = False
          WordWrap = False
        end
        object Memo141: TfrxMemoView
          Left = 223.748031500000000000
          Top = 34.015769999999970000
          Width = 357.165098030000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDAS DO DIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo142: TfrxMemoView
          Left = 223.748031500000000000
          Top = 50.133890000000010000
          Width = 357.165098030000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDAS ACUMULADO')
          ParentFont = False
          WordWrap = False
        end
        object Memo169: TfrxMemoView
          Left = 582.047620000000000000
          Top = 34.015769999999970000
          Width = 67.653516460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
          WordWrap = False
        end
        object Memo171: TfrxMemoView
          Left = 866.779903470000000000
          Top = 34.015769999999970000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltPrzDia]')
          ParentFont = False
          WordWrap = False
        end
        object Memo172: TfrxMemoView
          Left = 649.701134020000000000
          Top = 34.015769999999970000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAviDia]')
          ParentFont = False
          WordWrap = False
        end
        object Memo173: TfrxMemoView
          Left = 582.047620000000000000
          Top = 50.133890000000010000
          Width = 67.653516460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
          WordWrap = False
        end
        object Memo175: TfrxMemoView
          Left = 866.779903470000000000
          Top = 50.133890000000010000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltPrzAcu]')
          ParentFont = False
          WordWrap = False
        end
        object Memo176: TfrxMemoView
          Left = 649.701134020000000000
          Top = 50.133890000000010000
          Width = 110.740157480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAviAcu]')
          ParentFont = False
          WordWrap = False
        end
        object Memo174: TfrxMemoView
          Left = 799.307504020000000000
          Top = 50.133890000000010000
          Width = 67.653516460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'A PRAZO')
          ParentFont = False
          WordWrap = False
        end
        object Memo170: TfrxMemoView
          Left = 799.307504020000000000
          Top = 34.015769999999970000
          Width = 67.653516460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'A PRAZO')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 279.685220000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxResumoVendas
        DataSetName = 'frxResumoVendas'
        RowCount = 0
        object Memo179: TfrxMemoView
          Left = 223.748031500000000000
          Width = 71.281880000000000000
          Height = 17.000000000000000000
          DataField = 'ESPDOC'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoVendas."ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo180: TfrxMemoView
          Left = 295.378170000000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataField = 'QTDDOC'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."QTDDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo181: TfrxMemoView
          Left = 408.385814570000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataField = 'VENDIA'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENDIA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo182: TfrxMemoView
          Left = 581.291338580000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataField = 'VENACU'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENACU"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo183: TfrxMemoView
          Left = 754.039384720000000000
          Width = 113.007876460000000000
          Height = 17.000000000000000000
          DataField = 'VENMED'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENMED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo184: TfrxMemoView
          Left = 867.023622047244000000
          Width = 110.740157480315000000
          Height = 17.000000000000000000
          DataField = 'TICMED'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."TICMED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo185: TfrxMemoView
          Left = 521.338582680000000000
          Width = 60.094456460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00%'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<fltTotDia> <> 0, (<frxResumoVendas."VENDIA">/<fltTotDia>*1' +
              '00), 0)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo186: TfrxMemoView
          Left = 694.299212600000000000
          Width = 60.094456460000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00%'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxResumoVendas."VENACU">/<fltTotAcu>*100)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object qckPaginaB: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object DETDUP: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.110390000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frmRelRcxResumoCaixa.frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object Memo127: TfrxMemoView
          Left = 3.779530000000000000
          Width = 1188.284170000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
        end
        object Memo5: TfrxMemoView
          Left = 6.600000000000000000
          Width = 137.574830000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."NUMDUP"]')
        end
        object Memo27: TfrxMemoView
          Left = 148.979530000000000000
          Width = 36.661410000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."CODEMP"]')
        end
        object Memo29: TfrxMemoView
          Left = 225.722820000000000000
          Width = 475.993630000000000000
          Height = 17.000000000000000000
          DataField = 'CODCLI'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxDuplicatas."CODCLI"]')
        end
        object Memo35: TfrxMemoView
          Left = 712.214100000000000000
          Width = 348.623500000000000000
          Height = 17.000000000000000000
          DataField = 'HISTOR'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          LineSpacing = 10.000000000000000000
          Memo.UTF8W = (
            '[frxDuplicatas."HISTOR"]')
        end
        object Memo40: TfrxMemoView
          Left = 1066.658070000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataField = 'VALDUP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDuplicatas."VALDUP"]')
        end
        object Memo50: TfrxMemoView
          Left = 190.800000000000000000
          Width = 32.881880000000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."CODVEN"]')
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 162.519790000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Left = 3.779530000000000000
          Top = 15.118120000000010000
          Width = 1188.661414880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo42: TfrxMemoView
          Left = 6.600000000000000000
          Top = 17.000000000000000000
          Width = 137.574830000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'NUMDUP')
        end
        object Memo43: TfrxMemoView
          Left = 712.214100000000000000
          Top = 17.000000000000000000
          Width = 348.623500000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HIST'#211'RICO')
        end
        object Memo48: TfrxMemoView
          Left = 1066.658070000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALDUP')
        end
        object Memo44: TfrxMemoView
          Left = 148.979530000000000000
          Top = 17.000000000000000000
          Width = 36.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
        end
        object Memo46: TfrxMemoView
          Left = 190.800000000000000000
          Top = 17.000000000000000000
          Width = 32.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VEN')
        end
        object Memo47: TfrxMemoView
          Left = 225.722820000000000000
          Top = 17.000000000000000000
          Width = 475.993630000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
        end
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 83.118120000000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object Memo59: TfrxMemoView
          Left = 9.600000000000000000
          Top = 43.464566929133900000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATAS EMITIDAS NAO BAIXADAS')
        end
        object Memo62: TfrxMemoView
          Left = 1066.658070000000000000
          Top = 43.456710000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Memo30: TfrxMemoView
          Left = 1114.658070000000000000
          Top = 60.456710000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo33: TfrxMemoView
          Left = 984.037600000000000000
          Top = 60.456710000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo36: TfrxMemoView
          Left = 9.448818900000000000
          Top = 9.440940000000001000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllOrdemB: TfrxMemoView
          Left = 9.600000000000000000
          Top = 60.472440944881890000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object Memo221: TfrxMemoView
          Left = 9.448818900000000000
          Top = 26.456692910000000000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMFAN'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMFAN"]')
          ParentFont = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.173470000000000000
        Width = 1201.134634000000000000
        object Memo78: TfrxMemoView
          Left = 5.820470000000000000
          Top = 17.000000000000000000
          Width = 762.179530000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo79: TfrxMemoView
          Left = 460.119480000000000000
          Top = 17.000000000000000000
          Width = 731.338590000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(DETDUP)]')
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 317.480520000000000000
        Width = 1201.134634000000000000
        object Memo203: TfrxMemoView
          Left = 792.037600000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo205: TfrxMemoView
          Left = 1066.658070000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
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
            '[SUM(<frxDuplicatas."VALDUP">)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object qckCredito: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader4: TfrxPageHeader
        FillType = ftBrush
        Height = 90.677180000000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object Memo187: TfrxMemoView
          Left = 9.600000000000000000
          Top = 48.338589999999990000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'RELA'#199#195'O DE CR'#201'DITOS UTILIZADOS NO PER'#205'ODO')
        end
        object Memo188: TfrxMemoView
          Left = 1066.658070000000000000
          Top = 47.236239999999990000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Memo189: TfrxMemoView
          Left = 1114.658070000000000000
          Top = 67.275610080000010000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo190: TfrxMemoView
          Left = 984.037600000000000000
          Top = 67.275610080000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo191: TfrxMemoView
          Left = 9.600000000000000000
          Top = 9.440940000000001000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.338590000000000000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object Memo222: TfrxMemoView
          Left = 9.448818900000000000
          Top = 28.456710000000000000
          Width = 864.680210000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMFAN'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMFAN"]')
          ParentFont = False
        end
      end
      object Header5: TfrxHeader
        FillType = ftBrush
        Height = 24.543290000000000000
        Top = 170.078850000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 24.543290000000000000
          Fill.BackColor = clSilver
        end
        object Memo193: TfrxMemoView
          Left = 7.600000000000000000
          Top = 4.661409999999989000
          Width = 137.952775430000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUMDUP')
        end
        object Memo194: TfrxMemoView
          Left = 717.214100000000000000
          Top = 4.661409999999989000
          Width = 333.505380000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HIST'#211'RICO')
        end
        object Memo195: TfrxMemoView
          Left = 1051.658070000000000000
          Top = 4.661409999999989000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALDUP')
        end
        object Memo196: TfrxMemoView
          Left = 151.097650000000000000
          Top = 4.661409999999989000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
        end
        object Memo197: TfrxMemoView
          Left = 201.138590000000000000
          Top = 4.661409999999989000
          Width = 66.897650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
        end
        object Memo198: TfrxMemoView
          Left = 273.856710000000000000
          Top = 4.661409999999989000
          Width = 438.198330000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
        end
      end
      object rlbCredito: TfrxMasterData
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 219.212740000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxCredito
        DataSetName = 'frxCredito'
        RowCount = 0
        object Memo199: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 20.779530000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
        end
        object Memo200: TfrxMemoView
          Left = 7.600000000000000000
          Top = 1.000000000000000000
          Width = 137.952775430000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCredito."NUMDUP"]')
        end
        object Memo201: TfrxMemoView
          Left = 151.097650000000000000
          Top = 1.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCredito."CODEMP"]')
        end
        object Memo202: TfrxMemoView
          Left = 273.856710000000000000
          Top = 1.000000000000000000
          Width = 438.198330000000000000
          Height = 17.000000000000000000
          DataField = 'NOMCLI'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxCredito."NOMCLI"]')
        end
        object Memo204: TfrxMemoView
          Left = 717.214100000000000000
          Top = 1.000000000000000000
          Width = 333.505380000000000000
          Height = 17.000000000000000000
          DataField = 'DESCRI'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          LineSpacing = 10.000000000000000000
          Memo.UTF8W = (
            '[frxCredito."DESCRI"]')
        end
        object Memo206: TfrxMemoView
          Left = 1051.658070000000000000
          Top = 1.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDUP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCredito."VALDUP"]')
        end
        object Memo207: TfrxMemoView
          Left = 201.138590000000000000
          Top = 1.000000000000000000
          Width = 66.897650000000000000
          Height = 17.000000000000000000
          DataField = 'DTAENT'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCredito."DTAENT"]')
        end
      end
      object ReportSummary3: TfrxReportSummary
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 302.362400000000000000
        Width = 1201.134634000000000000
        object Memo208: TfrxMemoView
          Left = 792.037600000000000000
          Top = 4.440940000000012000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo209: TfrxMemoView
          Left = 1066.658070000000000000
          Top = 4.440940000000012000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
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
            '[SUM(<frxCredito."VALDUP">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 351.496290000000000000
        Width = 1201.134634000000000000
        object Memo210: TfrxMemoView
          Left = 9.600000000000000000
          Top = 14.000000000000000000
          Width = 637.455040000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo211: TfrxMemoView
          Left = 656.655040000000000000
          Top = 14.000000000000000000
          Width = 534.803030000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbCredito)]')
        end
        object Line13: TfrxLineView
          Left = 3.779530000000000000
          Top = 7.559059999999988000
          Width = 1194.331480000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbVenPra: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
        RowCount = 0
        object Memo238: TfrxMemoView
          Left = 223.748031496063000000
          Top = 0.948818899999999000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '     [frxVenPra."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo239: TfrxMemoView
          Left = 638.740157480000000000
          Top = 0.948818899999999000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenPra."VALFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbVenVis: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
        RowCount = 0
        object Memo240: TfrxMemoView
          Left = 223.748031500000000000
          Top = 0.948818899999999000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '     [frxVenVis."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo241: TfrxMemoView
          Left = 638.740157480000000000
          Top = 0.948818899999999000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenVis."VALFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page3: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
        RowCount = 0
        object Memo38: TfrxMemoView
          Left = 332.598425200000000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '     [frxVenPra."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 728.692913385826900000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenPra."VALFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page4: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
        RowCount = 0
        object Memo54: TfrxMemoView
          Left = 332.598425196850000000
          Width = 371.300680000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '     [frxVenVis."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 728.692913385826900000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenVis."VALFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object qckResumoEspecie: TfrxReportPage
      PaperWidth = 414.000000000000000000
      PaperHeight = 222.400000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader5: TfrxPageHeader
        FillType = ftBrush
        Height = 145.456710000000000000
        Top = 18.897650000000000000
        Width = 1489.134820000000000000
        object rllNmEmRe: TfrxMemoView
          Align = baCenter
          Left = 493.644745000000000000
          Top = 9.440940000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Align = baCenter
          Left = 412.384850000000000000
          Top = 45.338590000000000000
          Width = 664.365120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 1311.878540000000000000
          Top = 28.338590000000000000
          Width = 173.933890000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Memo91: TfrxMemoView
          Left = 1409.012430000000000000
          Top = 45.338590000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo84: TfrxMemoView
          Left = 1312.407730000000000000
          Top = 45.338590000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object rllOrdemResEsp: TfrxMemoView
          Align = baCenter
          Left = 267.024275000000000000
          Top = 113.338590000000000000
          Width = 955.086270000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object rllOperadorResEsp: TfrxMemoView
          Left = 4.600000000000000000
          Top = 79.338590000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object Memo228: TfrxMemoView
          Left = 737.878540000000000000
          Top = 79.338590000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
        end
        object rllNmFnRe: TfrxMemoView
          Align = baCenter
          Left = 493.644745000000000000
          Top = 26.456710000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 272.126160000000000000
        Width = 1489.134820000000000000
        Child = frxRelRcxResumoCaixaJ.Child5
        DataSet = frmRelRcxResumoCaixa.frxResumoEspecies
        DataSetName = 'frxResumoEspecies'
        PrintChildIfInvisible = True
        RowCount = 0
        object rllNomPortador: TfrxMemoView
          Left = 9.600000000000000000
          Width = 52.232900000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxResumoEspecies."RCX_ESPDOC"]')
        end
        object rllVis001: TfrxMemoView
          Left = 330.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS001"]')
        end
        object rllTotVis: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTVIS"]')
        end
        object Memo86: TfrxMemoView
          Left = 79.370130000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A Vista')
        end
        object Memo87: TfrxMemoView
          Left = 79.370130000000000000
          Top = 18.897650000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Juros')
        end
        object Memo230: TfrxMemoView
          Left = 79.370130000000000000
          Top = 37.795300000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descontos')
        end
        object rllVis002: TfrxMemoView
          Left = 431.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS002"]')
        end
        object rllVis003: TfrxMemoView
          Left = 535.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS003"]')
        end
        object rllVis004: TfrxMemoView
          Left = 637.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS004"]')
        end
        object rllVis005: TfrxMemoView
          Left = 742.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS005"]')
        end
        object rllVis006: TfrxMemoView
          Left = 846.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS006"]')
        end
        object rllVis007: TfrxMemoView
          Left = 949.417322830000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS007"]')
        end
        object rllVis008: TfrxMemoView
          Left = 1055.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS008"]')
        end
        object rllVis009: TfrxMemoView
          Left = 1158.803149610000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS009"]')
        end
        object rllVis010: TfrxMemoView
          Left = 1262.362204720000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS010"]')
        end
        object rllJvs001: TfrxMemoView
          Left = 330.000000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS001"]')
        end
        object rllTotJvs: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 18.897650000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTJVS"]')
        end
        object rllJvs002: TfrxMemoView
          Left = 431.600000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS002"]')
        end
        object rllJvs003: TfrxMemoView
          Left = 535.200000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS003"]')
        end
        object rllJvs004: TfrxMemoView
          Left = 637.800000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS004"]')
        end
        object rllJvs005: TfrxMemoView
          Left = 742.400000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS005"]')
        end
        object rllJvs006: TfrxMemoView
          Left = 846.000000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS006"]')
        end
        object rllJvs007: TfrxMemoView
          Left = 949.417322830000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS007"]')
        end
        object rllJvs008: TfrxMemoView
          Left = 1055.200000000000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS008"]')
        end
        object rllJvs009: TfrxMemoView
          Left = 1158.803149610000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS009"]')
        end
        object rllJvs010: TfrxMemoView
          Left = 1262.362204720000000000
          Top = 18.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS010"]')
        end
        object rllDvs001: TfrxMemoView
          Left = 330.000000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS001"]')
        end
        object rllTotDvs: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 37.795300000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTDVS"]')
        end
        object rllDvs002: TfrxMemoView
          Left = 431.600000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS002"]')
        end
        object rllDvs003: TfrxMemoView
          Left = 535.200000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS003"]')
        end
        object rllDvs004: TfrxMemoView
          Left = 637.800000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS004"]')
        end
        object rllDvs005: TfrxMemoView
          Left = 742.400000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS005"]')
        end
        object rllDvs006: TfrxMemoView
          Left = 846.000000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS006"]')
        end
        object rllDvs007: TfrxMemoView
          Left = 949.417322830000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS007"]')
        end
        object rllDvs008: TfrxMemoView
          Left = 1055.200000000000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS008"]')
        end
        object rllDvs009: TfrxMemoView
          Left = 1158.803149610000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS009"]')
        end
        object rllDvs010: TfrxMemoView
          Left = 1262.362204720000000000
          Top = 37.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS010"]')
        end
      end
      object Header6: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 226.771800000000000000
        Width = 1489.134820000000000000
        ReprintOnNewPage = True
        object rllFundoHeader: TfrxMemoView
          Width = 1485.354330710000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object Memo224: TfrxMemoView
          Left = 9.600000000000000000
          Top = 2.000000000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Esp'#233'cie')
        end
        object rllLoja1: TfrxMemoView
          Left = 330.000000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja2: TfrxMemoView
          Tag = 3
          Left = 431.600000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja3: TfrxMemoView
          Tag = 3
          Left = 535.200000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja4: TfrxMemoView
          Tag = 3
          Left = 637.800000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja5: TfrxMemoView
          Tag = 3
          Left = 742.400000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja6: TfrxMemoView
          Tag = 3
          Left = 846.000000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja7: TfrxMemoView
          Tag = 3
          Left = 949.417322830000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja8: TfrxMemoView
          Tag = 3
          Left = 1055.200000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja9: TfrxMemoView
          Tag = 3
          Left = 1158.803149610000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllLoja10: TfrxMemoView
          Tag = 3
          Left = 1262.362204720000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
        end
        object rllTotal: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 2.000000000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
        end
        object Memo225: TfrxMemoView
          Left = 75.590600000000000000
          Top = 2.000000000000000000
          Width = 180.888250000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 75.590551180000000000
        Top = 355.275820000000000000
        Width = 1489.134820000000000000
        object Memo275: TfrxMemoView
          Left = 9.600000000000000000
          Width = 52.232900000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxResumoEspecies."RCX_ESPDOC"]')
        end
        object rllPra001: TfrxMemoView
          Left = 330.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA001"]')
        end
        object rllTotPra: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTPRA"]')
        end
        object Memo278: TfrxMemoView
          Left = 79.370130000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A Prazo')
        end
        object Memo279: TfrxMemoView
          Left = 79.370130000000000000
          Top = 19.897650000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Juros')
        end
        object Memo280: TfrxMemoView
          Left = 79.370130000000000000
          Top = 39.795300000000000000
          Width = 176.957390000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descontos')
        end
        object rllPra002: TfrxMemoView
          Left = 431.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA002"]')
        end
        object rllPra003: TfrxMemoView
          Left = 535.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA003"]')
        end
        object rllPra004: TfrxMemoView
          Left = 637.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA004"]')
        end
        object rllPra005: TfrxMemoView
          Left = 742.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA005"]')
        end
        object rllPra006: TfrxMemoView
          Left = 846.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA006"]')
        end
        object rllPra007: TfrxMemoView
          Left = 949.417322830000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA007"]')
        end
        object rllPra008: TfrxMemoView
          Left = 1055.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA008"]')
        end
        object rllPra009: TfrxMemoView
          Left = 1158.803149610000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA009"]')
        end
        object rllPra010: TfrxMemoView
          Left = 1262.362204720000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA010"]')
        end
        object rllJpr001: TfrxMemoView
          Left = 330.000000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR001"]')
        end
        object rllTotJpr: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 19.897650000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTJPR"]')
        end
        object rllJpr002: TfrxMemoView
          Left = 431.600000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR002"]')
        end
        object rllJpr003: TfrxMemoView
          Left = 535.200000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR003"]')
        end
        object rllJpr004: TfrxMemoView
          Left = 637.800000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR004"]')
        end
        object rllJpr005: TfrxMemoView
          Left = 742.400000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR005"]')
        end
        object rllJpr006: TfrxMemoView
          Left = 846.000000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR006"]')
        end
        object rllJpr007: TfrxMemoView
          Left = 949.417322830000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR007"]')
        end
        object rllJpr008: TfrxMemoView
          Left = 1055.200000000000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR008"]')
        end
        object rllJpr009: TfrxMemoView
          Left = 1158.803149610000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR009"]')
        end
        object rllJpr010: TfrxMemoView
          Left = 1262.362204720000000000
          Top = 19.897650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR010"]')
        end
        object rllDpr001: TfrxMemoView
          Left = 330.000000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR001"]')
        end
        object rllTotDpr: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 39.795300000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTDPR"]')
        end
        object rllDpr002: TfrxMemoView
          Left = 431.600000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR002"]')
        end
        object rllDpr003: TfrxMemoView
          Left = 535.200000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR003"]')
        end
        object rllDpr004: TfrxMemoView
          Left = 637.800000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR004"]')
        end
        object rllDpr005: TfrxMemoView
          Left = 742.400000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR005"]')
        end
        object rllDpr006: TfrxMemoView
          Left = 846.000000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR006"]')
        end
        object rllDpr007: TfrxMemoView
          Left = 949.417322830000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR007"]')
        end
        object rllDpr008: TfrxMemoView
          Left = 1055.200000000000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR008"]')
        end
        object rllDpr009: TfrxMemoView
          Left = 1158.803149610000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR009"]')
        end
        object rllDpr010: TfrxMemoView
          Left = 1262.362204720000000000
          Top = 39.795300000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR010"]')
        end
        object Line6: TfrxLineView
          Top = 67.031540000000000000
          Width = 1485.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter5: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 536.693260000000000000
        Width = 1489.134820000000000000
        object Memo324: TfrxMemoView
          Left = 9.600000000000000000
          Top = 8.000000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo325: TfrxMemoView
          Left = 1127.886580000000000000
          Top = 8.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object rllLinha3: TfrxMemoView
          Top = 7.559060000000040000
          Width = 1485.354330710000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          ParentFont = False
        end
      end
      object ReportSummary4: TfrxReportSummary
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 491.338900000000000000
        Width = 1489.134820000000000000
        object Memo326: TfrxMemoView
          Left = 9.600000000000000000
          Top = 3.023622049999970000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL')
        end
        object rllLinha2: TfrxLineView
          Top = 1.500000000000000000
          Width = 1485.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotalGeral: TfrxMemoView
          Tag = 1
          Left = 1366.188976380000000000
          Top = 3.023622049999970000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
        end
        object rllTotLoj001: TfrxMemoView
          Left = 329.952755910000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj002: TfrxMemoView
          Tag = 3
          Left = 431.622047240000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj003: TfrxMemoView
          Tag = 3
          Left = 535.181102360000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj004: TfrxMemoView
          Tag = 3
          Left = 637.984251970000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj005: TfrxMemoView
          Tag = 3
          Left = 742.299212600000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj006: TfrxMemoView
          Tag = 3
          Left = 845.858267720000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj007: TfrxMemoView
          Tag = 3
          Left = 949.417322830000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj008: TfrxMemoView
          Tag = 3
          Left = 1055.244094490000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj009: TfrxMemoView
          Tag = 3
          Left = 1158.803149610000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotLoj010: TfrxMemoView
          Tag = 3
          Left = 1262.362204720000000000
          Top = 3.023622049999970000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
    end
    object qckResumoFpg: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader6: TfrxPageHeader
        FillType = ftBrush
        Height = 134.118120000000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object rllNmEmRf: TfrxMemoView
          Align = baCenter
          Left = 349.644652000000000000
          Top = 9.440940000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Align = baCenter
          Left = 268.384757000000000000
          Top = 45.338590000000000000
          Width = 664.365120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 1062.878540000000000000
          Top = 28.338590000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Memo234: TfrxMemoView
          Left = 1110.878540000000000000
          Top = 45.338590000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo235: TfrxMemoView
          Left = 980.258070000000000000
          Top = 45.338590000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo236: TfrxMemoView
          Align = baCenter
          Left = 123.024182000000000000
          Top = 113.338590000000000000
          Width = 955.086270000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object Memo237: TfrxMemoView
          Left = 9.600000000000000000
          Top = 96.338590000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
        end
        object Memo242: TfrxMemoView
          Left = 9.600000000000000000
          Top = 79.338590000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object Memo243: TfrxMemoView
          Left = 438.878540000000000000
          Top = 96.338590000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
        end
        object Memo244: TfrxMemoView
          Left = 438.878540000000000000
          Top = 79.338590000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
        end
        object rllNmFnRf: TfrxMemoView
          Align = baCenter
          Left = 349.644652000000000000
          Top = 26.456710000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object Header7: TfrxHeader
        FillType = ftBrush
        Height = 39.677180000000000000
        Top = 215.433210000000000000
        Width = 1201.134634000000000000
        object Memo246: TfrxMemoView
          Left = 839.007932600000000000
          Top = 22.015770000000000000
          Width = 125.858277480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TRANSFER'#202'NCIAS')
          ParentFont = False
          WordWrap = False
        end
        object Memo247: TfrxMemoView
          Left = 516.881872680000000000
          Top = 22.015770000000000000
          Width = 122.078735280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'REC. DE TITULOS')
          ParentFont = False
          WordWrap = False
        end
        object Memo248: TfrxMemoView
          Left = 9.535291500000000000
          Top = 22.015770000000000000
          Width = 275.376500000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'FORMA')
          ParentFont = False
          WordWrap = False
        end
        object Memo249: TfrxMemoView
          Left = 282.921460000000000000
          Top = 22.015770000000000000
          Width = 118.299205280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo250: TfrxMemoView
          Left = 401.385814570000000000
          Top = 22.015770000000000000
          Width = 114.519675280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VENDAS '#192' VISTA')
          ParentFont = False
          WordWrap = False
        end
        object Memo251: TfrxMemoView
          Left = 735.677238580000000000
          Top = 22.015770000000000000
          Width = 103.181085280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'PAGAMENTOS')
          ParentFont = False
          WordWrap = False
        end
        object Memo252: TfrxMemoView
          Left = 965.354474720000000000
          Top = 22.015770000000000000
          Width = 95.622025280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'OUTROS PAG')
          ParentFont = False
          WordWrap = False
        end
        object Memo253: TfrxMemoView
          Left = 1060.960766610000000000
          Top = 22.015770000000000000
          Width = 129.637795280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO FINAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo254: TfrxMemoView
          Left = 9.535291500000000000
          Top = 5.007874020000000000
          Width = 1181.102638030000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR FORMA DE PAGAMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 638.520100000000000000
          Top = 21.921259840000000000
          Width = 97.133858270000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'OUTROS REC')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 279.685220000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxResumofPG
        DataSetName = 'frxResumoFpg'
        RowCount = 0
        object Memo271: TfrxMemoView
          Left = 9.448818900000000000
          Width = 275.527559060000000000
          Height = 17.000000000000000000
          DataField = 'FORMA'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxResumoFpg."FORMA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo272: TfrxMemoView
          Left = 282.921460000000000000
          Width = 118.299205280000000000
          Height = 17.000000000000000000
          DataField = 'VALINI'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VALINI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo273: TfrxMemoView
          Left = 401.385814570000000000
          Width = 114.519675280000000000
          Height = 17.000000000000000000
          DataField = 'VENAVI'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VENAVI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo274: TfrxMemoView
          Left = 735.677238580000000000
          Width = 103.181085280000000000
          Height = 17.000000000000000000
          DataField = 'PAGAME'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."PAGAME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo255: TfrxMemoView
          Left = 965.354474720000000000
          Width = 95.622025280000000000
          Height = 17.000000000000000000
          DataField = 'OUTROS'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."OUTROS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo276: TfrxMemoView
          Left = 1060.960766610000000000
          Width = 129.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxResumoFpg."VALINI"> + <frxResumoFpg."VENAVI"> + <frxResumoF' +
              'pg."VENPRA"> + <frxResumoFpg."OUTREC"> + <frxResumoFpg."PAGAME">' +
              ' + '
            ' <frxResumoFpg."TRANSF"> + <frxResumoFpg."OUTROS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo277: TfrxMemoView
          Left = 516.881872680000000000
          Width = 122.078735280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VENPRA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo256: TfrxMemoView
          Left = 839.007932600000000000
          Width = 125.858277480000000000
          Height = 17.000000000000000000
          DataField = 'TRANSF'
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."TRANSF"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 638.520100000000000000
          Width = 97.133858270000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."OUTREC"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer3: TfrxFooter
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 321.260050000000000000
        Width = 1201.134634000000000000
        object Memo257: TfrxMemoView
          Left = 9.448818900000000000
          Width = 275.527559060000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
          WordWrap = False
        end
        object Memo258: TfrxMemoView
          Left = 401.385814570000000000
          Width = 114.519675280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VENAVI">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo259: TfrxMemoView
          Left = 735.677238580000000000
          Width = 103.181085280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."PAGAME">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo260: TfrxMemoView
          Left = 965.354474720000000000
          Width = 95.622025280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."OUTROS">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo261: TfrxMemoView
          Left = 1060.960766610000000000
          Width = 129.637795280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VALINI">,MasterData4) + '
            ' SUM(<frxResumoFpg."VENAVI">,MasterData4) + '
            ' SUM(<frxResumoFpg."VENPRA">,MasterData4) +'
            ' SUM(<frxResumoFpg."OUTREC">,MasterData4) +'
            ' SUM(<frxResumoFpg."PAGAME">,MasterData4) +'
            ' SUM(<frxResumoFpg."TRANSF">,MasterData4) +'
            ' SUM(<frxResumoFpg."OUTROS">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo262: TfrxMemoView
          Left = 282.921460000000000000
          Width = 118.299205280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VALINI">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo263: TfrxMemoView
          Left = 516.881872680000000000
          Width = 122.078735280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VENPRA">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo264: TfrxMemoView
          Left = 839.007932600000000000
          Width = 125.858277480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."TRANSF">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo336: TfrxMemoView
          Left = 9.448818900000000000
          Top = 16.897650000000000000
          Width = 275.527559060000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'UTILIZA'#199#195'O DE CRED. (INFORMATIVO)')
          ParentFont = False
          WordWrap = False
        end
        object Memo337: TfrxMemoView
          Left = 401.385814570000000000
          Top = 17.118120000000000000
          Width = 114.519675280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo338: TfrxMemoView
          Left = 735.677238580000000000
          Top = 17.118120000000000000
          Width = 103.181085280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo339: TfrxMemoView
          Left = 965.354474720000000000
          Top = 17.118120000000000000
          Width = 95.622025280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo340: TfrxMemoView
          Left = 1060.960766610000000000
          Top = 17.118120000000000000
          Width = 129.637795280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo341: TfrxMemoView
          Left = 282.921460000000000000
          Top = 17.118120000000000000
          Width = 118.299205280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo342: TfrxMemoView
          Left = 516.881872680000000000
          Top = 17.118120000000000000
          Width = 122.078735280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ABS(SUM(<frxResumoFpg."VALCRE">,MasterData4))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo343: TfrxMemoView
          Left = 839.007932600000000000
          Top = 17.118120000000000000
          Width = 125.858277480000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 638.520100000000000000
          Width = 97.133858270000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."OUTREC">,MasterData4)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 638.520100000000000000
          Top = 17.118120000000000000
          Width = 97.133858270000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter6: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 687.874460000000000000
        Width = 1201.134634000000000000
        object Memo265: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 372.887940000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo266: TfrxMemoView
          Left = 380.749350000000000000
          Top = 17.000000000000000000
          Width = 806.929190000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData4) + COUNT(MasterData7)]')
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 35.897650000000000000
        Top = 464.882190000000000000
        Width = 1201.134634000000000000
        Condition = 'frxDetOutrosFpg."FORMA"'
        KeepTogether = True
        ReprintOnNewPage = True
        object Memo422: TfrxMemoView
          Left = 66.338590000000000000
          Top = 18.141732283464600000
          Width = 99.401555280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
        end
        object Memo423: TfrxMemoView
          Left = 166.283550000000000000
          Top = 18.118120000000000000
          Width = 69.165315280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'HORA')
          ParentFont = False
          WordWrap = False
        end
        object Memo424: TfrxMemoView
          Left = 234.976500000000000000
          Top = 18.118120000000000000
          Width = 69.165315280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'ESP')
          ParentFont = False
          WordWrap = False
        end
        object Memo425: TfrxMemoView
          Left = 304.228510000000000000
          Top = 18.118120000000000000
          Width = 707.905885280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo426: TfrxMemoView
          Left = 66.000000000000000000
          Top = 0.220469999999978000
          Width = 1078.299212600000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDetOutrosFpg."FORMA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo427: TfrxMemoView
          Left = 1011.000620000000000000
          Top = 18.338590000000000000
          Width = 133.417325280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData7: TfrxMasterData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 525.354670000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxDetOutrosFpg
        DataSetName = 'frxDetOutrosFpg'
        RowCount = 0
        object Memo428: TfrxMemoView
          Left = 66.519685040000000000
          Width = 99.401574800000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."DATA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo429: TfrxMemoView
          Left = 166.299212600000000000
          Width = 69.165354330000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."HORA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo430: TfrxMemoView
          Left = 235.086614170000000000
          Width = 69.165354330000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDetOutrosFpg."ESPECIE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo431: TfrxMemoView
          Left = 304.251968500000000000
          Width = 707.905511810000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo432: TfrxMemoView
          Left = 1011.023622050000000000
          Width = 133.417322830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDetOutrosFpg."VALOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.141732280000000000
        Top = 566.929500000000000000
        Width = 1201.134634000000000000
        HideIfSingleDataRecord = True
        object Memo433: TfrxMemoView
          Left = 1011.023622050000000000
          Width = 133.417322830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDetOutrosFpg."VALOR">,MasterData7)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo410: TfrxMemoView
          Left = 66.519685040000000000
          Width = 946.016294800000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          ParentFont = False
          WordWrap = False
        end
      end
      object Header9: TfrxHeader
        FillType = ftBrush
        Height = 18.141732280000000000
        Top = 423.307360000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Memo434: TfrxMemoView
          Left = 66.141732280000000000
          Width = 1078.299212600000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DEMONSTRATIVO ANAL'#205'TICO DE OUTROS PAGAMENTOS')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer5: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 608.504330000000000000
        Width = 1201.134634000000000000
        object Memo409: TfrxMemoView
          Left = 1010.914040000000000000
          Width = 133.417322830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDetOutrosFpg."VALOR">,MasterData7,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo411: TfrxMemoView
          Left = 66.519685040000000000
          Width = 944.881889760000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DE OUTROS PAGAMENTOS')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object qckListVenPraz: TfrxReportPage
      PaperWidth = 320.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader7: TfrxPageHeader
        FillType = ftBrush
        Height = 154.960644570000000000
        Top = 18.897650000000000000
        Width = 1133.859000000000000000
        object rllNmFnLv: TfrxMemoView
          Align = baCenter
          Left = 344.353310000000000000
          Top = 26.456710000000000000
          Width = 445.152380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Align = baCenter
          Left = 342.463545000000000000
          Top = 45.338590000000000000
          Width = 448.931910000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllNmEmLv: TfrxMemoView
          Align = baCenter
          Left = 344.353310000000000000
          Top = 9.440940000000000000
          Width = 445.152380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo269: TfrxMemoView
          Left = 1006.697340000000000000
          Top = 28.338590000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
        end
        object Memo270: TfrxMemoView
          Left = 1081.154050000000000000
          Top = 45.338590000000000000
          Width = 50.343290000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo281: TfrxMemoView
          Left = 1001.391960000000000000
          Top = 45.338590000000000000
          Width = 75.666110000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo282: TfrxMemoView
          Align = baCenter
          Left = 340.725110000000000000
          Top = 113.338590000000000000
          Width = 452.408780000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object Memo283: TfrxMemoView
          Left = 4.600000000000000000
          Top = 96.338590000000000000
          Width = 387.703710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
        end
        object Memo284: TfrxMemoView
          Left = 4.600000000000000000
          Top = 79.338590000000000000
          Width = 387.703710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
        end
        object Memo285: TfrxMemoView
          Left = 817.343290000000000000
          Top = 96.338590000000000000
          Width = 314.154050000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
        end
        object Memo286: TfrxMemoView
          Left = 817.343290000000000000
          Top = 79.338590000000000000
          Width = 314.154050000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
        end
        object Shape5: TfrxShapeView
          Top = 136.063080000000000000
          Width = 1131.968464880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo293: TfrxMemoView
          Top = 136.063080000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. Emiss'#227'o')
          ParentFont = False
        end
        object Memo294: TfrxMemoView
          Left = 90.724490000000000000
          Top = 136.063080000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
        end
        object Memo295: TfrxMemoView
          Left = 253.228510000000000000
          Top = 136.063080000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo296: TfrxMemoView
          Left = 505.614410000000000000
          Top = 136.063080000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vend.')
          ParentFont = False
        end
        object Memo297: TfrxMemoView
          Left = 551.441250000000000000
          Top = 136.063080000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pagto.')
          ParentFont = False
        end
        object Memo298: TfrxMemoView
          Left = 1017.111440000000000000
          Top = 136.063080000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Documento')
          ParentFont = False
        end
      end
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 260.787570000000000000
        Width = 1133.859000000000000000
        DataSet = frmRelRcxResumoCaixa.frxListVenPraz
        DataSetName = 'frxListVenPraz'
        RowCount = 0
        Stretched = True
        object Memo287: TfrxMemoView
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_DTADOC"]')
          ParentFont = False
        end
        object Memo288: TfrxMemoView
          Left = 90.724490000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."NUMDOC"]')
          ParentFont = False
        end
        object Memo289: TfrxMemoView
          Left = 253.228510000000000000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CODCLI"]-[frxListVenPraz."CLI_NOMCLI"]')
          ParentFont = False
        end
        object Memo290: TfrxMemoView
          Left = 505.614410000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CODVEN"]')
          ParentFont = False
        end
        object Memo291: TfrxMemoView
          Left = 551.441250000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CONPAG"]')
          ParentFont = False
        end
        object Memo292: TfrxMemoView
          Left = 967.977550000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxListVenPraz."GER_VLRCON"]')
          ParentFont = False
        end
      end
      object Header8: TfrxHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 234.330860000000000000
        Width = 1133.859000000000000000
      end
      object PageFooter7: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 381.732530000000000000
        Width = 1133.859000000000000000
        object Memo299: TfrxMemoView
          Left = 2.600000000000000000
          Top = 17.000000000000000000
          Width = 478.714780000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo300: TfrxMemoView
          Left = 479.528880000000000000
          Top = 17.000000000000000000
          Width = 651.968460000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData5)]')
        end
      end
      object Footer4: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 302.362400000000000000
        Width = 1133.859000000000000000
        object Memo301: TfrxMemoView
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo302: TfrxMemoView
          Left = 947.946124720000000000
          Width = 182.551215280000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
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
            '[SUM(<frxListVenPraz."GER_VLRCON">,MasterData5)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object Page5: TfrxReportPage
      Visible = False
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbPagamento: TfrxMasterData
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 75.590600000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
        RowCount = 0
        object rllZebraPg: TfrxMemoView
          Left = 0.661410000000000000
          Width = 1243.464596220000000000
          Height = 37.795275590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo303: TfrxMemoView
          Left = 88.606370000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo304: TfrxMemoView
          Left = 224.874150000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_PARCEL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo305: TfrxMemoView
          Left = 4.913385830000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DUPLICATA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo306: TfrxMemoView
          Left = 270.551330000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo307: TfrxMemoView
          Left = 312.126160000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo308: TfrxMemoView
          Left = 361.480520000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SERIE:')
          ParentFont = False
          WordWrap = False
        end
        object Memo309: TfrxMemoView
          Left = 411.173470000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_SERIE_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo310: TfrxMemoView
          Left = 252.874150000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo311: TfrxMemoView
          Left = 344.362400000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo312: TfrxMemoView
          Left = 452.559370000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNEC.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo313: TfrxMemoView
          Left = 433.882190000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo314: TfrxMemoView
          Left = 519.811380000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo315: TfrxMemoView
          Left = 594.181510000000000000
          Width = 336.377986930000000000
          Height = 18.897625590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo333: TfrxMemoView
          Left = 1114.268400000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxPagamento."CTP_VALORI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo219: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 1182.992890000000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'Memo219OnBeforePrint'
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O: [frxPagamento."CTP_HIST01"]')
          ParentFont = False
        end
      end
      object rlbCabPagamento: TfrxHeader
        FillType = ftBrush
        Height = 34.015755350000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        object Memo316: TfrxMemoView
          Left = 4.913385830000000000
          Top = 9.826771650000001000
          Width = 1239.685840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DETALHAMENTO DE PAGAMENTOS:')
          ParentFont = False
        end
      end
    end
    object Page6: TfrxReportPage
      Visible = False
      PaperWidth = 337.800000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbPagamentoS: TfrxMasterData
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 75.590600000000000000
        Width = 1201.134634000000000000
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
        RowCount = 0
        object rllZebraPGS: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 37.795275590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo317: TfrxMemoView
          Left = 88.606370000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxPagamento."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo318: TfrxMemoView
          Left = 261.787570000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_PARCEL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo319: TfrxMemoView
          Left = 4.913385830000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DUPLICATA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo320: TfrxMemoView
          Left = 302.567100000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo321: TfrxMemoView
          Left = 344.141930000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo322: TfrxMemoView
          Left = 393.496290000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SERIE:')
          ParentFont = False
          WordWrap = False
        end
        object Memo323: TfrxMemoView
          Left = 444.189240000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_SERIE_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo327: TfrxMemoView
          Left = 284.889920000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo328: TfrxMemoView
          Left = 376.378170000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo329: TfrxMemoView
          Left = 485.575140000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNEC.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo330: TfrxMemoView
          Left = 466.897960000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
          WordWrap = False
        end
        object Memo331: TfrxMemoView
          Left = 552.827150000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo332: TfrxMemoView
          Left = 627.197280000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxPagamento."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo335: TfrxMemoView
          Left = 1058.268400000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxPagamento."CTP_VALORI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo213: TfrxMemoView
          Left = 4.559059999999999000
          Top = 18.897650000000000000
          Width = 1182.992890000000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'Memo213OnBeforePrint'
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O: [frxPagamento."CTP_HIST01"]')
          ParentFont = False
        end
      end
      object rlbCabPagamentoS: TfrxHeader
        FillType = ftBrush
        Height = 34.015755350000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object Memo334: TfrxMemoView
          Left = 4.913385830000000000
          Top = 9.826771650000001000
          Width = 1186.772420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DETALHAMENTO DE PAGAMENTOS:')
          ParentFont = False
        end
      end
    end
    object qckDupJus: TfrxReportPage
      PaperWidth = 350.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetDupJus: TfrxMasterData
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 219.212740000000000000
        Width = 1247.244900000000000000
        DataSet = frmRelRcxResumoCaixa.frxDupJus
        DataSetName = 'frxDupJus'
        RowCount = 0
        object rllZebDupJus: TfrxMemoView
          Width = 1248.227460000000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
        end
        object Memo447: TfrxMemoView
          Left = 2.118120000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupJus."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo448: TfrxMemoView
          Left = 191.960730000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupJus."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo449: TfrxMemoView
          Left = 277.228510000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupJus."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo450: TfrxMemoView
          Left = 366.157700000000000000
          Width = 404.409710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupJus."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object rllCodFpg: TfrxMemoView
          Left = 777.717070000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'rllCodFpgOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object Memo452: TfrxMemoView
          Left = 951.575450000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALORI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo453: TfrxMemoView
          Left = 1075.284170000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALDES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo454: TfrxMemoView
          Left = 1143.536180000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo455: TfrxMemoView
          Left = 2.118120000000000000
          Top = 18.118120000000000000
          Width = 1243.465370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDupJus."JUSDES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo396: TfrxMemoView
          Left = 1124.638530000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '%')
          ParentFont = False
        end
      end
      object rlbCabDupJus: TfrxPageHeader
        FillType = ftBrush
        Height = 139.842524570000000000
        Top = 18.897650000000000000
        Width = 1247.244900000000000000
        object Shape8: TfrxShapeView
          Top = 97.708720000000000000
          Width = 1247.244900000000000000
          Height = 41.574830000000000000
          Fill.BackColor = clScrollBar
        end
        object rllNmEmDj: TfrxMemoView
          Align = baCenter
          Left = 372.699785000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo457: TfrxMemoView
          Align = baCenter
          Left = 291.439890000000000000
          Top = 35.897650000000000000
          Width = 664.365120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo458: TfrxMemoView
          Left = 1120.232900000000000000
          Top = 18.897650000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
        end
        object Memo459: TfrxMemoView
          Left = 1168.232900000000000000
          Top = 35.897650000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo460: TfrxMemoView
          Left = 1037.612430000000000000
          Top = 35.897650000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo461: TfrxMemoView
          Align = baCenter
          Left = 146.079315000000000000
          Top = 56.543290000000000000
          Width = 955.086270000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
        end
        object rllNmFnDj: TfrxMemoView
          Align = baCenter
          Left = 372.699785000000000000
          Top = 17.015770000000000000
          Width = 501.845330000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo463: TfrxMemoView
          Align = baCenter
          Left = 146.079315000000000000
          Top = 75.826840000000000000
          Width = 955.086270000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATAS COM JUSTIFICATIVA DE DESCONTO')
          WordWrap = False
        end
        object Memo464: TfrxMemoView
          Left = 2.118120000000000000
          Top = 100.047310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo465: TfrxMemoView
          Left = 190.299320000000000000
          Top = 100.047310000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. VEN.')
          ParentFont = False
        end
        object Memo466: TfrxMemoView
          Left = 277.228510000000000000
          Top = 100.047310000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. REC.')
          ParentFont = False
        end
        object Memo467: TfrxMemoView
          Left = 366.157700000000000000
          Top = 100.047310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo468: TfrxMemoView
          Left = 777.717070000000000000
          Top = 100.047310000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORMA PAG.')
          ParentFont = False
        end
        object Memo469: TfrxMemoView
          Left = 962.914040000000000000
          Top = 100.047310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. ORIG.')
          ParentFont = False
        end
        object Memo470: TfrxMemoView
          Left = 1094.402290000000000000
          Top = 100.047310000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo471: TfrxMemoView
          Left = 1151.095240000000000000
          Top = 100.047310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. REC.')
          ParentFont = False
        end
        object Memo472: TfrxMemoView
          Left = 2.118120000000000000
          Top = 118.944960000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'JUSTIFICATIVA')
          ParentFont = False
        end
      end
      object PageFooter8: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 317.480520000000000000
        Width = 1247.244900000000000000
        object Memo397: TfrxMemoView
          Left = 2.118120000000000000
          Top = 17.000000000000000000
          Width = 429.580890000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
        end
        object Memo398: TfrxMemoView
          Left = 426.410760000000000000
          Top = 17.000000000000000000
          Width = 818.267780000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetDupJus)]')
        end
      end
    end
    object Page7: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDadosFechamento: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 86.929190000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxFechamentos
        DataSetName = 'frxFechamentos'
        RowCount = 0
        object Memo456: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object Memo482: TfrxMemoView
          Left = 109.606223540000000000
          Width = 166.299224800000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DESCRI"]')
          ParentFont = False
        end
        object Memo484: TfrxMemoView
          Left = 352.614136610000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DINREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo485: TfrxMemoView
          Left = 413.218800000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CARREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo486: TfrxMemoView
          Left = 473.559050240000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQAVI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo487: TfrxMemoView
          Left = 535.921254960000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQPRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo488: TfrxMemoView
          Left = 596.393695910000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_ORDREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo489: TfrxMemoView
          Left = 656.866136850000000000
          Width = 111.496084960000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy hh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTAGRV"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo490: TfrxMemoView
          Left = 277.023321810000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo492: TfrxMemoView
          Left = 40.236176540000000000
          Width = 68.031508270000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo494: TfrxMemoView
          Left = 8.000000000000000000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          DataSet = frmRelRcxResumoCaixa.frxFechamentos
          DataSetName = 'frxFechamentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CODOPE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbHeaderFechamentos: TfrxHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        object Shape6: TfrxShapeView
          Align = baWidth
          Top = 24.677192200000000000
          Width = 944.882500000000000000
          Height = 18.897637800000000000
          Fill.BackColor = clSilver
        end
        object Memo462: TfrxMemoView
          Left = 108.960583540000000000
          Top = 26.677180000000000000
          Width = 166.299224800000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo473: TfrxMemoView
          Left = 351.968496610000000000
          Top = 26.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo474: TfrxMemoView
          Left = 412.573160000000000000
          Top = 26.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo475: TfrxMemoView
          Left = 472.913410240000000000
          Top = 26.677180000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo476: TfrxMemoView
          Left = 535.275614960000000000
          Top = 26.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.PR'#201)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo477: TfrxMemoView
          Left = 595.748055910000000000
          Top = 26.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PAG.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo478: TfrxMemoView
          Left = 658.000026850000000000
          Top = 26.677180000000000000
          Width = 107.716554960000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA/HORA LAN'#199'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo479: TfrxMemoView
          Left = 278.157211810000000000
          Top = 26.677180000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo481: TfrxMemoView
          Left = 41.370066540000010000
          Top = 26.677180000000000000
          Width = 64.251978270000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo483: TfrxMemoView
          Left = 7.354360000000000000
          Top = 26.677180000000000000
          Width = 30.236220470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo451: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000001000
          Width = 944.882500000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'LISTAGEM DE FECHAMENTOS')
          ParentFont = False
        end
      end
    end
    object qckLacresMalotes: TfrxReportPage
      PaperWidth = 260.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 94.488250000000000000
        Width = 944.882500000000000000
        DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
        DataSetName = 'frxLacresMalotes'
        RowCount = 0
        object Memo480: TfrxMemoView
          Align = baClient
          Width = 944.882500000000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 =0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object Memo493: TfrxMemoView
          Left = 321.700716610000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataField = 'RCX_DINREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DINREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo495: TfrxMemoView
          Left = 382.305380000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataField = 'RCX_CARREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CARREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo496: TfrxMemoView
          Left = 442.645630240000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataField = 'RCX_CHQAVI'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQAVI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo497: TfrxMemoView
          Left = 505.007834960000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataField = 'RCX_CHQPRE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQPRE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo498: TfrxMemoView
          Left = 565.480275910000100000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataField = 'RCX_ORDREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_ORDREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo499: TfrxMemoView
          Left = 131.834286850000000000
          Width = 111.496084960000000000
          Height = 15.118110240000000000
          DataField = 'RCX_NUMLAC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_NUMLAC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo501: TfrxMemoView
          Left = 64.236176540000000000
          Width = 64.251978270000010000
          Height = 15.118110240000000000
          DataField = 'RCX_DTACAD'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo502: TfrxMemoView
          Left = 8.000000000000000000
          Width = 52.913400470000000000
          Height = 15.118110240000000000
          DataField = 'RCX_CODOPE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CODOPE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo491: TfrxMemoView
          Left = 244.992270000000000000
          Width = 75.590560940000000000
          Height = 15.118110240000000000
          DataField = 'RCX_VALDOC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo503: TfrxMemoView
          Left = 626.724800000000000000
          Width = 83.149620939999990000
          Height = 15.118110240000000000
          DataField = 'RCX_FUNCAX'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_FUNCAX"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object RLBhEADERlACRES: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 944.882500000000000000
        object Shape7: TfrxShapeView
          Align = baWidth
          Top = 33.677192200000000000
          Width = 944.882500000000000000
          Height = 18.897637800000000000
          Fill.BackColor = clSilver
        end
        object Memo504: TfrxMemoView
          Left = 319.275546610000000000
          Top = 35.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo505: TfrxMemoView
          Left = 379.880210000000000000
          Top = 35.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo506: TfrxMemoView
          Left = 440.220460240000000000
          Top = 35.677180000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo507: TfrxMemoView
          Left = 502.582664960000000000
          Top = 35.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.PR'#201)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo508: TfrxMemoView
          Left = 563.055105909999900000
          Top = 35.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PAG.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo509: TfrxMemoView
          Left = 132.968176850000000000
          Top = 35.677180000000000000
          Width = 107.716554960000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#218'M. LACRE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo510: TfrxMemoView
          Left = 245.464261810000000000
          Top = 35.677180000000000000
          Width = 71.811030940000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo511: TfrxMemoView
          Left = 65.370066540000010000
          Top = 35.677180000000000000
          Width = 64.251978270000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo512: TfrxMemoView
          Left = 7.354360000000000000
          Top = 35.677180000000000000
          Width = 56.692930470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OPE. FEC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo513: TfrxMemoView
          Align = baWidth
          Top = 11.779530000000000000
          Width = 944.882500000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'LISTAGEM DE TRANSFER'#202'NCIAS POR LACRES')
          ParentFont = False
        end
        object Memo500: TfrxMemoView
          Left = 625.945270000000000000
          Top = 36.456710000000000000
          Width = 83.149620940000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FUNDO CAIXA')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxRelRcxResumoCaixaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42895.425645023100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltSaldo: Double;'
      '  fltSomaValDoc: Double;'
      '  fltTotalSeq: Double;'
      '  fltSomaSeq: Double;             '
      '  intSeqAnt1: Integer;'
      '  blnCheques: Boolean;        '
      ''
      'procedure MSDESPDOCOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChildTroFpg.Visible := <frxRelatorio_RelRcx."TROSEQ"> <> '#39#39';'
      '  '
      '  if (<frxRelatorio_RelRcx."JURDES"> = '#39#39') Then'
      '  Begin                      '
      ''
      
        '    If (Not fAdicionaCheques(<frxRelatorio_RelRcx."RCX_DOCUME">,' +
        ' <frxRelatorio_RelRcx."RCX_CODEMP">, <frxRelatorio_RelRcx."SEQCO' +
        'N">, <frxRelatorio_RelRcx."DTACAD">)) Or'
      
        '       ((<frxRelatorio_RelRcx."CHQAVI"> = 0 ) And (<frxRelatorio' +
        '_RelRcx."CHQPRE"> = 0 )) Or ((<frxRelatorio_RelRcx."ESPDOC"> = '#39 +
        'CC'#39') And (<SEQBAI> = '#39'S'#39')) Or'
      
        '       ((<frxRelatorio_RelRcx."DINHEI"> + <frxRelatorio_RelRcx."' +
        'CARREC"> + <frxRelatorio_RelRcx."CHQAVI"> + <frxRelatorio_RelRcx' +
        '."CHQPRE"> + <frxRelatorio_RelRcx."ORDREC">) = 0)           '
      '       Then'
      '    Begin              '
      '      rlbChqs.Visible := False;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbMotDes;            '
      '      End Else'
      '      Begin                    '
      
        '        if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN             ' +
        '                                                                ' +
        '               '
      '          rlbDetGrupo.Child := rlbMotDes'
      '        else'
      '        begin'
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbMotDes;                      ' +
        '                    '
      '        end;                        '
      '      End;                  '
      '    End'
      '    Else'
      '    Begin'
      '      rlbChqs.Visible := True;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbChqs;            '
      '      End Else'
      '      Begin                    '
      '        rlbDetGrupo.Child := rlbChqs;'
      '      End;                  '
      '    End;'
      '  End'
      '  Else'
      '  Begin'
      '    rlbChqs.Visible := False;'
      '    If ChildTroFpg.Visible Then'
      '    Begin'
      '      rlbDetGrupo.Child := ChildTroFpg;'
      '      ChildTroFpg.Child := rlbMotDes;            '
      '    End Else'
      '    Begin                    '
      
        '      if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN               ' +
        '                                                                ' +
        '             '
      '          rlbDetGrupo.Child := rlbMotDes'
      '        else'
      '        begin'
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbMotDes;                      ' +
        '                    '
      '        end;              '
      '    End;                  '
      '  End;'
      ''
      '  If (<SEQBAI> = '#39'S'#39') And (<MODRCX> = '#39'1'#39') Then'
      '  Begin'
      '    rdbDin.Visible := (<frxRelatorio_RelRcx."DINHEI"> <> 0);'
      '    rdbCart.Visible := (<frxRelatorio_RelRcx."CARREC"> <> 0);'
      
        '    rdbChqVista.Visible := (<frxRelatorio_RelRcx."CHQAVI"> <> 0)' +
        ';'
      '    rdbChqPre.Visible := (<frxRelatorio_RelRcx."CHQPRE"> <> 0);'
      '    rdbOrdPag.Visible := (<frxRelatorio_RelRcx."ORDREC"> <> 0);'
      '    rdbValCre.Visible := (<frxRelatorio_RelRcx."VALCRE"> <> 0);'
      '      '
      
        '    rdbValor.Visible := ((<frxRelatorio_RelRcx."DINHEI"> + <frxR' +
        'elatorio_RelRcx."CARREC"> + '
      
        '                          <frxRelatorio_RelRcx."CHQAVI"> + <frxR' +
        'elatorio_RelRcx."CHQPRE"> + '
      '                          <frxRelatorio_RelRcx."ORDREC">) <> 0);'
      ''
      
        '    rdbSaldo.Visible := rdbValor.Visible;                       ' +
        '                                                '
      '      '
      '  End'
      '  Else'
      '  Begin'
      '    rdbDin.Visible      := True;'
      '    rdbCart.Visible     := True;'
      '    rdbChqVista.Visible := True;'
      '    rdbChqPre.Visible   := True;'
      '    rdbOrdPag.Visible   := True;'
      '    rdbValCre.Visible   := True;'
      '    rdbValor.Visible    := True;'
      '    rdbSaldo.Visible    := True;                   '
      '  End;'
      ''
      '  {************************************************}'
      '  {* Exibir cheques apenas no '#250'ltimo doc da baixa *}'
      
        '  {* quando estiver no Modelo 2                   *}            ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                              '
      '  {*********************************************AJ*}          '
      
        '  If (intSeqAnt1 <> <frxRelatorio_RelRcx."SEQCON">) And (<SEQBAI' +
        '> = '#39'S'#39')  Then'
      '  Begin            '
      
        '    intSeqAnt1 := <frxRelatorio_RelRcx."SEQCON">;               ' +
        '          '
      '    fltSomaSeq := 0;'
      
        '    blnCheques := False;                                        ' +
        '        '
      
        '    fltTotalSeq := fTotalSeq(<frxRelatorio_RelRcx."RCX_CODEMP">,' +
        ' <frxRelatorio_RelRcx."SEQCON">, <frxRelatorio_RelRcx."DTACAD">)' +
        ';'
      ' End;'
      '             '
      '  If (<SEQBAI> = '#39'S'#39') And (<MODRCX> = '#39'2'#39') Then'
      '  Begin              '
      '   '
      '    fltSomaSeq := fltSomaSeq + <frxRelatorio_RelRcx."VALDOC">;'
      '        '
      '    rlbChqs.Visible := False;'
      
        '    If fAdicionaCheques(<frxRelatorio_RelRcx."RCX_DOCUME">, <frx' +
        'Relatorio_RelRcx."RCX_CODEMP">, <frxRelatorio_RelRcx."SEQCON">, ' +
        '<frxRelatorio_RelRcx."DTACAD">) Then'
      
        '      blnCheques := True;                                       ' +
        '                                                                ' +
        '                                      '
      '    If (blnCheques) And (fltSomaSeq = (fltTotalSeq)) Then'
      
        '    Begin                                                       ' +
        '          '
      '      rlbChqs.Visible := True;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbChqs;            '
      '      End Else'
      '      Begin                    '
      '        rlbDetGrupo.Child := rlbChqs;'
      '      End;                 '
      '    End'
      '    Else'
      '    Begin'
      '      rlbChqs.Visible := False;'
      '      If ChildTroFpg.Visible Then'
      '      Begin'
      '        rlbDetGrupo.Child := ChildTroFpg;'
      '        ChildTroFpg.Child := rlbMotDes;            '
      '      End Else'
      '      Begin                    '
      
        '        if <frxRelatorio_RelRcx."MOTEST"> = '#39#39' THEN             ' +
        '                                                                ' +
        '               '
      '          rlbDetGrupo.Child := rlbMotDes'
      '        else'
      '        begin'
      '          rlbDetGrupo.Child  := ChildEstorno;'
      
        '          ChildEstorno.Child := rlbMotDes;                      ' +
        '                    '
      '        end;              '
      '      End;                 '
      '    End;  '
      '  End;      '
      'end;'
      ''
      'procedure rllSalIniAOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <Page> > 1 Then'
      '  Begin                      '
      '    rllSalIniA.visible := False;'
      '    rllTitSalIniA.Visible := False;'
      '    rllCarIniA.Visible := False;'
      '    rllDinIniA.Visible := False;'
      '    rllChaIniA.Visible := False;'
      '    rllchpIniA.Visible := False;'
      '    rllOrdIniA.Visible := False;'
      '  End                '
      '  Else'
      '  Begin              '
      '    rllSalIniA.visible := True;'
      '    rllTitSalIniA.Visible := True;'
      '    rllCarIniA.Visible := True;'
      '    rllDinIniA.Visible := True;'
      '    rllChaIniA.Visible := True;'
      '    rllchpIniA.Visible := True;'
      '    rllOrdIniA.Visible := True;        '
      '  End;              '
      'end;'
      ''
      'procedure rllSalIniSOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <Page> > 1 Then'
      '    rllSalIniS.visible := False'
      '  Else'
      '    rllSalIniS.visible := True;  '
      'end;'
      ''
      'procedure rlbMotDesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio_RelRcx."MOTDES"> = '#39#39') Or (<frxRelatorio_Rel' +
        'Rcx."JURDES"> <> '#39'D'#39') Then'
      '    rlbMotDes.Visible := False'
      '  Else'
      '    rlbMotDes.Visible := True;              '
      'end;'
      ''
      'procedure mmoTitPg1SOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoTitPg1S.Visible := <TOTPAG> <> 0;                          ' +
        '                      '
      'end;'
      ''
      'procedure mmoValPg1SOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoValPg1S.Visible := <TOTPAG> <> 0;  '
      'end;'
      ''
      ''
      ''
      'procedure mmoTitPg1AOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoTitPg1A.Visible := <TOTPAG> <> 0;  '
      'end;'
      ''
      ''
      'procedure mmoValPg1AOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  mmoValPg1A.Visible := <TOTPAG> <> 0;  '
      'end;'
      ''
      ''
      'procedure rlbGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure childCabInformOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxResumo."VENENT">) = '#39'0,00'#39' then'
      '  Begin'
      '    rllFaturadoA.Visible  := False;'
      '    rllFaturadoS.Visible  := False;'
      '    rllVenPreEntA.Visible := False;'
      
        '    rllVenPreEntS.Visible := False;                             ' +
        '                             '
      '  End'
      '  Else'
      '  Begin'
      '    rllFaturadoA.Visible  := True;'
      '    rllFaturadoS.Visible  := True;'
      '    rllVenPreEntA.Visible := True;'
      '    rllVenPreEntS.Visible := True;  '
      '  End;            '
      'end;'
      ''
      ''
      ''
      'procedure rllCodFpgOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDupJus."CTR_DINHEI"> > 0 Then'
      '    rllCodFpg.Text := '#39'DINHEIRO'#39
      ''
      '  Else If <frxDupJus."CTR_CHQAVI"> > 0 Then'
      '    rllCodFpg.Text := '#39'CHEQUE A VISTA'#39
      ''
      '  Else If <frxDupJus."CTR_CHQPRE"> > 0 Then'
      '    rllCodFpg.Text := '#39'CHEQUE A PRAZO'#39
      ''
      '  Else If <frxDupJus."CTR_CARTAO"> > 0 Then'
      '    rllCodFpg.Text := '#39'CARTAO'#39
      ''
      '  Else'
      '    rllCodFpg.Text := '#39#39';  '
      'end;'
      ''
      'procedure rdbSaldoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltSaldo := fltSaldo + <frxRelatorio_RelRcx."SOMSLD">;'
      
        '  fltSomaValDoc := fltSomaValDoc + <frxRelatorio_RelRcx."VALDOC"' +
        '>;                                '
      
        '  rdbSaldo.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);          ' +
        '                                '
      'end;'
      ''
      'procedure rdbSaldoGerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbSaldoGer.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);  '
      'end;'
      ''
      'procedure rdbSaldoTotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbSaldoTot.Text := FormatFloat('#39'###,#0.00'#39', fltSaldo);    '
      'end;'
      ''
      'procedure DMPMemo156OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo156.Text := FormatFloat('#39'###,#0.00'#39', fltSomaValDoc + fl' +
        'tSaldo);  '
      'end;'
      ''
      ''
      'procedure DMPMemo215OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxPagamento."CTP_HIST01"> = '#39#39' Then Begin             '
      '    DMPMemo215.Visible := False;'
      
        '    rlbPagamento.Height := 19;                                  ' +
        '    '
      '  End Else Begin             '
      '    DMPMemo215.Visible := True;'
      '    rlbPagamento.Height := 38;'
      '  End;  '
      'end;'
      ''
      ''
      '     '
      'procedure DMPMemo224OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxPagamento."CTP_HIST01"> = '#39#39' Then Begin             '
      '    DMPMemo224.Visible := False;'
      
        '    rlbPagamentoS.Height := 19;                                 ' +
        '     '
      '  End Else Begin             '
      '    DMPMemo224.Visible := True;'
      '    rlbPagamentoS.Height := 38;'
      '  End;    '
      'end;    '
      ''
      ''
      'procedure memTotalVendaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memTotalVenda.Text := FormatFloat('#39'###,#0.00'#39', (<frxResFat."VD' +
        '_VIS"> + <frxResFat."VD_VIS015"> + <frxResFat."VD_FAT"> + <frxRe' +
        'sFat."VD_CAR">));'
      
        '  DMPMemo401.Text    := FormatFloat('#39'###,#0.00'#39', (<frxResFat."VD' +
        '_VIS"> + <frxResFat."VD_VIS015"> + <frxResFat."VD_FAT"> + <frxRe' +
        'sFat."VD_CAR">));'
      
        '  memTotalVendaFreA.Text  := FormatFloat('#39'###,#0.00'#39', (<frxResFa' +
        't."VD_VISFRE"> + <frxResFat."VD_VISFRE015"> + <frxResFat."VD_FAT' +
        'FRE"> + <frxResFat."VD_CARFRE">));'
      
        '  memTotalVendaFreB.Text  := FormatFloat('#39'###,#0.00'#39', (<frxResFa' +
        't."VD_VISFRE"> + <frxResFat."VD_VISFRE015"> + <frxResFat."VD_FAT' +
        'FRE"> + <frxResFat."VD_CARFRE">));      '
      'end;'
      ''
      'BEGIN'
      '  fltSaldo := <SALINI>;'
      '  fltSomaValDoc := 0;'
      '  fltSomaSeq := 0;'
      '  intSeqAnt1 := 0;            '
      '  blnCheques := False;      '
      'END.          ')
    OnNewGetValue = frxRelRcxResumoCaixaMNewGetValue
    Left = 64
    Top = 24
    Datasets = <
      item
        DataSet = frmRelRcxResumoCaixa.frxCheques
        DataSetName = 'frxCheques'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxCredito
        DataSetName = 'frxCredito'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDetOutrosFpg
        DataSetName = 'frxDetOutrosFpg'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDupJus
        DataSetName = 'frxDupJus'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxFechamentos
        DataSetName = 'frxFechamentos'
      end
      item
        DataSet = frxGen_RelRcx
        DataSetName = 'frxGen_RelRcx'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
        DataSetName = 'frxLacresMalotes'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxListVenPraz
        DataSetName = 'frxListVenPraz'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
      end
      item
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResFat
        DataSetName = 'frxResFat'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumoEspecies
        DataSetName = 'frxResumoEspecies'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumofPG
        DataSetName = 'frxResumoFpg'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxResumoVendas
        DataSetName = 'frxResumoVendas'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
      end
      item
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
      end>
    Variables = <
      item
        Name = ' Resumo'
        Value = Null
      end
      item
        Name = 'fltQtdDia'
        Value = Null
      end
      item
        Name = 'fltQtdDoc'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      LargeDesignHeight = True
      OnAfterPrint = 'qckPaginaAOnAfterPrint'
      FontStyle = [fsx12cpi]
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1564.800000000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        Child = frxRelRcxResumoCaixaM.ChildTroFpg
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
        RowCount = 0
        object rllDesDoc: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."NUMDOC"]')
          TruncOutboundText = False
        end
        object rdbDescri: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESCRI'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DESCRI"]')
          TruncOutboundText = False
        end
        object rdbDin: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DINHEI"]')
          TruncOutboundText = False
        end
        object rdbCart: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CARREC"]')
          TruncOutboundText = False
        end
        object rdbChqVista: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQAVI"]')
          TruncOutboundText = False
        end
        object rdbChqPre: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQPRE"]')
          TruncOutboundText = False
        end
        object rdbOrdPag: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."ORDREC"]')
          TruncOutboundText = False
        end
        object rdbValCre: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALCRE"]')
          TruncOutboundText = False
        end
        object rdbValor: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALDOC"]')
          TruncOutboundText = False
        end
        object rdbSaldo: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllDtaCad: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DTACAD"]')
          TruncOutboundText = False
        end
        object rllSeqBai: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."SEQCON"]')
          TruncOutboundText = False
        end
        object rllDesCodOpe: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CODOPE"]')
          TruncOutboundText = False
        end
        object DMPMemo533: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."PIXREC"]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 187.000000000000000000
        Width = 1564.800000000000000000
        ReprintOnNewPage = True
        object rllTitDoc: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object rllTitHis: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DINHEIRO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.VISTA')
          TruncOutboundText = False
        end
        object RLLHIST: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.PRE')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ORD.PAG.')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VAL.CRED.')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object rllSalIniA: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalIniAOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[SALINI]')
          TruncOutboundText = False
        end
        object rllTitDta: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object rllTitSalIniA: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO INICIAL:')
          TruncOutboundText = False
        end
        object rllDinIniA: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DININI]')
          TruncOutboundText = False
        end
        object rllCarIniA: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CARINI]')
          TruncOutboundText = False
        end
        object rllChaIniA: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CHAINI]')
          TruncOutboundText = False
        end
        object rllchpIniA: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CHPINI]')
          TruncOutboundText = False
        end
        object rllOrdIniA: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDINI]')
          TruncOutboundText = False
        end
        object rllTitSeqBai: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'SEQBAI')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object rllTitCodOpe: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo524: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'PIX')
          TruncOutboundText = False
        end
        object DMPMemo525: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PIXINI]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1564.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorioA: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllOrdemA: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSqFcRxA: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
          TruncOutboundText = False
        end
        object rllOperadorA: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object rllVisualizacao: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
          TruncOutboundText = False
        end
        object rllEspecieA: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object rllNomeFantasia: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1564.800000000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'frxRelatorio_RelRcx."QUEBRA"'
        ReprintOnNewPage = True
        object rllTitEspecie: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ESP.DOC:')
          TruncOutboundText = False
        end
        object rdbEspecie: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DataField = 'QUEBRA'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."QUEBRA"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 2006.000000000000000000
        Width = 1564.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETGRUPO)]')
          TruncOutboundText = False
        end
      end
      object rlbResumoGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 561.000000000000000000
        Width = 1564.800000000000000000
        PrintChildIfInvisible = True
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL DOCUMENTOS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."DINHEI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CARREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQAVI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQPRE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."ORDREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALCRE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbSaldoTot: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoTotOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo534: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."PIXREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childOperacoesA: TfrxChild
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 731.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.childCabInformA
        object DMPMemo16: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'OPERACOES')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SAIDAS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO FINAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DINHEIRO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntDin: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DINENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiDin: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DINSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalDin: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<DININI>+<frxResumo."DINENT">+<frxResumo."DINSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 68.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CHEQUE A VISTA:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntChqVis: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQENT_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_AVI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiChqVis: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQSAI_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_AVI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalChqVis: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHAINI>+<frxResumo."CHQENT_AVI">+<frxResumo."CHQSAI_AVI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 85.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CHEQUE PRE:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntChqPre: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_PRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiChqPre: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQSAI_PRE'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_PRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalChqPre: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHPINI>+<frxResumo."CHQENT_PRE">+<frxResumo."CHQSAI_PRE">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 102.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ORDEM DE PAGAMENTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntOrdPag: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiOrdPag: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ORDSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalOrdPag: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<ORDINI>+<frxResumo."ORDENT">+<frxResumo."ORDSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 119.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CARTAO DE CREDITO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntCarCre: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CARENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiCarCre: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CARSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalCarCre: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CARINI>+<frxResumo."CARENT">+<frxResumo."CARSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 170.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OUTROS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntOutros: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'OUTENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiOutros: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalOutros: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."OUTENT">+<frxResumo."OUTSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 204.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntTotA: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."OUTENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."FINENT">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSaiTotA: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."OUTSAI">+'
            '<frxResumo."PIXSAI">+'
            '<frxResumo."FINSAI">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalTotalA: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."OUTENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."OUTSAI">+'
            '<frxResumo."PIXSAI">+'
            '<SALINI>]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllOutIni: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalIniResA: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SALINI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo150: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[DININI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo153: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHAINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo158: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHPINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo159: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo160: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CARINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 153.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FINANCIAMENTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[FININI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<FININI>+<frxResumo."FINENT">+<frxResumo."FINSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo526: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 136.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Memo.UTF8W = (
            'PIX:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo527: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."PIXENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo528: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."PIXSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo529: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<PIXINI>+<frxResumo."PIXENT">+<frxResumo."PIXSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo530: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[PIXINI]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbMotDes: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 1564.800000000000000000
        OnBeforePrint = 'rlbMotDesOnBeforePrint'
        object rllTitMotDerc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MOTIVO DO DESCONTO:')
          TruncOutboundText = False
        end
        object rdbMotDes: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 1344.000000000000000000
          Height = 17.000000000000000000
          DataField = 'MOTDES'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOTDES"]')
          TruncOutboundText = False
        end
      end
      object rlbTotGeral: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 680.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.childOperacoesA
        object DMPMemo13: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotValGer: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbSaldoGer: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoGerOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbChqs: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 493.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.rlbMotDes
        object SubRepChqs: TfrxSubreport
          Left = 9.600000000000000000
          Width = 1526.400000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.qckPaginaC
        end
      end
      object ChildTroFpg: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 459.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.rlbChqs
        object DMPMemo209: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORMA DE PAGAMENTO ANTERIOR:')
          TruncOutboundText = False
        end
        object DMPMemo210: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TRODIN"]')
          TruncOutboundText = False
        end
        object DMPMemo211: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROCAR"]')
          TruncOutboundText = False
        end
        object DMPMemo212: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROCHQ"]')
          TruncOutboundText = False
        end
        object DMPMemo213: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo531: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROORD"]')
          TruncOutboundText = False
        end
        object DMPMemo532: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TROPIX"]')
          TruncOutboundText = False
        end
      end
      object ChildCancelados: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 1343.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.ChildPG
        PrintChildIfInvisible = True
        Stretched = True
        object rllQdeCanA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'QUANTIDADE DE DOCS CANCELADOS:..................................' +
              '..')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbQdeCanA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[QTDCAN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVlrCanA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VALOR TOTAL DOS DOCS CANCELADOS:................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVlrCanA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCAN]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildPG: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1411.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.Child3
        PrintChildIfInvisible = True
        Stretched = True
        object mmoTitPg1A: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitPg1AOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'TOTAL DE PG :...........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoValPg1A: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoValPg1AOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTPAG]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childCabInformA: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 986.000000000000000000
        Width = 1564.800000000000000000
        OnBeforePrint = 'childCabInformOnBeforePrint'
        Child = frxRelRcxResumoCaixaM.childFpgVenPraA
        PrintChildIfInvisible = True
        object DMPMemo218: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS INFORMATIVOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFaturadoA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FATURADO:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo220: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCONTO:....................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo221: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 85.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'JUROS:..........................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenPraA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 119.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VENDAS A PRAZO:..............................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenPreEntA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VENENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VENENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDescontoA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALDES"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllJurosA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALJUR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenPraA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPRA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childFpgVenPraA: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1139.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.childTotVenVisA
        PrintChildIfInvisible = True
        object subVenPraA: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page1
        end
      end
      object childRodInformA: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 1258.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.ChildCancelados
        PrintChildIfInvisible = True
        Stretched = True
        object rllTroDevA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'TROCAS E DEVOLUCOES:........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbTroDevA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[TRODEV]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenDiaA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VENDAS DO PERIODO:........................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenDiaA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPER]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childFpgVenVisA: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1224.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.childRodInformA
        PrintChildIfInvisible = True
        object subVenVisA: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page2
        end
      end
      object childTotVenVisA: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1173.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.childFpgVenVisA
        PrintChildIfInvisible = True
        Stretched = True
        object rllVenVisA: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'VENDAS A VISTA:............................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenVisA: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[VENVIS]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1887.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.rlbFechamentosA
        PrintChildIfInvisible = True
        object subPagamento: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page5
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 408.000000000000000000
        Top = 1462.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.Child1
        Stretched = True
        object DMPMemo325: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo326: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 85.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo327: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 102.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '...')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo328: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo329: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo330: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo324: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO PROPRIA LOJA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo331: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 187.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'PEDIDO A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo332: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 221.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO FATURADO:................................................' +
              '....')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo333: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 238.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'PEDIDO CARTAO DE CREDITO:.......................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo334: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 187.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo335: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 221.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo336: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 238.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_CAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo337: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 306.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo338: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 340.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo339: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 357.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo340: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 306.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo341: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 340.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo342: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 357.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_CAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo343: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 272.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTREGA PELO CD')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object lblTotalVenda: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 119.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDA .........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object memTotalVenda: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memTotalVendaOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo417: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo419: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FATFRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo420: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CARFRE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object memTotalVendaFreA: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo421: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo425: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA (015-[FORMAPAGAMENTO015]):................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo427: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo428: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo429: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 204.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO A VISTA (015-[FORMAPAGAMENTO015]):.......................' +
              '.........')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo430: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo431: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 323.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA (015-[FORMAPAGAMENTO015]):.....................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo432: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 323.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo543: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 153.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'DESP.ACESSORIA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo544: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_DESACE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object gphTipRec: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1564.800000000000000000
        Condition = 'frxRelatorio_RelRcx."TIPREC"'
        ReprintOnNewPage = True
        object DMPMemo243: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'TIPO DE RECEBIMENTO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo244: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 1286.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."TIPREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object gpfTipRec: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 612.000000000000000000
        Width = 1564.800000000000000000
        object DMPLine12: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo364: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [frxRelatorio_RelRcx."TIPREC"]:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo374: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."DINHEI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo392: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CARREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo393: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQAVI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo394: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."CHQPRE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo395: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."ORDREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo396: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALCRE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo397: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."VALDOC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo398: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo398OnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo535: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio_RelRcx."PIXREC">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object gphMovDia: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 1564.800000000000000000
        Condition = 'frxRelatorio_RelRcx."MOVDIA"'
        object DMPMemo399: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOVDIA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object ChildEstorno: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.ChildTroFpg
        object Memo405: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."MOTEST"]')
          TruncOutboundText = False
        end
      end
      object rlbFechamentosA: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1921.000000000000000000
        Visible = False
        Width = 1564.800000000000000000
        Child = frxRelRcxResumoCaixaM.rlbLacresMalotesA
        object subFechamentos: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page7
        end
      end
      object rlbLacresMalotesA: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1955.000000000000000000
        Width = 1564.800000000000000000
        object subLacresMalotes: TfrxSubreport
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.subLacresMalotesA
        end
      end
    end
    object qckPaginaS: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      LargeDesignHeight = True
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNmEmPs: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorioS: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllOrdemS: TfrxDMPMemoView
          Align = baCenter
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSqFcRxS: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
          TruncOutboundText = False
        end
        object rllOperadorS: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object rllEspecieS: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object rllNmFnPs: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1649.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo82: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetSint)]')
          TruncOutboundText = False
        end
      end
      object childOperacoesS: TfrxChild
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.childCabInformS
        PrintChildIfInvisible = True
        object DMPMemo94: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'OPERACOES')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo95: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo96: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SAIDAS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo97: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO FINAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo102: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DINHEIRO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DINENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DINSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."DINSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo105: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<DININI>+<frxResumo."DINENT">+<frxResumo."DINSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo106: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 68.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CHEQUE A VISTA:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo107: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQENT_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_AVI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo108: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQSAI_AVI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_AVI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo109: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHAINI>+<frxResumo."CHQENT_AVI">+<frxResumo."CHQSAI_AVI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo110: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 85.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CHEQUE PRE:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo111: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQENT_PRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo112: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQSAI_PRE'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CHQSAI_PRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo113: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CHPINI>+<frxResumo."CHQENT_PRE">+<frxResumo."CHQSAI_PRE">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo114: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 102.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ORDEM DE PAGAMENTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo115: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo116: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ORDSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."ORDSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo117: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<ORDINI>+<frxResumo."ORDENT">+<frxResumo."ORDSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo118: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 119.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CARTAO DE CREDITO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo119: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CARENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo120: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CARSAI'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."CARSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo121: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<CARINI>+<frxResumo."CARENT">+<frxResumo."CARSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo122: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 170.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OUTROS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo123: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'OUTENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo124: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."OUTSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo125: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."OUTENT">+<frxResumo."OUTSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo126: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 204.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo127: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINENT">+'
            '<frxResumo."FINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."OUTENT">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo128: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINSAI">+'
            '<frxResumo."FINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."PIXSAI">+'
            '<frxResumo."OUTSAI">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalTotalS: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResumo."DINENT">+'
            '<frxResumo."CHQENT_AVI">+'
            '<frxResumo."CHQENT_PRE">+'
            '<frxResumo."ORDENT">+'
            '<frxResumo."CARENT">+'
            '<frxResumo."OUTENT">+'
            '<frxResumo."PIXENT">+'
            '<frxResumo."DINSAI">+'
            '<frxResumo."CHQSAI_AVI">+'
            '<frxResumo."CHQSAI_PRE">+'
            '<frxResumo."ORDSAI">+'
            '<frxResumo."CARSAI">+'
            '<frxResumo."OUTSAI">+'
            '<frxResumo."PIXSAI">+'
            '<SALINI>]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo98: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalIniResS: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SALINI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo100: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[DININI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo161: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHAINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo162: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CHPINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo163: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo164: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[CARINI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 153.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FINANCIAMENTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[FININI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo130: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo133: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."FINSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo134: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<FININI>+<frxResumo."FINENT">+<frxResumo."FINSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo536: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 136.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          Memo.UTF8W = (
            'PIX:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo537: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."PIXENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo538: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."PIXSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo539: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<PIXINI>+<frxResumo."PIXENT">+<frxResumo."PIXSAI">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo540: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[PIXINI]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 187.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPMemo151: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTOS')
          TruncOutboundText = False
        end
        object DMPMemo152: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object rllSalIniS: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalIniSOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SALDO INICIAL: [SALINI]')
          TruncOutboundText = False
        end
        object DMPMemo318: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo319: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CARTAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo320: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.VISTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo321: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ.PRE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo322: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PAG.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo323: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR.CRED.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo541: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PIX')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetSint: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frxRelatorio_RelRcx
        DataSetName = 'frxRelatorio_RelRcx'
        RowCount = 0
        object DMPMemo154: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            'TOTAL( [frxRelatorio_RelRcx."ESPDOC"] ):')
          TruncOutboundText = False
        end
        object DMPMemo155: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataField = 'VALDOC'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo312: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."DINHEI"]')
          TruncOutboundText = False
        end
        object DMPMemo313: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CARREC"]')
          TruncOutboundText = False
        end
        object DMPMemo314: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQAVI"]')
          TruncOutboundText = False
        end
        object DMPMemo315: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."CHQPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo316: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."ORDREC"]')
          TruncOutboundText = False
        end
        object DMPMemo317: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."VALCRE"]')
          TruncOutboundText = False
        end
        object DMPMemo542: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio_RelRcx."PIXREC"]')
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 323.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.childOperacoesS
        PrintChildIfInvisible = True
        object DMPMemo157: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo156: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo156OnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object ChildCanceladosS: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 1003.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.ChildPGS
        PrintChildIfInvisible = True
        Stretched = True
        object rllQdeCanS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'QUANTIDADE DE DOCS CANCELADOS:..................................' +
              '..')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVlrCanS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VALOR TOTAL DOS DOCS CANCELADOS:................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbQdeCanS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[QTDCAN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVlrCanS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALCAN]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildPGS: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1071.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object mmoTitPg1S: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitPg1SOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'TOTAL DE PG *:..........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoValPg1S: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoValPg1SOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTPAG]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childCabInformS: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 646.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'childCabInformOnBeforePrint'
        Child = frxRelRcxResumoCaixaM.childFpgVenPraS
        PrintChildIfInvisible = True
        object DMPMemo57: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS INFORMATIVOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFaturadoS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FATURADO:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCONTO:....................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 85.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'JUROS:..........................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenPraS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 119.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VENDAS A PRAZO:..............................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenPreEntS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VENENT'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VENENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALDES"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo219: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."VALJUR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenPraS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPRA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childFpgVenPraS: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 799.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.childTotVenVisS
        PrintChildIfInvisible = True
        Stretched = True
        object subVenPraS: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page3
        end
      end
      object childTotVenVisS: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 833.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.childFpgVenVisS
        PrintChildIfInvisible = True
        Stretched = True
        object rllVenVisS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'VENDAS A VISTA:............................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenVisS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[VENVIS]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object childFpgVenVisS: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 884.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.childRodInformS
        PrintChildIfInvisible = True
        Stretched = True
        object subVenVisS: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page4
        end
      end
      object childRodInformS: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 918.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.ChildCanceladosS
        PrintChildIfInvisible = True
        Stretched = True
        object rllTroDevS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'TROCAS E DEVOLUCOES:........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbTroDevS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[TRODEV]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVenDiaS: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VENDAS DO PERIODO:........................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object rlbVenDiaS: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VENPER]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1530.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.rlbFechamentoss
        PrintChildIfInvisible = True
        object subPagamentoS: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page6
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 391.000000000000000000
        Top = 1122.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.Child2
        Stretched = True
        object DMPMemo344: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo345: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 85.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo346: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 102.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = []
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '.....................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo347: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo348: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo349: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo350: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO PROPRIA LOJA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo351: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 170.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'PEDIDO A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo352: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 204.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'PEDIDO FATURADO:................................................' +
              '....')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo353: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 221.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'PEDIDO CARTAO DE CREDITO:.......................................' +
              '.........')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo354: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 170.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo355: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 204.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo356: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 221.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_CAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo357: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 289.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo358: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 323.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA FATURADO:.................................................' +
              '...')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo359: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 340.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              'VENDA CARTAO DE CREDITO:........................................' +
              '.....................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo360: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 289.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo361: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 323.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_FAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo362: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 340.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_CAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo363: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 255.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTREGA PELO CD')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo400: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 119.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDA .........................................')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo401: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'memTotalVendaOnBeforePrint'
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo422: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo423: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_FATFRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo424: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_CARFRE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object memTotalVendaFreB: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo426: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo433: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            
              'VENDA A VISTA (015-[FORMAPAGAMENTO015]):........................' +
              '..')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo434: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo435: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_VISFRE015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo436: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 187.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'PEDIDO A VISTA (015-[FORMAPAGAMENTO015]):......................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo437: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 187.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."PD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo438: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 306.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'VENDA A VISTA (015-[FORMAPAGAMENTO015]):...................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo439: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 306.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."CD_VIS015"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo545: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 153.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            'DESP.ACESSORIA:................................................')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo546: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFat."VD_DESACE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbFechamentoss: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1564.000000000000000000
        Visible = False
        Width = 1507.200000000000000000
        Child = frxRelRcxResumoCaixaM.rlbLacresMalotesS
        Stretched = True
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.Page8
        end
      end
      object rlbLacresMalotesS: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 1598.000000000000000000
        Width = 1507.200000000000000000
        object Subreport2: TfrxSubreport
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelRcxResumoCaixaM.subLacresMalotesS
        end
      end
    end
    object qckPaginaC: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Top = 17.000000000000000000
        Width = 1555.200000000000000000
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 68.000000000000000000
        Width = 1555.200000000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 34.000000000000000000
        Width = 1555.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHQ:')
          TruncOutboundText = False
        end
        object rllNumChq: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 240.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE:')
          TruncOutboundText = False
        end
        object rllEmitente: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NOMEMI'
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA VENC.:')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR:')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          TruncOutboundText = False
        end
        object DMPMemo207: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DIAS CHEQUE:')
          TruncOutboundText = False
        end
        object DMPMemo208: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_DIACHQ"]')
          TruncOutboundText = False
        end
      end
    end
    object qckResumoVendas: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 187.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo70: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESPECIE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.DOCS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VENDAS DO DIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ACUMULADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TICKET MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE VENDAS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'REP(%)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'REP(%)')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 357.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo84: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENDIA">,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">/<fltQtdDia>,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPMemo90: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."VENACU">/<fltQtdDoc>,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPMemo148: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendas."QTDDOC">,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPMemo149: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'QUANTIDADE DE DIAS UTEIS: [(<fltQtdDia>)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00%'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDAS DO DIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 102.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'TOTAL DE VENDAS ACUMULADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo166: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo167: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAviDia]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo165: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltAviAcu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo168: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'A PRAZO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo169: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 102.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'A PRAZO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo170: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltPrzDia]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo171: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 102.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fltPrzAcu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo172: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 68.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo173: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 102.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxResumoVendas
        DataSetName = 'frxResumoVendas'
        RowCount = 0
        object DMPMemo92: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPDOC'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoVendas."ESPDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo93: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDDOC'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."QTDDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDIA'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENDIA"]')
          TruncOutboundText = False
        end
        object DMPMemo129: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VENACU'
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENACU"]')
          TruncOutboundText = False
        end
        object DMPMemo131: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."VENMED"]')
          TruncOutboundText = False
        end
        object DMPMemo132: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendas."TICMED"]')
          TruncOutboundText = False
        end
        object DMPMemo138: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00%'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<fltTotDia> <> 0, (<frxResumoVendas."VENDIA">/<fltTotDia>*1' +
              '00), 0)]')
          TruncOutboundText = False
        end
        object DMPMemo140: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00%'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxResumoVendas."VENACU">/<fltTotAcu>*100)]')
          TruncOutboundText = False
        end
      end
      object PageHeader3: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNmEmRv: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo144: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo146: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPMemo174: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo175: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo176: TfrxDMPMemoView
          Align = baCenter
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo177: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
          TruncOutboundText = False
        end
        object DMPMemo178: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPCommand4: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo179: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
          TruncOutboundText = False
        end
        object DMPMemo180: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object rllNmFnRv: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 544.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo181: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo182: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData2)]')
          TruncOutboundText = False
        end
      end
    end
    object qckPaginaB: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object DETDUP: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frmRelRcxResumoCaixa.frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODCLI'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxDuplicatas."CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataField = 'HISTOR'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxDuplicatas."HISTOR"]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbSaldoOnBeforePrint'
          DataField = 'VALDUP'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDuplicatas."VALDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDuplicatas."CODVEN"]')
          TruncOutboundText = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 136.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUMDUP')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALDUP')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo59: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATAS EMITIDAS NAO BAIXADAS')
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPCommand3: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllOrdemB: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo216: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMFAN'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMFAN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo78: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(DETDUP)]')
          TruncOutboundText = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 255.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo203: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo205: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDuplicatas."VALDUP">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object qckCredito: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader4: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo183: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'RELACAO DE CREDITOS POR PERIODO')
          TruncOutboundText = False
        end
        object DMPMemo184: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPCommand5: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo185: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo186: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo187: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo188: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo217: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMFAN'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen_RelRcx."EMP_NOMFAN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCredito: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxCredito
        DataSetName = 'frxCredito'
        RowCount = 0
        object DMPMemo189: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCredito."NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo190: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCredito."CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo191: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMCLI'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxCredito."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo192: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DESCRI'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxCredito."DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo193: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDUP'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCredito."VALDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo194: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'dtaent'
          DataSet = frmRelRcxResumoCaixa.frxCredito
          DataSetName = 'frxCredito'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCredito."dtaent"]')
          TruncOutboundText = False
        end
      end
      object Header5: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 136.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPMemo195: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUMDUP')
          TruncOutboundText = False
        end
        object DMPMemo196: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo197: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALDUP')
          TruncOutboundText = False
        end
        object DMPMemo198: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          TruncOutboundText = False
        end
        object DMPMemo199: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPMemo200: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo201: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo202: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbCredito)]')
          TruncOutboundText = False
        end
      end
      object ReportSummary3: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 255.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo204: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo206: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxDuplicatas
          DataSetName = 'frxDuplicatas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCredito."VALDUP">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1555.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
        RowCount = 0
        object DMPMemo227: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '   [frxVenPra."DESFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo228: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenPra."VALFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1555.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
        RowCount = 0
        object DMPMemo231: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '   [frxVenVis."DESFPG"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo232: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenVis."VALFPG"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page3: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenPra
        DataSetName = 'frxVenPra'
        RowCount = 0
        object DMPMemo39: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenPra
          DataSetName = 'frxVenPra'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '   [frxVenPra."DESFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumo
          DataSetName = 'frxResumo'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenPra."VALFPG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page4: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxVenVis
        DataSetName = 'frxVenVis'
        RowCount = 0
        object DMPMemo52: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '   [frxVenVis."DESFPG"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxVenVis
          DataSetName = 'frxVenVis'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxVenVis."VALFPG"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object qckResumoEspecie: TfrxDMPPage
      PaperWidth = 414.019732612256000000
      PaperHeight = 202.406119279381300000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader5: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1545.600000000000000000
        object rllNmEmRe: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo136: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo145: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPMemo147: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo137: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo139: TfrxDMPMemoView
          Align = baCenter
          Left = 28.800000000000000000
          Top = 119.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo141: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object rllComando: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo223: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object rllNmFnRe: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1545.600000000000000000
        Child = frxRelRcxResumoCaixaM.Child5
        DataSet = frmRelRcxResumoCaixa.frxResumoEspecies
        DataSetName = 'frxResumoEspecies'
        RowCount = 0
        object rllNomPortador: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxResumoEspecies."RCX_ESPDOC"]')
          TruncOutboundText = False
        end
        object rllVis001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS001"]')
          TruncOutboundText = False
        end
        object rllVis002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS002"]')
          TruncOutboundText = False
        end
        object rllVis003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS003"]')
          TruncOutboundText = False
        end
        object rllVis004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS004"]')
          TruncOutboundText = False
        end
        object rllVis005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS005"]')
          TruncOutboundText = False
        end
        object rllVis006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS006"]')
          TruncOutboundText = False
        end
        object rllTotVis: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTVIS"]')
          TruncOutboundText = False
        end
        object rllVis007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS007"]')
          TruncOutboundText = False
        end
        object rllVis008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS008"]')
          TruncOutboundText = False
        end
        object rllVis009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS009"]')
          TruncOutboundText = False
        end
        object rllVis010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."VIS010"]')
          TruncOutboundText = False
        end
        object DMPMemo229: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A VISTA')
          TruncOutboundText = False
        end
        object DMPMemo241: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo253: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCONTOS')
          TruncOutboundText = False
        end
        object rllJvs001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS001"]')
          TruncOutboundText = False
        end
        object rllJvs002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS002"]')
          TruncOutboundText = False
        end
        object rllJvs003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS003"]')
          TruncOutboundText = False
        end
        object rllJvs004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS004"]')
          TruncOutboundText = False
        end
        object rllJvs005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS005"]')
          TruncOutboundText = False
        end
        object rllJvs006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS006"]')
          TruncOutboundText = False
        end
        object rllTotJvs: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTJVS"]')
          TruncOutboundText = False
        end
        object rllJvs007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS007"]')
          TruncOutboundText = False
        end
        object rllJvs008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS008"]')
          TruncOutboundText = False
        end
        object rllJvs009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS009"]')
          TruncOutboundText = False
        end
        object rllJvs010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JVS010"]')
          TruncOutboundText = False
        end
        object rllDvs001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS001"]')
          TruncOutboundText = False
        end
        object rllDvs002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS002"]')
          TruncOutboundText = False
        end
        object rllDvs003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS003"]')
          TruncOutboundText = False
        end
        object rllDvs004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS004"]')
          TruncOutboundText = False
        end
        object rllDvs005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS005"]')
          TruncOutboundText = False
        end
        object rllDvs006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS006"]')
          TruncOutboundText = False
        end
        object rllTotDvs: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTDVS"]')
          TruncOutboundText = False
        end
        object rllDvs007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS007"]')
          TruncOutboundText = False
        end
        object rllDvs008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS008"]')
          TruncOutboundText = False
        end
        object rllDvs009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS009"]')
          TruncOutboundText = False
        end
        object rllDvs010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DVS010"]')
          TruncOutboundText = False
        end
      end
      object PageFooter5: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1545.600000000000000000
        object DMPMemo222: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo225: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Header6: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 187.000000000000000000
        Width = 1545.600000000000000000
        ReprintOnNewPage = True
        object rllLinha1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
        object rllLinha2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
        object DMPMemo226: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ESPECIE')
          TruncOutboundText = False
        end
        object rllLoja1: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja2: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja3: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja4: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja5: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja6: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja7: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja8: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja9: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllLoja10: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object rllTotal: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo143: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
      end
      object ReportSummary4: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 1545.600000000000000000
        object DMPMemo230: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL')
          TruncOutboundText = False
        end
        object rllLinha3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
        object rllTotalGeral: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotLoj010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 323.000000000000000000
        Width = 1545.600000000000000000
        object DMPMemo266: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxResumoEspecies."RCX_ESPDOC"]')
          TruncOutboundText = False
        end
        object rllPra001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA001"]')
          TruncOutboundText = False
        end
        object rllPra002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA002"]')
          TruncOutboundText = False
        end
        object rllPra003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA003"]')
          TruncOutboundText = False
        end
        object rllPra004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA004"]')
          TruncOutboundText = False
        end
        object rllPra005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA005"]')
          TruncOutboundText = False
        end
        object rllPra006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA006"]')
          TruncOutboundText = False
        end
        object rllTotPra: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTPRA"]')
          TruncOutboundText = False
        end
        object rllPra007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA007"]')
          TruncOutboundText = False
        end
        object rllPra008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA008"]')
          TruncOutboundText = False
        end
        object rllPra009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA009"]')
          TruncOutboundText = False
        end
        object rllPra010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."PRA010"]')
          TruncOutboundText = False
        end
        object DMPMemo278: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A PRAZO')
          TruncOutboundText = False
        end
        object DMPMemo279: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo280: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCONTOS')
          TruncOutboundText = False
        end
        object rllJpr001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR001"]')
          TruncOutboundText = False
        end
        object rllJpr002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR002"]')
          TruncOutboundText = False
        end
        object rllJpr003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR003"]')
          TruncOutboundText = False
        end
        object rllJpr004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR004"]')
          TruncOutboundText = False
        end
        object rllJpr005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR005"]')
          TruncOutboundText = False
        end
        object rllJpr006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR006"]')
          TruncOutboundText = False
        end
        object rllTotJpr: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTJPR"]')
          TruncOutboundText = False
        end
        object rllJpr007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR007"]')
          TruncOutboundText = False
        end
        object rllJpr008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR008"]')
          TruncOutboundText = False
        end
        object rllJpr009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR009"]')
          TruncOutboundText = False
        end
        object rllJpr010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."JPR010"]')
          TruncOutboundText = False
        end
        object rllDpr001: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR001"]')
          TruncOutboundText = False
        end
        object rllDpr002: TfrxDMPMemoView
          Tag = 3
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR002"]')
          TruncOutboundText = False
        end
        object rllDpr003: TfrxDMPMemoView
          Tag = 3
          Left = 547.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR003"]')
          TruncOutboundText = False
        end
        object rllDpr004: TfrxDMPMemoView
          Tag = 3
          Left = 652.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR004"]')
          TruncOutboundText = False
        end
        object rllDpr005: TfrxDMPMemoView
          Tag = 3
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR005"]')
          TruncOutboundText = False
        end
        object rllDpr006: TfrxDMPMemoView
          Tag = 3
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR006"]')
          TruncOutboundText = False
        end
        object rllTotDpr: TfrxDMPMemoView
          Tag = 1
          Left = 1392.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."TOTDPR"]')
          TruncOutboundText = False
        end
        object rllDpr007: TfrxDMPMemoView
          Tag = 3
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR007"]')
          TruncOutboundText = False
        end
        object rllDpr008: TfrxDMPMemoView
          Tag = 3
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR008"]')
          TruncOutboundText = False
        end
        object rllDpr009: TfrxDMPMemoView
          Tag = 3
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR009"]')
          TruncOutboundText = False
        end
        object rllDpr010: TfrxDMPMemoView
          Tag = 3
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoEspecies."DPR010"]')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1526.400000000000000000
          Color = clBlack
        end
      end
    end
    object qckResumoFpg: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 10.159993438337600000
      RightMargin = 10.159993438337600000
      TopMargin = 8.995827523528060000
      BottomMargin = 8.995827523528060000
      FontStyle = []
      object PageHeader6: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1449.600000000000000000
        object rllNmEmRf: TfrxDMPMemoView
          Align = baCenter
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo66: TfrxDMPMemoView
          Align = baCenter
          Left = 393.600000000000000000
          Top = 51.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo67: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Memo70: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Memo75: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object Memo76: TfrxDMPMemoView
          Align = baCenter
          Left = 249.600000000000000000
          Top = 119.000000000000000000
          Width = 950.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo80: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
          TruncOutboundText = False
        end
        object Memo84: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object Memo86: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
          TruncOutboundText = False
        end
        object Memo87: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object rllNmFnRf: TfrxDMPMemoView
          Align = baCenter
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand6: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
      end
      object Header7: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 204.000000000000000000
        Width = 1449.600000000000000000
        object Memo237: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TRANSFERENCIAS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo242: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. DE TITULOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo243: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'FORMA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo244: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO INICIAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo245: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VENDAS A VISTA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo246: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'PAGAMENTOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo247: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'OUTROS PAG')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo248: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Top = 51.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO FINAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo249: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1430.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR FORMA DE PAGAMENTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'OUTROS REC')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer3: TfrxFooter
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 357.000000000000000000
        Width = 1449.600000000000000000
        object Memo253: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo254: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VENAVI">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo255: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."PAGAME">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo256: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."OUTROS">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo257: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VALINI">,MasterData7) + '
            ' SUM(<frxResumoFpg."VENAVI">,MasterData7) + '
            ' SUM(<frxResumoFpg."VENPRA">,MasterData7) +'
            ' SUM(<frxResumoFpg."OUTREC">,MasterData7) +'
            ' SUM(<frxResumoFpg."PAGAME">,MasterData7) +'
            ' SUM(<frxResumoFpg."TRANSF">,MasterData7) +'
            ' SUM(<frxResumoFpg."OUTROS">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo258: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VALINI">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo259: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."VENPRA">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo260: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."TRANSF">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo304: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'UTILIZACAO CRED. (INFORMATIVO)')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo305: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo306: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo307: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo308: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo309: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo310: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ABS(SUM(<frxResumoFpg."VALCRE">,MasterData7))]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo311: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo142: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoFpg."OUTREC">,MasterData7)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo214: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object MasterData7: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1449.600000000000000000
        DataSet = frmRelRcxResumoCaixa.frxResumofPG
        DataSetName = 'frxResumoFpg'
        RowCount = 0
        object DMPMemo233: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxResumoFpg."FORMA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo234: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VENAVI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo235: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."PAGAME"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo236: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."OUTROS"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo237: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxResumoFpg."VALINI"> + <frxResumoFpg."VENAVI"> + <frxResumoF' +
              'pg."VENPRA"> + <frxResumoFpg."OUTREC"> + <frxResumoFpg."PAGAME">' +
              ' + '
            ' <frxResumoFpg."TRANSF"> + <frxResumoFpg."OUTROS">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo238: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VALINI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo239: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."VENPRA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo240: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."TRANSF"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo135: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFpg."OUTREC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object PageFooter6: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 782.000000000000000000
        Width = 1449.600000000000000000
        object Memo279: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object Memo280: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData7) + COUNT(MasterData9)]')
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 527.000000000000000000
        Width = 1449.600000000000000000
        Condition = 'frxDetOutrosFpg."FORMA"'
        ReprintOnNewPage = True
        object DMPMemo404: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 825.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo405: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo406: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'HORA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo407: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESP')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo409: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo410: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDetOutrosFpg."FORMA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object MasterData9: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 612.000000000000000000
        Width = 1449.600000000000000000
        DataSet = frmRelRcxResumoCaixa.frxDetOutrosFpg
        DataSetName = 'frxDetOutrosFpg'
        RowCount = 0
        object DMPMemo403: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 825.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."DESCRICAO"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo408: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."DATA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo411: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxDetOutrosFpg."HORA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo412: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDetOutrosFpg."ESPECIE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo413: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDetOutrosFpg."VALOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 663.000000000000000000
        Width = 1449.600000000000000000
        HideIfSingleDataRecord = True
        object DMPMemo415: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1123.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo418: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDetOutrosFpg."VALOR">,MasterData9)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Header9: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1449.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo402: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEMONSTRATIVO ANAL'#205'TICO DE OUTROS PAGAMENTOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer5: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 714.000000000000000000
        Width = 1449.600000000000000000
        object DMPMemo414: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1123.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          FontStyle = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DE OUTROS PAGAMENTOS')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo416: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmRelRcxResumoCaixa.frxResumoVendas
          DataSetName = 'frxResumoVendas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDetOutrosFpg."VALOR">,MasterData9,2)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object qckListVenPraz: TfrxDMPPage
      PaperWidth = 279.399819554283200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader7: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1036.800000000000000000
        object DMPMemo242: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 51.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNmFnLv: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNmEmLv: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = []
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo245: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPMemo246: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo247: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo248: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 119.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo249: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[SQFCRX]')
          TruncOutboundText = False
        end
        object DMPMemo250: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPMemo251: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 102.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[VISUALI]')
          TruncOutboundText = False
        end
        object DMPMemo252: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 85.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
        object DMPCommand7: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo254: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DTA. EMI.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo255: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 136.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo256: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 136.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo257: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VEN.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo258: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 136.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'COND. PAGTO.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo259: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. DOC.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Header8: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1036.800000000000000000
      end
      object Footer4: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1036.800000000000000000
        object DMPMemo260: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo261: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxListVenPraz."GER_VLRCON">,MasterData8)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter7: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 1036.800000000000000000
        object DMPMemo262: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo263: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData8)]')
          TruncOutboundText = False
        end
      end
      object MasterData8: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 255.000000000000000000
        Width = 1036.800000000000000000
        DataSet = frmRelRcxResumoCaixa.frxListVenPraz
        DataSetName = 'frxListVenPraz'
        RowCount = 0
        Stretched = True
        object DMPMemo264: TfrxDMPMemoView
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_DTADOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo265: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo267: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CODCLI"]-[frxListVenPraz."CLI_NOMCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo268: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CODVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo269: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxListVenPraz."GER_CONPAG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo270: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmRelRcxResumoCaixa.frxResumofPG
          DataSetName = 'frxResumoFpg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxListVenPraz."GER_VLRCON"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page5: TfrxDMPPage
      Visible = False
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabPagamento: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine8: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo271: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DETALHAMENTO DE PAGAMENTOS')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbPagamento: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 68.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
        RowCount = 0
        object DMPMemo272: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo273: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DUPLICATA:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo274: TfrxDMPMemoView
          Left = 326.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo275: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_PARCEL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo276: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo277: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMP.:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo281: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo282: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'SERIE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo283: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_SERIE_"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo284: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo285: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORNEC.:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo286: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo287: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo302: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxPagamento."CTP_VALORI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo215: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1526.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo215OnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO:[frxPagamento."CTP_HIST01"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page6: TfrxDMPPage
      Visible = False
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabPagamentoS: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo288: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DETALHAMENTO DE PAGAMENTOS')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbPagamentoS: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 68.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxPagamento
        DataSetName = 'frxPagamento'
        RowCount = 0
        object DMPMemo289: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo290: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DUPLICATA:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo291: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo292: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_PARCEL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo293: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo294: TfrxDMPMemoView
          Left = 345.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMP.:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo295: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo296: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'SERIE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo297: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_SERIE_"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo298: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            ' -')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo299: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORNEC.:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo300: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo301: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxPagamento."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo303: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxPagamento."CTP_VALORI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo224: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1478.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo224OnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            'DESCRICAO: [frxPagamento."CTP_HIST01"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object qckDupJus: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabDupJus: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1555.200000000000000000
        object rllNmEmDj: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo365: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object DMPMemo366: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object DMPMemo367: TfrxDMPMemoView
          Left = 1468.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo368: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo369: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 68.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNmFnDj: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo370: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo371: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DTA. VEN.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo372: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DTA. REC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo373: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo375: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FORMA PAG.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo376: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. ORIG.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo377: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo378: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. REC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo379: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'JUSTIFICATIVA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1545.600000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1545.600000000000000000
          Color = clBlack
        end
        object DMPMemo391: TfrxDMPMemoView
          Align = baCenter
          Left = 547.200000000000000000
          Top = 85.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATAS COM JUSTIFICATIVA DE DESCONTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand8: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
      end
      object rlbDetDupJus: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1555.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxDupJus
        DataSetName = 'frxDupJus'
        RowCount = 0
        object DMPMemo380: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDupJus."NUMDUP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo381: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDupJus."DTAVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo382: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDupJus."DTAREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo383: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDupJus."CODCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCodFpg: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllCodFpgOnBeforePrint'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo384: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALORI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo385: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALDES"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo386: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDupJus."VALREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo387: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '%')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo388: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1536.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDupJus."JUSDES"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter8: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Width = 1555.200000000000000000
        object DMPMemo389: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen_RelRcx
          DataSetName = 'frxGen_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen_RelRcx."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo390: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetDupJus)]')
          TruncOutboundText = False
        end
      end
    end
    object Page7: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      LargeDesignHeight = True
      FontStyle = []
      object rlbHeaderFechamentos: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1564.800000000000000000
        object DMPLine13: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo440: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LISTAGEM DE FECHAMENTOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo442: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo443: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DINHEIRO')
          TruncOutboundText = False
        end
        object DMPMemo444: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo445: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.VISTA')
          TruncOutboundText = False
        end
        object DMPMemo446: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.PRE')
          TruncOutboundText = False
        end
        object DMPMemo447: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ORD.PAG.')
          TruncOutboundText = False
        end
        object DMPMemo449: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo450: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA LANC.')
          TruncOutboundText = False
        end
        object DMPMemo451: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPLine15: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo453: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDadosFechamento: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1564.800000000000000000
        DataSet = frmRelRcxResumoCaixa.frxFechamentos
        DataSetName = 'frxFechamentos'
        RowCount = 0
        object DMPMemo448: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo452: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DINREC"]')
          TruncOutboundText = False
        end
        object DMPMemo454: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CARREC"]')
          TruncOutboundText = False
        end
        object DMPMemo455: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQAVI"]')
          TruncOutboundText = False
        end
        object DMPMemo456: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo457: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_ORDREC"]')
          TruncOutboundText = False
        end
        object DMPMemo458: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTAGRV"]')
          TruncOutboundText = False
        end
        object DMPMemo459: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_VALDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo460: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo462: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CODOPE"]')
          TruncOutboundText = False
        end
      end
    end
    object Page8: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      LargeDesignHeight = True
      FontStyle = []
      object Header10: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine14: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo441: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LISTAGEM DE FECHAMENTOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo461: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo463: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DINHEIRO')
          TruncOutboundText = False
        end
        object DMPMemo464: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo465: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.VISTA')
          TruncOutboundText = False
        end
        object DMPMemo466: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.PRE')
          TruncOutboundText = False
        end
        object DMPMemo467: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ORD.PAG.')
          TruncOutboundText = False
        end
        object DMPMemo468: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo469: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA/HORA LANC.')
          TruncOutboundText = False
        end
        object DMPMemo470: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPLine16: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo471: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData10: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frmRelRcxResumoCaixa.frxFechamentos
        DataSetName = 'frxFechamentos'
        RowCount = 0
        object DMPMemo472: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo473: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DINREC"]')
          TruncOutboundText = False
        end
        object DMPMemo474: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CARREC"]')
          TruncOutboundText = False
        end
        object DMPMemo475: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQAVI"]')
          TruncOutboundText = False
        end
        object DMPMemo476: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CHQPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo477: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_ORDREC"]')
          TruncOutboundText = False
        end
        object DMPMemo478: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTAGRV"]')
          TruncOutboundText = False
        end
        object DMPMemo479: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFechamentos."RCX_VALDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo480: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxFechamentos."RCX_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo481: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          Memo.UTF8W = (
            '[frxFechamentos."RCX_CODOPE"]')
          TruncOutboundText = False
        end
      end
    end
    object subLacresMalotesA: TfrxDMPPage
      PaperWidth = 416.559730971840400000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      LargeDesignHeight = True
      FontStyle = []
      object Header11: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1564.799999993044000000
        object DMPLine17: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo482: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LISTAGEM DE TRANSFERENCIAS POR LACRES')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo483: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NUM. LACRE')
          TruncOutboundText = False
        end
        object DMPMemo484: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DINHEIRO')
          TruncOutboundText = False
        end
        object DMPMemo485: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo486: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.VISTA')
          TruncOutboundText = False
        end
        object DMPMemo487: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.PRE')
          TruncOutboundText = False
        end
        object DMPMemo488: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ORD.PAG.')
          TruncOutboundText = False
        end
        object DMPMemo489: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo490: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FUNDO CAIXA')
          TruncOutboundText = False
        end
        object DMPMemo491: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPLine18: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo492: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData11: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1564.799999993044000000
        DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
        DataSetName = 'frxLacresMalotes'
        RowCount = 0
        object DMPMemo493: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_NUMLAC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_NUMLAC"]')
          TruncOutboundText = False
        end
        object DMPMemo494: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_DINREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DINREC"]')
          TruncOutboundText = False
        end
        object DMPMemo495: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CARREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CARREC"]')
          TruncOutboundText = False
        end
        object DMPMemo496: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CHQAVI'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQAVI"]')
          TruncOutboundText = False
        end
        object DMPMemo497: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CHQPRE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo498: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_ORDREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_ORDREC"]')
          TruncOutboundText = False
        end
        object DMPMemo499: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_FUNCAX'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_FUNCAX"]')
          TruncOutboundText = False
        end
        object DMPMemo500: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_VALDOC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_VALDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo501: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_DTACAD'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo502: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CODOPE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CODOPE"]')
          TruncOutboundText = False
        end
      end
    end
    object subLacresMalotesS: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      LargeDesignHeight = True
      FontStyle = []
      object Header12: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.199999985190000000
        object DMPLine19: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo503: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LISTAGEM DE TRANSFERENCIAS POR LACRES')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo504: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NUM. LACRE')
          TruncOutboundText = False
        end
        object DMPMemo505: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'DINHEIRO')
          TruncOutboundText = False
        end
        object DMPMemo506: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo507: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.VISTA')
          TruncOutboundText = False
        end
        object DMPMemo508: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHQ.PRE')
          TruncOutboundText = False
        end
        object DMPMemo509: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'ORD.PAG.')
          TruncOutboundText = False
        end
        object DMPMemo510: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPMemo511: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FUNDO CAIXA')
          TruncOutboundText = False
        end
        object DMPMemo512: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          TruncOutboundText = False
        end
        object DMPLine20: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1536.000000000000000000
          Color = clBlack
        end
        object DMPMemo513: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio_RelRcx
          DataSetName = 'frxRelatorio_RelRcx'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'OPE.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData12: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1507.199999985190000000
        DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
        DataSetName = 'frxLacresMalotes'
        RowCount = 0
        object DMPMemo514: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_NUMLAC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_NUMLAC"]')
          TruncOutboundText = False
        end
        object DMPMemo515: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_DINREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DINREC"]')
          TruncOutboundText = False
        end
        object DMPMemo516: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CARREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CARREC"]')
          TruncOutboundText = False
        end
        object DMPMemo517: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CHQAVI'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQAVI"]')
          TruncOutboundText = False
        end
        object DMPMemo518: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CHQPRE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CHQPRE"]')
          TruncOutboundText = False
        end
        object DMPMemo519: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_ORDREC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_ORDREC"]')
          TruncOutboundText = False
        end
        object DMPMemo520: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_FUNCAX'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_FUNCAX"]')
          TruncOutboundText = False
        end
        object DMPMemo521: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_VALDOC'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_VALDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo522: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_DTACAD'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo523: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RCX_CODOPE'
          DataSet = frmRelRcxResumoCaixa.frxLacresMalotes
          DataSetName = 'frxLacresMalotes'
          Memo.UTF8W = (
            '[frxLacresMalotes."RCX_CODOPE"]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxTermoFechamento: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 43879.462112222200000000
    ReportOptions.LastChange = 43880.602512581020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 240
    Top = 24
    Datasets = <
      item
        DataSet = frxDataSetEmpresa
        DataSetName = 'frxDataSetEmpresa'
      end
      item
        DataSet = frxDataSetFechamentoCaixa
        DataSetName = 'frxDataSetFechamentoCaixa'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'VS_Date'
        Value = #39'19/02/2020'#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'001'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = #39'C:\NFE\CITEL.BMP'#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = #39'001_002_003_004_005_007_006_'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'998'#39
      end>
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
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 165.992270000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          Left = -3.779530000000000000
          Top = 127.047310000000000000
          Width = 718.110700000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Diverg'#234'ncia de Valores')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 419.527830000000000000
          Top = 102.826840000000000000
          Width = 298.582870000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - [TIME]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo6: TfrxMemoView
          Align = baCenter
          Left = 158.740260000000000000
          Top = 5.472480000000001000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDataSetEmpresa
          DataSetName = 'frxDataSetEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetEmpresa."EMP_CODEMP"]-[frxDataSetEmpresa."EMP_NOMEMP"' +
              ']')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baCenter
          Left = 198.425325000000000000
          Top = 38.165430000000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          DataField = 'EMP_ENDERE'
          DataSet = frxDataSetEmpresa
          DataSetName = 'frxDataSetEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSetEmpresa."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baCenter
          Left = 298.582870000000000000
          Top = 22.472480000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'EMP_FONE01'
          DataSet = frxDataSetEmpresa
          DataSetName = 'frxDataSetEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSetEmpresa."EMP_FONE01"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baCenter
          Left = 198.425325000000000000
          Top = 56.196969999999990000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          DataSet = frxDataSetEmpresa
          DataSetName = 'frxDataSetEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetEmpresa."EMP_NOMCID"] - [frxDataSetEmpresa."EMP_ESTAD' +
              'O"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 241.889920000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Top = 14.811070000000000000
          Width = 718.110700000000000000
          Height = 90.708720000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ''
            
              'Eu, [frxDataSetFechamentoCaixa."RCX_NOMOPE"], estou ciente que o' +
              ' caixa do dia [frxDataSetFechamentoCaixa."RCX_DTACAD"] est'#225' send' +
              'o fechado com diverg'#234'ncias de valores, podendo sofrer confer'#234'nci' +
              'a futura e aplicadas as regras internas da empresa quanto ao pro' +
              'cedimento.')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 177.637910000000000000
          Top = 159.283550000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 154.960730000000000000
          Top = 184.433210000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetFechamentoCaixa."RCX_CODOPE"]-[frxDataSetFechamentoCa' +
              'ixa."RCX_NOMOPE"] ')
          ParentFont = False
        end
        object mmExibeValorDiv: TfrxMemoView
          Left = 0.833333330000000000
          Top = 116.292516670000000000
          Width = 410.630180000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 510.236550000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxDataSetEmpresa: TfrxDBDataset
    UserName = 'frxDataSetEmpresa'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 88
  end
  object frxDataSetFechamentoCaixa: TfrxDBDataset
    UserName = 'frxDataSetFechamentoCaixa'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 144
  end
  object frxTermoFechamento40c: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 43879.497607280100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 368
    Top = 24
    Datasets = <
      item
        DataSet = frxDataSetEmpresa
        DataSetName = 'frxDataSetEmpresa'
      end
      item
        DataSet = frxDataSetFechamentoCaixa
        DataSetName = 'frxDataSetFechamentoCaixa'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'VS_Date'
        Value = #39'19/02/2020'#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'001'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = #39'C:\NFE\CITEL.BMP'#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = #39'001_002_003_004_005_007_006_'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'998'#39
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
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetEmpresa."EMP_CODEMP"]-[frxDataSetEmpresa."EMP_NOMEMP"' +
              ']')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSetEmpresa."EMP_FONE01"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataSetEmpresa."EMP_ENDERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetEmpresa."EMP_NOMCID"] - [frxDataSetEmpresa."EMP_ESTAD' +
              'O"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baRight
          Left = 192.000000000000000000
          Top = 102.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATE]-[TIME]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 153.000000000000000000
        Width = 384.000000000000000000
        Child = frxTermoFechamento40c.ChildRodape
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERGENCIA DE VALORES')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 355.200000000000000000
          Height = 136.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Eu, [frxDataSetFechamentoCaixa."RCX_NOMOPE"], '
            'estou ciente que o caixa do dia '
            '[frxDataSetFechamentoCaixa."RCX_DTACAD"] esta sendo fechado com '
            'divergencias de valores,podendo '
            'sofrer conferencia futura e aplicadas '
            'as regras internas da empresa quanto ao '
            'procedimento.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmExibeValorDiv: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 408.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object rllSalto: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 68.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baCenter
          Left = 62.400000000000000000
          Top = 42.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[frxDataSetFechamentoCaixa."RCX_CODOPE"]-[frxDataSetFechamentoCa' +
              'ixa."RCX_NOMOPE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorio_RelRcx: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio_RelRcx'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 368
    Top = 72
  end
  object frxGen_RelRcx: TfrxUserDataSet
    UserName = 'frxGen_RelRcx'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 368
    Top = 128
  end
end
