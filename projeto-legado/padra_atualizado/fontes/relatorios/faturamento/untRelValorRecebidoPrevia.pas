unit untRelValorRecebidoPrevia;

interface

uses SysUtils, strUtils, untTypesSistema;

Type
  TValorRecebido = class(TObject)
    private
      FConJur   : Boolean;
      FCodVen   : String;
      FStaVen   : String;
      FCodDep   : string;
      FCodEmp   : String;
      FTipVenRep: String;
      FRelEmp   : TRelacionamentoEmpresa;
      FVenRep   : TOpVendedorRepresentante;
      FDtaIni: String;
      FUltPar: Boolean;
      FDtaFin: String;

      function fRetFiltroCliente: String;
      function fRetFiltroData(strTabela: String): String;

      function fRetSQLMovger(blnAgrupa: Boolean): String;
      function fRetCampoGER_TOTPRO(strTabela: String): String;
      function fGetQtdParcelasCtr(strTabela: String): String;
    public

      Constructor Create;

      function fGetVenDig(strAlias: String): String;
      function fGetVenDigDet: String;
      function fGetFatCom: String;

      function fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String): String;
      function fGetSqlComConfirmacao(strCadRec, strCtrCnf: String): String;
      function fGetSqlComAgrupamentoDireto(strCadRec, strDupAgr: String): String;
      function fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr, strCtrCnf: String): String;

      function fGetSqlSemAgrupamentoNemConfirmacaoAberto(strTabela: String): String;
      function fGetSqlComConfirmacaoAberto(strCadRec, strCtrCnf: String): String;
      function fGetSqlComAgrupamentoDiretoAberto(strCadRec, strDupAgr: String): String;
      function fGetSqlAgrupamentoConfirmacaoAberto(strCadRec, strDupAgr, strCtrCnf: String): String;

      property strCodVen: String Read FCodVen Write FCodVen;
      property strStaVen: String Read FStaVen Write FStaVen;
      property strCodDep: string read FCodDep Write FCodDep;
      property strCodEmp: String Read FCodEmp Write FCodEmp;
      property strTipVenRep: String Read FTipVenRep Write FTipVenRep;
      property relRelEmp: TRelacionamentoEmpresa   Read FRelEmp Write FRelEmp;
      property opcVenRep: TOpVendedorRepresentante Read FVenRep Write FVenRep;
      property blnConJur: Boolean                  Read FConJur Write FConJur;

      property strDtaIni: String  Read FDtaIni Write FDtaIni;
      property strDtaFim: String  Read FDtaFin Write FDtaFin;
      property blnUltPar: Boolean Read FUltPar Write FUltPar;
    End;

implementation

uses untFuncoesFactory, untIFuncoes;

{ TValorRecebido }

constructor TValorRecebido.Create;
begin
  strCodVen    := '';
  strStaVen    := '';
  strCodDep    := '';
  strCodEmp    := '';
  strTipVenRep := '';
  relRelEmp    := reMovimentacao;

  blnUltPar := False;  
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT  SQL_NO_CACHE                       ';
  strSQL := strSQL + '   "AGRUPAMENTO CONFIRMAÇÃO" AS MODALIDADE, ';
  strSQL := strSQL + '  ' + fGetVenDig('CNF.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,                              ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,     ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,     ';
  strSQL := strSQL + '   OPE_INTEXT,                              ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                          ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('CNF.') + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
//strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALORI, REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALDES, ';
//  strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
//    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, '
    strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
//    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

//  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM((REC.CTR_VALORI - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0)' + ' - IFNULL(CNF.CTR_VALCBS,0) - IFNULL(CNF.CTR_VALIBS,0) - IFNULL(CNF.CTR_VAL_IS,0) - IFNULL(CNF.CTR_VALACE,0) - IFNULL(CNF.CTR_VALFRE,0) - IFNULL(CNF.CTR_VALFCP,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG, ';

  If opcVenRep in [opSupGeral, opSupRegional] Then
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End;
  End;

  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP) AS DOCUME,  ';

  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   CNF.CTR_CODCLI, ';
  strSQL := strSQL + '   CNF.CTR_CODEMP, ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF,  ';

  {************************************}
  {* CAMPOS PARA                      *}
  {* RESUMO POR MODALIDADE            *}
  {********************************MM**}
  strSQL := strSQL + '   SUM(REC.CTR_DINHEI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQAVI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQPRE * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CARTAO * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(REC.CTR_ORDPAG * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS ORDPAG,  ';
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS VALFIN,  ';

  strSQL := strSQL + fRetCampoGER_TOTPRO(strCadRec);

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL +    fRetSQLMovger(True);

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0  '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ',                                                      ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacaoAberto(strCadRec,
  strDupAgr, strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                                   ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                                           ';
  strSQL := strSQL + '   OPE_NOMOPE,                                                         ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,                                ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,                                ';
  strSQL := strSQL + '   OPE_INTEXT,                                                         ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,                    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_ABERTO,';
  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';  

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAVEN IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';    

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE    ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDireto(strCadRec,
  strDupAgr: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "AGRUPAMENTO DIRETO" AS MODALIDADE,       ';
  strSQL := strSQL + '   ' + fGetVenDig('AGR.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,                               ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('AGR.') + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALORI, REC.CTR_VALORI) * AGR.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2) AS CTR_VALDES, ';
//  strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2) AS CTR_VALREC,           ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2) AS CTR_VALREC,           ';

  If blnConJur Then
//    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2) AS CTR_RECCOM, '
    strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2) AS CTR_RECCOM, '
  Else
//    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2) AS CTR_RECCOM, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALORI) * AGR.CTR_FATCO2) AS CTR_RECCOM, ';

//  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(AGR.CTR_VALIPI,0) - IFNULL(AGR.CTR_VALRET,0)) * AGR.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM((REC.CTR_VALORI - IFNULL(AGR.CTR_VALIPI,0) - IFNULL(AGR.CTR_VALRET,0)' + ' - IFNULL(AGR.CTR_VALCBS,0) - IFNULL(AGR.CTR_VALIBS,0) - IFNULL(AGR.CTR_VAL_IS,0) - IFNULL(AGR.CTR_VALACE,0) - IFNULL(AGR.CTR_VALFRE,0) - IFNULL(AGR.CTR_VALFCP,0)) * AGR.CTR_FATCO2) AS CTR_RECIPI, ';

//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * AGR.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * AGR.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALORI * AGR.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALORI * AGR.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG,                                 ';

  If opcVenRep in [opSupGeral, opSupRegional] Then
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(((REC.CTR_VALORI) * AGR.CTR_FATCO2) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, '
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, '
    End;
  End;

  strSQL := strSQL + '   CONCAT(AGR.CTR_NUMDUP,"-",AGR.CTR_PARCEL,"-",AGR.CTR_ESPDOC,"-",AGR.CTR_CODEMP) AS DOCUME,  ';

  strSQL := strSQL + '   AGR.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   AGR.CTR_CODCLI, ';
  strSQL := strSQL + '   AGR.CTR_CODEMP, ';

  strSQL := strSQL + '   CNF.CTR_DOCCNF  AS CTR_DOCCNF,  ';

  {************************************}
  {* CAMPOS PARA                      *}
  {* RESUMO POR MODALIDADE            *}
  {********************************MM**}
  strSQL := strSQL + '   SUM(REC.CTR_DINHEI * AGR.CTR_FATCO2) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQAVI * AGR.CTR_FATCO2) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQPRE * AGR.CTR_FATCO2) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CARTAO * AGR.CTR_FATCO2) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(REC.CTR_ORDPAG * AGR.CTR_FATCO2) AS ORDPAG,  ';
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * AGR.CTR_FATCO2) AS VALFIN,  ';

  strSQL := strSQL + fRetCampoGER_TOTPRO(strCadRec);

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('AGR.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL +    fRetSQLMovger(True);

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('AGR.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('AGR.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  strSQL := strSQL + ' HAVING  ';

  strSQL := strSQL + '   (CTR_DOCCNF IS NULL)            ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDiretoAberto(strCadRec,
  strDupAgr: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                   ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                           ';
  strSQL := strSQL + '   OPE_NOMOPE,                                         ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,                ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,                ';
  strSQL := strSQL + '   OPE_INTEXT,                                         ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2) AS CTR_ABERTO, ';
  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('AGR.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    ((CNF.CTR_DOCCNF IS NULL)) AND  ';

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAVEN IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('AGR.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';    

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE  ';


  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacao(strCadRec,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "CONFIRMAÇÃO DOCUMENTO" AS MODALIDADE,    ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,                               ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('CNF.') + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALORI, REC.CTR_VALORI) * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * CNF.CTR_FATCO2) AS CTR_VALDES, ';
//  strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.CTR_FATCO2) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
//    strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.CTR_FATCO2) AS CTR_RECCOM, '
    strSQL := strSQL + '   SUM(REC.CTR_VALORI * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
//    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * CNF.CTR_FATCO2) AS CTR_RECCOM, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALORI) * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

//  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0)) * CNF.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM((REC.CTR_VALORI - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0)' + ' - IFNULL(CNF.CTR_VALCBS,0) - IFNULL(CNF.CTR_VALIBS,0) - IFNULL(CNF.CTR_VAL_IS,0) - IFNULL(CNF.CTR_VALACE,0) - IFNULL(CNF.CTR_VALFRE,0) - IFNULL(CNF.CTR_VALFCP,0)) * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * CNF.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALORI * CNF.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALORI * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG, ';

  If opcVenRep in [opSupGeral, opSupRegional] Then
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, '
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, '
    End;
  End;

  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP) AS DOCUME,  ';

  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   CNF.CTR_CODCLI,         ';
  strSQL := strSQL + '   CNF.CTR_CODEMP,         ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF,       ';

  {************************************}
  {* CAMPOS PARA                      *}
  {* RESUMO POR MODALIDADE            *}
  {********************************MM**}
  strSQL := strSQL + '   SUM(REC.CTR_DINHEI * CNF.CTR_FATCO2) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQAVI * CNF.CTR_FATCO2) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQPRE * CNF.CTR_FATCO2) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CARTAO * CNF.CTR_FATCO2) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(REC.CTR_ORDPAG * CNF.CTR_FATCO2) AS ORDPAG,  ';
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * CNF.CTR_FATCO2) AS VALFIN,  ';

  strSQL := strSQL + fRetCampoGER_TOTPRO(strCadRec);

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.') ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL +    fRetSQLMovger(False);

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';


  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacaoAberto(strCadRec,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                          ';
  strSQL := strSQL + '   OPE_NOMOPE,                                        ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,               ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,               ';
  strSQL := strSQL + '   OPE_INTEXT,                                        ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,   ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * CNF.CTR_FATCO2) AS CTR_ABERTO,';
  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.') ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAVEN IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"  ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE  ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacao(
  strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "DIRETA" AS MODALIDADE,                   ';
  strSQL := strSQL + '   ' + fGetVenDig('REC.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,                               ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('REC.') + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(IFNULL(REC.CTR_VALJUR,0),0) + IFNULL(IFNULL(REC.CTR_VALDES,0),0), REC.CTR_VALORI)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALORI, REC.CTR_VALORI)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0)) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0), 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0))) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0)) AS CTR_VALDES, ';
//  strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_VALREC,           ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI) AS CTR_VALREC,           ';

  If FConJur Then
//    strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_RECCOM, '
    strSQL := strSQL + '   SUM(REC.CTR_VALORI) AS CTR_RECCOM, '
  Else
//    strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) AS CTR_RECCOM, ';
    strSQL := strSQL + '   SUM(REC.CTR_VALORI) AS CTR_RECCOM, ';

//  strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0)) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0) - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0) - IFNULL(REC.CTR_VALFCP,0)) AS CTR_RECIPI, ';

//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.CTR_VALREC,0)) AS CTR_AVISTA, ';
//  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.CTR_VALREC)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.CTR_VALORI,0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.CTR_VALORI)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG,              ';

  If opcVenRep in [opSupGeral, opSupRegional] Then
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM(REC.CTR_VALREC * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALORI * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALORI * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

//      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALORI) * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End;
  End;

  strSQL := strSQL + '   "" AS DOCUME,           ';

  strSQL := strSQL + '   REC.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   REC.CTR_CODCLI,         ';
  strSQL := strSQL + '   REC.CTR_CODEMP,         ';

  strSQL := strSQL + '   CTRCNF.CTR_DOCCNF  AS CTR_DOCCNF,  ';

  {************************************}
  {* CAMPOS PARA                      *}
  {* RESUMO POR MODALIDADE            *}
  {********************************MM**}
  strSQL := strSQL + '   SUM(REC.CTR_DINHEI) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQAVI) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQPRE) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CARTAO) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(REC.CTR_ORDPAG) AS ORDPAG,  ';
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN) AS VALFIN,  ';

  strSQL := strSQL + fRetCampoGER_TOTPRO(strTabela);

  strSQL := strSQL + '   "' + strtabela + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('REC.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + fRetSQLMovger(False);

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"    AND ';

  strSQL := strSQL + fRetFiltroData(strTabela);

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('REC.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('REC.') + '," - ",OPE_NOMOPE),                             ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto(
  strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                        ';
  strSQL := strSQL + '   OPE_NOMOPE,                                      ';
  strSQL := strSQL + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,             ';
  strSQL := strSQL + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,             ';
  strSQL := strSQL + '   OPE_INTEXT,                                      ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP) AS CTR_ABERTO,                ';
  strSQL := strSQL + '   "' + strTabela + '" TABCTR ';  

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('REC.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAVEN IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('REC.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE    ';

  Result := strSQL;
end;

function TValorRecebido.fGetVenDig(strAlias: String): String;
begin
  Case opcVenRep Of
    opVendedor:      Result := ' ' + strAlias + 'CTR_CODVEN ';
    opRepresentante: Result := ' ' + strAlias + 'CTR_CODREP ';
    opSupGeral:      Result := ' CLI_SUPGER ';
    opSupRegional:   Result := ' CLI_SUPREG ';
    opVenCadCli:     Result := ' CLI_CODVEN ';
    opDigitador:     Result := ' ' + strAlias + 'CTR_CODDIG ';
  End;
end;

function TValorRecebido.fGetVenDigDet: String;
begin
  Case opcVenRep Of
    opVendedor:      Result := ' DET_CODVEN ';
    opRepresentante: Result := ' DET_CODREP ';
    opSupGeral:      Result := ' CLI_SUPGER ';
    opSupRegional:   Result := ' CLI_SUPREG ';
    opVenCadCli:     Result := ' CLI_CODVEN ';
    opDigitador:     Result := ' DET_CODDIG ';
  End;
end;

function TValorRecebido.fGetFatCom: String;
begin
  {****************************************}
  {* DIGITADOR IGUAL AO SUPERVISOR.       *}
  {* SOLICITADO PELO RONALDO - 23/01/2013 *}
  {**************************************FC}
  Case opcVenRep Of
    opVendedor:      Result := 'CTR_FATCOM';
    opRepresentante: Result := 'CTR_FATREP';
    opSupGeral,
    opSupRegional:   Result := '1';
    opDigitador,
    opVenCadCli:     Result := 'CTR_FATCOM';
  End;
end;

function TValorRecebido.fGetQtdParcelasCtr(strTabela: String): String;
begin
  Result := '';
  Result := Result + '(';
  Result := Result + 'SELECT ';
  Result := Result + '  IF(IFNULL(COUNT(*), 0) = 0, 1, COUNT(*)) AS QTDPAR ';
  Result := Result + 'FROM   ';
  Result := Result +    strTabela + ' TT ';
  Result := Result + 'WHERE  ';
  Result := Result + '  TT.CTR_NUMDUP = REC.CTR_NUMDUP AND ';
  Result := Result + '  TT.CTR_ESPDOC = REC.CTR_ESPDOC AND ';
  Result := Result + '  TT.CTR_CODEMP = REC.CTR_CODEMP AND ';
  Result := Result + '  TT.CTR_CODCLI = REC.CTR_CODCLI     ';
  Result := Result + ')';
end;

function TValorRecebido.fRetFiltroCliente: String;
begin
  Result := ' REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
end;

function TValorRecebido.fRetFiltroData(strTabela: String): String;
begin

  Result := '';

  If (blnUltPar) Then
  Begin
    {********************************************}
    {* IRÁ CONSIDERAR A DATA DO VENCIMENTO DA   *}
    {* ULTIMA PARCELA PARA O FILTRO DO PERIODO. *}
    {*****************************************PZ*}
    Result := Result + '  (((SELECT                                     ';
    Result := Result + '       IFNULL(MAX(TT.CTR_DTAVEN), 0) AS MAXDTA  ';
    Result := Result + '     FROM                                       ';
    Result := Result +         strTabela + ' TT                         ';
    Result := Result + '     WHERE                                      ';
    Result := Result + '       TT.CTR_NUMDUP = REC.CTR_NUMDUP AND       ';
    Result := Result + '       TT.CTR_ESPDOC = REC.CTR_ESPDOC AND       ';
    Result := Result + '       TT.CTR_CODEMP = REC.CTR_CODEMP  AND      ';
    Result := Result + '       TT.CTR_CODCLI = REC.CTR_CODCLI           ';
    Result := Result + '      ) BETWEEN  ' + fCurrentDate(StrToDateDef(strDtaIni, 0)) + ' AND ' + fCurrentDate(StrToDateDef(strDtaFim, 0)) + ')) ';

    //Result := Result + '      AND                                       ';

    {************************************************}
    {* VERIFICA SE TODAS AS PARCELAS ESTÃO QUITADAS *}
    {*********************************************PZ*}
    {Result := Result + '  ((SELECT                                     ';
    Result := Result + '      IFNULL(COUNT(*), 0) AS QTDREG            ';
    Result := Result + '    FROM                                       ';
    Result := Result +        strTabela + ' TT                         ';
    Result := Result + '    WHERE                                      ';
    Result := Result + '      TT.CTR_NUMDUP = REC.CTR_NUMDUP AND       ';
    Result := Result + '      TT.CTR_ESPDOC = REC.CTR_ESPDOC AND       ';
    Result := Result + '      TT.CTR_CODEMP = REC.CTR_CODEMP  AND      ';
    Result := Result + '      TT.CTR_CODCLI = REC.CTR_CODCLI  AND      ';
    Result := Result + '      IFNULL(TT.CTR_DTAREC, 0) = 0) = 0))      ';}

  End
  Else
    Result := '    REC.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM  ';
end;

function TValorRecebido.fRetSQLMovger(blnAgrupa: Boolean): String;
begin

  Result := '';

  If (Not FUltPar) Then
    Exit;

  Result := Result + ' LEFT JOIN MOVGER G ON G.GER_NUMDOC = REC.CTR_NUMDUP AND  ';
  Result := Result + '                       G.GER_ESPDOC = REC.CTR_ESPDOC AND  ';
  Result := Result + '                       G.GER_CODEMP = REC.CTR_CODEMP AND  ';
  Result := Result + '                       G.GER_CODCLI = REC.CTR_CODCLI      ';

  Result := Result + ' LEFT JOIN NOTGER N ON N.GER_NUMDOC = REC.CTR_NUMDUP AND  ';
  Result := Result + '                       N.GER_ESPDOC = REC.CTR_ESPDOC AND  ';
  Result := Result + '                       N.GER_CODEMP = REC.CTR_CODEMP AND  ';
  Result := Result + '                       N.GER_CODCLI = REC.CTR_CODCLI      ';

  If (blnAgrupa) Then
    Result := AnsiReplaceStr(Result, 'REC.', 'AGR.');

end;

function TValorRecebido.fRetCampoGER_TOTPRO(strTabela: String): String;
begin
  If (Not FUltPar) Then
  Begin
    Result := '  0 AS GER_TOTPRO, ';
    Exit;
  End;

  Result := ' (ROUND(COALESCE(G.GER_TOTPRO, N.GER_TOTPRO, 0) / ' + fGetQtdParcelasCtr(strTabela) + ', 2)) AS GER_TOTPRO, ';
end;

end.
