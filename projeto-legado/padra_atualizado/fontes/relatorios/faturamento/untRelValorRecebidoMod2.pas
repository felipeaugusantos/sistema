unit untRelValorRecebidoMod2;

interface

uses SysUtils, UniClientDataSet, Uni, Classes, untTypesSistema;

Type
  TRelacionamentoEmpresa = (reMovimentacao, reVendedor);

Type
  TValorRecebido = class(TObject)
    private
      FCodVen: String;
      FCodEmp: String;
      FPosCom: Integer;
      FConJur: Boolean;
      FRelEmp: TRelacionamentoEmpresa;
      FRelCt2: String;
      FDocCom: Boolean;
      FVenRep: TOpVendedorRepresentante;
      function fImpostos(strAbrevTab: String): String;
      function fGetSomaCampos(arrImp: array of String; strAbrevTab: String): String;
      function fRetFiltroCliente: String;
      function getVenRep: TOpVendedorRepresentante;
      procedure setVenRep(Value: TOpVendedorRepresentante);
    public

      Constructor Create;

      function fGetVenDig: String;
      function fGetVenDigDet: String;
      function fGetCampoValRec(blnDeduzImposto: Boolean = True): String;
      function fGetCampoDinheiro(strAbr: String): String;
      function fGetCampoFator: String;

      function fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String; intNotSer : Integer = 2): String;
      function fGetSqlComConfirmacao(strCadRec, strCtrCnf: String; intNotSer : Integer = 2): String;
      function fGetSqlComAgrupamentoDireto(strCadRec, strDupAgr: String; intNotSer : Integer = 2): String;
      function fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2): String;

      function fGetSqlSemAgrupamentoNemConfirmacaoAberto(strTabela: String; intNotSer : Integer = 2): String;
      function fGetSqlComConfirmacaoAberto(strCadRec, strCtrCnf: String; intNotSer : Integer = 2): String;
      function fGetSqlComAgrupamentoDiretoAberto(strCadRec, strDupAgr: String; intNotSer : Integer = 2): String;
      function fGetSqlAgrupamentoConfirmacaoAberto(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2): String;

      property strCodVen: String Read FCodVen Write FCodVen;
      property strCodEmp: String Read FCodEmp Write FCodEmp;
      property intPosCom: Integer Read FPosCom Write FPosCom;
      property blnConJur: Boolean Read FConJur Write FConJur;
      property relRelEmp: TRelacionamentoEmpresa Read FRelEmp Write FRelEmp;
      property strRelCt2: String Read FRelCt2 Write FRelCt2;
      property blnDocCom: Boolean Read FDocCom Write FDocCom;
      property opcVenRep: TOpVendedorRepresentante Read getVenRep Write setVenRep;
    End;

Const
  POSCOM_TODAS = 0;
  POSCOM_PENDENTES = 1;
  POSCOM_BAIXADAS = 2;    

implementation

uses untFuncoesSimples;

{ TValorRecebido }

constructor TValorRecebido.Create;
begin
  strCodVen := '';
  strCodEmp := '';
  relRelEmp := reMovimentacao;
  strRelCt2 := '';
  blnDocCom := False;
  FVenRep := opVendedor;
end;

function TValorRecebido.fGetCampoDinheiro(strAbr: String): String;
begin
  Result := '(IFNULL('+strAbr+'CTR_VALREC,0) - IFNULL('+strAbr+'CTR_CHQAVI,0) - IFNULL('+strAbr+'CTR_CHQPRE,0) - IFNULL('+strAbr+'CTR_CARTAO,0))';
end;

function TValorRecebido.fGetCampoFator: String;
begin
  Case FVenRep Of
    opVendedor      : Result := 'CTR_FATCOM';
    opRepresentante : Result := 'CTR_FATREP';
    opQuimico       : Result := 'CTR_FATQUI';
    opGerente       : Result := 'CTR_FATGER';
  End;
end;

function TValorRecebido.fGetCampoValRec(blnDeduzImposto: Boolean = True): String;
begin
  If FRelCt2 = '2' Then
  Begin
    If FConJur Then
    Begin
      If (blnDeduzImposto) Then
        Result := fGetCampoDinheiro('REC.') + ' - (' + fImpostos('REC.') + ')'
      Else
        Result := fGetCampoDinheiro('REC.');
    End
    Else
    Begin
      If (blnDeduzImposto) Then
        Result := ' IFNULL(( '+ fGetCampoDinheiro('REC.') +' - ( IFNULL(REC.CTR_VALJUR,0) * ( '+fGetCampoDinheiro('REC.')+' / IFNULL(REC.CTR_VALREC,0)))),0) - (' + fImpostos('REC.') + ')'
      Else
        Result := ' IFNULL(( '+ fGetCampoDinheiro('REC.') +' - ( IFNULL(REC.CTR_VALJUR,0) * ( '+fGetCampoDinheiro('REC.')+' / IFNULL(REC.CTR_VALREC,0)))),0) ';
    End;
  End
  Else
  Begin
    If FConJur Then
      Result := 'REC.CTR_VALREC'
    Else
      Result := '(REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR, 0))';
  End;
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr,
  strCtrCnf: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + ' SELECT                                     ';
  strSQL := strSQL + '   "AGRUPAMENTO CONFIRMAÇÃO" AS MODALIDADE, ';
  strSQL := strSQL + '   CNF.' + fGetVenDig + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,     ';
  strSQL := strSQL + '   REC.CTR_ESPDOC, ';
  strSQL := strSQL + '   CONCAT(CNF.' + fGetVenDig + ',"-",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTAREC, ';
  strSQL := strSQL + '   REC.CTR_DTACAD, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALJUR * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALJUR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDES * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALDES, ';

  strSQL := strSQL + '   SUM((' + fGetCampoValRec(False) + ') * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM(('+ fGetCampoValRec +') * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, ';
  strSQL := strSQL + '   SUM(('+ fGetCampoValRec +') * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, ('   + fGetCampoValRec + ') * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, 0, ('+ fGetCampoValRec + ') * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(('+ fGetCampoValRec + ') * AGR.CTR_FATCO2 * CNF.' + fGetCampoFator + ') AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,"A","P") AS CTR_FORMAPG, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP,"-",CNF.CTR_SEQBAI) AS DOCUME,  ';
  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';

  strSQL := strSQL + '   CNF.CTR_CODCLI, ';
  strSQL := strSQL + '   CNF.CTR_CODEMP, ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF, ';

  strSQL := strSQL + '   "'+ strCadRec +'" AS TABCTR, ';
  strSQL := strSQL + '   "' + strCadRec + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CNF.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente + ' AND ';

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC = "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(CNF.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CNF.' + fGetVenDig + ',                                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI), ';
  strSQL := strSQL + '   DOCUME                                                                           ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING VALOR_COMISSAO <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacaoAberto(strCadRec,
  strDupAgr, strCtrCnf: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                                               ';
//  strSQL := strSQL + '  DISTINCT  REC.CTR_NUMDUP, REC.CTR_CODEMP,  REC.CTR_ESPDOC, REC.CTR_PARCEL, ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                                           ';
  strSQL := strSQL + '   OPE_NOMOPE,                                                         ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR,                    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_ABERTO ';
//  strSQL := strSQL + '   REC.CTR_VALDUP AS CTR_ABERTO ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CNF.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC = "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + ' AND   AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + ' AND   AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(CNF.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE    ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDireto(strCadRec,
  strDupAgr: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT                                ';
  strSQL := strSQL + '   "AGRUPAMENTO DIRETO" AS MODALIDADE, ';
  strSQL := strSQL + '   AGR.' + fGetVenDig + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,     ';
  strSQL := strSQL + '   REC.CTR_ESPDOC, ';
  strSQL := strSQL + '   CONCAT(AGR.' + fGetVenDig + ',"-",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTAREC, ';
  strSQL := strSQL + '   REC.CTR_DTACAD, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * AGR.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALJUR * AGR.CTR_FATCO2) AS CTR_VALJUR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDES * AGR.CTR_FATCO2) AS CTR_VALDES, ';

  strSQL := strSQL + '   SUM((' + fGetCampoValRec(False) + ') * AGR.CTR_FATCO2) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * AGR.CTR_FATCO2) AS CTR_RECCOM, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * AGR.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, ('+ fGetCampoValRec + ') * AGR.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, 0, (' + fGetCampoValRec + ') * AGR.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * AGR.' + fGetCampoFator + ') AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,"A","P") AS CTR_FORMAPG, ';
  strSQL := strSQL + '   CONCAT(AGR.CTR_NUMDUP,"-",AGR.CTR_PARCEL,"-",AGR.CTR_ESPDOC,"-",AGR.CTR_CODEMP,"-",AGR.CTR_SEQBAI) AS DOCUME,  ';
  strSQL := strSQL + '   AGR.CTR_DTACAD AS DATA, ';

  strSQL := strSQL + '   AGR.CTR_CODCLI, ';
  strSQL := strSQL + '   AGR.CTR_CODEMP, ';

  strSQL := strSQL + '   CNF.CTR_DOCCNF  AS CTR_DOCCNF, ';
  strSQL := strSQL + '   "'+ strCadRec +'" AS TABCTR, ';
  strSQL := strSQL + '   "' + strCadRec + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON                  ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = AGR.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE                                            ';

  strSQL := strSQL + fRetFiltroCliente + ' AND ';

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC = "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;


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
    strSQL := strSQL + '  AND LOCATE(AGR.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   AGR.' + fGetVenDig + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI), ';
  strSQL := strSQL + '   DOCUME                                                                           ';

  strSQL := strSQL + ' HAVING  ';

  strSQL := strSQL + '  ((CTR_DOCCNF IS NULL))            ';

  If blnDocCom Then
    strSQL := strSQL + ' AND VALOR_COMISSAO <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDiretoAberto(strCadRec,
  strDupAgr: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                                ';
//  strSQL := strSQL + '  DISTINCT  REC.CTR_NUMDUP, REC.CTR_CODEMP,  REC.CTR_ESPDOC, REC.CTR_PARCEL, ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                           ';
  strSQL := strSQL + '   OPE_NOMOPE,                                         ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR,    ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2) AS CTR_ABERTO  ';
//  strSQL := strSQL + '   REC.CTR_VALDUP AS CTR_ABERTO  ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON                  ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = AGR.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE                                            ';

  strSQL := strSQL + '    ((CNF.CTR_DOCCNF IS NULL)) AND  ';

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC = "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(AGR.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE  ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacao(strCadRec, strCtrCnf: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   "CONFIRMAÇÃO DOCUMENTO" AS MODALIDADE, ';
  strSQL := strSQL + '   CNF.' + fGetVenDig + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,     ';
  strSQL := strSQL + '   REC.CTR_ESPDOC, ';
  strSQL := strSQL + '   CONCAT(CNF.' + fGetVenDig + ',"-",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTAREC, ';
  strSQL := strSQL + '   REC.CTR_DTACAD, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI * CNF.CTR_FATCO2) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALJUR * CNF.CTR_FATCO2) AS CTR_VALJUR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDES * CNF.CTR_FATCO2) AS CTR_VALDES, ';

  strSQL := strSQL + '   SUM((' + fGetCampoValRec(False) + ') * CNF.CTR_FATCO2) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * CNF.CTR_FATCO2) AS CTR_RECCOM, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * CNF.CTR_FATCO2) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, (' + fGetCampoValRec + ') * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, 0, (' + fGetCampoValRec + ') * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(('+ fGetCampoValRec + ') * CNF.' + fGetCampoFator + ') AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,"A","P") AS CTR_FORMAPG, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP,"-",CNF.CTR_SEQBAI) AS DOCUME,  ';
  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';

  strSQL := strSQL + '   CNF.CTR_CODCLI, ';
  strSQL := strSQL + '   CNF.CTR_CODEMP, ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF, ';
  strSQL := strSQL + '   "'+ strCadRec +'" AS TABCTR, ';
  strSQL := strSQL + '   "' + strCadRec + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON                  ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CNF.' + fGetVenDig ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente + ' AND ';

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM  AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(CNF.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CNF.' + fGetVenDig + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI), ';
  strSQL := strSQL + '   DOCUME                                                                           ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING VALOR_COMISSAO <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacaoAberto(strCadRec,
  strCtrCnf: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

//  strSQL := strSQL + '  DISTINCT  REC.CTR_NUMDUP, REC.CTR_CODEMP,  REC.CTR_ESPDOC, REC.CTR_PARCEL, ';

  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                          ';
  strSQL := strSQL + '   OPE_NOMOPE,                                        ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR,   ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP * CNF.CTR_FATCO2) AS CTR_ABERTO ';

//  strSQL := strSQL + '   REC.CTR_VALDUP AS CTR_ABERTO ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON                  ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CNF.' + fGetVenDig ;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"  ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(CNF.' + fGetVenDig + ', :CODVEN) > 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE  ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                    ';
  strSQL := strSQL + '   "DIRETA" AS MODALIDADE, ';
  strSQL := strSQL + '   REC.' + fGetVenDig + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   OPE_NOMOPE,     ';
  strSQL := strSQL + '   REC.CTR_ESPDOC, ';
  strSQL := strSQL + '   CONCAT(REC.' + fGetVenDig + ',"-",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTAREC, ';
  strSQL := strSQL + '   REC.CTR_DTACAD, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALORI) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALJUR) AS CTR_VALJUR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDES) AS CTR_VALDES, ';

  strSQL := strSQL + '   SUM( ' + fGetCampoValRec(False) + ' ) AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM( ' + fGetCampoValRec + ' ) AS CTR_RECCOM, ';
  strSQL := strSQL + '   SUM( ' + fGetCampoValRec + ' ) AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, ' + fGetCampoValRec + ', 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAVEN, 0, ' + fGetCampoValRec + ' )) AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM((' + fGetCampoValRec + ') * REC.' + fGetCampoFator + ') AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,"A","P") AS CTR_FORMAPG, ';
  strSQL := strSQL + '   "" AS DOCUME,  ';

  strSQL := strSQL + '   REC.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   REC.CTR_CODCLI, ';
  strSQL := strSQL + '   REC.CTR_CODEMP, ';

  strSQL := strSQL + '   CTRCNF.CTR_DOCCNF  AS CTR_DOCCNF, ';
  strSQL := strSQL + '   "'+ strTabela+'" AS TABCTR, ';

  strSQL := strSQL + '   "' + strTabela + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = REC.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ON                      ';
  strSQL := strSQL + '    REC.CTR_CODCLI = MOVGER.GER_CODCLI AND ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = MOVGER.GER_NUMDOC AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = MOVGER.GER_ESPDOC AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = MOVGER.GER_CODEMP     ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente + ' AND ';

  strSQL := strSQL + '    IFNULL(MOVGER.GER_CODFPG, "") NOT IN ("007","002","006") AND ';

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG" ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exceto Notas de Serviço
  End;


  strSQL := strSQL + '  AND  REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM ';

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
    strSQL := strSQL + '  AND LOCATE(REC.' + fGetVenDig + ', :CODVEN) > 0 ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CONCAT(REC.' + fGetVenDig + ',"-",OPE_NOMOPE),                                         ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP,"-",REC.CTR_SEQBAI), ';
  strSQL := strSQL + '   DOCUME                                                                           ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING VALOR_COMISSAO <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto( strTabela: String; intNotSer : Integer = 2): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                             ';
//  strSQL := strSQL + '  DISTINCT  REC.CTR_NUMDUP, REC.CTR_CODEMP,  REC.CTR_ESPDOC, REC.CTR_PARCEL, ';
  strSQL := strSQL + '   OPE_CODOPE AS CTR_CODVEN,                        ';
  strSQL := strSQL + '   OPE_NOMOPE,                                      ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALDUP) AS CTR_ABERTO                ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = REC.' + fGetVenDig;
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG" ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

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
    strSQL := strSQL + '  AND LOCATE(REC.' + fGetVenDig + ', :CODVEN) > 0 ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';
  
  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   OPE_CODOPE    ';

  Result := strSQL;
end;

function TValorRecebido.fGetVenDig: String;
begin
  Case FVenRep Of
    opVendedor      : Result := 'CTR_CODVEN';
    opRepresentante : Result := 'CTR_CODREP';
    opQuimico       : Result := 'CTR_CODQUI';
    opGerente       : Result := 'CTR_CODGER';
  End;
end;

function TValorRecebido.fGetVenDigDet: String;
begin
  Case FVenRep Of
    opVendedor      : Result := 'DET_CODVEN';
    opRepresentante : Result := 'DET_CODREP';
    opQuimico       : Result := 'DET_CODQUI';
    opGerente       : Result := 'DET_CODGER';
  End;
end;

function TValorRecebido.fImpostos(strAbrevTab: String): String;
  Var
    strTmpAbrevTab : String;
begin
  strTmpAbrevTab := strAbrevTab;

  If FRelCt2 = '2' Then
  Begin
    Result :=          ' IFNULL( ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALIPI,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALRET,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALCBS,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALIBS,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VAL_IS,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALACE,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALFRE,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))) +  ';
    Result := Result + ' (IFNULL('+strTmpAbrevTab+'CTR_VALFCP,0) * ('+ fGetCampoDinheiro(strTmpAbrevTab) +' / IFNULL('+strTmpAbrevTab+'CTR_VALREC,0))),0) ';
  End
  Else
    Result := fGetSomaCampos(['CTR_VALIPI', 'CTR_VALRET', 'CTR_VALCBS', 'CTR_VALIBS', 'CTR_VAL_IS', 'CTR_VALACE', 'CTR_VALFRE', 'CTR_VALFCP'], strAbrevTab);
end;

function TValorRecebido.fRetFiltroCliente: String;
begin
  Result := ' REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';
end;

function TValorRecebido.getVenRep: TOpVendedorRepresentante;
begin
  Result := FVenRep;
end;

procedure TValorRecebido.setVenRep(Value: TOpVendedorRepresentante);
begin
  FVenRep := Value;
end;

function TValorRecebido.fGetSomaCampos(arrImp: Array Of String; strAbrevTab: String): String;
  Var
    strImp: String;
begin
  For strImp In arrImp Do
    Result := Result + IIF(fEmptyStr(Result), '', ' + ') + ' IFNULL(' + IIF(fEmptyStr(strAbrevTab), '', strAbrevTab + '.') + strImp + ', 0)';
end;

end.
