unit Contabilidade.Classes.TLanConENT;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet, Contabilidade.Interfaces,
     System.Generics.Collections, System.Math;

type
  TLanConENT = Class(TInterfacedObject, ITipLanCon)
  private
    FcdsTravaGnreDuplicada : TUniClientDataSet ;
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FUsaCampoNatCfo : boolean;
    FUsaCampoNatOpeMovTri : boolean;
    FUsaCampoAbfCon : boolean;
    FUsaCampoPagant : boolean;
    FParametrizouPagant : boolean;
    fltVlrCon : double ;
    fltValIcm : double ;
    fltValIpi : double ;
    fltTotFre : double ;
    fltDesAce : double ;
    fltValRet : double ;
    fltValPis : double ;
    fltValCof : double ;
    fltTotMed : double ;
    fltTotIte : double ;
    fltDesEsp : double ;
    fltValIss : double ;
    fltRecSsl : double ;
    fltReInss : double ;
    fltReIrrf : double ;
    fltRInssp : double ;
    fltLiqEnt : double ;
    fltPagAnt : double ;
    strIncDoc  : string;
    fltRatVlrCon : double ;
    fltRatValIcm : double ;
    fltRatValIpi : double ;
    fltRatTotFre : double ;
    fltRatDesAce : double ;
    fltRatValRet : double ;
    fltRatValPis : double ;
    fltRatValCof : double ;
    fltRatTotMed : double ;
    fltRatTotIte : double ;
    fltRatDesEsp : double ;
    fltRatValIss : double ;
    fltRatRecSsl : double ;
    fltRatReInss : double ;
    fltRatReIrrf : double ;
    fltRatRInssP : double ;
    fltRatLiqEnt : double ;
    fltRatPagAnt : double ;
    fltDifVlrCon : double ;
    fltDifValIcm : double ;
    fltDifValIpi : double ;
    fltDifTotFre : double ;
    fltDifDesAce : double ;
    fltDifValRet : double ;
    fltDifValPis : double ;
    fltDifValCof : double ;
    fltDifTotMed : double ;
    fltDifTotIte : double ;
    fltDifDesEsp : double ;
    fltDifValIss : double ;
    fltDifRecSsl : double ;
    fltDifReInss : double ;
    fltDifReIrrf : double ;
    fltDifRInssP : double ;
    fltDifLiqEnt : double ;
    fltDifPagAnt : double ;
    FstrCentroCustoDefault : String ;
    FCdsEntAdt: TUniClientDataset;
    procedure pZerarValores;
    procedure pSomarValores;
    procedure pAlterarValores;
    procedure pCarregaEntAdt;
    function fChaveRateio: string;
    function fRetornaSQLNaurezaOperacao: string ;
    function fRetornaTravaRegistroDuplicadoGNRE(): TUniClientDataSet ;
    function fEhGNREDuplicada(const AstrFisInc: string): Boolean ;
    procedure pAjustaValorIRRF;
  public
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
     Contabilidade.Classes.TEventoContabil, Contabilidade.Classes.TTrataIncDoc;

{ TLanConENT }

constructor TLanConENT.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FUsaCampoNatOpeMovTri := fUsarNaturezaOperacaoDoItemNoEnt ;
  FUsaCampoNatCfo := fCampoExiste('AUXMOV', 'AUX_NATCFO');
  FUsaCampoAbfCon := fCampoExiste('CADITE', 'ITE_ABFCON');
  FUsaCampoPagant := fCampoExiste('MOVTRI', 'DET_PAGANT');
  FParametrizouPagant := fCampoTabelaParcon('COUNT(*)', ['CON_DESVAL'], ['Vl.Adiantamento'], True) > 0;
  FcdsTravaGnreDuplicada := Nil ;
  FCdsEntAdt := Nil;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConENT.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FcdsTravaGnreDuplicada) then
    FreeAndNil(FcdsTravaGnreDuplicada);
  if Assigned(FCdsEntAdt) then
    FreeAndNil(FCdsEntAdt);
  inherited;
end;

function TLanConENT.fCarregaDados: Boolean;
  Var
    strSQL : String;
    strSQLPrincipal : String;

  function fVlrCon: string;
  begin
    Result := ' DET_VLRCON ';
    if (FParametrizouPagant) and (FUsaCampoPagant) then
    begin
      Result := Result + ' - IFNULL(DET_PAGANT,0) ';
      Result := '(' + Result + ')';
    end;
  end;

begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, GER_CODEVE, DET_TIP_FC, ';
  strSQL := strSQL + '        DET_NUMDOC AS NUMDOC, DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '        DET_CODFOR, DET_SERIE_, SUM(' + fVlrCon + ') AS VLRCON, SUM(DET_VALICM) AS VALICM, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALIPI,0)) AS VALIPI, SUM(DET_TOTFRE) AS TOTFRE, SUM(DET_DESACE) AS DESACE, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALRET,0)) AS VALRET, SUM(DET_VALPIS) AS VALPIS, SUM(DET_VALCOF) AS VALCOF, ';
  strSQL := strSQL + '        SUM(DET_TOTMED) AS TOTMED, IFNULL(CLI_NOMCLI, FOR_NOMFOR) AS NOME, IF(CLI_NOMCLI IS NULL, FOR_C_G_C_, CLI_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '        IFNULL(FIS_VALISS, 0) AS VALISS, IFNULL(FIS_RECSSL, 0) AS RECSSL, ';
  strSQL := strSQL + '        IFNULL(FIS_REINSS, 0) AS REINSS, ';
  strSQL := strSQL + '        IFNULL(FIS_REIRRF, 0) AS REIRRF, ';
  strSQL := strSQL + '        IFNULL(' + fRetornaCampoInssPatronalCadfis + ', 0) AS RINSSP, ';
  strSQL := strSQL + '        SUM(' + fVlrCon + ' - IFNULL(DET_VALICM, 0) - IFNULL(DET_VALIPI, 0) - IFNULL(DET_VALPIS, 0) - IFNULL(DET_VALCOF, 0)) AS LIQENT, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, "F", "C") AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, IFNULL(NCO_CODFOR, FOR_CODFOR), IFNULL(NCO_CODCLI, CLI_CODCLI)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO), IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO)) AS PLANCO, ';
  strSQL := strSQL + '        IF(DET_CLAFIS IN (''2401'',''2403''), ';
  strSQL := strSQL + '           IFNULL(GNR_VALGNR, 0) / NULLIF( ';
  strSQL := strSQL + '               IF(FIS_CLFSC1 IN (''2401'',''2403''), IFNULL(FIS_VLCON1,0), 0) + ';
  strSQL := strSQL + '               IF(FIS_CLFSC2 IN (''2401'',''2403''), IFNULL(FIS_VLCON2,0), 0) + ';
  strSQL := strSQL + '               IF(FIS_CLFSC3 IN (''2401'',''2403''), IFNULL(FIS_VLCON3,0), 0) + ';
  strSQL := strSQL + '               IF(FIS_CLFSC4 IN (''2401'',''2403''), IFNULL(FIS_VLCON4,0), 0) + ';
  strSQL := strSQL + '               IF(FIS_CLFSC5 IN (''2401'',''2403''), IFNULL(FIS_VLCON5,0), 0) ';
  strSQL := strSQL + '           , 0), ';
  strSQL := strSQL + '           0) AS FATOR_GNR, ';
  strSQL := strSQL + '        FIS_FORCLI AS FORCLI, ';
  strSQL := strSQL + '        MOVDET.DET_SEQGER AS SEQGER, "MOVGER" AS TABELA, ';

  strSQL := strSQL + fRetornaSQLNaurezaOperacao ;

  if FUsaCampoPagant then
    strSQL := strSQL + '        SUM(IFNULL(DET_PAGANT,0)) AS PAGANT, '
  else
    strSQL := strSQL + '        0.00 AS PAGANT, ';

  strSQL := strSQL + '        SUM(DET_DESESP) AS DESESP, ';
  strSQL := strSQL + '        SUM(DET_TOTITE-DET_DESESP) AS TOTITE, CADFIS.AUTOINCREM AS FISINC, ';

  strSQL := strSQL + '        SUM(IF( COALESCE(MOVICD.ICD_BASFCP,0.00) = 0.00, IFNULL(MOVTRI.DET_VFCPST,0.00), IF(COALESCE(MOVTRI.DET_BFCPST,0) = COALESCE(MOVICD.ICD_BASFCP,0), IFNULL(MOVTRI.DET_VFCPST, 0.00), 0) )) AS VFCPST, ';
  strSQL := strSQL + '        SUM(IF( COALESCE(MOVICD.ICD_BASFCP,0.00) <> 0.00, IF(COALESCE(MOVTRI.DET_BFCPST,0) <> COALESCE(MOVICD.ICD_BASFCP,0), IFNULL(MOVICD.ICD_VALFCP, 0.00), 0 ), 0)) AS VALFCP, ';
  strSQL := strSQL + '        IF(GER_CONPAG = "01000", "À Vista", "À Prazo") AS NATOPE ';
  if (FUsaCampoAbfCon) then
    strSQL := strSQL + '  ,IFNULL(ITE_ABFCON, "") AS ITE_ABFCON ';

  if fCfgConGru = 'S' then
  begin
    strSQL := strSQL + '  ,ITE_CODGRU ';
  end ;
  strSQL := strSQL + '     , GER_VALIRF ';
  strSQL := strSQL + '     , ROUND((DET_TOTITE / (IFNULL(GER_TOTPRO,0) + IFNULL(GER_TOTSER,0))) * GER_VALIRF, 2) AS VALIRF ';
  strSQL := strSQL + '     , SUM(CASE WHEN DET_PROEMB <> "S" AND COALESCE(GER_ORIDOC, "") = "V" AND COALESCE(GER_TIP_FC, "") = "C" THEN COALESCE(ICD_VALDES,0.00) ELSE 0.00 END) AS VAL_DIFAL ';

  strSQL := strSQL + '   FROM MOVDET ';
  strSQL := strSQL + '   JOIN MOVGER ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  strSQL := strSQL + '   JOIN CADEMP ON MOVDET.DET_CODEMP = CADEMP.EMP_CODEMP ';

  if (FUsaCampoAbfCon) or (fCfgConGru = 'S') then
    strSQL := strSQL + ' JOIN CADITE ON MOVDET.DET_CODITE = CADITE.ITE_CODITE ';

  strSQL := strSQL + '   LEFT JOIN MOVICD ON MOVDET.AUTOINCREM = MOVICD.ICD_SEQGER ';

  if FUsaCampoNatCfo and (not FUsaCampoNatOpeMovTri) then
    strSQL := strSQL + ' LEFT JOIN AUXMOV ON AUX_SEQGER = MOVDET.DET_SEQGER ';

  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = DET_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC ';
  strSQL := strSQL + '                   AND FIS_ESPDOC = DET_ESPDOC ';
  strSQL := strSQL + '                   AND FIS_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '                   AND FIS_TIP_FC = DET_TIP_FC ';
  strSQL := strSQL + '                   AND FIS_FORCLI = IFNULL(DET_CODCLI, DET_CODFOR) ';
  strSQL := strSQL + '                   AND FIS_ORIDOC = DET_ORIDOC ';
  strSQL := strSQL + '                   AND IFNULL(FIS_SERIE_,"") = IFNULL(DET_SERIE_,"") ';
  strSQL := strSQL + '   LEFT JOIN CADGNR ON GNR_AUTFIS = CADFIS.AUTOINCREM ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '  WHERE TRUE ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVDET.DET_SEQGER')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '    AND LEFT(DET_CLAFIS, 1) < "5" ';
  strSQL := strSQL + '    AND RIGHT(DET_CLAFIS, 3) NOT IN ("933", ' + fListaCfopsOutrasEntradas + ') ';
  strSQL := strSQL + '    AND DET_ESPDOC IN ("NF", "NS", "NV", "IF", "IV", "D1", "EL") ';

  strSQL := strSQL + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_CODFOR, DET_TIP_FC, DET_ORIDOC, DET_CLAFIS ';

  // ITE_ABFCON nulo e vazio são a mesma abreviação: agrupados à parte, a nota virava duas linhas
  if (FUsaCampoAbfCon) then
    strSQL := strSQL + '  ,IFNULL(ITE_ABFCON, "") ';

  if fCfgConGru = 'S' then
  begin
    strSQL := strSQL + '  ,ITE_CODGRU ';
  end ;

  if fEmptyStr(recParCon.strTabela) then
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'IFNULL(MOVTRI.DET_NATOPE,"")', '""') , 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'), 'MOVGER', 'NOTGER'), 'MOVICD', 'NOTICD')
  else if (recParCon.strTabela = 'NOTGER') then
    strSQL := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'IFNULL(MOVTRI.DET_NATOPE,"")', '""'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'), 'MOVGER', 'NOTGER'), 'MOVICD', 'NOTICD');

  strSQLPrincipal := '';
  strSQLPrincipal := strSQLPrincipal + ' SELECT CLAFIS, DTAENT, NUMDOC, ESPDOC, CODEMP, NOMEMP, SEQGER, TABELA, ';
  strSQLPrincipal := strSQLPrincipal + '        DET_CODFOR, DET_SERIE_, NOME, CNPJ, NATCFO, FISINC, ';
  strSQLPrincipal := strSQLPrincipal + '        TIPO_CLIENTE_FORNECEDOR, CODIGO_CLIENTE_FORNECEDOR, ';
  strSQLPrincipal := strSQLPrincipal + '        PLANCO, FORCLI, IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, ';
  strSQLPrincipal := strSQLPrincipal + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE)           AS CODEVE, ';
  strSQLPrincipal := strSQLPrincipal + '        GER_CODEVE, DET_TIP_FC, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VLRCON, ROUND(VLRCON*D.CTP_FATCAL,2)) AS VLRCON, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALICM, ROUND(VALICM*D.CTP_FATCAL,2)) AS VALICM, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALIPI, ROUND(VALIPI*D.CTP_FATCAL,2)) AS VALIPI, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, TOTFRE, ROUND(TOTFRE*D.CTP_FATCAL,2)) AS TOTFRE, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, DESACE, ROUND(DESACE*D.CTP_FATCAL,2)) AS DESACE, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALRET, ROUND(VALRET*D.CTP_FATCAL,2)) AS VALRET, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALPIS, ROUND(VALPIS*D.CTP_FATCAL,2)) AS VALPIS, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALCOF, ROUND(VALCOF*D.CTP_FATCAL,2)) AS VALCOF, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, TOTMED, ROUND(TOTMED*D.CTP_FATCAL,2)) AS TOTMED, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, TOTITE, ROUND(TOTITE*D.CTP_FATCAL,2)) AS TOTITE, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, DESESP, ROUND(DESESP*D.CTP_FATCAL,2)) AS DESESP, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALISS, ROUND(VALISS*D.CTP_FATCAL,2)) AS VALISS, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, RECSSL, ROUND(RECSSL*D.CTP_FATCAL,2)) AS RECSSL, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, REINSS, ROUND(REINSS*D.CTP_FATCAL,2)) AS REINSS, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, REIRRF, ROUND(REIRRF*D.CTP_FATCAL,2)) AS REIRRF, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, RINSSP, ROUND(RINSSP*D.CTP_FATCAL,2)) AS RINSSP, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, LIQENT, ROUND(LIQENT*D.CTP_FATCAL,2)) AS LIQENT, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, PAGANT, ROUND(PAGANT*D.CTP_FATCAL,2)) AS PAGANT, ';

  strSQLPrincipal := strSQLPrincipal + '        VLRCON AS VLRCON_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALICM AS VALICM_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALIPI AS VALIPI_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        TOTFRE AS TOTFRE_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        DESACE AS DESACE_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALRET AS VALRET_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALPIS AS VALPIS_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALCOF AS VALCOF_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        TOTMED AS TOTMED_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        TOTITE AS TOTITE_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        DESESP AS DESESP_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        VALISS AS VALISS_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        RECSSL AS RECSSL_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        REINSS AS REINSS_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        REIRRF AS REIRRF_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        RINSSP AS RINSSP_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        LIQENT AS LIQENT_TOT, ';
  strSQLPrincipal := strSQLPrincipal + '        PAGANT AS PAGANT_TOT, ';

  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, ROUND(FATOR_GNR * VLRCON, 2), ROUND(ROUND(FATOR_GNR * VLRCON, 2) * D.CTP_FATCAL,2)) AS VALGNR, ';
  strSQLPrincipal := strSQLPrincipal + '        P.CTP_DTAPAG AS DTAPAG, ';

  if fCfgDesMva = 'S' then
  begin
    strSQLPrincipal := strSQLPrincipal + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    strSQLPrincipal := strSQLPrincipal + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    strSQLPrincipal := strSQLPrincipal + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  strSQLPrincipal := strSQLPrincipal + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VFCPST, ROUND(VFCPST*D.CTP_FATCAL,2)) AS VFCPST, ';
  strSQLPrincipal := strSQLPrincipal + '        IF(D.CTP_FATCAL IS NULL, VALFCP, ROUND(VALFCP*D.CTP_FATCAL,2)) AS VALFCP, ';
  strSQLPrincipal := strSQLPrincipal + '        NATOPE, ';
  strSQLPrincipal := strSQLPrincipal + '        GER_VALIRF, ';
  strSQLPrincipal := strSQLPrincipal + '        VALIRF, ';
  strSQLPrincipal := strSQLPrincipal + '        VAL_DIFAL ';

  if (FUsaCampoAbfCon) then
    strSQLPrincipal := strSQLPrincipal + '  ,ITE_ABFCON ';

  if fCfgConGru = 'S' then
  begin
    strSQLPrincipal := strSQLPrincipal + '  ,ITE_CODGRU ';
  end ;

  strSQLPrincipal := strSQLPrincipal + '   FROM ( ' + strSQL + ') AS TMP ';

  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN DUPAGP AGP ON AGP.CTP_NUMDUP = TMP.NUMDOC ';
  strSQLPrincipal := strSQLPrincipal + '                       AND AGP.CTP_CODEMP = TMP.CODEMP ';
  strSQLPrincipal := strSQLPrincipal + '                       AND AGP.CTP_CODFOR = TMP.FORCLI ';
  strSQLPrincipal := strSQLPrincipal + '                       AND AGP.CTP_PARCEL = "A" ';
  strSQLPrincipal := strSQLPrincipal + '                       AND IFNULL(AGP.CTP_SERIE_,"") = IFNULL(DET_SERIE_, "") ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = IF(AGP.CTP_NUMAGR IS NULL, TMP.NUMDOC, AGP.CTP_NUMAGR) ';
  strSQLPrincipal := strSQLPrincipal + '                     AND P.CTP_CODFOR = TMP.FORCLI ';
  strSQLPrincipal := strSQLPrincipal + '                     AND P.CTP_CODEMP = IF(AGP.CTP_NUMAGR IS NULL, TMP.CODEMP, AGP.CTP_EMPAGR) ';
  strSQLPrincipal := strSQLPrincipal + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(IF(AGP.CTP_NUMAGR IS NULL, TMP.DET_SERIE_, P.CTP_SERIE_), "") ';
  strSQLPrincipal := strSQLPrincipal + '                     AND P.CTP_SEQBAI = 0 ';
  strSQLPrincipal := strSQLPrincipal + '                     AND P.CTP_PARCEL = "A" ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CTPDET D ON CASE WHEN AGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE AGP.CTP_CODFOR END = D.CTP_CODFOR ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE AGP.CTP_NUMDUP END = D.CTP_NUMDUP ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE AGP.CTP_PARCEL END = D.CTP_PARCEL ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE AGP.CTP_CODEMP END = D.CTP_EMPORI ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_,"")) ELSE TRIM(COALESCE(AGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQLPrincipal := strSQLPrincipal + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, TMP.CODEMP, D.CTP_CODEMP)', 'TMP.CODEMP') ;

  // Linhas do mesmo grupo em sequência: o rateio de fEfetuaLancamentos fecha o grupo quando
  // fChaveRateio muda. TABELA e FISINC porque MOVGER e NOTGER repetem o SEQGER.
  strSQLPrincipal := strSQLPrincipal + '   ORDER BY SEQGER, TABELA, FISINC, CLAFIS ';
  if (FUsaCampoAbfCon) then
    strSQLPrincipal := strSQLPrincipal + ', ITE_ABFCON ';
  if fCfgConGru = 'S' then
    strSQLPrincipal := strSQLPrincipal + ', ITE_CODGRU ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQLPrincipal);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConENT.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConENT.fEfetuaLancamentos: Boolean;
  Var
    strPlaCta : String;
    strCodEve: String;
    strNatCfo : string;
    strEveNec: string;
    LstrNatOpe: string;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;
  FcdsTravaGnreDuplicada := fRetornaTravaRegistroDuplicadoGNRE ;
  pCarregaEntAdt;
  pAjustaValorIRRF;
  strIncDoc := '' ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if FCdsEntAdt.FindKey([qryDados.FieldByName('SEQGER').AsString, qryDados.FieldByName('TABELA').AsString]) then
    begin
      qryDados.Next;
      Continue;
    end;

    if (qryDados.FieldByName('DET_TIP_FC').AsString = 'C') then
      strCodEve := qryDados.FieldByName('GER_CODEVE').AsString
    else
      strCodEve := qryDados.FieldByName('CODEVE').AsString;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(strCodEve, 'ENT', qryDados.FieldByName('CLAFIS').AsString).fConsultaEvento(FstrCentroCustoDefault);

    if (not fEmptyStr(strEveNec)) and (not fEmptyStr(strCodEve))
       and (Pos(strCodEve, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+strCodEve+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    if fEhGNREDuplicada(qryDados.FieldByName('FISINC').AsString) then
    begin
      Generico.pAdicionarWarning('GNRE [Doc:' + FcdsTravaGnreDuplicada.FieldByName('GNR_NUMDOC').AsString + '/Forn:' + FcdsTravaGnreDuplicada.FieldByName('GNR_CODFOR').AsString + '] associada ao lançamento, foi lançada em duplicidade!', qryDados, '', '', '', '', '', '', False);
      qryDados.Next;
      Continue;
    end ;

    fltVlrCon   := qryDados.FieldByName('VLRCON_TOT').AsFloat;
    fltValIcm   := qryDados.FieldByName('VALICM_TOT').AsFloat;
    fltValIpi   := qryDados.FieldByName('VALIPI_TOT').AsFloat;
    fltTotFre   := qryDados.FieldByName('TOTFRE_TOT').AsFloat;
    fltDesAce   := qryDados.FieldByName('DESACE_TOT').AsFloat;
    fltValRet   := qryDados.FieldByName('VALRET_TOT').AsFloat;
    fltValPis   := qryDados.FieldByName('VALPIS_TOT').AsFloat;
    fltValCof   := qryDados.FieldByName('VALCOF_TOT').AsFloat;
    fltTotMed   := qryDados.FieldByName('TOTMED_TOT').AsFloat;
    fltTotIte   := qryDados.FieldByName('TOTITE_TOT').AsFloat;
    fltDesEsp   := qryDados.FieldByName('DESESP_TOT').AsFloat;
    fltValIss   := qryDados.FieldByName('VALISS_TOT').AsFloat;
    fltRecSsl   := qryDados.FieldByName('RECSSL_TOT').AsFloat;
    fltReInss   := qryDados.FieldByName('REINSS_TOT').AsFloat;
    fltReIrrf   := qryDados.FieldByName('REIRRF_TOT').AsFloat;
    fltRinssP   := qryDados.FieldByName('RINSSP_TOT').AsFloat;
    fltLiqEnt   := qryDados.FieldByName('LIQENT_TOT').AsFloat;
    fltPagAnt   := qryDados.FieldByName('PAGANT_TOT').AsFloat;

    if fChaveRateio <> strIncDoc then
    begin
      strIncDoc := fChaveRateio;
      pZerarValores;
    end;
    pSomarValores;

    qryDados.Next;
    if (fChaveRateio <> strIncDoc) or (qryDados.Eof) then
    begin
      if not qryDados.Eof then
        qryDados.Prior;

      fltDifVlrCon := fFormataFloat(fltVlrCon - fltRatVlrCon, 2) ;
      fltDifValIcm := fFormataFloat(fltValIcm - fltRatValIcm, 2) ;
      fltDifValIpi := fFormataFloat(fltValIpi - fltRatValIpi, 2) ;
      fltDifTotFre := fFormataFloat(fltTotFre - fltRatTotFre, 2) ;
      fltDifDesAce := fFormataFloat(fltDesAce - fltRatDesAce, 2) ;
      fltDifValRet := fFormataFloat(fltValRet - fltRatValRet, 2) ;
      fltDifValPis := fFormataFloat(fltValPis - fltRatValPis, 2) ;
      fltDifValCof := fFormataFloat(fltValCof - fltRatValCof, 2) ;
      fltDifTotMed := fFormataFloat(fltTotMed - fltRatTotMed, 2) ;
      fltDifTotIte := fFormataFloat(fltTotIte - fltRatTotIte, 2) ;
      fltDifDesEsp := fFormataFloat(fltDesEsp - fltRatDesEsp, 2) ;
      fltDifValIss := fFormataFloat(fltValIss - fltRatValIss, 2) ;
      fltDifRecSsl := fFormataFloat(fltRecSsl - fltRatRecSsl, 2) ;
      fltDifReInss := fFormataFloat(fltReInss - fltRatReInss, 2) ;
      fltDifReIrrf := fFormataFloat(fltReIrrf - fltRatReIrrf, 2) ;
      fltDifRInssp := fFormataFloat(fltRInssp - fltRatRInssp, 2) ;
      fltDifLiqEnt := fFormataFloat(fltLiqEnt - fltRatLiqEnt, 2) ;
      fltDifPagAnt := fFormataFloat(fltPagAnt - fltRatPagAnt, 2) ;

      if (fltDifVlrCon <> 0) or
         (fltDifValIcm <> 0) or
         (fltDifValIpi <> 0) or
         (fltDifTotFre <> 0) or
         (fltDifDesAce <> 0) or
         (fltDifValRet <> 0) or
         (fltDifValPis <> 0) or
         (fltDifValCof <> 0) or
         (fltDifTotMed <> 0) or
         (fltDifTotIte <> 0) or
         (fltDifDesEsp <> 0) or
         (fltDifValIss <> 0) or
         (fltDifRecSsl <> 0) or
         (fltDifReInss <> 0) or
         (fltDifReIrrf <> 0) or
         (fltDifRInssp <> 0) or
         (fltDifLiqEnt <> 0) or
         (fltDifPagAnt <> 0)  then
      begin
        pAlterarValores;
      end;
    end
    else
    begin
      qryDados.Prior;
    end;

    strNatCfo := '';
    if Assigned(qryDados.FindField('NATCFO')) then
      strNatCfo := qryDados.FieldByName('NATCFO').AsString;

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    LstrNatOpe := qryDados.FieldByName('NATOPE').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALIPI', 'Vr.IPI', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('TOTFRE', 'Vr.Frete', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('DESACE', 'Vr.Desp.Acessórias', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALRET', 'Vr.Sub.Tributária', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('TOTMED', DES_VALOR_CMV, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('RINSSP', DES_VALOR_INSS_PATRONAL, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALGNR', DES_VALOR_GNRE, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('PAGANT', 'Vl.Adiantamento', strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VFCPST', DES_VALOR_FCP_ST, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALFCP', DES_VALOR_FCP, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VALIRF', DES_VALOR_RET_IRRF, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    Generico.pGravaLancto('VAL_DIFAL', DES_VALOR_DIFAL, strPlaCta, '', strCodEve, '', '', strNatCfo, LstrNatOpe);
    qryDados.Next;
  End;

  Result := True;
end;

function TLanConENT.fChaveRateio: string;
begin
  // Separa exatamente o que o GROUP BY de fCarregaDados separa. Só nota + CFOP fazia a
  // diferença de um grupo ser lançada como desconto no outro, com as contas invertidas.
  // Nulo tem marca própria porque o AsString o confunde com vazio.
  Result := qryDados.FieldByName('FISINC').AsString + qryDados.FieldByName('CLAFIS').AsString;
  if Assigned(qryDados.FindField('ITE_ABFCON')) then
  begin
    if qryDados.FieldByName('ITE_ABFCON').IsNull then
      Result := Result + '|#'
    else
      Result := Result + '|' + qryDados.FieldByName('ITE_ABFCON').AsString;
  end;
  if Assigned(qryDados.FindField('ITE_CODGRU')) then
  begin
    if qryDados.FieldByName('ITE_CODGRU').IsNull then
      Result := Result + '|#'
    else
      Result := Result + '|' + qryDados.FieldByName('ITE_CODGRU').AsString;
  end;
end;

function TLanConENT.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConENT.fEhGNREDuplicada(const AstrFisInc: string): Boolean;
begin
  Result := False ;
  if not Assigned(FcdsTravaGnreDuplicada) then
    exit ;

  if not FcdsTravaGnreDuplicada.FindKey([AstrFisInc]) then
    exit ;

  Result := True ;
end;

procedure TLanConENT.pAjustaValorIRRF;
  Var
    dicDocs: TDictionary<String,Double>;
    fltTotIrf: Double;
    strIncDoc: String;
begin
  dicDocs := TDictionary<String,Double>.Create;
  Try
    qryDados.Filtered := False;
    qryDados.Filter   := 'GER_VALIRF > 0';
    qryDados.Filtered := True;

    If qryDados.IsEmpty Then
      Exit;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      dicDocs.AddOrSetValue(qryDados.FieldByName('SEQGER').AsString,
                            qryDados.FieldByName('GER_VALIRF').AsFloat);
      qryDados.Next;
    End;

    For strIncDoc In dicDocs.Keys Do
    Begin
      qryDados.Filtered := False;
      qryDados.Filter   := 'SEQGER = '+ strIncDoc.QuotedString;
      qryDados.Filtered := True;

      fltTotIrf := 0;

      qryDados.First;
      While Not qryDados.Eof Do
      Begin
        fltTotIrf := fltTotIrf + qryDados.FieldByName('VALIRF').AsFloat;
        qryDados.Next;
      End;

      //ajusta a diferença no último item de cada documento
      If Not SameValue(fltTotIrf, dicDocs[strIncDoc]) Then
      Begin
        qryDados.Edit;
        qryDados.FieldByName('VALIRF').AsFloat := qryDados.FieldByName('VALIRF').AsFloat +
                                                  (dicDocs[strIncDoc] - fltTotIrf);
        qryDados.Post;
      End;
    End;
  Finally
    dicDocs.Free;
    qryDados.Filter := '';
    qryDados.Filtered := False;
  End;
end;

function TLanConENT.fRetornaSQLNaurezaOperacao: string;
begin
  result := '' ;
  if FUsaCampoNatOpeMovTri then
  begin
    result := result + '      IFNULL(MOVTRI.DET_NATOPE,"") AS NATCFO, ' ;
    exit ;
  end ;

  if fCfgNatDsc = 'N' then
  begin
    if FUsaCampoNatCfo then
    begin
      result := result + '      IFNULL(AUX_NATCFO,"") AS NATCFO, ' ;
    end
    else
    begin
      result := result + '      "" AS NATCFO, ';
    end;
  end
  else
  begin
    result := result + '      IFNULL(GER_NATOPE,"") AS NATCFO, ' ;
  end ;
end;

function TLanConENT.fRetornaTravaRegistroDuplicadoGNRE: TUniClientDataSet;
var
  LstrSql: String ;
  LstrSqlExec: String ;
  LqryConsulta: TUniQuery ;
begin
  LstrSqlExec := '' ;
  LstrSql := '' ;
  LstrSql := LstrSql + ' SELECT DISTINCT CADGNR.AUTOINCREM, CADGNR.GNR_AUTFIS, CADGNR.GNR_NUMDOC, CADGNR.GNR_CODFOR ' ;
  LstrSql := LstrSql + ' FROM MOVDET ' ;
  LstrSql := LstrSql + '     INNER JOIN MOVGER ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ' ;
  LstrSql := LstrSql + '     INNER JOIN CADFIS  ON FIS_NUMDOC = DET_NUMDOC ' ;
  LstrSql := LstrSql + '       AND FIS_ESPDOC = DET_ESPDOC ' ;
  LstrSql := LstrSql + '       AND FIS_CODEMP = DET_CODEMP ' ;
  LstrSql := LstrSql + '       AND FIS_TIP_FC = DET_TIP_FC ' ;
  LstrSql := LstrSql + '       AND FIS_FORCLI = IFNULL(DET_CODCLI, DET_CODFOR) ' ;
  LstrSql := LstrSql + '       AND FIS_ORIDOC = DET_ORIDOC ' ;
  LstrSql := LstrSql + '       AND IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ' ;
  LstrSql := LstrSql + '     INNER JOIN CADGNR ON GNR_AUTFIS = CADFIS.AUTOINCREM ' ;
  LstrSql := LstrSql + ' WHERE TRUE ' ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    LstrSql := LstrSql + '  AND DET_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    LstrSql := LstrSql + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  LstrSql := LstrSql + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('MOVDET.DET_SEQGER')
                        .fIncDoc(recParCon.strIncDoc)
                        .fArrIncDoc(recParCon.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  LstrSql := LstrSql + '    AND LEFT(DET_CLAFIS, 1) < "5" ' ;
  LstrSql := LstrSql + '    AND RIGHT(DET_CLAFIS, 3) NOT IN ("933", ' + fListaCfopsOutrasEntradas + ') ' ;
  LstrSql := LstrSql + '    AND DET_ESPDOC IN ("NF", "NS", "NV", "IF", "IV", "D1", "EL")' ;

  if fEmptyStr(recParCon.strTabela) then
    LstrSql := LstrSql + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(LstrSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER')
  else if (recParCon.strTabela = 'NOTGER') then
    LstrSql := AnsiReplaceStr(AnsiReplaceStr(LstrSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  LstrSqlExec := LstrSqlExec + 'SELECT GNR_AUTFIS, GNR_NUMDOC, GNR_CODFOR, COUNT(*) AS CNT FROM ( ' ;
  LstrSqlExec := LstrSqlExec + LstrSql ;
  LstrSqlExec := LstrSqlExec + ' ) AS SEL ' ;
  LstrSqlExec := LstrSqlExec + ' GROUP BY GNR_AUTFIS ' ;
  LstrSqlExec := LstrSqlExec + ' HAVING COUNT(*) > 1 ' ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(LstrSqlExec) ;
    pSetaParametrosGerLanCon(recParCon, LqryConsulta);
    LqryConsulta.Open ;

    Result := fCriaClientDatset(LqryConsulta) ;
    Result.IndexFieldNames := 'GNR_AUTFIS' ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;

end;

function TLanConENT.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConENT.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConENT.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Entrada de Mercadoria Concluída!', ['&OK']);
end;

procedure TLanConENT.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConENT.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

procedure TLanConENT.pZerarValores;
begin
  fltRatVlrCon := 0;
  fltRatValIcm := 0;
  fltRatValIpi := 0;
  fltRatTotFre := 0;
  fltRatDesAce := 0;
  fltRatValRet := 0;
  fltRatValPis := 0;
  fltRatValCof := 0;
  fltRatTotMed := 0;
  fltRatTotIte := 0;
  fltRatDesEsp := 0;
  fltRatValIss := 0;
  fltRatRecSsl := 0;
  fltRatReInss := 0;
  fltRatReIrrf := 0;
  fltRatRInssp := 0;
  fltRatLiqEnt := 0;
  fltRatPagAnt := 0;

  fltDifVlrCon := 0;
  fltDifValIcm := 0;
  fltDifValIpi := 0;
  fltDifTotFre := 0;
  fltDifDesAce := 0;
  fltDifValRet := 0;
  fltDifValPis := 0;
  fltDifValCof := 0;
  fltDifTotMed := 0;
  fltDifTotIte := 0;
  fltDifDesEsp := 0;
  fltDifValIss := 0;
  fltDifRecSsl := 0;
  fltDifReInss := 0;
  fltDifReIrrf := 0;
  fltDifRInssp := 0;
  fltDifLiqEnt := 0;
  fltDifPagAnt := 0;

end;

procedure TLanConENT.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConENT.pSomarValores;
begin
  fltRatVlrCon := fltRatVlrCon + qryDados.FieldByName('VLRCON').AsFloat;
  fltRatValIcm := fltRatValIcm + qryDados.FieldByName('VALICM').AsFloat;
  fltRatValIpi := fltRatValIpi + qryDados.FieldByName('VALIPI').AsFloat;
  fltRatTotFre := fltRatTotFre + qryDados.FieldByName('TOTFRE').AsFloat;
  fltRatDesAce := fltRatDesAce + qryDados.FieldByName('DESACE').AsFloat;
  fltRatValRet := fltRatValRet + qryDados.FieldByName('VALRET').AsFloat;
  fltRatValPis := fltRatValPis + qryDados.FieldByName('VALPIS').AsFloat;
  fltRatValCof := fltRatValCof + qryDados.FieldByName('VALCOF').AsFloat;
  fltRatTotMed := fltRatTotMed + qryDados.FieldByName('TOTMED').AsFloat;
  fltRatTotIte := fltRatTotIte + qryDados.FieldByName('TOTITE').AsFloat;
  fltRatDesEsp := fltRatDesEsp + qryDados.FieldByName('DESESP').AsFloat;
  fltRatValIss := fltRatValIss + qryDados.FieldByName('VALISS').AsFloat;
  fltRatRecSsl := fltRatRecSsl + qryDados.FieldByName('RECSSL').AsFloat;
  fltRatReInss := fltRatReInss + qryDados.FieldByName('REINSS').AsFloat;
  fltRatReIrrf := fltRatReIrrf + qryDados.FieldByName('REIRRF').AsFloat;
  fltRatRInssp := fltRatRInssp + qryDados.FieldByName('RINSSP').AsFloat;
  fltRatLiqEnt := fltRatLiqEnt + qryDados.FieldByName('LIQENT').AsFloat;
  fltratPagAnt := fltratPagAnt + qryDados.FieldByName('PAGANT').AsFloat;
end;

procedure TLanConENT.pAlterarValores;
begin
  qryDados.Edit;
  if fltDifVlrCon <> 0 then
    qryDados.FieldByName('VLRCON').AsFloat := qryDados.FieldByName('VLRCON').AsFloat + fltDifVlrCon ;
  if fltDifValIcm <> 0 then
    qryDados.FieldByName('VALICM').AsFloat := qryDados.FieldByName('VALICM').AsFloat + fltDifValIcm ;
  if fltDifValIpi <> 0 then
    qryDados.FieldByName('VALIPI').AsFloat := qryDados.FieldByName('VALIPI').AsFloat + fltDifValIpi ;
  if fltDifTotFre <> 0 then
    qryDados.FieldByName('TOTFRE').AsFloat := qryDados.FieldByName('TOTFRE').AsFloat + fltDifTotFre ;
  if fltDifDesAce <> 0 then
    qryDados.FieldByName('DESACE').AsFloat := qryDados.FieldByName('DESACE').AsFloat + fltDifDesAce ;
  if fltDifValRet <> 0 then
    qryDados.FieldByName('VALRET').AsFloat := qryDados.FieldByName('VALRET').AsFloat + fltDifValRet ;
  if fltDifValPis <> 0 then
    qryDados.FieldByName('VALPIS').AsFloat := qryDados.FieldByName('VALPIS').AsFloat + fltDifValPis ;
  if fltDifValCof <> 0 then
    qryDados.FieldByName('VALCOF').AsFloat := qryDados.FieldByName('VALCOF').AsFloat + fltDifValCof ;
  if fltDifTotMed <> 0 then
    qryDados.FieldByName('TOTMED').AsFloat := qryDados.FieldByName('TOTMED').AsFloat + fltDifTotMed ;
  if fltDifTotIte <> 0 then
    qryDados.FieldByName('TOTITE').AsFloat := qryDados.FieldByName('TOTITE').AsFloat + fltDifTotIte ;
  if fltDifDesEsp <> 0 then
    qryDados.FieldByName('DESESP').AsFloat := qryDados.FieldByName('DESESP').AsFloat + fltDifDesEsp ;
  if fltDifValIss <> 0 then
    qryDados.FieldByName('VALISS').AsFloat := qryDados.FieldByName('VALISS').AsFloat + fltDifValIss ;
  if fltDifRecSsl <> 0 then
    qryDados.FieldByName('RECSSL').AsFloat := qryDados.FieldByName('RECSSL').AsFloat + fltDifRecSsl ;
  if fltDifReInss <> 0 then
    qryDados.FieldByName('REINSS').AsFloat := qryDados.FieldByName('REINSS').AsFloat + fltDifReInss ;
  if fltDifReIrrf <> 0 then
    qryDados.FieldByName('REIRRF').AsFloat := qryDados.FieldByName('REIRRF').AsFloat + fltDifReIrrf ;
  if fltDifRInssP <> 0 then
    qryDados.FieldByName('RINSSP').AsFloat := qryDados.FieldByName('RINSSP').AsFloat + fltDifRInssP ;
  if fltDifLiqEnt <> 0 then
    qryDados.FieldByName('LIQENT').AsFloat := qryDados.FieldByName('LIQENT').AsFloat + fltDifLiqEnt ;
  if fltDifPagAnt <> 0 then
    qryDados.FieldByName('PAGANT').AsFloat := qryDados.FieldByName('PAGANT').AsFloat + fltDifPagAnt ;
  qryDados.Post;
end;

procedure TLanConENT.pCarregaEntAdt;
begin
  if Assigned(FCdsEntAdt) then
    FreeandNil(FCdsEntAdt);

  FCdsentAdt := fCarregaEntAdt(recParCon);
end;

end.
