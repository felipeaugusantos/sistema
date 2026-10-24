unit untRelValorRecebidoProfissional;

interface

uses SysUtils;

Type
  TPosicaoComissao = (tcTodas, tcPendentes, tcBaixadas, tcNaoInformado);

Type
  TValorRecebidoProfissional = class(TObject)
    private
      FConJur   : Boolean;
      FCodPro   : String;
      FStaPro   : String;
      FCodEmp   : String;
      FPosCom   : TPosicaoComissao;

      function fRetFiltroCliente: String;
      function fGetFiltroPosicaoComissao: String;
      function fGetModConfirmacaoDocumento: String;
    public

      Constructor Create;

      function fGetPro(strAlias: String): String;
      function fGetProDet: String;
      function fGetFatCom: String;

      function fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String): String;
      function fGetSqlComConfirmacao(strCadRec, strCtrCnf: String): String;
      function fGetSqlComAgrupamentoDireto(strCadRec, strDupAgr: String): String;
      function fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr, strCtrCnf: String): String;

      function fGetSqlSemAgrupamentoNemConfirmacaoAberto(strTabela: String): String;
      function fGetSqlComConfirmacaoAberto(strCadRec, strCtrCnf: String): String;
      function fGetSqlComAgrupamentoDiretoAberto(strCadRec, strDupAgr: String): String;
      function fGetSqlAgrupamentoConfirmacaoAberto(strCadRec, strDupAgr, strCtrCnf: String): String;

      property strCodPro: String Read FCodPro Write FCodPro;
      property strStaPro: String Read FStaPro Write FStaPro;
      property strCodEmp: String Read FCodEmp Write FCodEmp;
      property blnConJur: Boolean                  Read FConJur Write FConJur;
      property pcPosCom : TPosicaoComissao Read FPosCom Write FPosCom;
      property strModConfirmacaoDocumento: String read fGetModConfirmacaoDocumento;
    End;

implementation

uses untFuncoesSimples;

{ TValorRecebidoProfissional }

function TValorRecebidoProfissional.fGetModConfirmacaoDocumento: String;
begin
  Result := 'CONFIRMAÇÃO DOCUMENTO';
end;

constructor TValorRecebidoProfissional.Create;
begin
  strCodPro    := '';
  strStaPro    := '';
  strCodEmp    := '';
end;

function TValorRecebidoProfissional.fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT  SQL_NO_CACHE                       ';
  strSQL := strSQL + '   "AGRUPAMENTO CONFIRMAÇÃO" AS MODALIDADE, ';
  strSQL := strSQL + '  ' + fGetPro('CNF.') + ' AS CTR_CODDIV, ';
  strSQL := strSQL + '   DIV_NOMDIV,                              ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,     ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                          ';
  strSQL := strSQL + '   CONCAT(' + fGetPro('CNF.') + '," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0)' + ' - IFNULL(CNF.CTR_VALCBS,0) - IFNULL(CNF.CTR_VALIBS,0) - IFNULL(CNF.CTR_VAL_IS,0) - IFNULL(CNF.CTR_VALACE,0) - IFNULL(CNF.CTR_VALFRE,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG, ';

  If FConJur Then
  Begin
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
  End
  Else
  Begin
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
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
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS VALFIN   ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODCLI = CNF.CTR_CLICNF        ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('CNF.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('CNF.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetPro('CNF.') + ',                                                      ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlAgrupamentoConfirmacaoAberto(strCadRec,
  strDupAgr, strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                                   ';
  strSQL := strSQL + '   DIV_CODDIV AS CTR_CODDIV,                                           ';
  strSQL := strSQL + '   DIV_NOMDIV,                                                         ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,                                ';
  strSQL := strSQL + '   CONCAT(DIV_CODDIV," - ",DIV_NOMDIV) AS PROFISSIONAL,                    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_ABERTO ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('CNF.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('CNF.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   DIV_CODDIV    ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlComAgrupamentoDireto(strCadRec,
  strDupAgr: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "AGRUPAMENTO DIRETO" AS MODALIDADE,       ';
  strSQL := strSQL + '   ' + fGetPro('AGR.') + ' AS CTR_CODDIV, ';
  strSQL := strSQL + '   DIV_NOMDIV,                               ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,      ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetPro('AGR.') + '," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2) AS CTR_VALREC,           ';

  If blnConJur Then
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(AGR.CTR_VALIPI,0) - IFNULL(AGR.CTR_VALRET,0) - IFNULL(AGR.CTR_VALCBS,0) - IFNULL(AGR.CTR_VALIBS,0) - IFNULL(AGR.CTR_VAL_IS,0) - IFNULL(AGR.CTR_VALACE,0) - IFNULL(AGR.CTR_VALFRE,0)) * AGR.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * AGR.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * AGR.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG,                                 ';

  If FConJur Then
  Begin
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM(REC.CTR_VALREC * AGR.CTR_FATCO2 * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
  End
  Else
  Begin
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, '
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
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * AGR.CTR_FATCO2) AS VALFIN   ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODCLI = CNF.CTR_CLICNF     ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('AGR.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('AGR.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetPro('AGR.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  strSQL := strSQL + ' HAVING  ';

  strSQL := strSQL + '  ((CTR_DOCCNF IS NULL))            ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlComAgrupamentoDiretoAberto(strCadRec,
  strDupAgr: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                   ';
  strSQL := strSQL + '   DIV_CODDIV AS CTR_CODDIV,                           ';
  strSQL := strSQL + '   DIV_NOMDIV,                                         ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,                ';
  strSQL := strSQL + '   CONCAT(DIV_CODDIV," - ",DIV_NOMDIV) AS PROFISSIONAL,    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2) AS CTR_ABERTO  ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('AGR.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    ((CNF.CTR_DOCCNF IS NULL)) AND  ';

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('AGR.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   DIV_CODDIV  ';


  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlComConfirmacao(strCadRec,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "CONFIRMAÇÃO DOCUMENTO" AS MODALIDADE,    ';
  strSQL := strSQL + '   ' + fGetPro('CNF.') + ' AS CTR_CODDIV, ';
  strSQL := strSQL + '   DIV_NOMDIV,                               ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,      ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetPro('CNF.') + '," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * CNF.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(CNF.CTR_VALIPI,0) - IFNULL(CNF.CTR_VALRET,0) - IFNULL(CNF.CTR_VALCBS,0) - IFNULL(CNF.CTR_VALIBS,0) - IFNULL(CNF.CTR_VAL_IS,0) - IFNULL(CNF.CTR_VALACE,0) - IFNULL(CNF.CTR_VALFRE,0)) * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, REC.CTR_VALREC * CNF.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, REC.CTR_VALREC * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG, ';

  If FConJur Then
  Begin
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM(REC.CTR_VALREC * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
  End
  Else
  Begin
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, '
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
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN * CNF.CTR_FATCO2) AS VALFIN   ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('CNF.') ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM  AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"     ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('CNF.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetPro('CNF.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlComConfirmacaoAberto(strCadRec,
  strCtrCnf: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   DIV_CODDIV AS CTR_CODDIV,                          ';
  strSQL := strSQL + '   DIV_NOMDIV,                                        ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,               ';
  strSQL := strSQL + '   CONCAT(DIV_CODDIV," - ",DIV_NOMDIV) AS PROFISSIONAL,   ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * CNF.CTR_FATCO2) AS CTR_ABERTO ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('CNF.') ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"  ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('CNF.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   DIV_CODDIV  ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlSemAgrupamentoNemConfirmacao(
  strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "DIRETA" AS MODALIDADE,                   ';
  strSQL := strSQL + '   ' + fGetPro('REC.') + ' AS CTR_CODDIV, ';
  strSQL := strSQL + '   DIV_NOMDIV,                               ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,      ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetPro('REC.') + '," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0)) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0), 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0))) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0)) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_VALREC,           ';

  If FConJur Then
    strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0) - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0)) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.CTR_VALREC,0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.CTR_VALREC)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG,              ';

  If FConJur Then
  Begin
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM(REC.CTR_VALREC * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
  End
  Else
  Begin
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

    strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
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
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN) AS VALFIN   ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('REC.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"    AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('REC.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CONCAT(' + fGetPro('REC.') + '," - ",DIV_NOMDIV),                             ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetSqlSemAgrupamentoNemConfirmacaoAberto(
  strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                ';
  strSQL := strSQL + '   DIV_CODDIV AS CTR_CODDIV,                        ';
  strSQL := strSQL + '   DIV_NOMDIV,                                      ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,             ';
  strSQL := strSQL + '   CONCAT(DIV_CODDIV," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP) AS CTR_ABERTO                ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = ' + fGetPro('REC.');
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"        ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetPro('REC.') + ', :CODPRO) > 0 ';

  If (Not fEmptyStr(strStaPro)) Then
    strSQL := strSQL + '  AND DIV_STATUS = "' +strStaPro+ '" ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  strSQL := strSQL + fGetFiltroPosicaoComissao();

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   DIV_CODDIV    ';

  Result := strSQL;
end;

function TValorRecebidoProfissional.fGetPro(strAlias: String): String;
begin
  Result := ' ' + strAlias + 'CTR_CODDIV ';
end;

function TValorRecebidoProfissional.fGetProDet: String;
begin
  Result := ' DET_CODDIV ';
end;

function TValorRecebidoProfissional.fGetFatCom: String;
begin
  Result := 'CTR_FATDIV';
end;

function TValorRecebidoProfissional.fGetFiltroPosicaoComissao: String;
begin
  If (FPosCom = tcPendentes) Then
    Result := ' AND IFNULL(REC.CTR_CTPCOP, "") = "" '
  Else If (FPosCom = tcBaixadas) Then
    Result := ' AND IFNULL(REC.CTR_CTPCOP, "") <> "" '
  Else
    Result := ' ';
end;

function TValorRecebidoProfissional.fRetFiltroCliente: String;
begin
  Result := ' REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
end;

end.
