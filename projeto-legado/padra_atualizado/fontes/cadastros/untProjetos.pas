unit untProjetos;

interface

uses Uni, Classes, strUtils, System.SysUtils, untFuncoesSimples, Data.DB,
     DBEditFocus, untConstantes;

Type

  TProjeto = class(TComponent)
    private
      class function fGetSqlServVen: String;
      class function fGetSqlTotVendas(tipoItem: Char): String;
    public
      class function fClienteTemProjetoAtivo(strCodCli: String; strCodPrj: String = ''): Boolean;
      class function fClienteNoProjeto(strCodPrj, strCodCli: String) : Boolean;
      class function fUnicoClienteProjeto(strCodPrj: String; dbeCodCli: TDBEditFocus): Boolean;
      class procedure pVerificaConsumo(strCodPrj: String; var fltRecursos: Double; var fltProdutos: Double; var fltServicos: Double);
      class procedure pCarregaApontamentos(strSeqPrj: String; qryProDet: TUniQuery);
      class procedure pCarregaClientes(strCodPrj: String; qryCliPrj: TUniQuery);
      class procedure pCarregaRecursos(strCodPrj: String; qryProRec: TUniQuery);
      class procedure pCarregaContasPagar(strCodPrj: String; qryCadPag: TUniQuery);
      class procedure pCarregaCreditos(strCodPrj: String; qryCadRec: TUniQuery);
      class procedure pCarregaVendas(strCodPrj: String; qryProVen: TUniQuery);
      class procedure pCarregaServicos(strCodPrj: String; qryProVen: TUniQuery);
      class procedure pRecalculaProjeto(strCodPrj: String);
      class procedure pRecalculaVendas(strNumDoc, strEspDoc, strCodEmp: String);
      class procedure pRecalculaRecursos(strCodPrj: String);
      class procedure pRecalculaConsumo(strCodPrj: String);
      class function fProjetoDaVenda(strNumDoc, strEspDoc, strCodEmp: String): String;
      class function fProjetoDaVendaDevolvida(strNumDoc, strEspDoc, strCodEmp: String): String;
      class function fClienteTemLancamentosNoProjeto(strCodCli, strCodPrj: String): Boolean;

      Class function fRetornarSQLTotaisProdutos : String;
      Class function fRetornarSQLTotaisServicos: String;

  End;

implementation

class function TProjeto.fClienteTemLancamentosNoProjeto(strCodCli,
  strCodPrj: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery();

  Try
    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS QTD FROM MOVGER G ');
      SQL.Add('INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ');
      SQL.Add('WHERE GER_CODCLI = :CODCLI AND A.AUX_CODPRJ = :CODPRJ ');
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODPRJ').AsString := strCodPrj;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
      Begin
        Result := True;
        Close;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.fClienteTemLancamentosNoProjeto]');
  End;

  FreeAndNil(qryAux);
end;

class function TProjeto.fClienteTemProjetoAtivo(strCodCli: String; strCodPrj: String = ''): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;

  If Not fCfgSis('UTLPRJ', varBoolean) Then
    Exit;

  qryAux := fCriaQuery();

  With qryAux do
  Begin
    SQL.Add('SELECT PRJ_CODPRJ FROM CLIPRJ C ');
    SQL.Add('  INNER JOIN CADPRJ P ');
    SQL.Add('    ON P.PRJ_CODPRJ = C.CLI_CODPRJ AND P.PRJ_SITUAC = "A" ');
    SQL.Add('WHERE C.CLI_CODCLI = :CODCLI ');
    If Not fEmptyStr(strCodPrj) Then
    Begin
      SQL.Add(' AND P.PRJ_CODPRJ = :CODPRJ ');
      ParamByName('CODPRJ').AsString := strCodPrj;
    End;

    ParamByName('CODCLI').AsString := strCodcli;
    Open;

    Result := Not IsEmpty;

    Close;
  End;

  FreeAndNil(qryAux);
end;

class function TProjeto.fGetSqlServVen: String;
  Var
    intCont: Integer;
    strNum, strAlias: String;
begin
  Result := '';

  For intCont := 1 To 30 Do
  Begin
    strNum   := fStrZero(intCont, 2);
    strAlias := IIF(intCont < 7, 'G.', 'S.');

    Result := Result + 'SELECT G.GER_NUMDOC AS NUMDOC, ';
    Result := Result + '       G.GER_ESPDOC AS ESPDOC, ';
    Result := Result + '       G.GER_CODEMP AS CODEMP, ';
    Result := Result + '       G.GER_DTAENT AS DTAENT, ';
    Result := Result + '       G.GER_CODVEN AS CODVEN, ';
    Result := Result +         intCont.ToString +' AS SEQ, ';
    Result := Result + '       S.GER_QTDS'+ strNum +' AS QTDITE, ';
    Result := Result + '       S.GER_UNIS'+ strNum +' AS UNITAR, ';
    Result := Result + '       CONCAT('+ strAlias +'GER_CODS'+ strNum +', "-", '+ strAlias +'GER_DESS'+ strNum +') AS CODITE, ';
    Result := Result +         strAlias +'GER_VALS'+ strNum +' AS TOTITE ';
    Result := Result + 'FROM AUXMOV A ';
    Result := Result + 'JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER ';
    Result := Result + 'JOIN SERMOV S ON S.GER_SEQGER = G.AUTOINCREM ';
    Result := Result + 'WHERE A.AUX_CODPRJ = :CODPRJ ';
    Result := Result + 'AND '+ strAlias +'GER_CODS'+ strNum +' IS NOT NULL ';

    If intCont < 30 Then
      Result := Result + ' UNION ';
    End;
end;


class function TProjeto.fGetSqlTotVendas(tipoItem: Char): String;
begin
  Result := '';
  Result := Result + '(SELECT IFNULL(SUM(DET_TOTITE),0) AS TOTVEN FROM ';
  Result := Result + '(SELECT (IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS, ' + QuotedStr(CLAFIS_BR) + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) AS DET_TOTITE ';
  Result := Result + 'FROM AUXMOV A ';
  Result := Result + 'INNER JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER ';
  Result := Result + 'INNER JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND ';
  Result := Result + '                       D.DET_ESPDOC = G.GER_ESPDOC AND ';
  Result := Result + '                       D.DET_CODCLI = G.GER_CODCLI AND ';
  Result := Result + '                       D.DET_CODEMP = G.GER_CODEMP ';
  Result := Result + 'WHERE A.AUX_CODPRJ = :CODPRJ ';

  Case tipoItem Of
    'P': Result := Result + 'AND D.DET_CODITE NOT IN ("'+ fCfgSis('ITESER') +'","'+ fCfgSis('SERTER') +'")  AND D.DET_ESPDOC NOT IN ("NS") ';  //produtos
    'S': Result := Result + 'AND D.DET_CODITE     IN ("'+ fCfgSis('ITESER') +'","'+ fCfgSis('SERTER') +'") ';  //serviços
  End;

  Result := Result + ') AS TAB) ';
end;

class function TProjeto.fProjetoDaVenda(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryProj: TUniQuery;
begin
  If not ((strEspDoc = 'NF') Or (strEspDoc = 'NS')) Then
    Exit('');

  qryProj := fCriaQuery();

  Try
    qryProj.SQL.Clear;
    qryProj.SQL.Add('SELECT A.AUX_CODPRJ AS CODPRJ FROM MOVGER G ');
    qryProj.SQL.Add('INNER JOIN AUXMOV A ON A.AUX_SEQGER  = G.AUTOINCREM ');
    qryProj.SQL.Add('WHERE GER_NUMDOC = :NUMDOC AND ');
    qryProj.SQL.Add('      GER_ESPDOC = :ESPDOC AND ');
    qryProj.SQL.Add('      GER_CODEMP = :CODEMP ');
    qryProj.ParamByName('NUMDOC').AsString := strNumDoc;
    qryProj.ParamByName('ESPDOC').AsString := strEspDoc;
    qryProj.ParamByName('CODEMP').AsString := strCodEmp;
    qryProj.Open;

    If (Not qryProj.isEmpty) And (Not fEmptyStr(qryProj.FieldByName('CODPRJ').AsString)) Then
      Result := qryProj.FieldByName('CODPRJ').AsString
    Else
      Result := '';

    qryProj.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.fProjetoDaVenda]');
  End;

  FreeAndNil(qryProj);
end;

class function TProjeto.fProjetoDaVendaDevolvida(strNumDoc, strEspDoc,
  strCodEmp: String): String;
var
  qryProj: TUniQuery;
begin
  qryProj := fCriaQuery();

  Try
    With qryProj, SQL Do
    Begin
      Clear;

      Add('SELECT A.AUX_CODPRJ AS CODPRJ FROM MOVDET D ');
      Add('INNER JOIN MOVGER G ON G.GER_NUMDOC = DET_DOCDEV AND ');
      Add('		       G.GER_ESPDOC = DET_ESPDEV AND ');
      Add('		       G.GER_CODEMP = DET_EMPDEV ');
      Add('INNER JOIN AUXMOV A ON A.AUX_SEQGER  = G.AUTOINCREM ');
      Add('WHERE DET_NUMDOC = :NUMDOC AND ');
      Add('      DET_ESPDOC = :ESPDOC AND ');
      Add('      DET_CODEMP = :CODEMP ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If (Not isEmpty) And (Not fEmptyStr(FieldByName('CODPRJ').AsString)) Then
        Result := FieldByName('CODPRJ').AsString
      Else
        Result := '';

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.fProjetoDaVendaDevolvida]');
  End;

  FreeAndNil(qryProj);
end;

class function TProjeto.fRetornarSQLTotaisProdutos: String;
begin
    Result := 'SELECT '+
            '    SUM(IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS, ' + QuotedStr(CLAFIS_BR) + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) AS VALOR_FATURADO_PRODUTOS, '+
            '    SUM(                                               '+
            '      IF(                                              '+
            '        LEFT(DET_CLAFIS, 1) < 5,                       '+
            '        - IFNULL(ROUND((IFNULL(DET_TOTCUS, 0)), 2), 0),'+
            '        IFNULL(ROUND((IFNULL(DET_TOTCUS, 0)), 2), 0)   '+
            '      )                                                '+
            '    ) AS CUSTO_FATURADO_PRODUTOS,                      '+
            '    SUM(DET_TOTITE - DET_DESESP - DET_DESCFF - DET_TOTCUS) AS LUCRO_BRUTO, '+
            '    ((SUM((DET_TOTITE - DET_DESESP - DET_DESCFF) - DET_TOTCUS) / SUM(DET_TOTITE - DET_DESESP - DET_DESCFF)) * 100) AS MARGEM_LUCRO_PRODUTO,' +
            '    ((SUM(DET_TOTITE - DET_DESESP - DET_DESCFF) / :VALOR_ORCADO) * 100) AS REPRESENTATIVIDADE_ORCAMENTO_PRODUTO '+
            '  FROM AUXMOV A '+
            '    INNER JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER '+
            '    INNER JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND '+
            '                           D.DET_ESPDOC = G.GER_ESPDOC AND '+
            '                           D.DET_CODCLI = G.GER_CODCLI AND '+
            '                           D.DET_CODEMP = G.GER_CODEMP '+
            '    WHERE A.AUX_CODPRJ = :CODPRJ '+
            '     AND D.DET_CODITE NOT IN ("'+ fCfgSis('ITESER') +'","'+ fCfgSis('SERTER') +'")  '+
            '     AND D.DET_ESPDOC NOT IN ("NS") ';
end;

class function TProjeto.fRetornarSQLTotaisServicos: String;
begin
  Result :='SELECT '+
           '    SUM(DET_TOTITE-DET_DESESP-DET_DESCFF) AS VALOR_FATURADO_SERVICOS, '+
           '    SUM(DET_TOTCUS) AS CUSTO_SERVICOS, '+
           '    SUM((((DET_TOTITE-DET_DESESP-DET_DESCFF)-(:SOMA_RECURSOS_ALOCADOS)) / (DET_TOTITE-DET_DESESP-DET_DESCFF))* 100) AS MARGEM_LUCRO_SERVICO, '+
           '    SUM(((DET_TOTITE-DET_DESESP-DET_DESCFF) / :VALOR_ORCADO_SERVICO) * 100 ) AS REPRESENTATIVIDADE_ORCAMENTO_SERVICO '+
           'FROM AUXMOV A '+
           ' JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER '+
           ' JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND '+
           '                        D.DET_ESPDOC = G.GER_ESPDOC AND '+
           '                        D.DET_CODCLI = G.GER_CODCLI AND '+
           '                        D.DET_CODEMP = G.GER_CODEMP '+
           ' JOIN SERMOV S ON S.GER_SEQGER = G.AUTOINCREM '+
           ' WHERE A.AUX_CODPRJ = :CODPRJ ';
end;

class function TProjeto.fClienteNoProjeto(strCodPrj, strCodCli: String) : Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;
  qryAux := fCriaQuery();

  Try

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CLI_CODCLI FROM CLIPRJ ');
      SQL.Add('WHERE CLI_CODPRJ = :CODPRJ AND CLI_CODCLI = :CODCLI ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      Result := Not IsEmpty;
    End;
  Except
    On E: Exception Do
        pMensagensErro(E.Message, '[TProjeto.fClienteNoProjeto]');
  End;

  FreeAndNil(qryAux);
end;

class procedure TProjeto.pVerificaConsumo(strCodPrj: String;
  var fltRecursos: Double; var fltProdutos: Double; var fltServicos: Double);
var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery();

  Try
    With qryAux do
    Begin
      SQL.Clear;
      SQL.Add('SELECT SUM(VALTOT) AS VALTOT FROM ');
      SQL.Add('(SELECT ');
      SQL.Add('  (IF(D.DET_QTDHOR IS NOT NULL,(((LEFT(D.DET_QTDHOR,2) * 60) + RIGHT(D.DET_QTDHOR,2))/60) ,D.DET_QUANTI) * C.REP_VALCUS) AS VALTOT ');
      SQL.Add('FROM PROGER G ');
      SQL.Add('  INNER JOIN PRODET D ON D.DET_SEQGER = G.AUTOINCREM ');
      SQL.Add('  INNER JOIN CADREP C ON C.REP_CODREP = D.DET_CODREP ');
      SQL.Add('WHERE G.GER_CODPRJ = :CODPRJ) AS TAB ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      Open;

      fltRecursos := FieldByName('VALTOT').AsFloat;
    End;

    With qryAux do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT '+ fGetSqlTotVendas('P') +' AS TOTVEN');
      ParamByName('CODPRJ').AsString := strCodPrj;
      Open;

      fltProdutos := FieldByName('TOTVEN').AsFloat;

      Close;
      SQL.Clear;
      SQL.Add('SELECT '+ fGetSqlTotVendas('S') +' AS TOTVEN');
      ParamByName('CODPRJ').AsString := strCodPrj;
      Open;

      fltServicos := FieldByName('TOTVEN').AsFloat;

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pVerificaConsumo]');
  End;

  FreeAndNil(qryAux);
end;

class function TProjeto.fUnicoClienteProjeto(strCodPrj: String; dbeCodCli: TDBEditFocus): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;
  qryAux := fCriaQuery();

  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CLI_CODCLI FROM CLIPRJ WHERE CLI_CODPRJ = :CODPRJ ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      Open;

      If RecordCount = 1 Then
      Begin
        dbeCodCli.Text := FieldByName('CLI_CODCLI').AsString;
        Result := True;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmDigRecursosProjeto.fUnicoClienteProjeto]');
  End;

  FreeAndNil(qryAux);
end;

class procedure TProjeto.pCarregaApontamentos(strSeqPrj: String; qryProDet: TUniQuery);
begin
  Try
    With qryProDet, SQL Do
    Begin
      Close;

      Clear;
      Add('SELECT ');
      Add('   D.AUTOINCREM, ');
      Add('   DET_SEQGER, ');
      Add('   DET_CODREP, ');
      Add('   DET_DTAINI, ');
      Add('   DET_DTAFIN, ');
      Add('   DET_KMTINI, ');
      Add('   DET_KMTFIN, ');
      Add('   DET_QUANTI, ');
      Add('   DET_QTDHOR, ');
      Add('   DET_OBSERV, ');
      Add('   R.REP_NOMREP AS DET_NOMREP ');
      Add('FROM PRODET D' );
      Add('INNER JOIN CADREP R ON R.REP_CODREP = DET_CODREP ');
      Add('WHERE DET_SEQGER = :SEQGER ');

      ParamByName('SEQGER').AsString := strSeqPrj;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaApontamentos]');
  End;
end;

class procedure TProjeto.pCarregaClientes(strCodPrj: String; qryCliPrj: TUniQuery);
begin
  Try
    With qryCliPrj, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT' );
      Add('  C.AUTOINCREM, ');
      Add('  C.CLI_CODPRJ, ');
      Add('  C.CLI_CODCLI, ');
      Add('  CL.CLI_NOMCLI ');
      Add('FROM ');
      Add('  CLIPRJ C ');
      Add('INNER JOIN CADCLI CL ON CL.CLI_CODCLI = C.CLI_CODCLI ');
      Add('WHERE ');
      Add('  C.CLI_CODPRJ = :CODPRJ ');

      ParamByName('CODPRJ').AsString := strCodPrj
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaClientes]');
  End;

end;

class procedure TProjeto.pCarregaContasPagar(strCodPrj: String; qryCadPag: TUniQuery);
begin
  Try
    With qryCadPag, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT  ');
      Add('  CONCAT(CTP_CODFOR," - ",FOR_NOMFOR) AS CODFOR, ');
      Add('  CONCAT(CTP_CODCTA," - ",CTA_DESCTA) AS CODCTA, ');
      Add('  CTP_DTACAD,  ');
      Add('  CTP_DTAPAG,  ');
      Add('  CTP_VALORI,  ');
      Add('  CTP_VALPAG,  ');
      Add('  (SELECT SUM(CTP_VALPAG) FROM CADPAG WHERE CTP_CODPRJ = :CODPRJ) AS VALOR_TOTAL_PAGO,  ');
      Add('  (SELECT SUM(CTP_VALORI) FROM CADPAG WHERE CTP_CODPRJ = :CODPRJ) AS VALOR_TOTAL_ORIGINAL  ');
      Add('FROM          ');
      Add('  CADPAG      ');
      Add('INNER JOIN CADFOR  ');
      Add('  ON FOR_CODFOR = CTP_CODFOR  ');
      Add('INNER JOIN CADCTA  ');
      Add('  ON CTA_CODCTA = CTP_CODCTA  ');
      Add('INNER JOIN CADPRJ  ');
      Add('  ON PRJ_CODPRJ = CTP_CODPRJ  ');
      Add('WHERE          ');
      Add('  CTP_CODPRJ = :CODPRJ  ');

      ParamByName('CODPRJ').AsString := strCodPrj;

      Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaContasPagar]');
  End;

end;

class procedure TProjeto.pCarregaCreditos(strCodPrj: String;
  qryCadRec: TUniQuery);
begin
  Try
    With qryCadRec, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT  ');
      Add('  CONCAT(CTR_CODCLI," - ",CLI_NOMCLI) AS CODCLI, ');
      Add('  CONCAT(CTR_CODCTA," - ",CTA_DESCTA) AS CODCTA, ');
      Add('  CTR_DTACAD,  ');
      Add('  CTR_DTAREC,  ');
      Add('  IF(CTR_VALDUP = 0,(CTR_VALREC - CTR_VALJUR + CTR_VALDES),CTR_VALDUP) AS CTR_VALORI,  ');
      Add('  CTR_VALREC,  ');
      Add('  (SELECT SUM(CTR_VALREC) FROM CADREC WHERE CTR_CODPRJ = :CODPRJ) AS VALOR_TOTAL_CREDITO_RECEBIDO,  ');
      Add('  (SELECT SUM(IF(CTR_VALDUP = 0,(CTR_VALREC - CTR_VALJUR + CTR_VALDES),CTR_VALDUP)) FROM CADREC WHERE CTR_CODPRJ = :CODPRJ) AS VALOR_TOTAL_CREDITO_ORIGINAL  ');
      Add('FROM          ');
      Add('  CADREC      ');
      Add('LEFT JOIN CADCLI  ');
      Add('  ON CLI_CODCLI = CTR_CODCLI  ');
      Add('LEFT JOIN CADCTA  ');
      Add('  ON CTA_CODCTA = CTR_CODCTA  ');
      Add('LEFT JOIN CADPRJ  ');
      Add('  ON PRJ_CODPRJ = CTR_CODPRJ  ');
      Add('WHERE          ');
      Add('  CTR_CODPRJ = :CODPRJ  ');

      ParamByName('CODPRJ').AsString := strCodPrj;

      Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaCreditos]');
  End;

end;

class procedure TProjeto.pCarregaRecursos(strCodPrj: String; qryProRec: TUniQuery);
begin
  Try
    With qryProRec, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  CASE C.REP_TIPREP ');
      Add('    WHEN "C" THEN "Colaborador" ');
      Add('    WHEN "F" THEN "Ferramenta" ');
      Add('    WHEN "V" THEN "Veículo" ');
      Add('  END AS TIPREP, ');
      Add('  C.REP_NOMREP AS NOMREP, ');
      Add('  CASE C.REP_TIPCAP ');
      Add('    WHEN "H" THEN "Hora" ');
      Add('    WHEN "D" THEN "Diária" ');
      Add('    WHEN "K" THEN "Km" ');
      Add('  END AS TIPCAP, ');
      Add('  D.DET_QUANTI AS QUANTI, ');
      Add('  D.DET_QTDHOR AS QTDHOR, ');
      Add('  C.REP_VALCUS AS VALCUS, ');
      Add('  (IF(D.DET_QTDHOR IS NOT NULL,(((LEFT(D.DET_QTDHOR,2) * 60) + RIGHT(D.DET_QTDHOR,2))/60) ,D.DET_QUANTI) * C.REP_VALCUS) AS VALTOT, ');
      Add('  G.GER_DTACAD AS DTACAD, ');
      Add('  G.GER_CODOPE AS CODOPE ');
      Add('FROM PROGER G ');
      Add('  INNER JOIN PRODET D ON D.DET_SEQGER = G.AUTOINCREM ');
      Add('  INNER JOIN CADREP C ON C.REP_CODREP = D.DET_CODREP ');
      Add('WHERE G.GER_CODPRJ = :CODPRJ ');
      Add('ORDER BY DTACAD ');

      ParamByName('CODPRJ').AsString := strCodPrj;

      Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaRecursos]');
  End;
end;

class procedure TProjeto.pCarregaServicos(strCodPrj: String;
  qryProVen: TUniQuery);
begin
  Try
    qryProVen.Close;
    qryProVen.SQL.Clear;

    qryProVen.SQL.Add( fGetSqlServVen );
    qryProVen.SQL.Add('ORDER BY DTAENT, NUMDOC, SEQ');

    qryProVen.ParamByName('CODPRJ').AsString := strCodPrj;

    qryProVen.Open;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaServicos]');
  End;
end;

class procedure TProjeto.pCarregaVendas(strCodPrj: String; qryProVen: TUniQuery);
begin
  Try
    With qryProVen, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  G.GER_NUMDOC AS NUMDOC, ');
      Add('	 G.GER_ESPDOC AS ESPDOC, ');
      Add('	 G.GER_CODEMP AS CODEMP, ');
      Add('	 G.GER_DTAENT AS DTAENT, ');
      Add('  G.GER_CODVEN AS CODVEN, ');
      Add('  CONCAT(D.DET_CODITE, "-", I.ITE_DESITE) AS CODITE, ');
      Add('  (IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_QTDITE, D.DET_QTDITE)) AS QTDITE, ');
      Add('  IFNULL((IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS, ' + QuotedStr(CLAFIS_BR) + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF)))/(IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_QTDITE, D.DET_QTDITE)),0.00) AS UNITAR, ');
      Add('  (IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS, ' + QuotedStr(CLAFIS_BR) + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) AS TOTITE ');
      Add('FROM AUXMOV A ');
      Add('  INNER JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER ');
      Add('  INNER JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND ');
      Add('                         D.DET_ESPDOC = G.GER_ESPDOC AND ');
      Add('                         D.DET_CODCLI = G.GER_CODCLI AND ');
      Add('                         D.DET_CODEMP = G.GER_CODEMP ');
      Add('  INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ');
      Add('WHERE A.AUX_CODPRJ = :CODPRJ ');
      Add('AND D.DET_CODITE NOT IN ("'+ fCfgSis('ITESER') +'","'+ fCfgSis('SERTER') +'") ');
      Add('AND D.DET_ESPDOC NOT IN ("NS") ');
      Add('ORDER BY DTAENT, NUMDOC ');

      ParamByName('CODPRJ').AsString := strCodPrj;

        Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pCarregaVendas]');
  End;
end;

class procedure TProjeto.pRecalculaConsumo(strCodPrj: String);
var
  qryConsumo: TUniQuery;
begin
  qryConsumo := fCriaQuery();

  Try
    With qryConsumo, SQL Do
    Begin
      Clear;
      Add('UPDATE CADPRJ SET PRJ_INDCON = (IF((IFNULL(PRJ_TOTREC,0)+IFNULL(PRJ_TOTVEN,0)+IFNULL(PRJ_TOTSER,0)>0 And IFNULL(PRJ_VALPRJ,0)>0), ');
      Add('				 ((IFNULL(PRJ_TOTREC,0)+IFNULL(PRJ_TOTVEN,0)+IFNULL(PRJ_TOTSER,0))/IFNULL(PRJ_VALPRJ,0))*100, 0)) ');
      Add('WHERE PRJ_CODPRJ = :CODPRJ; ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      ExecSQL;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pRecalculaConsumo]');
  End;

  FreeAndNil(qryConsumo);
end;

class procedure TProjeto.pRecalculaRecursos(strCodPrj: String);
var
  qryRecursos: TUniQuery;
  field: string;
  fieldCredito: String;
begin
  qryRecursos := fCriaQuery();
  field:='CTP_VALPAG';
  fieldCredito := 'CTR_VALREC';

  If fCfgSis('PRJCTP', varInteger) = 2 Then
   field := 'CTP_VALORI';

  If fCfgSis('PRJCRE', varInteger) = 2 Then
   fieldCredito := ' IF(CTR_VALDUP = 0,(CTR_VALREC - CTR_VALJUR + CTR_VALDES),CTR_VALDUP) ';

  Try
    With qryRecursos, SQL Do
    Begin
      Clear;
      Add('UPDATE CADPRJ SET PRJ_TOTREC = (SELECT IFNULL(SUM('+field+'),0) FROM CADPAG WHERE CTP_CODPRJ = :CODPRJ) + ');
      Add('(SELECT IFNULL(SUM('+fieldCredito+'),0) FROM CADREC WHERE CTR_CODPRJ = :CODPRJ) + ');
      Add('(SELECT IFNULL(SUM(VALTOT),0) AS VALTOT FROM ');
      Add('(SELECT ');
      Add('  (IF(D.DET_QTDHOR IS NOT NULL,(((LEFT(D.DET_QTDHOR,2) * 60) + RIGHT(D.DET_QTDHOR,2))/60) ,D.DET_QUANTI) * C.REP_VALCUS) AS VALTOT ');
      Add('FROM PROGER G ');
      Add('  INNER JOIN PRODET D ON D.DET_SEQGER = G.AUTOINCREM ');
      Add('  INNER JOIN CADREP C ON C.REP_CODREP = D.DET_CODREP ');
      Add('WHERE G.GER_CODPRJ = :CODPRJ) AS TAB) ');
      Add('WHERE PRJ_CODPRJ = :CODPRJ ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      ExecSQL;

      pRecalculaConsumo(strCodPrj);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pRecalculaRecursos]');
  End;

  FreeAndNil(qryRecursos);
end;

class procedure TProjeto.pRecalculaVendas(strNumDoc, strEspDoc,
  strCodEmp: String);
var
  strCodPrj: String;
begin
  strCodPrj := fProjetoDaVenda(strNumDoc, strEspDoc, strCodEmp);

  If Not fEmptyStr(strCodPrj) Then
    pRecalculaProjeto(strCodPrj);
end;


class procedure TProjeto.pRecalculaProjeto(strCodPrj: String);
var
  qryVendas: TUniQuery;
begin
  qryVendas := fCriaQuery();

  Try
    With qryVendas, SQL Do
    Begin
      Clear;
      Add('UPDATE CADPRJ SET PRJ_TOTVEN = '+ fGetSqlTotVendas('P'));
      Add('                 ,PRJ_TOTSER = '+ fGetSqlTotVendas('S'));
      Add('WHERE PRJ_CODPRJ = :CODPRJ ');
      ParamByName('CODPRJ').AsString := strCodPrj;
      ExecSQL;

      pRecalculaConsumo(strCodPrj);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TProjeto.pRecalculaProjeto]');
  End;

  FreeAndNil(qryVendas);
end;

end.
