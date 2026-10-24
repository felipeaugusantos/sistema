unit Contabilidade.Classes.TLanConENTADT;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet, Contabilidade.Interfaces,
     System.Generics.Collections, System.Math;

type
  TLanConENTADT = Class(TInterfacedObject, ITipLanCon)
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
    fltRatRInssp : double ;
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
    fltDifRInssp : double ;
    fltDifLiqEnt : double ;
    fltDifPagAnt : double ;
    FstrCentroCustoDefault : String ;
    FCdsEntAdt: TUniClientDataset;
    FCdsTotCadPag: TUniClientDataset;
    procedure pZerarValores;
    procedure pSomarValores;
    procedure pAlterarValores;
    procedure pAjustarValorProporcionalParcela;
    procedure pCarregaEntAdt;
    procedure pCarregaTotCadPag;
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

  TLanConServicoEntradaADT = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FCampoDupAgp_CodEve_Existe : Boolean;
    FCampoDupAgp_PagAnt_Existe : Boolean;
    fltVlrCon : double ;
    fltValIcm : double ;
    fltValPis : double ;
    fltValCof : double ;
    fltVrePis : double ;
    fltVreCof : double ;
    fltRetIss : double ;
    fltReCssl : double ;
    fltReIrrf : double ;
    fltRInssp : double ;
    fltReInss : double ;
    fltLiqEnt : double ;
    fltLiqCon : double ;
    strIncDoc : string ;
    fltRatVlrCon : double ;
    fltRatValIcm : double ;
    fltRatValPis : double ;
    fltRatValCof : double ;
    fltRatVrePis : double ;
    fltRatVreCof : double ;
    fltRatRetIss : double ;
    fltRatReCssl : double ;
    fltRatReIrrf : double ;
    fltRatRInssp : double ;
    fltRatReInss : double ;
    fltRatLiqEnt : double ;
    fltRatLiqCon : double ;

    fltDifVlrCon : double ;
    fltDifValIcm : double ;
    fltDifValPis : double ;
    fltDifValCof : double ;
    fltDifVrePis : double ;
    fltDifVreCof : double ;
    fltDifRetIss : double ;
    fltDifReCssl : double ;
    fltDifReIrrf : double ;
    fltDifRInssp : double ;
    fltDifReInss : double ;
    fltDifLiqEnt : double ;
    fltDifLiqCon : double ;
    FstrCentroCustoDefault : String ;
    FblnFIS_VRECOF: Boolean ;
    FblnFIS_VREPIS: Boolean ;
    FCdsServicoAdt: TUniClientDataset;
    FCdsTotCadPag: TUniClientDataset;
    FColunasValorContabil: TSetColunasValorLiquidoContabil ;
    function fFieldMensagemValidacao:string;
    procedure pZerarValores;
    procedure pSomarValores;
    procedure pAlterarValores;
    procedure pAjustarValorProporcionalParcela;
    procedure pCarregaServicoAdt;
    procedure pCarregaTotCadPag;
    function fPreparaSqlUnions(const AintColuna: integer): string ;
    function fRetornaFiltroDupAgpPagAnt: string ;
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

uses Forms, SysUtils, StrUtils, Generics.Collections, untFuncoesSimples, Contabilidade.Funcoes,
     Contabilidade.Classes.TEventoContabil, Contabilidade.Classes.TTrataIncDoc;

{ TLanConENTADT }

constructor TLanConENTADT.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
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
  FcdsEntAdt := Nil;
  FCdsTotCadPag := Nil;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConENTADT.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FcdsTravaGnreDuplicada) then
    FreeAndNil(FcdsTravaGnreDuplicada);
  if Assigned(FCdsEntAdt) then
    FreeAndNil(FCdsEntAdt);
  if Assigned(FCdsTotCadPag) then
    FreeAndNil(FCdsTotCadPag);
  inherited;
end;

function TLanConENTADT.fCarregaDados: Boolean;
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
  strSQL := strSQL + ' SELECT DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, GER_CODEVE, DET_TIP_FC, GER_VLRCON, ';
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
    strSql := strSql + '  AND DET_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSql := strSql + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVDET.DET_SEQGER')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSql := strSql + '    AND LEFT(DET_CLAFIS, 1) < "5" ';
  strSql := strSql + '    AND RIGHT(DET_CLAFIS, 3) NOT IN ("933", ' + fListaCfopsOutrasEntradas + ') ';
  strSql := strSql + '    AND DET_ESPDOC IN ("NF", "NS", "NV", "IF", "IV", "D1", "EL") ';

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
  strSQLPrincipal := strSQLPrincipal + '        GER_CODEVE, DET_TIP_FC,  ';
  strSQLPrincipal := strSQLPrincipal + '        IFNULL(P.CTP_VALORI, 0.00) AS CTP_VALORI, GER_VLRCON, ';

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
  strSQLPrincipal := strSQLPrincipal + '        P.CTP_DTAPAG AS DTAPAG, IFNULL(P.CTP_PARCEL, "") AS CTP_PARCEL, ';
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
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CTPDET D ON CASE WHEN AGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE AGP.CTP_CODFOR END = D.CTP_CODFOR ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE AGP.CTP_NUMDUP END = D.CTP_NUMDUP ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE AGP.CTP_PARCEL END = D.CTP_PARCEL ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE AGP.CTP_CODEMP END = D.CTP_EMPORI ';
  strSQLPrincipal := strSQLPrincipal + '                         AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_,"")) ELSE TRIM(COALESCE(AGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQLPrincipal := strSQLPrincipal + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQLPrincipal := strSQLPrincipal + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, TMP.CODEMP, D.CTP_CODEMP)', 'TMP.CODEMP') ;

  // Parcelas do mesmo grupo em sequência: o rateio de fEfetuaLancamentos fecha o grupo quando
  // fChaveRateio muda, e ordenar direto pela parcela intercalava os grupos. TABELA e FISINC
  // porque MOVGER e NOTGER repetem o SEQGER.
  strSQLPrincipal := strSQLPrincipal + '   ORDER BY SEQGER, TABELA, FISINC, CLAFIS, ';
  if (FUsaCampoAbfCon) then
    strSQLPrincipal := strSQLPrincipal + 'ITE_ABFCON, ';
  if fCfgConGru = 'S' then
    strSQLPrincipal := strSQLPrincipal + 'ITE_CODGRU, ';
  strSQLPrincipal := strSQLPrincipal + 'CTP_PARCEL ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQLPrincipal);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConENTADT.fDeletaLanCon: Boolean;
begin
  Result := True ;
end;

function TLanConENTADT.fEfetuaLancamentos: Boolean;
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
  pCarregaTotCadPag;
  pAjustaValorIRRF;
  strIncDoc := '' ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if not FCdsEntAdt.FindKey([qryDados.FieldByName('SEQGER').AsString, qryDados.FieldByName('TABELA').AsString]) then
    begin
      qryDados.Next;
      Continue;
    end;

    if not FCdsTotCadPag.FindKey([qryDados.FieldByName('SEQGER').AsString, qryDados.FieldByName('TABELA').AsString]) then
    begin
      Generico.pAdicionarWarning('Não encontrado registro cadpag ref. ao doc. [' + qryDados.FieldByName('SEQGER').AsString +']', qryDados, '', '', '', '', '', '', False);
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
    fltRInssp   := qryDados.FieldByName('RINSSP_TOT').AsFloat;
    fltLiqEnt   := qryDados.FieldByName('LIQENT_TOT').AsFloat;
    fltPagAnt   := qryDados.FieldByName('PAGANT_TOT').AsFloat;

    if fChaveRateio <> strIncDoc then
    begin
      strIncDoc := fChaveRateio;
      pZerarValores;
    end;
    pAjustarValorProporcionalParcela;
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

function TLanConENTADT.fChaveRateio: string;
begin
  // Separa exatamente o que o GROUP BY e o ORDER BY de fCarregaDados separam. Só nota + CFOP
  // fazia a diferença de um grupo ser lançada como desconto no outro, com as contas invertidas.
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

function TLanConENTADT.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConENTADT.fEhGNREDuplicada(const AstrFisInc: string): Boolean;
begin
  Result := False ;
  if not Assigned(FcdsTravaGnreDuplicada) then
    exit ;

  if not FcdsTravaGnreDuplicada.FindKey([AstrFisInc]) then
    exit ;

  Result := True ;
end;

procedure TLanConENTADT.pAjustaValorIRRF;
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

function TLanConENTADT.fRetornaSQLNaurezaOperacao: string;
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

function TLanConENTADT.fRetornaTravaRegistroDuplicadoGNRE: TUniClientDataSet;
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

function TLanConENTADT.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConENTADT.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConENTADT.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Entrada de Mercadoria Concluída!', ['&OK']);
end;

procedure TLanConENTADT.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConENTADT.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

procedure TLanConENTADT.pZerarValores;
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
  fltRatRInssP := 0;
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

procedure TLanConENTADT.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConENTADT.pSomarValores;
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

procedure TLanConENTADT.pAjustarValorProporcionalParcela;
var
  LRazaoParcela: Extended;
begin
  LRazaoParcela := 1;

  if (qryDados.FieldByName('CTP_VALORI').AsFloat <> 0) and (FCdsTotCadPag.FieldByName('CTP_VALORI_TOT').AsFloat <> 0) then
    LRazaoParcela := qryDados.FieldByName('CTP_VALORI').AsFloat / FCdsTotCadPag.FieldByName('CTP_VALORI_TOT').AsFloat ;

  if LRazaoParcela >= 1 then
    exit;

  qryDados.Edit;
  qryDados.FieldByName('VLRCON').AsFloat := fFormataFloat(qryDados.FieldByName('VLRCON').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALICM').AsFloat := fFormataFloat(qryDados.FieldByName('VALICM').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALIPI').AsFloat := fFormataFloat(qryDados.FieldByName('VALIPI').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('TOTFRE').AsFloat := fFormataFloat(qryDados.FieldByName('TOTFRE').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('DESACE').AsFloat := fFormataFloat(qryDados.FieldByName('DESACE').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALRET').AsFloat := fFormataFloat(qryDados.FieldByName('VALRET').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALPIS').AsFloat := fFormataFloat(qryDados.FieldByName('VALPIS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALCOF').AsFloat := fFormataFloat(qryDados.FieldByName('VALCOF').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('TOTMED').AsFloat := fFormataFloat(qryDados.FieldByName('TOTMED').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('TOTITE').AsFloat := fFormataFloat(qryDados.FieldByName('TOTITE').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('DESESP').AsFloat := fFormataFloat(qryDados.FieldByName('DESESP').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALISS').AsFloat := fFormataFloat(qryDados.FieldByName('VALISS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('RECSSL').AsFloat := fFormataFloat(qryDados.FieldByName('RECSSL').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('REINSS').AsFloat := fFormataFloat(qryDados.FieldByName('REINSS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('REIRRF').AsFloat := fFormataFloat(qryDados.FieldByName('REIRRF').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('RINSSP').AsFloat := fFormataFloat(qryDados.FieldByName('RINSSP').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('LIQENT').AsFloat := fFormataFloat(qryDados.FieldByName('LIQENT').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('PAGANT').AsFloat := fFormataFloat(qryDados.FieldByName('PAGANT').AsFloat * LRazaoParcela, 2);
  qryDados.Post;
end;

procedure TLanConENTADT.pAlterarValores;
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
  if fltDifRInssp <> 0 then
    qryDados.FieldByName('RINSSP').AsFloat := qryDados.FieldByName('RINSSP').AsFloat + fltDifRInssp ;
  if fltDifLiqEnt <> 0 then
    qryDados.FieldByName('LIQENT').AsFloat := qryDados.FieldByName('LIQENT').AsFloat + fltDifLiqEnt ;
  if fltDifPagAnt <> 0 then
    qryDados.FieldByName('PAGANT').AsFloat := qryDados.FieldByName('PAGANT').AsFloat + fltDifPagAnt ;
  qryDados.Post;
end;

procedure TLanConENTADT.pCarregaEntAdt;
begin
  if Assigned(FCdsEntAdt) then
    FreeAndNil(FCdsEntAdt);

  FCdsEntAdt := fCarregaEntAdt(recParCon);
end;

procedure TLanConENTADT.pCarregaTotCadPag;
var
  strSQL: string;
  qryAux: TUniQuery;
begin
  if Assigned(FCdsTotCadPag) then
    FreeAndNil(FCdsTotCadPag);

  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    strSql := strSql + 'SELECT MOVGER.AUTOINCREM AS SEQGER, "MOVGER" AS TABELA, ';
    strSql := strSql + '  SUM(CTP_VALORI) AS CTP_VALORI_TOT ';
    strSql := strSql + 'FROM CADPAG ';
    strSql := strSql + 'INNER JOIN MOVGER ';
    strSql := strSql + '  ON GER_NUMDOC = CTP_NUMDUP ';
    strSql := strSql + '  AND GER_CODFOR = CTP_CODFOR ';
    strSql := strSql + '  AND GER_CODEMP = CTP_CODEMP ';
    strSql := strSql + '  AND IFNULL(GER_SERIE_, "") = IFNULL(CTP_SERIE_, "") ';
    strSql := strSql + 'WHERE TRUE ';

    If Not fEmptyStr(recParCon.strCodEmp) Then
      strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSql := strSql + 'GROUP BY MOVGER.AUTOINCREM ';

    if fEmptyStr(recParCon.strTabela) then
      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER')
    else if (recParCon.strTabela = 'NOTGER') then
      strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');

    qryAux.SQL.Add(strSQL);

    pSetaParametrosGerLanCon(recParCon, qryAux);

    qryAux.Open;

    FCdsTotCadPag := fCriaClientDatset(qryAux) ;
    FCdsTotCadPag.IndexFieldNames := 'SEQGER;TABELA';
  finally
    FreeAndNil(qryAux);
  end;
end;

{ TLanConServicoEntradaADT }

constructor TLanConServicoEntradaADT.Create(strTipLan: String;
  pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FCampoDupAgp_CodEve_Existe := fCampoExiste('DUPAGP', 'CTP_CODEVE');
  FCampoDupAgp_PagAnt_Existe := fCampoExiste('DUPAGP', 'CTP_PAGANT');
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
  FblnFIS_VRECOF := fCampoExiste('CADFIS', 'FIS_VRECOF') ;
  FblnFIS_VREPIS := fCampoExiste('CADFIS', 'FIS_VREPIS') ;
  FCdsTotCadPag := Nil;
  FCdsServicoAdt := Nil;
  FColunasValorContabil := [Low(TColunasValorLiquidoContabil)..High(TColunasValorLiquidoContabil)];
  pVerificaColunasExitemValorContabil(FColunasValorContabil) ;
end;

destructor TLanConServicoEntradaADT.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FCdsTotCadPag) then
    FreeAndNil(FCdsTotCadPag);
  if Assigned(FCdsServicoAdt) then
    FreeAndNil(FCdsServicoAdt);
  inherited;
end;

function TLanConServicoEntradaADT.fCarregaDados: Boolean;
  Var
    strSQL : String;
    LintCnt : Integer;
    LlstComCfopServico: TList<Integer> ;
begin
  strSQL := '';
  LlstComCfopServico := fColunasComCfopServico(recParCon, 'E') ;
  try
    for LintCnt in LlstComCfopServico do
    begin
      strSQL := strSQL + ifthen(LlstComCfopServico.count = 1, '', '(') ;
      strSQL := strSQL + fPreparaSqlUnions(LintCnt) ;
      strSQL := strSQL + ifthen(LlstComCfopServico.count = 1, '', ')') ;
      if LlstComCfopServico.count > 1 then
        strSQL := strSQL + iif(LintCnt <> LlstComCfopServico.Items[LlstComCfopServico.Count-1], ' UNION ', '') ;
    end ;
  finally
    FreeAndNil(LlstComCfopServico) ;
  end ;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConServicoEntradaADT.fDeletaLanCon: Boolean;
begin
  Result := True;
end;

function TLanConServicoEntradaADT.fEfetuaLancamentos: Boolean;
  Var
    strPlaCta : String;
    strCodEve : String;
    strEveNec: string;
    LstrNatCfo: String;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;
  pCarregaServicoAdt;
  pCarregaTotCadPag;
  strIncDoc := '' ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if not FCdsServicoAdt.FindKey([qryDados.FieldByName('FISINC').AsString]) then
    begin
      qryDados.Next;
      Continue;
    end;

    if not FCdsTotCadPag.FindKey([qryDados.FieldByName('FISINC').AsString]) then
    begin
      Generico.pAdicionarWarning('Não encontrado registro cadpag ref. ao doc. [' + qryDados.FieldByName('FISINC').AsString +']', qryDados, '', '', '', '', '', '', False);
      qryDados.Next;
      Continue;
    end;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    fltVlrCon   := qryDados.FieldByName('VLRCON_TOT').AsFloat ;
    fltValIcm   := qryDados.FieldByName('VALICM_TOT').AsFloat ;
    fltValPis   := qryDados.FieldByName('VALPIS_TOT').AsFloat ;
    fltValCof   := qryDados.FieldByName('VALCOF_TOT').AsFloat ;
    fltVrePis   := qryDados.FieldByName('VREPIS_TOT').AsFloat ;
    fltVreCof   := qryDados.FieldByName('VRECOF_TOT').AsFloat ;
    fltRetIss   := qryDados.FieldByName('RETISS_TOT').AsFloat ;
    fltReCssl   := qryDados.FieldByName('RECSSL_TOT').AsFloat ;
    fltReIrrf   := qryDados.FieldByName('REIRRF_TOT').AsFloat ;
    fltRInssp   := qryDados.FieldByName('RINSSP_TOT').AsFloat ;
    fltReInss   := qryDados.FieldByName('REINSS_TOT').AsFloat ;
    fltLiqEnt   := qryDados.FieldByName('LIQENT_TOT').AsFloat ;
    fltLiqCon   := qryDados.FieldByName('LIQCON_TOT').AsFloat ;

    if qryDados.FieldByName('FISINC').AsString <> strIncDoc then
    begin
      strIncDoc := qryDados.FieldByName('FISINC').AsString;
      pZerarValores;
    end;
    pAjustarValorProporcionalParcela;
    pSomarValores;

    qryDados.Next;
    if (qryDados.FieldByName('FISINC').AsString <> strIncDoc) or (qryDados.Eof) then
    begin
      if not qryDados.Eof then
        qryDados.Prior;

      fltDifVlrCon   := fFormataFloat(fltVlrCon - fltRatVlrCon, 2) ;
      fltDifValIcm   := fFormataFloat(fltValIcm - fltRatValIcm, 2) ;
      fltDifValPis   := fFormataFloat(fltValPis - fltRatValPis, 2) ;
      fltDifValCof   := fFormataFloat(fltValCof - fltRatValCof, 2) ;
      fltDifVrePis   := fFormataFloat(fltVrePis - fltRatVrePis, 2) ;
      fltDifVreCof   := fFormataFloat(fltVreCof - fltRatVreCof, 2) ;
      fltDifRetIss   := fFormataFloat(fltRetIss - fltRatRetIss, 2) ;
      fltDifReCssl   := fFormataFloat(fltReCssl - fltRatReCssl, 2) ;
      fltDifReIrrf   := fFormataFloat(fltReIrrf - fltRatReIrrf, 2) ;
      fltDifRInssp   := fFormataFloat(fltRInssp - fltRatRInssp, 2) ;
      fltDifReInss   := fFormataFloat(fltReInss - fltRatReInss, 2) ;
      fltDifLiqEnt   := fFormataFloat(fltLiqEnt - fltRatLiqEnt, 2) ;
      fltDifLiqCon   := fFormataFloat(fltLiqCon - fltRatLiqCon, 2) ;

      if (fltDifVlrCon <> 0) or
         (fltDifValIcm <> 0) or
         (fltDifValPis <> 0) or
         (fltDifValCof <> 0) or
         (fltDifVrePis <> 0) or
         (fltDifVreCof <> 0) or
         (fltDifRetIss <> 0) or
         (fltDifReCssl <> 0) or
         (fltDifReIrrf <> 0) or
         (fltDifRInssp <> 0) or
         (fltDifReInss <> 0) or
         (fltDifLiqEnt <> 0) or
         (fltDifLiqCon <> 0) then
      begin
        pAlterarValores;
      end;
    end
    else
    begin
      qryDados.Prior;
    end;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString, 'ENT', qryDados.FieldByName('CLAFIS').AsString).fConsultaEvento(FstrCentroCustoDefault);
    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
    LstrNatCfo := qryDados.FieldByName('NATCFO').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RETISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RINSSP', DES_VALOR_INSS_PATRONAL, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQCON', DES_VALOR_LIQUIDO_CONTABIL, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VREPIS', DES_VALOR_RETENCAO_PIS, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VRECOF', DES_VALOR_RETENCAO_COFINS, strPlaCta, '', strCodEve, '', '', LstrNatCfo);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConServicoEntradaADT.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConServicoEntradaADT.fFieldMensagemValidacao: string;
var
  strSQL : string ;
begin
  strSQL := '' ;
  strSQL := strSQL + ' ( ' ;
  strSQL := strSQL + ' SELECT IF( ' ;
  strSQL := strSQL + '           ((IF(SUB_P.CTP_DTACAD IS NULL, SUB_DUPAGP.CTP_DTACAD, SUB_P.CTP_DTACAD) <> SUB_CADFIS.FIS_DTAENT) AND (SUB_P.CTP_PAGANT = "N")), ' ;
  strSQL := strSQL + '           CONCAT(CONCAT(CONCAT(CONCAT(CONCAT("Data divergente CADFIS[",DATE_FORMAT(SUB_CADFIS.FIS_DTAENT,"%d/%m/%Y")), "] e "),'+' IF(SUB_P.CTP_DTACAD IS NULL, "DUPAGP[", "CADPAG[")),IF(SUB_P.CTP_DTACAD IS NULL, DATE_FORMAT(SUB_DUPAGP.CTP_DTACAD,"%d/%m/%Y"), DATE_FORMAT(SUB_P.CTP_DTACAD,"%d/%m/%Y"))),"]"), ' ;
  strSQL := strSQL + '           NULL ' ;
  strSQL := strSQL + '           ) AS mensagem ' ;
  strSQL := strSQL + ' FROM CADFIS AS SUB_CADFIS ' ;
  strSQL := strSQL + '    LEFT JOIN DUPAGP AS SUB_DUPAGP ON SUB_DUPAGP.CTP_NUMDUP = SUB_CADFIS.FIS_NUMDOC ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_CODFOR = SUB_CADFIS.FIS_FORCLI ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_CODEMP = SUB_CADFIS.FIS_CODEMP ' ;
  strSQL := strSQL + '                    AND IFNULL(SUB_DUPAGP.CTP_SERIE_,"") = IFNULL(SUB_CADFIS.FIS_SERIE_, "") ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_PARCEL = "A" ' ;
  strSQL := strSQL + '    LEFT JOIN CADPAG SUB_P ON SUB_P.CTP_NUMDUP = SUB_CADFIS.FIS_NUMDOC ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_CODFOR = SUB_CADFIS.FIS_FORCLI ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_CODEMP = SUB_CADFIS.FIS_CODEMP ' ;
  strSQL := strSQL + '                      AND IFNULL(SUB_P.CTP_SERIE_,"") = IFNULL(SUB_CADFIS.FIS_SERIE_, "") ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_SEQBAI = 0 ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_PARCEL = "A" ' ;
  strSQL := strSQL + '  WHERE SUB_CADFIS.AUTOINCREM = CADFIS.AUTOINCREM ' ;
  strSQL := strSQL + '        AND (SUB_P.CTP_DTACAD IS NOT NULL OR SUB_DUPAGP.CTP_DTACAD IS NOT NULL) ' ;
  strSQL := strSQL + '  ORDER BY IF(SUB_P.CTP_DTACAD IS NULL, SUB_DUPAGP.CTP_DTACAD, SUB_P.CTP_DTACAD) DESC ' ;
  strSQL := strSQL + '  LIMIT 1 ' ;
  strSQL := strSQL + '  ) ' ;
  result := strSQL ;
end;

function TLanConServicoEntradaADT.fPreparaSqlUnions(
  const AintColuna: integer): string;
var
  LstrSQL: string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + ' SELECT FIS_CLFSC'+ intTostr(AintColuna) +' AS CLAFIS, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
  LstrSQL := LstrSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrContabilLivro(AintColuna) + ', ROUND(' + fVlrContabilLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS VLRCON, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrIcmsLivro(AintColuna) + ', ROUND(' + fVlrIcmsLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS VALICM, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTPIS, ROUND(FIS_TOTPIS*D.CTP_FATCAL,2)) AS VALPIS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTCOF, ROUND(FIS_TOTCOF*D.CTP_FATCAL,2)) AS VALCOF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, '+ fFieldVREPIS(FblnFIS_VREPIS) +', ROUND('+ fFieldVREPIS(FblnFIS_VREPIS) +'*D.CTP_FATCAL,2)) AS VREPIS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, '+ fFieldVRECOF(FblnFIS_VRECOF) +', ROUND('+ fFieldVRECOF(FblnFIS_VRECOF) +'*D.CTP_FATCAL,2)) AS VRECOF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RETISS, ROUND(FIS_RETISS*D.CTP_FATCAL,2)) AS RETISS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RECSSL, ROUND(FIS_RECSSL*D.CTP_FATCAL,2)) AS RECSSL, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REIRRF, ROUND(FIS_REIRRF*D.CTP_FATCAL,2)) AS REIRRF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0), ROUND(IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) * D.CTP_FATCAL,2)) AS RINSSP, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REINSS, ROUND(FIS_REINSS*D.CTP_FATCAL,2)) AS REINSS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoEntradaLivro(AintColuna) + ', ROUND(' + fValorLiquidoEntradaLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS LIQENT, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + ', ROUND(' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + '*D.CTP_FATCAL,2)) AS LIQCON, ';

  LstrSQL := LstrSQL + '        ' + fVlrContabilLivro(AintColuna) + ' AS VLRCON_TOT, ';
  LstrSQL := LstrSQL + '        ' + fVlrIcmsLivro(AintColuna) + ' AS VALICM_TOT, ';
  LstrSQL := LstrSQL + '        FIS_TOTPIS AS VALPIS_TOT, ';
  LstrSQL := LstrSQL + '        FIS_TOTCOF AS VALCOF_TOT, ';
  LstrSQL := LstrSQL + '        '+ fFieldVREPIS(FblnFIS_VREPIS) +' AS VREPIS_TOT, ';
  LstrSQL := LstrSQL + '        '+ fFieldVRECOF(FblnFIS_VRECOF) +' AS VRECOF_TOT, ';
  LstrSQL := LstrSQL + '        FIS_RETISS AS RETISS_TOT, ';
  LstrSQL := LstrSQL + '        FIS_RECSSL AS RECSSL_TOT, ';
  LstrSQL := LstrSQL + '        FIS_REIRRF AS REIRRF_TOT, ';
  LstrSQL := LstrSQL + '        IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) AS RINSSP_TOT, ';
  LstrSQL := LstrSQL + '        FIS_REINSS AS REINSS_TOT, ';
  LstrSQL := LstrSQL + '        ' + fValorLiquidoEntradaLivro(AintColuna) + ' AS LIQENT_TOT, ';

  if (FCampoDupAgp_CodEve_Existe) then
    LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, IF(P.CTP_CODEVE IS NULL, DUPAGP.CTP_CODEVE, P.CTP_CODEVE), D.CTP_CODEVE) AS CODEVE, '
  else
    LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CODEVE, ';

  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, FIS_SERIE_, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, FIS_FORCLI, ';
  LstrSQL := LstrSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, FIS_TIP_FC, ';
  LstrSQL := LstrSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, CADFIS.AUTOINCREM AS FISINC, "CADFIS" AS TABELA, ';
  LstrSQL := LstrSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';

  if fCfgDesMva = 'S' then
  begin
    LstrSQL := LstrSQL + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  LstrSQL := LstrSQL + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  LstrSQL := LstrSQL + '        CAST(' + fFieldMensagemValidacao + ' AS CHAR(128)) AS MENSAGEM_VALIDACAO, ';
  LstrSQL := LstrSQL + '        IFNULL(FIS_NATOPE,"") AS NATCFO, ';
  LstrSQL := LstrSQL + '        IFNULL(P.CTP_VALORI, 0.00) AS CTP_VALORI, IFNULL(P.CTP_PARCEL, "") AS CTP_PARCEL, ';
  LstrSQL := LstrSQL + '        ' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + ' AS LIQCON_TOT  ';
  LstrSQL := LstrSQL + '   FROM CADFIS ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  LstrSQL := LstrSQL + '   LEFT JOIN DUPAGP ON DUPAGP.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                   AND IFNULL(DUPAGP.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_PARCEL = "A" ';
  LstrSQL := LstrSQL + fRetornaFiltroDupAgpPagAnt ;

  LstrSQL := LstrSQL + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                     AND P.CTP_SEQBAI = 0 ';
  LstrSQL := LstrSQL + '                     AND CASE WHEN P.CTP_PAGANT = "N" THEN P.CTP_DTACAD = FIS_DTAENT ELSE TRUE END ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTPDET D ON CASE WHEN DUPAGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE DUPAGP.CTP_CODFOR END = D.CTP_CODFOR ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE DUPAGP.CTP_NUMDUP END = D.CTP_NUMDUP ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE DUPAGP.CTP_PARCEL END = D.CTP_PARCEL ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE DUPAGP.CTP_CODEMP END = D.CTP_EMPORI ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_, "")) ELSE TRIM(COALESCE(DUPAGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';

  LstrSQL := LstrSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';

  LstrSQL := LstrSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  LstrSQL := LstrSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  LstrSQL := LstrSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';
  LstrSQL := LstrSQL + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, FIS_CODEMP, D.CTP_CODEMP)', 'FIS_CODEMP') ;

  LstrSQL := LstrSQL + '  WHERE FIS_ENTSAI = "E" ';
  LstrSQL := LstrSQL + '    AND RIGHT(FIS_CLFSC'+ intTostr(AintColuna) +', 3) = "933" ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    LstrSQL := LstrSQL + '  AND FIS_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    LstrSQL := LstrSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  LstrSql := LstrSql + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CADFIS.AUTOINCREM')
                        .fIncDoc(recParCon.strIncDoc)
                        .fArrIncDoc(recParCon.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  result := LstrSQL ;
end;

function TLanConServicoEntradaADT.fRetornaFiltroDupAgpPagAnt: string;
begin
  if FCampoDupAgp_PagAnt_Existe then
    result := '                   AND CASE WHEN DUPAGP.CTP_PAGANT = "N" THEN DUPAGP.CTP_DTACAD = FIS_DTAENT ELSE TRUE END ' ;
end;

function TLanConServicoEntradaADT.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConServicoEntradaADT.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConServicoEntradaADT.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Serviços de Entrada Concluído!', ['&OK']);
end;

procedure TLanConServicoEntradaADT.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConServicoEntradaADT.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

procedure TLanConServicoEntradaADT.pZerarValores;
begin
  fltRatVlrCon := 0 ;
  fltRatValIcm := 0 ;
  fltRatValPis := 0 ;
  fltRatValCof := 0 ;
  fltRatVrePis := 0 ;
  fltRatVreCof := 0 ;
  fltRatRetIss := 0 ;
  fltRatReCssl := 0 ;
  fltRatReIrrf := 0 ;
  fltRatRInssp := 0 ;
  fltRatReInss := 0 ;
  fltRatLiqEnt := 0 ;
  fltRatLiqCon := 0 ;

  fltDifVlrCon := 0 ;
  fltDifValIcm := 0 ;
  fltDifValPis := 0 ;
  fltDifValCof := 0 ;
  fltDifVrePis := 0 ;
  fltDifVreCof := 0 ;
  fltDifRetIss := 0 ;
  fltDifReCssl := 0 ;
  fltDifReIrrf := 0 ;
  fltDifRInssp := 0 ;
  fltDifReInss := 0 ;
  fltDifLiqEnt := 0 ;
  fltDifLiqCon := 0 ;
end;

procedure TLanConServicoEntradaADT.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConServicoEntradaADT.pSomarValores;
begin
  fltRatVlrCon := fltRatVlrCon + qryDados.FieldByName('VLRCON').AsFloat;
  fltRatValIcm := fltRatValIcm + qryDados.FieldByName('VALICM').AsFloat;
  fltRatValPis := fltRatValPis + qryDados.FieldByName('VALPIS').AsFloat;
  fltRatValCof := fltRatValCof + qryDados.FieldByName('VALCOF').AsFloat;
  fltRatVrePis := fltRatVrePis + qryDados.FieldByName('VREPIS').AsFloat;
  fltRatVreCof := fltRatVreCof + qryDados.FieldByName('VRECOF').AsFloat;
  fltRatRetIss := fltRatRetIss + qryDados.FieldByName('RETISS').AsFloat;
  fltRatReCssl := fltRatRecSsl + qryDados.FieldByName('RECSSL').AsFloat;
  fltRatReIrrf := fltRatReIrrf + qryDados.FieldByName('REIRRF').AsFloat;
  fltRatRInssp := fltRatRInssp + qryDados.FieldByName('RINSSP').AsFloat;
  fltRatReInss := fltRatReInss + qryDados.FieldByName('REINSS').AsFloat;
  fltRatLiqEnt := fltRatLiqEnt + qryDados.FieldByName('LIQENT').AsFloat;
  fltRatLiqCon := fltRatLiqCon + qryDados.FieldByName('LIQCON').AsFloat;
end;

procedure TLanConServicoEntradaADT.pAjustarValorProporcionalParcela;
var
  LRazaoParcela: Extended;
begin
  LRazaoParcela := 1;

  if (qryDados.FieldByName('CTP_VALORI').AsFloat <> 0) and (FCdsTotCadPag.FieldByName('CTP_VALORI_TOT').AsFloat <> 0) then
    LRazaoParcela := qryDados.FieldByName('CTP_VALORI').AsFloat / FCdsTotCadPag.FieldByName('CTP_VALORI_TOT').AsFloat ;

  if LRazaoParcela >= 1 then
    exit;

  qryDados.Edit;
  qryDados.FieldByName('VLRCON').AsFloat := fFormataFloat(qryDados.FieldByName('VLRCON').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALICM').AsFloat := fFormataFloat(qryDados.FieldByName('VALICM').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALPIS').AsFloat := fFormataFloat(qryDados.FieldByName('VALPIS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VALCOF').AsFloat := fFormataFloat(qryDados.FieldByName('VALCOF').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VREPIS').AsFloat := fFormataFloat(qryDados.FieldByName('VREPIS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('VRECOF').AsFloat := fFormataFloat(qryDados.FieldByName('VRECOF').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('RETISS').AsFloat := fFormataFloat(qryDados.FieldByName('RETISS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('RECSSL').AsFloat := fFormataFloat(qryDados.FieldByName('RECSSL').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('REIRRF').AsFloat := fFormataFloat(qryDados.FieldByName('REIRRF').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('RINSSP').AsFloat := fFormataFloat(qryDados.FieldByName('RINSSP').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('REINSS').AsFloat := fFormataFloat(qryDados.FieldByName('REINSS').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('LIQENT').AsFloat := fFormataFloat(qryDados.FieldByName('LIQENT').AsFloat * LRazaoParcela, 2);
  qryDados.FieldByName('LIQCON').AsFloat := fFormataFloat(qryDados.FieldByName('LIQCON').AsFloat * LRazaoParcela, 2);
  qryDados.Post;
end;

procedure TLanConServicoEntradaADT.pAlterarValores;
begin
  qryDados.Edit;
  if fltDifVlrCon <> 0 then
    qryDados.FieldByName('VLRCON').AsFloat := qryDados.FieldByName('VLRCON').AsFloat + fltDifVlrCon ;
  if fltDifValIcm <> 0 then
    qryDados.FieldByName('VALICM').AsFloat := qryDados.FieldByName('VALICM').AsFloat + fltDifVlrCon ;
  if fltDifValPis <> 0 then
    qryDados.FieldByName('VALPIS').AsFloat := qryDados.FieldByName('VALPIS').AsFloat + fltDifValPis ;
  if fltDifValCof <> 0 then
    qryDados.FieldByName('VALCOF').AsFloat := qryDados.FieldByName('VALCOF').AsFloat + fltDifValCof ;
  if fltDifVrePis <> 0 then
    qryDados.FieldByName('VREPIS').AsFloat := qryDados.FieldByName('VREPIS').AsFloat + fltDifVrePis ;
  if fltDifVreCof <> 0 then
    qryDados.FieldByName('VRECOF').AsFloat := qryDados.FieldByName('VRECOF').AsFloat + fltDifVreCof ;
  if fltDifRetIss <> 0 then
    qryDados.FieldByName('RETISS').AsFloat := qryDados.FieldByName('RETISS').AsFloat + fltDifRetIss ;
  if fltDifRecSsl <> 0 then
    qryDados.FieldByName('RECSSL').AsFloat := qryDados.FieldByName('RECSSL').AsFloat + fltDifRecSsl ;
  if fltDifReIrrf <> 0 then
    qryDados.FieldByName('REIRRF').AsFloat := qryDados.FieldByName('REIRRF').AsFloat + fltDifReIrrf ;
  if fltDifRInssp <> 0 then
    qryDados.FieldByName('RINSSP').AsFloat := qryDados.FieldByName('RINSSP').AsFloat + fltDifRInssp ;
  if fltDifLiqEnt <> 0 then
    qryDados.FieldByName('LIQENT').AsFloat := qryDados.FieldByName('LIQENT').AsFloat + fltDifLiqEnt ;
  if fltDifLiqCon <> 0 then
    qryDados.FieldByName('LIQCON').AsFloat := qryDados.FieldByName('LIQCON').AsFloat + fltDifLiqCon ;
  if fltDifReInss <> 0 then
    qryDados.FieldByName('REINSS').AsFloat := qryDados.FieldByName('REINSS').AsFloat + fltDifReInss ;
  qryDados.Post;
end;

procedure TLanConServicoEntradaADT.pCarregaServicoAdt;
begin
  if Assigned(FCdsServicoAdt) then
    FreeAndNil(FCdsServicoAdt);

  FCdsServicoAdt := fCarregaEntAdtFis(recParCon);
end;

procedure TLanConServicoEntradaADT.pCarregaTotCadPag;
var
  strSQL: string;
  qryAux: TUniQuery;
begin
  if Assigned(FCdsTotCadPag) then
    FreeAndNil(FCdsTotCadPag);

  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    strSql := strSql + 'SELECT CADFIS.AUTOINCREM AS FISINC, ';
    strSql := strSql + '  SUM(CTP_VALORI) AS CTP_VALORI_TOT ';
    strSql := strSql + 'FROM CADPAG ';
    strSql := strSql + 'INNER JOIN CADFIS ';
    strSql := strSql + '  ON FIS_NUMDOC = CTP_NUMDUP ';
    strSql := strSql + '  AND FIS_FORCLI = CTP_CODFOR ';
    strSql := strSql + '  AND FIS_CODEMP = CTP_CODEMP ';
    strSql := strSql + '  AND IFNULL(FIS_SERIE_, "") = IFNULL(CTP_SERIE_, "") ';
    strSql := strSql + 'WHERE TRUE ';

    If Not fEmptyStr(recParCon.strCodEmp) Then
      strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      strSQL := strSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSql := strSql + 'GROUP BY CADFIS.AUTOINCREM ';

    qryAux.SQL.Add(strSQL);

    pSetaParametrosGerLanCon(recParCon, qryAux);

    qryAux.Open;

    FCdsTotCadPag := fCriaClientDatset(qryAux) ;
    FCdsTotCadPag.IndexFieldNames := 'FISINC';
  finally
    FreeAndNil(qryAux);
  end;
end;

end.
