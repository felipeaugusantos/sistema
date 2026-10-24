unit untSQLFaturamento;

interface

uses Uni;

procedure pSQLFaturamento(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String);
procedure pSQLCadastro(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const);

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Classes, SysUtils, StrUtils;

procedure pSQLFaturamento(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String);
  Var
    strCampo,
    strTabela,
    strSQLJoin,
    strJoinMovGer: String;
begin

  If strNomeSQL = 'HISTORICO_VEICULO' Then
  Begin
    // [0] = PLACA DO VEICULO
    qry.SQL.Add('SELECT FGO_DTAENT AS DTAENT,');
    qry.SQL.Add('       CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMDOC,');
    qry.SQL.Add('       IF(IFNULL(FGO_NUMFAT, "") = "", "", CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT)) AS DOCFAT,');
    qry.SQL.Add('       CLI_NOMCLI AS NOMCLI,');
    qry.SQL.Add('       FGO_CONPAG AS CONPAG,');
    qry.SQL.Add('       FGO_CODVEN AS CODVEN,');
    qry.SQL.Add('       FGO_VLRCON AS VLRCON,');

    qry.SQL.Add('       FGO_NUMDOC,');
    qry.SQL.Add('       FGO_ESPDOC');

    qry.SQL.Add('  FROM FATGOR');
    qry.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI');
    qry.SQL.Add('  JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM');
    qry.SQL.Add(' WHERE FGO_ESPDOC = "PD"');
    qry.SQL.Add('   AND FGO_PLAVEI = :PLAVEI');

    qry.ParamByName('PLAVEI').AsString := String(arrParams[0].VAnsiString);
  End

  Else If strNomeSQL = 'CONSULTA_DOCS_AVISO_EMBARQUE' Then
  Begin
    // [0] = CÓDIGO DA EMPRESA
    // [1] = NÚMERO DOCUMENTO
    // [2] = ESPÉCIE DO DOCUMENTO
    // [3] = DATA INICIAL
    // [4] = DATA FINAL
    // [5] = CÓDIGO DO CLIENTE
    // [6] = GERADA/NÃO GERADA  (S/N)
    // [7] = CFOP - TODOS / SOMENTE VENDA (T/V)

    qry.SQL.Add('SELECT GER_DTAENT DTAENT,');
    qry.SQL.Add('       GER_NUMDOC NUMDOC,');
    qry.SQL.Add('       GER_ESPDOC ESPDOC,');
    qry.SQL.Add('       CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) NOMCLI,');
    qry.SQL.Add('       GER_VLRCON VLRCON,');
    qry.SQL.Add('       IFNULL(C.AUX_GERAVE, "N") GERAVE,');
    qry.SQL.Add('       GER_CODEMP CODEMP,');
    qry.SQL.Add('       GER_CODCLI CODCLI,');
    qry.SQL.Add('       "MOVGER" TABGER,');
    qry.SQL.Add('       MOVGER.AUTOINCREM AS AUTINC');
    qry.SQL.Add('  FROM MOVGER ');
    qry.SQL.Add('       JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ');
    qry.SQL.Add('       JOIN AUXMOV C ON MOVGER.AUTOINCREM = C.AUX_SEQGER ');
    qry.SQL.Add(' WHERE GER_TIP_FC = "C" ');
    qry.SQL.Add('   AND IFNULL(C.AUX_GERAVE, "N") = :GERAVE ');
    qry.SQL.Add('   AND GER_ESPDOC IN ("NF", "EL", "IF", "IV")');

    If Not fEmptyStr(String(arrParams[1].VAnsiString)) Then
      qry.SQL.Add('   AND GER_NUMDOC = :NUMDOC');

    If Not fEmptyStr(String(arrParams[2].VAnsiString)) Then
      qry.SQL.Add('   AND GER_ESPDOC = :ESPDOC');

    qry.SQL.Add('   AND LOCATE(GER_CODEMP, :CODEMP) > 0 ');

    If arrParams[3].VExtended^ > 0 Then
      qry.SQL.Add('   AND GER_DTAENT >= :DTAINI');

    If arrParams[4].VExtended^ > 0 Then
      qry.SQL.Add('   AND GER_DTAENT <= :DTAFIN');

    If Not fEmptyStr(String(arrParams[5].VAnsiString)) Then
      qry.SQL.Add('   AND GER_CODCLI = :CODCLI');

    If arrParams[7].VPChar = 'V' Then
      qry.SQL.Add('   AND LOCATE(GER_CLAFIS, '+ QuotedStr(VS_strClaVen) +') > 0 ');

    qry.SQL.Add(' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(qry.SQL.Text, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT'));

    qry.SQL.Add(' ORDER BY DTAENT DESC, ');
    qry.SQL.Add('       ESPDOC DESC, ');
    qry.SQL.Add('       NUMDOC DESC  ');

    qry.ParamByName('CODEMP').AsString := String(arrParams[0].VAnsiString);

    If Not fEmptyStr(String(arrParams[1].VAnsiString)) Then
      qry.ParamByName('NUMDOC').AsString := String(arrParams[1].VAnsiString);

    If Not fEmptyStr(String(arrParams[2].VAnsiString)) Then
      qry.ParamByName('ESPDOC').AsString := String(arrParams[2].VAnsiString);

    If arrParams[3].VExtended^ > 0 Then
      qry.ParamByName('DTAINI').AsDateTime := arrParams[3].VExtended^;

    If arrParams[4].VExtended^ > 0 Then
      qry.ParamByName('DTAFIN').AsDateTime := arrParams[4].VExtended^;

    If Not fEmptyStr(String(arrParams[5].VAnsiString)) Then
      qry.ParamByName('CODCLI').AsString := String(arrParams[5].VAnsiString);

    qry.ParamByName('GERAVE').AsString := String(arrParams[6].VAnsiString);

  End

  Else If strNomeSQL = 'DOCUMENTO_AVISO_EMBARQUE' Then
  Begin
    // [0] = TABELA GER (MOVGER, NOTGER)
    // [1] = TABELA AUX (AUXMOV, AUXNOT)
    // [2] = CÓDIGO DA EMPRESA
    // [3] = NÚMERO DO DOCUMETNO
    // [4] = ESPÉCIE DO DOCUMENTO
    // [5] = CÓDIGO DO CLIENTE
    // [6] = TABELA DET (MOVDET, NOTDET)

    qry.SQL.Add('SELECT G.AUTOINCREM AUTINC,');
    qry.SQL.Add('       EMP_C_G_C_ EMPCGC,');
    qry.SQL.Add('       CLI_C_G_C_ CLICGC,');
    qry.SQL.Add('       CLI_CODCLI CODCLI,');
    qry.SQL.Add('       CLI_NOMCLI NOMCLI,');
    qry.SQL.Add('       GER_NUMDOC NUMDOC,');
    qry.SQL.Add('       GER_SERIE_ SERIE,');
    qry.SQL.Add('       GER_DTAENT DTAENT,');
    qry.SQL.Add('       (SELECT SUM(DET_QTDITE) FROM '+ String(arrParams[6].VAnsiString) +' WHERE DET_SEQGER = G.AUTOINCREM) QTDITE,');
    qry.SQL.Add('       GER_VLRCON VLRCON,');
    qry.SQL.Add('       GER_CLAFIS CLAFIS,');
    qry.SQL.Add('       GER_TOTICM TOTICM,');
    qry.SQL.Add('       GER_TOTIPI TOTIPI,');
    qry.SQL.Add('       IF( GER_NATOPE IS NOT NULL, GER_NATOPE, ');
    qry.SQL.Add('          (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFIS LIMIT 1) ) NATOPE, ');
    qry.SQL.Add('       CLI_FABDES FABDES,');
    qry.SQL.Add('       GER_DESACE DESACE,');
    qry.SQL.Add('       GER_TOTFRE TOTFRE,');
    qry.SQL.Add('       GER_SEGURO SEGURO,');
    qry.SQL.Add('       GER_DESESP DESESP,');
    qry.SQL.Add('       GER_BASICM BASICM,');
    qry.SQL.Add('       GER_MEN001 MEN001,');
    qry.SQL.Add('       GER_MEN002 MEN002,');
    qry.SQL.Add('       CAST((SELECT MIN(CTR_DTAVEN)');
    qry.SQL.Add('               FROM CADREC');
    qry.SQL.Add('              WHERE CTR_NUMDUP = GER_NUMDOC');
    qry.SQL.Add('                AND CTR_ESPDOC = GER_ESPDOC');
    qry.SQL.Add('                AND CTR_CODCLI = GER_CODCLI');
    qry.SQL.Add('                AND CTR_CODEMP = GER_CODEMP) AS DATE) DTAVEN');
    qry.SQL.Add('  FROM '+ String(arrParams[0].VAnsiString) + ' G');
    qry.SQL.Add('  JOIN '+ String(arrParams[1].VAnsiString) + ' A ON A.AUX_SEQGER = G.AUTOINCREM');
    qry.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = GER_CODEMP');
    qry.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI');
    qry.SQL.Add('  JOIN CADCFO ON CFO_CODCFO = GER_CLAFIS');
    qry.SQL.Add(' WHERE GER_CODEMP = :CODEMP');
    qry.SQL.Add('   AND GER_NUMDOC = :NUMDOC');
    qry.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    If Not fEmptyStr(String(arrParams[5].VAnsiString)) Then
      qry.SQL.Add('   AND GER_CODCLI = :CODCLI');

    qry.ParamByName('CODEMP').AsString := String(arrParams[2].VAnsiString);
    qry.ParamByName('NUMDOC').AsString := String(arrParams[3].VAnsiString);
    qry.ParamByName('ESPDOC').AsString := String(arrParams[4].VAnsiString);
    If Not fEmptyStr(String(arrParams[5].VAnsiString)) Then
      qry.ParamByName('CODCLI').AsString := String(arrParams[5].VAnsiString);
  End

  Else If strNomeSQL = 'ITEM_DOCUMENTO_AVISO_EMBARQUE' Then
  Begin
    // [0] TABELA DET (MOVDET, NOTDET)
    // [1] AUTOINCREM DA MOVGER OU NOTGER
    // [2] CÓDIGO DO CLIENTE
    // [3] TABELA TRI (MOVTRI, NOTTRI)

    qry.SQL.Add('SELECT IF(IFNULL(CLI_COD_NF, "") = "", ITE_CODITE, CLI_COD_NF) CODITE,'); // Obtém o código de impressão NF (Cliente/Produto)
    qry.SQL.Add('       DET_QTDITE QTDITE,');
    qry.SQL.Add('       UNI_SIGUNI SIGUNI,');
    qry.SQL.Add('       DET_ALQIPI ALQIPI,');
    qry.SQL.Add('       ROUND(DET_DESESP/DET_TOTITE*100, 2) PERDES,');
    qry.SQL.Add('       DET_ALQICM ALQICM,');
    qry.SQL.Add('       DET_BASICM BASICM,');
    qry.SQL.Add('       DET_VALICM VALICM,');
    qry.SQL.Add('       DET_VALIPI VALIPI,');
    qry.SQL.Add('       ITE_PESLIQ PESLIQ,');
    qry.SQL.Add('       DET_UNITAR UNITAR,');
    qry.SQL.Add('       DET_TOTITE TOTITE,');
    qry.SQL.Add('       DET_NUMCMP NUMCMP,');
    qry.SQL.Add('       DET_NITCMP NITCMP,');
    qry.SQL.Add('       ITE_CLAIPI CLAIPI,');
    qry.SQL.Add('       DET_CODFIS CODFIS,');
    qry.SQL.Add('       DET_NUMPLA NUMPLA,');
    qry.SQL.Add('       DET_PARNUM PARNUM');
    qry.SQL.Add('  FROM '+ String(arrParams[0].VAnsiString) + ' D');
    qry.SQL.Add('  JOIN '+ String(arrParams[3].VAnsiString) +' T ON T.DET_SEQGER = D.AUTOINCREM');
    qry.SQL.Add('  JOIN CADITE ON ITE_CODITE = DET_CODITE');
    qry.SQL.Add('  LEFT JOIN CLIPRO ON CLI_CODITE = ITE_CODITE');
    qry.SQL.Add('                  AND CLI_CODCLI = :CODCLI');
    qry.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = COALESCE(CLI_CODUNI, ITE_CODUNI)');
    qry.SQL.Add(' WHERE D.DET_SEQGER = :SEQGER');

    qry.ParamByName('SEQGER').AsString := String(arrParams[1].VAnsiString);
    qry.ParamByName('CODCLI').AsString := String(arrParams[2].VAnsiString);
  End

  Else If strNomeSQL = 'VERIFICA_PED_FATURADO' Then
  Begin
    // [0] NUM DOCUMENTO
    // [1] ESP DOCUMENTO
    // [2] COD CLIENTE
    // [3] COD EMPRESA
    qry.SQL.Add('SELECT FGO_JAFATU AS JAFATU');
    qry.SQL.Add('  FROM FATGOR');
    qry.SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC');
    qry.SQL.Add('   AND FGO_ESPDOC = :ESPDOC');
    qry.SQL.Add('   AND FGO_CODCLI = :CODCLI');
    qry.SQL.Add('   AND FGO_CODEMP = :CODEMP');

    qry.ParamByName('NUMDOC').AsString := String(arrParams[0].VAnsiString);
    qry.ParamByName('ESPDOC').AsString := String(arrParams[1].VAnsiString);
    qry.ParamByName('CODCLI').AsString := String(arrParams[2].VAnsiString);
    qry.ParamByName('CODEMP').AsString := String(arrParams[3].VAnsiString);
  End

  Else If strNomeSQL = 'ITENS_SEM_CLIPRO' Then
  Begin
    // [0] AUTOINCREM DA MOVGER/X
    // [1] TABELA DET
    qry.SQL.Add('SELECT DISTINCT ITE_CODITE CODITE,');
    qry.SQL.Add('       ITE_DESITE DESITE');
    qry.SQL.Add('  FROM '+ String(arrParams[1].VAnsiString));
    qry.SQL.Add('  JOIN CADITE ON ITE_CODITE = DET_CODITE');
    qry.SQL.Add('  LEFT JOIN CLIPRO ON CLI_CODITE = DET_CODITE');
    qry.SQL.Add('                  AND CLI_CODCLI = DET_CODCLI');
    qry.SQL.Add(' WHERE DET_SEQGER = :AUTINC');
    qry.SQL.Add('   AND IFNULL(CLI_CODITE, "") = ""');

    qry.ParamByName('AUTINC').AsString := String(arrParams[0].VAnsiString);
  End
  
  Else If strNomeSQL = 'VALIDA_CLIENTE_POSSUI_FABDES' Then
  Begin
    // [0] COD CLIENTE
    qry.SQL.Add('SELECT COUNT(1) AS QTDREGISTRO');
    qry.SQL.Add('  FROM CADCLI');
    qry.SQL.Add(' WHERE CLI_CODCLI = :CODCLI');
    qry.SQL.Add('   AND IFNULL(CLI_FABDES, "") = ""');

    qry.ParamByName('CODCLI').AsString := String(arrParams[0].VAnsiString);
  End

  Else If strNomeSQL = 'GET_DADOS_VEICULO' Then
  Begin
    If Pos('MOVGER', strNomeTabela) > 0 Then
      strCampo := 'AUX_'
    Else
      strCampo := 'FGO_';

    // [0] SEQFGO
    qry.SQL.Add('SELECT');

    If Pos('MOVGER', strNomeTabela) > 0 Then
    Begin
      qry.SQL.Add('  COALESCE(PED.FGO_PLAVEI, ' + strCampo + 'PLAVEI) AS PLAVEI,');
      qry.SQL.Add('  COALESCE(PED.FGO_KM_VEI, ' + strCampo + 'KM_VEI) AS KM_VEI,');
    End
    Else
    Begin
      qry.SQL.Add('  ' + strCampo + 'PLAVEI AS PLAVEI,');
      qry.SQL.Add('  ' + strCampo + 'KM_VEI AS KM_VEI,');
    End;

    qry.SQL.Add('  MAR_DESMAR AS DESMAR,');
    qry.SQL.Add('  MOD_DESMOD AS DESMOD ');
    qry.SQL.Add('FROM');

    If Pos('MOVGER', strNomeTabela) > 0 Then
    Begin
      If Pos('DEL_', strNomeTabela) > 0 Then
        strTabela := '  DEL_AUXMOV '
      Else
        strTabela := '  AUXMOV ';
    End
    Else
    Begin
      If Pos('DEL_', strNomeTabela) > 0 Then
        strTabela := '  DEL_EXTGOR '
      Else
        strTabela := '  EXTGOR ';
    End;

    qry.SQL.Add(strTabela);

    If Pos('MOVGER', strNomeTabela) > 0 Then
    Begin
      strSQLJoin := '';

      If Pos('DEL_', strNomeTabela) > 0 Then
      Begin
        strJoinMovGer := 'DEL_MOVGER';

        strSQLJoin := strSQLJoin + ' JOIN ' + strJoinMovGer + ' ON (' + strJoinMovGer + '.AUTOINCREM = ' + strTabela + '.AUX_SEQGER) ';
        strSQLJoin := strSQLJoin + ' LEFT JOIN DEL_FATGOR ON (DEL_FATGOR.FGO_NUMFAT = ' + strJoinMovGer + '.GER_NUMDOC AND ';
        strSQLJoin := strSQLJoin + '                          DEL_FATGOR.FGO_EMPFAT = ' + strJoinMovGer + '.GER_CODEMP AND ';
        strSQLJoin := strSQLJoin + '                          DEL_FATGOR.FGO_TIPFAT = ' + strJoinMovGer + '.GER_ESPDOC) ';
        strSQLJoin := strSQLJoin + ' LEFT JOIN DEL_EXTGOR PED ON (PED.FGO_SEQFGO = DEL_FATGOR.AUTOINCREM) ';
      End
      Else
      Begin
        strJoinMovGer := 'MOVGER';

        strSQLJoin := strSQLJoin + ' JOIN ' + strJoinMovGer + ' ON (' + strJoinMovGer + '.AUTOINCREM = ' + strTabela + '.AUX_SEQGER) ';
        strSQLJoin := strSQLJoin + ' LEFT JOIN FATGOR ON (FATGOR.FGO_NUMFAT = ' + strJoinMovGer + '.GER_NUMDOC AND ';
        strSQLJoin := strSQLJoin + '                      FATGOR.FGO_EMPFAT = ' + strJoinMovGer + '.GER_CODEMP AND ';
        strSQLJoin := strSQLJoin + '                      FATGOR.FGO_TIPFAT = ' + strJoinMovGer + '.GER_ESPDOC) ';
        strSQLJoin := strSQLJoin + ' LEFT JOIN EXTGOR PED ON (PED.FGO_SEQFGO = FATGOR.AUTOINCREM) ';
      End;

      qry.SQL.Add(strSQLJoin);
    End;

    If Pos('MOVGER', strNomeTabela) > 0 Then
      qry.SQL.Add('JOIN CADVEI ON (CADVEI.VEI_PLAVEI = COALESCE(PED.FGO_PLAVEI, ' + strTabela + '.' + strCampo + 'PLAVEI)) ')
    Else
      qry.SQL.Add('JOIN CADVEI ON (CADVEI.VEI_PLAVEI = ' + strTabela + '.' + strCampo + 'PLAVEI)');

    qry.SQL.Add('JOIN MARVEI ON (MARVEI.MAR_CODMAR = CADVEI.VEI_CODMAR)');
    qry.SQL.Add('JOIN MODVEI ON (MODVEI.MOD_CODMOD = CADVEI.VEI_CODMOD)');
    qry.SQL.Add('WHERE ' + IIF(Pos('MOVGER', strNomeTabela) > 0, 'AUX_SEQGER', 'FGO_SEQFGO') + ' = :SEQFGO');
    qry.SQL.Add('LIMIT 1');
    qry.ParamByName('SEQFGO').AsString := String(arrParams[0].VAnsiString);
  End

  Else If strNomeSQL = 'DOCUMENTO_B2B' Then
  Begin
    // [0] = NÚMERO DO DOCUMENTO
    // [1] = ESPÉCIE DO DOCUMENTO
    // [2] = CÓDIGO DA EMPRESA
    // [3] = CLIENTE DO DOCUMENTO
    qry.SQL.Add('SELECT X.NFE_ARQXML, X.NFE_ACESSO, L.NFE_HORINI, L.NFE_SERIE_');
    qry.SQL.Add('FROM LOGNFE L');
    qry.SQL.Add('INNER JOIN XMLNFE X');
    qry.SQL.Add('ON(L.NFE_ACESSO = X.NFE_ACESSO)');
    qry.SQL.Add('WHERE L.NFE_NUMDOC = :NUMDOC');
    qry.SQL.Add('AND L.NFE_ESPDOC = :ESPDOC');
    qry.SQL.Add('AND L.NFE_CODEMP = :CODEMP');
    qry.SQL.Add('AND L.NFE_CODCLI = :CODCLI');
    qry.SQL.Add('AND X.NFE_ACESSO IS NOT NULL');
    qry.SQL.Add('AND X.NFE_ARQXML IS NOT NULL');

    qry.ParamByName('NUMDOC').AsString := String(arrParams[0].VAnsiString);
    qry.ParamByName('ESPDOC').AsString := String(arrParams[1].VAnsiString);
    qry.ParamByName('CODEMP').AsString := String(arrParams[2].VAnsiString);
    qry.ParamByName('CODCLI').AsString := String(arrParams[3].VAnsiString);
  End

  Else If strNomeSQL = 'ITEM_DOCUMENTO_B2B' Then
  Begin
    // [0] = NÚMERO DO DOCUMENTO
    // [1] = ESPÉCIE DO DOCUMENTO
    // [2] = CÓDIGO DA EMPRESA
    // [3] = CLIENTE DO DOCUMENTO
    // [4] = TABELA DET (MOVDET, NOTDET)
    // [5] = TABELA TRI (MOVTRI, NOTTRI)
    qry.SQL.Add('SELECT D.DET_CODITE, D.DET_UNIDAD, D.DET_NUM_PD, T.DET_NUMCMP, T.DET_NITCMP, T.DET_NUMPLA, T.DET_PARNUM, T.DET_REQCOM');
    qry.SQL.Add('FROM '+ String(arrParams[4].VAnsiString) + ' D');
    qry.SQL.Add('INNER JOIN '+ String(arrParams[5].VAnsiString) + ' T');
    qry.SQL.Add('ON(D.AUTOINCREM = T.DET_SEQGER)');
    qry.SQL.Add('WHERE D.DET_NUMDOC = :NUMDOC');
    qry.SQL.Add('AND D.DET_ESPDOC = :ESPDOC');
    qry.SQL.Add('AND D.DET_CODEMP = :CODEMP');
    qry.SQL.Add('AND D.DET_CODCLI = :CODCLI');

    qry.ParamByName('NUMDOC').AsString := String(arrParams[0].VAnsiString);
    qry.ParamByName('ESPDOC').AsString := String(arrParams[1].VAnsiString);
    qry.ParamByName('CODEMP').AsString := String(arrParams[2].VAnsiString);
    qry.ParamByName('CODCLI').AsString := String(arrParams[3].VAnsiString);
  End

  Else pSQLCadastro(qry, strNomeSQL, arrParams);
end;

procedure pSQLCadastro(qry: TUniQuery; strNomeSQL: String; arrParams: Array Of Const);
begin

  If strNomeSQL = 'METATI_DELETA' Then
  Begin
    // [0] Cod Vendedor
    // [1] Período
    // [2] Cod Empresa

    qry.SQL.Add('DELETE FROM METATI');
    qry.SQL.Add(' WHERE MAT_CODVEN = :CODVEN');
    qry.SQL.Add('   AND MAT_MESANO = :MESANO');
    qry.SQL.Add('   AND MAT_CODEMP = :CODEMP');

    qry.ParamByName('CODVEN').AsString   := String(arrParams[0].VAnsiString);
    qry.ParamByName('MESANO').AsDateTime := arrParams[1].VExtended^;
    qry.ParamByName('CODEMP').AsString   := String(arrParams[2].VAnsiString);
    qry.ExecSQL;
  End

  Else If strNomeSQL = 'METATI_INSERE' Then
  Begin
    // [0] AUTOINCREM
    // [1] COD VENDEDOR
    // [2] MESANO
    // [3] COD EMPRESA
    // [4] COD ATIVIDADE
    // [5] PRAZO MEDIO
    // [6] FATURAMENTO
    // [7] MARGEM
    qry.SQL.Add('INSERT INTO METATI(');
    qry.SQL.Add('  AUTOINCREM,');
    qry.SQL.Add('  MAT_CODVEN,');
    qry.SQL.Add('  MAT_MESANO,');
    qry.SQL.Add('  MAT_CODEMP,');
    qry.SQL.Add('  MAT_CODATI,');
    qry.SQL.Add('  MAT_PRAMED,');
    qry.SQL.Add('  MAT_FATURA,');
    qry.SQL.Add('  MAT_MARGEM');
    qry.SQL.Add(') VALUES (');
    qry.SQL.Add('  :AUTINC,');
    qry.SQL.Add('  :CODVEN,');
    qry.SQL.Add('  :MESANO,');
    qry.SQL.Add('  :CODEMP,');
    qry.SQL.Add('  :CODATI,');
    qry.SQL.Add('  :PRAMED,');
    qry.SQL.Add('  :FATURA,');
    qry.SQL.Add('  :MARGEM');
    qry.SQL.Add(')');

    qry.ParamByName('AUTINC').AsString   := String(arrParams[0].VAnsiString);
    qry.ParamByName('CODVEN').AsString   := String(arrParams[1].VAnsiString);
    qry.ParamByName('MESANO').AsDateTime := arrParams[2].VExtended^;
    qry.ParamByName('CODEMP').AsString   := String(arrParams[3].VAnsiString);
    qry.ParamByName('CODATI').AsString   := String(arrParams[4].VAnsiString);
    qry.ParamByName('PRAMED').AsFloat    := arrParams[5].VExtended^;
    qry.ParamByName('FATURA').AsFloat    := arrParams[6].VExtended^;
    qry.ParamByName('MARGEM').AsFloat    := arrParams[7].VExtended^;

    qry.ExecSQL;
  End

  Else If strNomeSQL = 'METATI_SELECT' Then
  Begin
    // [0] COD VENDEDOR
    // [1] PERIODO
    // [2] COD EMPRESA

    qry.SQL.Add('SELECT *');
    qry.SQL.Add('  FROM METATI');
    qry.SQL.Add(' WHERE MAT_CODVEN = :CODVEN');
    qry.SQL.Add('   AND MAT_MESANO = :MESANO');
    qry.SQL.Add('   AND MAT_CODEMP = :CODEMP');

    qry.ParamByName('CODVEN').AsString   := String(arrParams[0].VAnsiString);
    qry.ParamByName('MESANO').AsDateTime := arrParams[1].VExtended^;
    qry.ParamByName('CODEMP').AsString   := String(arrParams[2].VAnsiString);
  End;

end;

end.
