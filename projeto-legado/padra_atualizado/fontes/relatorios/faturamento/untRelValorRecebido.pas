unit untRelValorRecebido;

interface

uses SysUtils, untIValorRecebido, untInterfacedObjectNoCount, untTypesSistema,
     untConstantes;

Type
  TValorRecebido = class(TInterfacedObjectNoCount, IValorRecebido)
    private
      FConJur   : Boolean;
      FCodVen   : String;
      FCodGer   : String;      
      FStaVen   : String;
      FCodDep   : string;
      FCodEmp   : String;
      FRelMod   : String;
      FTipVenRep: String;
      FRelEmp   : TRelacionamentoEmpresa;
      FVenRep   : TOpVendedorRepresentante;
      FCodCli   : String;
      FCliExc   : String;
      FUltPar: Boolean;
      FDtaIni: String;
      FDtaFin: String;
      FPosCom: Integer;
      FDocCom: Boolean;
      FCampoComissao: String;
      FDepCod: String;
      blnListaAdtCli : Boolean;
      FblnCalcularPeloCadastroOperador: Boolean;
      FblnValorBaseLiquido: Boolean;
      function fGetModConfirmacaoDocumento: String;
      function fRetornaSQLItens(blnFatGor: Boolean = False): String;
      function fRetornaJoinItens(strMovDet: String): String;
      function fRetCndEhAVista(strAlias: String='REC'): String;
      function fRetCndEhAPrazo(strAlias: String='REC'): String;
      function fRetPeriodoData(strAlias: String='REC'): String;
      function fRetValorBase(blnValorLiquido: Boolean=False; strAlias: String='REC'): String;
    public

      Constructor Create;

      function fGetVenDig(strAlias: String): String;
      function fGetVenDigAdt: String;
      function fGetVenDigDet: String;
      function fGetFatCom: String;
      function fGetFatComAdt: String;

      function fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
      function fGetSqlComConfirmacao(strCadRec, strCtrCnf: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
      function fGetSqlComAgrupamentoDireto(strCadRec, strDupAgr: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
      function fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2;  intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
      function fGetSqlAdiantamentos(intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String;

      function fGetSqlSemAgrupamentoNemConfirmacaoAberto(strTabela: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
      function fGetSqlComConfirmacaoAberto(strCadRec, strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
      function fGetSqlComAgrupamentoDiretoAberto(strCadRec, strDupAgr: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
      function fGetSqlAgrupamentoConfirmacaoAberto(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

      function fRetFiltroCliente: String;
      function fRetFiltroData(strTabela: String): String;

      function getCodVen: String;
      procedure setCodVen(Value: String);

      function getCodEmp: String;
      procedure setCodEmp(Value: String);

      function getRelEmp: TRelacionamentoEmpresa;
      procedure setRelEmp(Value: TRelacionamentoEmpresa);

      function getVenRep: TOpVendedorRepresentante;
      procedure setVenRep(Value: TOpVendedorRepresentante);

      function getDepCod: String;

      procedure setDepCod(const Value: String);

      property strCodVen: String Read getCodVen Write setCodVen;
      property strCodGer: String Read FCodGer   Write FCodGer;
      property strStaVen: String Read FStaVen   Write FStaVen;
      property strCodDep: String Read FCodDep   Write FCodDep;
      property strCodEmp: String Read getCodEmp Write setCodEmp;
      property strCodCli: String Read FCodCli   Write FCodCli;
      property strCliExc: String Read FCliExc   Write FCliExc;

      property strDtaIni: String Read FDtaIni   Write FDtaIni;
      property strDtaFim: String Read FDtaFin   Write FDtaFin;

      property strTipVenRep: String Read FTipVenRep Write FTipVenRep;
      property relRelEmp: TRelacionamentoEmpresa   Read getRelEmp Write setRelEmp;
      property opcVenRep: TOpVendedorRepresentante Read getVenRep Write setVenRep;
      property blnConJur: Boolean                  Read FConJur Write FConJur;
      property blnUltPar: Boolean                  Read FUltPar Write FUltPar;
      property blnDocCom: Boolean                  Read FDocCom Write FDocCom;
      property strCampoComissao: String            Read FCampoComissao Write FCampoComissao;
      property strRelMod: String                   Read FRelMod Write FRelMod;
      property strDepCod: String  Read getDepCod Write setDepCod;

      property intPosCom: Integer Read FPosCom Write FPosCom;
      property strModConfirmacaoDocumento: String read fGetModConfirmacaoDocumento;
      property blnCalcularPeloCadastroOperador: Boolean Read FblnCalcularPeloCadastroOperador Write FblnCalcularPeloCadastroOperador;
      property blnValorBaseLiquido: Boolean Read FblnValorBaseLiquido Write FblnValorBaseLiquido;
      
    End;

Const
  POSCOM_TODAS = 0;
  POSCOM_PENDENTES = 1;
  POSCOM_BAIXADAS = 2;    

  STR_QTDITE = ' (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE)) ';
  STR_TOTCOM = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCOM, DET_TOTCOM)) ';
  STR_PERCOM = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IFNULL(DET_PERCOM, 0)) ';
  STR_TOTPRA = ' COALESCE((DET_TOTITE - DET_DESESP), 0) ';
  STR_PERDES = ' IF((((DET_UNIORI - ((DET_TOTITE - DET_DESESP) / DET_QTDITE)) / DET_UNIORI) * 100) <= 0, 0.00, (((DET_UNIORI - ((DET_TOTITE - DET_DESESP) / DET_QTDITE)) / DET_UNIORI) * 100)) ';
  STR_UNIPRA = ' COALESCE(((DET_TOTITE - DET_DESESP) / DET_QTDITE), 0) ';

implementation

uses untFuncoesSimples, StrUtils;

{ TValorRecebido }

constructor TValorRecebido.Create;
begin
  strCodVen    := '';
  strCodGer    := '';
  strStaVen    := '';
  strCodDep    := '';
  strCodEmp    := '';
  strDepCod    := '';
  strTipVenRep := '';
  relRelEmp    := reMovimentacao;

  strRelMod    := fCfgSis('RELCT2', varString);

  blnUltPar := False;
  blnDocCom := False;
  FCampoComissao := 'VALOR_COMISSAO';

  blnListaAdtCli := fCfgSis('ADCOCT', varBoolean);
  FblnCalcularPeloCadastroOperador := False;
  FblnValorBaseLiquido := False;
end;

function TValorRecebido.fRetCndEhAVista(strAlias: String='REC'): String;
begin
  Result := ' (.CTR_DTACAD = .CTR_DTAREC) ';
  If (strRelMod = '4') Then
    Result := ' ((.CTR_DTACAD = .CTR_DTAREC) AND (.CTR_DTABOL IS NULL)) ';
  Result := AnsiReplaceStr(Result, '.', strAlias+'.');
end;

function TValorRecebido.fRetCndEhAPrazo(strAlias: String='REC'): String;
begin
  Result := ' (.CTR_DTACAD <> .CTR_DTAREC) ';
  If (strRelMod = '4') Then
    Result := ' ((.CTR_DTACAD <> .CTR_DTAREC) OR (.CTR_DTABOL IS NOT NULL)) ';
  Result := AnsiReplaceStr(Result, '.', strAlias+'.');
end;

function TValorRecebido.fRetValorBase(blnValorLiquido: Boolean=False; strAlias: String='REC'): String;
  Var
    strValRec: String;
begin
  strValRec := ' (.CTR_VALREC) ';
  If blnValorLiquido Then
    strValRec :=  ' (.CTR_VALREC - IFNULL(.CTR_VALIPI,0) - IFNULL(.CTR_VALRET,0) - IFNULL(.CTR_VALCBS,0) - IFNULL(.CTR_VALIBS,0) - IFNULL(.CTR_VAL_IS,0) - IFNULL(.CTR_VALACE,0) - IFNULL(.CTR_VALFRE,0) - IFNULL(.CTR_VALFCP,0)) ';

  Result := strValRec;
  If (strRelMod = '4') Then
    Result := '(IF('+strValRec+' <> 0, '+strValRec+', IF(.CTR_DTABOL IS NOT NULL, .CTR_VALDUP, '+strValRec+')))';
  Result := AnsiReplaceStr(Result, '.', strAlias+'.');
end;

function TValorRecebido.fRetPeriodoData(strAlias: String='REC'): String;
begin
  Result := Result + ' .CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM ';
  If (strRelMod = '4') Then
    Result := ' ((.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM) OR (.CTR_DTABOL BETWEEN :DTAINI AND :DTAFIM)) ';
  Result := AnsiReplaceStr(Result, '.', strAlias+'.');
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr,
  strCtrCnf: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0;
  blnExibeItens: Boolean = False): String;
  Var
    strSQL,
    strNomCam: String;
Begin
  Case intRetSubGer Of
    1: strNomCam := 'OPE_CODGER';
    2: strNomCam := 'OPE_CODSUB';
  End;

  strSQL := '';

  strSQL := strSQL + ' SELECT  SQL_NO_CACHE                       ';
  strSQL := strSQL + '   "AGRUPAMENTO CONFIRMAÇÃO" AS MODALIDADE, ';
  strSQL := strSQL + '   REC.CTR_CTPCOM,                          ';
  strSQL := strSQL + '   COM.COM_CTPCOM,                          ';
  strSQL := strSQL + '   REC.AUTOINCREM AS CTR_AUTOINC,           ';
  strSQL := strSQL + '  ' + fGetVenDig('CNF.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE,                              ';
  strSQL := strSQL + '   V.OPE_CODDEP,                            ';

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,                 ';
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,                 ';
  End;

  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,     ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,     ';
  strSQL := strSQL + '   V.OPE_INTEXT,                              ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                          ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('CNF.') + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   REC.CTR_SEQBAI AS CTR_SEQBAI, ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(ROUND(IF(REC.CTR_SEQBAI = 0, '+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0)  - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 2)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM('+fRetValorBase+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
    strSQL := strSQL + '   SUM('+fRetValorBase+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0)' + ' - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0) - IFNULL(REC.CTR_VALFCP,0)) * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2, 0)) AS CTR_AVISTA_LIQ, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2 * CNF.CTR_FATCO2)) AS CTR_APRAZO_LIQ, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAPrazo+' AND REC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIM AND '+fRetPeriodoData+', '+fRetValorBase+' * CNF.CTR_FATCO2, 0)) AS CTR_FATREC, ';
  strSQL := strSQL + '   IF('+fRetCndEhAVista+',"A","P") AS CTR_FORMAPG, ';

  If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2 * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End;
  End;

  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP) AS DOCUME,  ';

  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   CNF.CTR_CODCLI, ';
  strSQL := strSQL + '   CNF.CTR_CODEMP, ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF, ';

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

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaSQLItens;

  strSQL := strSQL + ',   "' + strDupAgr + '" AS TABELAUPDATE ';

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
  If blnDocCom Then
    strSQL := strSQL + ' AND CNF.CTR_FATCOM > 0 ';

  strSQL := strSQL + '  LEFT JOIN AGRCOM COM ON ';
  strSQL := strSQL + '    COM.COM_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '    COM.COM_EMPAGR = REC.CTR_CODEMP AND ';
  strSQL := strSQL + '    COM.COM_PARAGR = REC.CTR_PARCEL AND ';
  strSQL := strSQL + '    COM.COM_CODCLI = CNF.CTR_CODCLI AND ';
  strSQL := strSQL + '    IFNULL(COM.COM_SEQBAI, 0) = IFNULL(REC.CTR_SEQBAI, 0) AND ';
  strSQL := strSQL + '    COM.COM_CHADUP = CONCAT(CNF.CTR_NUMDUP,"-", ';
  strSQL := strSQL + '                            CNF.CTR_PARCEL,"-", ';
  strSQL := strSQL + '                            CNF.CTR_ESPDOC,"-", ';
  strSQL := strSQL + '                            CNF.CTR_CODEMP) ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + fGetVenDig('CNF.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(V.OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADOPE G ON (G.OPE_CODOPE = V.' + strNomCam + ') ';
    strSQL := strSQL + '                      OR (G.OPE_CODOPE = V.OPE_CODOPE AND G.OPE_INTEXT = '+IfThen(intRetSubGer = 1,'"G"', '"S"')+')';
  end;

  If blnExibeItens Then
    strSQL := strSQL + fRetornaJoinItens('MOVDET');

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  {*********************************************************************}
  {* VERIFICA SE FILTRA POR DATA DE RECEBIMENTO DA ULTIMA PARCELA PAGA *}
  {******************************************************************PZ*}
  strSQL := strSQL + fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0  '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(V.OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ',                                                      ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';

  If blnExibeItens Then
    strSQL := strSQL + '   M.AUTOINCREM,   '
  Else
    strSQL := strSQL + '   DOCUME,   ';

  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  strSQL := strSQL + ' HAVING TRUE ';

  If blnDocCom Then
    strSQL := strSQL + ' AND '+FCampoComissao+' <> 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND CTR_CTPCOM IS NULL AND COM_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND (CTR_CTPCOM IS NOT NULL OR COM_CTPCOM IS NOT NULL) ';
  End;

  Result := strSQL;
end;

function TValorRecebido.fGetSqlAdiantamentos(intNotSer : Integer = 2; intRetSubGer : Integer = 0;
  blnExibeItens: Boolean = False): String;

  function fValLan: String;
  begin
    Result := 'IF(ADT_TIPLAN = "C", ADT_VALLAN, -ABS(ADT_VALLAN))';
  end;

  Var
    strSQL,
    strNomCam: String;
Begin
  Case intRetSubGer Of
    1: strNomCam := 'OPE_CODGER';
    2: strNomCam := 'OPE_CODSUB';
  End;

  strSQL := '';

  strSQL := strSQL + ' SELECT  SQL_NO_CACHE ';
  strSQL := strSQL + '   "ADIANTAMENTOS" AS MODALIDADE, ';
  strSQL := strSQL + '   NULL AS CTR_CTPCOM,            ';
  strSQL := strSQL + '   NULL AS COM_CTPCOM,            ';
  strSQL := strSQL + '   ADTCLI.AUTOINCREM AS CTR_AUTOINC,    ';
  strSQL := strSQL + '   ' + fGetVenDigAdt + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE, ';
  strSQL := strSQL + '   V.OPE_CODDEP, ';

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,                 ';
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,                 ';
  End;

  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,     ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,     ';
  strSQL := strSQL + '   V.OPE_INTEXT,                              ';
  strSQL := strSQL + '   ADT_ESPDOC AS CTR_ESPDOC, ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDigAdt + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   ADT_DTALAN AS CTR_DTACAD, ';
  strSQL := strSQL + '   ADT_DTALAN AS CTR_DTAREC, ';
  strSQL := strSQL + '   CONCAT(ADT_NUMDOC,"-","A","-",ADT_ESPDOC,"-",ADT_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   0 AS CTR_SEQBAI,  ';
  strSQL := strSQL + '   CONCAT(ADT_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_VALORI, ';
  strSQL := strSQL + '   0.00 AS CTR_VALJUR, ';
  strSQL := strSQL + '   0.00 AS CTR_JURVIS, ';
  strSQL := strSQL + '   0.00 AS CTR_JURPRA, ';
  strSQL := strSQL + '   0.00 AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_VALREC, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_RECCOM, ';
  strSQL := strSQL + '   0.00 AS CTR_RECIPI, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_AVISTA, ';
  strSQL := strSQL + '   0.00 AS CTR_APRAZO, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_AVISTA_LIQ, ';
  strSQL := strSQL + '   0.00 AS CTR_APRAZO_LIQ, ';
  strSQL := strSQL + '   SUM(' + fValLan + ') AS CTR_FATREC, ';
  strSQL := strSQL + '   "A" AS CTR_FORMAPG, ';

  If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
  Begin
    strSQL := strSQL + '   SUM(' + fValLan + ' * (V.OPE_PERCOM)) AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   0.00 AS VLCOM_OPEAPR, ';
    strSQL := strSQL + '   SUM(' + fValLan + ' * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
  End
  Else
  Begin
    strSQL := strSQL + '   SUM(' + fValLan + ' * ' + fGetFatComAdt + ') AS VLCOM_OPEAVI, ';
    strSQL := strSQL + '   0.00 AS VLCOM_OPEAPR, ';
    strSQL := strSQL + '   SUM(' + fValLan + ' * ' + fGetFatComAdt + ') AS VALOR_COMISSAO, ';
  End;

  strSQL := strSQL + '   "" AS DOCUME,  ';
  strSQL := strSQL + '   ADT_DTALAN AS DATA, ';
  strSQL := strSQL + '   ADT_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '   ADT_CODEMP AS CTR_CODEMP, ';
  strSQL := strSQL + '   "" AS CTR_DOCCNF, ';

  strSQL := strSQL + '   SUM(ADT_VALDIN) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(ADT_VALCHV) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(ADT_VALCHP) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(ADT_VALCAR) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(ADT_VALORD) AS ORDPAG,  ';
  strSQL := strSQL + '   0.00            AS VALFIN,  ';
  strSQL := strSQL + '   "ADTCLI" TABCTR ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaSQLItens(True);

  strSQL := strSQL + ',   "ADTCLI" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ADTCLI ';
  strSQL := strSQL + '  INNER JOIN FATGOR ON FGO_NUMDOC = ADT_NUMDOC ';
  strSQL := strSQL + '                   AND FGO_ESPDOC = ADT_ESPDOC ';
  strSQL := strSQL + '                   AND FGO_CODEMP = ADT_CODEMP ';
  strSQL := strSQL + '                   AND FGO_CODCLI = ADT_CODCLI ';
  strSQL := strSQL + '  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = ADT_CODCLI ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + fGetVenDigAdt + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(V.OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADOPE G ON (G.OPE_CODOPE = V.' + strNomCam + ') ';
    strSQL := strSQL + '                      OR (G.OPE_CODOPE = V.OPE_CODOPE AND G.OPE_INTEXT = '+IfThen(intRetSubGer = 1,'"G"', '"S"')+')';
  end;

  If blnExibeItens Then
    strSQL := strSQL + fRetornaJoinItens('FATDOR');

  strSQL := strSQL + '  WHERE ADT_ESPDOC =  "PD"  ';
  strSQL := strSQL + '    AND ADT_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '    AND ADT_DTALAN >= :DTACOR ';
  strSQL := strSQL + '    AND ADT_DTALAN BETWEEN :DTAINI AND :DTAFIM ';
  strSQL := strSQL + '    AND ((ADT_TIPLAN = "C") OR ((ADT_TIPLAN = "D") AND (ADT_ESTORN = "S"))) ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND ADT_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND ADT_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0  '
    Else
      strSQL := strSQL + '  AND LOCATE(ADT_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(ADT_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDigAdt + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(V.OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDigAdt + ',                                                      ';
  strSQL := strSQL + '   CONCAT(ADT_NUMDOC,"-","A","-",ADT_ESPDOC,"-",ADT_CODEMP), ';

  If blnExibeItens Then
    strSQL := strSQL + '   M.AUTOINCREM,   '
  Else
    strSQL := strSQL + '   DOCUME,   ';

  strSQL := strSQL + '   ADT_DTALAN ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING '+FCampoComissao+' <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlAgrupamentoConfirmacaoAberto(strCadRec,
  strDupAgr, strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

  function fGetFieldsSin: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE AS CTR_CODVEN,                                           ';
    Result := Result + '   OPE_NOMOPE,                                                         ';
    Result := Result + '   OPE_CODDEP,                                                         ';
    Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,                                ';
    Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,                                ';
    Result := Result + '   OPE_INTEXT,                                                         ';
    Result := Result + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,                    ';
    Result := Result + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS CTR_ABERTO,';
    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  function fGetFieldsAna: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE     AS CODVEN, ';
    Result := Result + '   OPE_NOMOPE     AS NOMVEN, ';
    Result := Result + '   CNF.CTR_DTACAD AS DTACAD, ';
    Result := Result + '   CNF.CTR_DTAVEN AS DTAVEN, ';
    Result := Result + '   CLI_CODCLI     AS CODCLI, ';
    Result := Result + '   CLI_NOMCLI     AS NOMCLI, ';
    Result := Result + '   (REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.CTR_FATCO2) AS VALDUP, ';
    Result := Result + '   CONCAT(REC.CTR_NUMDUP, "-", REC.CTR_PARCEL, "-", REC.CTR_ESPDOC, "-", REC.CTR_CODEMP) AS DUPLIC, ';

    If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End;
    End
    Else
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End;
    End;

    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                                   ';

  If (strAnaSin = 'S') Then
    strSQL := strSQL + fGetFieldsSin
  Else
    strSQL := strSQL + fGetFieldsAna;

  strSQL := strSQL + ',   "' + strDupAgr + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON      ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND   ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND   ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP       ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON      ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND    ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF        ';

  strSQL := strSQL + '  LEFT JOIN AGRCOM COM ON ';
  strSQL := strSQL + '    COM.COM_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '    COM.COM_EMPAGR = REC.CTR_CODEMP AND ';
  strSQL := strSQL + '    COM.COM_PARAGR = REC.CTR_PARCEL AND ';
  strSQL := strSQL + '    COM.COM_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '    IFNULL(COM.COM_SEQBAI, 0) = IFNULL(REC.CTR_SEQBAI, 0) AND ';
  strSQL := strSQL + '    COM.COM_CHADUP = CONCAT(AGR.CTR_NUMDUP,"-", ';
  strSQL := strSQL + '                            AGR.CTR_PARCEL,"-", ';
  strSQL := strSQL + '                            AGR.CTR_ESPDOC,"-", ';
  strSQL := strSQL + '                            AGR.CTR_CODEMP) ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  strSQL := strSQL + '  WHERE  ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

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
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL AND COM.COM_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND (REC.CTR_CTPCOM IS NOT NULL OR COM.COM_CTPCOM IS NOT NULL) ';
  End;

  If (strAnaSin = 'S') Then
  Begin
    strSQL := strSQL + ' GROUP BY  ';
    strSQL := strSQL + '   OPE_CODOPE    ';
  End;

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDireto(strCadRec,
  strDupAgr: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0;
  blnExibeItens: Boolean = False): String;
  Var
    strSQL,
    strNomCam: String;
Begin
  Case intRetSubGer Of
    1: strNomCam := 'OPE_CODGER';
    2: strNomCam := 'OPE_CODSUB';
  End;

  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "AGRUPAMENTO DIRETO" AS MODALIDADE,       ';
  strSQL := strSQL + '   REC.CTR_CTPCOM,                           ';
  strSQL := strSQL + '   COM.COM_CTPCOM,                           ';
  strSQL := strSQL + '   REC.AUTOINCREM AS CTR_AUTOINC,            ';
  strSQL := strSQL + '   ' + fGetVenDig('AGR.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE,                             ';
  strSQL := strSQL + '   V.OPE_CODDEP,                             ';

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,                 ';
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,                 ';
  End;

  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   V.OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('AGR.') + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   REC.CTR_SEQBAI AS CTR_SEQBAI,  ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(ROUND(IF(REC.CTR_SEQBAI = 0, '+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * AGR.CTR_FATCO2, 2)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, IFNULL(REC.CTR_VALJUR,0) * AGR.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * AGR.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM('+fRetValorBase+' * AGR.CTR_FATCO2) AS CTR_VALREC,           ';

  If blnConJur Then
    strSQL := strSQL + '   SUM('+fRetValorBase+' * AGR.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(AGR.CTR_VALIPI,0) - IFNULL(AGR.CTR_VALRET,0) - IFNULL(AGR.CTR_VALCBS,0) - IFNULL(AGR.CTR_VALIBS,0) - IFNULL(AGR.CTR_VAL_IS,0) - IFNULL(AGR.CTR_VALACE,0) - IFNULL(AGR.CTR_VALFRE,0) - IFNULL(AGR.CTR_VALFCP,0)) * AGR.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase+' * AGR.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase+' * AGR.CTR_FATCO2)) AS CTR_APRAZO, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2,0)) AS CTR_AVISTA_LIQ,  ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2)) AS CTR_APRAZO_LIQ, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAPrazo+' AND REC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIM AND '+fRetPeriodoData+', '+fRetValorBase+' * AGR.CTR_FATCO2, 0)) AS CTR_FATREC, ';
  strSQL := strSQL + '   IF('+fRetCndEhAVista+',"A","P") AS CTR_FORMAPG,                                 ';

  If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * AGR.CTR_FATCO2 * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(ABS('+fRetValorBase(FblnValorBaseLiquido)+') * IF(AGR.CTR_VALORI < 0, -1, 1) * ABS(AGR.' + fGetFatCom + ')) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(ABS(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0))) * IF(AGR.CTR_VALORI < 0, -1, 1) * ABS(AGR.' + fGetFatCom + ')) AS VALOR_COMISSAO, '
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

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaSQLItens;

  strSQL := strSQL + ',   "' + strDupAgr + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';
  If blnDocCom Then
    strSQL := strSQL + ' AND AGR.CTR_FATCOM > 0 ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODCLI = CNF.CTR_CLICNF     ';

  strSQL := strSQL + '  LEFT JOIN AGRCOM COM ON ';
  strSQL := strSQL + '    COM.COM_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '    COM.COM_EMPAGR = REC.CTR_CODEMP AND ';
  strSQL := strSQL + '    COM.COM_PARAGR = REC.CTR_PARCEL AND ';
  strSQL := strSQL + '    COM.COM_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '    IFNULL(COM.COM_SEQBAI, 0) = IFNULL(REC.CTR_SEQBAI, 0) AND ';
  strSQL := strSQL + '    COM.COM_CHADUP = CONCAT(AGR.CTR_NUMDUP,"-", ';
  strSQL := strSQL + '                            AGR.CTR_PARCEL,"-", ';
  strSQL := strSQL + '                            AGR.CTR_ESPDOC,"-", ';
  strSQL := strSQL + '                            AGR.CTR_CODEMP) ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + fGetVenDig('AGR.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(V.OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADOPE G ON (G.OPE_CODOPE = V.' + strNomCam + ') ';
    strSQL := strSQL + '                      OR (G.OPE_CODOPE = V.OPE_CODOPE AND G.OPE_INTEXT = '+IfThen(intRetSubGer = 1,'"G"', '"S"')+')';
  end;

  If blnExibeItens Then
    strSQL := strSQL + fRetornaJoinItens('MOVDET');

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';

  {*********************************************************************}
  {* VERIFICA SE FILTRA POR DATA DE RECEBIMENTO DA ULTIMA PARCELA PAGA *}
  {******************************************************************PZ*}
  strSQL := strSQL +  fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"     ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  AGR.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('AGR.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(V.OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('AGR.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';

  If blnExibeItens Then
    strSQL := strSQL + '   M.AUTOINCREM,   '
  Else
    strSQL := strSQL + '   DOCUME,   ';

  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  strSQL := strSQL + ' HAVING  ';

  strSQL := strSQL + '  (CTR_DOCCNF IS NULL)            ';

  If blnDocCom Then
    strSQL := strSQL + ' AND '+FCampoComissao+' <> 0 ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND CTR_CTPCOM IS NULL AND COM_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND (CTR_CTPCOM IS NOT NULL OR COM_CTPCOM IS NOT NULL) ';
  End;

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComAgrupamentoDiretoAberto(strCadRec,
  strDupAgr: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

  function fGetFieldsSin: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE AS CTR_CODVEN,                           ';
    Result := Result + '   OPE_NOMOPE,                                         ';
    Result := Result + '   OPE_CODDEP,                                         ';
    Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,                ';
    Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,                ';
    Result := Result + '   OPE_INTEXT,                                         ';
    Result := Result + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,    ';
    Result := Result + '   SUM(REC.CTR_VALDUP * AGR.CTR_FATCO2) AS CTR_ABERTO, ';
    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  function fGetFieldsAna: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE     AS CODVEN, ';
    Result := Result + '   OPE_NOMOPE     AS NOMVEN, ';
    Result := Result + '   AGR.CTR_DTACAD AS DTACAD, ';
    Result := Result + '   AGR.CTR_DTAVEN AS DTAVEN, ';
    Result := Result + '   CLI_CODCLI     AS CODCLI, ';
    Result := Result + '   CLI_NOMCLI     AS NOMCLI, ';
    Result := Result + '   (REC.CTR_VALDUP * AGR.CTR_FATCO2) AS VALDUP, ';
    Result := Result + '   CONCAT(REC.CTR_NUMDUP, "-", REC.CTR_PARCEL, "-", REC.CTR_ESPDOC, "-", REC.CTR_CODEMP) AS DUPLIC, ';

    If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * AGR.CTR_FATCO2 * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End;
    End
    Else
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,AGR.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,AGR.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * AGR.' + fGetFatCom + ') AS VALOR_COMISSAO, '
      End;
    End;

    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                   ';

  If (strAnaSin = 'S') Then
    strSQL := strSQL + fGetFieldsSin
  Else
    strSQL := strSQL + fGetFieldsAna;

  strSQL := strSQL + ',   "' + strDupAgr + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strDupAgr + ' AGR ON    ';
  strSQL := strSQL + '     AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ';

  strSQL := strSQL + '  LEFT JOIN CTRCNF CNF ON               ';
  strSQL := strSQL + '    AGR.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    AGR.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    AGR.CTR_CODEMP = CNF.CTR_EMPCNF     ';

  strSQL := strSQL + '  LEFT JOIN AGRCOM COM ON ';
  strSQL := strSQL + '    COM.COM_NUMAGR = REC.CTR_NUMDUP AND ';
  strSQL := strSQL + '    COM.COM_EMPAGR = REC.CTR_CODEMP AND ';
  strSQL := strSQL + '    COM.COM_PARAGR = REC.CTR_PARCEL AND ';
  strSQL := strSQL + '    COM.COM_CODCLI = REC.CTR_CODCLI AND ';
  strSQL := strSQL + '    IFNULL(COM.COM_SEQBAI, 0) = IFNULL(REC.CTR_SEQBAI, 0) AND ';
  strSQL := strSQL + '    COM.COM_CHADUP = CONCAT(AGR.CTR_NUMDUP,"-", ';
  strSQL := strSQL + '                            AGR.CTR_PARCEL,"-", ';
  strSQL := strSQL + '                            AGR.CTR_ESPDOC,"-", ';
  strSQL := strSQL + '                            AGR.CTR_CODEMP) ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('AGR.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    (CNF.CTR_DOCCNF IS NULL) AND  ';

  strSQL := strSQL + '    AGR.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC =  "AG"        ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

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
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('AGR.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL AND COM.COM_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND (REC.CTR_CTPCOM IS NOT NULL OR COM.COM_CTPCOM IS NOT NULL) ';
  End;

  If (strAnaSin = 'S') Then
  Begin
    strSQL := strSQL + ' GROUP BY  ';
    strSQL := strSQL + '   OPE_CODOPE  ';
  End;


  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacao(strCadRec,
  strCtrCnf: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0;
  blnExibeItens: Boolean = False): String;
  Var
    strSQL,
    strNomCam: String;
Begin
  Case intRetSubGer Of
    1: strNomCam := 'OPE_CODGER';
    2: strNomCam := 'OPE_CODSUB';
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "' + fGetModConfirmacaoDocumento + '" AS MODALIDADE,    ';
  strSQL := strSQL + '   REC.CTR_CTPCOM,                           ';
  strSQL := strSQL + '   NULL AS COM_CTPCOM,                       ';
  strSQL := strSQL + '   REC.AUTOINCREM AS CTR_AUTOINC,            ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE,                             ';
  strSQL := strSQL + '   V.OPE_CODDEP,                             ';

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,                 ';
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,                 ';
  End;  

  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,    ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,    ';
  strSQL := strSQL + '   V.OPE_INTEXT,                             ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('CNF.') + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   CNF.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   REC.CTR_SEQBAI AS CTR_SEQBAI,  ';
  strSQL := strSQL + '   CONCAT(CNF.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(ROUND(IF(REC.CTR_SEQBAI = 0, '+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI) * CNF.CTR_FATCO2, 2)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2, 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, IFNULL(REC.CTR_VALJUR,0) * CNF.CTR_FATCO2)) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0) * CNF.CTR_FATCO2) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM('+fRetValorBase+' * CNF.CTR_FATCO2) AS CTR_VALREC, ';

  If FConJur Then
    strSQL := strSQL + '   SUM('+fRetValorBase+' * CNF.CTR_FATCO2) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0)) * CNF.CTR_FATCO2) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM(('+fRetValorBase+' - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0) - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0) - IFNULL(REC.CTR_VALFCP,0)) * CNF.CTR_FATCO2) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase+' * CNF.CTR_FATCO2,0)) AS CTR_AVISTA,  ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase+' * CNF.CTR_FATCO2)) AS CTR_APRAZO, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', '+fRetValorBase(FblnValorBaseLiquido)+' * CNF.CTR_FATCO2,0)) AS CTR_AVISTA_LIQ,  ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, '+fRetValorBase(FblnValorBaseLiquido)+' * CNF.CTR_FATCO2)) AS CTR_APRAZO_LIQ, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAPrazo+' AND REC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIM AND '+fRetPeriodoData+', '+fRetValorBase+' * CNF.CTR_FATCO2, 0)) AS CTR_FATREC, ';
  strSQL := strSQL + '   IF('+fRetCndEhAVista+',"A","P") AS CTR_FORMAPG, ';

  If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, '
    End;
  End;

  strSQL := strSQL + '   CONCAT(CNF.CTR_NUMDUP,"-",CNF.CTR_PARCEL,"-",CNF.CTR_ESPDOC,"-",CNF.CTR_CODEMP) AS DOCUME,  ';

  strSQL := strSQL + '   CNF.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   CNF.CTR_CODCLI,         ';
  strSQL := strSQL + '   CNF.CTR_CODEMP,         ';

  strSQL := strSQL + '   "" AS CTR_DOCCNF,      ';

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

  strSQL := strSQL + '   "' + strCadRec + '" TABCTR ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaSQLItens;

  strSQL := strSQL + ',   "' + strCadRec + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF     ';
  If blnDocCom Then
    strSQL := strSQL + ' AND CNF.CTR_FATCOM > 0 ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + fGetVenDig('CNF.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(V.OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADOPE G ON (G.OPE_CODOPE = V.' + strNomCam + ') ';
    strSQL := strSQL + '                      OR (G.OPE_CODOPE = V.OPE_CODOPE AND G.OPE_INTEXT = '+IfThen(intRetSubGer = 1,'"G"', '"S"')+')';
  end;

  If blnExibeItens Then
    strSQL := strSQL + fRetornaJoinItens('NOTDET');

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  {*********************************************************************}
  {* VERIFICA SE FILTRA POR DATA DE RECEBIMENTO DA ULTIMA PARCELA PAGA *}
  {******************************************************************PZ*}
  strSQL := strSQL + fRetFiltroData(strCadRec) + ' AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"     ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;
  
  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '    AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '    AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(V.OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ' + fGetVenDig('CNF.') + ',                                          ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';

  If blnExibeItens Then
    strSQL := strSQL + '   M.AUTOINCREM,   '
  Else
    strSQL := strSQL + '   DOCUME,   ';

  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING '+FCampoComissao+' <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlComConfirmacaoAberto(strCadRec,
  strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

  function fGetFieldsSin: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE AS CTR_CODVEN,                          ';
    Result := Result + '   OPE_NOMOPE,                                        ';
    Result := Result + '   OPE_CODDEP,                                        ';
    Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,               ';
    Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,               ';
    Result := Result + '   OPE_INTEXT,                                        ';
    Result := Result + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR,   ';
    Result := Result + '   SUM(REC.CTR_VALDUP * CNF.CTR_FATCO2) AS CTR_ABERTO,';
    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  function fGetFieldsAna: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE     AS CODVEN, ';
    Result := Result + '   OPE_NOMOPE     AS NOMVEN, ';
    Result := Result + '   CNF.CTR_DTACAD AS DTACAD, ';
    Result := Result + '   CNF.CTR_DTAVEN AS DTAVEN, ';
    Result := Result + '   CLI_CODCLI     AS CODCLI, ';
    Result := Result + '   CLI_NOMCLI     AS NOMCLI, ';
    Result := Result + '   (REC.CTR_VALDUP * CNF.CTR_FATCO2) AS VALDUP, ';
    Result := Result + '   CONCAT(REC.CTR_NUMDUP, "-", REC.CTR_PARCEL, "-", REC.CTR_ESPDOC, "-", REC.CTR_CODEMP) AS DUPLIC, ';

    If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End;
    End
    Else
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,CNF.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,CNF.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * CNF.' + fGetFatCom + ') AS VALOR_COMISSAO, '
      End;
    End;

    Result := Result + '   "' + strCadRec + '" TABCTR ';
  end;

  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  If (strAnaSin = 'S') Then
    strSQL := strSQL + fGetFieldsSin
  Else
    strSQL := strSQL + fGetFieldsAna;

  strSQL := strSQL + ',   "' + strCadRec + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strCadRec + ' REC ';

  strSQL := strSQL + '  INNER JOIN ' + strCtrCnf + ' CNF ON   ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CNF.CTR_EMPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODCLI = CNF.CTR_CLICNF     ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CNF.CTR_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('CNF.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    CNF.CTR_DTACAD >= :DTACOR AND ';

  strSQL := strSQL + '    REC.CTR_DTAREC IS NULL AND ';

  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC" AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"  ';

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

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
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('CNF.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';    

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  If (strAnaSin = 'S') Then
  Begin
    strSQL := strSQL + ' GROUP BY  ';
    strSQL := strSQL + '   OPE_CODOPE  ';
  End;

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacao(
  strTabela: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0;
  blnExibeItens: Boolean = False): String;
  Var
    strSQL,
    strNomCam: String;
Begin

  Case intRetSubGer Of
    1: strNomCam := 'OPE_CODGER';
    2: strNomCam := 'OPE_CODSUB';
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "DIRETA" AS MODALIDADE,                   ';
  strSQL := strSQL + '   REC.CTR_CTPCOM,                           ';
  strSQL := strSQL + '   NULL AS COM_CTPCOM,                       ';
  strSQL := strSQL + '   REC.AUTOINCREM AS CTR_AUTOINC,            ';
  strSQL := strSQL + '   ' + fGetVenDig('REC.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE,                             ';
  strSQL := strSQL + '   V.OPE_CODDEP,                             ';

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,                 ';
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,                 ';
  End;

  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   V.OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('REC.') + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   REC.CTR_SEQBAI AS CTR_SEQBAI,  ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(ROUND(IF(REC.CTR_SEQBAI = 0, '+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI), 2)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0)) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', IFNULL(REC.CTR_VALJUR,0), 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+', 0, IFNULL(REC.CTR_VALJUR,0))) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0)) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM('+fRetValorBase+') AS CTR_VALREC,           ';

  If FConJur Then
    strSQL := strSQL + '   SUM('+fRetValorBase+') AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM('+fRetValorBase+' - IFNULL(REC.CTR_VALJUR,0)) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM('+fRetValorBase+' - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0) - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0) - IFNULL(REC.CTR_VALFCP,0)) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+','+fRetValorBase+',0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+',0,'+fRetValorBase+')) AS CTR_APRAZO, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+','+fRetValorBase(FblnValorBaseLiquido)+',0)) AS CTR_AVISTA_LIQ, ';
  strSQL := strSQL + '   SUM(IF('+fRetCndEhAVista+',0,'+fRetValorBase(FblnValorBaseLiquido)+')) AS CTR_APRAZO_LIQ, ';

  strSQL := strSQL + '   SUM(IF('+fRetCndEhAPrazo+' AND REC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIM AND '+fRetPeriodoData+', '+fRetValorBase+', 0)) AS CTR_FATREC, ';
  strSQL := strSQL + '   IF('+fRetCndEhAVista+',"A","P") AS CTR_FORMAPG,              ';

  If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If FConJur Then
    Begin
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * (IF('+fRetCndEhAVista+',0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM('+fRetValorBase(FblnValorBaseLiquido)+' * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * (IF('+fRetCndEhAVista+',0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(('+fRetValorBase(FblnValorBaseLiquido)+' - IFNULL(REC.CTR_VALJUR,0)) * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
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

  strSQL := strSQL + '   "' + strtabela + '" TABCTR ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaSQLItens;

  strSQL := strSQL + ',   "' + strTabela + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + fGetVenDig('REC.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(V.OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

  If (intRetSubGer > 0) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADOPE G ON (G.OPE_CODOPE = V.' + strNomCam + ') ';
    strSQL := strSQL + '                      OR (G.OPE_CODOPE = V.OPE_CODOPE AND G.OPE_INTEXT = '+IfThen(intRetSubGer = 1,'"G"', '"S"')+')';
  end;

  strSQL := strSQL + '  LEFT JOIN CTRCNF ON                      ';
  strSQL := strSQL + '    REC.CTR_NUMDUP = CTRCNF.CTR_DOCCNF AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC = CTRCNF.CTR_ESPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODEMP = CTRCNF.CTR_EMPCNF AND ';
  strSQL := strSQL + '    REC.CTR_CODCLI = CTRCNF.CTR_CLICNF     ';
  If blnDocCom Then
    strSQL := strSQL + ' AND CTRCNF.CTR_FATCOM > 0 ';

  If blnExibeItens Then
    strSQL := strSQL + fRetornaJoinItens('MOVDET');

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"    AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "AG"        ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

  {*********************************************************************}
  {* VERIFICA SE FILTRA POR DATA DE RECEBIMENTO DA ULTIMA PARCELA PAGA *}
  {******************************************************************PZ*}
  strSQL := strSQL + '  AND (' + fRetFiltroData(strTabela) + ') ';

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + fGetVenDig('REC.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(V.OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CONCAT(' + fGetVenDig('REC.') + '," - ",V.OPE_NOMOPE),                             ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';

  If blnExibeItens Then
    strSQL := strSQL + '   M.AUTOINCREM,   '
  Else
    strSQL := strSQL + '   DOCUME,   ';

  strSQL := strSQL + '   REC.CTR_DTAREC                                                                  ';

  If blnDocCom Then
    strSQL := strSQL + ' HAVING '+FCampoComissao+' <> 0 ';

  Result := strSQL;
end;

function TValorRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto(
  strTabela: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

  function fGetFieldsSin: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE AS CTR_CODVEN,                        ';
    Result := Result + '   OPE_NOMOPE,                                      ';
    Result := Result + '   OPE_CODDEP,                                      ';
    Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,             ';
    Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,             ';
    Result := Result + '   OPE_INTEXT,                                      ';
    Result := Result + '   CONCAT(OPE_CODOPE," - ",OPE_NOMOPE) AS VENDEDOR, ';
    Result := Result + '   SUM(REC.CTR_VALDUP) AS CTR_ABERTO,                ';
    Result := Result + '   "' + strTabela + '" TABCTR ';
  end;

  function fGetFieldsAna: String;
  begin
    Result := '';
    Result := Result + '   OPE_CODOPE     AS CODVEN, ';
    Result := Result + '   OPE_NOMOPE     AS NOMVEN, ';
    Result := Result + '   REC.CTR_DTACAD AS DTACAD, ';
    Result := Result + '   REC.CTR_DTAVEN AS DTAVEN, ';
    Result := Result + '   CLI_CODCLI     AS CODCLI, ';
    Result := Result + '   CLI_NOMCLI     AS NOMCLI, ';
    Result := Result + '   (REC.CTR_VALDUP) AS VALDUP, ';
    Result := Result + '   CONCAT(REC.CTR_NUMDUP, "-", REC.CTR_PARCEL, "-", REC.CTR_ESPDOC, "-", REC.CTR_CODEMP) AS DUPLIC, ';

    If (opcVenRep In [opSupGeral, opSupRegional]) Or (FblnCalcularPeloCadastroOperador) Then
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,OPE_PERCO2))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
      End;
    End
    Else
    Begin
      If FConJur Then
      Begin
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   (REC.CTR_VALDUP * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   (REC.CTR_VALDUP * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End
      Else
      Begin
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,REC.' + fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAVEN,0,REC.' + fGetFatCom + '))) AS VLCOM_OPEAPR, ';
        Result := Result + '   ((REC.CTR_VALDUP - IFNULL(REC.CTR_VALJUR,0)) * REC.' + fGetFatCom + ') AS VALOR_COMISSAO, ';
      End;
    End;

    Result := Result + '   "' + strTabela + '" TABCTR ';
  end;

  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                ';

  If (strAnaSin = 'S') Then
    strSQL := strSQL + fGetFieldsSin
  Else
    strSQL := strSQL + fGetFieldsAna;

  strSQL := strSQL + ',   "' + strTabela + '" AS TABELAUPDATE ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = ' + fGetVenDig('REC.') + IfThen(Not fEmptyStr(strDepCod), ' AND (LOCATE(OPE_CODDEP, :DEPOPE) > 0 ) ', ' ');

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

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  If (blnListaAdtCli) Then
    strSQL := strSQL + ' AND REC.CTR_ADTCLI = "N" ';

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

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND LOCATE(OPE_CODDEP, :CODDEP) > 0 ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(strStaVen)) Then
    strSQL := strSQL + '  AND OPE_STATUS = "' +strStaVen+ '" ';

  If (Not fEmptyStr(strTipVenRep)) Then
    strSQL := strSQL + '  AND OPE_INTEXT = :INTEXT ';

  strSQL := strSQL + '    AND (CTRCNF.CTR_DOCCNF IS NULL) ';

  Case FPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  If (strAnaSin = 'S') Then
  Begin
    strSQL := strSQL + ' GROUP BY  ';
    strSQL := strSQL + '   OPE_CODOPE    ';
  End;

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
    opParticipante1: Result := ' ' + strAlias + 'CTR_CODPA1 ';
    opParticipante2: Result := ' ' + strAlias + 'CTR_CODPA2 ';
    opProjetista1:   Result := ' ' + strAlias + 'CTR_CODPJ1 ';
    opProjetista2:   Result := ' ' + strAlias + 'CTR_CODPJ2 ';
  End;
end;

function TValorRecebido.fGetVenDigAdt: String;
begin
  Case opcVenRep Of
    opVendedor:      Result := ' FGO_CODVEN ';
    opRepresentante: Result := ' FGO_CODVEN ';
    opSupGeral:      Result := ' CLI_SUPGER ';
    opSupRegional:   Result := ' CLI_SUPREG ';
    opVenCadCli:     Result := ' CLI_CODVEN ';
    opDigitador:     Result := ' FGO_CODDIG ';
    opParticipante1: Result := ' ADT_OPELAN ';
    opParticipante2: Result := ' ADT_OPELAN ';
    opProjetista1:   Result := ' ADT_OPELAN ';
    opProjetista2:   Result := ' ADT_OPELAN ';
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

    {**************************************************************************}
    {* Não grava no MOVDET, é incluido manualmente depois apenas no CADREC/X, *}
    {* incluido o DET_CODVEN aqui apenas para manter compatibilidade no rel.  *}
    {***********************************************************************RN*}    
    opParticipante1: Result := ' DET_CODVEN ';
    opParticipante2: Result := ' DET_CODVEN ';
    opProjetista1:   Result := ' DET_CODVEN ';
    opProjetista2:   Result := ' DET_CODVEN ';
  End;
end;

function TValorRecebido.fGetModConfirmacaoDocumento: String;
begin
  Result := 'CONFIRMAÇÃO DOCUMENTO';
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
    opParticipante1: Result := 'CTR_FATPA1';
    opParticipante2: Result := 'CTR_FATPA2';
    opProjetista1:   Result := 'CTR_FATPJ1';
    opProjetista2:   Result := 'CTR_FATPJ2';
  End;
end;

function TValorRecebido.fGetFatComAdt: String;
begin
  If (opcVenRep = opRepresentante) Then
    Result := 'ADT_FATREP'
  Else
    Result := 'ADT_FATCOM';
end;

function TValorRecebido.fRetFiltroCliente: String;
begin
  Result := ' REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
end;

{***************************************************************}
{* ESSA FUNÇÃO RETORNA O FILTRO QUANDO QUANDO ESTÁ CONFIGURADO *}
{* PARA CALCULAR A COMISSÃO SOMENTE SE FOI QUITADA TODAS AS    *}
{* PARCELAS DO CONTA A RECEBER CONSIDERANDO A DATA DO ULTIMO   *}
{* RECEBIMENTO PARA O PERIODO INFORMADO.                       *}
{* SE ESTIVER AS PARCELAS ESTIVEREM QUITADAS, IRÁ EXIBIR TODAS *}
{* AS PARCELAS.                                                *}
{************************************************************PZ*}
function TValorRecebido.fRetFiltroData(strTabela: String): String;
begin
  Result := '';

  If (blnUltPar) Then
  Begin
    {*******************************************}
    {* IRÁ CONSIDERAR A DATA DA ULTIMA PARCELA *}
    {* RECEBIDA PARA O FILTRO DO PERIODO.      *}
    {****************************************PZ*}
    Result := Result + '  (((SELECT                                     ';
    Result := Result + '       IFNULL(MAX(TT.CTR_DTAREC), 0) AS MAXDTA  ';
    Result := Result + '     FROM                                       ';
    Result := Result +         strTabela + ' TT                         ';
    Result := Result + '     WHERE                                      ';
    Result := Result + '       TT.CTR_NUMDUP = REC.CTR_NUMDUP AND       ';
    Result := Result + '       TT.CTR_ESPDOC = REC.CTR_ESPDOC AND       ';
    Result := Result + '       TT.CTR_CODEMP = REC.CTR_CODEMP  AND      ';
    Result := Result + '       TT.CTR_CODCLI = REC.CTR_CODCLI           ';
    Result := Result + '      ) BETWEEN  ' + fCurrentDate(StrToDateDef(strDtaIni, 0)) + ' AND ' + fCurrentDate(StrToDateDef(strDtaFim, 0)) + ') ';

    Result := Result + '      AND                                      ';

    {************************************************}
    {* VERIFICA SE TODAS AS PARCELAS ESTÃO QUITADAS *}
    {*********************************************PZ*}
    Result := Result + '  ((SELECT                                     ';
    Result := Result + '      IFNULL(COUNT(*), 0) AS QTDREG            ';
    Result := Result + '    FROM                                       ';
    Result := Result +        strTabela + ' TT                         ';
    Result := Result + '    WHERE                                      ';
    Result := Result + '      TT.CTR_NUMDUP = REC.CTR_NUMDUP AND       ';
    Result := Result + '      TT.CTR_ESPDOC = REC.CTR_ESPDOC AND       ';
    Result := Result + '      TT.CTR_CODEMP = REC.CTR_CODEMP  AND      ';
    Result := Result + '      TT.CTR_CODCLI = REC.CTR_CODCLI  AND      ';
    Result := Result + '      IFNULL(TT.CTR_DTAREC, 0) = 0) = 0))      ';

    If (strRelMod = '4') Then
    Begin
      Result := ' ( '+Result + ' OR ' + AnsiReplaceStr(Result, 'CTR_DTAREC', 'CTR_DTABOL')+' ) ';
    End;
  End
  Else
    Result := Result + fRetPeriodoData;
end;

function TValorRecebido.fRetornaJoinItens(strMovDet: String): String;
begin
  If (strMovDet = 'FATDOR') Then
  Begin
    Result := Result + '   LEFT JOIN FATDOR M ON ADT_NUMDOC = FDO_NUMDOC ';
    Result := Result + '                     AND ADT_ESPDOC = FDO_ESPDOC ';
    Result := Result + '                     AND ADT_CODEMP = FDO_CODEMP ';
    Result := Result + '                     AND ADT_CODCLI = FDO_CODCLI ';
    Result := Result + '   LEFT JOIN CADUNI U ON U.UNI_CODUNI = FDO_UNIDAD ';
  End
  Else
  Begin
    Result := Result + '   LEFT  JOIN '+ strMovDet +' M ON REC.CTR_NUMDUP = M.DET_NUMDOC ';
    Result := Result + '                               AND REC.CTR_ESPDOC = M.DET_ESPDOC ';
    Result := Result + '                               AND REC.CTR_CODEMP = M.DET_CODEMP ';
    Result := Result + '                               AND REC.CTR_CODCLI = M.DET_CODCLI ';
    Result := Result + '                               AND M.DET_TIP_FC   = "C" ';
    Result := Result + '   LEFT  JOIN CADUNI U ON U.UNI_CODUNI   = M.DET_UNIDAD ';
  End;
end;

function TValorRecebido.fRetornaSQLItens(blnFatGor: Boolean = False): String;
var
  blnFreCom : Boolean;

  function fRetSQLQtdDup: String;
  begin
    If (blnFatGor) Then
    Begin
      Result := Result + ' (SELECT COUNT(*) FROM CADREC K       ';
      Result := Result + '   WHERE K.CTR_NUMDUP = M.FDO_NUMDOC  ';
      Result := Result + '     AND K.CTR_ESPDOC = M.FDO_ESPDOC  ';
      Result := Result + '     AND K.CTR_CODEMP = M.FDO_CODEMP  ';
      Result := Result + '     AND K.CTR_CODCLI = M.FDO_CODCLI) ';

      Result := ' IFNULL('+Result+', IFNULL(LEFT(FDO_CONPAG, 2), 1)) ';
    End
    Else
    Begin
      Result := Result + ' (SELECT COUNT(*) FROM CADREC K       ';
      Result := Result + '   WHERE K.CTR_NUMDUP = M.DET_NUMDOC  ';
      Result := Result + '     AND K.CTR_ESPDOC = M.DET_ESPDOC  ';
      Result := Result + '     AND K.CTR_CODEMP = M.DET_CODEMP  ';
      Result := Result + '     AND K.CTR_CODCLI = M.DET_CODCLI) ';

      Result := ' IFNULL('+Result+', IFNULL(LEFT(DET_CONPAG, 2), 1)) ';
    End;

    Result := ' CAST('+Result+' AS UNSIGNED) ';
  end;

begin
  blnFreCom := fCfgSis('FRECOM', varBoolean);

  If (blnFatGor) Then
  Begin
    Result := ' ,   ';
    Result := Result + '   M.AUTOINCREM AS CHAVE,                  ';
    Result := Result + '   M.FDO_DTAENT AS DTAENT,                 ';
    Result := Result + '   CONCAT(M.FDO_NUMDOC,"-",M.FDO_ESPDOC,"-",M.FDO_SERIE_,"-",M.FDO_CODEMP) AS NUMDOC, ';
    Result := Result + '   M.FDO_CODITE AS CODITE,                 ';
    Result := Result + '   M.FDO_DESCRI AS DESITE,                 ';
    Result := Result + '   U.UNI_SIGUNI AS SIGUNI,                 ';
    Result := Result + '   (IF(LEFT(FDO_CLAFIS,1) < 5, -(FDO_QTDITE), FDO_QTDITE)) AS QTDITE, ';
    Result := Result + '   (COALESCE(FDO_UNIORI, 0)) AS UNITAB, ';
    Result := Result + '   (COALESCE(((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE), 0)) AS UNIPRA, ';
    Result := Result + '   (IF((((FDO_UNIORI - ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE)) / FDO_UNIORI) * 100) <= 0, 0.00, (((FDO_UNIORI - ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE)) / FDO_UNIORI) * 100))) AS PERDES, ';
    Result := Result + '   (COALESCE((FDO_TOTITE - FDO_DESESP), 0)) AS TOTPRA, ';
    Result := Result + '   (IF((FDO_ESPDOC = "BR") OR LOCATE(FDO_CLAFIS,' + CLAFIS_BR + '), 0.00, IFNULL(FDO_PERCOM, 0))) AS PERCOM, ';
    Result := Result + '   (IF((FDO_ESPDOC = "BR") OR LOCATE(FDO_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(FDO_CLAFIS,1) < 5, -FDO_TOTCOM, FDO_TOTCOM)) / '+fRetSQLQtdDup+') AS TOTCOM, ';
    Result := Result + '   (IF((FDO_ESPDOC = "BR") OR LOCATE(FDO_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP' + IIF(blnFreCom,' + FDO_TOTFRE', '') + '), FDO_TOTITE - FDO_DESESP' + IIF(blnFreCom,' + FDO_TOTFRE', '') + '))) AS TOTITE, ';
    Result := Result + '   M.FDO_VALIPI AS VALIPI                  ';
  End
  Else
  Begin
    Result := ' ,   ';
    Result := Result + '   M.AUTOINCREM AS CHAVE,                  ';
    Result := Result + '   M.DET_DTAENT AS DTAENT,                 ';
    Result := Result + '   CONCAT(M.DET_NUMDOC,"-",M.DET_ESPDOC,"-",M.DET_SERIE_,"-",M.DET_CODEMP) AS NUMDOC, ';
    Result := Result + '   M.DET_CODITE AS CODITE,                 ';
    Result := Result + '   M.DET_DESCRI AS DESITE,                 ';
    Result := Result + '   U.UNI_SIGUNI AS SIGUNI,                 ';
    Result := Result +     STR_QTDITE +' AS QTDITE,                ';
    Result := Result + '   (COALESCE(DET_UNIORI, 0)) AS UNITAB, ';
    Result := Result + '   ('+ STR_UNIPRA +') AS UNIPRA,        ';
    Result := Result + '   ('+ STR_PERDES +') AS PERDES,        ';
    Result := Result + '   ('+ STR_TOTPRA +') AS TOTPRA,        ';
    Result := Result + '   ('+ STR_PERCOM +') AS PERCOM,        ';
    Result := Result + '   ('+ STR_TOTCOM +' / '+fRetSQLQtdDup+') AS TOTCOM, ';
    Result := Result + '   (IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IIF(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IIF(blnFreCom,' + DET_TOTFRE', '') + '))) AS TOTITE, ';
    Result := Result + '   M.DET_VALIPI AS VALIPI                  ';
  End;
end;

function TValorRecebido.getCodEmp: String;
begin
  Result := FCodEmp
end;

function TValorRecebido.getCodVen: String;
begin
  Result := FCodVen
end;

function TValorRecebido.getDepCod: String;
begin
  Result := FDepCod;
end;

function TValorRecebido.getRelEmp: TRelacionamentoEmpresa;
begin
  Result := FRelEmp;
end;

function TValorRecebido.getVenRep: TOpVendedorRepresentante;
begin
  Result := FVenRep;
end;

procedure TValorRecebido.setCodEmp(Value: String);
begin
  FCodEmp := Value;
end;

procedure TValorRecebido.setCodVen(Value: String);
begin
  FCodVen := Value;
end;

procedure TValorRecebido.setDepCod(const Value: String);
begin
  FDepCod := Value;
end;

procedure TValorRecebido.setRelEmp(Value: TRelacionamentoEmpresa);
begin
  FRelEmp := Value;
end;

procedure TValorRecebido.setVenRep(Value: TOpVendedorRepresentante);
begin
  FVenRep := Value;
end;

end.
