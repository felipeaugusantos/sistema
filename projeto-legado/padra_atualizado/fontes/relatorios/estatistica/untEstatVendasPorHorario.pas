unit untEstatVendasPorHorario;

interface
{$M+}

uses Controls, SysUtils, DateUtils, StrUtils, untTypesSistema;

const
  INT_MINUTOS_INTERVALO_ENTRE_HORARIOS = 60;

  Type
    TRelEstVendasPorPeriodo = Class(TObject)
    private
      FHoraAbertura : Integer;
      FHoraFechamento : Integer;
      FCodEmp: String;

      FCodDep: TObject;
      FArrDep: TConsultasArray;
      function fSQLMontaHorario(intHorario: Integer): String;
      function fGetSubSelect: String;
      function fGetFrom: String;
      function fGetWhere: String;
      function fGetSelect(strSQL : String): String;
    public
      constructor Create;
      function fQtdColunas: Integer;
      function fGetUltCol: String;
      function fGetSQLRelatorio: String;
    published
      property intHoraAbertura: Integer read FHoraAbertura write FHoraAbertura;
      property intHoraFechamento: Integer read FHoraFechamento write FHoraFechamento;
      property strCodEmp: String read FCodEmp write FCodEmp;
      property edtCodDep: TObject read FCodDep write FCodDep;
      property arrCodDep: TConsultasArray read FArrDep write FArrDep;
    End;

implementation

uses untConstantes, untFuncoesFactory, untIFuncoes;

constructor TRelEstVendasPorPeriodo.Create;
begin
  inherited Create;
end;

function TRelEstVendasPorPeriodo.fGetFrom: String;
begin
  Result := ' FROM ';
  Result := Result + '  MOVDET D ';
  Result := Result + '  INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';

  //NÃO FOI COLOCADA A COM_FV POIS ESSE RELATÓRIO JÁ FOI CONVERTIDO PARA O EDITOR DE MODELOS
  If (fCfgSis('COM_FF') = '2') Or
     (fCfgSis('COM_TR') = '2') Or
     (fCfgSis('COM_DV') = '2') Then
  Begin
    Result := Result + ' LEFT JOIN NOTGER N ON N.GER_NUMDOC = G.GER_NUMFAT AND ';
    Result := Result + '                       N.GER_ESPDOC = G.GER_TIPFAT AND ';
    Result := Result + '                       N.GER_CODEMP = G.GER_EMPFAT     ';
  End;
end;

function TRelEstVendasPorPeriodo.fGetUltCol: String;
  Var
    intCnt,
    intSeq : Integer;
  Const
    arrLet : Array [1..27] Of String[2] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                                           'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                                           'AA');
begin
  intSeq := 2; // DataFat e TotalGeral
  For intCnt := intHoraAbertura To intHoraFechamento Do
  Begin
    Inc(intSeq);
  End;
  Result := String(arrLet[intSeq]);
end;

function TRelEstVendasPorPeriodo.fGetSelect(strSQL : String): String;
  Var
    intCnt : Integer;
    strHora : String;
    strSomValParci : String;
    strSomValTotal : String;
    strSomQtdParci : String;
    strSomQtdTotal : String;
begin
  Result := '';
  Result := Result + 'SELECT      ';
  Result := Result + '  GER_DATA AS DET_DATA, ';

  strSomValTotal := '';
  strSomValParci := '';
  strSomQtdParci := '';
  strSomQtdTotal := '';

  For intCnt := FHoraAbertura To FHoraFechamento Do
  Begin
    strHora := fStrZero(intCnt, 2);

    // Soma Valores
    strSomValParci := ' SUM(MIA_' + strHora + 'HS + FFN_'  + strHora  + 'HS + MIFFC_' +
                                    strHora + 'HS + NFIF_' + strHora  + 'HS + TR_' +
                                    strHora + 'HS) '; 

    // Soma Quantidade
    strSomQtdParci := ' SUM(QTD_' + strHora + 'HS) ';

    Result := Result + strSomValParci + ' AS TOT_' + strHora + 'HS, ';
    Result := Result + strSomQtdParci + ' AS QTD_' + strHora + 'HS, ';

    If (intCnt <> FHoraFechamento) Then
    Begin
      strSomValParci := strSomValParci + ' + ';
      strSomQtdParci := strSomQtdParci + ' + ';
    End;

    strSomValTotal := strSomValTotal + strSomValParci;
    strSomQtdTotal := strSomQtdTotal + strSomQtdParci;
  End;

  Result := Result + strSomValTotal + ' AS TOT_GERAL, ';
  Result := Result + strSomQtdTotal + ' AS QTD_GERAL  ';
  Result := Result + 'FROM       (';
  Result := Result + strSQL;
  Result := Result + ') AS TAB    ';
  Result := Result + 'GROUP BY    ';
  Result := Result + '  GER_DATA  ';
end;

function TRelEstVendasPorPeriodo.fGetSQLRelatorio: String;
  Var
    strSQL : String;
    strComFF  : String;
    strComTR  : String;
    strComDV  : String;

    function fGetHoraGer: String;
    Begin
      Result := 'IF(G.GER_JAFATU = 1, N.GER_HORENT, G.GER_HORENT)';
    End;

    function fGetHoraDet: String;
    Begin
      Result := 'IF(DET_JAFATU = 1, N.GER_HORENT, DET_HORENT)';
    End;
begin
  strSQL := fGetSubSelect +
            fGetFrom +
            fGetWhere ;

  strComFF := strSQL;
  strComTR := strSQL;
  strComDV := strSQL;

  If (fCfgSis('COM_FF') = '2') Then
  Begin
    strComFF := AnsiReplaceStr(strComFF, 'G.GER_DTAENT', 'G.GER_DTAFAT');
    strComFF := AnsiReplaceStr(strComFF, 'NOT IN ("FF")', 'IN ("FF")');
    strComFF := AnsiReplaceStr(strComFF, 'G.GER_HORENT', fGetHoraGer);
    strComFF := AnsiReplaceStr(strComFF, 'DET_HORENT', fGetHoraDet);
    strSQL  := strSQL + ' UNION ALL ' + strComFF;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("FF")', 'NOT IN ("")');

  If (fCfgSis('COM_TR') = '2') Then
  Begin
    strComTR := AnsiReplaceStr(strComTR, 'G.GER_DTAENT', 'G.GER_DTAFAT');
    strComTR := AnsiReplaceStr(strComTR, 'NOT IN ("TR")', 'IN ("TR")');
    strComTR := AnsiReplaceStr(strComTR, 'G.GER_HORENT', fGetHoraGer);
    strComTR := AnsiReplaceStr(strComTR, 'DET_HORENT', fGetHoraDet);

    strSQL  := strSQL + ' UNION ALL ' + strComTR;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("TR")','NOT IN ("")');

  If (fCfgSis('COM_DV') = '2') Then
  Begin
    strComDV := AnsiReplaceStr(strComDV, 'G.GER_DTAENT', 'G.GER_DTAFAT');
    strComDV := AnsiReplaceStr(strComDV, 'NOT IN ("DV")', 'IN ("DV")');
    strComDV := AnsiReplaceStr(strComDV, 'G.GER_HORENT', fGetHoraGer);
    strComDV := AnsiReplaceStr(strComDV, 'DET_HORENT', fGetHoraDet);

    strSQL := strSQL + ' UNION ALL ' + strComDV;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("DV")','NOT IN ("")');

  Result := fGetSelect( strSQL );
end;

function TRelEstVendasPorPeriodo.fGetSubSelect: String;
  Var
    intCnt : Integer;
begin
  Result := '           SELECT SQL_NO_CACHE ';
  Result := Result + '         G.GER_DTAENT AS GER_DATA, ';

  For intCnt := FHoraAbertura To FHoraFechamento Do
  Begin
    Result := Result + fSQLMontaHorario(intCnt);

    If Not (intCnt = FHoraFechamento) Then
      Result := Result + ', ';
  End;
end;

function TRelEstVendasPorPeriodo.fGetWhere: String;
begin
  Result := ' WHERE ';
  Result := Result + '  G.GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '  DET_PROEMB <> "S" AND ';
  Result := Result + '  DET_TIP_FC = "C"  AND ';
  Result := Result + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  Result := Result + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    Result := Result + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0) '
  Else
    Result := Result + ') ';

  If Not fEmptyStr(FCodEmp) Then
    Result := Result + ' AND DET_CODEMP = :CODEMP '
  Else
    Result := Result + ' AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  Result := Result + '  AND DET_ESPDOC NOT IN ("FF") ';
  Result := Result + '  AND DET_ESPDOC NOT IN ("TR") ';
  Result := Result + '  AND DET_ESPDOC NOT IN ("DV") ';

  Result := Result + fStrLocate(edtCodDep, arrCodDep, 'ITE_CODDEP', 'DEPITE');

  Result := Result + 'GROUP BY     ';
  Result := Result + '  G.GER_DTAENT, G.GER_HORENT ';
end;

function TRelEstVendasPorPeriodo.fQtdColunas: Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;

  For intCnt := FHoraAbertura To FHoraFechamento Do
  Begin
    Inc(Result);

    If (Result >= FHoraFechamento) Then
      Break;
  End;
end;

function TRelEstVendasPorPeriodo.fSQLMontaHorario(intHorario: Integer): String;
  Var
    strSQL : String;
    strTimeIni : String;
    strTimeFin : String;
    strHora : String;
    dtaHorFin : TDateTime;
begin
  strSQL := '';
  strHora := fStrZero(intHorario, 2);
  dtaHorFin := EncodeDateTime(YearOf(VS_DATE), MonthOf(VS_DATE), DayOf(VS_DATE), intHorario, 0, 0, 0) ;
  strTimeIni := '"' + fStrZero(intHorario, 2) + ':00:00"';

  (*
  If (intHorario = FHoraAbertura) Then
  Begin
    strSQL := strSQL + '  IF(GER_HORENT <= TIME(' + strTimeIni + '), COUNT(DISTINCT(CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI))), 0) AS QTD_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT <= TIME(' + strTimeIni + '), ';
    strSQL := strSQL + '    SUM(IF((GER_ESPDOC IN ("NF", "EL", "IF", "D1", "NS")) AND LEFT(DET_CLAFIS,1) >= 5 AND (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0), DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS NFIF_' + strHora + 'HS,  ';
    strSQL := strSQL + '  IF(DET_HORENT <= TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC = "MI" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIA_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT <= TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC = "FF" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS FFN_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT <= TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC IN ("FF","MI") AND DET_JAFATU = 1 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIFFC_' + strHora + 'HS, ';
    strSQL := strSQL + '  IF(DET_HORENT <= TIME(' + strTimeIni + '), ';
    strSQL := strSQL + '    SUM(IF(GER_ESPDOC = "TR" OR GER_ESPDOC = "DV" OR LEFT(DET_CLAFIS,1) < 5, ';
    strSQL := strSQL + '    IF(LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, -(DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)), 0) AS TR_' + strHora + 'HS ';
  End
  Else If (intHorario = FHoraFechamento) Then
  Begin
    strSQL := strSQL + '  IF(GER_HORENT > TIME(' + strTimeIni + '), COUNT(DISTINCT(CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI))), 0) AS QTD_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT > TIME(' + strTimeIni + '), ';
    strSQL := strSQL + '    SUM(IF((GER_ESPDOC IN ("NF", "EL", "IF", "D1", "NS")) AND LEFT(DET_CLAFIS,1) >= 5 AND (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0), DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS NFIF_' + strHora + 'HS,  ';
    strSQL := strSQL + '  IF(DET_HORENT > TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC = "MI" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIA_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT > TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC = "FF" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS FFN_' + strHora + 'HS,   ';
    strSQL := strSQL + '  IF(DET_HORENT > TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC IN ("FF","MI") AND DET_JAFATU = 1 AND LEFT(DET_CLAFIS,1) >= 5, ';
    strSQL := strSQL + '    DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIFFC_' + strHora + 'HS, ';
    strSQL := strSQL + '      IF(DET_HORENT > TIME(' + strTimeIni + '), SUM(IF(GER_ESPDOC = "TR" OR GER_ESPDOC = "DV" OR LEFT(DET_CLAFIS,1) < 5, ';
    strSQL := strSQL + '        IF(LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, -(DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)), 0) AS TR_' + strHora + 'HS ';
  End
  Else
  Begin*)
  
  // Incrementa 60 Minutos para o tempo final;
  dtaHorFin := IncMinute(dtaHorFin, INT_MINUTOS_INTERVALO_ENTRE_HORARIOS);
  // Aqui o tempo inicial começa com um segundo a mais.
  strTimeIni := '"' + fStrZero(intHorario, 2) + ':00:01"';
  //  
  strTimeFin := '"' + FormatDateTime('hh:nn:ss', dtaHorFin) + '"';

  strSQL := strSQL + '  IF(G.GER_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), COUNT(DISTINCT(CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI))), 0) AS QTD_' + strHora + 'HS,   ';
  strSQL := strSQL + '  IF(DET_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), ';
  strSQL := strSQL + '    SUM(IF((G.GER_ESPDOC IN ("NF", "EL", "IF", "IV", "D1", "NS")) AND LEFT(DET_CLAFIS,1) >= 5 AND (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0), DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS NFIF_' + strHora + 'HS,  ';
  strSQL := strSQL + '  IF(DET_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), SUM(IF(G.GER_ESPDOC = "MI" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIA_' + strHora + 'HS,   ';
  strSQL := strSQL + '  IF(DET_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), SUM(IF(G.GER_ESPDOC = "FF" AND DET_JAFATU = 0 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS FFN_' + strHora + 'HS,   ';
  strSQL := strSQL + '  IF(DET_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), SUM(IF(G.GER_ESPDOC IN ("FF","MI") AND DET_JAFATU = 1 AND LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, 0)), 0) AS MIFFC_'  + strHora + 'HS, ';
  strSQL := strSQL + '  IF(DET_HORENT BETWEEN TIME(' + strTimeIni + ') AND TIME(' + strTimeFin + '), ';
  strSQL := strSQL + '    SUM(IF(G.GER_ESPDOC = "TR" OR G.GER_ESPDOC = "DV" OR LEFT(DET_CLAFIS,1) < 5, ';
  strSQL := strSQL + '      IF(LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, -(DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)), 0) AS TR_' + strHora + 'HS ';

  //End;

  Result := strSQL;
end;

end.
