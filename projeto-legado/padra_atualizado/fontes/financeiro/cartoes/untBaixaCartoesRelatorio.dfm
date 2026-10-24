object frmBaixaCartoesRelatorio: TfrmBaixaCartoesRelatorio
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'frmBaixaCartoesRelatorio'
  ClientHeight = 336
  ClientWidth = 735
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45847.467121284700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValDif: Double;'
      '  fltValNEn: Double;'
      '  fltValRcx: Double;'
      '  fltValBai: Double;'
      '  fltValRot: Double;'
      '  fltValPar: Double;'
      '  fltValDeb: Double;'
      '  fltVal_PV: Double;'
      '  fltTotDif: Double;'
      '  fltTotNEn: Double;'
      '  fltTotRcx: Double;'
      '  fltTotBai: Double;'
      '  fltTotRot: Double;'
      '  fltTotPar: Double;'
      '  fltTotDeb: Double;      '
      '  intQtdDif: Integer;'
      '  intQtdNEn: Integer;'
      '  intQtdRcx: Integer;'
      '  intQtdBai: Integer;'
      '  intQtdRot: Integer;'
      '  intQtdPar: Integer;'
      '  intQtdDeb: Integer;          '
      '  intQtd_PV: Integer;'
      '  intTotDif: Integer;'
      '  intTotNEn: Integer;'
      '  intTotRcx: Integer;'
      '  intTotBai: Integer;'
      '  intTotRot: Integer;'
      '  intTotPar: Integer;'
      '  intTotDeb: Integer;'
      '  intQtdNCa: Integer;'
      '  intQtdVDi: Integer;'
      '  intQtdAnt: Integer;'
      
        '  intQtdMan: Integer;                                           ' +
        '    '
      '  fltTotGer: Double;'
      '  intTotAnt: Integer;'
      '  fltValNCa: Double;'
      '  fltValVDi: Double;'
      '  fltValAnt: Double;   '
      '  fltLiq_PV: Double;       '
      '  fltValTip: Double;'
      '  fltValInc: Double;'
      '  fltValMan: Double;      '
      '  fltLiqInc: Double;'
      '  fltLiqTip: Double;'
      '  fltLValDif: Double;  '
      '  fltLValNEn: Double;  '
      '  fltLValRcx: Double;  '
      '  fltLValBai: Double;  '
      '  fltLValRot: Double;  '
      '  fltLValPar: Double;'
      '  fltLValDeb: Double;  '
      '  fltLValAnt: Double;'
      '  fltLValMan: Double;      '
      '  intTotIncon: Integer;'
      '  intQtdTotCon: Integer;'
      '  intQtdTotMan: Integer;      '
      '  fltBruIncon: Double;'
      '  fltLiqIncon: Double;'
      '  fltBruCanPV: Double;'
      '  fltLiqCanPV: Double;'
      '  fltValTotCon: Double;'
      '  fltValTotMan: Double;'
      '  fltLiqTotCon: Double;'
      '  fltLiqTotMan: Double;'
      ''
      '  intQtdInconsistentePIX: Integer;'
      '  fltBrutoInconsistentePIX: Double;'
      '  fltLiquidoInconsistentePIX: Double;'
      ''
      '  intQtdInconsistenteBoleto: Integer;'
      '  fltBrutoInconsistenteBoleto: Double;'
      '  fltLiquidoInconsistenteBoleto: Double;        '
      ''
      '  fltValorTransferencia: Double;'
      ''
      '  FFiltroPrincipal: String;'
      ''
      '  FWidthNumeroNSU: Double;'
      '  FLeftParcela: Double;'
      '  FWidthAutorizacao: Double;'
      '  FLeftResumoVenda: Double;        '
      ''
      '  fltValorNegociacao: Double;      '
      ''
      '  intQtdDifDtaPag: Integer;'
      '  intQtdNEnDtaPag: Integer;'
      '  intQtdRcxDtaPag: Integer;'
      '  intQtdBaiDtaPag: Integer;'
      '  intQtdManDtaPag: Integer;'
      '  intQtdRotDtaPag: Integer;'
      '  intQtdParDtaPag: Integer;'
      '  intQtdAntDtaPag: Integer;'
      '  intQtdDebDtaPag: Integer;'
      '  intQtdDtaPag: Integer;'
      '  intQtdInconsistentePIXDtaPag: Integer;'
      '  intQtdInconsistenteBoletoDtaPag: Integer;'
      '  fltValDifDtaPag: Double;'
      '  fltValNEnDtaPag: Double;'
      '  fltValRcxDtaPag: Double;'
      '  fltValBaiDtaPag: Double;'
      '  fltValManDtaPag: Double; '
      '  fltValRotDtaPag: Double;'
      '  fltValParDtaPag: Double;'
      '  fltValDebDtaPag: Double;'
      '  fltValAntDtaPag: Double;'
      '  fltLValRotDtaPag: Double;'
      '  fltLValParDtaPag: Double;'
      '  fltLValDebDtaPag: Double;'
      '  fltLValAntDtaPag: Double;'
      '  fltLValDifDtaPag: Double;'
      '  fltLValNEnDtaPag: Double;'
      '  fltLValRcxDtaPag: Double;'
      '  fltLValBaiDtaPag: Double;'
      '  fltLValManDtaPag: Double;'
      '  fltValDtaPag: Double;'
      '  fltLiqDtaPag: Double;'
      '  fltBrutoInconsistentePIXDtaPag: Double;'
      '  fltLiquidoInconsistentePIXDtaPag: Double;'
      '  fltBrutoInconsistenteBoletoDtaPag: Double;'
      '  fltLiquidoInconsistenteBoletoDtaPag: Double;'
      ''
      'procedure rllVRotPVOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVRotPV.Text := FormatFloat('#39'#,##0.00'#39', fltValRot);'
      
        '  fltTotRot := fltTotRot + fltValRot;                           ' +
        '                                                         '
      '  fltValRot := 0;      '
      'end;'
      ''
      'procedure rlbCabGruDTAPAGOnBeforePrint(Sender: TfrxComponent);'
      'begin                    '
      '  fltValDifDtaPag := 0;'
      '  intQtdDifDtaPag := 0;'
      '  fltValNEnDtaPag := 0;'
      '  intQtdNEnDtaPag := 0;'
      '  fltValRcxDtaPag := 0;'
      '  intQtdRcxDtaPag := 0;'
      '  fltValBaiDtaPag := 0;'
      '  intQtdBaiDtaPag := 0;'
      '  fltValManDtaPag := 0;'
      '  intQtdManDtaPag := 0;'
      '  fltValRotDtaPag := 0;'
      '  intQtdRotDtaPag := 0;'
      '  fltValParDtaPag := 0;'
      '  intQtdParDtaPag := 0;'
      '  fltValDebDtaPag := 0;'
      '  intQtdDebDtaPag := 0;'
      '  fltValAntDtaPag := 0;'
      '  intQtdAntDtaPag := 0;'
      '  fltLValRotDtaPag := 0;'
      '  fltLValParDtaPag := 0;'
      '  fltLValDebDtaPag := 0;'
      '  fltLValAntDtaPag := 0;'
      '  fltLValDifDtaPag := 0;'
      '  fltLValNEnDtaPag := 0;'
      '  fltLValRcxDtaPag := 0;'
      '  fltLValBaiDtaPag := 0;'
      '  fltLValManDtaPag := 0;'
      '  fltValDtaPag := 0;'
      '  intQtdDtaPag := 0;'
      '  fltLiqDtaPag := 0;'
      '  intQtdInconsistentePIXDtaPag := 0;'
      '  fltBrutoInconsistentePIXDtaPag := 0;'
      '  fltLiquidoInconsistentePIXDtaPag := 0;'
      '  intQtdInconsistenteBoletoDtaPag := 0;'
      '  fltBrutoInconsistenteBoletoDtaPag := 0;'
      '  fltLiquidoInconsistenteBoletoDtaPag := 0;'
      'end;'
      ''
      'procedure rlbRodGruDtaPagOnBeforePrint(Sender: TfrxComponent);'
      'begin          '
      '  rllAntDtaPag.Text := IntToStr(intQtdAntDtaPag);'
      '  rllParDtaPag.Text := IntToStr(intQtdParDtaPag);'
      '  rllRotDtaPag.Text := IntToStr(intQtdRotDtaPag);'
      '  rllDebDtaPag.Text := IntToStr(intQtdDebDtaPag);'
      '  rllDifDtaPag.Text := IntToStr(intQtdDifDtaPag);'
      '  rllNenDtaPag.Text := IntToStr(intQtdNEnDtaPag);'
      '  rllRcxDtaPag.Text := IntToStr(intQtdRcxDtaPag);'
      '  rllBaiDtaPag.Text := IntToStr(intQtdBaiDtaPag);'
      '  rllManDtaPag.Text := IntToStr(intQtdManDtaPag);      '
      '  rllQtdDtaPag.Text := IntToStr(intQtdDtaPag);'
      '    '
      
        '  rllVAntDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValAntDtaPag)' +
        ';                                                               ' +
        '   '
      
        '  rllVParDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValParDtaPag)' +
        ';'
      
        '  rllVRotDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValRotDtaPag)' +
        ';'
      
        '  rllVDebDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValDebDtaPag)' +
        ';'
      
        '  rllVDifDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValDifDtaPag)' +
        ';'
      
        '  rllVNenDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValNEnDtaPag)' +
        ';'
      
        '  rllVRcxDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValRcxDtaPag)' +
        ';'
      
        '  rllVBaiDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValBaiDtaPag)' +
        ';'
      
        '  rllVManDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValManDtaPag)' +
        ';        '
      '  rllTotDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltValDtaPag);   '
      ''
      
        '  rllLAntDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValAntDtaPag' +
        ');                                                              ' +
        '    '
      
        '  rllLParDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValParDtaPag' +
        ');'
      
        '  rllLRotDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValRotDtaPag' +
        ');'
      
        '  rllLDebDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValDebDtaPag' +
        ');'
      
        '  rllLDifDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValDifDtaPag' +
        ');'
      
        '  rllLNenDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValNEnDtaPag' +
        ');'
      
        '  rllLRcxDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValRcxDtaPag' +
        ');'
      
        '  rllLBaiDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValBaiDtaPag' +
        ');'
      
        '  rllLManDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLValManDtaPag' +
        ');      '
      '  rllLiqDtaPag.Text := FormatFloat('#39'#,##0.00'#39', fltLiqDtaPag);'
      ''
      
        '  rllQtdInconsistentePIXDtaPag.Text := IntToStr(intQtdInconsiste' +
        'ntePIXDtaPag);'
      
        '  rllValorBrutoInconsistentePIXDtaPag.Text := FormatFloat('#39'#,##0' +
        '.00'#39', fltBrutoInconsistentePIXDtaPag);'
      
        '  rllValorLiquidoInconsistentePIXDtaPag.Text := FormatFloat('#39'#,#' +
        '#0.00'#39', fltLiquidoInconsistentePIXDtaPag);      '
      ''
      
        '  rllQtdInconsistenteBoletoDtaPag.Text := IntToStr(intQtdInconsi' +
        'stenteBoletoDtaPag);'
      
        '  rllValorBrutoInconsistenteBoletoDtaPag.Text := FormatFloat('#39'#,' +
        '##0.00'#39', fltBrutoInconsistenteBoletoDtaPag);'
      
        '  rllValorLiquidoInconsistenteBoletoDtaPag.Text := FormatFloat('#39 +
        '#,##0.00'#39', fltLiquidoInconsistenteBoletoDtaPag);  '
      'end;    '
      ''
      'procedure rlbCabGru_PVOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValDif := 0;  '
      '  intQtdDif := 0;                 '
      '  fltValNEn := 0;  '
      '  intQtdNEn := 0;                 '
      '  fltValRcx := 0;  '
      '  intQtdRcx := 0;                 '
      '  fltValBai := 0;  '
      '  intQtdBai := 0;'
      '  fltValMan := 0;  '
      '  intQtdMan := 0;      '
      '  '
      '  fltValRot := 0;  '
      '  intQtdRot := 0;                 '
      '  fltValPar := 0;'
      '  intQtdPar := 0;                 '
      '  fltValDeb := 0;  '
      '  intQtdDeb := 0;'
      '  fltValAnt := 0;  '
      '  intQtdAnt := 0;'
      ''
      '  fltLValRot := 0;  '
      '  fltLValPar := 0;'
      '  fltLValDeb := 0;  '
      '  fltLValAnt := 0;'
      '  fltLValDif := 0;  '
      '  fltLValNEn := 0;  '
      '  fltLValRcx := 0;  '
      '  fltLValBai := 0;'
      '  fltLValMan := 0;      '
      '      '
      '  fltVal_PV := 0;'
      '  intQtd_PV := 0;'
      '  fltLiq_PV := 0;'
      ''
      '  intQtdInconsistentePIX := 0;'
      '  fltBrutoInconsistentePIX := 0;'
      '  fltLiquidoInconsistentePIX := 0;'
      ''
      '  intQtdInconsistenteBoleto := 0;'
      '  fltBrutoInconsistenteBoleto := 0;'
      '  fltLiquidoInconsistenteBoleto := 0;    '
      ''
      '  FWidthNumeroNSU := 90.71;'
      '  FWidthAutorizacao := 79.37;      '
      '  FLeftParcela := 177.27;'
      '  FLeftResumoVenda := 222.17;      '
      'end;'
      ''
      'procedure rlbCabGruIncOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValInc := 0;'
      '  fltLiqInc := 0;  '
      'end;'
      ''
      'procedure rlbCabGruTipOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltValTip := 0;'
      '  fltLiqTip := 0;'
      ''
      
        '  rllCodigoBandeira.Visible := (RetornaNomeConciliacao = '#39'REDECA' +
        'RDAPI'#39') And'
      
        '                               ((<frxRelatorio."DESCRI"> = '#39'Taxa' +
        ' de administra'#231#227'o do registro importado difere da taxa cadastrad' +
        'a para a operadora.'#39') Or'
      
        '                                (<frxRelatorio."DESCRI"> = '#39'Taxa' +
        ' de administra'#231#227'o do registro importado difere da taxa da movime' +
        'nta'#231#227'o do cart'#227'o.'#39'));                                           ' +
        '                                '
      
        '  rllCodigoBandeiraValor.Visible := rllCodigoBandeira.Visible;  ' +
        '                            '
      '  rllPercentual.Visible := rllCodigoBandeira.Visible;  '
      '  rllPercentualValor.Visible := rllCodigoBandeira.Visible;'
      ''
      '  If Not rllCodigoBandeira.Visible Then'
      '  Begin'
      '    Memo96.Width := Memo96.Width + rllCodigoBandeira.Width;'
      
        '    Memo30.Width := Memo30.Width + rllCodigoBandeira.Width;     ' +
        '   '
      '  End;            '
      ''
      '  rlbRodGruTip.height := 24.118110240000000000;  '
      '       '
      '  If RetornaNomeConciliacao = '#39'PAGSEGURO'#39' Then'
      '  Begin'
      '    Memo59.Text := '#39'N'#250'mero NSU'#39';                 '
      '    Memo59.Width := FWidthNumeroNSU;'
      '    Memo15.Width :=  Memo59.Width;'
      
        '    Memo15.Font.Size := 8;                                      ' +
        '     '
      '    Memo104.Visible := True;'
      '    Memo60.Visible := True;'
      
        '    Memo104.Left := Memo59.Left + 86;                           ' +
        '                                                                ' +
        '             '
      '    Memo60.Left := Memo104.Left;                         '
      '    Memo103.Left := FLeftParcela - 14;  '
      '    Memo16.Left := Memo103.Left;'
      '    Memo96.Left := Memo103.Left + 42;'
      
        '    Memo30.Left := Memo96.Left;                                 ' +
        '         '
      '    Memo30.Width := Memo96.Width + 29;'
      '    Memo30.Font.Size := 7;        '
      '      '
      
        '    If (<frxRelatorio."TIPCAR"> = '#39'PIX'#39') Or (<frxRelatorio."TIPC' +
        'AR"> = '#39'BOLETO'#39') Then'
      '    Begin'
      '      Memo59.Text := '#39'C'#243'digo Transa'#231#227'o'#39';'
      
        '      Memo59.Width :=  FWidthNumeroNSU + Memo104.Width + 12;    ' +
        '      '
      '      Memo15.Width :=  Memo59.Width;'
      '      Memo15.Font.Size := 7;          '
      '      Memo104.Visible := False;'
      '      Memo60.Visible := False;'
      ''
      '      Memo103.Left := FLeftParcela + 6;'
      '      Memo16.Left := Memo103.Left;'
      ''
      '      Memo96.Left := Memo103.Left + 42;'
      
        '      Memo30.Left := Memo96.Left;                               ' +
        '                         '
      '      Memo30.Width := Memo96.Width + 32;'
      
        '      Memo30.Font.Size := 7;                                    ' +
        '                                            '
      '    End;              '
      '  End'
      '  Else If RetornaNomeConciliacao = '#39'CIELO'#39' Then'
      '  Begin              '
      '    Memo104.Text := '#39'N'#250'mero Aut.'#39';                 '
      '    Memo104.Width := FWidthAutorizacao;'
      '    Memo60.Width := FWidthAutorizacao;'
      '    Memo60.Font.Size := 8;        '
      ''
      
        '    Memo97.Visible := True;                                     ' +
        ' '
      '    Memo26.Visible := True;'
      ''
      
        '    Memo103.Left := FLeftParcela;                               ' +
        '                 '
      '    Memo16.Left := FLeftParcela;'
      
        '    Memo96.Left := FLeftResumoVenda;                            ' +
        '      '
      
        '    Memo30.Left := FLeftResumoVenda;                            ' +
        '               '
      '           '
      '    If (<frxRelatorio."TIPCAR"> = '#39'PIX'#39') Then'
      '  Begin'
      '      Memo104.Text := '#39'C'#243'digo Transa'#231#227'o'#39';'
      
        '      Memo104.Width :=  FWidthAutorizacao + Memo97.Width + 12;  ' +
        '        '
      '      Memo60.Width :=  Memo104.Width;'
      '      Memo97.Visible := False;'
      '      Memo26.Visible := False;'
      ''
      '      Memo103.Left := FLeftParcela + Memo97.Width + 12;'
      '      Memo16.Left := FLeftParcela + Memo97.Width + 12;'
      
        '      Memo96.Left := FLeftResumoVenda + Memo97.Width + 12;      ' +
        '                            '
      
        '      Memo30.Left := FLeftResumoVenda + Memo97.Width + 12;      ' +
        '                        '
      '    End;  '
      '  End          '
      '  Else If RetornaNomeConciliacao = '#39'PAGAR.ME'#39' Then'
      '  Begin'
      '    Memo97.Text := '#39'N'#250'mero Cart'#227'o'#39';'
      
        '    If (<frxRelatorio."TIPCAR"> = '#39'PIX'#39') Or (<frxRelatorio."TIPC' +
        'AR"> = '#39'BOLETO'#39') Then'
      '      Memo97.Text := '#39'Meio de Pagamento'#39';        '
      '  End'
      '  Else If RetornaNomeConciliacao = '#39'REDECARD API'#39' Then'
      '  Begin'
      
        '    rllCodigoBandeira                                           ' +
        '              '
      '  End'
      '  Else If RetornaNomeConciliacao = '#39'SHOPEEPAY'#39' Then'
      '  Begin'
      ''
      
        '    If (mmOrdAll.Visible = False) Then                          ' +
        '                                                   '
      '    Begin    '
      '      Memo304.Visible := true;'
      '      Memo305.Visible := true;'
      '      Memo306.Visible := true;'
      '      Memo307.Visible := true;'
      '      Memo308.Visible := true;'
      '      Memo310.Visible := true;               '
      '    '
      '      rlbRodGruTip.height := 58.133880240000000000;'
      '      Memo311.Visible := True;'
      '      Memo312.Visible := True;  '
      '      Memo316.Visible := True;  '
      '      Memo318.Visible := True;  '
      '      Memo314.Visible := True;  '
      '      Memo315.Visible := True;'
      '    End;'
      '      '
      '  End;'
      '    '
      'end;'
      ''
      'procedure rlbDetRedeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        ' If <frxRelatorio."TOTALI"> = '#39'S'#39' Then                          ' +
        '                          '
      ' Begin              '
      
        '  If Copy(<frxRelatorio."DESCRI">, 1, 50) = '#39'Valor do cart'#227'o dif' +
        'erente do registrado no sistema'#39' Then'
      '  Begin'
      '    fltValDif := fltValDif + <frxRelatorio."VALORI">;'
      '    fltLValDif := fltLValDif + <frxRelatorio."VALLIQ">;'
      
        '    fltValDifDtaPag := fltValDifDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValDifDtaPag := fltLValDifDtaPag + <frxRelatorio."VALLIQ' +
        '">;                              '
      '    intQtdDif := intQtdDif + 1;'
      
        '    intQtdDifDtaPag := intQtdDifDtaPag + 1;                     ' +
        '               '
      '  End'
      
        '  Else If <frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enc' +
        'ontrado nos lan'#231'amentos do sistema'#39' Then'
      '  Begin'
      '    fltValNEn := fltValNEn + <frxRelatorio."VALORI">;'
      '    fltLValNEn := fltLValNEn + <frxRelatorio."VALLIQ">;'
      
        '    fltValNEnDtaPag := fltValNEnDtaPag + <frxRelatorio."VALORI">' +
        ';                                 '
      
        '    fltLValNEnDtaPag := fltLValNEnDtaPag + <frxRelatorio."VALLIQ' +
        '">;                              '
      '    intQtdNEn := intQtdNEn + 1;'
      
        '    intQtdNEnDtaPag := intQtdNEnDtaPag + 1;                     ' +
        '           '
      '  End'
      
        '  Else If <frxRelatorio."DESCRI"> = '#39'Cart'#245'es recebibos pelo Caix' +
        'a e n'#227'o transferidos n'#227'o podem ser selecionados'#39' Then'
      '  Begin'
      '    fltValRcx := fltValRcx + <frxRelatorio."VALORI">;'
      '    fltLValRcx := fltLValRcx + <frxRelatorio."VALLIQ">;'
      
        '    fltValRcxDtaPag := fltValRcxDtaPag + <frxRelatorio."VALORI">' +
        ';  '
      
        '    fltLValRcxDtaPag := fltLValRcxDtaPag + <frxRelatorio."VALLIQ' +
        '">;    '
      '    intQtdRcx := intQtdRcx + 1;'
      '    intQtdRcxDtaPag := intQtdRcxDtaPag + 1;        '
      '  End'
      
        '  Else If <frxRelatorio."DESCRI"> = '#39'Cart'#227'o j'#225' foi baixado atrav' +
        #233's de concilia'#231#227'o autom'#225'tica'#39' Then'
      '  Begin'
      '    fltValBai := fltValBai + <frxRelatorio."VALORI">;'
      '    fltLValBai := fltLValBai + <frxRelatorio."VALLIQ">;      '
      
        '    fltValBaiDtaPag := fltValBaiDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValBaiDtaPag := fltLValBaiDtaPag + <frxRelatorio."VALLIQ' +
        '">;        '
      '    intQtdBai := intQtdBai + 1;'
      
        '    intQtdBaiDtaPag := intQtdBaiDtaPag + 1;                     ' +
        '           '
      '  End'
      
        '  Else If <frxRelatorio."DESCRI"> = '#39'Cart'#227'o j'#225' foi baixado manua' +
        'lmente'#39' Then'
      '  Begin'
      '    fltValMan  := fltValMan + <frxRelatorio."VALORI">;'
      '    fltLValMan := fltLValMan + <frxRelatorio."VALLIQ">;'
      
        '    fltValManDtaPag := fltValManDtaPag + <frxRelatorio."VALORI">' +
        ';                            '
      
        '    fltLValManDtaPag := fltLValManDtaPag + <frxRelatorio."VALLIQ' +
        '">;                                     '
      '    intQtdMan := intQtdMan + 1;'
      
        '    intQtdManDtaPag := intQtdManDtaPag + 1;                     ' +
        '               '
      '  End;'
      ''
      '  If <frxRelatorio."TIPCAR"> = '#39'CR'#201'DITO ROTATIVO'#39' Then'
      '  Begin'
      '    fltValRot := fltValRot + <frxRelatorio."VALORI">;'
      '    fltLValRot := fltLValRot + <frxRelatorio."VALLIQ">;'
      
        '    fltValRotDtaPag := fltValRotDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValRotDtaPag := fltLValRotDtaPag + <frxRelatorio."VALLIQ' +
        '">;                                 '
      '    intQtdRot := intQtdRot + 1;'
      
        '    intQtdRotDtaPag := intQtdRotDtaPag + 1;                     ' +
        '               '
      '  End'
      '  Else If <frxRelatorio."TIPCAR"> = '#39'CR'#201'DITO PARCELADO'#39' Then'
      '  Begin'
      '    fltValPar := fltValPar + <frxRelatorio."VALORI">;'
      '    fltLValPar := fltLValPar + <frxRelatorio."VALLIQ">;'
      
        '    fltValParDtaPag := fltValParDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValParDtaPag := fltLValParDtaPag + <frxRelatorio."VALLIQ' +
        '">;                              '
      '    intQtdPar := intQtdPar + 1;'
      
        '    intQtdParDtaPag := intQtdParDtaPag + 1;                     ' +
        '           '
      '  End'
      '  Else If <frxRelatorio."TIPCAR"> = '#39'D'#201'BITO'#39' Then'
      '  Begin'
      '    fltValDeb := fltValDeb + <frxRelatorio."VALORI">;'
      '    fltLValDeb := fltLValDeb + <frxRelatorio."VALLIQ">;'
      
        '    fltValDebDtaPag := fltValDebDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValDebDtaPag := fltLValDebDtaPag + <frxRelatorio."VALLIQ' +
        '">;                              '
      '    intQtdDeb := intQtdDeb + 1;'
      
        '    intQtdDebDtaPag := intQtdDebDtaPag + 1;                     ' +
        '         '
      '  End'
      '  Else If <frxRelatorio."TIPCAR"> = '#39'ANTECIPA'#199#195'O'#39' Then'
      '  Begin'
      '    fltValAnt := fltValAnt + <frxRelatorio."VALORI">;'
      '    fltLValAnt := fltLValAnt + <frxRelatorio."VALLIQ">;'
      
        '    fltValAntDtaPag := fltValAntDtaPag + <frxRelatorio."VALORI">' +
        ';'
      
        '    fltLValAntDtaPag := fltLValAntDtaPag + <frxRelatorio."VALLIQ' +
        '">;                                 '
      '    intQtdAnt := intQtdAnt + 1;'
      
        '    intQtdAntDtaPag := intQtdAntDtaPag + 1;                     ' +
        '               '
      '  End'
      '  Else If <frxRelatorio."TIPCAR"> = '#39'PIX'#39' Then'
      '  Begin'
      '    intQtdInconsistentePIX := intQtdInconsistentePIX + 1;'
      
        '    fltBrutoInconsistentePIX := fltBrutoInconsistentePIX + <frxR' +
        'elatorio."VALORI">;'
      
        '    fltLiquidoInconsistentePIX := fltLiquidoInconsistentePIX + <' +
        'frxRelatorio."VALLIQ">;'
      
        '    intQtdInconsistentePIXDtaPag := intQtdInconsistentePIXDtaPag' +
        ' + 1;'
      
        '    fltBrutoInconsistentePIXDtaPag := fltBrutoInconsistentePIXDt' +
        'aPag + <frxRelatorio."VALORI">;                      '
      
        '    fltLiquidoInconsistentePIXDtaPag := fltLiquidoInconsistenteP' +
        'IXDtaPag + <frxRelatorio."VALLIQ">;                             ' +
        '    '
      '  End'
      '  Else If <frxRelatorio."TIPCAR"> = '#39'BOLETO'#39' Then'
      '  Begin'
      '    intQtdInconsistenteBoleto := intQtdInconsistenteBoleto + 1;'
      
        '    fltBrutoInconsistenteBoleto := fltBrutoInconsistenteBoleto +' +
        ' <frxRelatorio."VALORI">;'
      
        '    fltLiquidoInconsistenteBoleto := fltLiquidoInconsistenteBole' +
        'to + <frxRelatorio."VALLIQ">;'
      
        '    intQtdInconsistenteBoletoDtaPag := intQtdInconsistenteBoleto' +
        'DtaPag + 1;                        '
      
        '    fltBrutoInconsistenteBoletoDtaPag := fltBrutoInconsistenteBo' +
        'letoDtaPag + <frxRelatorio."VALORI">;                         '
      
        '    fltLiquidoInconsistenteBoletoDtaPag := fltLiquidoInconsisten' +
        'teBoletoDtaPag + <frxRelatorio."VALLIQ">;                       ' +
        '    '
      '  End;'
      '  fltVal_PV := fltVal_PV + <frxRelatorio."VALORI">;'
      '  fltLiq_PV := fltLiq_PV + <frxRelatorio."VALLIQ">;      '
      '  intQtd_PV := intQtd_PV + 1;'
      '  fltValInc := fltValInc + <frxRelatorio."VALORI">;'
      '  fltLiqInc := fltLiqInc + <frxRelatorio."VALLIQ">;'
      ' End;'
      ' intQtdDtaPag := intQtdDtaPag + 1;                             '
      
        ' fltValDtaPag := fltValDtaPag + <frxRelatorio."VALORI">;        ' +
        '                        '
      ' fltLiqDtaPag := fltLiqDtaPag + <frxRelatorio."VALLIQ">;     '
      ' fltValTip := fltValTip + <frxRelatorio."VALORI">;'
      ' fltLiqTip := fltLiqTip + <frxRelatorio."VALLIQ">;'
      'end;'
      ''
      'procedure rllTotTipOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotTip.Text := FormatFloat('#39'#,##0.00'#39', fltValTip);  '
      'end;'
      ''
      'procedure rllTotIncOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotInc.Text := FormatFloat('#39'#,##0.00'#39', fltValInc);  '
      'end;'
      ''
      'procedure rllLiqTipOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllLiqTip.Text := FormatFloat('#39'#,##0.00'#39', fltLiqTip);  '
      'end;'
      ''
      'procedure rllLiqIncOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllLiqInc.Text := FormatFloat('#39'#,##0.00'#39', fltLiqInc);  '
      'end;'
      ''
      'procedure rlbRodGru_PVOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllAnt_PV.Text := IntToStr(intQtdAnt);'
      '  rllPar_PV.Text := IntToStr(intQtdPar);'
      '  rllRot_PV.Text := IntToStr(intQtdRot);'
      '  rllDeb_PV.Text := IntToStr(intQtdDeb);'
      '  rllDif_PV.Text := IntToStr(intQtdDif);'
      '  rllNen_PV.Text := IntToStr(intQtdNen);'
      '  rllRcx_PV.Text := IntToStr(intQtdRcx);'
      '  rllBai_PV.Text := IntToStr(intQtdBai);'
      '  rllMan_PV.Text := IntToStr(intQtdMan);      '
      '  rllQtd_PV.Text := IntToStr(intQtd_PV);              '
      '  intTotIncon    := intTotIncon + intQtd_PV;'
      '  intQtdTotCon   := intQtdTotCon + intQtdBai;'
      '  intQtdTotMan   := intQtdTotMan + intQtdMan;      '
      ''
      
        '  rllVAntPV.Text := FormatFloat('#39'#,##0.00'#39', fltValAnt);         ' +
        '                                                         '
      '  rllVParPV.Text := FormatFloat('#39'#,##0.00'#39', fltValPar);'
      '  rllVRotPV.Text := FormatFloat('#39'#,##0.00'#39', fltValRot);'
      '  rllVDebPV.Text := FormatFloat('#39'#,##0.00'#39', fltValDeb);'
      '  rllVDifPV.Text := FormatFloat('#39'#,##0.00'#39', fltValDif);'
      '  rllVNenPV.Text := FormatFloat('#39'#,##0.00'#39', fltValNen);'
      '  rllVRcxPV.Text := FormatFloat('#39'#,##0.00'#39', fltValRcx);'
      '  rllVBaiPV.Text := FormatFloat('#39'#,##0.00'#39', fltValBai);'
      '  rllVManPV.Text := FormatFloat('#39'#,##0.00'#39', fltValMan);        '
      '  rllTot_PV.Text := FormatFloat('#39'#,##0.00'#39', fltVal_PV);'
      '  fltBruIncon    := fltBruIncon + fltVal_PV;'
      '  fltValTotCon   := fltValTotCon + fltValBai;'
      '  fltValTotMan   := fltValTotMan + fltValMan;      '
      ''
      
        '  rllLAntPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValAnt);        ' +
        '                                                          '
      '  rllLParPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValPar);'
      '  rllLRotPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValRot);'
      '  rllLDebPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValDeb);'
      '  rllLDifPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValDif);'
      '  rllLNenPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValNen);'
      '  rllLRcxPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValRcx);'
      '  rllLBaiPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValBai);'
      '  rllLManPV.Text := FormatFloat('#39'#,##0.00'#39', fltLValMan);      '
      '  rllLiq_PV.Text := FormatFloat('#39'#,##0.00'#39', fltLiq_PV);'
      '  fltLiqIncon    := fltLiqIncon + fltLiq_PV;'
      '  fltLiqTotCon   := fltLiqTotCon + fltLValBai;'
      '  fltLiqTotMan   := fltLiqTotMan + fltLValMan;'
      ''
      
        '  rllQtdInconsistentePIX.Text := IntToStr(intQtdInconsistentePIX' +
        ');'
      
        '  rllValorBrutoInconsistentePIX.Text := FormatFloat('#39'#,##0.00'#39', ' +
        'fltBrutoInconsistentePIX);'
      
        '  rllValorLiquidoInconsistentePIX.Text := FormatFloat('#39'#,##0.00'#39 +
        ', fltLiquidoInconsistentePIX);      '
      ''
      
        '  rllQtdInconsistenteBoleto.Text := IntToStr(intQtdInconsistente' +
        'Boleto);'
      
        '  rllValorBrutoInconsistenteBoleto.Text := FormatFloat('#39'#,##0.00' +
        #39', fltBrutoInconsistenteBoleto);'
      
        '  rllValorLiquidoInconsistenteBoleto.Text := FormatFloat('#39'#,##0.' +
        '00'#39', fltLiquidoInconsistenteBoleto);      '
      '  '
      ' If SubReport3.Visible Then'
      '  Begin              '
      '    fTotBan(<frxRelatorio."NUM_PV">, 2, 0);'
      '  End'
      '  Else'
      '  Begin'
      
        '    rlbRodGru_PV.Height := rlbRodGru_PV.Height - 27;            ' +
        '                                             '
      '  End;        '
      'end;'
      ''
      'procedure Memo130OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio."DESEMP"> = '#39#39') Or (<frxRelatorio."DESEMP"> ' +
        '= '#39'N'#195'O EXISTE EMPRESA VINCULADA'#39') Then'
      '  Begin'
      '    Memo130.Text := '#39'N'#195'O EXISTE EMPRESA VINCULADA'#39';'
      '    Memo130.Font.Style := fsItalic;'
      '  End'
      '  Else        '
      '  Begin'
      '    Memo130.Font.Style := 0;                 '
      '  End;                '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllQtdIncon.Text := InttoStr(intTotIncon + StrToInt(Trim(rllQt' +
        'dCan.Text)));'
      
        '  rllBruIncon.Text := FormatFloat('#39'#,##0.00;-#,##0.00'#39', fltBruIn' +
        'con + fStrToFloat(Trim(rllBruCan.Text)));'
      
        '  rllLiqIncon.Text := FormatFloat('#39'#,##0.00;-#,##0.00'#39', fltLiqIn' +
        'con + fStrToFloat(Trim(rllLiqCan.Text)));'
      ''
      
        '  rllQtdInc.Text :=InttoStr(intTotIncon - intQtdTotMan - intQtdT' +
        'otCon);'
      
        '  rllBruInc.Text := FormatFloat('#39'#,##0.00'#39', fltBruIncon - fltVal' +
        'TotMan - fltValTotCon);'
      
        '  rllIncLiq.Text := FormatFloat('#39'#,##0.00'#39', fltLiqIncon - fltLiq' +
        'TotMan - fltLiqTotCon);      '
      ''
      
        '  rllQtdTotCar.Text := InttoStr(StrtoInt(Trim(rllQtdRes.Text)) +' +
        ' StrtoInt(Trim(rllQtdIncon.Text)));'
      
        '  rllBruTotCar.Text := FormatFloat('#39'#,##0.00'#39', fStrToFloat(Trim(' +
        'rllTotRes.Text)) + fStrToFloat(Trim(rllBruIncon.Text)));'
      
        '  rllLiqTotCar.Text := FormatFloat('#39'#,##0.00'#39',  fStrToFloat(Trim' +
        '(rllLiqRes.Text)) + fStrToFloat(Trim(rllLiqIncon.Text)));'
      ''
      '  rllQtdTotCon.Text := InttoStr(intQtdTotCon);'
      '  rllValTotCon.Text := FormatFloat('#39'#,##0.00'#39', fltValTotCon);'
      '  rllLiqTotCon.Text := FormatFloat('#39'#,##0.00'#39', fltLiqTotCon);'
      ''
      '  rllQtdTotMan.Text := InttoStr(intQtdTotMan);'
      '  rllValTotMan.Text := FormatFloat('#39'#,##0.00'#39', fltValTotMan);'
      
        '  rllLiqTotMan.Text := FormatFloat('#39'#,##0.00'#39', fltLiqTotMan);   ' +
        '   '
      ''
      '  If StrToInt(Trim(rllQtdCan.Text)) = 0 Then'
      '  Begin'
      '    rllMensagem01.Visible := False;'
      
        '    ReportSummary1.Height := ReportSummary1.Height - 20;        ' +
        '                                           '
      '  End;  '
      'end;'
      ''
      'procedure Memo155OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."CODCLI"> = '#39#39') Then'
      '  Begin'
      '    If (<frxRelatorio."NOMCLI"> = '#39#39') Then'
      '      Memo155.Text := '#39'DADOS N'#195'O CADASTRADOS NO AUTCOM'#39
      '    Else'
      '      Memo155.Text := <frxRelatorio."NOMCLI">;'
      '  End;                  '
      'end;'
      ''
      'procedure Child7OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fTotBan('#39#39', 2, 1);  '
      'end;'
      ''
      'procedure Memo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxTotBan."CONCIL"> = 0) Then'
      '    Memo1.Text := '#39'Resumo por Bandeira (N'#195'O CONCILIADOS)'#39
      '  Else'
      '    Memo1.Text := '#39'Resumo por Bandeira (CONCILIADOS)'#39';  '
      'end;'
      ''
      'procedure rlbBandeirasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbbandeiras.Height := 0;  '
      'end;'
      ''
      'procedure Memo5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxTotBan."CONCIL"> = 0) Then'
      '    Memo5.Text := '#39'N'#195'O CONCILIADOS por Ponto de Venda'#39
      '  Else'
      
        '    Memo5.Text := '#39'CONCILIADOS por Ponto de Venda'#39';             ' +
        '   '
      'end;'
      ''
      'procedure rlbConcilEstabeOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbConcilEstabe.Height := 0;  '
      'end;'
      ''
      'procedure Child3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Child3.Visible := SubReport4.Visible;                         ' +
        '                                             '
      '  If SubReport4.Visible Then'
      '    fTotBan('#39#39', 2, 2);  '
      'end;'
      ''
      'procedure Child5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If StrToInt(Trim(rllQtdCan.Text)) = 0 Then'
      '  Begin'
      '    Child5.Visible := False;'
      '  End'
      '  Else'
      '  Begin'
      '    fFiltraCancelamentos;'
      '  End;  '
      'end;'
      ''
      'procedure GroupHeader3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBruCanPV := 0;'
      '  fltLiqCanPV := 0;                                        '
      'end;'
      ''
      'procedure MasterData2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltBruCanPV := fltBruCanPV + <frxRelatorio."VALORI">;'
      '  fltLiqCanPV := fltLiqCanPV + <frxRelatorio."VALLIQ">;  '
      'end;'
      ''
      'procedure GroupFooter4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllBruCanPV.Text := FormatFloat('#39'#,##0.00'#39', fltBruCanPV);'
      
        '  rllLiqCanPV.Text := FormatFloat('#39'#,##0.00'#39', fltLiqCanPV);     ' +
        ' '
      'end;'
      ''
      
        'procedure rlbCancelamentosEAjustesMktOnBeforePrint(Sender: TfrxC' +
        'omponent);'
      'begin'
      '  If StrToInt(Trim(rllQuantidadeCancelamentoMkt.Text)) = 0 Then'
      '  Begin'
      '    rlbCancelamentosEAjustesMkt.Visible := False;'
      '  End'
      '  Else'
      '  Begin'
      '    fFiltraCancelamentos;'
      '  End;  '
      'end;'
      ''
      
        'procedure rlbResumoTransferenciasOnBeforePrint(Sender: TfrxCompo' +
        'nent);'
      'begin'
      
        '  rlbResumoTransferencias.Visible := FiltraTransferencias;      ' +
        '                                            '
      'end;'
      ''
      
        'procedure rlbTransferenciasEstabelecimentoHeaderOnBeforePrint(Se' +
        'nder: TfrxComponent);'
      'begin'
      '  fltValorTransferencia := 0;                '
      'end;'
      ''
      
        'procedure rlbTransferenciasDadosOnBeforePrint(Sender: TfrxCompon' +
        'ent);'
      'begin'
      
        '  fltValorTransferencia := fltValorTransferencia + <frxRelatorio' +
        '."VALREC">;                        '
      'end;'
      ''
      
        'procedure rlbTransferenciasEstabelecimentoFooterOnBeforePrint(Se' +
        'nder: TfrxComponent);'
      'begin'
      
        '  rllValorTotalTransferencias.Text := FormatFloat('#39'#,##0.00'#39', fl' +
        'tValorTransferencia);  '
      'end;'
      ''
      
        'procedure rlbResumoTransferenciasMKTOnBeforePrint(Sender: TfrxCo' +
        'mponent);'
      'begin'
      '  rlbResumoTransferenciasMkt.Visible := FiltraTransferencias;  '
      'end;'
      ''
      'procedure qckMarketPLaceOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  FFiltroPrincipal := RetornaFiltroPrincipal;    '
      'end;'
      ''
      'procedure rlbArquivosMktOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  VoltaFiltros(FFiltroPrincipal);  '
      'end;'
      ''
      'procedure qckRedeCardOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  FFiltroPrincipal := RetornaFiltroPrincipal;    '
      'end;'
      ''
      'procedure Child1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  VoltaFiltros(FFiltroPrincipal);  '
      'end;'
      ''
      
        'procedure rlbTotaisCancelamentosMktOnBeforePrint(Sender: TfrxCom' +
        'ponent);'
      'begin'
      '  If <frxRelatorio."DESCRI"> <> '#39'Cancelamentos/Ajustes'#39' Then'
      
        '    rllTextoCancelamentoMkt.Text := '#39'*Esses registros s'#227'o merame' +
        'nte informativos e N'#195'O ser'#227'o lan'#231'ados na Movimenta'#231#227'o Banc'#225'ria.'#39 +
        ';                                                               ' +
        '                                                                ' +
        '                                                                ' +
        '                                                            '
      'end;'
      ''
      
        'procedure rlbNegociacoesEstabelecimentoHeaderOnBeforePrint(Sende' +
        'r: TfrxComponent);'
      'begin'
      '  fltValorNegociacao := 0;'
      'end;'
      ''
      
        'procedure rlbNegociacoesDadosOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  fltValorNegociacao := fltValorNegociacao + <frxRelatorio."VALR' +
        'EC">;  '
      'end;'
      ''
      
        'procedure rlbNegociacoesEstabelecimentoFooterOnBeforePrint(Sende' +
        'r: TfrxComponent);'
      'begin'
      
        '  rllValorTotalNegociacoes.Text := FormatFloat('#39'#,##0.00'#39', fltVa' +
        'lorNegociacao);  '
      'end;'
      ''
      'procedure Child6OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    Child6.Visible := FiltraNegociacoesRecebiveis;  '
      'end;'
      ''
      'begin'
      '  fltValDif:= 0;'
      '  fltValNEn:= 0;'
      '  fltValRcx:= 0;'
      '  fltValBai:= 0;'
      '  fltValRot:= 0;'
      '  fltValPar:= 0;'
      '  fltValDeb:= 0;'
      '  fltVal_PV:= 0;'
      '  fltTotDif:= 0;'
      '  fltTotNEn:= 0;'
      '  fltTotRcx:= 0;'
      '  fltTotBai:= 0;'
      '  fltTotRot:= 0;'
      '  fltTotPar:= 0;'
      '  fltTotDeb:= 0;          '
      '  intQtdDif:= 0;'
      '  intQtdNEn:= 0;'
      '  intQtdRcx:= 0;'
      '  intQtdBai:= 0;'
      '  intQtdRot:= 0;'
      '  intQtdPar:= 0;'
      '  intQtdDeb:= 0;'
      '  intQtd_PV:= 0;'
      '  intQtdAnt:= 0;        '
      '  intTotDif:= 0;'
      '  intTotNEn:= 0;'
      '  intTotRcx:= 0;'
      '  intTotBai:= 0;'
      '  intTotRot:= 0;'
      '  intTotPar:= 0;'
      '  intTotDeb:= 0;'
      '  fltTotGer:= 0;'
      '  intTotAnt:= 0;'
      '  intQtdTotMan:= 0;'
      '  intQtdTotCon:= 0;                                   '
      '  intTotIncon := 0;'
      '  fltBruIncon := 0;'
      '  fltLiqIncon := 0;'
      '  fltBruCanPV := 0;      '
      '  fltLiqCanPV := 0;'
      '  fltValTotCon:= 0;'
      '  fltValTotMan:= 0;'
      '  fltLiqTotCon:= 0;'
      '  fltLiqTotMan:= 0;'
      ''
      '  fltValorTransferencia := 0;'
      '  fltValorNegociacao := 0;'
      ''
      '  rlbCabGruDtaPag.Visible := False;       '
      '  if RetornaNomeConciliacao = '#39'REDECARDAPI'#39' Then'
      '  begin                                               '
      '    MemoDtaPag_.Visible := True;'
      '    MemoDtaPag.Visible := True;'
      '    rlbCabGru_PV.Height := 57;'
      '    rlbRodGruDtaPag.Visible := True;        '
      '  end'
      '  else'
      '  begin               '
      '    MemoDtaPag_.Visible := False;'
      '    MemoDtaPag.Visible := False;'
      '    rlbCabGru_PV.Height := 31;   '
      '    rlbRodGruDtaPag.Visible := False;                     '
      
        '    rlbCabGruDtaPag.Condition := '#39'0=1'#39'; //condi'#231#227'o falsa para n'#227 +
        'o agrupar sem dar erro                                          ' +
        '                                                                ' +
        '    '
      '  end;  '
      'end.')
    OnUserFunction = frxPaginaUserFunction
    Left = 32
    Top = 24
    Datasets = <
      item
        DataSet = frxListArq
        DataSetName = 'frxListArq'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxSemRed
        DataSetName = 'frxSemRed'
      end
      item
        DataSet = frxTotalFinal
        DataSetName = 'frxTotalFinal'
      end
      item
        DataSet = frxTotBan
        DataSetName = 'frxTotBan'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckRedeCard: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 600.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'qckRedeCardOnBeforePrint'
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 26.102340240000000000
        Top = 1988.032780000000000000
        Width = 718.110700000000000000
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000040000
          Width = 710.475820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [(<Page>)] de [TotalPages#]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 81.204700000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 16.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
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
        object Memo20: TfrxMemoView
          Left = 1241.757700000000000000
          Width = 115.200000000000000000
          Height = 17.007874020000000000
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
        object Memo21: TfrxMemoView
          Left = 1308.655350000000000000
          Top = 16.000000000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo22: TfrxMemoView
          Left = 1245.753000000000000000
          Top = 16.000000000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo23: TfrxMemoView
          Align = baCenter
          Left = 121.814410000000000000
          Width = 474.481880000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 665.847620000000000000
          Top = 16.118120000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo54: TfrxMemoView
          Left = 602.945270000000000000
          Top = 16.118120000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo64: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 38.354360000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
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
        object rllCodigoConciliacao: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 58.692950000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODIGO_CONCILIACAO]')
          ParentFont = False
        end
        object mmOrdAll: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.252010000000000000
          Width = 3.338553390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 272.126023310000000000
        Top = 1111.181820000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPagina.Child8
        PrintChildIfInvisible = True
        StartNewPage = True
        object Shape3: TfrxShapeView
          Top = 27.338590000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo36: TfrxMemoView
          Left = 1055.788190000000000000
          Top = 3.779530000000020000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          WordWrap = False
        end
        object rllValPar: TfrxMemoView
          Left = 1010.433830000000000000
          Top = 19.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllValParOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdPar: TfrxMemoView
          Left = 815.118740000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllQtdParOnBeforePrint'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 1.779530000000000000
          Top = 27.338590000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cart'#245'es Conciliados (marcados no filtro)')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 410.968770000000000000
          Top = 27.338590000000000000
          Width = 83.149606299212600000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 499.653543310000000000
          Top = 27.338590000000000000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 1.000000000000000000
          Top = 58.456710000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Parcelado...............................................' +
              '............................................... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 1.000000000000000000
          Top = 74.354360000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Rotativo................................................' +
              '................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 1.000000000000000000
          Top = 89.692950000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'D'#233'bito..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllTotCPa: TfrxMemoView
          Left = 499.653543310000000000
          Top = 58.456710000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotCRo: TfrxMemoView
          Left = 499.653543310000000000
          Top = 74.354360000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotDeb: TfrxMemoView
          Left = 499.653543310000000000
          Top = 89.692950000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdCPa: TfrxMemoView
          Left = 411.709030000000000000
          Top = 57.677180000000000000
          Width = 83.149606299212600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdCRo: TfrxMemoView
          Left = 411.709030000000000000
          Top = 73.574830000000000000
          Width = 83.149606299212600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdDeb: TfrxMemoView
          Left = 411.709030000000000000
          Top = 88.913420000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 1.000000000000000000
          Top = 42.456710000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Antecipa'#231#227'o.....................................................' +
              '.................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdAnt: TfrxMemoView
          Left = 410.968770000000000000
          Top = 42.456710000000000000
          Width = 83.149606299212600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotAnt: TfrxMemoView
          Left = 499.653543310000000000
          Top = 42.456710000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Top = 136.708720000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........................................................ :')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdRes: TfrxMemoView
          Left = 411.968770000000000000
          Top = 137.929190000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotRes: TfrxMemoView
          Left = 499.653543310000000000
          Top = 137.708720000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 608.504330000000000000
          Top = 27.338590000000000000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqCPa: TfrxMemoView
          Left = 608.504330000000000000
          Top = 58.456710000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqCRo: TfrxMemoView
          Left = 608.504330000000000000
          Top = 74.354360000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqDeb: TfrxMemoView
          Left = 608.504330000000000000
          Top = 89.692950000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqAnt: TfrxMemoView
          Left = 608.504330000000000000
          Top = 42.456710000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqRes: TfrxMemoView
          Left = 608.504330000000000000
          Top = 137.708720000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Shape6: TfrxShapeView
          Top = 157.385900000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo131: TfrxMemoView
          Left = 1.779530000000000000
          Top = 157.385900000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cart'#245'es n'#227'o Conciliados')
          ParentFont = False
          WordWrap = False
        end
        object Memo132: TfrxMemoView
          Left = 410.968770000000000000
          Top = 157.385900000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo133: TfrxMemoView
          Left = 499.653543310000000000
          Top = 157.385900000000000000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIncon: TfrxMemoView
          Left = 410.968770000000000000
          Top = 234.504020000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBruIncon: TfrxMemoView
          Left = 499.653543310000000000
          Top = 234.504020000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 608.504330000000000000
          Top = 157.385900000000000000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqIncon: TfrxMemoView
          Left = 608.504330000000000000
          Top = 234.504020000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Top = 235.063080000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '....................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdCan: TfrxMemoView
          Left = 410.968770000000000000
          Top = 173.504020000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBruCan: TfrxMemoView
          Left = 499.653543310000000000
          Top = 173.504020000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqCan: TfrxMemoView
          Left = 608.504330000000000000
          Top = 173.504020000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Top = 173.063080000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cancelamentos/Ajustes...........................................' +
              '........................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllMensagem01: TfrxMemoView
          Left = 7.559060000000000000
          Top = 252.858380000000000000
          Width = 400.630180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Registros de Cancelamentos/Ajustes ser'#227'o listados na inconsist'#234 +
              'ncia abaixo.'
            
              '**Registros de Cancelamentos/Ajustes com valor l'#237'quido zerados s' +
              #227'o meramente informativos e n'#227'o ser'#227'o baixados.')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Top = 11.338590000000000000
          Width = 716.220472440000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Style = fsDot
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Total Geral')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdInc: TfrxMemoView
          Left = 410.968770000000000000
          Top = 187.960730000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBruInc: TfrxMemoView
          Left = 499.653543310000000000
          Top = 187.960730000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllIncLiq: TfrxMemoView
          Left = 608.504330000000000000
          Top = 187.960730000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Top = 187.519790000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Inconsistentes..................................................' +
              '.................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = -0.220470000000000000
          Top = 202.637910000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica.........' +
              '........................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValTotCon: TfrxMemoView
          Left = 499.126470000000000000
          Top = 203.637910000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdTotCon: TfrxMemoView
          Left = 410.488560000000000000
          Top = 202.858380000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqTotCon: TfrxMemoView
          Left = 608.283860000000000000
          Top = 202.858380000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = -0.220470000000000000
          Top = 219.008040000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado manualmente...............................' +
              '.................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValTotMan: TfrxMemoView
          Left = 499.606680000000000000
          Top = 219.787570000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdTotMan: TfrxMemoView
          Left = 410.968770000000000000
          Top = 219.008040000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqTotMan: TfrxMemoView
          Left = 607.764070000000000000
          Top = 219.008040000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTextoTotalPIX: TfrxMemoView
          Left = 1.000000000000000000
          Top = 106.606370000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'PIX.............................................................' +
              '....................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalBrutoPIX: TfrxMemoView
          Left = 499.653543310000000000
          Top = 106.606370000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdTotalPIX: TfrxMemoView
          Left = 411.709030000000000000
          Top = 105.826840000000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotalLiquidoPIX: TfrxMemoView
          Left = 608.504330000000000000
          Top = 106.606370000000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTextoTotalBoleto: TfrxMemoView
          Left = 1.000000000000000000
          Top = 120.606370000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Boleto..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalBrutoBoleto: TfrxMemoView
          Left = 499.653543310000000000
          Top = 121.433070870000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdTotalBoleto: TfrxMemoView
          Left = 411.709030000000000000
          Top = 121.433070870000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotalLiquidoBoleto: TfrxMemoView
          Left = 608.504330000000000000
          Top = 121.433070870000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object rlbDetRede: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 381.732530000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetRedeOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 0.385382520000000000
          Width = 90.708666300000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."AUTORI"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 335.700990000000000000
          Width = 98.047310000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NUMCAR"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 435.779530000000000000
          Width = 58.582674720000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object rllDtaCre: TfrxMemoView
          Left = 498.897637800000000000
          Width = 60.472440940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 221.858380000000000000
          Width = 82.708663860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUM_RV"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 177.488250000000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PARCEL"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 95.488250000000000000
          Width = 79.370093390000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NUMCCD"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 640.740570000000000000
          Width = 75.590546300000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALLIQ"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 564.811380000000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORI"]')
          ParentFont = False
        end
        object rllCodigoBandeiraValor: TfrxMemoView
          Left = 304.000000000000000000
          Width = 30.708663860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CODIGO_BANDEIRA"]')
          ParentFont = False
        end
        object rllPercentualValor: TfrxMemoView
          Left = 557.000000000000000000
          Top = 1.000000000000000000
          Width = 27.590551180000000000
          Height = 13.228346460000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PERCENTUAL_TAXA"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo305: TfrxMemoView
          Left = 355.275820000000000000
          Width = 41.133833860000000000
          Height = 13.228346460000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TAXAS_MARKETPLACE"]')
          ParentFont = False
        end
        object Memo307: TfrxMemoView
          Left = 412.724638900000000000
          Width = 41.133833860000000000
          Height = 13.228346460000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FRETE_MARKETPLACE"]')
          ParentFont = False
        end
        object Memo310: TfrxMemoView
          Left = 476.598654650000000000
          Width = 41.133833860000000000
          Height = 13.228346460000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUPOM_MARKETPLACE"]')
          ParentFont = False
        end
      end
      object rlbCabGruInc: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 264.567100000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbCabGruIncOnBeforePrint'
        Condition = 'frxRelatorio."DESCRI"'
        object Memo25: TfrxMemoView
          Left = 134.551181100000000000
          Top = 4.000000000000000000
          Width = 668.976810000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Top = 4.000000000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Inconsist'#234'ncia: ')
          ParentFont = False
        end
      end
      object rlbRodGruInc: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 498.897960000000000000
        Width = 718.110700000000000000
        object Memo48: TfrxMemoView
          Top = 8.000000000000000000
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Tipo de Inconsist'#234'ncia')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 200.677490000000000000
          Top = 8.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 349.929500000000000000
          Top = 8.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 281.307360000000000000
          Top = 8.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetRede)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotInc: TfrxMemoView
          Left = 429.299630000000000000
          Top = 8.220469999999980000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotIncOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 532.913730000000000000
          Top = 7.559059999999990000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqInc: TfrxMemoView
          Left = 614.606680000000000000
          Top = 7.559059999999990000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqIncOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabGru_PV: TfrxGroupHeader
        FillType = ftBrush
        Height = 56.692913390000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbCabGru_PVOnBeforePrint'
        Condition = 'frxRelatorio."NUM_PV"'
        object Memo31: TfrxMemoView
          Left = 134.488250000000000000
          Top = 7.779529999999990000
          Width = 188.976443860000000000
          Height = 20.787406460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUM_PV"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Top = 8.000000000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ponto Venda:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 332.598640000000000000
          Top = 7.937007870000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 415.748300000000000000
          Top = 7.937007870000000000
          Width = 294.803283860000000000
          Height = 20.787406460000000000
          OnBeforePrint = 'Memo130OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '[frxRelatorio."DESEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object MemoDtaPag: TfrxMemoView
          Left = 164.787421100000000000
          Top = 30.236240000000000000
          Width = 551.811380000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAPAG"]')
          ParentFont = False
        end
        object MemoDtaPag_: TfrxMemoView
          Top = 30.236240000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data de pagamento:')
          ParentFont = False
        end
      end
      object rlbRodGru_PV: TfrxGroupFooter
        FillType = ftBrush
        Height = 245.669430470000000000
        Top = 551.811380000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbRodGru_PVOnBeforePrint'
        PrintChildIfInvisible = True
        object Shape7: TfrxShapeView
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo55: TfrxMemoView
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Resumo por Ponto de Venda')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 410.709030000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 498.653990000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object rllQtd_PV: TfrxMemoView
          Left = 408.709030000000000000
          Top = 197.338590000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
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
        object rllTot_PV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 198.118120000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Top = 213.236240000000000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo67: TfrxMemoView
          Top = 114.897650000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Valor da duplicata diferente do registrado no sistema...........' +
              '............................ :')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Top = 130.795300000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema...' +
              '................  :')
          ParentFont = False
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Top = 146.133890000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#245'es recebidos pelo Caixa e n'#227'o transferidos.................' +
              '............................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo70: TfrxMemoView
          Top = 162.031540000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica.........' +
              '.......................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVDifPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 114.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVNEnPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 130.795300000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVRcxPV: TfrxMemoView
          Left = 498.756340000000000000
          Top = 146.913420000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVBaiPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 163.031540000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllDif_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 115.559060000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllNen_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 130.015770000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllRcx_PV: TfrxMemoView
          Left = 409.488560000000000000
          Top = 146.133890000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBai_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 162.252010000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Top = 32.897650000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Parcelado...............................................' +
              '............................................... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Top = 48.795300000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Rotativo................................................' +
              '................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Top = 64.133890000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'D'#233'bito..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVParPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 32.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVRotPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 48.795300000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVDebPV: TfrxMemoView
          Left = 499.346940000000000000
          Top = 64.133890000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllPar_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 32.118120000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllRot_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 48.015770000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllDeb_PV: TfrxMemoView
          Left = 409.709030000000000000
          Top = 63.354360000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = -1.000000000000000000
          Top = 195.842610000000000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo88: TfrxMemoView
          Top = 198.118120000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Top = 112.252010000000000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo32: TfrxMemoView
          Top = 16.897650000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Antecipa'#231#227'o.....................................................' +
              '................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object rllAnt_PV: TfrxMemoView
          Left = 409.968770000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVAntPV: TfrxMemoView
          Left = 499.354670000000000000
          Top = 16.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 608.504330000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiq_PV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 198.338590000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllLDifPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 115.118120000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLNEnPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 131.015770000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLRcxPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 146.354360000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLBaiPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 162.252010000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLParPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 33.118120000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLRotPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 49.015770000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLDebPV: TfrxMemoView
          Left = 608.504330000000000000
          Top = 64.354360000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLAntPV: TfrxMemoView
          Left = 608.512060000000000000
          Top = 17.118120000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Subreport3: TfrxSubreport
          Top = 220.858380000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckbandeira
        end
        object Memo66: TfrxMemoView
          Top = 178.401670000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado manualmente...............................' +
              '................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVmanPV: TfrxMemoView
          Left = 498.827150000000000000
          Top = 179.181200000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllMan_PV: TfrxMemoView
          Left = 410.189240000000000000
          Top = 178.401670000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLManPV: TfrxMemoView
          Left = 607.984540000000000000
          Top = 178.401670000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTextoInconsistentePIX: TfrxMemoView
          Top = 80.149660000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'PIX.............................................................' +
              '....................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValorBrutoInconsistentePIX: TfrxMemoView
          Left = 499.346940000000000000
          Top = 80.149660000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdInconsistentePIX: TfrxMemoView
          Left = 409.709030000000000000
          Top = 80.370130000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllValorLiquidoInconsistentePIX: TfrxMemoView
          Left = 608.504330000000000000
          Top = 80.370130000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTextoInconsistenteBoleto: TfrxMemoView
          Top = 94.149660000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Boleto..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValorBrutoInconsistenteBoleto: TfrxMemoView
          Left = 499.346940000000000000
          Top = 94.110236220000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdInconsistenteBoleto: TfrxMemoView
          Left = 409.709030000000000000
          Top = 94.110236220000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllValorLiquidoInconsistenteBoleto: TfrxMemoView
          Left = 608.504330000000000000
          Top = 94.110236220000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object rlbCabGruTip: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 317.480520000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbCabGruTipOnBeforePrint'
        Condition = 'frxRelatorio."TIPCAR"'
        object Memo52: TfrxMemoView
          Left = 134.551181100000000000
          Top = 2.000000000000000000
          Width = 332.598640000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."TIPCAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo de cart'#227'o:')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Top = 22.677180000000000000
          Width = 716.220489530000000000
          Height = 15.118120000000000000
        end
        object Memo59: TfrxMemoView
          Top = 22.677180000000000000
          Width = 90.708683390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#250'mero NSU')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 222.165430000000000000
          Top = 22.677180000000000000
          Width = 82.708683390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Res. Venda')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 334.330860000000000000
          Top = 22.677180000000000000
          Width = 98.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero Cart'#227'o')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 564.771653540000000000
          Top = 22.677180000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. s/ Taxa')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 434.173470000000000000
          Top = 22.677180000000000000
          Width = 64.251968500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Venda')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 498.559370000000000000
          Top = 22.677180000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Venc.')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 177.267780000000000000
          Top = 22.677180000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 95.267780000000000000
          Top = 22.677180000000000000
          Width = 79.370093390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero Aut.')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 640.520100000000000000
          Top = 22.677180000000000000
          Width = 75.590546300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. L'#237'quido')
          ParentFont = False
        end
        object rllCodigoBandeira: TfrxMemoView
          Left = 303.000000000000000000
          Top = 23.000000000000000000
          Width = 30.708683390000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Ban.')
          ParentFont = False
        end
        object rllPercentual: TfrxMemoView
          Left = 560.000000000000000000
          Top = 23.000000000000000000
          Width = 19.590551180000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
        end
        object Memo304: TfrxMemoView
          Left = 355.275820000000000000
          Top = 22.677180000000000000
          Width = 41.133853390000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Taxa')
          ParentFont = False
        end
        object Memo306: TfrxMemoView
          Left = 412.724638900000000000
          Top = 22.677180000000000000
          Width = 41.133853390000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Frete')
          ParentFont = False
        end
        object Memo308: TfrxMemoView
          Left = 476.598654650000000000
          Top = 22.677180000000000000
          Width = 41.133853390000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cupom')
          ParentFont = False
        end
      end
      object rlbRodGruTip: TfrxGroupFooter
        FillType = ftBrush
        Height = 58.204724410000000000
        Top = 419.527830000000000000
        Width = 718.110700000000000000
        object Memo107: TfrxMemoView
          Top = 4.000000000000000000
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Tipo de Cart'#227'o')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 202.882190000000000000
          Top = 4.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo109: TfrxMemoView
          Left = 347.031850000000000000
          Top = 4.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 279.732530000000000000
          Top = 4.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetRede)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotTip: TfrxMemoView
          Left = 428.724800000000000000
          Top = 4.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo111: TfrxMemoView
          Left = 532.913730000000000000
          Top = 3.779530000000020000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqTip: TfrxMemoView
          Left = 614.606680000000000000
          Top = 3.779530000000020000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo314: TfrxMemoView
          Left = 347.716760000000000000
          Top = 39.795300000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Fretes')
          ParentFont = False
          WordWrap = False
        end
        object Memo315: TfrxMemoView
          Left = 429.330930790000000000
          Top = 40.015770000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."FRETE_MARKETPLACE">,rlbDetRede)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo311: TfrxMemoView
          Left = 347.716760000000000000
          Top = 22.677180000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Taxas')
          ParentFont = False
          WordWrap = False
        end
        object Memo312: TfrxMemoView
          Left = 429.330930790000000000
          Top = 22.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TAXAS_MARKETPLACE">,rlbDetRede)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo316: TfrxMemoView
          Left = 533.449390080000000000
          Top = 22.677180000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Cupons')
          ParentFont = False
          WordWrap = False
        end
        object Memo318: TfrxMemoView
          Left = 615.599050080000000000
          Top = 22.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CUPOM_MARKETPLACE">,rlbDetRede)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1878.426410000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'Child1OnAfterPrint'
        Child = frxPagina.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object Subreport1: TfrxSubreport
          Left = 1.779530000000000000
          Top = 7.559060000000040000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckSubRede
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 1731.024740000000000000
        Width = 718.110700000000000000
        Child = frxPagina.Child9
        PrintChildIfInvisible = True
        Stretched = True
        object Shape5: TfrxShapeView
          Top = 8.779530000000020000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo112: TfrxMemoView
          Top = 8.779530000000020000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RVs Faltando Arquivos de Venda')
          ParentFont = False
          WordWrap = False
        end
        object Memo113: TfrxMemoView
          Top = 24.897650000000100000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........................................................ :')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdSem: TfrxMemoView
          Left = 410.968770000000000000
          Top = 24.118120000000100000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllTotSem: TfrxMemoView
          Left = 583.047620000000000000
          Top = 23.897650000000100000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Subreport2: TfrxSubreport
          Left = 1.779530000000000000
          Top = 49.133890000000100000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckRedSem
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1572.284480000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child7OnBeforePrint'
        Child = frxPagina.Child3
        PrintChildIfInvisible = True
        object Subreport5: TfrxSubreport
          Top = 7.559060000000040000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckConcilPontoVenda
        end
      end
      object Child8: TfrxChild
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 1405.985160000000000000
        Width = 718.110700000000000000
        Child = frxPagina.rlbResumoTransferencias
        PrintChildIfInvisible = True
        object Shape10: TfrxShapeView
          Top = 7.559060000000040000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo135: TfrxMemoView
          Left = 1.779530000000000000
          Top = 7.559060000000040000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total dos Cart'#245'es (Conciliados + N'#227'o Conciliados)')
          ParentFont = False
          WordWrap = False
        end
        object Memo136: TfrxMemoView
          Left = 410.968770000000000000
          Top = 7.559060000000040000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo138: TfrxMemoView
          Left = 499.653543310000000000
          Top = 7.559060000000040000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo140: TfrxMemoView
          Left = 608.504330000000000000
          Top = 7.559060000000040000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdTotCar: TfrxMemoView
          Left = 410.968770000000000000
          Top = 24.118120000000100000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBruTotCar: TfrxMemoView
          Left = 499.653543310000000000
          Top = 24.118119999999900000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLiqTotCar: TfrxMemoView
          Left = 608.504330000000000000
          Top = 24.118120000000100000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Top = 23.677179999999900000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........................................................ :')
          ParentFont = False
          WordWrap = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1625.197900000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child3OnBeforePrint'
        Child = frxPagina.Child6
        PrintChildIfInvisible = True
        object Subreport4: TfrxSubreport
          Left = 1.220470000000000000
          Top = 6.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckbandeira
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 1931.339830000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Line8: TfrxLineView
          Top = 11.338590000000100000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo62: TfrxMemoView
          Left = 2.779530000000000000
          Top = 14.897650000000100000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[RESUMO]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1519.371060000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child5OnBeforePrint'
        Child = frxPagina.Child7
        PrintChildIfInvisible = True
        object Subreport7: TfrxSubreport
          Top = 7.559060000000040000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckCancelamentos
        end
      end
      object rlbResumoTransferencias: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1474.016700000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbResumoTransferenciasOnBeforePrint'
        Child = frxPagina.Child5
        PrintChildIfInvisible = True
        object subResumoTransferencias: TfrxSubreport
          Top = 3.779530000000020000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckResumoTransferencias
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1678.111320000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child6OnBeforePrint'
        Child = frxPagina.Child2
        PrintChildIfInvisible = True
        object Subreport10: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.Page1
        end
      end
      object rlbCabGruDTAPAG: TfrxGroupHeader
        FillType = ftBrush
        Top = 162.519790000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbCabGruDTAPAGOnBeforePrint'
        Condition = 'frxRelatorio."DTAPAG"'
      end
      object rlbRodGruDtaPag: TfrxGroupFooter
        FillType = ftBrush
        Height = 230.551310470000000000
        Top = 820.158010000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbRodGruDtaPagOnBeforePrint'
        PrintChildIfInvisible = True
        object Shape18: TfrxShapeView
          Top = 7.559060000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo205: TfrxMemoView
          Top = 7.559060000000000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Resumo dos pagamentos feitos em [frxRelatorio."DTAPAG"]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          Left = 410.078740157480000000
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo267: TfrxMemoView
          Left = 498.653990000000000000
          Top = 7.559060000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 205.984256850394000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
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
        object rllTotDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 205.984256850394000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Line9: TfrxLineView
          Top = 224.881894645669000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo274: TfrxMemoView
          Top = 122.834650550000000000
          Width = 410.078740160000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Valor da duplicata diferente do registrado no sistema...........' +
              '............................ :')
          ParentFont = False
          WordWrap = False
        end
        object Memo275: TfrxMemoView
          Top = 137.952760787402000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema...' +
              '................  :')
          ParentFont = False
          WordWrap = False
        end
        object Memo276: TfrxMemoView
          Top = 153.070871023622000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#245'es recebidos pelo Caixa e n'#227'o transferidos.................' +
              '............................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo277: TfrxMemoView
          Top = 168.188981259843000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica.........' +
              '.......................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVDifDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 122.834650551181000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVNEnDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 137.952760787402000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVRcxDtaPag: TfrxMemoView
          Left = 498.756340000000000000
          Top = 153.070871023622000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVBaiDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 168.188981259843000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllDifDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 122.834650550000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllNenDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 137.952760790000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllRcxDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 153.070871020000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBaiDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 168.188981259843000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo286: TfrxMemoView
          Top = 39.685044251968500000
          Width = 410.078740160000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Parcelado...............................................' +
              '............................................... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo287: TfrxMemoView
          Top = 54.803154490000000000
          Width = 410.078740160000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cr'#233'dito Rotativo................................................' +
              '................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object Memo288: TfrxMemoView
          Top = 69.921264720000000000
          Width = 410.078740160000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'D'#233'bito..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVParDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 39.685044251968500000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVRotDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 54.803154488189000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVDebDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 69.921264724409500000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllParDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 39.685044251968500000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllRotDtaPag: TfrxMemoView
          Left = 410.078740160000000000
          Top = 54.803154490000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllDebDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 69.921264724409500000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = -1.000000000000000000
          Top = 202.204729291339000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo295: TfrxMemoView
          Top = 205.984256850394000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Top = 119.055122992126000000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo296: TfrxMemoView
          Top = 24.456710000000000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Antecipa'#231#227'o.....................................................' +
              '................................................. :')
          ParentFont = False
          WordWrap = False
        end
        object rllAntDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 24.456710000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllVAntDtaPag: TfrxMemoView
          Left = 499.354670000000000000
          Top = 24.456710000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo299: TfrxMemoView
          Left = 608.504330000000000000
          Top = 7.559060000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 205.984256850394000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllLDifDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 122.834650551181000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLNEnDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 137.952760787402000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLRcxDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 153.070871023622000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLBaiDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 168.188981259843000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLParDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 39.685044251968500000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLRotDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 54.803154488189000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLDebDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 69.921264724409500000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLAntDtaPag: TfrxMemoView
          Left = 608.512060000000000000
          Top = 24.677180000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo309: TfrxMemoView
          Top = 183.307091496063000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Cart'#227'o j'#225' foi baixado manualmente...............................' +
              '................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllVmanDtaPag: TfrxMemoView
          Left = 498.827150000000000000
          Top = 183.307091496063000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllManDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 183.307091496063000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllLManDtaPag: TfrxMemoView
          Left = 608.503937007874000000
          Top = 183.307091496063000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo313: TfrxMemoView
          Top = 85.039374960629900000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'PIX.............................................................' +
              '....................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValorBrutoInconsistentePIXDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 85.039374960629900000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdInconsistentePIXDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 85.039374960629900000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllValorLiquidoInconsistentePIXDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 85.039374960629900000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo317: TfrxMemoView
          Top = 100.157485196850000000
          Width = 410.078740157480000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Boleto..........................................................' +
              '...................................................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValorBrutoInconsistenteBoletoDtaPag: TfrxMemoView
          Left = 499.346940000000000000
          Top = 100.157485196850000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllQtdInconsistenteBoletoDtaPag: TfrxMemoView
          Left = 410.078740157480000000
          Top = 100.157485196850000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllValorLiquidoInconsistenteBoletoDtaPag: TfrxMemoView
          Left = 608.504330000000000000
          Top = 100.157485196850000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child9: TfrxChild
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 1825.512990000000000000
        Width = 718.110700000000000000
        Child = frxPagina.Child1
        object Subreport11: TfrxSubreport
          Top = 7.559060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.Page2
        end
      end
    end
    object qckSubRede: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbGrp_Arquivos: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxListArq."DESCRI"'
        object Memo114: TfrxMemoView
          Left = 4.338590000000000000
          Top = 7.559060000000000000
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRI'
          DataSet = frxListArq
          DataSetName = 'frxListArq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxListArq."DESCRI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbListArq: TfrxMasterData
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 68.031540000000000000
        Width = 718.110700000000000000
        DataSet = frxListArq
        DataSetName = 'frxListArq'
        RowCount = 0
        object rllArquivos: TfrxMemoView
          Left = 4.338590000000000000
          Width = 702.992580000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMARQ'
          DataSet = frxListArq
          DataSetName = 'frxListArq'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxListArq."NOMARQ"]')
          ParentFont = False
        end
      end
      object FooterArqFaltaVenda: TfrxFooter
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 105.826840000000000000
        Visible = False
        Width = 718.110700000000000000
        Stretched = True
        object mmoArqFaltaRegVenda: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.574830000000000000
          Width = 710.551640000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Clipped = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ARQFALTAVENDA]')
          ParentFont = False
        end
        object mmoDescFaltaVendas: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 457.323130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REALIZE A IMPORTA'#199#195'O DOS REGISTROS DE VENDAS DO(S) DIA(S) ')
          ParentFont = False
        end
      end
    end
    object qckRedSem: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetSemArq: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 56.692950000000000000
        Width = 718.110700000000000000
        Columns = 2
        ColumnWidth = 340.157480314961000000
        ColumnGap = 37.795275590551200000
        DataSet = frxSemRed
        DataSetName = 'frxSemRed'
        RowCount = 0
        object Memo115: TfrxMemoView
          Left = 3.779530000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          DataField = 'NUM_PV'
          DataSet = frxSemRed
          DataSetName = 'frxSemRed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSemRed."NUM_PV"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 263.078850000000000000
          Width = 71.811033390000000000
          Height = 15.118120000000000000
          DataSet = frxSemRed
          DataSetName = 'frxSemRed'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSemRed."VALORI"]')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 198.283550000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataField = 'DTA_CV'
          DataSet = frxSemRed
          DataSetName = 'frxSemRed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxSemRed."DTA_CV"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 81.929190000000000000
          Width = 68.031503390000000000
          Height = 15.118120000000000000
          DataField = 'NUM_RV'
          DataSet = frxSemRed
          DataSetName = 'frxSemRed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSemRed."NUM_RV"]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 153.078850000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataField = 'PARCEL'
          DataSet = frxSemRed
          DataSetName = 'frxSemRed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxSemRed."PARCEL"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo120: TfrxMemoView
          Left = 3.779530000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero PV')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 263.078850000000000000
          Width = 71.811033390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Lan'#231'.')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 198.283550000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data RV')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 81.929190000000000000
          Width = 68.031503390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero RV')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 153.078850000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 380.834880000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero PV')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 640.134200000000000000
          Width = 71.811033390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Lan'#231'.')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 575.338900000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data RV')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 458.984540000000000000
          Width = 68.031503390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero RV')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 530.134200000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
      end
    end
    object qckbandeira: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 600.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbBanConcil: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotBan."CONCIL"'
        object Shape1: TfrxShapeView
          Top = 1.000000000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo1: TfrxMemoView
          Top = 1.000000000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo1OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Resumo por Bandeira do Ponto de Venda')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 410.709030000000000000
          Top = 1.000000000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 498.653990000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 608.504330000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbNomBan: TfrxGroupHeader
        FillType = ftBrush
        Top = 60.472480000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotBan."NOMBAN"'
      end
      object rlbBandeiras: TfrxMasterData
        FillType = ftBrush
        Height = 0.220460240000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbBandeirasOnBeforePrint'
        DataSet = frxTotBan
        DataSetName = 'frxTotBan'
        RowCount = 0
      end
      object rlbNomBanRodape: TfrxGroupFooter
        FillType = ftBrush
        Height = 16.629921260000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        object Memo9: TfrxMemoView
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTotBan."NOMBAN"]:')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 408.189240000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."QTDBAN">,rlbBandeiras)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 497.575140000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."VALBAN">,rlbBandeiras)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 606.732530000000000000
          Top = 0.220470000000006000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."LIQBAN">,rlbBandeiras)]')
          ParentFont = False
        end
      end
      object rlbConcilRodape: TfrxGroupFooter
        FillType = ftBrush
        Height = 10.960629920000000000
        Top = 143.622140000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Top = 1.779529999999990000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object qckConcilPontoVenda: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 400.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbConcilPV: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotBan."CONCIL"'
        object Shape4: TfrxShapeView
          Top = 1.000000000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo5: TfrxMemoView
          Top = 1.000000000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo5OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conciliados por Ponto de Venda')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 410.709030000000000000
          Top = 1.000000000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 498.653990000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 608.504330000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbEstabePV: TfrxGroupHeader
        FillType = ftBrush
        Top = 60.472480000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotBan."ESTABE"'
      end
      object rlbConcilEstabe: TfrxMasterData
        FillType = ftBrush
        Height = 0.220460240000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbConcilEstabeOnBeforePrint'
        DataSet = frxTotBan
        DataSetName = 'frxTotBan'
        RowCount = 0
      end
      object rlbEstabePV_Rodape: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        object Memo45: TfrxMemoView
          Width = 408.189240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTotBan."ESTABE"]:')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 408.189240000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."QTDBAN">,rlbConcilEstabe)]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 497.575140000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."VALBAN">,rlbConcilEstabe)]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 606.732530000000000000
          Top = 0.220470000000006000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxTotBan."LIQBAN">,rlbConcilEstabe)]')
          ParentFont = False
        end
      end
      object rlbConcilPV_Rodape: TfrxGroupFooter
        FillType = ftBrush
        Height = 10.960629920000000000
        Top = 143.622140000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Top = 1.779529999999990000
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object qckCancelamentos: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.023622050000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object Memo141: TfrxMemoView
          Left = 138.330711100000000000
          Top = 7.559060000000000000
          Width = 668.976810000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Inconsist'#234'ncia: ')
          ParentFont = False
        end
        object Shape11: TfrxShapeView
          Top = 33.236240000000000000
          Width = 716.220489530000000000
          Height = 15.118120000000000000
        end
        object Memo143: TfrxMemoView
          Left = 256.008035110000000000
          Top = 33.236240000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#250'mero NSU')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 433.716760000000000000
          Top = 33.236240000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero Cart'#227'o')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 586.913730000000000000
          Top = 33.236240000000000000
          Width = 60.472426300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 528.173470000000000000
          Top = 33.236240000000000000
          Width = 56.692891420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Venda')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 402.582870000000000000
          Top = 33.236240000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 342.976380380000000000
          Top = 33.236240000000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. Aut.')
          ParentFont = False
        end
        object Memo152: TfrxMemoView
          Left = 648.740570000000000000
          Top = 33.236240000000000000
          Width = 64.251956300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 1.779530000000000000
          Top = 33.015770000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Motivo/Descri'#231#227'o')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 94.488250000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupHeader3OnBeforePrint'
        Condition = 'frxRelatorio."NUM_PV"'
        object Memo156: TfrxMemoView
          Left = 1.559060000000000000
          Width = 83.149603860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ponto de Venda:')
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 92.267780000000000000
          Width = 158.740203860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUM_PV"]')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 132.283550000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData2OnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo157: TfrxMemoView
          Left = 402.669291340000000000
          Width = 30.236215590000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PARCEL"]')
          ParentFont = False
        end
        object Memo158: TfrxMemoView
          Left = 335.417322830000000000
          Width = 64.251970940000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NUMCCD"]')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Left = 587.047244090000000000
          Width = 60.472438500000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORI"]')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Width = 253.228453860000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'Memo155OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."CODCLI"]-[frxRelatorio."NOMCLI"] - [frxRelatorio.' +
              '"FONCLI"]')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 649.566929130000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALLIQ"]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Left = 527.575140000000000000
          Width = 56.692913390000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 433.866420000000000000
          Width = 94.488193860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMCAR"]')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 256.008040000000000000
          Width = 75.590558500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."AUTORI"]')
          ParentFont = False
        end
      end
      object GroupFooter4: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 170.078850000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupFooter4OnBeforePrint'
        object Memo63: TfrxMemoView
          Left = 225.567100000000000000
          Top = 2.440940000000010000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdCanPV: TfrxMemoView
          Left = 306.196970000000000000
          Top = 2.440940000000010000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 542.551330000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiqCanPV: TfrxMemoView
          Left = 625.244280000000000000
          Top = 3.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo71: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Ponto de Venda:')
          ParentFont = False
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 367.834880000000000000
          Top = 3.118120000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto:')
          ParentFont = False
          WordWrap = False
        end
        object rllBruCanPV: TfrxMemoView
          Left = 449.527830000000000000
          Top = 3.118120000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        Stretched = True
        object rllMenAju: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779529999999990000
          Width = 699.213050000000000000
          Height = 26.456710000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Esses registros devem ser lan'#231'ados manualmente na Movimenta'#231#227'o ' +
              'Banc'#225'ria.')
          ParentFont = False
        end
      end
    end
    object qckMarketPLace: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'qckMarketPLaceOnBeforePrint'
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 62.307050000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo74: TfrxMemoView
          Align = baCenter
          Left = 136.932530000000000000
          Top = 16.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
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
        object Memo76: TfrxMemoView
          Left = 1241.757700000000000000
          Width = 115.200000000000000000
          Height = 17.007874020000000000
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
        object Memo77: TfrxMemoView
          Left = 1308.655350000000000000
          Top = 16.000000000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo82: TfrxMemoView
          Left = 1245.753000000000000000
          Top = 16.000000000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo83: TfrxMemoView
          Align = baCenter
          Left = 140.712060000000000000
          Width = 474.481880000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 701.406680000000000000
          Top = 16.118120000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo85: TfrxMemoView
          Left = 638.504330000000000000
          Top = 16.118120000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo86: TfrxMemoView
          Align = baCenter
          Left = 136.932530000000000000
          Top = 38.354360000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
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
      object rlbGrupoInconsistenciaMKt: TfrxGroupHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 196.535560000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object Memo87: TfrxMemoView
          Left = 125.551181100000000000
          Top = 5.000000000000000000
          Width = 619.842920000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 2.000000000000000000
          Top = 4.000000000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Inconsist'#234'ncia: ')
          ParentFont = False
        end
        object Shape8: TfrxShapeView
          Top = 34.015770000000000000
          Width = 754.015789530000000000
          Height = 15.118120000000000000
        end
        object rllDesChave1Mkt: TfrxMemoView
          Top = 34.015770000000000000
          Width = 83.149623390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Shipping ID')
          ParentFont = False
        end
        object rllDesValorBrutoMkt: TfrxMemoView
          Left = 391.937230000000000000
          Top = 34.015770000000000000
          Width = 59.716520790000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr Bruto')
          ParentFont = False
        end
        object rllDesDataVendaMkt: TfrxMemoView
          Left = 258.858380000000000000
          Top = 34.015770000000000000
          Width = 64.251951420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Venda')
          ParentFont = False
        end
        object rllDesDataVencimentoMkt: TfrxMemoView
          Left = 325.464750000000000000
          Top = 34.015770000000000000
          Width = 64.251966060000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Venc.')
          ParentFont = False
        end
        object rllDesParcelaMkt: TfrxMemoView
          Left = 215.267780000000000000
          Top = 34.015770000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
        end
        object rllDesChave2Mkt: TfrxMemoView
          Left = 89.196850393700800000
          Top = 34.015770000000000000
          Width = 79.370093390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'External Ref.')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 691.740570000000000000
          Top = 34.015770000000000000
          Width = 58.582667400000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'q.')
          ParentFont = False
        end
        object rllDesTaxasMkt: TfrxMemoView
          Left = 453.645950000000000000
          Top = 34.015770000000000000
          Width = 56.692896300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr Taxas')
          ParentFont = False
        end
        object rllDesFreteMkt: TfrxMemoView
          Left = 512.457020000000000000
          Top = 34.015770000000000000
          Width = 52.913378500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr Frete')
          ParentFont = False
        end
        object rllDesAjustesMkt: TfrxMemoView
          Left = 567.236550000000000000
          Top = 34.015770000000000000
          Width = 60.472426300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr Ajustes')
          ParentFont = False
        end
        object rllDesCupomMarketPlace: TfrxMemoView
          Left = 629.504330000000000000
          Top = 34.118120000000000000
          Width = 60.472438500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr Cupom')
          ParentFont = False
        end
        object mmoCodEmp: TfrxMemoView
          Left = 183.078850000000000000
          Top = 34.015770000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp')
          ParentFont = False
        end
      end
      object rlbRegistrosMkt: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 272.126160000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebraMkt: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          WordWrap = False
        end
        object rllChave1Mkt: TfrxMemoView
          Width = 86.929136300000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."AUTORI"]')
          ParentFont = False
        end
        object rllParcelaMkt: TfrxMemoView
          Left = 215.370078740000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PARCEL"]')
          ParentFont = False
        end
        object rllChave2Mkt: TfrxMemoView
          Left = 89.354330710000000000
          Width = 98.267716540000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMCCD"]')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 693.740570000000000000
          Width = 58.582667400000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LIQUIDO_MARKETPLACE"]')
          ParentFont = False
        end
        object rllTaxasMkt: TfrxMemoView
          Left = 453.645950000000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TAXAS_MARKETPLACE"]')
          ParentFont = False
        end
        object rllDataVencimentoMkt: TfrxMemoView
          Left = 325.354330710000000000
          Width = 64.251966060000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
        end
        object rllDataVendaMkt: TfrxMemoView
          Left = 258.834645670000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object rllValorBrutoMkt: TfrxMemoView
          Left = 391.992135750000000000
          Width = 59.716520790000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BRUTO_MARKETPLACE"]')
          ParentFont = False
        end
        object rllFreteMkt: TfrxMemoView
          Left = 512.457020000000000000
          Width = 52.913385830000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FRETE_MARKETPLACE"]')
          ParentFont = False
        end
        object rllAjustesMkt: TfrxMemoView
          Left = 567.236550000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."AJUSTES_MARKETPLACE"]')
          ParentFont = False
        end
        object rllCupomMarketPlace: TfrxMemoView
          Left = 629.504330000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUPOM_MARKETPLACE"]')
          ParentFont = False
        end
        object rllCodEmp: TfrxMemoView
          Left = 189.976500000000000000
          Width = 22.677180000000000000
          Height = 13.228346460000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
        end
      end
      object rlbGrupoTotalInconsistenciaMkt: TfrxGroupFooter
        FillType = ftBrush
        Height = 75.590580470000000000
        Top = 309.921460000000000000
        Width = 755.906000000000000000
        object Memo172: TfrxMemoView
          Left = 4.000000000000000000
          Top = 8.000000000000000000
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Tipo de Inconsist'#234'ncia')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 238.677490000000000000
          Top = 8.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo174: TfrxMemoView
          Left = 387.929500000000000000
          Top = 8.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
          WordWrap = False
        end
        object Memo175: TfrxMemoView
          Left = 319.307360000000000000
          Top = 8.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Width = 754.015748030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotalBrutoMKt: TfrxMemoView
          Left = 467.299630000000000000
          Top = 8.220469999999980000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BRUTO_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo177: TfrxMemoView
          Left = 574.693260000000000000
          Top = 44.015770000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalLiquidoMkt: TfrxMemoView
          Left = 656.386210000000000000
          Top = 44.015770000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."LIQUIDO_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo163: TfrxMemoView
          Left = 388.496290000000000000
          Top = 26.456710000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Taxas')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalTaxasMkt: TfrxMemoView
          Left = 467.866420000000000000
          Top = 26.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TAXAS_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo165: TfrxMemoView
          Left = 388.496290000000000000
          Top = 43.574830000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Fretes')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalFretesMKt: TfrxMemoView
          Left = 467.866420000000000000
          Top = 43.795300000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."FRETE_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo167: TfrxMemoView
          Left = 574.913730000000000000
          Top = 7.559059999999990000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Ajustes')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalAjustesMkt: TfrxMemoView
          Left = 656.283860000000000000
          Top = 7.779530000000020000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."AJUSTES_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object rllDesTotalCuponsMarketPlace: TfrxMemoView
          Left = 575.252320000000000000
          Top = 26.456710000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Cupons')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalCuponsMarketPlace: TfrxMemoView
          Left = 656.622450000000000000
          Top = 26.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CUPOM_MARKETPLACE">,rlbRegistrosMkt)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumarioMkt: TfrxReportSummary
        FillType = ftBrush
        Height = 283.464613310000000000
        Top = 476.220780000000000000
        Width = 755.906000000000000000
        Child = frxPagina.rlbSomaTotalMkt
        PrintChildIfInvisible = True
        StartNewPage = True
        object Shape9: TfrxShapeView
          Top = 27.338590000000000000
          Width = 754.015748030000000000
          Height = 15.118120000000000000
        end
        object Memo179: TfrxMemoView
          Left = 1055.788190000000000000
          Top = 3.779530000000020000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
          WordWrap = False
        end
        object Memo180: TfrxMemoView
          Left = 1010.433830000000000000
          Top = 19.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllValParOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 815.118740000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllQtdParOnBeforePrint'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 1.779530000000000000
          Top = 27.338590000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedidos Conciliados (marcados no filtro)')
          ParentFont = False
          WordWrap = False
        end
        object Memo183: TfrxMemoView
          Left = 249.070866140000000000
          Top = 27.338590000000000000
          Width = 34.015748031496100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          WordWrap = False
        end
        object Memo184: TfrxMemoView
          Left = 284.976377950000000000
          Top = 27.338590000000000000
          Width = 66.141732283464600000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
          WordWrap = False
        end
        object Memo185: TfrxMemoView
          Left = 1.000000000000000000
          Top = 58.456710000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos cancelados (conciliados).......................... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo186: TfrxMemoView
          Left = 1.000000000000000000
          Top = 74.354360000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos conciliados com taxas ou frete diverg...... :')
          ParentFont = False
          WordWrap = False
        end
        object rllBrutoZeradosMkt: TfrxMemoView
          Left = 284.976377950000000000
          Top = 58.456710000000000000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllBrutoDivergentesMkt: TfrxMemoView
          Left = 284.976377950000000000
          Top = 74.354360000000000000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object c: TfrxMemoView
          Left = 249.070866140000000000
          Top = 57.677180000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conciliados)' +
              #39')]')
          ParentFont = False
        end
        object rllQuantidadeDivergentesMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 74.574830000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de' +
              ' taxas ou frete divergentes'#39')]')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 1.000000000000000000
          Top = 42.456710000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Pedidos conciliados.............................................' +
              '.. :')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeConciliadosMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 42.456710000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[QUANTIDADECONCILIADOSMKT-'
            
              ' SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conciliados)' +
              #39')-'
            
              ' SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de' +
              ' taxas ou frete divergentes'#39')-'
            
              ' SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de' +
              ' cupom divergente'#39')]')
          ParentFont = False
        end
        object rllBrutoConciliadosMkt: TfrxMemoView
          Left = 284.976377950000000000
          Top = 44.236240000000000000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BRUTOCONCILIADOSMKT-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object Memo197: TfrxMemoView
          Top = 118.708720000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........... :')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeTotalConciliadosMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 118.929190000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[QUANTIDADECONCILIADOSMKT]')
          ParentFont = False
        end
        object rllBrutoTotalConciliadosMkt: TfrxMemoView
          Left = 284.976377950000000000
          Top = 118.708720000000000000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BRUTOCONCILIADOSMKT]')
          ParentFont = False
        end
        object Memo200: TfrxMemoView
          Left = 694.299212600000000000
          Top = 27.338590000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllLiquidoZeradosMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 58.456710000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllLiquidoDivergentesMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 74.354360000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."LIQUIDO_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllLiquidoConciliadosMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 43.456710000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LIQUIDOCONCILIADOSMKT-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."LIQUIDO_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),' +
              'rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllLiquidoTotalConciliadosMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 118.708720000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LIQUIDOCONCILIADOSMKT]')
          ParentFont = False
        end
        object Shape12: TfrxShapeView
          Top = 149.385900000000000000
          Width = 754.015748030000000000
          Height = 15.118120000000000000
        end
        object Memo206: TfrxMemoView
          Left = 1.779530000000000000
          Top = 149.385900000000000000
          Width = 245.669291338583000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedidos n'#227'o Conciliados')
          ParentFont = False
          WordWrap = False
        end
        object Memo207: TfrxMemoView
          Left = 249.070866141732000000
          Top = 149.385900000000000000
          Width = 34.015748031496100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          WordWrap = False
        end
        object Memo208: TfrxMemoView
          Left = 284.976377952756000000
          Top = 149.385900000000000000
          Width = 66.141732283464600000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeTotalNaoConciliadosMkt: TfrxMemoView
          Left = 249.070866141732000000
          Top = 226.504020000000000000
          Width = 34.015748031496100000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[QUANTIDADECANCELADOSMKT+SUM(<frxRelatorio."DESCRI"> = '#39'Registro' +
              ' do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39')+SUM(<frx' +
              'Relatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia' +
              #231#227'o autom'#225'tica'#39')+SUM(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi ba' +
              'ixado manualmente'#39')]')
          ParentFont = False
        end
        object rllBrutoTotanNaoConciliadosMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 226.504020000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[LIQUIDOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registr' +
              'o do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRel' +
              'atorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRela' +
              'torio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o ' +
              'autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosM' +
              'kt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado man' +
              'ualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto div' +
              'ergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ']')
          ParentFont = False
        end
        object Memo211: TfrxMemoView
          Left = 694.181510000000000000
          Top = 149.385900000000000000
          Width = 60.472428740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object Memo212: TfrxMemoView
          Left = 694.181510000000000000
          Top = 226.504020000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[LIQUIDOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registr' +
              'o do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRel' +
              'atorio."LIQUIDO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227 +
              'o autom'#225'tica'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado' +
              ' manualmente'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bru' +
              'to divergente'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegis' +
              'trosMkt)]')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          Top = 227.063080000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........... :')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeCancelamentoMkt: TfrxMemoView
          Left = 249.070866141732000000
          Top = 165.504020000000000000
          Width = 34.015748031496100000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllBrutoCancelamentoMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 165.504020000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LIQUIDOCANCELADOSMKT]')
          ParentFont = False
        end
        object rllLiquidoCancelamentoMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 165.504020000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LIQUIDOCANCELADOSMKT]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          Top = 165.063080000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cancelamentos/Ajustes......................................... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo218: TfrxMemoView
          Left = 7.559060000000000000
          Top = 248.858380000000000000
          Width = 498.897960000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Registros de Cancelamentos/Ajustes ser'#227'o listados na inconsist'#234 +
              'ncia abaixo.'
            
              '**Registros de Cancelamentos/Ajustes com valor l'#237'quido zerados s' +
              #227'o meramente informativos e n'#227'o ser'#227'o baixados.')
          ParentFont = False
          WordWrap = False
        end
        object Memo219: TfrxMemoView
          Top = 11.338590000000000000
          Width = 754.015772440000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Style = fsDot
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Total Geral')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeinconsisteMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 179.960730000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontra' +
              'do nos lan'#231'amentos do sistema'#39')+SUM(<frxRelatorio."DESCRI"> = '#39'P' +
              'edidos com valor bruto divergente'#39')]')
          ParentFont = False
        end
        object rllBrutoInconsistentesMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 179.960730000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pe' +
              'didos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllLiquidoInconsistentesMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 179.960730000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."LIQUIDO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39 +
              'Pedidos com valor bruto divergente'#39', <frxRelatorio."LIQUIDO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object Memo223: TfrxMemoView
          Top = 179.519790000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Inconsistentes..................................................' +
              '..... :')
          ParentFont = False
          WordWrap = False
        end
        object Memo224: TfrxMemoView
          Top = 194.637910000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedido j'#225' foi baixado atrav'#233's de conc. autom'#225'tica:')
          ParentFont = False
          WordWrap = False
        end
        object rllBrutoBaixadosConcMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 195.637910000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllQuantidadeBaixadosConcMkt: TfrxMemoView
          Left = 249.070866141732000000
          Top = 194.858380000000000000
          Width = 34.015748031496100000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de' +
              ' concilia'#231#227'o autom'#225'tica'#39')]')
          ParentFont = False
        end
        object rllLiquidoBaixadosConcMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 194.858380000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."LIQUIDO_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Top = 211.008040000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedido j'#225' foi baixado manualmente....................... :')
          ParentFont = False
          WordWrap = False
        end
        object rllBrutoBaixadosManualMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 211.787570000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllQuantidadeBaixadosManualMkt: TfrxMemoView
          Left = 249.070866141732000000
          Top = 211.008040000000000000
          Width = 34.015748031496100000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manualment' +
              'e'#39')]')
          ParentFont = False
        end
        object rllLiquidoBaixadosManualMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 211.008040000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ']')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 352.629921260000000000
          Top = 26.456710000000000000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Taxas')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTaxasConciliadosMkt: TfrxMemoView
          Left = 352.629921260000000000
          Top = 44.354360000000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TAXASCONCILIADOSMKT-'
            
              ' (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concili' +
              'ados)'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '  SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com val' +
              'or de taxas ou frete divergentes'#39', <frxRelatorio."TAXAS_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+'
            
              '  SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com val' +
              'or de cupom divergente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),r' +
              'lbRegistrosMkt))]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 407.055118110236000000
          Top = 27.456710000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object rllPercentualTaxasConciliadosMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 43.574830000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT-'
            
              '      SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (con' +
              'ciliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)-'
            
              '      SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com' +
              ' valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)-'
            
              '      SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com' +
              ' valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,' +
              '0),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((TAXASCONCILIADOSMKT-'
            
              '                                       (SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."TAX' +
              'AS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt))) / '
            '                                      (BRUTOCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."BRUT' +
              'O_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 440.314960630000000000
          Top = 26.456710000000000000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fretes')
          ParentFont = False
          WordWrap = False
        end
        object Memo234: TfrxMemoView
          Left = 494.362204724410000000
          Top = 26.456710000000000000
          Width = 34.015701650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo235: TfrxMemoView
          Left = 528.755905510000000000
          Top = 26.456710000000000000
          Width = 52.913385830000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Ajustes')
          ParentFont = False
          WordWrap = False
        end
        object Memo236: TfrxMemoView
          Left = 584.314960630000000000
          Top = 26.456710000000000000
          Width = 34.015701650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object rllValorFreteConciliadosMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 43.464566930000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FRETECONCILIADOSMKT-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."FRETE_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteConciliadosMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 43.464566930000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((FRETECONCILIADOSMKT-'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."FRE' +
              'TE_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diver' +
              'gentes'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <' +
              'frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            '                                       (BRUTOCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."BRUT' +
              'O_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesConciliados: TfrxMemoView
          Left = 528.795275590000000000
          Top = 43.464566930000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUSTESCONCILIADOSMKT-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."AJUSTES_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)-'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),' +
              'rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualAjustesConciliadosMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 43.464566930000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((AJUSTESCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."AJUS' +
              'TES_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              '-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            '                                      (BRUTOCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."BRUT' +
              'O_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorTaxasZeradosMkt: TfrxMemoView
          Left = 352.629921260000000000
          Top = 60.362273070000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasZeradosMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 59.582743070000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos cancelados (conciliados)'#39', <frxRelatorio."TAXAS_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pe' +
              'didos cancelados (conciliados)'#39', <frxRelatorio."BRUTO_MARKETPLAC' +
              'E">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorFreteZeradosMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 59.472480000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteZeradosMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 59.472480000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos cancelados (conciliados)'#39', <frxRelatorio."FRETE_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pe' +
              'didos cancelados (conciliados)'#39', <frxRelatorio."BRUTO_MARKETPLAC' +
              'E">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesZeradosMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 59.472480000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualAjustesZeradosMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 59.472480000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos cancelados (conciliados)'#39', <frxRelatorio."AJUSTES_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = '#39 +
              'Pedidos cancelados (conciliados)'#39', <frxRelatorio."BRUTO_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorTaxasDivergentesMkt: TfrxMemoView
          Left = 352.629921260000000000
          Top = 75.480393070000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."TAXAS_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasDivergentesMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 74.700863070000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de taxas ou frete divergentes'#39', <frxR' +
              'elatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de taxas ' +
              'ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlb' +
              'RegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorFreteDivergentesMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 74.590600000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."FRETE_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteDivergentesMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 74.590600000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de taxas ou frete divergentes'#39', <frxR' +
              'elatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de taxas ' +
              'ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlb' +
              'RegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesDivergentesMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 74.590600000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."AJUSTES_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualAjustesDivergentesMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 74.590600000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de taxas ou frete divergentes'#39', <frxR' +
              'elatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(' +
              '<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de taxa' +
              's ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),r' +
              'lbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllTaxasTotalConciliadosMkt: TfrxMemoView
          Left = 352.629921260000000000
          Top = 119.157573070000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TAXASCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualTaxasTotalConciliadosMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 118.378043070000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (TAXASCONCILIADOSMKT / BRUTOCONCILIADOSM' +
              'KT) * 100))]')
          ParentFont = False
        end
        object rllFreteTotalConciliadosMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 118.267780000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FRETECONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualFreteTotalConciliadosMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 118.267780000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (FRETECONCILIADOSMKT / BRUTOCONCILIADOSM' +
              'KT) * 100))]')
          ParentFont = False
        end
        object rllAjustesTotalConciliadosMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 118.267780000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUSTESCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualAjustesTotalConciliadosMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 118.267780000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (AJUSTESCONCILIADOSMKT / BRUTOCONCILIADO' +
              'SMKT) * 100))]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 352.629921259843000000
          Top = 149.385900000000000000
          Width = 52.913385826771700000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Taxas')
          ParentFont = False
          WordWrap = False
        end
        object Memo215: TfrxMemoView
          Left = 406.984540000000000000
          Top = 149.385900000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo237: TfrxMemoView
          Left = 440.354330710000000000
          Top = 149.385900000000000000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fretes')
          ParentFont = False
          WordWrap = False
        end
        object Memo238: TfrxMemoView
          Left = 494.401574800000000000
          Top = 149.385900000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo239: TfrxMemoView
          Left = 528.795275590000000000
          Top = 149.385900000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Ajustes')
          ParentFont = False
          WordWrap = False
        end
        object Memo240: TfrxMemoView
          Left = 584.149564800000000000
          Top = 149.385900000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTaxasInconsistentesMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 179.960730000000000000
          Width = 52.913385826771700000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."TAXAS_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasInconsistentesMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 179.960730000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o ' +
              'encontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MAR' +
              'KETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> =' +
              ' '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."T' +
              'AXAS_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            
              '   (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o e' +
              'ncontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorFreteInconsistentesMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 179.960730000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."FRETE_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteInconsistentesMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 179.960730000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o ' +
              'encontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MAR' +
              'KETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> =' +
              ' '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."F' +
              'RETE_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            
              '   (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o e' +
              'ncontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesInconsistentesMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 179.960730000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."AJUSTES_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')]')
          ParentFont = False
        end
        object rllPercentualAjustesInconsistentesMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 179.960730000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o ' +
              'encontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MAR' +
              'KETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> =' +
              ' '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."A' +
              'JUSTES_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            
              '   (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o e' +
              'ncontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorTaxasBaixadosConcMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 195.637910000000000000
          Width = 52.913385826771700000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."TAXAS_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasBaixadosConcMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 195.637910000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'ido j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelat' +
              'orio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227 +
              'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistro' +
              'sMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorFreteBaixadosConcMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 195.637910000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."FRETE_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteBaixadosConcMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 195.637910000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'ido j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelat' +
              'orio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227 +
              'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistro' +
              'sMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesBaixadosConcMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 195.637910000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."AJUSTES_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualAjustesBaixadosConcMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 195.637910000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'ido j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelat' +
              'orio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frx' +
              'Relatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia' +
              #231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorTaxasBaixadosManualMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 211.653680000000000000
          Width = 52.913385826771700000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasBaixadosManualMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 211.653680000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado ma' +
              'nualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)=0, '
            '  0.00, '
            
              '  FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'P' +
              'edido j'#225' foi baixado manualmente'#39', <frxRelatorio."TAXAS_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKET' +
              'PLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorFreteBaixadosManualMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 211.653680000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteBaixadosManualMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 211.653680000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado ma' +
              'nualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)=0, '
            '  0.00, '
            
              '  FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'P' +
              'edido j'#225' foi baixado manualmente'#39', <frxRelatorio."FRETE_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKET' +
              'PLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorAjustesBaixadosManualMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 211.653680000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ']')
          ParentFont = False
        end
        object rllPercentualAjustesBaixadosManualMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 211.653680000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado ma' +
              'nualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)=0, '
            '  0.00, '
            
              '  FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'P' +
              'edido j'#225' foi baixado manualmente'#39', <frxRelatorio."AJUSTES_MARKET' +
              'PLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorTaxasTotalNaoConciliadosMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 226.771800000000000000
          Width = 52.913385826771700000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."TAXAS_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."TAXAS_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasTotalNaoConciliadosMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 226.771800000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'R' +
              'egistro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <' +
              'frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concil' +
              'ia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegi' +
              'strosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixa' +
              'do manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bru' +
              'to divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistr' +
              'osMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."TAXAS_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro' +
              ' do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRela' +
              'torio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelat' +
              'orio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o a' +
              'utom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manu' +
              'almente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              '+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object rllValorFreteTotalNaoConciliadosMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 226.771800000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."FRETE_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."FRETE_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteTotalNaoConciliadosMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 226.771800000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'R' +
              'egistro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <' +
              'frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concil' +
              'ia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegi' +
              'strosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixa' +
              'do manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bru' +
              'to divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistr' +
              'osMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."FRETE_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro' +
              ' do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRela' +
              'torio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelat' +
              'orio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o a' +
              'utom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manu' +
              'almente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              '+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object rllValorAjustesTotalNaoConciliadosMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 226.771800000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."AJUSTES_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."AJUSTES_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ']')
          ParentFont = False
        end
        object rllPercentualAjustesTotalNaoConciliadosMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 226.771800000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'R' +
              'egistro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <' +
              'frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concil' +
              'ia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegi' +
              'strosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixa' +
              'do manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bru' +
              'to divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistr' +
              'osMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."AJUSTES_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ') /'
            
              ' (BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro' +
              ' do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRela' +
              'torio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelat' +
              'orio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o a' +
              'utom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manu' +
              'almente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              '+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object Memo221: TfrxMemoView
          Left = 1.000000000000000000
          Top = 90.708720000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Pedidos conciliados com cupom divergente.......... :')
          ParentFont = False
          WordWrap = False
        end
        object rllBrutoCuponsDivergentesMkt: TfrxMemoView
          Left = 284.976377950000000000
          Top = 90.708720000000000000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object rllQuantidadeCuponsDivergentesMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 90.929190000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de' +
              ' cupom divergente'#39')]')
          ParentFont = False
        end
        object Memo251: TfrxMemoView
          Left = 694.181510000000000000
          Top = 90.708720000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),' +
              'rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllValorTaxasCuponsDivergentesMkt: TfrxMemoView
          Left = 352.629921260000000000
          Top = 91.834753070000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasCuponsDivergentesMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 91.055223070000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de cupom divergente'#39', <frxRelatorio."' +
              'TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatori' +
              'o."DESCRI"> = '#39'Pedidos conciliados com valor de cupom divergente' +
              #39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 10' +
              '0))]')
          ParentFont = False
        end
        object rllValorFreteCuponsDivergentesMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 90.944960000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteCuponsDivergentesMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 90.944960000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de cupom divergente'#39', <frxRelatorio."' +
              'FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatori' +
              'o."DESCRI"> = '#39'Pedidos conciliados com valor de cupom divergente' +
              #39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 10' +
              '0))]')
          ParentFont = False
        end
        object rllValorAjustesCuponsDivergentesMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 90.944960000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),' +
              'rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualAjustesCuponsDivergentesMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 90.944960000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de cupom divergente'#39', <frxRelatorio."' +
              'AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelato' +
              'rio."DESCRI"> = '#39'Pedidos conciliados com valor de cupom divergen' +
              'te'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * ' +
              '100))]')
          ParentFont = False
        end
        object rllValorCuponsConciliados: TfrxMemoView
          Left = 617.622450000000000000
          Top = 44.354360000000000000
          Width = 45.354291650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUPONSCONCILIADOSMKT-'
            
              ' (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concili' +
              'ados)'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '  SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com val' +
              'or de taxas ou frete divergentes'#39', <frxRelatorio."CUPOM_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+'
            
              '  SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com val' +
              'or de cupom divergente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),r' +
              'lbRegistrosMkt))]')
          ParentFont = False
        end
        object rllPercentualCuponsConciliadosMkt: TfrxMemoView
          Left = 662.976810000000000000
          Top = 44.354360000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)-'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((CUPONSCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."CUPO' +
              'M_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            '                                      (BRUTOCONCILIADOSMKT-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos cancelados (conciliados)'#39', <frxRelatorio."BRUT' +
              'O_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de taxas ou frete diverg' +
              'entes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)-'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos conciliados com valor de cupom divergente'#39', <f' +
              'rxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object Memo269: TfrxMemoView
          Left = 662.929133860000000000
          Top = 26.456710000000000000
          Width = 29.858267720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo270: TfrxMemoView
          Left = 617.574803150000000000
          Top = 26.456710000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cupons')
          ParentFont = False
          WordWrap = False
        end
        object rllValorCuponsZeradosMkt: TfrxMemoView
          Left = 617.622450000000000000
          Top = 59.472480000000000000
          Width = 45.354291650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (concilia' +
              'dos)'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsZeradosMkt: TfrxMemoView
          Left = 662.976810000000000000
          Top = 59.472480000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos cancelados (conc' +
              'iliados)'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos cancelados (conciliados)'#39', <frxRelatorio."CUPOM_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pe' +
              'didos cancelados (conciliados)'#39', <frxRelatorio."BRUTO_MARKETPLAC' +
              'E">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorCuponsDivergentesMkt: TfrxMemoView
          Left = 617.622450000000000000
          Top = 75.590600000000000000
          Width = 45.354291650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de taxas ou frete divergentes'#39', <frxRelatorio."CUPOM_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsDivergentesMkt: TfrxMemoView
          Left = 662.976810000000000000
          Top = 75.590600000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de taxas ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de taxas ou frete divergentes'#39', <frxR' +
              'elatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valor de taxas ' +
              'ou frete divergentes'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlb' +
              'RegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorCupomCuponsDivergentesMkt: TfrxMemoView
          Left = 617.622450000000000000
          Top = 90.708720000000000000
          Width = 45.354291650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com valo' +
              'r de cupom divergente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rl' +
              'bRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCupomCuponsDivergentesMkt: TfrxMemoView
          Left = 662.976810000000000000
          Top = 90.708720000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos conciliados com ' +
              'valor de cupom divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0' +
              '),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos conciliados com valor de cupom divergente'#39', <frxRelatorio."' +
              'CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) / (SUM(IIF(<frxRelatori' +
              'o."DESCRI"> = '#39'Pedidos conciliados com valor de cupom divergente' +
              #39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 10' +
              '0))]')
          ParentFont = False
        end
        object rllCuponsTotalConciliadosMkt: TfrxMemoView
          Left = 617.622450000000000000
          Top = 118.267780000000000000
          Width = 45.354291650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUPONSCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualCuponsTotalConciliadosMkt: TfrxMemoView
          Left = 662.976810000000000000
          Top = 118.267780000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(BRUTOCONCILIADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (CUPONSCONCILIADOSMKT / BRUTOCONCILIADOS' +
              'MKT) * 100))]')
          ParentFont = False
        end
        object Memo222: TfrxMemoView
          Left = 662.929133860000000000
          Top = 149.385900000000000000
          Width = 29.858267720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo250: TfrxMemoView
          Left = 617.574803150000000000
          Top = 149.385900000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cupons')
          ParentFont = False
          WordWrap = False
        end
        object rllValorCuponsInconsistentesMkt: TfrxMemoView
          Left = 617.574803150000000000
          Top = 179.960730000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."CUPOM_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsInconsistentesMkt: TfrxMemoView
          Left = 662.929133860000000000
          Top = 179.960730000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o ' +
              'encontrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."BRUTO_MAR' +
              'KETPLACE">,0),rlbRegistrosMkt)+'
            
              '     SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto ' +
              'divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosM' +
              'kt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              '                                        SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."C' +
              'UPOM_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            
              '                                       (SUM(IIF(<frxRelatorio."D' +
              'ESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos do' +
              ' sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+'
            
              '                                       SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BR' +
              'UTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object rllValorCuponsBaixadosConcMkt: TfrxMemoView
          Left = 617.574803150000000000
          Top = 195.637910000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."CUPOM_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsBaixadosConcMkt: TfrxMemoView
          Left = 662.929133860000000000
          Top = 195.637910000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'ido j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelat' +
              'orio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) / '
            
              '                                      (SUM(IIF(<frxRelatorio."DE' +
              'SCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o autom'#225'tic' +
              'a'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 1' +
              '00))]')
          ParentFont = False
        end
        object rllValorCuponsBaixadosManualMkt: TfrxMemoView
          Left = 617.574803150000000000
          Top = 211.653680000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsBaixadosManualMkt: TfrxMemoView
          Left = 662.929133860000000000
          Top = 211.653680000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado ma' +
              'nualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)=0, '
            '  0.00, '
            
              '  FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'P' +
              'edido j'#225' foi baixado manualmente'#39', <frxRelatorio."CUPOM_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)) / '
            
              '                                        (SUM(IIF(<frxRelatorio."' +
              'DESCRI"> = '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."B' +
              'RUTO_MARKETPLACE">,0),rlbRegistrosMkt))) * 100))]')
          ParentFont = False
        end
        object Memo264: TfrxMemoView
          Left = 617.574803150000000000
          Top = 226.771800000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."CUPOM_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."CUPOM_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object Memo266: TfrxMemoView
          Left = 662.929133860000000000
          Top = 226.771800000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'R' +
              'egistro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <' +
              'frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<f' +
              'rxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concil' +
              'ia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegi' +
              'strosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixa' +
              'do manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bru' +
              'to divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistr' +
              'osMkt)=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', ((SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Reg' +
              'istro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <fr' +
              'xRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."CUPOM_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro' +
              ' do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema'#39', <frxRela' +
              'torio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelat' +
              'orio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233's de concilia'#231#227'o a' +
              'utom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMk' +
              't)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manu' +
              'almente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt)' +
              '+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
      end
      object rlbSomaTotalMkt: TfrxChild
        FillType = ftBrush
        Height = 90.708720000000000000
        Top = 782.362710000000000000
        Width = 755.906000000000000000
        Child = frxPagina.rlbResumoTransferenciasMKT
        PrintChildIfInvisible = True
        object Shape13: TfrxShapeView
          Top = 7.559060000000050000
          Width = 754.015748030000000000
          Height = 15.118120000000000000
        end
        object Memo90: TfrxMemoView
          Left = 1.779530000000000000
          Top = 7.559060000000050000
          Width = 245.669291338583000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total dos Pedidos (Conc. + N'#227'o Conc.)')
          ParentFont = False
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 249.070866141732000000
          Top = 7.559060000000050000
          Width = 34.015748031496100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 284.976377952756000000
          Top = 7.559060000000050000
          Width = 66.141732283464600000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 694.181510000000000000
          Top = 7.559060000000050000
          Width = 60.472428740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeGeralMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 24.118120000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[QUANTIDADECONCILIADOSMKT + QUANTIDADECANCELADOSMKT+SUM(<frxRela' +
              'torio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'am' +
              'entos do sistema'#39')+SUM(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi ' +
              'baixado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39')+SUM(<frxRelatorio."D' +
              'ESCRI"> = '#39'Pedido j'#225' foi baixado manualmente'#39')+SUM(<frxRelatorio' +
              '."DESCRI"> = '#39'Pedidos com valor bruto divergente'#39')]')
          ParentFont = False
        end
        object rllBrutoGeralMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 24.118120000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[BRUTOCONCILIADOSMKT + LIQUIDOCANCELADOSMKT + SUM(IIF(<frxRelato' +
              'rio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amen' +
              'tos do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegist' +
              'rosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado' +
              ' atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKET' +
              'PLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'P' +
              'edido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Ped' +
              'idos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllLiquidoGeralMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 24.118120000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[LIQUIDOCONCILIADOSMKT + LIQUIDOCANCELADOSMKT+SUM(IIF(<frxRelato' +
              'rio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amen' +
              'tos do sistema'#39', <frxRelatorio."LIQUIDO_MARKETPLACE">,0),rlbRegi' +
              'strosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixa' +
              'do atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."LIQUIDO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."LIQUIDO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedidos com valor bruto divergente'#39', <frxRelatorio."LIQUIDO_M' +
              'ARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Top = 23.677180000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........... :')
          ParentFont = False
          WordWrap = False
        end
        object Shape15: TfrxShapeView
          Top = 52.913420000000000000
          Width = 754.015748030000000000
          Height = 15.118120000000000000
        end
        object Memo166: TfrxMemoView
          Left = 1.779530000000000000
          Top = 52.913420000000000000
          Width = 245.669291338583000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total dos registros que ser'#227'o baixados')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 249.070866141732000000
          Top = 52.913420000000000000
          Width = 34.015748031496100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          WordWrap = False
        end
        object Memo178: TfrxMemoView
          Left = 284.976377950000000000
          Top = 52.913420000000000000
          Width = 66.141732280000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
          WordWrap = False
        end
        object Memo190: TfrxMemoView
          Left = 694.181510000000000000
          Top = 52.913420000000000000
          Width = 60.472428740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object rllQuantidadeBaixadosMkt: TfrxMemoView
          Left = 249.070866140000000000
          Top = 69.472480000000000000
          Width = 34.015748030000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[QUANTIDADEBAIXADOSMKT]')
          ParentFont = False
        end
        object rllBrutoBaixadosMkt: TfrxMemoView
          Left = 284.976377952756000000
          Top = 69.472480000000000000
          Width = 66.141732283464600000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BRUTOBAIXADOSMKT]')
          ParentFont = False
        end
        object rllLiquidoBaixadosMkt: TfrxMemoView
          Left = 694.181510000000000000
          Top = 69.472480000000000000
          Width = 60.472428740000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[LIQUIDOBAIXADOSMKT]')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Top = 69.031540000000000000
          Width = 245.669291340000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Total...........................................................' +
              '........... :')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTaxasGeralMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 24.118120000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TAXASCONCILIADOSMKT+'
            
              'SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encon' +
              'trado nos lan'#231'amentos do sistema'#39', <frxRelatorio."TAXAS_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."TAXAS_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualTaxasGeralMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 24.118120000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231 +
              'amentos do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRe' +
              'gistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi bai' +
              'xado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((TAXASCONCILIADOSMKT+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."TAXAS_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."TAXAS_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."TAXAS_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio' +
              '."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos' +
              ' do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistros' +
              'Mkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedi' +
              'do j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido' +
              's com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE"' +
              '>,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object rllValorFreteGeralMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 24.118120000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FRETECONCILIADOSMKT+'
            
              'SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encon' +
              'trado nos lan'#231'amentos do sistema'#39', <frxRelatorio."FRETE_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."FRETE_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualFreteGeralMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 24.118120000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231 +
              'amentos do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRe' +
              'gistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi bai' +
              'xado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((FRETECONCILIADOSMKT+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."FRETE_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."FRETE_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."FRETE_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio' +
              '."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos' +
              ' do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistros' +
              'Mkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedi' +
              'do j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido' +
              's com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE"' +
              '>,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object rllValorAjustesGeralMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 24.118120000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUSTESCONCILIADOSMKT+'
            
              'SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encon' +
              'trado nos lan'#231'amentos do sistema'#39', <frxRelatorio."AJUSTES_MARKET' +
              'PLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."AJUSTES_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ']')
          ParentFont = False
        end
        object rllPercentualAjustesGeralMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 24.118120000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231 +
              'amentos do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRe' +
              'gistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi bai' +
              'xado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((AJUSTESCONCILIADOSMKT+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."AJUSTES_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt' +
              ')+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."AJUSTES_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."AJUSTES_MARKETPLACE">,0),rlbRegistrosMkt)' +
              ') /'
            
              ' (BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio' +
              '."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos' +
              ' do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistros' +
              'Mkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedi' +
              'do j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido' +
              's com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE"' +
              '>,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object Memo226: TfrxMemoView
          Left = 352.629921259843000000
          Top = 7.559060000000050000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Taxas')
          ParentFont = False
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 406.984540000000000000
          Top = 7.559060000000050000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo229: TfrxMemoView
          Left = 440.354330710000000000
          Top = 7.559060000000050000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fretes')
          ParentFont = False
          WordWrap = False
        end
        object Memo230: TfrxMemoView
          Left = 494.401574800000000000
          Top = 7.559060000000050000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo231: TfrxMemoView
          Left = 528.795275590000000000
          Top = 7.559060000000050000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Ajustes')
          ParentFont = False
          WordWrap = False
        end
        object Memo241: TfrxMemoView
          Left = 584.149564800000000000
          Top = 7.559060000000050000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo242: TfrxMemoView
          Left = 352.629921259843000000
          Top = 52.913420000000000000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Taxas')
          ParentFont = False
          WordWrap = False
        end
        object Memo243: TfrxMemoView
          Left = 406.984540000000000000
          Top = 52.913420000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo244: TfrxMemoView
          Left = 440.354330710000000000
          Top = 52.913420000000000000
          Width = 52.913351650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fretes')
          ParentFont = False
          WordWrap = False
        end
        object Memo245: TfrxMemoView
          Left = 494.401574800000000000
          Top = 52.913420000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo246: TfrxMemoView
          Left = 528.795275590000000000
          Top = 52.913420000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Ajustes')
          ParentFont = False
          WordWrap = False
        end
        object Memo247: TfrxMemoView
          Left = 584.149564800000000000
          Top = 52.913420000000000000
          Width = 32.125984250000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTaxasBaixadosMkt: TfrxMemoView
          Left = 352.629921259843000000
          Top = 69.472480000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TAXASCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualTaxasBaixadosMkt: TfrxMemoView
          Left = 406.984540000000000000
          Top = 69.472480000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Abs(IIF(BRUTOBAIXADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (TAXASCONCILIADOSMKT / BRUTOBAIXADOSMKT)' +
              ' * 100)))]')
          ParentFont = False
        end
        object rllValorFreteBaixadosMkt: TfrxMemoView
          Left = 440.354330710000000000
          Top = 69.472480000000000000
          Width = 52.913351650000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FRETECONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualFreteBaixadosMkt: TfrxMemoView
          Left = 494.401574800000000000
          Top = 69.472480000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Abs(IIF(BRUTOBAIXADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (FRETECONCILIADOSMKT / BRUTOBAIXADOSMKT)' +
              ' * 100)))]')
          ParentFont = False
        end
        object rllValorAjustesBaixadosMkt: TfrxMemoView
          Left = 528.795275590000000000
          Top = 69.472480000000000000
          Width = 52.913380940000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AJUSTESCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualAjustesBaixadosMkt: TfrxMemoView
          Left = 584.149564800000000000
          Top = 69.472480000000000000
          Width = 32.125984250000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Abs(IIF(BRUTOBAIXADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (AJUSTESCONCILIADOSMKT / BRUTOBAIXADOSMK' +
              'T) * 100)))]')
          ParentFont = False
        end
        object Memo256: TfrxMemoView
          Left = 662.929133860000000000
          Top = 7.559060000000000000
          Width = 29.858267720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo257: TfrxMemoView
          Left = 617.574803150000000000
          Top = 7.559060000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cupons')
          ParentFont = False
          WordWrap = False
        end
        object Memo261: TfrxMemoView
          Left = 662.929133860000000000
          Top = 52.913420000000000000
          Width = 29.858267720000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object Memo263: TfrxMemoView
          Left = 617.574803150000000000
          Top = 52.913420000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cupons')
          ParentFont = False
          WordWrap = False
        end
        object rllValorCuponsGeralMkt: TfrxMemoView
          Left = 617.574803150000000000
          Top = 24.118120000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUPONSCONCILIADOSMKT+'
            
              'SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encon' +
              'trado nos lan'#231'amentos do sistema'#39', <frxRelatorio."CUPOM_MARKETPL' +
              'ACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."CUPOM_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)]')
          ParentFont = False
        end
        object rllPercentualCuponsGeralMkt: TfrxMemoView
          Left = 662.929133860000000000
          Top = 24.118120000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[Abs(IIF(BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRe' +
              'latorio."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231 +
              'amentos do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRe' +
              'gistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi bai' +
              'xado atrav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MA' +
              'RKETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> ' +
              '= '#39'Pedido j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARK' +
              'ETPLACE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = ' +
              #39'Pedidos com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKE' +
              'TPLACE">,0),rlbRegistrosMkt)=0,'
            '0.00,'
            'FormatFloat('#39'#,##0.00'#39', ((CUPONSCONCILIADOSMKT+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Registro do arquivo n'#227'o enco' +
              'ntrado nos lan'#231'amentos do sistema'#39', <frxRelatorio."CUPOM_MARKETP' +
              'LACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedidos com valor bruto dive' +
              'rgente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado atrav'#233 +
              's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."CUPOM_MARKETPLACE">' +
              ',0),rlbRegistrosMkt)+'
            
              ' SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado manual' +
              'mente'#39', <frxRelatorio."CUPOM_MARKETPLACE">,0),rlbRegistrosMkt)) ' +
              '/'
            
              ' (BRUTOCONCILIADOSMKT + BRUTOCANCELADOSMKT+SUM(IIF(<frxRelatorio' +
              '."DESCRI"> = '#39'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos' +
              ' do sistema'#39', <frxRelatorio."BRUTO_MARKETPLACE">,0),rlbRegistros' +
              'Mkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido j'#225' foi baixado at' +
              'rav'#233's de concilia'#231#227'o autom'#225'tica'#39', <frxRelatorio."BRUTO_MARKETPLA' +
              'CE">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedi' +
              'do j'#225' foi baixado manualmente'#39', <frxRelatorio."BRUTO_MARKETPLACE' +
              '">,0),rlbRegistrosMkt)+SUM(IIF(<frxRelatorio."DESCRI"> = '#39'Pedido' +
              's com valor bruto divergente'#39', <frxRelatorio."BRUTO_MARKETPLACE"' +
              '>,0),rlbRegistrosMkt))'
            ''
            ') * 100)'
            '))]')
          ParentFont = False
        end
        object rllValorCuponsBaixadosMkt: TfrxMemoView
          Left = 617.574803150000000000
          Top = 69.472480000000000000
          Width = 45.354330710000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUPONSCONCILIADOSMKT]')
          ParentFont = False
        end
        object rllPercentualCuponsBaixadosMkt: TfrxMemoView
          Left = 662.929133860000000000
          Top = 69.472480000000000000
          Width = 29.858267720000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Abs(IIF(BRUTOBAIXADOSMKT=0,'
            '0.00,'
            
              'FormatFloat('#39'#,##0.00'#39', (CUPONSCONCILIADOSMKT / BRUTOBAIXADOSMKT' +
              ') * 100)))]')
          ParentFont = False
        end
      end
      object rlbCancelamentosEAjustesMkt: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 944.882500000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbCancelamentosEAjustesMktOnBeforePrint'
        Child = frxPagina.rlbArquivosMkt
        PrintChildIfInvisible = True
        object Subreport6: TfrxSubreport
          Top = 7.559060000000050000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckCancelamentosMkt
        end
      end
      object rlbArquivosMkt: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 997.795920000000000000
        Width = 755.906000000000000000
        OnAfterPrint = 'rlbArquivosMktOnAfterPrint'
        PrintChildIfInvisible = True
        Stretched = True
        object Subreport8: TfrxSubreport
          Left = 1.779530000000000000
          Top = 7.559060000000050000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckSubRede
        end
      end
      object rlbResumoTransferenciasMKT: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 895.748610000000000000
        Visible = False
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbResumoTransferenciasMKTOnBeforePrint'
        Child = frxPagina.rlbCancelamentosEAjustesMkt
        PrintChildIfInvisible = True
        object Subreport9: TfrxSubreport
          Top = 3.779530000000020000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPagina.qckResumoTransferencias
        end
      end
      object GroupHeader_Empresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.724414330000000000
        Top = 143.622140000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbCabGru_PVOnBeforePrint'
        Condition = 'frxRelatorio."NUM_PV"'
        object Memo271: TfrxMemoView
          Top = 9.937007870000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
        end
        object Memo272: TfrxMemoView
          Left = 69.811070000000000000
          Top = 8.937007870000000000
          Width = 657.638163860000000000
          Height = 20.787406460000000000
          OnBeforePrint = 'Memo130OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Memo.UTF8W = (
            '[frxRelatorio."DESEMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter_Empresa: TfrxGroupFooter
        FillType = ftBrush
        Height = 7.559040470000000000
        Top = 408.189240000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbRodGru_PVOnBeforePrint'
        PrintChildIfInvisible = True
      end
    end
    object qckCancelamentosMkt: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 8.000000000000000000
      RightMargin = 7.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbGrupoCancelamentosMkt: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.023622050000000000
        Top = 16.000000000000000000
        Width = 737.008350000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object Memo161: TfrxMemoView
          Left = 138.330711100000000000
          Top = 7.559060000000000000
          Width = 668.976810000000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Inconsist'#234'ncia: ')
          ParentFont = False
        end
        object Shape14: TfrxShapeView
          Top = 33.236240000000000000
          Width = 735.118139530000000000
          Height = 15.118120000000000000
        end
        object rllDesChaveCancelamento1Mkt: TfrxMemoView
          Left = 256.008035110000000000
          Top = 33.236240000000000000
          Width = 90.708683390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Shippind ID')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 568.016080000000000000
          Top = 33.236240000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Bruto')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 492.275820000000000000
          Top = 33.236240000000000000
          Width = 71.811011420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Registro')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 457.275820000000000000
          Top = 33.236240000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parc.')
          ParentFont = False
        end
        object rllDesChaveCancelamento2Mkt: TfrxMemoView
          Left = 350.535440380000000000
          Top = 33.236240000000000000
          Width = 102.047273390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'External Ref.')
          ParentFont = False
        end
        object Memo187: TfrxMemoView
          Left = 648.740570000000000000
          Top = 33.236240000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
        end
        object Memo188: TfrxMemoView
          Left = 1.779530000000000000
          Top = 33.015770000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Motivo Cancelamento/Ajuste')
          ParentFont = False
        end
      end
      object rlbRegistrosCancelamentosMkt: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 88.000000000000000000
        Width = 737.008350000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo189: TfrxMemoView
          Left = 457.275820000000000000
          Width = 30.236215590000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."PARCEL"]')
          ParentFont = False
        end
        object rllChaveCancelamento2Mkt: TfrxMemoView
          Left = 350.362204720000000000
          Width = 102.047273390000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMCCD"]')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 568.016080000000000000
          Width = 83.149606300000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BRUTO_MARKETPLACE"]')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Width = 253.228453860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo193: TfrxMemoView
          Left = 648.740570000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LIQUIDO_MARKETPLACE"]')
          ParentFont = False
        end
        object Memo195: TfrxMemoView
          Left = 492.275820000000000000
          Width = 71.811023620000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object rllChaveCancelamento1Mkt: TfrxMemoView
          Left = 256.008040000000000000
          Width = 90.708661420000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."AUTORI"]')
          ParentFont = False
        end
      end
      object rlbTotaisCancelamentosMkt: TfrxGroupFooter
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 124.000000000000000000
        Width = 737.008350000000000000
        OnBeforePrint = 'rlbTotaisCancelamentosMktOnBeforePrint'
        object rllTextoCancelamentoMkt: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 699.213050000000000000
          Height = 26.456710000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Esses registros devem ser lan'#231'ados manualmente na Movimenta'#231#227'o ' +
              'Banc'#225'ria.')
          ParentFont = False
        end
        object Memo199: TfrxMemoView
          Left = 416.425480000000000000
          Top = 2.440940000000010000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo201: TfrxMemoView
          Left = 497.055350000000000000
          Top = 2.440940000000010000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbRegistrosCancelamentosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo202: TfrxMemoView
          Left = 559.551330000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object Memo203: TfrxMemoView
          Left = 642.244280000000000000
          Top = 3.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."LIQUIDO_MARKETPLACE">,rlbRegistrosCancelamen' +
              'tosMkt)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo204: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 257.008040000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais de [frxRelatorio."DESCRI"]:')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object qckResumoTransferencias: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 600.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbTransferenciasHeader: TfrxGroupHeader
        FillType = ftBrush
        Height = 39.685032050000000000
        Top = 16.000000000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object Memo198: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.559060000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transfer'#234'ncias')
          ParentFont = False
        end
        object Shape16: TfrxShapeView
          Top = 23.236240000000000000
          Width = 716.220489530000000000
          Height = 15.118120000000000000
        end
        object Memo210: TfrxMemoView
          Left = 316.551330000000000000
          Top = 23.236240000000000000
          Width = 219.212598430000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Portador Transfer'#234'ncia')
          ParentFont = False
        end
        object Memo216: TfrxMemoView
          Left = 539.559370000000000000
          Top = 23.236240000000000000
          Width = 90.708666300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Transfer'#234'ncia')
          ParentFont = False
        end
        object Memo220: TfrxMemoView
          Left = 2.818800000000000000
          Top = 23.236240000000000000
          Width = 86.929131420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Lan'#231'amento')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 92.488250000000000000
          Top = 23.015770000000000000
          Width = 219.212740000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Portador D'#233'bito')
          ParentFont = False
        end
        object Memo225: TfrxMemoView
          Left = 633.181510000000000000
          Top = 23.015770000000000000
          Width = 79.370071420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Realizada?')
          ParentFont = False
        end
      end
      object rlbTransferenciasEstabelecimentoHeader: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 76.000000000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbTransferenciasEstabelecimentoHeaderOnBeforePrint'
        Condition = 'frxRelatorio."NUM_PV"'
        object Memo196: TfrxMemoView
          Left = 1.559060000000000000
          Width = 83.149603860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ponto de Venda:')
          ParentFont = False
        end
        object Memo249: TfrxMemoView
          Left = 92.267780000000000000
          Width = 158.740203860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUM_PV"]')
          ParentFont = False
        end
      end
      object rlbTransferenciasDados: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 112.000000000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbTransferenciasDadosOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo252: TfrxMemoView
          Left = 537.913354090000000000
          Width = 94.488208500000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
        end
        object Memo253: TfrxMemoView
          Left = 90.708720000000000000
          Width = 219.212683860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PORTADOR_DEBITO"]')
          ParentFont = False
        end
        object Memo254: TfrxMemoView
          Left = 634.448809130000000000
          Width = 79.370088500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CONCILIADO"> = 0, '#39'N'#195'O'#39', '#39'SIM'#39')]')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 2.220470000000000000
          Width = 86.929153390000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          Left = 313.700990000000000000
          Width = 219.212683860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PORTADOR_TRANSFERENCIA"]')
          ParentFont = False
        end
      end
      object rlbTransferenciasEstabelecimentoFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 148.000000000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbTransferenciasEstabelecimentoFooterOnBeforePrint'
        object Memo258: TfrxMemoView
          Left = 312.496290000000000000
          Top = 4.440940000000010000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object Memo259: TfrxMemoView
          Left = 393.126160000000000000
          Top = 4.440940000000010000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbTransferenciasDados)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo260: TfrxMemoView
          Left = 455.622140000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTotalTransferencias: TfrxMemoView
          Left = 538.315090000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo262: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Ponto de Venda:')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTransferenciasFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 192.000000000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo265: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779529999999990000
          Width = 699.213050000000000000
          Height = 26.456710000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Os lan'#231'amentos das transfer'#234'ncias n'#227'o realizadas ser'#227'o feitos n' +
              'a Movimenta'#231#227'o Banc'#225'ria no momento da baixa. '
            '**Transfer'#234'ncias sem portadores n'#227'o ser'#227'o lan'#231'adas.')
          ParentFont = False
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 600.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbNegociacoesHeader: TfrxGroupHeader
        FillType = ftBrush
        Height = 39.685032050000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object rllNegociacoesDescricao: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.559060000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Negocia'#231#227'o de Receb'#237'veis')
          ParentFont = False
        end
        object Shape17: TfrxShapeView
          Top = 23.236240000000000000
          Width = 716.220489530000000000
          Height = 15.118120000000000000
        end
        object rllVencimentoOriginalDesc: TfrxMemoView
          Left = 448.834880000000000000
          Top = 23.236240000000000000
          Width = 86.929133860000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Venc. Original')
          ParentFont = False
        end
        object rllValorNegociacaoDesc: TfrxMemoView
          Left = 539.559370000000000000
          Top = 23.236240000000000000
          Width = 90.708666300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Recebido')
          ParentFont = False
        end
        object rllDatapagamentoNegociacaoDesc: TfrxMemoView
          Left = 2.818800000000000000
          Top = 23.236240000000000000
          Width = 86.929131420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Pagamento')
          ParentFont = False
        end
        object rllNumeroNegociacaoDesc: TfrxMemoView
          Left = 183.196970000000000000
          Top = 23.015770000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero Negocia'#231#227'o')
          ParentFont = False
        end
        object rllLancadoDesc: TfrxMemoView
          Left = 633.181510000000000000
          Top = 23.015770000000000000
          Width = 79.370071420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Realizado?')
          ParentFont = False
        end
        object rllBandeiraNegociacaoDesc: TfrxMemoView
          Left = 306.141930000000000000
          Top = 22.677180000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bandeira')
          ParentFont = False
        end
        object rllDataNegociacaoDesc: TfrxMemoView
          Left = 94.488250000000000000
          Top = 22.677180000000000000
          Width = 86.929131420000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Negocia'#231#227'o')
          ParentFont = False
        end
      end
      object rlbNegociacoesEstabelecimentoHeader: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbNegociacoesEstabelecimentoHeaderOnBeforePrint'
        Condition = 'frxRelatorio."NUM_PV"'
        object rllPontoDeVendaNegociadcoesDesc: TfrxMemoView
          Left = 1.559060000000000000
          Width = 83.149603860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ponto de Venda:')
          ParentFont = False
        end
        object rllPontoDeVendaNegociadcoes: TfrxMemoView
          Left = 92.267780000000000000
          Width = 158.740203860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUM_PV"]')
          ParentFont = False
        end
      end
      object rlbNegociacoesDados: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbNegociacoesDadosOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllValorNegociacao: TfrxMemoView
          Left = 537.913354090000000000
          Width = 94.488208500000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
        end
        object rllDataNegociacao: TfrxMemoView
          Left = 94.488250000000000000
          Width = 86.929133860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object rllLancado: TfrxMemoView
          Left = 634.448809130000000000
          Width = 79.370088500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CONCIL"> = 0, '#39'N'#195'O'#39', '#39'SIM'#39')]')
          ParentFont = False
        end
        object rllDatapagamentoNegociacao: TfrxMemoView
          Left = 4.220470000000000000
          Width = 86.929153390000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTA_CV"]')
          ParentFont = False
        end
        object rllNumeroNegociacao: TfrxMemoView
          Left = 181.417440000000000000
          Width = 120.944903860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMERO_NEGOCIACAO"]')
          ParentFont = False
        end
        object rllBandeiraNegociacao: TfrxMemoView
          Left = 306.141930000000000000
          Width = 139.842553860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."BANDEI"]')
          ParentFont = False
        end
        object rllVencimentoOriginal: TfrxMemoView
          Left = 447.764070000000000000
          Width = 86.929133860000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
        end
      end
      object rlbNegociacoesEstabelecimentoFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 158.740260000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbNegociacoesEstabelecimentoFooterOnBeforePrint'
        object rllQtdTotalNegociacoesDesc: TfrxMemoView
          Left = 312.496290000000000000
          Top = 4.440940000000010000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdTotalNegociacoes: TfrxMemoView
          Left = 393.126160000000000000
          Top = 4.440940000000010000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbNegociacoesDados)]')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTotalNegociacoesDesc: TfrxMemoView
          Left = 455.622140000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
          ParentFont = False
          WordWrap = False
        end
        object rllValorTotalNegociacoes: TfrxMemoView
          Left = 538.315090000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllTotaisNegociacoesDesc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais por Ponto de Venda:')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbNegociacoesFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        Stretched = True
        object rllTextoFooterNegociacoes: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779529999999990000
          Width = 699.213050000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*Os lan'#231'amentos das negocia'#231#245'es n'#227'o realizados ser'#227'o feitos na M' +
              'ovimenta'#231#227'o Banc'#225'ria no momento da baixa. ')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 600.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 68.031540000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotalFinal."ESTABE"'
        object Memo268: TfrxMemoView
          Top = 1.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ponto de venda: ')
          ParentFont = False
          WordWrap = False
        end
        object Memo273: TfrxMemoView
          Left = 86.606370000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotalFinal."ESTABE"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 0.220460240000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbBandeirasOnBeforePrint'
        DataSet = frxTotalFinal
        DataSetName = 'frxTotalFinal'
        RowCount = 0
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 20.409451260000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        object Memo278: TfrxMemoView
          Left = 4.000000000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTotalFinal."RECEBE"]:')
          ParentFont = False
          WordWrap = False
        end
        object Memo279: TfrxMemoView
          Left = 289.189240000000000000
          Width = 83.149660000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotalFinal."TOTENT"]')
          ParentFont = False
        end
        object Memo280: TfrxMemoView
          Left = 380.575140000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotalFinal."TOTSAI"]')
          ParentFont = False
        end
        object Memo281: TfrxMemoView
          Left = 606.732530000000000000
          Top = 0.220470000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotalFinal."TOTLIQ"]')
          ParentFont = False
        end
        object Memo282: TfrxMemoView
          Left = 496.000310000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotalFinal."TOTTAX"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        object Memo283: TfrxMemoView
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Como Funciona o C'#225'lculo dos Totalizadores?')
          ParentFont = False
        end
        object Memo284: TfrxMemoView
          Top = 15.118120000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Entradas:')
          ParentFont = False
        end
        object Memo285: TfrxMemoView
          Left = 77.149660000000000000
          Top = 15.118120000000000000
          Width = 642.520100000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'corresponde '#224' soma do valor bruto de todos os cart'#245'es n'#227'o incons' +
              'istentes, acrescida do total de cancelamentos/ajustes positivos.')
          ParentFont = False
        end
        object Memo289: TfrxMemoView
          Top = 30.236240000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Sa'#237'das:')
          ParentFont = False
        end
        object Memo290: TfrxMemoView
          Left = 76.149660000000000000
          Top = 30.236240000000000000
          Width = 642.520100000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'resulta da soma de todos os cancelamentos/ajustes negativos (exc' +
              'eto aqueles referentes '#224' "Taxa de Transfer'#234'ncias"), somada ao to' +
              'tal de transfer'#234'ncias.')
          ParentFont = False
        end
        object Memo291: TfrxMemoView
          Top = 45.354360000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Taxas:')
          ParentFont = False
        end
        object Memo292: TfrxMemoView
          Left = 76.149660000000000000
          Top = 45.354360000000000000
          Width = 642.520100000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'equivale ao somat'#243'rio das taxas de cart'#245'es n'#227'o inconsistentes, a' +
              'crescido das taxas de transfer'#234'ncia, subtraindo taxas de cancela' +
              'mentos/ajustes negativos.')
          ParentFont = False
        end
        object Memo293: TfrxMemoView
          Top = 60.472480000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Liqu'#237'do:')
          ParentFont = False
        end
        object Memo294: TfrxMemoView
          Left = 76.149660000000000000
          Top = 60.472480000000000000
          Width = 642.520100000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'corresponde ao "Total de Entradas", subtra'#237'do do "Total de Sa'#237'da' +
              's" e do "Total de Taxas".')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Width = 716.220448030000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        Condition = 'frxTotalFinal."RECEBE"'
        object Shape19: TfrxShapeView
          Top = 1.000000000000000000
          Width = 716.220448030000000000
          Height = 15.118120000000000000
        end
        object Memo297: TfrxMemoView
          Left = 4.000000000000000000
          Top = 2.000000000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo1OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Recebedor')
          ParentFont = False
        end
        object Memo298: TfrxMemoView
          Left = 287.929500000000000000
          Top = 1.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Entradas')
          ParentFont = False
          WordWrap = False
        end
        object Memo300: TfrxMemoView
          Left = 381.653990000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Sa'#237'das')
          ParentFont = False
          WordWrap = False
        end
        object Memo301: TfrxMemoView
          Left = 608.504330000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total L'#237'quido')
          ParentFont = False
          WordWrap = False
        end
        object Memo302: TfrxMemoView
          Left = 495.000310000000000000
          Top = 1.000000000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Taxas')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo303: TfrxMemoView
          Left = 7.559060000000000000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Final por Ponto de Venda e Recebedor')
          ParentFont = False
        end
      end
    end
  end
  object frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    EnviarNomes = False
    Left = 504
    Top = 104
  end
  object frxExportaXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 504
    Top = 159
  end
  object frxExportaPDF: TfrxPDFExport
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
    Left = 504
    Top = 215
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 40
  end
  object frxSemRed: TfrxDBDataset
    UserName = 'frxSemRed'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 89
  end
  object frxListArq: TfrxDBDataset
    UserName = 'frxListArq'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 145
  end
  object frxTotBan: TfrxDBDataset
    UserName = 'frxTotBan'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 216
    Top = 206
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    DeleteEmptyColumns = True
    Left = 500
    Top = 46
  end
  object frxDBCartoesPendenteConciliacao: TfrxDBDataset
    UserName = 'frxDBCartoesPendenteConciliacao'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 328
    Top = 276
  end
  object frxCartoesPendenteConciliacao: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45119.688416365700000000
    ReportOptions.LastChange = 45119.688416365700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 120
    Top = 276
    Datasets = <
      item
        DataSet = frxDBCartoesPendenteConciliacao
        DataSetName = 'frxDBCartoesPendenteConciliacao'
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
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 69.866110000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 17.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CART'#213'ES PENDENTES DE CONCILIA'#199#195'O ')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 1241.757700000000000000
          Width = 115.200000000000000000
          Height = 17.007874020000000000
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
        object Memo21: TfrxMemoView
          Left = 1308.655350000000000000
          Top = 16.000000000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo22: TfrxMemoView
          Left = 1245.753000000000000000
          Top = 16.000000000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo23: TfrxMemoView
          Align = baCenter
          Left = 119.924645000000000000
          Width = 478.261410000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 668.847620000000000000
          Top = 0.220470000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo54: TfrxMemoView
          Left = 605.945270000000000000
          Top = 0.220470000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
        object Memo64: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 38.354360000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
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
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo97: TfrxMemoView
          Align = baLeft
          Left = 291.023736780000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cart'#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo98: TfrxMemoView
          Align = baLeft
          Left = 566.929346220000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo99: TfrxMemoView
          Align = baLeft
          Left = 362.834806780000000000
          Width = 94.488208500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data de Cadastro')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo101: TfrxMemoView
          Align = baLeft
          Left = 457.323015280000000000
          Width = 109.606330940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data de Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo103: TfrxMemoView
          Align = baLeft
          Left = 249.448906780000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo104: TfrxMemoView
          Align = baLeft
          Left = 90.708683390000000000
          Width = 102.047273390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'NSU')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo105: TfrxMemoView
          Align = baLeft
          Left = 642.519897400000000000
          Width = 75.590546300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Align = baLeft
          Width = 90.708683390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'm. Libera'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 192.755956780000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataCartoesPendente: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetRedeOnBeforePrint'
        DataSet = frxDBCartoesPendenteConciliacao
        DataSetName = 'frxDBCartoesPendenteConciliacao'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 291.023736780000000000
          Top = 0.779530000000000000
          Width = 71.811070000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_CODCAR"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 566.929346220000000000
          Top = 0.779530000000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_VALSTA"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 362.834806780000000000
          Top = 0.779530000000000000
          Width = 94.488208500000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_DTACAD"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 459.559255280000000000
          Top = 0.779530000000000000
          Width = 105.826800940000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_DTAVEN"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 249.448906780000000000
          Top = 0.779530000000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_PARCEL"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 90.708683390000000000
          Top = 0.779530000000000000
          Width = 102.047273390000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_NUMNSU"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 642.519897400000000000
          Top = 0.779530000000000000
          Width = 75.590546300000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_VALDUP"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 0.779530000000000000
          Width = 90.708683390000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_NUMCCD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 192.755956780000000000
          Top = 0.779530000000000000
          Width = 56.692950000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartoesPendenteConciliacao."MCA_CODEMP"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 122.385900000000000000
        Top = 226.771800000000000000
        Width = 718.110700000000000000
        object Memo15: TfrxMemoView
          Align = baRight
          Left = 642.520148820000000000
          Top = 48.763760000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBCartoesPendenteConciliacao."MCA_VALSTA">,MasterDataCa' +
              'rtoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 642.520148820000000000
          Top = 68.440940000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBCartoesPendenteConciliacao."MCA_VALDUP">,MasterDataCa' +
              'rtoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Top = 24.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 642.520100000000000000
          Top = 87.354360000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterDataCartoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 21.559060000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo24: TfrxMemoView
          Align = baRight
          Left = 510.236598820000000000
          Top = 48.787401574803100000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 510.236598820000000000
          Top = 66.456710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 510.236550000000000000
          Top = 87.535433070000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 40.795300000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 64.472480000000000000
        Top = 408.189240000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 642.520148820000000000
          Top = 10.763760000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBCartoesPendenteConciliacao."MCA_VALDUP">,MasterDataCa' +
              'rtoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 566.929597640000000000
          Top = 10.543290000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBCartoesPendenteConciliacao."MCA_VALSTA">,MasterDataCa' +
              'rtoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Top = 10.000000000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total por p'#225'gina')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 28.795300000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo14: TfrxMemoView
          Align = baRight
          Left = 464.882287640000000000
          Top = 10.338590000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quantidade: [COUNT(MasterDataCartoesPendente)]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 7.559060000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 41.574830000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'frmBaixaCartoesRelatorio')
          ParentFont = False
          VAlign = vaBottom
        end
        object Page: TfrxMemoView
          Left = 680.315400000000000000
          Top = 45.354360000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object frxTotalFinal: TfrxDBDataset
    UserName = 'frxTotalFinal'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 296
    Top = 206
  end
end
