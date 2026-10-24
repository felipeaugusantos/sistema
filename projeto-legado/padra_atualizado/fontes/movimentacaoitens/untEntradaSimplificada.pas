unit untEntradaSimplificada;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
  untZClient, StrUtils, Math, Variants, cxProgressBar,
  untGravando, untTypesSistema, UniDataSetProvider;

Type
  TRecAutEntTe = record
    blnAutEnt: Boolean;
    blnPedidoCompra: Boolean;
    strDocOri,
    strEspOri,
    strEmpOri,
    strSerOri,
    strCodForTe: String;
  end;

  TEntradaSimplificada = Class(TComponent)
  Private
     LimiteDias: integer;
    function fGetSqlTE(blnFluxo: Boolean = False): String;
    function fGetSqlNF(blnFluxo: Boolean = False): String;
    function fGetSqlPedidoCompra: String;
    function fGetSqlAjuste(blnFluxo: Boolean = False): String;
    function fGetSqlConfirmacao(blnFluxo: Boolean = False): String;
    function fGetSQLField_TEM_LOTPRE_TEM_ENDERE(blnTE: Boolean = False): String;
    function fGetInnerJoinPCMGER(blnFluxo: Boolean = False; blnVerificaConferencia: Boolean = True): String;
    Function fGetSQLField_TEM_EFEITVACAO(strTabela: String): String;
    function fUsaEfetvacaoFiscal: Boolean;
    function fGetSQLField_TEM_CONFERENCIA(blnVerificar: Boolean = True): String;

  Public

    recAutEntTe: TRecAutEntTe;
    strCliFil,
    strForFilEmpresaLogada: String;

    Constructor Create(AOwner: TComponent); reintroduce;
    Destructor Destroy; override;

    function fGetSql(blnLike: Boolean; blnFluxo: Boolean = False): String;

  End;

implementation

Uses
  untFuncoesSimples;

Constructor TEntradaSimplificada.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  LimiteDias := fCfgSis('FLUCDI', varInteger);
  FillChar(recAutEntTe, SizeOf(recAutEntTe), #0);
  recAutEntTe.blnAutEnt := False;
  recAutEntTe.blnPedidoCompra:= True;

  strCliFil := fCampoTabela('EMP_CLIFIL','CADEMP',['EMP_CODEMP'],[VS_strCodEmp], False);
  strForFilEmpresaLogada := fCampoTabela('EMP_FORFIL','CADEMP',['EMP_CODEMP'],[VS_strCodEmp]);
End;

Destructor TEntradaSimplificada.Destroy;
Begin
  inherited;
End;

function TEntradaSimplificada.fGetSQLField_TEM_CONFERENCIA(blnVerificar: Boolean = True): String;
begin
  Result := '';

  If (fCfgSis('EMSRCS', varBoolean)) And blnVerificar Then
  Begin
    Result := Result + ' IF(IFNULL(   ';
    Result := Result + ' (SELECT COUNT(GER_OPEINI) ';
    Result := Result + '  FROM CONDOC ';
    Result := Result + '  LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON  ';
    Result := Result + '  WHERE DOC_SEQGER = G.AUTOINCREM AND GER_DTAFIM IS NULL  ';
    Result := Result + '      ), 0 ) <> 0, "S", ""  ';
    Result := Result + ' ) AS TEM_CONFERENCIA,  ';
  End
  Else
  begin
    Result := Result + ' CAST("" AS CHAR(1)) AS TEM_CONFERENCIA, ';
  end;
end;

function TEntradaSimplificada.fGetSQLField_TEM_EFEITVACAO(strTabela: String): String;
begin
  Result := '';
  If fUsaEfetvacaoFiscal Then
  Begin
    Result := Result + ' IFNULL(   ';
    Result := Result + ' (SELECT MG.AUTOINCREM  ';
    Result := Result + '    FROM  ' + strTabela + ' AS MG  ';
    If SameText(strTabela, 'MOVGER' ) Then
      Result := Result + '   INNER JOIN AUXMOV A   ON A.AUX_SEQGER = MG.AUTOINCREM  '
    Else
      Result := Result + '   INNER JOIN AUXNOT A   ON A.AUX_SEQGER = MG.AUTOINCREM  ';
    Result := Result + '   WHERE MG.GER_NUMDOC = G.GER_NUMDOC  ';
    Result := Result + '     AND MG.GER_ESPDOC = G.GER_ESPDOC  ';
    Result := Result + '     AND MG.GER_SERIE_ = G.GER_SERIE_  ';
    Result := Result + '     AND MG.GER_CODFOR =  (SELECT EMP_FORFIL FROM CADEMP WHERE EMP_CODEMP = G.GER_CODEMP)  ';
    Result := Result + '     AND MG.GER_CODEMP = PCG_EMPDES  ';
    If SameText(strTabela, 'MOVGER' ) Then
      Result := Result + '     AND A.AUX_ENTSIM = "S"  ';
    Result := Result + '     AND MG.GER_DTAENT IS NULL  ';
    Result := Result + '      ), ""   ';
    Result := Result + ' ) AS TEM_EFETIVACAO_FISCAL,  ';
  End
  Else
    Result := Result + ' CAST("" AS CHAR(1)) AS TEM_EFETIVACAO_FISCAL, ';

end;

function TEntradaSimplificada.fGetSQLField_TEM_LOTPRE_TEM_ENDERE(blnTE: Boolean = False): String;
Begin
  Result := '';
  If fCfgSis('LOTSIM') = 'S' Then
  begin
    result := result + ' 	  IF(PCG_BAIXAD <> 0,  IFNULL((SELECT MOVGER.AUTOINCREM ';
    result := result + ' 	                          FROM LOTPRE ';
    result := result + ' 	                          INNER JOIN MOVDET ON MOVDET.AUTOINCREM = LTP_SEQDET ';
    result := result + ' 	                          INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
    Result := Result + '                            INNER JOIN AUXMOV A ON A.AUX_SEQGER = MOVGER.AUTOINCREM  ';
    result := result + ' 	                         WHERE LTP_NUMDOC = G.GER_NUMDOC ';
    result := result + ' 	                           AND LTP_ESPDOC = G.GER_ESPDOC ';
    result := result + ' 	                           AND LTP_SERIE_ = G.GER_SERIE_ ';
    result := result + ' 	                           AND LTP_CODFOR = (SELECT EMP_FORFIL FROM CADEMP WHERE EMP_CODEMP = G.GER_CODEMP) ';
    result := result + ' 	                           AND LTP_CODEMP = PCG_EMPDES ';
    Result := Result + '                             AND A.AUX_ENTSIM = "S" ';
    Result := Result + '                             AND MOVGER.GER_DTAENT IS NOT NULL ';
    Result := Result + '                             AND LTP_BAIXAD = "N" ';

    If blnTE Then
     Result := Result + '                             AND LTP_ESPDOC = "TE" '
    Else
      Result := Result + '                             AND LTP_ESPDOC = "NF" ';

    If Not (fCfgSis('EMPGER', varBoolean) And fCfgSis('LOTGER', varBoolean)) Then
      Result := Result + ' 	                         AND LTP_CODEMP = "' + VS_strCodEmp + '" ';

    If fUsaRotinaWMS Then
      Result := Result + ' AND NOT EXISTS (SELECT * FROM GERELE WHERE B08_NNF = GER_NUMDOC AND  B07_SERIE = GER_SERIE_ AND  GER_CODFOR = GER_CODFOR AND  B09_DEMI = GER_DTADOC ) ';

    result := result + '                            LIMIT 1), "")  , "") AS TEM_LOTPRE, ';
  End
  Else
    result := result + ' CAST("" AS CHAR(1)) AS TEM_LOTPRE, ';

  If fUsaEnderecamento Then
  Begin
    result := result + ' IF( ';
    result := result + '   PCG_BAIXAD <> 0, ';
    result := result + '   IFNULL( ';
    result := result + '           ( SELECT GERENT.AUTOINCREM FROM EXTGOR ';  {precisa achar o autoincrem do documento de entrada}
    If fCfgSis('SPCDEN', varBoolean) Then
    Begin
      result := result + '  INNER JOIN MOVGER GERENT  ON FGO_DCENUM = GERENT.GER_NUMDOC ';
      result := result + '                           AND FGO_DCEESP = GERENT.GER_ESPDOC ';
      result := result + '                           AND FGO_DCESER = GERENT.GER_SERIE_ ';
      result := result + '                           AND FGO_DCEEMP = GERENT.GER_CODEMP ';
      result := result + '                           AND FGO_DCEFOR = GERENT.GER_CODFOR ';
      result := result + '                           AND FGO_DCETFC = GERENT.GER_TIP_FC ';
      Result := Result + ' WHERE FGO_DOCEND IS NOT NULL ';
      Result := Result + '   AND FGO_DCENUM = G.GER_NUMDOC ';
      Result := Result + '   AND FGO_DCEESP = IF(G.GER_ESPDOC="TE", "PD", G.GER_ESPDOC) ';
      Result := Result + '   AND FGO_DCESER = IFNULL(G.GER_SERIE_, "") ';
      Result := Result + '   AND FGO_DCEEMP = PCG_EMPDES ';
      Result := Result + '   AND FGO_DCEFOR = EMP_FORFIL ';
      Result := Result + '   AND FGO_DCETFC = "F" ';
    End
    Else
    Begin
      result := result + '      INNER JOIN MOVGER GERENT  ON SUBSTRING(FGO_DOCEND, 01, 12) = GERENT.GER_NUMDOC ';
      result := result + '                                   AND SUBSTRING(FGO_DOCEND, 13, 02) = GERENT.GER_ESPDOC ';
      result := result + '                                   AND SUBSTRING(FGO_DOCEND, 15, 03) = GERENT.GER_SERIE_ ';
      result := result + '                                   AND SUBSTRING(FGO_DOCEND, 18, 03) = GERENT.GER_CODEMP ';
      result := result + '                                   AND SUBSTRING(FGO_DOCEND, 21, 08) = GERENT.GER_CODFOR ';
      result := result + '                                   AND GERENT.GER_TIP_FC = "F"                           ';
      result := result + '       WHERE SUBSTRING(FGO_DOCEND, 01, 12) = G.GER_NUMDOC';
      result := result + '         AND SUBSTRING(FGO_DOCEND, 13, 02) = IF(G.GER_ESPDOC="TE", "PD", G.GER_ESPDOC) ';
      result := result + '         AND SUBSTRING(FGO_DOCEND, 15, 03) = G.GER_SERIE_';
      result := result + '         AND SUBSTRING(FGO_DOCEND, 18, 03) = PCG_EMPDES';
      result := result + '         AND SUBSTRING(FGO_DOCEND, 21, 08) = EMP_FORFIL';
      result := result + '         AND FGO_DOCEND IS NOT NULL';
    End;

    If fUsaRotinaWMS Then
      Result := Result + ' AND NOT EXISTS (SELECT * FROM GERELE WHERE B08_NNF = GER_NUMDOC AND  B07_SERIE = GER_SERIE_ AND  GER_CODFOR = GER_CODFOR AND  B09_DEMI = GER_DTADOC ) ';

    result := result + '     LIMIT 1),';
    result := result + '     ""';
    result := result + '   ),';
    result := result + '   ""';
    result := result + ' ) AS TEM_ENDERE,';
  End
  Else
    result := result + ' 	  CAST("" AS CHAR(1)) AS TEM_ENDERE, ';
End;



function TEntradaSimplificada.fGetSqlTE(blnFluxo: Boolean = False): String;
  Var
    strSql : String;
    strSQLPadrao: String;
begin
  {******************************************}
  {* TRANSFERENCIAS DE ESTOQUE ESPECIE "TE" *}
  {******************************************}
  strSql := '';
  strSQLPadrao := '';
  (*CodCli*)
  strSQLPadrao := strSQLPadrao + ' SELECT                                         ';
  strSQLPadrao := strSQLPadrao + ' 		"MOVGER" AS TABELA,                                     ';
  strSQLPadrao := strSQLPadrao + ' 		"SENHA2" AS TIPSEN,                                     ';
  strSQLPadrao := strSQLPadrao + ' 		G.AUTOINCREM,                                           ';
  strSQLPadrao := strSQLPadrao + ' 		GER_CODCLI,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_CODFOR,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_NUMDOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_ESPDOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_SERIE_,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		CONCAT(GER_NUMDOC," - ",GER_ESPDOC) AS GER_DOCUME,      ';
  strSQLPadrao := strSQLPadrao + ' 		GER_DTAENT,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_DTADOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODEMP,                                           ';
  strSQLPadrao := strSQLPadrao + '    EMP_NOMEMP AS GER_NOMEMP,                               ';
  strSQLPadrao := strSQLPadrao + '    OPE_NOMOPE AS GER_NOMDIG,                               ';
  strSQLPadrao := strSQLPadrao + ' 		GER_VLRCON,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_MEN001,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_MEN002,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		OPE_CODOPE,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		IF(IFNULL(GER_CONPAG,"")="", "01000", GER_CONPAG) GER_CONPAG,      ';
  strSQLPadrao := strSQLPadrao + ' 		GER_DESESP,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_TOTPRO,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_TOTCUS,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_TOTFRE,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		GER_CLAFIS,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_CODFOR,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_NUMPED,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_CODEMP,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_EMPDES,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_DTALIB,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_ESPDOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		PCG_NUMCTN,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		CONCAT(GER_NUMFAT, " - ", GER_TIPFAT) AS GER_NUMFAT,    ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR01, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR02, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR03, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR04, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR05, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR06, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR07, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR08, ';
  strSQLPadrao := strSQLPadrao + ' 	 	G.GER_VPAR09, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR10, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR11, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR12, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODTRA, ';
  strSQLPadrao := strSQLPadrao + ' 		MOV_OBSFIS,   ';
  strSQLPadrao := strSQLPadrao + ' 	  MOV_OBSERV,   ';
  strSQLPadrao := strSQLPadrao + ' 	  GER_CODCON,   ';
  strSQLPadrao := strSQLPadrao + ' 	  CASE                                            ';
  strSQLPadrao := strSQLPadrao + ' 	    WHEN CONGER.GER_DTAFIM IS NOT NULL THEN "F"   ';
  strSQLPadrao := strSQLPadrao + ' 	    WHEN CONGER.AUTOINCREM IS NOT NULL THEN "A"   ';
  strSQLPadrao := strSQLPadrao + ' 	    ELSE "N"                                      ';
  strSQLPadrao := strSQLPadrao + ' 	  END AS CONCOL,                                  ';

  If not blnFluxo then
    strSQLPadrao := strSQLPadrao + ' 	  PCG_BAIXAD AS BAIXADO,   ';

  If blnFluxo then
  Begin
    strSQLPadrao := strSQLPadrao + ' 	  PCG_BAIXAD,';
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_LOTPRE_TEM_ENDERE(True);
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_EFEITVACAO('MOVGER');
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_CONFERENCIA;
  End;

  strSQLPadrao := strSQLPadrao + ' 	  EMP_FORFIL   ';

  strSQLPadrao := strSQLPadrao + ' 	FROM                                                      ';
  strSQLPadrao := strSQLPadrao + ' 		MOVGER G                                                ';

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CADEMP ON EMP_CODEMP = G.GER_CODEMP            ';

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN MOVOBS ON MOV_SEQGER = G.AUTOINCREM             ';

  If fCfgSis('USADIG', varBoolean) Then
    strSQLPadrao := strSQLPadrao + '  INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) '
  Else
    strSQLPadrao := strSQLPadrao + '  INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN            ';

  strSQLPadrao := strSQLPadrao + fGetInnerJoinPCMGER(blnFluxo);

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CONDOC ON DOC_SEQGER = G.AUTOINCREM             ';
  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON        ';

  strSql := strSQLPadrao + ' 	WHERE                                                     ';
  strSql := strSql + ' 		(GER_CODCLI = "' + strCliFil + '") AND ';
  strSql := strSql + ' 		GER_ESPDOC = "TE"                                       ';
  strSql := strSql + ' 		AND (PCG_EMPDES = "' + VS_StrCodEmp+ '") ';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND GER_DTADOC >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';

  strSql := strSql + 'UNION ALL ';
  strSql := strSql + strSQLPadrao + ' 	WHERE                                                     ';
  strSql := strSql + ' 		( GER_CODFOR = "' + strForFilEmpresaLogada + '") AND ';
  strSql := strSql + ' 		  GER_ESPDOC = "TE"                                       ';
  strSql := strSql + ' 	   	AND (PCG_EMPDES = "' + VS_StrCodEmp+ '") ';
  strSql := strSql + ' 	   	AND ((SELECT COUNT(1) FROM MOVGAE WHERE GAE_NUMENV = PCG_ORIGND AND GAE_ESPENV = PCG_ORIGES AND GAE_EMPENV = PCG_ORIGEP) = 0 ) ';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND GER_DTADOC >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';
  Result := strSQL;
End;

function TEntradaSimplificada.fUsaEfetvacaoFiscal: Boolean;
begin
  If fUsaRotinaWMS Then
  Begin
    If fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
      Result := False
    Else
      Result := True;
  End
  Else
    Result := fConferenciaDepoisDaEntrada;
end;

function TEntradaSimplificada.fGetSqlPedidoCompra: String;
  Var
    strSql : String;
begin
  strSql := '';

  If (recAutEntTe.blnPedidoCompra) Then
  Begin
    strSql := strSql + ' 		PCG_CODFOR,                                             ';
    strSql := strSql + ' 		PCG_NUMPED,                                             ';
    strSql := strSql + ' 		PCG_CODEMP,                                             ';
    strSql := strSql + ' 		PCG_EMPDES,                                             ';
    strSql := strSql + ' 		PCG_DTALIB,                                             ';
    strSql := strSql + ' 		PCG_ESPDOC,                                             ';
    strSql := strSql + ' 		PCG_NUMCTN,                                             ';
  End
  Else
  Begin
    strSql := strSql + '"' + recAutEntTe.strCodForTE + '" AS PCG_CODFOR,            ';
    strSql := strSql + ' 		NULL AS PCG_NUMPED,                                     ';
    strSql := strSql + ' 		NULL AS PCG_CODEMP,                                     ';
    strSql := strSql + ' 		NULL AS PCG_EMPDES,                                     ';
    strSql := strSql + ' 		NULL AS PCG_DTALIB,                                     ';
    strSql := strSql + ' 		NULL AS PCG_ESPDOC,                                     ';
    strSql := strSql + ' 		NULL AS PCG_NUMCTN,                                     ';
  End;

  Result := strSQL;
End;

function TEntradaSimplificada.fGetSqlNF(blnFluxo: Boolean = False): String;
  Var
    strSql : String;
    strSQLPadrao: string;
    strSQLEMSRCS: string;
begin
  strSql := '';
  strSQLPadrao := '';
  {******************************************}
  {* TRANSFERENCIAS DE ESTOQUE ESPECIE "NF" *}
  {******************************************}
  strSQLPadrao := strSQLPadrao + ' SELECT                                         ';
  strSQLPadrao := strSQLPadrao + ' 		"MOVGER" AS TABELA,                                     ';
  strSQLPadrao := strSQLPadrao + ' 		"SENHA1" AS TIPSEN,                                     ';
  strSQLPadrao := strSQLPadrao + ' 		G.AUTOINCREM,                                           ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODCLI,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODFOR,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_NUMDOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_ESPDOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_SERIE_,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		CONCAT(G.GER_NUMDOC," - ",G.GER_ESPDOC) AS GER_DOCUME,      ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_DTAENT,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_DTADOC,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODEMP,                                             ';
  strSQLPadrao := strSQLPadrao + '    EMP_NOMEMP AS GER_NOMEMP,                               ';
  strSQLPadrao := strSQLPadrao + '    OPE_NOMOPE AS GER_NOMDIG,                               ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VLRCON,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_MEN001,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_MEN002,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		OPE_CODOPE,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		IF(IFNULL(G.GER_CONPAG,"")="", "01000", G.GER_CONPAG) GER_CONPAG,      ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_DESESP,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_TOTPRO,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_TOTCUS,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_TOTFRE,                                             ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CLAFIS,                                             ';

  strSQLPadrao := strSQLPadrao +  fGetSqlPedidoCompra;

  strSQLPadrao := strSQLPadrao + ' 		CONCAT(G.GER_NUMFAT, " - ", G.GER_TIPFAT) AS GER_NUMFAT,    ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR01, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR02, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR03, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR04, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR05, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR06, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR07, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR08, ';
  strSQLPadrao := strSQLPadrao + ' 	 	G.GER_VPAR09, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR10, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR11, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_VPAR12, ';
  strSQLPadrao := strSQLPadrao + ' 		G.GER_CODTRA, ';
  strSQLPadrao := strSQLPadrao + ' 		MOV_OBSFIS,   ';
  strSQLPadrao := strSQLPadrao + ' 	  MOV_OBSERV,   ';
  strSQLPadrao := strSQLPadrao + ' 	  GER_CODCON,   ';

  strSQLPadrao := strSQLPadrao + ' 	  CASE                                            ';
  strSQLPadrao := strSQLPadrao + ' 	    WHEN CONGER.GER_DTAFIM IS NOT NULL THEN "F"   ';
  strSQLPadrao := strSQLPadrao + ' 	    WHEN CONGER.AUTOINCREM IS NOT NULL THEN "A"   ';
  strSQLPadrao := strSQLPadrao + ' 	    ELSE "N"                                      ';
  strSQLPadrao := strSQLPadrao + ' 	  END AS CONCOL,                                   ';

  If not blnFluxo then
    strSQLPadrao := strSQLPadrao + ' 	  PCG_BAIXAD AS BAIXADO,   ';

  If blnFluxo then
  Begin
    strSQLPadrao := strSQLPadrao + ' 	  PCG_BAIXAD,';
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_LOTPRE_TEM_ENDERE;
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_EFEITVACAO('MOVGER');
    strSQLPadrao := strSQLPadrao + fGetSQLField_TEM_CONFERENCIA;
  End;


  strSQLPadrao := strSQLPadrao + ' 	  EMP_FORFIL    ';


  strSQLPadrao := strSQLPadrao + ' 	FROM                                                      ';
  strSQLPadrao := strSQLPadrao + ' 		MOVGER  G                                               ';

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CADEMP ON EMP_CODEMP = G.GER_CODEMP             ';

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN MOVOBS ON MOV_SEQGER = G.AUTOINCREM             ';

  If fCfgSis('USADIG', varBoolean) Then
    strSQLPadrao := strSQLPadrao + '  INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) '
  Else
    strSQLPadrao := strSQLPadrao + '  INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN            ';

  strSQLEMSRCS := strSQLPadrao;

  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CONDOC ON DOC_SEQGER = G.AUTOINCREM             ';
  strSQLPadrao := strSQLPadrao + '  LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON        ';

  If (recAutEntTe.blnPedidoCompra) Then
  Begin
    strSQLPadrao := strSQLPadrao + fGetInnerJoinPCMGER(blnFluxo, False);
  End;

  strSQLPadrao := strSQLPadrao + ' 	WHERE                                                     ';
  strSql := strSQLPadrao + ' 		(GER_CODCLI = "' + strCliFil + '")  AND ';
  strSql := strSql + ' 		(GER_ESPDOC = "NF")    ';

  If (Not recAutEntTe.blnPedidoCompra) Then
  Begin
    strSql := strSql + ' 		AND G.GER_NUMDOC = "' + recAutEntTe.strDocOri + '" ';
    strSql := strSql + ' 		AND G.GER_ESPDOC = "' + recAutEntTe.strEspOri + '" ';
    strSql := strSql + ' 		AND G.GER_CODEMP = "' + recAutEntTe.strEmpOri + '" ';
    strSql := strSql + ' 		AND G.GER_SERIE_ = "' + recAutEntTe.strSerOri + '" ';
  End
  Else
    strSql := strSql + ' 		AND (PCG_EMPDES = "' + VS_StrCodEmp+ '")';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND GER_DTADOC >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';

  strSql := strSql + ' UNION ALL ' ;
  strSql := strSql + strSQLPadrao + ' 		(GER_CODFOR = "' + strForFilEmpresaLogada + '") AND ';
  strSql := strSql + ' 		(GER_ESPDOC = "NF")  ';

  If (recAutEntTe.blnPedidoCompra) Then
    strSql := strSql + '  	AND ((fCfgSis("CFG_COFTRA",PCG_ORIGEP) = "S") OR ((SELECT COUNT(1) FROM MOVGAE WHERE GAE_NUMENV = PCG_ORIGND AND GAE_ESPENV = PCG_ORIGES AND GAE_EMPENV = PCG_ORIGEP) = 0 )) ';

  If (Not recAutEntTe.blnPedidoCompra) Then
  Begin
    strSql := strSql + ' 		AND G.GER_NUMDOC = "' + recAutEntTe.strDocOri + '" ';
    strSql := strSql + ' 		AND G.GER_ESPDOC = "' + recAutEntTe.strEspOri + '" ';
    strSql := strSql + ' 		AND G.GER_CODEMP = "' + recAutEntTe.strEmpOri + '" ';
    strSql := strSql + ' 		AND G.GER_SERIE_ = "' + recAutEntTe.strSerOri + '" ';
  End
  Else
    strSql := strSql + ' 		AND (PCG_EMPDES = "' + VS_StrCodEmp+ '")';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND GER_DTADOC >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';

  {$Region 'Garantia Envio p/ Fornecedor (filial) - transferência entre lojas'}
  strSql := strSql + ' UNION ALL ' ;
  strSql := strSql + strSQLPadrao + ' 		(GER_CODFOR = ' + QuotedStr(strForFilEmpresaLogada) + ') AND ';
  strSql := strSql + ' 		(GER_ESPDOC = "NF")  ';
  strSql := strSql + '     AND G.GER_CODEMP <> '+Quotedstr(VS_StrCodEmp);
  strSql := strSql + '     AND EXISTS (SELECT 1 ';
  strSql := strSql + '                 FROM MOVGAE ';
  strSql := strSql + '                 WHERE GAE_NUMENV = G.GER_NUMDOC ';
  strSql := strSql + '                   AND GAE_ESPENV = G.GER_ESPDOC ';
  strSql := strSql + '                   AND GAE_EMPENV = G.GER_CODEMP ';
  strSql := strSql + '                   AND GAE_SERENV = G.GER_SERIE_) ';

  strSql := strSql + ' 		 AND ((PCG_CODEMP = G.GER_CODEMP) AND (PCG_CODEMP <> '+QuotedStr(VS_StrCodEmp)+')) ';
  strSql := strSql + ' 		 AND ((IFNULL(PCG_EMPDES,"") = "") OR (PCG_EMPDES = ' + QuotedStr(VS_StrCodEmp)+ '))';

  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND GER_DTADOC >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';
  {$EndRegion 'Garantia Envio p/ Fornecedor (filial) - transferência entre lojas'}

  If (fCfgSis('EMSRCS', varBoolean)) AND (Not blnFluxo) then
  begin
    strSQLEMSRCS := StringReplace(strSQLEMSRCS, 'G.GER_CODEMP,', 'PCG_CODEMP AS GER_CODEMP,', []);

    strSql := strSql + ' UNION ALL ' ;
    strSql := strSql + strSQLEMSRCS;
    strSql := strSql + '  INNER JOIN PCMGER';
    strSql := strSql + '   ON PCG_ORIGND = G.GER_NUMDOC ';
    strSql := strSql + '  AND PCG_ORIGES = G.GER_ESPDOC ';
    strSql := strSql + '  AND PCG_EMPDES = G.GER_CODEMP ';

    strSql := strSql + ' INNER JOIN MOVGER MV ON MV.GER_NUMDOC = PCG_ORIGND AND MV.GER_ESPDOC = PCG_ORIGES AND MV.GER_CODEMP = PCG_CODEMP ';
    strSql := strSql + ' INNER JOIN CONDOC CD ON CD.DOC_SEQGER = MV.AUTOINCREM ';
    strSql := strSql + ' INNER JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON  AND GER_DTAFIM IS NULL       ';

    strSql := strSql + '  WHERE   ';
    strSql := strSql + ' 		(G.GER_CODFOR <> "") AND ';
    strSql := strSql + ' 		(G.GER_ESPDOC = "NF")  ';

    If (Not recAutEntTe.blnPedidoCompra) Then
    Begin
      strSql := strSql + ' 		AND G.GER_NUMDOC = "' + recAutEntTe.strDocOri + '" ';
      strSql := strSql + ' 		AND G.GER_ESPDOC = "' + recAutEntTe.strEspOri + '" ';
      strSql := strSql + ' 		AND G.GER_CODEMP = "' + recAutEntTe.strEmpOri + '" ';
      strSql := strSql + ' 		AND G.GER_SERIE_ = "' + recAutEntTe.strSerOri + '" ';
    End
    Else
      strSql := strSql + ' 		AND (PCG_EMPDES = "' + VS_StrCodEmp+ '")';
  end;

  Result := strSQL;
End;

function TEntradaSimplificada.fGetSqlAjuste(blnFluxo: Boolean = False): String;
  Var
    strSql : String;
begin
  {***********************************************************}
  {* CONFIRMACOES DE AJUSTE DE ESTOQUE PARA CLIENTES FILIAIS *}
  {* OBS: SOLICITADO PELO CLIENTE "MATIZ" NO DIA 18/02/2014  *}
  {********************************************************RN*}
  strSql := '';
  strSql := strSql + ' SELECT                                               ';
  strSql := strSql + ' 		"NOTGER" AS TABELA,                                     ';
  strSql := strSql + ' 		"SENHA1" AS TIPSEN,                                     ';
  strSql := strSql + ' 		G.AUTOINCREM,                                           ';
  strSql := strSql + ' 		GER_CODCLI,                                             ';
  strSql := strSql + ' 		GER_CODFOR,                                             ';
  strSql := strSql + ' 		GER_NUMDOC,                                             ';
  strSql := strSql + ' 		GER_ESPDOC,                                             ';
  strSql := strSql + ' 		GER_SERIE_,                                             ';
  strSql := strSql + ' 		CONCAT(GER_NUMDOC," - ",GER_ESPDOC) AS GER_DOCUME,      ';
  strSql := strSql + ' 		GER_DTAENT,                                             ';
  strSql := strSql + ' 		GER_DTAENT AS GER_DTADOC,                               ';
  strSql := strSql + ' 		GER_CODEMP,                                             ';
  strSql := strSql + '          EMP_NOMEMP AS GER_NOMEMP,                               ';
  strSql := strSql + '          OPE_NOMOPE AS GER_NOMDIG,                               ';
  strSql := strSql + ' 		GER_VLRCON,                                             ';
  strSql := strSql + ' 		GER_MEN001,                                             ';
  strSql := strSql + ' 		GER_MEN002,                                             ';
  strSql := strSql + ' 		OPE_CODOPE,                                             ';
  strSql := strSql + ' 		IF(IFNULL(GER_CONPAG,"")="", "01000", GER_CONPAG) GER_CONPAG,      ';
  strSql := strSql + ' 		GER_DESESP,                                             ';
  strSql := strSql + ' 		GER_TOTPRO,                                             ';
  strSql := strSql + ' 		GER_TOTCUS,                                             ';
  strSql := strSql + ' 		GER_TOTFRE,                                             ';
  strSql := strSql + ' 		GER_CLAFIS,                                             ';
  strSql := strSql + ' 		PCG_CODFOR,                                             ';
  strSql := strSql + ' 		PCG_NUMPED,                                             ';
  strSql := strSql + ' 		PCG_CODEMP,                                             ';
  strSql := strSql + ' 		PCG_EMPDES,                                             ';
  strSql := strSql + ' 		PCG_DTALIB,                                             ';
  strSql := strSql + ' 		PCG_ESPDOC,                                             ';
  strSql := strSql + ' 		PCG_NUMCTN,                                             ';
  strSql := strSql + ' 		CONCAT(GER_NUMFAT, " - ", GER_TIPFAT) AS GER_NUMFAT,    ';
  strSql := strSql + ' 		G.GER_VPAR01, ';
  strSql := strSql + ' 		G.GER_VPAR02, ';
  strSql := strSql + ' 		G.GER_VPAR03, ';
  strSql := strSql + ' 		G.GER_VPAR04, ';
  strSql := strSql + ' 		G.GER_VPAR05, ';
  strSql := strSql + ' 		G.GER_VPAR06, ';
  strSql := strSql + ' 		G.GER_VPAR07, ';
  strSql := strSql + ' 		G.GER_VPAR08, ';
  strSql := strSql + ' 	 	G.GER_VPAR09, ';
  strSql := strSql + ' 		G.GER_VPAR10, ';
  strSql := strSql + ' 		G.GER_VPAR11, ';
  strSql := strSql + ' 		G.GER_VPAR12, ';
  strSql := strSql + ' 		G.GER_CODTRA, ';
  strSql := strSql + ' 		" " AS MOV_OBSFIS, ';
  strSql := strSql + ' 	  " " AS MOV_OBSERV, ';
  strSql := strSql + ' 	  " " AS GER_CODCON,   ';
  strSql := strSql + ' 	  "N" AS CONCOL,  ';

  If not blnFluxo then
    strSql := strSql + ' 	  PCG_BAIXAD AS BAIXADO, ';

  If blnFluxo then
  Begin
    strSql := strSql + ' 	  PCG_BAIXAD,';
    strSql := strSql + fGetSQLField_TEM_LOTPRE_TEM_ENDERE;
    strSql := strSql + fGetSQLField_TEM_EFEITVACAO('NOTGER');
    strSql := strSql + fGetSQLField_TEM_CONFERENCIA(False);
  End;

  strSql := strSql + ' 	  EMP_FORFIL    ';

  strSql := strSql + ' 	FROM                                                            ';
  strSql := strSql + ' 		NOTGER  G                                               ';
  strSql := strSql + '  LEFT JOIN CADEMP ON EMP_CODEMP = GER_CODEMP                    ';

  If fCfgSis('USADIG', varBoolean) Then
    strSql := strSql + '  INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) '
  Else
    strSql := strSql + '  INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN            ';

  strSql := strSql + fGetInnerJoinPCMGER(blnFluxo);

  strSql := strSql + ' 	WHERE   ';
  strSql := strSql + ' 		GER_CODCLI = "' + strCliFil + '" AND           ';
  strSql := strSql + ' 		(GER_ESPDOC = "NF") AND   ';

  strSql := strSql + ' 		(GER_CODEMP <> "' + VS_StrCodEmp+ '")';
  strSql := strSql + ' 		AND (PCG_EMPDES = "' + VS_StrCodEmp+ '")';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND G.GER_DTAENT >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';

  Result := strSQL;
End;

function TEntradaSimplificada.fGetSqlConfirmacao(blnFluxo: Boolean = False): String;
  Var
    strSql : String;
begin
  strSql := '';

  {*******************************************************}
  {* CONFIRMACOES DE TRANSFERENCIA DE ESTOQUE (TE -> NF) *}
  {*******************************************************}
  strSql := strSql + ' SELECT  DISTINCT                               ';
  strSql := strSql + ' 		"NOTGER" AS TABELA,                                     ';
  strSql := strSql + ' 		"SENHA1" AS TIPSEN,                                     ';
  strSql := strSql + ' 		G.AUTOINCREM,                                           ';
  strSql := strSql + ' 		G.GER_CODCLI,                                             ';
  strSql := strSql + ' 		G.GER_CODFOR,                                             ';
  strSql := strSql + ' 		G.GER_NUMDOC,                                             ';
  strSql := strSql + ' 		G.GER_ESPDOC,                                             ';
  strSql := strSql + ' 		G.GER_SERIE_,                                             ';
  strSql := strSql + ' 		CONCAT(G.GER_NUMDOC," - ",G.GER_ESPDOC) AS GER_DOCUME,      ';
  strSql := strSql + ' 		G.GER_DTAENT,                                             ';
  strSql := strSql + ' 		G.GER_DTAENT AS GER_DTADOC,                               ';
  strSql := strSql + ' 		G.GER_CODEMP,                                             ';
  strSql := strSql + '    EMP_NOMEMP AS GER_NOMEMP,                               ';
  strSql := strSql + '    OPE_NOMOPE AS GER_NOMDIG,                               ';
  strSql := strSql + ' 		G.GER_VLRCON,                                             ';
  strSql := strSql + ' 		G.GER_MEN001,                                             ';
  strSql := strSql + ' 		G.GER_MEN002,                                             ';
  strSql := strSql + ' 		OPE_CODOPE,                                             ';
  strSql := strSql + ' 		IF(IFNULL(G.GER_CONPAG,"")="", "01000", G.GER_CONPAG) GER_CONPAG,      ';
  strSql := strSql + ' 		G.GER_DESESP,                                             ';
  strSql := strSql + ' 		G.GER_TOTPRO,                                             ';
  strSql := strSql + ' 		G.GER_TOTCUS,                                             ';
  strSql := strSql + ' 		G.GER_TOTFRE,                                             ';
  strSql := strSql + ' 		G.GER_CLAFIS,                                             ';
  strSql := strSql + ' 		NULL AS PCG_CODFOR,                                     ';
  strSql := strSql + ' 		NULL AS PCG_NUMPED,                                     ';
  strSql := strSql + ' 		NULL AS PCG_CODEMP,                                     ';
  strSql := strSql + ' 		NULL AS PCG_EMPDES,                                     ';
  strSql := strSql + ' 		NULL AS PCG_DTALIB,                                      ';
  strSql := strSql + ' 		NULL AS PCG_ESPDOC,                                     ';
  strSql := strSql + ' 		NULL AS PCG_NUMCTN,                                     ';
  strSql := strSql + ' 		CONCAT(G.GER_NUMFAT, " - ", G.GER_TIPFAT) AS GER_NUMFAT,';
  strSql := strSql + ' 		G.GER_VPAR01, ';
  strSql := strSql + ' 		G.GER_VPAR02, ';
  strSql := strSql + ' 		G.GER_VPAR03, ';
  strSql := strSql + ' 		G.GER_VPAR04, ';
  strSql := strSql + ' 		G.GER_VPAR05, ';
  strSql := strSql + ' 		G.GER_VPAR06, ';
  strSql := strSql + ' 		G.GER_VPAR07, ';
  strSql := strSql + ' 		G.GER_VPAR08, ';
  strSql := strSql + ' 	 	G.GER_VPAR09, ';
  strSql := strSql + ' 		G.GER_VPAR10, ';
  strSql := strSql + ' 		G.GER_VPAR11, ';
  strSql := strSql + ' 		G.GER_VPAR12, ';
  strSql := strSql + ' 		G.GER_CODTRA, ';
  strSql := strSql + ' 		" " AS MOV_OBSFIS, ';
  strSql := strSql + ' 	  " " AS MOV_OBSERV, ';
  strSql := strSql + ' 	  " " AS GER_CODCON,   ';
  strSql := strSql + ' 	  "N" AS CONCOL,  ';

  If not blnFluxo then
    strSql := strSql + ' 0 AS BAIXADO, ';

  If blnFluxo then
  Begin
     strSql := strSql + ' 0 AS PCG_BAIXAD,';
     {strSql := strSql + fGetSQLField_TEM_LOTPRE_TEM_ENDERE; }
     strSql := strSql + ' CAST("" AS CHAR(1)) AS TEM_LOTPRE, ';
     strSql := strSql + ' CAST("" AS CHAR(1)) AS TEM_ENDERE, ';
     strSql := strSql + fGetSQLField_TEM_EFEITVACAO('NOTGER');
     strSql := strSql + fGetSQLField_TEM_CONFERENCIA(False);
  End;

  strSql := strSql + ' 	  EMP_FORFIL    ';


  strSql := strSql + ' 	FROM                                                      ';
  strSql := strSql + ' 		NOTGER  G                                               ';

  strSql := strSql + '  LEFT JOIN CADEMP ON EMP_CODEMP = G.GER_CODEMP              ';

  strSql := strSql + '  INNER JOIN MOVGER M ON M.GER_TIPFAT = G.GER_ESPDOC AND   ';
  strSql := strSql + '                         M.GER_NUMFAT = G.GER_NUMDOC AND   ';
  strSql := strSql + '                         M.GER_EMPFAT = G.GER_CODEMP       ';

  If fCfgSis('USADIG', varBoolean) Then
    strSql := strSql + '  INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(G.GER_CODDIG, G.GER_CODVEN) '
  Else
    strSql := strSql + '  INNER JOIN CADOPE ON OPE_CODOPE = G.GER_CODVEN            ';
  {* NÃO PODE CARREGAR REGISTRO COM PEDIDO DE COMPRA VINCULADO, POIS O 'UNION' ACIMA JÁ FAZ ISSO *}
  {* REQUISITO 198971 *}
  {strSQL := strSQL + '  LEFT JOIN (SELECT ';
  strSQL := strSQL + '                PCG_CODFOR, ';
  strSQL := strSQL + '                PCG_NUMPED, ';
  strSQL := strSQL + '                PCG_CODEMP, ';
  strSQL := strSQL + '                PCG_EMPDES, ';
  strSQL := strSQL + '                PCG_DTALIB, ';
  strSQL := strSQL + '                SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') AS ORI_NUMDOC, ';
  strSQL := strSQL + '                SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) AS ORI_ESPDOC, ';
  strSQL := strSQL + '                SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 9, 15)) + ',3) AS ORI_CODEMP, ';
  strSql := strSql + ' 		            PCG_ESPDOC, ';
  strSql := strSql + ' 		            PCG_DTAPED, ';
  strSql := strSql + ' 		            PCG_BAIXAD, PCG_NUMCTN  ';
  strSQL := strSQL + '              FROM ';
  strSQL := strSQL + '                PCMGER ';
  strSQL := strSQL + '              WHERE TRUE AND ';
  If Not blnFluxo then
    strSQL := strSQL + '               PCG_BAIXAD = 0 AND ';
  strSQL := strSQL + '                IFNULL(PCG_DOCORI, "") <> "") AS TMP ON ORI_NUMDOC = G.GER_NUMDOC AND ';
  strSQL := strSQL + '                                                        ORI_ESPDOC = G.GER_ESPDOC AND ';
  strSQL := strSQL + '                                                        ORI_CODEMP = G.GER_CODEMP AND ';
  strSQL := strSQL + '                                                        PCG_DTAPED = G.GER_DTAENT ';  }

  strSql := strSql + ' 	WHERE                                                       ';
  strSql := strSql + ' 		IFNULL(G.GER_NUMFAT, "") = "" AND                         ';
  strSql := strSql + ' 		G.GER_CODCLI = "' + strCliFil + '" AND                    ';
  strSql := strSql + ' 		(G.GER_ESPDOC = "NF") AND                                 ';
  strSql := strSql + ' 		(G.GER_CODEMP <> "' + VS_StrCodEmp+ '") AND               ';
  strSql := strSql + ' 		(M.GER_ESPDOC <> "AJ" )                                   ';
  If (LimiteDias > 0) And (blnFluxo) Then
    strSql := strSql + ' 		AND G.GER_DTAENT >= DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY) ';

  {strSql := strSql + ' 	(PCG_NUMPED IS NULL )  '; }

  Result := strSQL;
End;

function TEntradaSimplificada.fGetInnerJoinPCMGER(blnFluxo: Boolean = False; blnVerificaConferencia: Boolean = True): String;
begin
  Result := '';
  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    Result := Result + '  INNER JOIN PCMGER';
    Result := Result + '   ON PCG_ORIGND = GER_NUMDOC ';
    Result := Result + '  AND PCG_ORIGES = GER_ESPDOC ';
    Result := Result + '  AND PCG_ORIGEP = G.GER_CODEMP ';
    Result := Result + '  AND PCG_DTAPED = G.GER_DTAENT ';
  End
  Else
  begin
    Result := Result + '  INNER JOIN (SELECT ';
    Result := Result + '                PCG_CODFOR, ';
    Result := Result + '                PCG_NUMPED, ';
    Result := Result + '                PCG_CODEMP, ';
    Result := Result + '                PCG_EMPDES, ';
    Result := Result + '                PCG_DTALIB, ';
    Result := Result + '                PCG_DOCORI, ';
    Result := Result + ' 		            PCG_ESPDOC, ';
    Result := Result + ' 		            PCG_DTAPED, ';
    Result := Result + ' 		            PCG_BAIXAD, ';
    Result := Result + '                PCG_NUMCTN, ';
    Result := Result + '                PCG_ORIGND, ';
    Result := Result + '                PCG_ORIGES, ';
    Result := Result + '                PCG_ORIGEP  ';
    Result := Result + '              FROM ';
    Result := Result + '                PCMGER ';
    Result := Result + '              WHERE TRUE  ';
    Result := Result + '                AND IFNULL(PCG_DOCORI, "") <> "") AS TMP ';
    Result := Result + '  ON  PCG_DOCORI = CONCAT(G.GER_NUMDOC,G.GER_ESPDOC,G.GER_CODEMP)  ';
    Result := Result + '  AND PCG_DTAPED = G.GER_DTAENT   ';
  End;

  If (Not blnFluxo) then
  begin
    if (fCfgSis('EMSRCS', varBoolean)) And blnVerificaConferencia then
    begin
      Result := Result + '  AND (PCG_BAIXAD = 0 OR ';
      Result := Result + ' (IFNULL(   ';
      Result := Result + ' (SELECT COUNT(GER_OPEINI) ';
      Result := Result + '  FROM CONDOC ';
      Result := Result + '  LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON  ';
      Result := Result + '  WHERE DOC_SEQGER = G.AUTOINCREM AND GER_DTAFIM IS NULL  ';
      Result := Result + '      ), 0 ) <> 0))  ';
    end
    else
    begin
      Result := Result + '  AND PCG_BAIXAD = 0 ';
    end;
  end;
end;

function TEntradaSimplificada.fGetSql(blnLike: Boolean; blnFluxo: Boolean = False): String;
  Var
    strSql : String;
begin

  strSql := '';
  strSql := strSql + fGetSqlTE(blnFluxo);
  strSql := strSql + ' 	UNION ALL                             ';
  strSql := strSql + fGetSqlNF(blnFluxo);
  strSql := strSql + ' UNION ALL                              ';
  strSql := strSql + fGetSqlAjuste(blnFluxo);
  strSql := strSql + ' 	UNION ALL                             ';
  strSql := strSql + fGetSqlConfirmacao(blnFluxo);

  Result := strSql;
end;

end.
