unit untValidaSituacaoFinanceiraPedido;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  untfuncoesSimples,
  untConstantes,
{$ENDIF LINUX}
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  Data.DB;

function fJaUsouCreditoDeAdiantamento(strNumPed, strEspPed, strEmpPed: String): Boolean;

function fValidaSituacaoFinanceiraPedido(strNumDoc, strEspDoc, strCodEmp: String;
                                         Var strPenFin: String;
                                         blnSomaValRecDocsFats: Boolean = False;
                                         blnEhTelaFormulacaoTinta: boolean = False): Boolean; overload;

function fValidaSituacaoFinanceiraPedido(strCodCli, strEspDoc, strCodFpg, strConPag,
                                         strFpgNeg, strIncGor, strTipOpe: String;
                                         blnOriF11: Boolean;
                                         fltVlrCon, fltValRec, fltBolAdt: Double;
                                         blnBolVen: Boolean;
                                         btnBEnFut: Boolean;
                                         Var strPenFin: String;
                                         blnJaUsouCreditoDeAdiantamento: Boolean = False;
                                         AblnPedidoGeradoViaEnvioConsignacao : Boolean = False;
                                         blnEhTelaFormulacaoTinta: boolean = False): Boolean; overload;

function fRetornaValorFpgNegAVista(const strIncGor: String):Double;
function fRetornaValorCreditoAdtCli(const strIncGor: String):Double;



implementation

function fJaUsouCreditoDeAdiantamento(strNumPed, strEspPed, strEmpPed: String): Boolean;
  Var
    qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
   qryGen := fCriaQuery;
   Try
     qryGen.SQL.Text := 'SELECT IF(COUNT(0) > 0, "S", "N") AS STATUS FROM MOVDET      '+
                        '                INNER JOIN CADREC ON CTR_NUMDUP = DET_NUMDOC '+
                        '                                 AND CTR_ESPDOC = DET_ESPDOC '+
                        '                                 AND CTR_CODEMP = DET_CODEMP '+
                        '                                 AND CTR_CODCLI = DET_CODCLI '+
                        'WHERE DET_NUM_PD = :NUM_PD '+
                        '  AND DET_ESP_PD = :ESP_PD '+
                        '  AND DET_EMP_PD = :EMP_PD '+
                        '  AND CTR_ADTCLI = "S"     '+
                        '  AND CTR_VALORI > 0       ';

     qryGen.ParamByName('NUM_PD').AsString := strNumPed;
     qryGen.ParamByName('ESP_PD').AsString := strEspPed;
     qryGen.ParamByName('EMP_PD').AsString := strEmpPed;

     qryGen.Open;
     Result := qryGen.FieldByName('STATUS').AsString = 'S';
     qryGen.Close;
   Finally
{$IFNDEF LINUX}
     FreeAndNil(qryGen)
{$ENDIF LINUX}
   End;
end;

function fValidaSituacaoFinanceiraPedido(strNumDoc, strEspDoc, strCodEmp: String;
                                         Var strPenFin: String;
                                         blnSomaValRecDocsFats: Boolean = False;
                                         blnEhTelaFormulacaoTinta: boolean = False): Boolean;
  Var
    qryInfPed: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    qryPedFat: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    stlDocFat: TStringList;
    stlDocAdt: TStringList;
    strSQLDocFat: String;
    strSQLDocAdt: String;
    intIdx: Integer;
    blnJaUsouCreditoDeAdiantamento: Boolean;
    fltValRec: Double;
    strConPag: String;
    fltVlrCon: Double;
    fltDesEspDif: Double;
    fltDesEspFat: Double;

    function fCarregaPedidoFaturado(strNumDoc,strEspDoc,strCodEmp,strCodCli: String): Boolean;
    begin
       qryPedFat.Close;
       qryPedFat.SQL.Text := ' SELECT DISTINCT '+
                             '    FDO_TIPFAT AS TIPFAT, '+
                             '    FDO_NUMFAT AS NUMFAT, '+
                             '    FDO_EMPFAT AS EMPFAT, '+
                             '    FDO_CODCLI AS CODCLI  '+
                             '  FROM FATDOR '+
                             ' WHERE FDO_NUMDOC = '+strNumDoc.QuotedString+
                             '   AND FDO_ESPDOC = '+strEspDoc.QuotedString+
                             '   AND FDO_CODEMP = '+strCodEmp.QuotedString+
                             '   AND FDO_CODCLI = '+strCodCli.QuotedString;
      qryPedFat.Open;
      Result := Not qryPedFat.IsEmpty;
    end;

begin
  Result := True;

  qryInfPed := fCriaQuery;
  qryPedFat := fCriaQuery;

  stlDocFat := TStringList.Create;
  stlDocAdt := TStringList.Create;
  stlDocFat.Duplicates := dupIgnore;
  stlDocAdt.Duplicates := dupIgnore;

  blnJaUsouCreditoDeAdiantamento := False;
  Try
    qryInfPed.SQL.Add('SELECT SQL_NO_CACHE    ');
    qryInfPed.SQL.Add('  FATGOR.AUTOINCREM AS INCGOR, ');
    qryInfPed.SQL.Add('  FGO_ENVCON AS ENVCON,');
    qryInfPed.SQL.Add('  FGO_JAFATU AS JAFATU,');
    qryInfPed.SQL.Add('  FDO_NUMFAT AS NUMFAT,');
    qryInfPed.SQL.Add('  FDO_EMPFAT AS EMPFAT,');
    qryInfPed.SQL.Add('  FDO_TIPFAT AS TIPFAT,');
    qryInfPed.SQL.Add('  FGO_TIPOPE AS TIPOPE, ');
    qryInfPed.SQL.Add('  FGO_CODCLI AS CODCLI,');
    qryInfPed.SQL.Add('  FGO_ESPDOC AS ESPDOC,');
    qryInfPed.SQL.Add('  FGO_CODFPG AS CODFPG,');
    qryInfPed.SQL.Add('  FGO_CONPAG AS CONPAG,');
    qryInfPed.SQL.Add('  FGO_BOLADT AS BOLADT,');
    qryInfPed.SQL.Add('  FGO_BOLVEN AS BOLVEN,');
    qryInfPed.SQL.Add('  FGO_DESESP AS DESESP,');

    qryInfPed.SQL.Add('  (SELECT SUM(DET_DESESP * IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1)) ');
    qryInfPed.SQL.Add('   FROM MOVDET                                            ');
    qryInfPed.SQL.Add('   WHERE  DET_TIP_FC = "C"                                ');
    qryInfPed.SQL.Add('      AND DET_ORIDOC = "V"                                ');
    qryInfPed.SQL.Add('      AND DET_CODEMP = FGO_EMPFAT                         ');
    qryInfPed.SQL.Add('      AND DET_ESPDOC = FGO_TIPFAT                         ');
    qryInfPed.SQL.Add('      AND DET_NUMDOC = FGO_NUMFAT) AS VLRDESC_MOVGER,     ');

    qryInfPed.SQL.Add('  (SELECT SUM(DET_DESESP * IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1)) ');
    qryInfPed.SQL.Add('   FROM NOTDET                                            ');
    qryInfPed.SQL.Add('   WHERE  DET_TIP_FC = "C"                                ');
    qryInfPed.SQL.Add('      AND DET_ORIDOC = "V"                                ');
    qryInfPed.SQL.Add('      AND DET_CODEMP = FGO_EMPFAT                         ');
    qryInfPed.SQL.Add('      AND DET_ESPDOC = FGO_TIPFAT                         ');
    qryInfPed.SQL.Add('      AND DET_NUMDOC = FGO_NUMFAT) AS VLRDESC_NOTGER,     ');

    qryInfPed.SQL.Add('  FGO_VLRCON-FGO_TOTBRI AS VLRCON,      ');
    qryInfPed.SQL.Add('                                        ');
    qryInfPed.SQL.Add('  (SELECT                               ');
    qryInfPed.SQL.Add('     SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) ');
    qryInfPed.SQL.Add('   FROM ');
    qryInfPed.SQL.Add('     CADREC ');
    qryInfPed.SQL.Add('   WHERE ');
    qryInfPed.SQL.Add('     ((CTR_NUMDUP = FGO_NUMDOC  AND ');
    qryInfPed.SQL.Add('       CTR_ESPDOC = FGO_ESPDOC  AND ');
    qryInfPed.SQL.Add('       CTR_CODEMP = FGO_CODEMP  AND ');
    qryInfPed.SQL.Add('       CTR_CODCLI = FGO_CODCLI)/*CADREC*/) AND ');
    qryInfPed.SQL.Add('     CTR_DTAREC IS NOT NULL) AS VALREC, ');
    qryInfPed.SQL.Add('            ');
    qryInfPed.SQL.Add('  (SELECT   ');
    qryInfPed.SQL.Add('     SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ');
    qryInfPed.SQL.Add('   FROM     ');
    qryInfPed.SQL.Add('     ADTCLI ');
    qryInfPed.SQL.Add('   WHERE    ');
    qryInfPed.SQL.Add('     (ADT_NUMDOC = FGO_NUMDOC AND ');
    qryInfPed.SQL.Add('      ADT_ESPDOC = FGO_ESPDOC AND ');
    qryInfPed.SQL.Add('      ADT_CODEMP = FGO_CODEMP AND ');
    qryInfPed.SQL.Add('      ADT_CODCLI = FGO_CODCLI)/*ADTCLI*/) AS VALADT, ');

    If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) And
       (Not fCfgSis('NPLF11', VarBoolean)) And (Not fCfgSis('LOCRET', VarBoolean)) Then
    Begin
      qryInfPed.SQL.Add('  "N" AS ORIF11,');
    End
    Else
    Begin
      qryInfPed.SQL.Add('  (SELECT ');
      qryInfPed.SQL.Add('     IF(COUNT(*) > 0, "S", "N") ');
      qryInfPed.SQL.Add('   FROM ');
      qryInfPed.SQL.Add('     FATDOR AS PEDORI ');
      qryInfPed.SQL.Add('   WHERE ');
      qryInfPed.SQL.Add('     PEDORI.FDO_NUMFAT = FATGOR.FGO_NUMDOC AND ');
      qryInfPed.SQL.Add('     PEDORI.FDO_TIPFAT = FATGOR.FGO_ESPDOC AND ');
      qryInfPed.SQL.Add('     PEDORI.FDO_EMPFAT = FATGOR.FGO_CODEMP) AS ORIF11, ');
    End;

    qryInfPed.SQL.Add(' (SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N", "N", "S") ');
    qryInfPed.SQL.Add('    FROM FATDOR FD ');
    qryInfPed.SQL.Add('    LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ');
    qryInfPed.SQL.Add('   WHERE FD.FDO_SEQGER = FATGOR.AUTOINCREM) AS BENFUT, ');
    qryInfPed.SQL.Add('   IF(IFNULL(MOVGPV.AUTOINCREM, 0) = 0, 0, 1) AS TEMMOVGPV, ');

    qryInfPed.SQL.Add('  (SELECT ');
    qryInfPed.SQL.Add('     GROUP_CONCAT(FPN_CODFPG) ');
    qryInfPed.SQL.Add('   FROM ');
    qryInfPed.SQL.Add('     FPGNEG ');
    qryInfPed.SQL.Add('   WHERE ');
    qryInfPed.SQL.Add('     FPGNEG.FPN_SEQFGO = FATGOR.AUTOINCREM) AS FPGNEG ');

    qryInfPed.SQL.Add('FROM     ');
    qryInfPed.SQL.Add('  FATGOR ');
    qryInfPed.SQL.Add('  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ');
    qryInfPed.SQL.Add('  INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ');
    qryInfPed.SQL.Add('  INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryInfPed.SQL.Add('  LEFT  JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM ');
    qryInfPed.SQL.Add('WHERE    ');
    qryInfPed.SQL.Add(' FGO_NUMDOC = :NUMDOC AND ');
    qryInfPed.SQL.Add(' FGO_ESPDOC = :ESPDOC AND ');
    qryInfPed.SQL.Add(' FGO_CODEMP = :CODEMP     ');

    qryInfPed.ParamByName('NUMDOC').AsString := strNumDoc;
    qryInfPed.ParamByName('ESPDOC').AsString := strEspDoc;
    qryInfPed.ParamByName('CODEMP').AsString := strCodEmp;

    qryInfPed.Open;
    qryInfPed.First;

    If qryInfPed.FieldByName('TEMMOVGPV').AsInteger = 1 Then
      Exit;

    fltVlrCon := fFormataFloat(qryInfPed.FieldByName('VLRCON').AsFloat, 2);

    If (blnSomaValRecDocsFats) Then
    Begin

      While Not qryInfPed.Eof Do
      Begin
        If (qryInfPed.FieldByName('TIPFAT').AsString = 'PD') Then
        Begin
          stlDocAdt.Add(' (ADT_NUMDOC='+qryInfPed.FieldByName('NUMFAT').AsString.QuotedString+' AND '+
                        '  ADT_ESPDOC='+qryInfPed.FieldByName('TIPFAT').AsString.QuotedString+' AND '+
                        '  ADT_CODEMP='+qryInfPed.FieldByName('EMPFAT').AsString.QuotedString+' AND '+
                        '  ADT_CODCLI='+qryInfPed.FieldByName('CODCLI').AsString.QuotedString+') ');

          If fCarregaPedidoFaturado(qryInfPed.FieldByName('NUMFAT').AsString,
                                    qryInfPed.FieldByName('TIPFAT').AsString,
                                    qryInfPed.FieldByName('EMPFAT').AsString,
                                    qryInfPed.FieldByName('CODCLI').AsString) Then
          Begin
            qryPedFat.First;
            While Not qryPedFat.Eof Do
            Begin
              If (Not fEmptyStr(qryPedFat.FieldByName('TIPFAT').AsString)) Then
              Begin
                stlDocFat.Add(' (CTR_NUMDUP='+qryPedFat.FieldByName('NUMFAT').AsString.QuotedString+' AND '+
                              '  CTR_ESPDOC='+qryPedFat.FieldByName('TIPFAT').AsString.QuotedString+' AND '+
                              '  CTR_CODEMP='+qryPedFat.FieldByName('EMPFAT').AsString.QuotedString+' AND '+
                              '  CTR_CODCLI='+qryPedFat.FieldByName('CODCLI').AsString.QuotedString+') ');
              End;

              qryPedFat.Next;
            End;
          End;
        End
        Else If (Not fEmptyStr(qryInfPed.FieldByName('TIPFAT').AsString)) Then
        Begin
          stlDocFat.Add(' (CTR_NUMDUP='+qryInfPed.FieldByName('NUMFAT').AsString.QuotedString+' AND '+
                        '  CTR_ESPDOC='+qryInfPed.FieldByName('TIPFAT').AsString.QuotedString+' AND '+
                        '  CTR_CODEMP='+qryInfPed.FieldByName('EMPFAT').AsString.QuotedString+' AND '+
                        '  CTR_CODCLI='+qryInfPed.FieldByName('CODCLI').AsString.QuotedString+') ');
        End;
        qryInfPed.Next;
      End;

      For intIdx:=0 To stlDocAdt.Count-1 Do
        strSQLDocAdt := strSQLDocAdt + ' OR ' + stlDocAdt[intIdx];

      For intIdx:=0 To stlDocFat.Count-1 Do
        strSQLDocFat := strSQLDocFat + ' OR ' + stlDocFat[intIdx];

      If (Not fEmptyStr(strSQLDocAdt)) Or (Not fEmptyStr(strSQLDocFat)) Then
      Begin
        qryInfPed.Close;

        If (Not fEmptyStr(strSQLDocAdt)) Then
          qryInfPed.SQL.Text := AnsiReplaceStr(qryInfPed.SQL.Text, '/*ADTCLI*/', strSQLDocAdt);

        If (Not fEmptyStr(strSQLDocFat)) Then
          qryInfPed.SQL.Text := AnsiReplaceStr(qryInfPed.SQL.Text, '/*CADREC*/', strSQLDocFat);

        qryInfPed.Open;
      End;

      qryInfPed.First;

      fltDesEspDif := 0;
      fltDesEspFat := (qryInfPed.FieldByName('VLRDESC_MOVGER').AsFloat + qryInfPed.FieldByName('VLRDESC_NOTGER').AsFloat);
      If (fltDesEspFat > qryInfPed.FieldByName('DESESP').AsFloat) Then
      Begin
        //Se foi dado mais desconto no ato do faturamento, apura-se o quanto a mais foi dado, para descontar do valor contábil do pedido;
        fltDesEspDif := fltDesEspFat - qryInfPed.FieldByName('DESESP').AsFloat;
      End;

      fltValRec := fFormataFloat(qryInfPed.FieldByName('VALADT').AsFloat + qryInfPed.FieldByName('VALREC').AsFloat, 2);
      fltVlrCon := fFormataFloat(qryInfPed.FieldByName('VLRCON').AsFloat - fltDesEspDif, 2) ;
      strConPag := qryInfPed.FieldByName('CONPAG').AsString;

      If ((strConPag = '01000') And (fltValRec > 0) And (fltValRec < fltVlrCon))
         Or
         ((fltValRec <= 0) And (strConPag <> '01000') And (fConPagComEntrada(strConPag))) Then
      Begin
        blnJaUsouCreditoDeAdiantamento := fJaUsouCreditoDeAdiantamento(strNumDoc, strEspDoc, strCodEmp);
      End;
    End;

    Result := fValidaSituacaoFinanceiraPedido(qryInfPed.FieldByName('CODCLI').AsString,
                                              qryInfPed.FieldByName('ESPDOC').AsString,
                                              qryInfPed.FieldByName('CODFPG').AsString,
                                              qryInfPed.FieldByName('CONPAG').AsString,
                                              qryInfPed.FieldByName('FPGNEG').AsString,
                                              qryInfPed.FieldByName('INCGOR').AsString,
                                              qryInfPed.FieldByName('TIPOPE').AsString,
                                              qryInfPed.FieldByName('ORIF11').AsString = 'S',
                                              fltVlrCon,
                                              fFormataFloat(qryInfPed.FieldByName('VALADT').AsFloat +
                                                            qryInfPed.FieldByName('VALREC').AsFloat, 2),
                                              qryInfPed.FieldByName('BOLADT').AsFloat,
                                              qryInfPed.FieldByName('BOLVEN').AsString = 'S',
                                              qryInfPed.FieldByName('BENFUT').AsString = 'S',
                                              strPenFin,
                                              blnJaUsouCreditoDeAdiantamento,
                                              qryInfPed.FieldByName('ENVCON').AsString = 'S',
                                              blnEhTelaFormulacaoTinta);
  Finally
    FreeAndNil(stlDocFat);
    FreeAndNil(stlDocAdt);
  {$IFNDEF LINUX}
    FreeAndNil(qryInfPed);
    FreeAndNil(qryPedFat);
  {$ENDIF LINUX}
  End;
end;

function fValidaSituacaoFinanceiraPedido(strCodCli, strEspDoc, strCodFpg, strConPag,
                                         strFpgNeg, strIncGor, strTipOpe: String;
                                         blnOriF11: Boolean;
                                         fltVlrCon, fltValRec, fltBolAdt: Double;
                                         blnBolVen: Boolean;
                                         btnBEnFut: Boolean;
                                         Var strPenFin: String;
                                         blnJaUsouCreditoDeAdiantamento: Boolean = False;
                                         AblnPedidoGeradoViaEnvioConsignacao : Boolean = False;
                                         blnEhTelaFormulacaoTinta: boolean = False): Boolean;

  Var
    fltAdtPed : Double;
    fltVlrAvi : Double;
    fltVlrCre : Double;
begin
  strPenFin := '';

  If strEspDoc <> 'PD' Then
    Exit(True);

  If (strTipOpe = 'B') Then
    Exit(True);

  If (strTipOpe = 'U') Then
    Exit(True);

  If strCodFpg = '003' Then
    Exit(True);

  If (strCodFpg = '012') And (fCfgSis('LFP012') = 'L') Then
    Exit(True);

  If strCodFpg = '014' Then
    Exit(True);

  If strCodFpg = '015' Then
    Exit(True);

  If (btnBEnFut) Then
    Exit(True);

  If (strTipOpe = 'A') And (fCfgSis('SFDEPA', VarString) = 'L') Then
    Exit(True);

  If (strCodFpg = '016') Then
  Begin
    fltAdtPed := fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [strIncGor]) ;

    If (fFormataFloat(fltAdtPed, 2) > 0) Then
      Exit(fltValRec >= fFormataFloat(fltAdtPed, 2))
    Else
      Exit(True);
  End;

  If Pos(strCodCli, VS_strCliFil) > 0 Then
    Exit(True);

  If (blnOriF11) And (strCodFpg = '009') And (Pos('015', strFpgNeg) > 0) Then
  Begin
    If (Pos('008', strFpgNeg) > 0) Then
      Exit(True);

    If (Pos('013', strFpgNeg) > 0) And (fltValRec > 0) Then
      Exit(True);
  End;

  if (strEspDoc = 'PD') and (AblnPedidoGeradoViaEnvioConsignacao) then
    Exit(True);

  If (fltBolAdt > 0) And (Not blnBolVen) And (Not fSolicitaDigDuplicAdiantamentoPedido) Then
  Begin
    strPenFin := 'Boleto de adiantamento ainda não foi baixado pela remessa bancária';
    Exit(False);
  End;

  Result := True;

  If (strConPag = '01000') And (fltValRec < fltVlrCon) Then
  Begin
    If fltValRec = 0 Then
    Begin
      strPenFin := 'Pedido à vista ainda não foi recebido';
      Exit(False);
    End
    Else
    Begin
      If Abs(fltValRec - fltVlrCon) > TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL Then
      Begin
        strPenFin := 'Pedido à vista com recebimento menor que o valor do documento';
        Exit(False);
      End;
    End;
  End;

  If (strConPag <> '01000') And (fConPagComEntrada(strConPag)) And ((fltValRec <= 0) And (Not blnJaUsouCreditoDeAdiantamento)) Then
  Begin
    strPenFin := 'Pedido a prazo com uma entrada que ainda não foi recebida';
    Exit(False);
  End;

  {*******************************************************************}
  {* ALTERACAO SOLICITADA PELA COFERT - REQUISITO: 28182             *}
  {****************************************************************JC*}
  If Pos(strCodFpg, '002_006_007_013_') > 0 Then
  Begin
    If (fltValRec < fltVlrCon) Then
    Begin
      strPenFin := 'Pedido com forma de pagamento "' + fRetDescFpg(strCodFpg) + '"';
      If fltValRec = 0 Then
      Begin
        strPenFin := strPenFin + ' ainda não foi recebido';
        Exit(False);
      End
      Else
      If Abs(fltValRec - fltVlrCon) > TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL Then
      Begin
        strPenFin := strPenFin + ' com recebimento menor que o valor do documento';
        Exit(False);
      End;
    End;
  End;

  If (blnEhTelaFormulacaoTinta) And (Pos(strCodFpg, '009_') > 0) And (fltValRec > 0) Then
  Begin
    fltVlrAvi := fRetornaValorFpgNegAVista(strIncGor);
    fltVlrCre := fRetornaValorCreditoAdtCli(strIncGor);

    if (fltVlrAvi > 0) And (fltVlrCre = 0) then
      Exit(True);
  End;

  If (Pos(strCodFpg, '009_') > 0) Then
  Begin
    fltVlrAvi := fRetornaValorFpgNegAVista(strIncGor);
    fltVlrCre := fRetornaValorCreditoAdtCli(strIncGor);

    If (fltVlrAvi > 0) And (fltVlrCre < fltVlrAvi) Then
    Begin
      strPenFin := 'Pedido com forma de pagamento negociada à vista ';

      If (fltValRec = 0) Then
        strPenFin := strPenFin + ' ainda não foi recebido'
      Else
        strPenFin := strPenFin + ' com recebimento menor que o valor negociado à vista';

      Exit(False);
    End;
  End;


end;

function fRetornaValorFpgNegAVista(const strIncGor: String):Double;
var
  qryFpgNeg: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strFpgSel: String;
begin
  qryFpgNeg := fCriaQuery();

  strFpgSel := '"001", "002", "006", "007", "013"';

  If (fCfgSis('LFP012', VarString) = 'B') Then
    strFpgSel := strFpgSel + ', "012"';

  Try
    qryFpgNeg.SQL.Add('  SELECT                                   ');
    qryFpgNeg.SQL.Add('    COALESCE(SUM(FPN_VALFPG), 0) VLRAVI    ');
    qryFpgNeg.SQL.Add('  FROM                                     ');
    qryFpgNeg.SQL.Add('    FPGNEG                                 ');
    qryFpgNeg.SQL.Add('  WHERE FPN_SEQFGO = :SEQFGO               ');
    qryFpgNeg.SQL.Add('    AND FPN_CONPAG = "01000"               ');
    qryFpgNeg.SQL.Add('    AND FPN_CODFPG IN (' + strFpgSel + ')  ');

    qryFpgNeg.ParamByName('SEQFGO').AsString := strIncGor;

    qryFpgNeg.Open;

    Result := qryFpgNeg.FieldByName('VLRAVI').AsFloat;

  Finally
    {$IFNDEF LINUX}
    FreeAndNil(qryFpgNeg);
    {$ENDIF LINUX}
  End;

end;

function fRetornaValorCreditoAdtCli(const strIncGor: String):Double;
var
  qryAdtCli: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryAdtCli := fCriaQuery();

  Try
    qryAdtCli.SQL.Add('  SELECT                                 ');
    qryAdtCli.SQL.Add('    COALESCE(SUM(ADT_VALLAN), 0) VALCRE  ');
    qryAdtCli.SQL.Add('  FROM                                   ');
    qryAdtCli.SQL.Add('    FATGOR FG                            ');
    qryAdtCli.SQL.Add('    INNER JOIN ADTCLI AC                 ');
    qryAdtCli.SQL.Add('      ON FG.FGO_NUMDOC = AC.ADT_NUMDOC   ');
    qryAdtCli.SQL.Add('      AND FG.FGO_ESPDOC = AC.ADT_ESPDOC  ');
    qryAdtCli.SQL.Add('      AND FG.FGO_CODEMP = AC.ADT_CODEMP  ');
    qryAdtCli.SQL.Add('      AND FG.FGO_CODCLI = AC.ADT_CODCLI  ');
    qryAdtCli.SQL.Add('  WHERE FG.AUTOINCREM = :AUTINC          ');
    qryAdtCli.SQL.Add('    AND AC.ADT_TIPLAN = "C"              ');


    qryAdtCli.ParamByName('AUTINC').AsString := strIncGor;

    qryAdtCli.Open;

    Result := qryAdtCli.FieldByName('VALCRE').AsFloat;

  Finally
    {$IFNDEF LINUX}
    FreeAndNil(qryAdtCli);
    {$ENDIF LINUX}
  End;

end;




end.
