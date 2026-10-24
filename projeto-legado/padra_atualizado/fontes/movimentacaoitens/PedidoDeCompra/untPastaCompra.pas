unit untPastaCompra;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni,
  cxProgressBar, untGravando, uniClientDataSet,
  untFuncoesPedido, untFuncoesPedidoSimples,
  untTypesSistema, untConstantes, untDigObservacoes;

Type
  TTipoAgrupamento = (taFornecedor, taFornecedorMarca, taFornecedorDepartamento);

  TPastaCompra = Class(TZClient)
    Private
      cdsItens: TZClient;
      FCodCmp,
      FNumPed,
      FEspDoc,
      FCodEmp,
      FEmpOri,
      FEmpDes,
      FCodFor,
      FCndPag,
      FCodCta,
      strBStFre,
      strBStDes,
      strIpiFre,

      FAutIncPcd: String;

      fltValFreGer,
      fltDesAceGer,
      FDesAdi: Double;

      FHorPed: TTime;
      FDtaPed,
      FDtaEnt,
      FDtaFat: TDate;

      FLisCmp: String;
      FEmpFil: String;

      stlLisPed: TStringList;

      frmGravando: TfrmGravando;

      FstrFiltroDepartamento: String;
      FstrFiltroMarca: String;
      blnFiltrarItem: Boolean;

      FarrFiltroLinhaGrupo: TConsultasArray;
      FarrFiltroFilEmpresa: TConsultasArray;

      FblnConsiderarProdSobEnc: Boolean;

      FUsarDadosJaDigitados: Boolean;

      FQtdEmpresasDestino: Integer;

      frmDigObservacoes: TfrmDigObservacoes;

      RecDigObservacoes: TRecDigObservacoes;

      fltDesVis      : Double;
      intCarPag      : Integer;
      strRedPis      : String;
      fltPisCof      : Double;
      strSimPau      : String;

      strTipAbfFor  :  string;
      blnTemDare,
      blnZonaFranca :  Boolean;
      strFRMPCM     :  String;




      Function fSQLCompras(strLisCmp: String): String;
      Function fSQLFiliaisMinimo(strLisCmp, AstrCodFor: String; blnGerarPedidoCompra: Boolean = False; strFilEmp: String = ''): String;
      Function fSQLItensGeraPedido: String;

      Procedure pAfterScroll(dataSet: TDataSet);

      Procedure pGravaMestrePedido;
      Procedure pGravaItemPedido;
      function fPrazoEntregaItem: integer;

      Procedure pApagaPreOrcamento(AstrCodFor, strCodEmp: String);
      Procedure pRateiaFreteDesAce(blnRecalcular: Boolean; fltValFreRat, fltDesAceRat: Double; strBStFrete, strBStDesAce, strBSIpiFrete: String);


      Function fGeraPedidoPrg(cxProgressBar: TcxProgressBar): Boolean;

      Function fCarregaDadosPrg(cxProgresso: TCxProgressBar): Boolean;

      Function fLocalizaCabecPreOrcamento(AstrCodFor: String; Var AstrCndPag: String; Var fltDesAdi: Double): Boolean;
      procedure SetFiltroDepartamento(const Value: String);
      procedure SetFiltroMarca(const Value: String);
      function fCarregaDigObservacoes(strCodEmp, strEmpGer: string): Boolean;
      Function fRateiaFreteDesAcePrg(pgbProgresso: TcxProgressBar): Boolean;
      Procedure pRateiaFreteRegistro(Var fltValFreRes, fltDesAceRes: Double;
                                     fltValFreGer, fltDesAceGer, fltTotIteGer: Double;
                                     cdsDados: TUniClientDataSet);
    procedure pCarregaFornecedor(AStrCodFor: String);
    procedure SetConsiderarProdSobEnc(const Value: Boolean);
    procedure SetFiltroLinhaGrupo(const Value: TConsultasArray);
    procedure SetFiltroFilEmpresa(const Value: TConsultasArray);

    Function fNroDeUmaEmpresaDestino: Integer;
  Var


    Public

      objResumoEmpresa: TZClient;
      strCodFor: string;
      strConPag: String;

      cdsEmpresas: TZClient;

      blnGlobal: Boolean;

      intDecUni,
      intDeqTpc: Integer;

      fltALPISP,
      fltALCOFP: Double;

      TipoAgrupamento : TTipoAgrupamento;
      strFiltroFornecedor: String;
      blnCnvEmb: Boolean;


      Function fCarregaResumo(strLisCmp, AstrCodFor: String; blnGerarPedCom: Boolean = false; strFilEmp: String = ''): Boolean;

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaDados(strLisComprador: String): Boolean;

      Function fTemFilialSelecionada: Boolean;

      Function fGeraPedido(strCodFor, strEmpOri, strEmpDes: String): Boolean;

      Function fGeraPedidosResumo: Boolean;


      Class Function fPrazoEntrega(strCodFor, strCodEmp: String): Integer;

      Function fTravaPastaFornecedor(strCodFor: String): Boolean;
      Procedure pDestravaPastaFornecedor(strCodFor: String);

      property strFiltroDepartamento: String read FstrFiltroDepartamento write SetFiltroDepartamento;
      property strFiltroMarca: String read FstrFiltroMarca write SetFiltroMarca;
      property blnConsiderarProdSobEnc: Boolean read FblnConsiderarProdSobEnc write SetConsiderarProdSobEnc;
      property arrFiltroLinhaGrupo: TConsultasArray read FarrFiltroLinhaGrupo write SetFiltroLinhaGrupo;
      property arrFiltroFilEmpresa: TConsultasArray read FarrFiltroFilEmpresa write SetFiltroFilEmpresa;
  End;

implementation

Uses
  Forms,
  DateUtils,
  Math,
  untFuncoesConsulta,
  untGravacaoPedido, untTipoFreteAtc, untSaldoPedidoCompra;

constructor TPastaCompra.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
  blnCnvEmb := False;
  TipoAgrupamento := taFornecedor;
  intDecUni := fCfgSis('DECUNI', varInteger);

  intDeqTpc := fCfgSis('DEQTPC', varInteger);

  fltALPISP := fCfgSis('ALPISP', varDouble);

  fltALCOFP := fCfgSis('ALCOFP', varDouble);

  objResumoEmpresa :=  TZClient.Create(Self);

  objResumoEmpresa.IndexFieldNames := 'CODFOR;CODEMP';

  stlLisPed := TStringList.Create;

  frmDigObservacoes := Nil;
  FUsarDadosJaDigitados := False;
  FQtdEmpresasDestino := 0;

  FstrFiltroDepartamento := '';
  FstrFiltroMarca := '';
  blnFiltrarItem := False;

  FblnConsiderarProdSobEnc := True;
  blnGlobal := fCfgSis('TIPPAS') = '2';

  cdsEmpresas := TZClient.Create(Self, 'SELECT EMP_CODEMP, CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS EMP_NOMEMP FROM CADEMP');
  cdsEmpresas.fLeDados('TPastaCompra.Create');
End;

Destructor TPastaCompra.Destroy;
Begin
  Inherited;

  FreeAndNil(stlLisPed);

  If Assigned(frmDigObservacoes) Then
    pFreeAndNil(frmDigObservacoes);
End;

Function TPastaCompra.fSQLCompras(strLisCmp: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                     ';
  strSQL := strSQL + '   PRE_CODFOR AS CODFOR,                    ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR,                    ';
  strSQL := strSQL + '   FOR_CONTAT AS CONTAT,                    ';

  strSQL := strSQL + '   CONCAT(PRE_CODFOR, "-", FOR_NOMFOR) AS FORNEC, ';

  If TipoAgrupamento <> taFornecedor Then
  Begin
    strSQL := strSQL + '   @CODFOR := FOR_CODFOR, ';

    strSQL := strSQL + '   @COUNT := (SELECT COUNT(1) FROM ';
    strSQL := strSQL + '   PRE_ORCAMENTO ';
    strSQL := strSQL + '   INNER JOIN CADFOR  ON FOR_CODFOR = PRE_CODFOR ';
    strSQL := strSQL + '   LEFT JOIN  CADITE ON ITE_CODITE = PRE_CODITE  ';
    strSQL := strSQL + '   WHERE                                         ';
    strSQL := strSQL + '     PRE_NECAJU > 0                              ';
    strSQL := strSQL + '     AND FOR_CODFOR = @CODFOR                    ';
    If Not fEmptyStr(strLisCmp) Then
      strSQL := strSQL + '   AND PRE_COMPRA IN (' + strLisCmp + ') ';

      strSQL := strSQL + '   ), ';
  End
  Else
    strSQL := strSQL + '    @COUNT := COUNT(1), ';


  case TipoAgrupamento Of
    taFornecedorMarca: Begin
                         strSQL := strSQL + '  CONCAT(MAR_CODMAR , "-", MAR_DESMAR) AS AGRUPAMENTO, ';
                         strSQL := strSQL + '  MAR_CODMAR AS CAMAGRU,';
                       End;

    taFornecedorDepartamento: Begin
                                strSQL := strSQL + '   CONCAT(ITE_CODDEP, "-", DEP_DESCRI) AS AGRUPAMENTO, ';
                                strSQL := strSQL + '   ITE_CODDEP AS CAMAGRU, ';
                              End;
  end;


  strSQL := strSQL + '   (SELECT LIM_VALPED FROM LIMFOR WHERE LIM_CODFOR = FOR_CODFOR AND LIM_NROANO = YEAR(CURRENT_DATE()) AND LIM_NROMES = MONTH(CURRENT_DATE())) AS LIMPED, ';

  strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(PCD_TOTITE, 0) + IFNULL(PCD_TOTIPI, 0) + IFNULL(PCD_TOTSUB, 0) + IFNULL(PCD_SUBFCP, 0)' + fSQLSomaImpostosReforma('PCD') + ') FROM PCMDET        ';
  strSQL := strSQL + '           INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC ';
  strSQL := strSQL + '           INNER JOIN EMPPAR ON PAR_CODEMP = PCG_CODEMP                                                         ';
  strSQL := strSQL + '           WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODFOR = FOR_CODFOR AND PCD_DTAPED BETWEEN :INIMES AND :FIMMES AND IFNULL(PCD_ENTREG, "") <> "N" ';
  case TipoAgrupamento Of
    taFornecedorMarca,
    taFornecedorDepartamento:     strSQL := strSQL + '   AND PCD_CODITE = C.ITE_CODITE ';
  end;

  If Assigned(FarrFiltroFilEmpresa) Then
  	strSQL := strSQL + fStrLocateEmpresa(FarrFiltroFilEmpresa, 'IFNULL(PCG_EMPDES, PCG_CODEMP)');

  strSQL := strSQL + '                  AND ((PAR_SUGGAR = "S") OR               ';
  strSQL := strSQL + '                                 (IFNULL(PCG_DOCORI, "") = "") OR    ';
  strSQL := strSQL + '                                 (IFNULL(                            ';

  strSQL := strSQL + '                                 (SELECT COUNT(1) FROM MOVGAE         ';
  strSQL := strSQL + '                                  WHERE                               ';
  strSQL := strSQL + '                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV ';
  strSQL := strSQL + '                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV ';
  strSQL := strSQL + '                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0) ';

  strSQL := strSQL + '          )), 0) AS PEDMES,  ';

  strSQL := strSQL + '   0 AS PASLIM,                            ';

  strSQL := strSQL + '   SUM(PRE_VALTOT) AS VALCOM,               ';
  strSQL := strSQL + '   SUM(PRE_VALNET) AS VALNET,               ';

  strSQL := strSQL + '   SUM(PRE_NECAJU) AS NECAJU,               ';

  strSQL := strSQL + '   SUM(DIAS_ESTOQUE) / @COUNT AS DIAEST,   ';
  strSQL := strSQL + '   SUM(DIAS_ESTOQUE_PENDENCIA) / @COUNT AS DIAPEN, ';

  strSQL := strSQL + '   IF(SUM(POSICAO) <> 0, SUM(RUPTURA) / SUM(POSICAO), 0) AS RUPTUR, ';

//  strSQL := strSQL + '   SUM(PRE_VALCOM) AS PEDCOM, ';


  strSQL := strSQL + '      (SELECT  SUM(((PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) * (1 - IFNULL(PCD_DESUN2, 0) / 100)) * ((PCD_QTDITE - IF(PCD_ENTREG = "N" AND PCD_BAIXAD = 1, PCD_QTDITE, PCD_QTDBAI))  ))  * (1 + ((PCD_PERIPI) / 100)) + (PCD_TOTSUB - PCD_SUBBAI) ';

  // IFNULL: PCD_QTDITE zero anularia a linha inteira do saldo
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    strSQL := strSQL + ' + IFNULL((IFNULL(PCD_VALCBS, 0) + IFNULL(PCD_VALIBS, 0) + IFNULL(PCD_VAL_IS, 0)) * (PCD_QTDITE - IF(PCD_ENTREG = "N" AND PCD_BAIXAD = 1, PCD_QTDITE, PCD_QTDBAI)) / PCD_QTDITE, 0) ';

  strSQL := strSQL + ') ';
  strSQL := strSQL + '          FROM PCMDET ';
  strSQL := strSQL + '               INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC ';
  strSQL := strSQL + '                INNER JOIN EMPPAR ON PAR_CODEMP = PCG_CODEMP ';
  strSQL := strSQL + '               WHERE PCD_NUMCTN = 0 ';
  strSQL := strSQL + '                 AND PCD_ESPDOC = "PD" ';

  If Assigned(FarrFiltroFilEmpresa) Then
  	strSQL := strSQL + fStrLocateEmpresa(FarrFiltroFilEmpresa, 'IFNULL(PCG_EMPDES, PCG_CODEMP)');

  strSQL := strSQL + '                 AND PCD_BAIXAD = 0 ';
  strSQL := strSQL + '                 AND PCG_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                 AND ((PAR_SUGGAR = "S") OR ';
  strSQL := strSQL + '                      (IFNULL(PCG_DOCORI, "") = "") OR ';
  strSQL := strSQL + '                      (IFNULL((SELECT COUNT(1) FROM MOVGAE ';
  strSQL := strSQL + '                                WHERE SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV ';
  strSQL := strSQL + '                                  AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV ';
  strSQL := strSQL + '                                  AND PCD_CODEMP = GAE_EMPENV), 0) = 0))) AS PEDCOM, ';

  strSQL := strSQL + '   IFNULL((SELECT COUNT(DISTINCT PCMGER.AUTOINCREM) FROM PCMGER      ';
  strSQL := strSQL + '           INNER JOIN EMPPAR ON PAR_CODEMP = PCG_CODEMP              ';
  strSQL := strSQL + '           WHERE PCG_NUMCTN = 0 AND PCG_ESPDOC = "PD" AND PCG_BAIXAD = 0 AND PCG_CODFOR = FOR_CODFOR ';

  If Assigned(FarrFiltroFilEmpresa) Then
  	strSQL := strSQL + fStrLocateEmpresa(FarrFiltroFilEmpresa, 'IFNULL(PCG_EMPDES, PCG_CODEMP)');

  strSQL := strSQL + '                            AND ((PAR_SUGGAR = "S") OR               ';
  strSQL := strSQL + '                                 (IFNULL(PCG_DOCORI, "") = "") OR    ';
  strSQL := strSQL + '                                 (IFNULL(                            ';

  strSQL := strSQL + '                                 (SELECT COUNT(1) FROM MOVGAE         ';
  strSQL := strSQL + '                                  WHERE                               ';
  strSQL := strSQL + '                                        SUBSTRING(PCG_DOCORI,1,12) = GAE_NUMENV ';
  strSQL := strSQL + '                                    AND SUBSTRING(PCG_DOCORI,13,2) = GAE_ESPENV ';
  strSQL := strSQL + '                                    AND PCG_CODEMP = GAE_EMPENV), 0) = 0) ';

  strSQL := strSQL + '   )), 0) AS QTDCOM, ';

  strSQL := strSQL + '   (SELECT MIN(PCD_DTAPED) FROM PCMDET ';
  strSQL := strSQL + '             INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC ';
  strSQL := strSQL + '              INNER JOIN EMPPAR ON PAR_CODEMP = PCG_CODEMP ';
  strSQL := strSQL + '             WHERE PCD_NUMCTN = 0 ';
  strSQL := strSQL + '               AND PCD_ESPDOC = "PD" ';

  If Assigned(FarrFiltroFilEmpresa) Then
  	strSQL := strSQL + fStrLocateEmpresa(FarrFiltroFilEmpresa, 'IFNULL(PCG_EMPDES, PCG_CODEMP)');

  strSQL := strSQL + '               AND PCD_BAIXAD = 0  ';
  strSQL := strSQL + '               AND PCG_CODFOR = FOR_CODFOR  ';
  strSQL := strSQL + '               AND ((PAR_SUGGAR = "S") OR  ';
  strSQL := strSQL + '                    (IFNULL(PCG_DOCORI, "") = "") OR  ';
  strSQL := strSQL + '                    (IFNULL((SELECT COUNT(1) FROM MOVGAE  ';
  strSQL := strSQL + '                              WHERE SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV  ';
  strSQL := strSQL + '                                AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV  ';
  strSQL := strSQL + '                                AND PCD_CODEMP = GAE_EMPENV), 0) = 0))) AS PREANT,  ';

//   strSQL := strSQL + '   CAST(MIN(PRE_ANTIGO) AS DATE) AS PREANT, ';

  strSQL := strSQL + '   0.00 AS MEDFIL,                            ';
  strSQL := strSQL + '   0 AS FILMIN,                               ';

  strSQL := strSQL + '   SUM(PRE_COMPEN) AS SKURUP, ';
  strSQL := strSQL + '   COUNT(1) AS SKUPED,                   ';
  strSQL := strSQL + '   PRE_DTAGER,                   ';

  strSQL := strSQL + '   CADFOR.FOR_MINPED as VALMIN, ';
  strSQL := strSQL + '   SUM(PRE_QTDITE) as TOTQTD, ';

  strSQL := strSQL + '   SUM(IF(U.UNI_KILLIT = "L", ( PRE_QTDITE * U.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), 0)) AS LITRAG ';

  strSQL := strSQL + '   FROM                                          ';
  strSQL := strSQL + '     PRE_ORCAMENTO  ORC ';
  strSQL := strSQL + '   INNER JOIN CADFOR ON FOR_CODFOR = PRE_CODFOR  ';

  strSQL := strSQL + '   INNER JOIN  CADITE C ON ITE_CODITE = PRE_CODITE ';

  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND G.ITE_CODEMP = PRE_CODEMP ';

  strSQL := strSQL + '   INNER JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI ';

  strSQL := strSQL + '   INNER JOIN CFGSIS ON SIS_CODCFG  = "CFG_LITGAL" AND SIS_CODEMP = PRE_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN SITPRO ON SIT_CODIGO = G.ITE_SITPRO ';

  If (TipoAgrupamento = taFornecedorMarca) Or (FstrFiltroMarca <> '') Then
    strSQL := strSQL + '   LEFT JOIN  CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  If (TipoAgrupamento = taFornecedorDepartamento) Or (FstrFiltroDepartamento <> '') Then
    strSQL := strSQL + '   LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP';
  strSQL := strSQL + '   WHERE                                         ';
  strSQL := strSQL + '     PRE_NECAJU > 0                              ';
  strSQL := strSQL + '     AND IFNULL(SIT_PASCMP, "S") = "S"          ';

  If Not fEmptyStr(strLisCmp) Then
    strSQL := strSQL + '   AND PRE_COMPRA IN (' + strLisCmp + ') ';

  If FstrFiltroMarca <> '' Then
    strSQL := strSQL + '   AND ITE_CODMAR = "' + FstrFiltroMarca  + '" ';
  If FstrFiltroDepartamento <> '' Then
    strSQL := strSQL + '   AND ITE_CODDEP = "' + FstrFiltroDepartamento + '" ';
  If strFiltroFornecedor <> '' Then
    strSQL := strSQL + '   AND FOR_CODFOR = "' + strFiltroFornecedor + '" ';

  If Not FblnConsiderarProdSobEnc Then
    strSQL := strSQL + ' AND G.ITE_SOBENC = "N" ';

  If Assigned(FarrFiltroLinhaGrupo) Then
  	strSQL := strSQL + fStrLocateLinGru(FarrFiltroLinhaGrupo, 'C.ITE_CODGRU');

  If Assigned(FarrFiltroFilEmpresa) Then
  	strSQL := strSQL + fStrLocateEmpresa(FarrFiltroFilEmpresa, 'PRE_CODEMP');

  strSQL := strSQL + '  GROUP BY ';
  case TipoAgrupamento Of
    taFornecedorDepartamento: strSQL := strSQL + '  FOR_CODFOR, ITE_CODDEP ';
    taFornecedorMarca:        strSQL := strSQL + '  FOR_CODFOR, ITE_CODMAR ';
  Else
    strSQL := strSQL + ' FOR_CODFOR ';
  End;

  Result := strSQL;
End;

Function TPastaCompra.fSQLFiliaisMinimo(strLisCmp, AstrCodFor: String; blnGerarPedidoCompra: Boolean = False; strFilEmp: String = ''): String;
  Var
    strSQL: String;

Begin
  strSQL := '';
  If Not fEmptyStr(AstrCodFor) Then
  Begin
    strSQL := strSQL + 'SELECT TMP.*, ';

    strSQL := strSQL + ' IF(TOTQTD < PRA_MINQTD, "S", "N") AS DIVQTD, ';
    strSQL := strSQL + ' IF(TOTKIL < PRA_MINPES, "S", "N") AS DIVPES, ';
    strSQL := strSQL + ' IF(TOTLIT < PRA_MINLIT, "S", "N") AS DIVLIT, ';
    strSQL := strSQL + ' IF(TOTMET < PRA_MINMET, "S", "N") AS DIVMET  ';

    strSQL := strSQL + ' FROM ( ';
  End;

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   PRE_DESBAN AS DESBAN,     ';
  strSQL := strSQL + '   PRE_CODFOR AS CODFOR,     ';
  strSQL := strSQL + '   PRE_CODEMP AS CODEMP,     ';
  strSQL := strSQL + '   PRE_CODEMP AS EMPGER,     ';
  strSQL := strSQL + '   FOR_EMPPAS AS EMPPAS,     ';
  strSQL := strSQL + '   (SELECT IF(IFNULL(EMP_SIGLA_, "") = "", EMP_CODEMP, EMP_SIGLA_) FROM CADEMP WHERE EMP_CODEMP = PRE_CODEMP) AS SIGEMP,     ';

  If Not fEmptyStr(AstrCodFor) Then
  Begin
    strSQL := strSQL + ' IFNULL(PRA_MINQTD, 0) AS PRA_MINQTD,';
    strSQL := strSQL + ' IFNULL(PRA_MINMET, 0) AS PRA_MINMET,';
    strSQL := strSQL + ' IFNULL(PRA_MINLIT, 0) AS PRA_MINLIT,';
    strSQL := strSQL + ' IFNULL(PRA_MINPES, 0) AS PRA_MINPES,';
    strSQL := strSQL + ' SUM(PRE_QTDITE) AS TOTQTD,';
    strSQL := strSQL + ' SUM(IF(CADUNI.UNI_KILLIT = "K", ( PRE_QTDITE * CADUNI.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), PRE_QTDITE * UNI_PESLIT)) AS TOTKIL,';
    strSQL := strSQL + ' SUM(IF(CADUNI.UNI_KILLIT = "L", ( PRE_QTDITE * CADUNI.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), 0)) AS TOTLIT,';
    strSQL := strSQL + ' SUM(IF(CADUNI.UNI_METFAT = "S", ( PRE_QTDITE * ITE_FATCMP), 0)) AS TOTMET,';

  End;
  strSQL := strSQL + '   PRE_VALMIN AS VALMIN,                        ';
  strSQL := strSQL + '   @VALTOT:=SUM(PRE_VALTOT) AS VALCOM,          ';
  strSQL := strSQL + '   IF(@VALTOT > PRE_VALMIN, "S", "N") AS GERARP, ';

  strSQL := strSQL + ' SUM(IF(CADUNI.UNI_KILLIT = "L", ( PRE_QTDITE * CADUNI.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), 0)) AS LITRAG ';

  strSQL := strSQL + ' FROM                                           ';
  strSQL := strSQL + '   PRE_ORCAMENTO                                ';
  strSQL := strSQL + '   INNER JOIN CADFOR ON FOR_CODFOR = PRE_CODFOR  ';
  strSQL := strSQL + '   INNER JOIN CADITE C ON ITE_CODITE = PRE_CODITE ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND G.ITE_CODEMP =   PRE_CODEMP ';
  strSQL := strSQL + '   INNER JOIN CFGSIS ON SIS_CODCFG  = "CFG_LITGAL" AND SIS_CODEMP = PRE_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_UNICOM ';
  strSQL := strSQL + '   LEFT JOIN SITPRO ON SIT_CODIGO = G.ITE_SITPRO ';
  If Not fEmptyStr(AstrCodFor) Then
    strSQL := strSQL + '   LEFT JOIN EMPPRA ON PRA_CODEMP = PRE_CODEMP AND PRA_CODFOR = PRE_CODFOR';


  strSQL := strSQL + ' WHERE TRUE                                     ';
   strSQL := strSQL + '   AND  PRE_VALTOT > 0                            ';

  strSQL := strSQL + '     AND IFNULL(SIT_PASCMP, "S") = "S"          ';

  If Not fEmptyStr(strLisCmp) Then
    strSQL := strSQL + '   AND PRE_COMPRA IN (' + strLisCmp + ') ';

  If Not fEmptyStr(AstrCodFor) Then
    strSQL := strSQL + '   AND PRE_CODFOR = ' + QuotedStr(AstrCodFor);

  If blnGerarPedidoCompra Then
    strSQL := strSQL + '   AND MARDES = 1';

  If Not fEmptyStr(strFilEmp) Then
    strSQL := strSQL + '   AND PRE_CODEMP IN (' + strFilEmp + ') ';

  strSQL := strSQL + '  GROUP BY CODFOR, CODEMP ';
  If Not fEmptyStr(AstrCodFor) Then
    strSQL := strSQL + '  ) TMP ';

  Result := strSQL;
End;

Function TPastaCompra.fCarregaResumo(strLisCmp, AstrCodFor: String; blnGerarPedCom: Boolean = false; strFilEmp: String = ''): Boolean;
Begin
  If Not fTabelaExiste('PRE_ORCAMENTO') Then
  Begin
    pMensagemOk('Não há nenhuma pasta de compra gerada!');
    Result := False;
    Exit;
  End;

  If blnGlobal And (Not fTabelaExiste('PRE_ORCAMENTO_SATELITES')) Then
  Begin
    pMensagemOk('A pasta de compra para os Satélites não foi gerada!');
    Result := False;
    Exit;
  End;


  objResumoEmpresa.qryQuery.SQL.Text := fSQLFiliaisMinimo(strLisCmp, AstrCodFor, blnGerarPedCom, strFilEmp);
  Result := objResumoEmpresa.fLeDados('TPastaCompra.fCarregaDadosstrNomFunc');
End;

Function TPastaCompra.fCarregaDados(strLisComprador: String): Boolean;
Begin
  If Not fTabelaExiste('PRE_ORCAMENTO') Then
  Begin
    pMensagemOk('Não há nenhuma pasta de compra gerada!');
    Result := False;
    Exit;
  End;

  If blnGlobal And (Not fTabelaExiste('PRE_ORCAMENTO_SATELITES')) Then
  Begin
    pMensagemOk('A pasta de compra para os Satélites não foi gerada!');
    Result := False;
    Exit;
  End;

  FLisCmp := strLisComprador;
  Result := TfrmGravando.fExecuta(fCarregaDadosPrg, frmGravando, 'Aguarde, calculando resumo por fornecedor...');
End;

Function TPastaCompra.fCarregaDadosPrg(cxProgresso: TCxProgressBar): Boolean;
Begin
  Self.AfterScroll := Nil;

  Self.qryQuery.SQL.Text := fSQLCompras(FLisCmp);

  Self.qryQuery.ParamByName('INIMES').AsDate := StartOfTheMonth(VS_Date);
  Self.qryQuery.ParamByName('FIMMES').AsDate := EndOfTheMonth(VS_Date);

  Result := fLeDados('TPastaCompra.fCarregaDados');

  frmGravando.lblGravando.Caption := 'Aguarde, calculando resumo por empresa...';
  Application.ProcessMessages;

  Result := Result And fCarregaResumo(FLisCmp, '', False, FEmpFil);

  If Not Result Then
    Exit;

  Self.pAlinhaCampoCentro('CODFOR');
  Self.pAlinhaCampoCentro('PREANT');

  objResumoEmpresa.pAlinhaCampoCentro('SIGEMP');
  objResumoEmpresa.pAlinhaCampoCentro('CODEMP');

  Try
    Self.DisableControls;

    cxProgresso.Properties.Max := Self.RecordCount;

    Self.First;
    While Not Self.Eof Do
    Begin
      Self.Edit;

      objResumoEmpresa.Filter   := 'CODFOR = ' + QuotedStr(Self.FieldByName('CODFOR').AsString) + ' AND VALCOM >= VALMIN ';
      objResumoEmpresa.Filtered := True;

      Self.FieldByName('FILMIN').AsInteger := objResumoEmpresa.RecordCount;

      objResumoEmpresa.Filter   := 'CODFOR = ' + QuotedStr(Self.FieldByName('CODFOR').AsString);
      objResumoEmpresa.Filtered := True;

      If objResumoEmpresa.RecordCount > 0 Then
        Self.FieldByName('MEDFIL').AsFloat :=  Self.FieldByName('VALCOM').AsFloat / objResumoEmpresa.RecordCount;


      If (Not Self.FieldByName('LIMPED').IsNull) And
         (RoundTo(Self.FieldByName('LIMPED').AsFloat, -4) < RoundTo(Self.FieldByName('VALCOM').AsFloat + Self.FieldByName('PEDMES').AsFloat, -4)) Then
        Self.FieldByName('PASLIM').AsInteger := 1;

      Self.Post;

      Self.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally

    Self.First;

    Self.AfterScroll := pAfterScroll;

    objResumoEmpresa.Filtered := False;

    pAfterScroll(Self);
    objResumoEmpresa.Filtered := True;

    Self.EnableControls;
  End;

End;

Procedure TPastaCompra.pAfterScroll(dataSet: TDataSet);
Begin
  If Not Self.IsEmpty Then
    objResumoEmpresa.Filter := 'CODFOR = ' + QuotedStr(Self.FieldByName('CODFOR').AsString);
End;

Function TPastaCompra.fTemFilialSelecionada: Boolean;
  Var
    intRecNo: Integer;
Begin

  objResumoEmpresa.DisableControls;
  intRecNo := objResumoEmpresa.RecNo;

  Try

    objResumoEmpresa.Filter   := 'GERARP = ' + QuotedStr('S');
    objResumoEmpresa.Filtered := True;

    Result := Not objResumoEmpresa.IsEmpty;

  Finally
    objResumoEmpresa.Filtered := False;

    If Not objResumoEmpresa.IsEmpty Then
      objResumoEmpresa.RecNo := intRecNo;

    objResumoEmpresa.EnableControls;
  End;

End;

Function TPastaCompra.fNroDeUmaEmpresaDestino: Integer;
  Var
    stlEmmpresas: TStringList;
Begin
  stlEmmpresas := TStringList.Create;

  Try
    stlEmmpresas.Sorted := True;
    stlEmmpresas.Duplicates := dupIgnore;

    objResumoEmpresa.First;

    While Not objResumoEmpresa.Eof Do
    Begin
      stlEmmpresas.Add(objResumoEmpresa.FieldByName('CODEMP').AsString);
      objResumoEmpresa.Next;
    End;

    Result := stlEmmpresas.Count;

  Finally
    FreeAndNil(stlEmmpresas);
  End;
End;

Function TPastaCompra.fGeraPedidosResumo: Boolean;
  Var
    intRecNo: Integer;
Begin
  Result := False;

  stlLisPed.Clear;

  objResumoEmpresa.DisableControls;
  intRecNo := objResumoEmpresa.RecNo;

  Try

    objResumoEmpresa.Filter   := 'GERARP = ' + QuotedStr('S');
    objResumoEmpresa.Filtered := True;

    FUsarDadosJaDigitados  := False;
    FQtdEmpresasDestino := fNroDeUmaEmpresaDestino;

    objResumoEmpresa.First;

    Begin
      While Not objResumoEmpresa.Eof Do
      Begin
        Result := True;
        Result := fGeraPedido(objResumoEmpresa.FieldByName('CODFOR').AsString,
                              objResumoEmpresa.FieldByName('CODEMP').AsString,
                              objResumoEmpresa.FieldByName('EMPGER').AsString);

        If Not Result Then
          Break;

        objResumoEmpresa.Next;
      End;

    End;


  Finally
    objResumoEmpresa.Filtered := False;

    If Not objResumoEmpresa.IsEmpty Then
      objResumoEmpresa.RecNo := intRecNo;

    objResumoEmpresa.EnableControls;

    If Assigned(frmDigObservacoes) Then
      pFreeAndNil(frmDigObservacoes);
  End;

  If Result Then
    pMensagemOk('Pedidos gerados com sucesso: ' + stlLisPed.CommaText + '!');
End;

Function TPastaCompra.fSQLItensGeraPedido: String;
  Var
    strSQL: String;
  Const
    cMarcado = 1;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   P.*,   ';
  strSQL := strSQL + '   C.ITE_CODUNI,   ';
  strSQL := strSQL + '   C.ITE_DESITE,    ';

  strSQL := strSQL + '   0 AS ITE_DESPIS, ';

  strSQL := strSQL + '   CAST("" AS CHAR(3)) AS ITE_CODSIT, ';
  strSQL := strSQL + '   0 AS ITE_UNIIMP, ';

  strSQL := strSQL + '   0 AS ITE_VALFRE, ';
  strSQL := strSQL + '   0 AS ITE_DESACE, ';

  strSQL := strSQL + '   G.ITE_CICMDE, ';
  strSQL := strSQL + '   G.ITE_CDPIOP, ';
  strSQL := strSQL + '   G.ITE_DIDIOP, ';

  strSQL := strSQL + '   0 AS   ITE_TOTIPI, ';
  strSQL := strSQL + '   0 AS   ITE_TOTSUB, ';
  strSQL := strSQL + '   C.ITE_INCPIS, ';
  strSQL := strSQL + '    ROUND(ROUND((PRE_UNILIQ * 100) / (100-((1 - ( ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF01, 0)/ 100)) * ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF02, 0)/ 100)) * ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF03, 0)/ 100)) * ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF04, 0)/ 100)) * ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF05, 0)/ 100)) * ';
  strSQL := strSQL + '               (1 - (IFNULL(G.ITE_DESF06, 0)/ 100)))) * 100)), 2), 4)  AS COMBRU, ';
 
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06 ';


  strSQL := strSQL + ' FROM              ';
  strSQL := strSQL + '   PRE_ORCAMENTO P ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = PRE_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = PRE_CODITE AND G.ITE_CODEMP =  PRE_CODEMP';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '       PRE_CODFOR = :CODFOR ';
  strSQL := strSQL + '   AND PRE_CODEMP = :CODEMP ';
  If Not fCfgSis('MARZER', varBoolean) Then
    strSQL := strSQL + '   AND PRE_QTDITE > 0       ';
  strSQL := strSQL + '   AND MARDES = ' + IntToStr(cMarcado);
  Result := strSQL;
End;

Class Function TPastaCompra.fPrazoEntrega(strCodFor, strCodEmp: String): Integer;
  Var
    qryEmpPra: TUniQuery;
Begin
  qryEmpPra := fCriaQuery;

  qryEmpPra.SQL.Text := 'SELECT IFNULL(PRA_DIAENT, 0) AS DIAENT FROM EMPPRA WHERE PRA_CODEMP = :CODEMP AND PRA_CODFOR = :CODFOR';
  qryEmpPra.ParamByName('CODFOR').AsString := strCodFor;
  qryEmpPra.ParamByName('CODEMP').AsString := strCodEmp;
  qryEmpPra.Open;

  If qryEmpPra.IsEmpty Then
    Result := 0
  Else
    Result := qryEmpPra.FieldByName('DIAENT').AsInteger;

  FreeAndNil(qryEmpPra);
End;

function TPastaCompra.fPrazoEntregaItem: integer;
begin
  If fCfgSis('ENTITE') <> 'S' Then
    Exit(0);
  Result :=  cdsItens.FieldByName('PRE_DIAENT').AsInteger;
end;

Procedure TPastaCompra.pApagaPreOrcamento(AstrCodFor, strCodEmp: String);
  Var
    qryOrcamento: TUniQuery;
Begin
  qryOrcamento := fCriaQuery;

  qryOrcamento.SQL.Text := 'DELETE FROM PRE_ORCAMENTO WHERE PRE_CODFOR = :CODFOR AND PRE_CODEMP = :CODEMP AND MARDES = 1';
  qryOrcamento.ParamByName('CODFOR').AsString := AstrCodFor;
  qryOrcamento.ParamByName('CODEMP').AsString := strCodEmp;
  qryOrcamento.ExecSQL;
  qryOrcamento.Close;


  FreeAndNil(qryOrcamento);
End;

Procedure TPastaCompra.pRateiaFreteDesAce(blnRecalcular: Boolean; fltValFreRat, fltDesAceRat: Double; strBStFrete, strBStDesAce, strBSIpiFrete: String);
var frmGravando2:  TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando2);
  Try
    Try


      fltValFreGer := fltValFreRat;
      fltDesAceGer := fltDesAceRat;

      strBStFre := strBStFrete;
      strBStDes := strBStDesAce;
      strIpiFre := strBSIpiFrete;

      frmGravando2.lblGravando.Caption := 'Calculando frete e despesas por item...';
      frmGravando2.fExecutarAcao := fRateiaFreteDesAcePrg;

      frmGravando2.ShowModal;

      FreeAndNil(frmGravando2);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pRateiaFreteDesAce]');
      End;
    End;
  Finally
      FreeAndNil(frmGravando2);
  End;
End;

function TPastaCompra.fCarregaDigObservacoes(strCodEmp, strEmpGer: string): Boolean;
  var
    stlObserv: TStringList;
    strNomEmp, strEndEmp, strCidEmp: String;
begin
  Try
    pDadosEntregaPedido(strNomEmp,
                        strEndEmp,
                        strCidEmp,
                        strCodEmp);

    If (Not FUsarDadosJaDigitados) And (Not Assigned(frmDigObservacoes)) Then
    Begin
      pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);
      frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')));
      frmDigObservacoes.Caption := 'Opções - Empresa Destino - ' + strEmpGer;

      frmDigObservacoes.edtNomEmp.Text := strNomEmp;
      frmDigObservacoes.edtEndEmp.Text := strEndEmp;
      frmDigObservacoes.edtCidEmp.Text := strCidEmp;

      stlObserv := fCarregaObservPedido;
      Try
        frmDigObservacoes.strCodComprador := FCodCmp;

        frmDigObservacoes.pnlAvisoEmpresas.Caption := 'Serão gerados pedidos para ' + FQtdEmpresasDestino.ToString + ' empresas.';
        frmDigObservacoes.blnVariasEmpresasDestino := FQtdEmpresasDestino > 1;

        frmDigObservacoes.memObserv.Lines := stlObserv;

        frmDigObservacoes.edtAtenca.Text  :=   fCampoTabela('FOR_NOMCTT', 'FORCTT', ['FOR_CODFOR', 'FOR_CMPCTT'], [strCodFor, 'S']);
      Finally
        FreeAndNil(stlObserv);
      End;

      If fEmptyStr(frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text) Then
        frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text := fCampoTabela('FOR_CODCTA', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);

      If Not fEmptyStr(frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text) Then
        frmDigObservacoes.fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text);

      frmDigObservacoes.gpbFinalPed.Visible := False;
      frmDigObservacoes.strCodFor := strCodFor;
      frmDigObservacoes.blnPastaDeCompra := True;

      frmDigObservacoes.strConPag := strConPag;
      frmDigObservacoes.dtaDtaEnt := fNow;

      frmDigObservacoes.mskDtaFat.Text := DateToStr(VS_Date);        // Data do Pedido

      // PASSA O PRAZO DE ENTREGA DIRETAMENTE PARA A VARIÁVEL
      frmDigObservacoes.intDiaDif := Max(0, fPrazoEntrega(strCodFor, strCodEmp));
      frmDigObservacoes.mskDtaPed.Text := DateToStr(VS_Date + frmDigObservacoes.intDiaDif); // Data Entrega

      frmDigObservacoes.fltTotGer := fDoubleAggregate(cdsItens, 'TOTGER'); // Total de Itens+IPI+SUB - Não está somado frete e desp. ace.
      frmDigObservacoes.strEspDoc := 'PD';

      frmDigObservacoes.cdsItensPedido := cdsItens;

      frmDigObservacoes.pRateiaFreteDesAce  := pRateiaFreteDesAce;

      frmDigObservacoes.ShowModal;
    End;

    Result := Assigned(frmDigObservacoes) And frmDigObservacoes.blnConfirma;

    If Result Then
    Begin
      RecDigObservacoes.blnEndLoj   := frmDigObservacoes.rdgEndEnt.ItemIndex = 1;
      RecDigObservacoes.strCodTra   := frmDigObservacoes.strCodTra;

      If FUsarDadosJaDigitados Then
      Begin
        RecDigObservacoes.strNomEmp   := strNomEmp;
        RecDigObservacoes.strEndEmp   := strEndEmp;
        RecDigObservacoes.strCidEmp   := strCidEmp;
      End Else
      Begin
        RecDigObservacoes.strNomEmp   := frmDigObservacoes.edtNomEmp.Text;
        RecDigObservacoes.strEndEmp   := frmDigObservacoes.edtEndEmp.Text;
        RecDigObservacoes.strCidEmp   := frmDigObservacoes.edtCidEmp.Text;
      End;

      FUsarDadosJaDigitados := frmDigObservacoes.chkReplicarDados.Checked;

      RecDigObservacoes.strObs001   := frmDigObservacoes.strObserv1;;
      RecDigObservacoes.strObs002   := frmDigObservacoes.strObserv2;;
      RecDigObservacoes.strObs003   := frmDigObservacoes.strObserv3;;
      RecDigObservacoes.strObs004   := frmDigObservacoes.strObserv4;;
      RecDigObservacoes.strObs005   := frmDigObservacoes.strObserv5;;

      RecDigObservacoes.strDtaEnt   := frmDigObservacoes.mskDtaPed.Text;
      RecDigObservacoes.strDtaFat   := frmDigObservacoes.mskDtaFat.Text;

      RecDigObservacoes.strTipFre   := frmDigObservacoes.strTipFre;
      RecDigObservacoes.fltValFre   := frmDigObservacoes.fltValFre;
      RecDigObservacoes.fltDesAce   := frmDigObservacoes.fltDesAce;

      RecDigObservacoes.strObsPd1   := frmDigObservacoes.strObserv1;
      RecDigObservacoes.strObsPd2   := frmDigObservacoes.strObserv2;
      RecDigObservacoes.strObsPd3   := frmDigObservacoes.strObserv3;
      RecDigObservacoes.strPedVen   := frmDigObservacoes.edtPedVen.Text;

      RecDigObservacoes.strAtenca   := frmDigObservacoes.strAtenca;
      RecDigObservacoes.strCodEve   := frmDigObservacoes.strCodEve;
      RecDigObservacoes.strCodCta   := fTiraCaracEspeciais(frmDigObservacoes.strCodCta);
      RecDigObservacoes.strEspDoc   := frmDigObservacoes.strEspDoc;

      RecDigObservacoes.strCodTraRedespacho := frmDigObservacoes.strCodTraRedespacho;
      RecDigObservacoes.strNomTraRedespacho := frmDigObservacoes.strNomTraRedespacho;
      RecDigObservacoes.strEndereRedespacho := frmDigObservacoes.strEndereRedespacho;
      RecDigObservacoes.strCidadeRedespacho := frmDigObservacoes.strCidadeRedespacho;
      RecDigObservacoes.strTipFreRedespacho := frmDigObservacoes.strTipFreRedespacho;
      RecDigObservacoes.strFinPed   := frmDigObservacoes.strFinPed;
      If fEmptyStr(RecDigObservacoes.strFinPed) then
        RecDigObservacoes.strFinPed := 'N';

      RecDigObservacoes.strCndPag := frmDigObservacoes.strConPag;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TPastaCompra.fCarregaDigObservacoes]');
    End;
  End;

  If Assigned(frmDigObservacoes) And (Not FUsarDadosJaDigitados) Then
    pFreeAndNil(frmDigObservacoes);
end;

Function TPastaCompra.fGeraPedido(strCodFor, strEmpOri, strEmpDes: String): Boolean;
Begin
  FEmpOri := strEmpOri;
  FEmpDes := strEmpDes;
  FCodFor := strCodFor;

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));
  strFRMPCM := fCfgSis('FRMPCM');
  pCarregaFornecedor(strCodFor);

  Result := TfrmGravando.fExecuta(fGeraPedidoPrg, frmGravando, 'Aguarde, gerando pedido...', True);
End;

Function TPastaCompra.fLocalizaCabecPreOrcamento(AstrCodFor: String; Var AstrCndPag: String; Var fltDesAdi: Double): Boolean;
  Var
    qryGPREOR: TUniQuery;
Begin
  qryGPREOR := fCriaQuery;
  qryGPREOR.SQL.Text := 'SELECT * FROM GPREOR WHERE PRE_CODFOR = :CODFOR';
  qryGPREOR.ParamByName('CODFOR').AsString := AstrCodFor;
  qryGPREOR.Open;

  Result := Not qryGPREOR.IsEmpty;

  If Result Then
  Begin
//    dtaDtaEnt := qryGPREOR.FieldByName('PRE_DTAENT').AsDateTime;
//    dtaDtaFat := qryGPREOR.FieldByName('PRE_DTAFAT').AsDateTime;
    AstrCndPag := qryGPREOR.FieldByName('PRE_CONPAG').AsString;
    fltDesAdi := qryGPREOR.FieldByName('PRE_DESADI').AsFloat;
  End;

  FreeAndNil(qryGPREOR);
End;

Function TPastaCompra.fGeraPedidoPrg(cxProgressBar: TcxProgressBar): Boolean;
Begin
  Try

    Try
      cdsItens := TZClient.Create(Nil, fSQLItensGeraPedido);
      cdsItens.pCriaSoma('PRE_TOTIPI', 'TOTIPI');
      cdsItens.pCriaSoma('PRE_TOTSUB', 'TOTSUB');
      cdsItens.pCriaSoma('PRE_TOTDAR', 'TOTDAR');
      cdsItens.pCriaSoma('PRE_SUBFCP', 'SUBFCP');
      cdsItens.pCriaSoma('PRE_TOTITE', 'TOTITE');
      cdsItens.pCriaSoma('PRE_VALTOT', 'TOTGER');
      cdsItens.pCriaSoma('PRE_BASICM', 'BASICM');
      cdsItens.pCriaSoma('PRE_VALICM', 'TOTICM');
      cdsItens.pCriaSoma('PRE_BASSUB', 'BASSUB');

      cdsItens.qryQuery.ParamByName('CODFOR').AsString := FCodFor;
      cdsItens.qryQuery.ParamByName('CODEMP').AsString := FEmpOri;


      Result := cdsItens.fLeDados('TPastaCompra.fGeraPedido');

      If Not fCarregaDigObservacoes(objResumoEmpresa.FieldByName('CODEMP').AsString,
                                    objResumoEmpresa.FieldByName('EMPGER').AsString) Then
        Exit(False);

      If Not Result Then
        Exit;

      If cdsItens.IsEmpty Then
        Exit;

      fStartTransaction;

      FCodEmp := VS_strCodEmp;
      FEspDoc := RecDigObservacoes.strEspDoc;

      If FEspDoc = 'PD' Then
        FNumPed := fSeqPedidoCompra
      Else
        FNumPed := fSeqOrcamento;

      stlLisPed.Add(FNumPed + '-' + FCodEmp);

      FCodCmp := cdsItens.FieldByName('PRE_COMPRA').AsString;
      FCodCta := fCampoTabela('FOR_CODCTA', 'CADFOR', ['FOR_CODFOR'], [FCodFor]);

      FHorPed := fTime();        // Hora do Pedido
      FDtaPed := VS_Date;        // Data do Pedido
      FDtaEnt := StrToDate(RecDigObservacoes.strDtaEnt);
      FDtaFat := StrToDate(RecDigObservacoes.strDtaFat);

      If Not fLocalizaCabecPreOrcamento(FCodFor, FCndPag, FDesAdi) Then
      Begin
        FDesAdi := 0;
        FCndPag := fCampoTabela('FOR_CNDPAG', 'CADFOR', ['FOR_CODFOR'], [FCodFor]);  // Cond. Pagamento
      End;

      frmGravando.pgbStatus.Properties.Max := cdsItens.RecordCount;
      frmGravando.pgbStatus.Position := 0;

      pGravaMestrePedido;

      FAutIncPcd := fRetAutoIncrem('PCMDET', VS_strCodEmp, cdsItens.RecordCount);

      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        pGravaItemPedido;

        FAutIncPcd := fNextAutoIncrem(FAutIncPcd);

        cdsItens.Next;

        frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      pAtualizaSaldoPedidoCompra(FNumPed, FEspDoc, FCodEmp);

      pApagaPreOrcamento(FCodFor, FEmpOri);

      fCommit;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, 'TPastaCompra.fGeraPedido');
      End;
    End;

  Finally
    FreeAndNil(cdsItens);
  End;
End;

Procedure TPastaCompra.pGravaMestrePedido;
  Var
    strAutGer: String;
Begin
  pGravaPcmGer(False,
               Nil,
               Nil,
               FNumPed,                               // Número do Pedido
               FCodEmp,                               // Empresa
               FEspDoc,                               // Espécie (PD / OR)
               FCodFor,                               // Fornecedor
               RecDigObservacoes.strCodTra,           // Transportadora
               RecDigObservacoes.strCodTraRedespacho, // RedesPacho
               FCndPag,                               // Cond. Pagamento
               FDtaPed,                               // Data do Pedido
               FHorPed,                               // Hora do Pedido
               FDtaEnt,                               // Data de Entrega
               FCodCmp,                               // Comprador
               fDoubleAggregate(cdsItens, 'TOTIPI'),  // Total de IPI
               fDoubleAggregate(cdsItens, 'TOTSUB'),  // Total de SUB
               fDoubleAggregate(cdsItens, 'TOTDAR'),  // Total de SUB
               fDoubleAggregate(cdsItens, 'SUBFCP'),  // Total de SUB FCP
               fDoubleAggregate(cdsItens, 'TOTITE'),  // Total de Itens
               fDoubleAggregate(cdsItens, 'TOTGER'),  // Total de Itens+IPI+SUB
               RecDigObservacoes.strObs001,           // Observação 1
               RecDigObservacoes.strObs002,           // Observação 2
               RecDigObservacoes.strObs003,           // Observação 3
               RecDigObservacoes.strObs004,           // Observação 4
               RecDigObservacoes.strObs005,           // Observação 5
               RecDigObservacoes.strObsPd1,           // Observ PD 1
               RecDigObservacoes.strObsPd2,           // Observ PD 2
               RecDigObservacoes.strObsPd3,           // Observ PD 3
               RecDigObservacoes.strPedVen,           // Pedido de venda
               RecDigObservacoes.strAtenca,           // Atenção de
               RecDigObservacoes.strTipFre,           // Tipo de Frete
               RecDigObservacoes.strTipFreRedespacho, // Tipo de Frete Redespacho
               '',                                    // Origem do Documento (Faturamento)
               0,                                     // Número do Container
               'N',                                   // Pedido de Importação?
               'N',                                   // Pedido Intrepostado?
               FEmpDes,                               // Codigo da empresa destino
               FDesAdi,                               // Desconto Adicional
               'N',                                   // Pedido Multi Lojas?
               RecDigObservacoes.fltValFre,           // Valor do Frete
               RecDigObservacoes.fltDesAce,           // Despesas Acessórias
               FDtaFat,                               // Data de Faturamento
               RecDigObservacoes.strCodEve,           // Código do Evento
               RecDigObservacoes.strCodCta,           // Centro de Custo
               RecDigObservacoes.strNomEmp,           // Nome p/ Entrega
               RecDigObservacoes.strEndEmp,           // Endereço p/ Entrega
               RecDigObservacoes.strCidEmp,           // Cidade p/ Entrega
               '',                                    // Nivel de Giro Selecionado A_B_C_
               nivNenhum,                             // Usa Nivel de Giro
               0,                                     // Dias Compra Geral
               0,                                     // Dias Compra Nivel A
               0,                                     // Dias Compra Nivel B
               0,                                     // Dias Compra Nivel C
               0,                                     // fRetImposto('BASCOF')
               0,                                     // fRetImposto('VALCOF')
               0,                                     // fRetImposto('BASPIS')
               0,                                     // fRetImposto('VALPIS')
               fDoubleAggregate(cdsItens, 'BASICM'),  // fltBasIcm
               fDoubleAggregate(cdsItens, 'TOTICM'),  // fltValIcm
               fDoubleAggregate(cdsItens, 'TOTITE'),  // fltBasIpi
               fDoubleAggregate(cdsItens, 'BASSUB'),  // fltBasSub
               IIF(fStatusCndPag(FCndPag) = A_VISTA, 'S', 'N'), // Pagamento A Vista
               '',                                    // Número da cotação
               '',                                    // Empresa da cotação
               'N',                                   // strPedBon
               'N',                                   // strZeraST
               'P',
               0,                                     // intMesGir: Integer;
               'N',                                   // strMesAtu: String;
               '',                                    // Número do orçamento que originou o pedido
               0,                                     // fltValSis
               0,                                     // fltValMar
               0,                                     // fltDesPis
               strAutGer,                             // strAutInc
               'N',                                   // strUsaGir
               False,                                 // blnTabRestaura
               '',                                    // strCodDig
               '',                                    // strNumPok
               moeReal,                               // moeMoeda
               'S',                                   // strPreOrc
               strBStFre,
               strBStDes,
               '',
               '',
               strIpiFre);
End;

procedure TPastaCompra.SetFiltroDepartamento(const Value: String);
begin
  FstrFiltroDepartamento := Value;
  blnFiltrarItem := (FstrFiltroDepartamento <> '') Or (FstrFiltroMarca <> '');
end;

procedure TPastaCompra.SetFiltroFilEmpresa(const Value: TConsultasArray);
begin
  FarrFiltroFilEmpresa := Value;
end;

procedure TPastaCompra.SetFiltroLinhaGrupo(const Value: TConsultasArray);
begin
  FarrFiltroLinhaGrupo := Value;
end;

procedure TPastaCompra.SetFiltroMarca(const Value: String);
begin
  FstrFiltroMarca := Value;
  blnFiltrarItem := (FstrFiltroDepartamento <> '') Or (FstrFiltroMarca <> '');
end;

procedure TPastaCompra.SetConsiderarProdSobEnc(const Value: Boolean);
begin
  FblnConsiderarProdSobEnc := Value;
end;

Procedure TPastaCompra.pGravaItemPedido;
var
  qryInsert: TUniQuery;
  intQtdConCol: Integer;
  fltEmbala: Double;
Begin
  qryInsert := fCriaQuery;
  Try
    Try
      fltEmbala := 1;
      If blnCnvEmb Then
        fltEmbala := cdsItens.FieldByName('PRE_EMBALA').AsFloat;
      If fltEmbala <=0 Then
        fltEmbala := 1;

      intQtdConCol := 0;
      With cdsItens Do
      Begin
      qryInsert.SQL.Add(fGravaPcmDet(intQtdConCol,
                   Nil,
                   False,
                   '',
                   '',                                     // strCampoSaldoSub,
                   '',                                     // strCampoSaldoAdd:
                   intDeqTpc,                              // intDeqTpc
                   FNumPed,                                // Número do Pedido
                   FCodEmp,                                // Empresa
                   FEspDoc,                                // Espécie (PD / OR)
                   FCodFor,                                // Fornecedor
                   FieldByName('PRE_CODITE').AsString,     // Código Item
                   FieldByName('ITE_CODUNI').AsString,     // Código da Unidade
                   FDtaEnt + fPrazoEntregaItem,            // Data Entrega
                   FHorPed,                                // Hora do Pedido
                   FDtaPed,                                // Data do Pedido
                   FCndPag,                                // Cond. Pagamento
                   FieldByName('ITE_DESITE').AsString,     // Descrição Item
                   FieldByName('PRE_QTDITE').AsFloat / fltEmbala,      // Quantidade
                   FieldByName('COMBRU').AsFloat*fltEmbala,          // Preço Unitario
                   FieldByName('ITE_DESF01').AsFloat,      // % Desconto Unitario 1
                   FieldByName('ITE_DESF02').AsFloat,      // % Desconto Unitario 2
                   FieldByName('ITE_DESF03').AsFloat,      // % Desconto Unitario 3
                   FieldByName('ITE_DESF04').AsFloat,      // % Desconto Unitario 4
                   FieldByName('ITE_DESF05').AsFloat,      // % Desconto Unitario 5
                   FieldByName('ITE_DESF06').AsFloat,      // % Desconto Unitario 6
                   FieldByName('PRE_TOTITE').AsFloat,      // Total Itens S
                   FieldByName('PRE_IPIENT').AsFloat,      // Percentual IPI
                   FieldByName('PRE_TOTIPI').AsFloat,      // Total IPI
                   FieldByName('PRE_PERSUB').AsFloat,      // Percentual SUB
                   FieldByName('PRE_TOTSUB').AsFloat,      // Total SUB
                   FieldByName('PRE_TOTDAR').AsFloat,      // Total DARE
                   FieldByName('PRE_PERFCP').AsFloat,      // Percentual SUB FCP
                   FieldByName('PRE_SUBFCP').AsFloat,      // Total SUB FCP
                   0,                                      // Quantidade Baixa
                   0,                                      // Total Baixado
                   0,                                      // IPI Baixado
                   0,                                      // SUB Baixado
                   0,                                      // DARE Baixado
                   0,                                      // fltFCPBai
                   0,                                      // fltFreBai
                   0,                                      // fltAceBai
                   cdsItens.FieldByName('ITE_VALFRE').AsFloat, // fltValFre
                   cdsItens.FieldByName('ITE_DESACE').AsFloat, // fltDesAce
                   0,                                      // Baixado?
                   '',                                     // Origem do Documento (Faturamento)
                   0,                                      // Número do Container
                   'N',                                    // Pedido de Importação?
                   'N',                                    // Pedido Intrepostado
                   'N',                                    // Proveninete de Importação?
                   0,                                      // fltQTDINC
                   0,                                      // fltTRAINC
                   FAutIncPcd,                             // Auto Incremento
                   '',                                     // Código do produto acabado
                   '',                                     // Empresa do produto acabado
                   'N',                                    // Produto acabado? (S/N)
                   0,                                      // Conferencia de entrada
                   FieldByName('PRE_BASSUB').AsFloat,      // fltBasSub
                   FieldByName('PRE_TOTITE').AsFloat,      // fltBasIPI
                   FieldByName('PRE_BASICM').AsFloat,      // fltBasIcm
                   100,                                    // fltPerBas
                   FieldByName('PRE_ALQICM').AsFloat,      // fltAlqIcm
                   FieldByName('PRE_VALICM').AsFloat,      // fltValIcm
                   False,                                  // blnIncPis
                   '',                                     // strAutIncIRQ_comma: String;
                   0,                                      // fltAlqPis
                   0,                                      // fltAlqCof
                   0,                                      // fltAlqImp
                   0,                                      // fltValImp
                   0,                                      // fltValSis
                   0,                                      // fltValMar
                   '',                                     // strFatDor
                   fltEmbala,                              // fltEmbala
                   fltALPISP,                              // fltALPISP
                   fltALCOFP,                              // fltALCOFP
                   'N',                                    // strSubUsu
                   0,                                      // fltDesPis
                   False,                                  // blnTabRestaura
                   '',                                     // strSeqGer
                   True,                                   // blnInsere,
                   '',                                     // strAutoin
                   True,                                   // blnVeioAutIncPcdInclusao
                   IIF(FieldByName('PRE_NECAJU').AsFloat > 0, FieldByName('PRE_NECAJU').AsFloat, 0), // fltQtdOrc
                   0,                                      // dtaDatEdt
                   FieldByName('PRE_UNILIQ').AsFloat       // fltUniLiq
                   ));
        qryInsert.ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TPastaCompra.pGravaItemPedido]');
      End;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
End;

Function TPastaCompra.fTravaPastaFornecedor(strCodFor: String): Boolean;
Begin
  Result := fLock_Unlock('PASTA_COMPRA_' + strCodFor, True, False);

  If Not Result Then
    pMensagemOk('A pasta de compra do fornecedor ' + strCodFor + ' já está sendo alterada em outra estação: ' + fGetHostLock('PASTA_COMPRA_' + strCodFor) +  '!');
End;

Procedure TPastaCompra.pDestravaPastaFornecedor(strCodFor: String);
Begin
  fLock_Unlock('PASTA_COMPRA_' + strCodFor, False, False);
End;

Function TPastaCompra.fRateiaFreteDesAcePrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    fltValFreRes,
    fltDesAceRes,
    fltTotIteGer: Double;
Begin

  With cdsItens Do
  Begin
  //  Filter   := fFiltroCompra;
  //  Filtered := True;

    Try

      fltTotIteGer := fDoubleAggregate(cdsItens, 'TOTITE');

      First;

      fltValFreRes := fltValFreGer;
      fltDesAceRes := fltDesAceGer;

      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pRateiaFreteRegistro(fltValFreRes, fltDesAceRes,
                             fltValFreGer, fltDesAceGer, fltTotIteGer,
                             cdsItens);

        fltValFreRes := RoundTo(fltValFreRes - FieldByName('ITE_VALFRE').AsFloat, -2);
        fltDesAceRes := RoundTo(fltDesAceRes - FieldByName('ITE_DESACE').AsFloat, -2);

        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Finally

      Filtered := False;
      Filter   := '';

    End;

  End;

  Result := True;
End;


Procedure TPastaCompra.pRateiaFreteRegistro(Var fltValFreRes, fltDesAceRes: Double;
                                                      fltValFreGer, fltDesAceGer, fltTotIteGer: Double;
                                                      cdsDados: TUniClientDataSet);
  Var
//    fltFreAceAnt,

    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltAlqIPI,
    fltValIpi,
    fltBasIPI,
    fltPerFCP,
    fltSubFcp,
    fltTotDar,

    fltDesPis: Double;
    strCodSit,
    strCodSitOrigem: String;
    fltAliquotaSub: Double;
    fltRepFre: Double;

    ParametrosCalcImpostos: TParametrosCalculoImposto;

Begin
  if (fltValFreGer + fltDesAceGer) = 0 tHEN
    Exit;

  With cdsDados Do
  Begin
//    fltFreAceAnt := FieldByName('ITE_VALFRE').AsFloat + FieldByName('ITE_DESACE').AsFloat;

    Edit;

    If (fltValFreRes > 0) And (fltValFreGer > 0) Then
    Begin

      If RoundTo(cdsDados.FieldByName('PRE_TOTITE').AsFloat * (fltValFreGer / fltTotIteGer), -2) > fltValFreRes Then
        cdsDados.FieldByName('ITE_VALFRE').AsFloat := fltValFreRes
      Else
        FieldByName('ITE_VALFRE').AsFloat := RoundTo(FieldByName('PRE_TOTITE').AsFloat * (fltValFreGer / fltTotIteGer), -2);

    End
    Else FieldByName('ITE_VALFRE').AsFloat := 0;

    If (fltDesAceRes > 0) And (fltDesAceGer > 0) Then
    Begin

      If RoundTo(FieldByName('PRE_TOTITE').AsFloat * (fltDesAceGer / fltTotIteGer), -2) > fltDesAceRes Then
        FieldByName('ITE_DESACE').AsFloat := fltDesAceRes
      Else
        FieldByName('ITE_DESACE').AsFloat := RoundTo(FieldByName('PRE_TOTITE').AsFloat * (fltDesAceGer / fltTotIteGer), -2);

    End
    Else FieldByName('ITE_DESACE').AsFloat := 0;


    fltBaseST := 0;
    fltBasIcm := 0;
    fltAlqIcm := 0;
    fltValIcm := 0;

    ParametrosCalcImpostos.pSetaParametros(FieldByName('ITE_CICMDE').AsString,
                                           FieldByName('ITE_CDPIOP').AsString,
                                           FieldByName('ITE_DIDIOP').AsString);

    fltAlqIPI := FieldByName('PRE_IPIENT').AsFloat;
    fltBasIPI := FieldByName('PRE_TOTITE').AsFloat;


    fltRepFre := (cdsDados.FieldByName('ITE_VALFRE').AsFloat*100)/cdsDados.FieldByName('PRE_TOTITE').AsFloat;

    If (strIPIFre = 'S') And (fltRepFre > 0) And (fltBasIPI > 0) Then
      fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);

    FieldByName('PRE_COMPEN').AsInteger := IIF(FieldByName('PRE_ESTTOT').AsFloat <= FieldByName('PRE_QTDITE').AsFloat, 1, 0);

    FieldByName('PRE_TOTITE').AsFloat := RoundTo(FieldByName('PRE_UNILIQ').AsFloat * FieldByName('PRE_QTDITE').AsFloat, -2);


    If FieldByName('PRE_TOTITE').AsFloat > 0 Then
      FieldByName('PRE_TOTSUB').AsFloat := fCalcularSubstituicaoProduto(FieldByName('PRE_CODFOR').AsString,                        // strCodFor
                                                                        fRetornaAbreviacaoItem(FieldByName('PRE_CODITE').AsString),// strCodAbf
                                                                        cdsDados.FieldByName('PRE_TOTITE').AsFloat,                              //fltTotIte,
                                                                        FieldByName('ITE_VALFRE').AsFloat,                              //fltTotFre,
                                                                        FieldByName('ITE_DESACE').AsFloat,                              //fltTotAce: Double;

                                                                        strFRMPCM,                                                 // strFrmPcm

                                                                        strBStFre,                                                      //strBStFre,
                                                                        strBStDes,                                //strBStAce: String;

                                                                        blnZonaFranca,                                             // blnZonaFranca
                                                                        FieldByName('ITE_INCPIS').AsString = 'S',                  // blnIncPis

                                                                        strSimPau = 'S',                                                //blnFornecSimples: Boolean;
                                                                        blnTemDare,
                                                                        fltAlqIPI,
                                                                        False,

                                                                        fltBasIcm,                                                 // var fltBasIcm
                                                                        fltAlqIcm,                                                 // var fltAlqIcm
                                                                        fltValIcm,                                                 // var fltValIcm
                                                                        fltBaseST,                                                 // var fltBaseST
                                                                        fltDesPis,                                                 // var fltDesPis
                                                                        fltBasIPI,
                                                                        fltValIPI,
                                                                        fltPerFCP,
                                                                        fltSubFCP,
                                                                        fltTotDar,
                                                                        strCodSit,                                                 // var strCodSit
                                                                        strCodSitOrigem,
                                                                        fltAliquotaSub,                                            // var fltAliquotaSub
                                                                        ParametrosCalcImpostos)
    Else
    Begin
      FieldByName('PRE_TOTSUB').AsFloat := 0;
      fltValIPI := RoundTo(fltBasIpi * (fltAlqIPI / 100), -2);
    end;

    FieldByName('PRE_TOTDAR').AsFloat := fltTotDar;

    FieldByName('PRE_TOTIPI').AsFloat := fltValIPI;

    FieldByName('PRE_BASSUB').AsFloat := fltBaseST;
    FieldByName('PRE_BASICM').AsFloat := fltBasIcm;
    FieldByName('PRE_ALQICM').AsFloat := fltAlqIcm;
    FieldByName('PRE_VALICM').AsFloat := fltValIcm;

    FieldByName('PRE_PERFCP').AsFloat := fltPerFCP;
    FieldByName('PRE_SUBFCP').AsFloat := fltSubFCP;

    FieldByName('PRE_PERSUB').AsFloat := fltAliquotaSub;

    FieldByName('PRE_VALTOT').AsFloat := FieldByName('PRE_TOTITE').AsFloat +
                                         FieldByName('PRE_TOTIPI').AsFloat +
                                         FieldByName('PRE_SUBFCP').AsFloat +
                                         FieldByName('PRE_TOTSUB').AsFloat;

    If FieldByName('PRE_MEDMES').AsFloat > 0 Then
    Begin
      FieldByName('PRE_DIAEST').AsFloat := (FieldByName('PRE_ESTDIS').AsFloat + FieldByName('PRE_PEDCOM').AsFloat) / (FieldByName('PRE_MEDMES').AsFloat / 30);
      FieldByName('PRE_DIASUG').AsFloat := (FieldByName('PRE_QTDITE').AsFloat + FieldByName('PRE_ESTDIS').AsFloat + FieldByName('PRE_PEDCOM').AsFloat) / (FieldByName('PRE_MEDMES').AsFloat / 30);
    End;



    Post;
  End;
End;

procedure TPastaCompra.pCarregaFornecedor(AstrCodFor: String);
  Var
    strSQL: String;
    qryConFor: TUniQuery;
begin
  qryConFor := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CADFOR.*, ';
    strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFOR, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FOR_CODCID = CID_CODCID AND ';
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  FOR_C_G_C_ IS NOT NULL AND ';
    strSQL := strSQL + '  FOR_STATUS = "A" ';

    With qryConFor Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := AstrCodFor;
      Open;

      fltDesVis      := FieldByName('FOR_DESVIS').AsFloat;
      intCarPag      := FieldByName('FOR_CARPAG').AsInteger;
      strRedPis      := FieldByName('FOR_REDPIS').AsString;
      fltPisCof      := FieldByName('FOR_PISCOF').AsFloat;
      strSimPau      := FieldByName('FOR_SIMPAU').AsString;

      strTipAbfFor   := fGetTipoAbfFornecedor(AstrCodFor);
      blnZonaFranca  := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

      blnTemDare     := fEhEmpresaDARE And
                        (Not fEhEstadoRegraZonaFranca(FieldByName('FOR_ESTADO').AsString));


    End;
  Finally
    FreeAndNil(qryConFor);
  End;
End;

end.
