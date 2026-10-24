unit untGarantiaColetaLibfuncoes;

interface

uses
  Uni;

function fSqlPedidosColeta: String;
function fObterQryDataSetPedidos(const strCodEmp: String; out cdsDados: TUniquery): boolean;

implementation
uses
  untFuncoesSimples, System.SysUtils;

function fSqlPedidosColeta: String;
begin
   Result :=          ' SELECT DISTINCT ';
   Result := Result +   ' D.AUTOINCREM, D.FDO_SEQGER AS "INCGOR", D.FDO_CODITE, D.FDO_QTDITE, D.FDO_CODITE, D.FDO_UNIDAD, D.FDO_QTDITE, D.FDO_UNITAR, ';
   Result := Result +   ' P.ITE_DESITE, P.ITE_CODFOR, I.ITE_PRECUS, ';
   Result := Result +   ' U.UNI_SIGUNI, ';
   Result := Result +   ' G.FGO_DTAENT, G.FGO_NUMDOC, G.FGO_ESPDOC, G.FGO_CODEMP, G.FGO_CODCLI, ';
   Result := Result +   ' C.CLI_NOMCLI, C.CLI_CODCID, ';
   {$Region 'VALITEUNITARIO'}
   Result := Result +   ' ((IF(LEFT(D1.DET_CLAFIS,1) < 5, ';
   Result := Result +           ' - (D1.DET_TOTITE - D1.DET_DESESP - D1.DET_DESCFF), ';
   Result := Result +           ' D1.DET_TOTITE - D1.DET_DESESP - D1.DET_DESCFF)) ';
   Result := Result +      ' /D1.DET_QTDITE) AS VALITEUNITARIO, ';
   {$Endregion}
   Result := Result +   ' D1.AUTOINCREM AS "INCDET", D1.DET_SEQGER AS "INCGER", D1.DET_TABPRE, D1.DET_NUMLOT, D1.DET_TOTFRE,  ';
   Result := Result +   ' G1.GER_NUMDOC, G1.GER_ESPDOC, G1.GER_CODEMP, D1.DET_VLRCON, ';

{$Region 'Obtendo IncoOri - Autoincrem da venda'}
     Result := Result + ' (SELECT NFV.AUTOINCREM ';
     Result := Result + '  FROM MOVDET NFV ';
     Result := Result + '  WHERE NFV.DET_NUMDOC = D1.DET_DOCDEV AND NFV.DET_ESPDOC = D1.DET_ESPDEV AND NFV.DET_CODEMP = D1.DET_EMPDEV ';
     Result := Result +          ' AND NFV.DET_CODITE = D1.DET_CODITE ';
     Result := Result + '  LIMIT 1) AS "INCORI" ';
{$Endregion}

   Result := Result + ' FROM  FATDOR D ';

   Result := Result + ' INNER JOIN FATGOR G  ON  G.AUTOINCREM = D.FDO_SEQGER ';

   Result := Result + ' INNER JOIN EXTGOR E  ON  E.FGO_SEQFGO = G.AUTOINCREM ';

   Result := Result + ' INNER JOIN MOVDET D1 ON D1.DET_NUMDOC = G.FGO_NUMFAT ';
   Result := Result +                         ' AND D1.DET_ESPDOC = G.FGO_TIPFAT ';
   Result := Result +                         ' AND D1.DET_CODEMP = G.FGO_EMPFAT ';
   Result := Result +                         ' AND D1.DET_CODITE = D.FDO_CODITE ';
   Result := Result +                         ' AND D1.DET_QTDITE = D.FDO_QTDITE ';

   Result := Result + ' INNER JOIN MOVGER G1 ON  G1.AUTOINCREM = D1.DET_SEQGER ';

   Result := Result + ' INNER JOIN AUXMOV A  ON  A.AUX_SEQGER = G1.AUTOINCREM ';
   Result := Result +                         ' AND A.AUX_OPCDOC = ''DV'' ';

   Result := Result + ' INNER JOIN CADCLI C  ON  C.CLI_CODCLI = G.FGO_CODCLI ';
   Result := Result + ' INNER JOIN CADITE P  ON  P.ITE_CODITE = D.FDO_CODITE ';
   Result := Result + ' INNER JOIN ITEGER I  ON  I.ITE_CODITE = D.FDO_CODITE AND I.ITE_CODEMP = D.FDO_CODEMP ';
   Result := Result + ' INNER JOIN CADUNI U  ON  U.UNI_CODUNI = D.FDO_UNIDAD ';

   Result := Result + ' WHERE D.FDO_CODEMP = :CODEMP AND E.FGO_COLETA = ''S'' AND (FDO_QTDITE > 0) ';
   Result := Result + ' GROUP BY D.AUTOINCREM ';
   Result := Result + ' ORDER BY  FGO_DTAENT, FGO_CODEMP, FGO_ESPDOC, FGO_NUMDOC, FDO_CODITE ';

end;

function fObterQryDataSetPedidos(const strCodEmp: String; out cdsDados: TUniquery): boolean;
begin
  Result := True;
  Try
    CdsDados := nil;
    CdsDados := fCriaQuery();
    CdsDados.Close;
    CdsDados.Sql.Clear;
    CdsDados.Sql.Add(fSqlPedidosColeta);
    CdsDados.ParamByName('CODEMP').AsString := strCodEmp;
    CdsDados.Open;
    if Not CdsDados.IsEmpty then
      CdsDados.First;
  Except
    On E: Exception do
    begin
      Result := False;
      if Assigned(CdsDados) then
        FreeAndNil(CdsDados);
    end;
  End;
end;


end.
