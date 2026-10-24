unit untGerenciaTransferenciaPedidoCompraMultiLoja;

interface
  uses Forms,Uni, untFuncoesSimples, Data.DB, Classes, strUtils, SysUtils,
       untZClient, cxProgressBar, untGravando, UniClientDataSet, untTypesSistema,
       untAtualizaOcorrenciasCRM, untFatGor, untFuncFatImp, untFuncFatTypes,
       untMsgValidacaoGeracaoOrcPed, untRelGeraOR, untFuncoesCRM, untTypesCRM,
       untConfGeraOrcPed, untTipoFreteAtc, untTFatReprocessarSaldoItem;

  Type
    TDocumento = Record
      strNumDoc: String;
      strEspDoc: String;
      strCodFor: String;
      strCodEmp: String;
      strSerie_: String;
    End;
    TpedidoCompra = Record
      strNumped: String;
      strCodEmp: String;
      strEspPed: String;
      strEmpOri: String;
    End;

    TGerenciaTransferenciaPedidoCompraMultiLoja = Class
    private
      cdsDados: TZClient;
      FDocumentoEntrada:TDocumento;
      FPedidoCompra: TpedidoCompra;
      blnUsaQtdPen: Boolean;
      intDecQtd: Integer;
      intDEQTEM: Integer;
      blnDefBai: Boolean;
      qryConsulta: TUniQuery;
      objOcoCrm : TAtuOcoCrm;

      strEspDoc: String;
      strNumDoc: String;
      strConfirma: String;
      strMen001: String;
      strMen002: String;
      strCodTra: String;
      fltValFre: Double;
      strTipFre: String;
      strTipPed: String;
      strEntFat: String;
      strCliFil: String;
      blnEmpFat: Boolean;
      strCodConPgt: String;
      strConPgtMas: String;
      fltTotGer   : Double;
      fltQtdIte   : Double;
      fltTotCus   : Double;
      fltTotMed   : Double;
      fltTotPes   : Double;
      strTabPre   : String;
      recServicos : TDadosServicos;
      ArrRecSepara  : Array of TDadosImpressaoVenda;
      arrDuplic : TarrDuplicata;

      procedure pMontaSQLDados;
      function fTemDefBai: Boolean;
      procedure pRedistribuiDiferencaArredondamento;
      Function fDistribuirItensNaoFracionados(pgbProgresso: TcxProgressBar): Boolean;
      function fReiniciaDistribuicao(strCodIte: String; fltDistribuido: Double): Boolean;

      function fGetQtdDifFrac(cdsItens: TUniClientDataSet; ACodIte: String): Double;
      procedure pDistribui(var fltQtd: Double; blnInsereLojaLogada: Boolean);
      function fProcessa(pgbProgresso: TcxProgressBar): Boolean;
      function fGravaPEDTRA(strIncFatGor: String; var strAutIncPedTra: String): Boolean;
      function fGravaDETTRA(strIncPcdDet: String; fltQtdIte: Double; strAutIncPedTra: String): Boolean;



      function fTemDiferencaArredondamento: Boolean;
      function fQuantidadeExcedeQuantidadeEntrada(pgbProgresso: TcxProgressBar): Boolean;
      function fGeraTranferencias(pgbProgresso: TcxProgressBar): Boolean;
      function fFinalizouItem(strCodIteAtu, strCodIteAnt: String): Boolean;
      function fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt: string): boolean;
      procedure pPedeInformacoesFrete;
      function fRetDesIte(strDesIte, strRefIte : String) : String;
      function fRetQtdItens(intPosIni, intPosFim: integer): Double;
      procedure pCrm;
      procedure pMontaCamposGenericos;
      procedure pMontaSQLDefBai;
      procedure pMontaSQLPreBai;

      procedure pMontaSQLPedido;
      function fRetSubtraQtdJaTransferida: String;
      function fGetSQLQtdBaixada: String;


      procedure pCalculaTotais(intPosIni, intPosFim: integer; var fltTotGer: Double; var fltTotCus: Double; var fltTotMed: Double; var fltTotPes: Double);

      procedure pSetaPosicoesEmpresa(strCodEmp: String; var intPosIni: integer;var intPosFim: integer);



    public
      Constructor Create(ADataSource: TDataSource; ADocumentoDeEntrada: TDocumento; APedidoCompra: TpedidoCompra);
      destructor Destroy;override;
      class function fValidaDocumentoEntrada(ADocumentoDeEntrada: TDocumento): Boolean;
      class function fValidaPedidoCompra(APedidoCompra: TpedidoCompra): Boolean;
      class function fValidaFornecedorDoPedidoPertenceAoGrupoDaEntrada(ADocumentoDeEntrada: TDocumento; APedidoCompra: TpedidoCompra): Boolean;
      class function fValidaPedidoMultiloja(APedidoCompra: TpedidoCompra): Boolean;


      class function fValidaPedidoCompraLiberado(APedidoCompra: TpedidoCompra): Boolean;
      function fGeraFatGor(strEmpDes: String; intPosIni, intPosFim: integer; var strAutInc: String): Boolean;
      function fGeraFatDor(strEmpDes: String; strIncFatGor: String): Boolean;
      function fConfirma: Boolean;
      class function fTemQueInformarOPedido(Documento: TDocumento): Boolean;
      class function fDocumentoExiste(Documento: TDocumento): Boolean;
      class function fRetAutoIncremMovGer(Documento: TDocumento): String;
      class function fDocumentoDeEntradaJaUtilizado(Documento: TDocumento; blnFinalizacao: Boolean = False): Boolean;
      function fGetListaPedidos: String;
      function fSemDados: Boolean;
  End;


  TCancelaTransferenciaPedidoCompraMultiLoja = class
  protected
    qryDoc: TUniQuery;
    FNumDoc: String;
    FEspDoc: String;
    FCodFor: String;
    FSerie: String;
    FCodEmp: String;

  public
    constructor Create;
    destructor Destroy; override;
    function fTemDocumentoDeTransferenciaFaturado: Boolean;
    class function fCarregaDocumentoCancelamento(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp: string):TCancelaTransferenciaPedidoCompraMultiLoja;
    function fTemTransferencia: Boolean;
    procedure pCancelaTransferencias;
  End;




implementation

uses
  untMensagemExplicativa, untCancelamentoDocResumo;



{ TGerenciaTransferenciaPedidoCompraMultiLoja }

constructor TGerenciaTransferenciaPedidoCompraMultiLoja.Create(ADataSource: TDataSource;
  ADocumentoDeEntrada: TDocumento; APedidoCompra: TpedidoCompra);
begin
  blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean));
  blnEmpFat    := fCfgSis('EMPFAT', varBoolean);
  blnDefBai    := False;
  qryConsulta  := fCriaQuery;
  If Not blnUsaQtdPen Then
    blnUsaQtdPen :=  fUsaQtdPendenteEntregaFutura;
  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDEQTEM :=  fCfgSis('DEQTEM', varInteger);
  FDocumentoEntrada := ADocumentoDeEntrada;
  FPedidoCompra     := APedidoCompra;
  cdsDados := TZClient.Create(nil);
  pMontaSQLDados;
  cdsDados.fAbreClient(False, '[TGerenciaTransferenciaPedidoCompraMultiLoja.Create]');
  ADataSource.DataSet := cdsDados;
  pRedistribuiDiferencaArredondamento;
end;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pMontaSQLDefBai;
begin
  cdsDados.qryQuery.SQL.Clear;
  cdsDados.qryQuery.SQL.Add('SELECT * FROM ( ');
  cdsDados.qryQuery.SQL.Add('SELECT CAST(CONCAT(PCDDET.PCD_EMPDES, " - ", CADEMP.EMP_NOMEMP) AS CHAR(100)) AS NOMEMP,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_EMPDES,');
  cdsDados.qryQuery.SQL.Add('       PCD_TOTITE,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_CODITE,');

  cdsDados.qryQuery.SQL.Add('       @QTDDES := PCDDET.PCD_QTDITE - ' + fRetSubtraQtdJaTransferida + ' AS QTDDES,');
  cdsDados.qryQuery.SQL.Add('       @RESPRES := (PCDDET.PCD_QTDITE * 100) /PCMDET.PCD_QTDITE REPRES,');
  cdsDados.qryQuery.SQL.Add('       @QTDDETDEF := ROUND(DEF_QTDITE / IFNULL(PCD_EMBALA, 1), 2) AS TOTENT,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA := ROUND(((@QTDDETDEF * @RESPRES) / 100), 2) AS QTDTRA_CALC,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA_ROUND := CAST(IF(IFNULL(UNI_ITEFRA, "S") = "N", FLOOR(@QTDTRA), @QTDTRA) AS DECIMAL(14,4)) AS QTDTRA,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA - @QTDTRA_ROUND AS DIF_QTDTRA,');

  pMontaCamposGenericos;

  cdsDados.qryQuery.SQL.Add('  FROM PCMGER');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODFOR = PCG_CODFOR');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODEMP = PCG_CODEMP');
  cdsDados.qryQuery.SQL.Add('                 AND PCG_ESPDOC = PCG_ESPDOC');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCDDET ON PCD_SEQGER = PCMDET.AUTOINCREM');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADITE C ON C.ITE_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER G ON G.ITE_CODITE = PCMDET.PCD_CODITE AND G.ITE_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER CD ON CD.ITE_CODITE = PCMDET.PCD_CODITE AND CD.ITE_CODEMP = ' + QuotedStr(VS_StrCodEmp));
  cdsDados.qryQuery.SQL.Add('INNER JOIN (SELECT SUM(DET_QTDITE) AS QTDDET, DET_CODITE');
  cdsDados.qryQuery.SQL.Add('              FROM MOVDET');
  cdsDados.qryQuery.SQL.Add('             WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp+ '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODFOR = "'+FDocumentoEntrada.strCodFor+'"');
  cdsDados.qryQuery.SQL.Add('               AND IFNULL(DET_SERIE_, "") = "'+FDocumentoEntrada.strSerie_+'"');
  cdsDados.qryQuery.SQL.Add('             GROUP BY DET_CODITE  ) M ON M.DET_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN DEFBAI ON DEFBAI.DEF_AUTPCD = PCMDET.AUTOINCREM');

  cdsDados.qryQuery.SQL.Add('  ORDER BY PCMDET.PCD_CODITE, PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add(') TMP ORDER BY ITE_DESITE, PCD_EMPDES ');
End;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pMontaSQLPreBai;
begin
  cdsDados.qryQuery.SQL.Clear;
  cdsDados.qryQuery.SQL.Add('SELECT * FROM ( ');
  cdsDados.qryQuery.SQL.Add('SELECT CAST(CONCAT(PCDDET.PCD_EMPDES, " - ", CADEMP.EMP_NOMEMP) AS CHAR(100)) AS NOMEMP,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_EMPDES,');
  cdsDados.qryQuery.SQL.Add('       PCD_TOTITE,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_CODITE,');
  cdsDados.qryQuery.SQL.Add('       @RESPRES := (PCDDET.PCD_QTDITE * 100) /PCMDET.PCD_QTDITE REPRES,');
  cdsDados.qryQuery.SQL.Add('       @QTDBAI := (' + fGetSQLQtdBaixada + '*@RESPRES)/100 AS QTDREL,');
  cdsDados.qryQuery.SQL.Add('       @QTDDES := PCDDET.PCD_QTDITE - ' + fRetSubtraQtdJaTransferida + ' - @QTDBAI AS QTDDES,');

  cdsDados.qryQuery.SQL.Add('       @QTDDETDEF := (SELECT SUM(ROUND(BAI_QTDPED / IFNULL(PCD_EMBALA, 1), 2)) FROM BAIPED ');
  cdsDados.qryQuery.SQL.Add('                       WHERE BAI_AUTDET IN (SELECT AUTOINCREM ');
  cdsDados.qryQuery.SQL.Add('                                              FROM MOVDET ');
  cdsDados.qryQuery.SQL.Add('                                             WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"');
  cdsDados.qryQuery.SQL.Add('                                               AND DET_CODFOR = "' + FDocumentoEntrada.strCodFor + '"');
  cdsDados.qryQuery.SQL.Add('                                               AND DET_ESPDOC = "' + FDocumentoEntrada.strEspDoc + '"');
  cdsDados.qryQuery.SQL.Add('                                               AND DET_CODITE = PCMDET.PCD_CODITE ');
  cdsDados.qryQuery.SQL.Add('                                               AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp + '"');
  cdsDados.qryQuery.SQL.Add('                                               AND IFNULL(DET_SERIE_, "") = "' + FDocumentoEntrada.strSerie_ + '")) AS TOTENT,');

  cdsDados.qryQuery.SQL.Add('       @QTDTRA := IF(ROUND(((@QTDDETDEF * @RESPRES) / 100), 2) > PCDDET.PCD_QTDITE, PCDDET.PCD_QTDITE, ROUND(((@QTDDETDEF * @RESPRES) / 100), 2)) AS QTDTRA_CALC,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA_ROUND := CAST(IF(IFNULL(UNI_ITEFRA, "S") = "N", FLOOR(@QTDTRA), @QTDTRA) AS DECIMAL(14,4)) AS QTDTRA,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA - @QTDTRA_ROUND AS DIF_QTDTRA,');

  pMontaCamposGenericos;

  cdsDados.qryQuery.SQL.Add('  FROM PCMGER');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODFOR = PCG_CODFOR');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODEMP = PCG_CODEMP');
  cdsDados.qryQuery.SQL.Add('                 AND PCG_ESPDOC = PCG_ESPDOC');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADUNI ON UNI_CODUNI =  PCD_CODUNI');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCDDET ON PCD_SEQGER = PCMDET.AUTOINCREM');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADITE C ON C.ITE_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER G ON G.ITE_CODITE = PCMDET.PCD_CODITE AND G.ITE_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER CD ON CD.ITE_CODITE = PCMDET.PCD_CODITE AND CD.ITE_CODEMP = ' + QuotedStr(VS_StrCodEmp));
  cdsDados.qryQuery.SQL.Add('INNER JOIN (SELECT SUM(DET_QTDITE) AS QTDDET, DET_CODITE');
  cdsDados.qryQuery.SQL.Add('              FROM MOVDET');
  cdsDados.qryQuery.SQL.Add('             WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp+ '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODFOR = "'+FDocumentoEntrada.strCodFor+'"');
  cdsDados.qryQuery.SQL.Add('               AND IFNULL(DET_SERIE_, "") = "'+FDocumentoEntrada.strSerie_+'"');
  cdsDados.qryQuery.SQL.Add('             GROUP BY DET_CODITE  ) M ON M.DET_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN BAIPED ON BAIPED.BAI_AUTPED = PCMDET.AUTOINCREM');
  cdsDados.qryQuery.SQL.Add('                  AND BAI_AUTDET IN (SELECT AUTOINCREM');
  cdsDados.qryQuery.SQL.Add('                                       FROM MOVDET');
  cdsDados.qryQuery.SQL.Add('                                      WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"');
  cdsDados.qryQuery.SQL.Add('                                        AND DET_CODFOR = "' + FDocumentoEntrada.strCodFor + '"');
  cdsDados.qryQuery.SQL.Add('                                        AND DET_ESPDOC = "' + FDocumentoEntrada.strEspDoc + '"');
  cdsDados.qryQuery.SQL.Add('                                        AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp + '"');
  cdsDados.qryQuery.SQL.Add('                                        AND IFNULL(DET_SERIE_, "") = "' + FDocumentoEntrada.strSerie_ + '")');

  cdsDados.qryQuery.SQL.Add('  ORDER BY PCMDET.PCD_CODITE, PCDDET.PCD_EMPDES');

  cdsDados.qryQuery.SQL.Add(') TMP ORDER BY ITE_DESITE, PCD_EMPDES ');

End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fRetSubtraQtdJaTransferida: String;
begin
  Result := '';
  Result := Result + 'IFNULL((SELECT SUM(TRA_QTDITE) FROM DETTRA WHERE TRA_PCDDET = PCDDET.AUTOINCREM), 0)'
End;


function TGerenciaTransferenciaPedidoCompraMultiLoja.fGetSQLQtdBaixada: String;
begin
  Result := '';

  Result := Result + 'IFNULL((SELECT SUM(BAI_QTDPED) FROM BAIPED WHERE BAI_AUTPED IN (PCMDET.AUTOINCREM) ';
  Result := Result + '  AND IFNULL((SELECT COUNT(1) FROM DETTRA WHERE TRA_PCDDET = PCDDET.AUTOINCREM), 0) = 0 ';
  Result := Result + '  AND BAI_AUTDET NOT IN (SELECT AUTOINCREM  ' ;
  Result := Result + '                           FROM MOVDET';
  Result := Result + '                          WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"';
  Result := Result + '                            AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp + '"';
  Result := Result + '                            AND DET_CODFOR = "' + FDocumentoEntrada.strCodFor + '"';
  Result := Result + '                            AND DET_CODITE = PCMDET.PCD_CODITE';

  Result := Result + '                            AND IFNULL(DET_SERIE_, "") = "'+FDocumentoEntrada.strSerie_+'")),0)';
End;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pMontaSQLPedido;
Begin
  cdsDados.qryQuery.SQL.Clear;
  cdsDados.qryQuery.SQL.Add('SELECT * FROM ( ');
  cdsDados.qryQuery.SQL.Add('SELECT CAST(CONCAT(PCDDET.PCD_EMPDES, " - ", CADEMP.EMP_NOMEMP) AS CHAR(100)) AS NOMEMP,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_EMPDES,');
  cdsDados.qryQuery.SQL.Add('       PCD_TOTITE,');
  cdsDados.qryQuery.SQL.Add('       PCDDET.PCD_CODITE,');
  cdsDados.qryQuery.SQL.Add('       @RESPRES := (PCDDET.PCD_QTDITE * 100) /PCMDET.PCD_QTDITE REPRES,');
  cdsDados.qryQuery.SQL.Add('       @QTDBAI := (' + fGetSQLQtdBaixada + '*@RESPRES)/100 AS QTDREL,');

  cdsDados.qryQuery.SQL.Add('       @QTDDES := PCDDET.PCD_QTDITE - ' + fRetSubtraQtdJaTransferida + ' - @QTDBAI AS QTDDES,');
  cdsDados.qryQuery.SQL.Add('       @QTDDETDEF := ROUND(QTDDET / IFNULL(PCD_EMBALA, 1), 2) AS TOTENT,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA := IF(ROUND(((@QTDDETDEF * @RESPRES) / 100), 2) > PCDDET.PCD_QTDITE, PCDDET.PCD_QTDITE, ROUND(((@QTDDETDEF * @RESPRES) / 100), 2)) AS QTDTRA_CALC,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA_ROUND := CAST(IF(IFNULL(UNI_ITEFRA, "S") = "N", FLOOR(@QTDTRA), @QTDTRA) AS DECIMAL(14,4)) AS QTDTRA,');
  cdsDados.qryQuery.SQL.Add('       @QTDTRA - @QTDTRA_ROUND AS DIF_QTDTRA,');

  pMontaCamposGenericos;

  cdsDados.qryQuery.SQL.Add('  FROM PCMGER');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODFOR = PCG_CODFOR');
  cdsDados.qryQuery.SQL.Add('                 AND PCD_CODEMP = PCG_CODEMP');
  cdsDados.qryQuery.SQL.Add('                 AND PCG_ESPDOC = PCG_ESPDOC');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADUNI ON UNI_CODUNI =  PCD_CODUNI');
  cdsDados.qryQuery.SQL.Add('INNER JOIN PCDDET ON PCD_SEQGER = PCMDET.AUTOINCREM');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN CADITE C ON C.ITE_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER G ON G.ITE_CODITE = PCMDET.PCD_CODITE AND G.ITE_CODEMP = PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add('INNER JOIN ITEGER CD ON CD.ITE_CODITE = PCMDET.PCD_CODITE AND CD.ITE_CODEMP = ' + QuotedStr(VS_StrCodEmp));
  cdsDados.qryQuery.SQL.Add('INNER JOIN (SELECT SUM(DET_QTDITE) AS QTDDET, DET_CODITE');
  cdsDados.qryQuery.SQL.Add('              FROM MOVDET');
  cdsDados.qryQuery.SQL.Add('             WHERE DET_NUMDOC = "' + FDocumentoEntrada.strNumDoc + '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODEMP = "' + FDocumentoEntrada.strCodEmp + '"');
  cdsDados.qryQuery.SQL.Add('               AND DET_CODFOR = "' + FDocumentoEntrada.strCodFor + '"');
  cdsDados.qryQuery.SQL.Add('               AND IFNULL(DET_SERIE_, "") = "'+FDocumentoEntrada.strSerie_+'"');
  cdsDados.qryQuery.SQL.Add('             GROUP BY DET_CODITE  ) M ON M.DET_CODITE = PCMDET.PCD_CODITE');
  cdsDados.qryQuery.SQL.Add('WHERE PCG_NUMPED = "'+ FPedidoCompra.strNumped+'"');
  cdsDados.qryQuery.SQL.Add('  AND PCG_ESPDOC = "'+ FPedidoCompra.strEspPed+'"');
  cdsDados.qryQuery.SQL.Add('  AND PCG_CODEMP = "'+ FPedidoCompra.strCodEmp+'"');
  cdsDados.qryQuery.SQL.Add('  AND PCG_NUMCTN = 0');

  If FPedidoCompra.strEmpOri <> '' Then
    cdsDados.qryQuery.SQL.Add('  AND PCDDET.PCD_EMPDES = "'+FPedidoCompra.strEmpOri+'"');
  cdsDados.qryQuery.SQL.Add('  ORDER BY PCMDET.PCD_CODITE, PCDDET.PCD_EMPDES');
  cdsDados.qryQuery.SQL.Add(') TMP ORDER BY ITE_DESITE, PCD_EMPDES ');
End;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pMontaCamposGenericos;
begin
  cdsDados.qryQuery.SQL.Add('       ROUND(G.ITE_SALDOS + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(CD.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('G'), '0') + ', ' + intDecQtd.ToString + ')AS SALFIS,');
  cdsDados.qryQuery.SQL.Add('       ROUND(' + fSQLSaldoDisponivel('G', True, False, True) +  ', ' + intDecQtd.ToString + ') AS SALDIS, ');
  cdsDados.qryQuery.SQL.Add('       ITE_DESITE, ');
  cdsDados.qryQuery.SQL.Add('       ITE_REFERE,');
  cdsDados.qryQuery.SQL.Add('       UNI_SIGUNI, ');
  cdsDados.qryQuery.SQL.Add('       UNI_CODUNI, ');
  cdsDados.qryQuery.SQL.Add('       CAST("" AS CHAR(1)) AS NUMLOT, ');
  cdsDados.qryQuery.SQL.Add('       ITE_INCPIS AS INCPIS, ');
  cdsDados.qryQuery.SQL.Add('       UNI_ITEFRA, ');
  cdsDados.qryQuery.SQL.Add('       G.ITE_ESTMIN, ');
  cdsDados.qryQuery.SQL.Add('       G.ITE_ESTMAX, ');
  cdsDados.qryQuery.SQL.Add('       C.ITE_CODMAR AS CODMAR, ');
  cdsDados.qryQuery.SQL.Add('       PCDDET.AUTOINCREM AS INC_PCDDET, ');

  cdsDados.qryQuery.SQL.Add('       PCG_NUMPED, ');
  cdsDados.qryQuery.SQL.Add('       PCG_ESPDOC, ');
  cdsDados.qryQuery.SQL.Add('       PCG_CODEMP, ');


  cdsDados.qryQuery.SQL.Add(TRelGeraOR.fSQLUnitarioAlias('CD.', VS_StrCodEmp) + ' AS UNITAR,');
  cdsDados.qryQuery.SQL.Add('       CD.ITE_PRECUS AS PRECUS, ');
  cdsDados.qryQuery.SQL.Add('       CD.ITE_PREMED AS PREMED, ');
  cdsDados.qryQuery.SQL.Add('       CD.ITE_ICMSAI AS ICMSAI, ');
  cdsDados.qryQuery.SQL.Add('       CD.ITE_IPISAI AS IPISAI, ');
  cdsDados.qryQuery.SQL.Add('       CD.ITE_SUBSTI AS SUBSTI, ');
  cdsDados.qryQuery.SQL.Add('       ITE_PESOIT AS PESOIT, ');
  cdsDados.qryQuery.SQL.Add('       PCMGER.PCG_CODFOR, ');
  cdsDados.qryQuery.SQL.Add('       QTDDET,');
  cdsDados.qryQuery.SQL.Add('       CAST(CONCAT(PCDDET.PCD_CODITE, "-", ITE_DESITE , " Qtd. Entrada: ", ROUND(QTDDET / IFNULL(PCD_EMBALA, 1), 2),');
  cdsDados.qryQuery.SQL.Add('       " ",  UNI_SIGUNI, "      Qtd. Distribuida Para o Pedido: ", @QTDDETDEF, "<TAG_SEPARATOR_AUTCOM>") AS CHAR(255))AS AGRUP ');
End;



procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pMontaSQLDados;
Begin
  If Not fTemQueInformarOPedido(FDocumentoEntrada) Then
    pMontaSQLPreBai
  Else If fTemDefBai then
    pMontaSQLDefBai
  Else
    pMontaSQLPedido ;
End;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pRedistribuiDiferencaArredondamento;
begin
  If Not fTemDiferencaArredondamento then
    Exit;
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.lblGravando.Caption := 'Distribuindo diferença de itens sem fracionamento...';
    frmGravando.fExecutarAcao := fDistribuirItensNaoFracionados;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fTemDiferencaArredondamento: Boolean;
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := 'DIF_QTDTRA > 0';
  cdsDados.Filtered := True;

  Result := cdsDados.RecordCount > 0;

  cdsDados.Filtered := False;
  cdsDados.Filter := '';

end;

destructor TGerenciaTransferenciaPedidoCompraMultiLoja.Destroy;
begin
  FreeAndNil(cdsDados);
  FreeAndNil(qryConsulta);
end;


function TGerenciaTransferenciaPedidoCompraMultiLoja.fDistribuirItensNaoFracionados(
  pgbProgresso: TcxProgressBar): Boolean;
  var cdsBackup: TUniClientDataSet;
      strCodIte: String;
      fltQtdRestoDif: Double;
      recNo: integer;
      fltQtdRestoDifOld: Double;
      blnAtribuiRestoNaEmpresa : Boolean;

begin
  Try
    recNo := 0;
    cdsBackup := TUniClientDataSet.Create(nil);
    Try
      cdsBackup.Data := cdsDados.Data;
      cdsDados.IndexFieldNames := 'PCD_CODITE;PCD_EMPDES';
      cdsDados.First;
      strCodIte := '';
      pgbProgresso.Properties.Max :=  cdsDados.RecordCount;
      fltQtdRestoDifOld := -1;
      blnAtribuiRestoNaEmpresa := False;
      while not cdsDados.Eof Do
      Begin
        If strCodIte <> cdsDados.FieldByName('PCD_CODITE').AsString Then
        Begin
          strCodIte := cdsDados.FieldByName('PCD_CODITE').AsString;
          fltQtdRestoDif := fGetQtdDifFrac(cdsBackup, strCodIte);
          recNo := cdsDados.RecNo;
          pgbProgresso.Position := recNo;
          fltQtdRestoDifOld := -1;
          blnAtribuiRestoNaEmpresa := False;
        End;

        If fltQtdRestoDif <= 0 Then
        Begin
          cdsDados.Next;
          Continue;
        End;

        pDistribui(fltQtdRestoDif, blnAtribuiRestoNaEmpresa);
        cdsDados.Next;

        If fReiniciaDistribuicao(strCodIte, fltQtdRestoDif) Then
        Begin
          If  fltQtdRestoDifOld = fltQtdRestoDif Then
            fltQtdRestoDifOld := fltQtdRestoDif
          Else
            blnAtribuiRestoNaEmpresa := True;
          cdsDados.RecNo := recNo;
        End;
      End;
      Result := True;
    Finally
      FreeAndNil(cdsBackup);
    End;
  Except
    on e:exception do
      Raise e;
  End
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fReiniciaDistribuicao(strCodIte: String; fltDistribuido: Double): Boolean;
begin
  Result := false;
  If cdsDados.Eof Then
  Begin
    If fltDistribuido > 0 Then
      Result := True;
  End
  Else If strCodIte <> cdsDados.FieldByName('PCD_CODITE').AsString Then
  Begin
    If fltDistribuido > 0 Then
      Result := True;
  End
End;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pDistribui(var fltQtd: Double; blnInsereLojaLogada: Boolean);
begin
  //A quantidade nova não pode ultrapassar a quantidade do Destino No Pedido
  If (cdsDados.FieldByName('QTDTRA').AsFloat + 1)  <= cdsDados.FieldByName('QTDDES').AsFloat  then
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('QTDTRA').AsFloat := cdsDados.FieldByName('QTDTRA').AsFloat + 1;
    fltQtd := fltQtd -1;
    cdsDados.Post;
  End
  Else If blnInsereLojaLogada Then
  Begin
    If cdsDados.FieldByName('PCD_EMPDES').AsString = VS_StrCodEmp Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('QTDTRA').AsFloat := cdsDados.FieldByName('QTDTRA').AsFloat + 1;
      fltQtd := fltQtd -1;
      cdsDados.Post;
    End;
  End;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGravaPEDTRA(strIncFatGor: String; var strAutIncPedTra: String): Boolean;
var qryComand: TUniQuery;
begin
  Result := True;
  Try
    qryComand := fCriaQuery;
    Try
      strAutIncPedTra := fRetAutoIncrem('PEDTRA', VS_strCodEmp);
      qryComand.SQL.Add('INSERT INTO PEDTRA (TRA_FATGOR, AUTOINCREM, TRA_NUMDOC, TRA_ESPDOC, TRA_CODFOR, TRA_SERIE_, TRA_CODEMP) VALUES (:TRA_FATGOR, :AUTOINCREM, :TRA_NUMDOC, :TRA_ESPDOC, :TRA_CODFOR, :TRA_SERIE_, :TRA_CODEMP)');
      qryComand.ParamByName('TRA_FATGOR').AsString :=  strIncFatGor;
      qryComand.ParamByName('TRA_NUMDOC').AsString :=  FDocumentoEntrada.strNumDoc;
      qryComand.ParamByName('TRA_ESPDOC').AsString :=  FDocumentoEntrada.strEspDoc;
      qryComand.ParamByName('TRA_CODFOR').AsString :=  FDocumentoEntrada.strCodFor;
      qryComand.ParamByName('TRA_SERIE_').AsString :=  FDocumentoEntrada.strSerie_;
      qryComand.ParamByName('TRA_CODEMP').AsString :=  FDocumentoEntrada.strCodEmp;

      qryComand.ParamByName('AUTOINCREM').AsString :=  strAutIncPedTra;
      qryComand.ExecSQL;
    Finally
      FreeAndNil(qryComand);
    End;
  Except
    on e: Exception do
    begin
      pMensagensErro(e.message, '[TGerenciaTransferenciaPedidoCompraMultiLoja.fGravaPEDTRA]');
      Result := False;
    End;
  End;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGravaDETTRA(strIncPcdDet: String; fltQtdIte: Double; strAutIncPedTra: String): Boolean;
var qryComand: TUniQuery;
begin
  Result := True;
  try
    qryComand := fCriaQuery;
    Try
      qryComand.SQL.Add('INSERT INTO DETTRA (TRA_SEQGER, TRA_PCDDET, TRA_QTDITE) VALUES (:TRA_SEQGER, :TRA_PCDDET, :TRA_QTDITE)');
      qryComand.ParamByName('TRA_SEQGER').AsString :=  strAutIncPedTra;
      qryComand.ParamByName('TRA_PCDDET').AsString :=  strIncPcdDet;
      qryComand.ParamByName('TRA_QTDITE').AsFloat :=  fltQtdIte;
      qryComand.ExecSQL;
    Finally
      FreeAndNil(qryComand);
    End;
  Except
    on e: Exception do
    begin
      pMensagensErro(e.message, '[TGerenciaTransferenciaPedidoCompraMultiLoja.fGravaDETTRA]');
      Result := False;
    End;
  End;
{
CREATE TABLE DETTRA(
  TRA_SEQGER VARCHAR(20) DEFAULT NULL,
  TRA_PCDDET VARCHAR(20) DEFAULT NULL,
  TRA_QTDITE DECIMAL(14,4) DEFAULT NULL}
End;


function TGerenciaTransferenciaPedidoCompraMultiLoja.fProcessa(pgbProgresso: TcxProgressBar): Boolean;
  var strCodEmp: String;
      intPosIni, intPosFim: integer;
      strIncFatGor: String;
      strIncPedTra: String;
Begin
  Result := True;
  strCodEmp := '';
  while not cdsDados.Eof do
  Begin
    If cdsDados.FieldByName('QTDTRA').AsFloat > 0 Then
    Begin
      If strCodEmp <> cdsDados.FieldByName('PCD_EMPDES').AsString Then
      Begin
        strCodEmp := cdsDados.FieldByName('PCD_EMPDES').AsString;
        pSetaPosicoesEmpresa(strCodEmp, intPosIni, intPosFim);
        cdsDados.RecNo := intPosIni;
        Result := Result And fGeraFatGor(strCodEmp, intPosIni, intPosFim, strIncFatGor);
        cdsDados.RecNo := intPosIni;
        Result := Result and fGravaPEDTRA(strIncFatGor, strIncPedTra);
        If not Result then
          Exit(False);
      End;
      Result := Result and fGeraFatDor(strCodEmp, strIncFatGor);
      Result := Result and fGravaDETTRA(cdsDados.FieldByName('INC_PCDDET').AsString, cdsDados.FieldByName('QTDTRA').AsFloat, strIncPedTra);
      If not Result Then
        Exit(False);
    End;
    cdsDados.Next;
    If Result and (strCodEmp <> cdsDados.FieldByName('PCD_EMPDES').AsString) then
    Begin
      TReprocessarSaldoItem.New
      .AddItensDoDocumento(TItensReprocessarDoDocumento.New
         .Documento(strNumDoc)
         .Especie(strEspDoc)
         .Empresa(VS_strCodEmp)
       ).ReprocessarSaldoPedidos(nil);
    End;

    pgbProgresso.Position := cdsDados.RecNo;
    Application.ProcessMessages;
  End;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGeraTranferencias(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  cdsDados.DisableControls;
  cdsDados.Filtered := False;
  cdsDados.Filter := 'PCD_EMPDES <> ' +QuotedStr(VS_StrCodEmp);
  cdsDados.Filtered := True;
  cdsDados.IndexFieldNames := 'PCD_EMPDES';
  Try

    cdsDados.First;
    pgbProgresso.Properties.Max := cdsDados.RecordCount -1;
    pPedeInformacoesFrete;
    fStartTransaction;
    Try
      Result := fProcessa(pgbProgresso);

      If Result Then
      begin
        fCommit;
        fDocumentoDeEntradaJaUtilizado(FDocumentoEntrada, True);
      End
      Else
      Begin
        pMensagemOk('Houve falhas na geração das transferências!');
        fRollBack;
      End;
    Except
      On e: Exception do
      begin
        fRollBack;
        pMensagensErro(e.message,'[TGerenciaTransferenciaPedidoCompraMultiLoja.fGeraTranferencias]');
        Result := False;
      End;
    End
  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter := '';
    cdsDados.EnableControls;
  End;
end;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pSetaPosicoesEmpresa(strCodEmp: String; var intPosIni: integer;var intPosFim: integer);
Begin
  intPosIni := cdsDados.RecNo;
  intPosFim := -1;
  while not cdsDados.Eof do
  begin
    If strCodEmp <> cdsDados.FieldByName('PCD_EMPDES').AsString Then
    Begin
      intPosFim := cdsDados.RecNo -1;
      Break;
    End;
    cdsDados.Next;
  End;

  If intPosFim = -1 Then
    intPosFim := cdsDados.RecNo;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGetListaPedidos: String;
begin
  cdsDados.First;
  Result := '';
  while not cdsDados.Eof Do
  Begin
    If pos(cdsDados.FieldByName('PCG_NUMPED').AsString + '-'+
           cdsDados.FieldByName('PCG_ESPDOC').AsString + '-'+
           cdsDados.FieldByName('PCG_CODEMP').AsString, Result) = 0 Then
      Result := Result + IIf(Result = '', '', ', ') + cdsDados.FieldByName('PCG_NUMPED').AsString + '-' +
                                                      cdsDados.FieldByName('PCG_ESPDOC').AsString + '-' +
                                                      cdsDados.FieldByName('PCG_CODEMP').AsString;
    cdsDados.nEXT;
  End;
  cdsDados.First;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGetQtdDifFrac(cdsItens: TUniClientDataSet; ACodIte: String): Double;
begin
  result := 0;
  cdsItens.Filtered := False;
  cdsItens.Filter := 'PCD_CODITE = ' + QuotedStr(ACodIte);
  cdsItens.Filtered := True;
  While Not cdsItens.Eof Do
  begin
    result := result + cdsItens.FieldByName('DIF_QTDTRA').AsFloat;
    cdsItens.Next;
  End;
End;


function TGerenciaTransferenciaPedidoCompraMultiLoja.fQuantidadeExcedeQuantidadeEntrada(pgbProgresso: TcxProgressBar): Boolean;
  var
    strCodIte: String;
    fltQtdIte: Double;
    fltTotIteEntrada: Double;
begin
  Result := False;
  cdsDados.First;
  strCodIte := '';
  If cdsDados.IndexFieldNames <> 'PCD_CODITE;PCD_EMPDES' Then
    cdsDados.IndexFieldNames := 'PCD_CODITE;PCD_EMPDES';
  fltQtdIte := 0;
  strCodIte := '';
  pgbProgresso.Properties.Max := cdsDados.RecordCount-1;
  fltTotIteEntrada := 0;
  While not cdsDados.EoF do
  Begin
    If strCodIte <> cdsDados.FieldByName('PCD_CODITE').AsString Then
    Begin
      strCodIte := cdsDados.FieldByName('PCD_CODITE').AsString;
      fltTotIteEntrada := cdsDados.FieldByName('TOTENT').AsFloat;
      fltQtdIte := 0;
    End;

    fltQtdIte := fltQtdIte + cdsDados.FieldByName('QTDTRA').AsFloat;
    cdsDados.Next;
    pgbProgresso.POsition := cdsDados.RecNo;
    Application.ProcessMessages;
    If fFinalizouItem(cdsDados.FieldByName('PCD_CODITE').AsString, strCodIte) Then
    Begin
      If fltTotIteEntrada < fltQtdIte Then
      Begin
        pMensagemOk('Atenção, o item ' + strCodIte + ' - ' + cdsDados.FieldByName('ITE_DESITE').AsString + #13 +
                    'a qtd. total a transferir('+FormatFloat('#0.00', fltQtdIte)+') excede a qtd. total de entrada('+FormatFloat('#0.00', fltTotIteEntrada)+')');
        Result := True;
      End;
    End;
  End;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fFinalizouItem(strCodIteAtu, strCodIteAnt: String): Boolean;
begin
  Result := False;
  If cdsDados.Eof Then
    Exit(True)
  Else If strCodIteAtu <>  strCodIteAnt Then
    Exit(True)
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fConfirma: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.lblGravando.Caption := 'Validando quantidades informadas.';
    frmGravando.fExecutarAcao := fQuantidadeExcedeQuantidadeEntrada;
    frmGravando.ShowModal;

    result := Not frmGravando.blnConfirma;

  Finally
    FreeAndNil(frmGravando);
  End;

  If result Then
  begin
    result := fMensagem('', 'Serão gerados os pedidos de transferência de estoque conforme a quantidade informada nas células em amarelo. ' + #13 +
                     'Estes pedidos de transferência estarão disponíveis para faturamento, e devem ser faturados para ocorrer a baixa do estoque. ' + #13 +
                     'Enquanto não forem faturados, estarão reservando saldo de estoque das respectivas quantidades.' + #13 +
                     'Confirma a geração dos pedidos de transferência ?',
                     ['&Sim', '&Não'],
                     0,
                     False,
                     1,
                     100,
                     False,
                     0,
                     False,
                     False,
                     False,
                     180,
                     800)  = 1;
(*
                     intSomarTop: Integer=0;
                     blnObrigaEsc: Boolean = False;
                     blnOcultPainelBtn: Boolean = False;
                     blnBtnSemImg : Boolean = False;
                     intHeightOpc: Integer = 0;
                     intFormWidth: Integer = 0;
                     intQtdLinha: Integer = -1;
                     pProcedureAjuda: TProcedureAjuda = nil;
                     pUrl: TParametrosMensagem.TUrl = nil *)
    If Result Then
    Begin
      pCriarFormularios(TfrmGravando, frmGravando);
      try
        frmGravando.lblGravando.Caption := 'Gerando Transferencias.';
        frmGravando.fExecutarAcao := fGeraTranferencias;
        frmGravando.ShowModal;

        result := frmGravando.blnConfirma;

      Finally
        FreeAndNil(frmGravando);
      End;
    End;
  End;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fTemDefBai: Boolean;
begin
  qryConsulta.sql.clear;
  qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM DEFBAI');
  qryConsulta.SQL.Add(' WHERE DEF_AUTPCG IN (SELECT  AUTOINCREM FROM PCMGER');
  qryConsulta.SQL.Add('                       WHERE PCG_NUMPED = "' + FPedidoCompra.strNumped + '"');
  qryConsulta.SQL.Add('                         AND PCG_CODEMP = "' + FPedidoCompra.strCodEmp + '"');
  qryConsulta.SQL.Add('                         AND PCG_ESPDOC = "' + FPedidoCompra.strEspPed + '")');
  qryConsulta.Open;
  Result := qryConsulta.FieldByName('QTD').AsInteger > 0;


end;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaDocumentoEntrada(
  ADocumentoDeEntrada: TDocumento): Boolean;
var qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery;
  Try
     qryBusca.SQL.Add('SELECT GER_CLAFIS');
     qryBusca.SQL.Add('  FROM MOVGER');
     qryBusca.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
     qryBusca.SQL.Add('   AND GER_CODEMP = :CODEMP');
     qryBusca.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
     qryBusca.SQL.Add('   AND GER_CODFOR = :CODFOR');
     qryBusca.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');

     qryBusca.ParamByName('NUMDOC').AsString := ADocumentoDeEntrada.strNumDoc;
     qryBusca.ParamByName('CODEMP').AsString := ADocumentoDeEntrada.strCodEmp;
     qryBusca.ParamByName('ESPDOC').AsString := ADocumentoDeEntrada.strEspDoc;
     qryBusca.ParamByName('CODFOR').AsString := ADocumentoDeEntrada.strCodFor;
     qryBusca.ParamByName('SERIE_').AsString := ADocumentoDeEntrada.strSerie_;

     qryBusca.Open;

     Result := Not qryBusca.IsEmpty;
     If Result then
       result := Pos(qryBusca.FieldByName('GER_CLAFIS').AsString, VS_strClaCom) > 0;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoCompra(
  APedidoCompra: TpedidoCompra): Boolean;
var qryBusca: TUniQuery;
begin
  If APedidoCompra.strNumped = '' Then
    Exit(True);
  qryBusca := fCriaQuery;
  Try
    qryBusca.SQL.Add('SELECT COUNT(1) AS QTD FROM PCMGER');
    qryBusca.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
    qryBusca.SQL.Add('   AND PCG_CODEMP = :CODEMP');
    qryBusca.SQL.Add('   AND PCG_ESPDOC = :ESPDOC');
    qryBusca.SQL.Add('   AND PCG_NUMCTN = 0');
    qryBusca.SQL.Add('   AND IFNULL(PCG_BAIXAD, 0) = 0');
    qryBusca.ParamByName('NUMPED').AsString := APedidoCompra.strNumped;
    qryBusca.ParamByName('CODEMP').AsString := APedidoCompra.strCodEmp;
    qryBusca.ParamByName('ESPDOC').AsString := APedidoCompra.strEspPed;

    qryBusca.Open;

    Result := (qryBusca.FieldByName('QTD').AsFloat > 0);
  Finally
    FreeAndNil(qryBusca);
  End;
end;


class function TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaFornecedorDoPedidoPertenceAoGrupoDaEntrada(
  ADocumentoDeEntrada: TDocumento; APedidoCompra: TpedidoCompra): Boolean;
  var qryBusca: TUniQuery;
      strForPedido, strForNotEnt: string;
begin
  If APedidoCompra.strNumped = '' Then
    Exit(True);

  qryBusca := fCriaQuery;
  Try
    qryBusca.SQL.Add('SELECT LEFT(FOR_C_G_C_, 8) AS FOR_C_G_C_ FROM PCMGER');
    qryBusca.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR');
    qryBusca.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
    qryBusca.SQL.Add('   AND PCG_CODEMP = :CODEMP');
    qryBusca.SQL.Add('   AND PCG_ESPDOC = :ESPDOC');
    qryBusca.SQL.Add('   AND PCG_NUMCTN = 0');
    qryBusca.SQL.Add('   AND IFNULL(PCG_BAIXAD, 0) = 0');
    qryBusca.ParamByName('NUMPED').AsString := APedidoCompra.strNumped;
    qryBusca.ParamByName('CODEMP').AsString := APedidoCompra.strCodEmp;
    qryBusca.ParamByName('ESPDOC').AsString := APedidoCompra.strEspPed;

    qryBusca.Open;

    If qryBusca.IsEmpty Then
      Exit(True);

    strForPedido := qryBusca.FieldByName('FOR_C_G_C_').AsString;
    strForNotEnt := fCampotabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [ADocumentoDeEntrada.strCodFor]);

    Result := (Copy(strForNotEnt, 1, 8) =  strForPedido);
  Finally
    FreeAndNil(qryBusca);
  End;


End;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoCompraLiberado(
  APedidoCompra: TpedidoCompra): Boolean;
var qryBusca: TUniQuery;
begin
  If Not (fCfgSis('LIBPCM') = 'S') Then
    Exit(True);

  If APedidoCompra.strNumped = '' then
    Exit(True);


  qryBusca := fCriaQuery;
  Try
    qryBusca.SQL.Add('SELECT PCG_PEDLIB FROM PCMGER');
    qryBusca.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
    qryBusca.SQL.Add('   AND PCG_CODEMP = :CODEMP');
    qryBusca.SQL.Add('   AND PCG_ESPDOC = :ESPDOC');
    qryBusca.SQL.Add('   AND PCG_NUMCTN = 0');
    qryBusca.SQL.Add('   AND IFNULL(PCG_BAIXAD, 0) = 0');
    qryBusca.ParamByName('NUMPED').AsString := APedidoCompra.strNumped;
    qryBusca.ParamByName('CODEMP').AsString := APedidoCompra.strCodEmp;
    qryBusca.ParamByName('ESPDOC').AsString := APedidoCompra.strEspPed;

    qryBusca.Open;

    Result := qryBusca.FieldByName('PCG_PEDLIB').AsString <> '';
  Finally
    FreeAndNil(qryBusca);
  End;
end;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoMultiloja(
  APedidoCompra: TpedidoCompra): Boolean;
var qryBusca: TUniQuery;
begin
  If APedidoCompra.strNumped = '' then
    Exit(True);

  qryBusca := fCriaQuery;
  Try
    qryBusca.SQL.Add('SELECT COUNT(1) AS QTD FROM PCMGER');
    qryBusca.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
    qryBusca.SQL.Add('   AND PCG_CODEMP = :CODEMP');
    qryBusca.SQL.Add('   AND PCG_ESPDOC = :ESPDOC');
    qryBusca.SQL.Add('   AND PCG_NUMCTN = 0');
    qryBusca.SQL.Add('   AND IFNULL(PCG_BAIXAD, 0) = 0');
    qryBusca.SQL.Add('   AND (SELECT COUNT(1) FROM PCDDET ');
    qryBusca.SQL.Add('          WHERE PCD_NUMPED = PCG_NUMPED');
    qryBusca.SQL.Add('            AND PCD_CODEMP = PCG_CODEMP');
    qryBusca.SQL.Add('            AND PCD_ESPDOC = PCG_ESPDOC) > 0');
    qryBusca.ParamByName('NUMPED').AsString := APedidoCompra.strNumped;
    qryBusca.ParamByName('CODEMP').AsString := APedidoCompra.strCodEmp;
    qryBusca.ParamByName('ESPDOC').AsString := APedidoCompra.strEspPed;

    qryBusca.Open;

    Result := qryBusca.FieldByName('QTD').AsFloat > 0;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pPedeInformacoesFrete;
Begin
  Try
    pCriarFormularios(TfrmConfGeraOrcPed, frmConfGeraOrcPed);
    frmConfGeraOrcPed.edtCodEmpresa.Text := VS_StrCodEmp;
    frmConfGeraOrcPed.edtDesEmpresa.Text := fRetNomeEmpresa;
    frmConfGeraOrcPed.edtCodEmpresa.Enabled := False;


    frmConfGeraOrcPed.cmbTipFre.ItemIndex := frmConfGeraOrcPed.cmbTipFre.Items.IndexOf(fDescricaoFrete('1'));
    frmConfGeraOrcPed.rdgTipo.ItemIndex := 1;
    frmConfGeraOrcPed.btnConfirmaDados.Click;


    strEspDoc   := frmConfGeraOrcPed.strTipoDoc;
    strConfirma := frmConfGeraOrcPed.strConfirma;
    strMen001   := frmConfGeraOrcPed.strMen001;
    strMen002   := frmConfGeraOrcPed.strMen002;
    strCodTra   := frmConfGeraOrcPed.strCodTra;
    fltValFre   := frmConfGeraOrcPed.fltValFre;
    strTipFre   := frmConfGeraOrcPed.strTipFre;
    strTipPed   := frmConfGeraOrcPed.strTipPed;
    strEntFat   := frmConfGeraOrcPed.strEntFat;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGerenciaTransferenciaPedidoCompraMultiLoja.btnImprimirClick]');
    End;
  End;

  pFreeAndNil(frmConfGeraOrcPed);
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fRetDesIte(strDesIte, strRefIte : String) : String;
begin
  If (fCfgSis('IMPREF', varBoolean)) Then
  Begin
    If (fCfgSis('MONDES', varString) = '1') Then
      Result := strDesIte + IIF(Not fEmptyStr(strRefIte),' ' + strRefIte,'')
    Else
      Result := IIF(Not fEmptyStr(strRefIte),strRefIte + ' ','') + strDesIte;
  End
  Else
    Result :=  strDesIte;
end;


procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pCalculaTotais(intPosIni, intPosFim: integer; var fltTotGer: Double; var fltTotCus: Double; var fltTotMed: Double; var fltTotPes: Double);
var lfltQtdIte: Double;
Begin
  cdsDados.Recno := intPosIni;
  fltTotGer := 0;
  fltTotCus := 0;
  fltTotMed := 0;
  fltTotPes := 0;

  While cdsDados.Recno <= intPosFim Do
  Begin
    Application.ProcessMessages;
    lfltQtdIte := cdsDados.Fieldbyname('QTDTRA').AsFloat;
    If lfltQtdIte > 0 Then
    Begin
      fltTotGer := fltTotGer + fFormataFloat((lfltQtdIte * cdsDados.FieldByName('UNITAR').AsFloat), 2);
      fltTotCus := fltTotCus + fFormataFloat((lfltQtdIte * cdsDados.FieldByName('PRECUS').AsFloat), 2);
      fltTotMed := fltTotMed + fFormataFloat((lfltQtdIte * cdsDados.FieldByName('PREMED').AsFloat), 2);
      fltTotPes := fltTotPes + fFormataFloat((lfltQtdIte * cdsDados.FieldByName('PESOIT').AsFloat), 2);
    End;
    cdsDados.Next;
    If cdsDados.Eof Then
      intPosFim := -1;
  End;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fRetQtdItens(intPosIni, intPosFim: integer): Double;
begin
  Result := 0;
  cdsDados.Recno := intPosIni;
  While cdsDados.Recno <= intPosFim Do
  Begin
    Result := Result + cdsDados.Fieldbyname('QTDTRA').AsFloat;
    cdsDados.Next;
    If cdsDados.Eof Then
      intPosFim := -1;
  End;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fSemDados: Boolean;
begin
  result := cdsDados.IsEmpty;
end;

procedure TGerenciaTransferenciaPedidoCompraMultiLoja.pCrm;
Begin
 If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,strEspDoc,VS_strCodEmp,strCliFil,'','',strLoginUsuarioLogado, afcPedido);
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGeraFatGor(strEmpDes: String; intPosIni, intPosFim: integer; var strAutInc: String): Boolean;
Begin
  Result := False;
  strEspDoc := 'PD';
  if not fCarregarConfigParaGerarOrcamento(strConPgtMas, strCodConPgt) then
     Exit;

  SetLength(ArrRecSepara, 0);


  If Not cdsDados.IsEmpty Then
    strCliFil := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [strEmpDes]);

  strNumDoc := fRetSequencialPedido;

  fltQtdIte := 0;

  fltQtdIte := fRetQtdItens(intPosIni, intPosFim);

  cdsDados.Recno := intPosIni;

  If fltQtdIte > 0 Then
  Begin
    pCalculaTotais(intPosIni, intPosFim, fltTotGer, fltTotCus, fltTotMed, fltTotPes);
    strTabPre := TRelGeraOR.fRetTabelaPreco(strCliFil, strLoginUsuarioLogado);
    strAutInc := fstrEspaco(' ', 20);

    pCRM;

    SetLength(ArrRecSepara, Length(ArrRecSepara) + 1);
    ArrRecSepara[High(ArrRecSepara)].strNumDoc := strNumDoc;
    ArrRecSepara[High(ArrRecSepara)].strEspDoc := strEspDoc;
    ArrRecSepara[High(ArrRecSepara)].strCodCli := strCliFil;
    ArrRecSepara[High(ArrRecSepara)].strEmpDoc := VS_strCodEmp;
    ArrRecSepara[High(ArrRecSepara)].strCodVen := strLoginUsuarioLogado;


    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    {$region 'fGravaFatGor'}
    Result := fGravaFatGor(strAutInc,
                   VS_strCodEmp,
                   strNumDoc,
                   strEspDoc,
                   strCliFil,
                   strLoginUsuarioLogado,
                   strCodTra,
                   '',
                   VS_Date,
                   fTime(),
                   strConPgtMas,
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   0,
                   '',
                   '',
                   '',
                   '',
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   fltTotGer,
                   fltTotGer,
                   fltTotCus,
                   fltTotMed,
                   IIF(strEspDoc = 'OR', '1', strTipFre),
                   fltValFre,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   0.0,
                   fltTotPes,
                   fltTotPes,
                   0,
                   arrDuplic,
                   '',
                   '',
                   strMen001,
                   strMen002,
                   False,
                   '',
                   '',
                   '',
                   0,
                   '',
                   '',
                   0.0,
                   0.0,
                   strLoginUsuarioLogado,
                   strCodConPgt,
                   IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                   recServicos,
                   'N',
                   VS_Date,
                   0,
                   VS_Date,
                   '',
                   strTipPed,
                   '',
                   0,
                   strEntFat,
                   0,
                   strTabPre,
                   'N',
                   0.0,
                   '',
                   VS_StrCodEmp,  // Empresa CD
                   True  ,  // Entrega pelo CD
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   FALSE,
                   VS_Date,
                   'N',
                   'V',
                   VS_Date,
                   'P',
                   0,
                   '',
                   '',
                   '',
                   False,
                   '',
                   Nil,
                   VS_StrCodEmp,
                   VS_StrCodEmp,
                   0,
                   0,
                   0,
                   '',
                   objOcoCrm,
                   IFThen(((fCfgSis('UTIPEN', VarBoolean))
                      And (Pos(fCfgSis('TIPEXP'), '3_4_') > 0)), fCfgSis('PENTRA', varString) , ''),  // strgerpen // gera pendencia // grava sugestao,
                   0,
                   0,
                   '',
                   '',
                   0,
                   '',
                   0,
                   '',
                   '',
                   '',
                   'N',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   'S',
                   False,            // blnGravarDavPv
                   false,            // blnAlterado
                   0,                // dtaImpSep
                   0,                // horImpSep
                   '',               // strNumPedRefOR
                   '',               // strEmpPedRefOR
                   '',               // strLatitu
                   '',               // strLongit
                   '',               // strRaio__
                   nil,              // objFazenda
                   'S',              // strEnvLib
                   0,                // fltFreRat
                   '',               // strNumPedAba
                   '',               // strEspPedAba
                   '',               // strEmpPedAba
                   '',               // strObsL01
                   '',               // strObsL02
                   'N',              // strVenPre
                   'N',              // strTemBri
                   'N',              // strEdiPes
                   0,                // fltTaxEnt
                   '',               // strCodSup
                   'N',              // strOrcEsp
                   '',               // strProspe
                   '',               // strCodOco
                   False,            // blnImpSfaPag
                   '',               // strCodEmbarcacao
                   0,                // fltDesOpeGor
                   '',               // strCliCon
                   '',               // strInRqCp
                   '',               // strOriGor
                   '',               // strBarCom
                   'S',              // strPD_Exp
                   0,                // dtaValOrc
                   '',               // strCodRot
                   0,                // fltTotBri
                   0,                // fltBolAdt
                   False,            // blnBolVen
                   0,                // fltTaxJur
                   'N',              // strFatTot
                   '',               // strTraRdp
                   '',               // strCliLoj
                   '',               // strSeqDmp
                   0,                // dtaDtFiCo
                   0,                // dtaDtInCo
                   0,                // dtaDtInSe
                   0,                // dtaDtBxSe
                   0,                // hraHrFiCo
                   0,                // hraHrInCo
                   0,                // hraHrInSe
                   0,                // hraHrBxSe
                   nil,              // cdsExpRet
                   'N',              // strUsaQue
                   '',               // strDocQue
                   '',               // strCodPrj
                   '',               // strTpOper
                   '',               // strNLeads
                   '',               // strCupDes
                   'S',              // strNotPau
                   0,                // dtaDtCtVn
                   0,                // fltVlCtVn
                   '',               // strCodCat
                   '',               // strMen003
                   '',               // strMen004
                   'GERACAO TE');    // strMen005
   {$endregion}

  End;
End;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fGeraFatDor(strEmpDes: String; strIncFatGor: String): Boolean;
  var strAutIncFdo: String;
      fltTotGer: Double;
      fltTotCus: Double;
      fltTotMed: Double;
      fltTotPes: Double;
Begin
  fltQtdIte := cdsDados.Fieldbyname('QTDTRA').AsFloat;
  Result := True;
  If fltQtdIte > 0 Then
  Begin
    fltTotGer := fFormataFloat((fltQtdIte * cdsDados.FieldByName('UNITAR').AsFloat), 2);
    fltTotCus := fFormataFloat((fltQtdIte * cdsDados.FieldByName('PRECUS').AsFloat), 2);
    fltTotMed := fFormataFloat((fltQtdIte * cdsDados.FieldByName('PREMED').AsFloat), 2);
    fltTotPes := fFormataFloat((fltQtdIte * cdsDados.FieldByName('PESOIT').AsFloat), 2);

    strAutIncFdo := '';
    {$region 'fGravaFatDor'}
    Result := fGravaFatDor(strAutIncFdo,
                           strIncFatGor,
                           VS_strCodEmp,
                           strCliFil,
                           strLoginUsuarioLogado,
                           cdsDados.FieldByName('PCD_CODITE').AsString,
                           cdsDados.FieldByName('CODMAR').AsString,
                           '',
                           strNumDoc,
                           strEspDoc,
                           '',
                           VS_Date,
                           fTime(),
                           strConPgtMas,
                           '',
                           fRetDesIte(cdsDados.FieldByName('ITE_DESITE').AsString, cdsDados.FieldByName('ITE_REFERE').AsString),
                           cdsDados.FieldByName('ITE_REFERE').AsString,
                           cdsDados.FieldByName('UNI_CODUNI').AsString,
                           cdsDados.FieldByName('PCG_CODFOR').AsString,
                           fltQtdIte,
                           cdsDados.FieldByName('UNITAR').AsFloat,
                           cdsDados.FieldByName('UNITAR').AsFloat,
                           cdsDados.FieldByName('UNITAR').AsFloat,
                           fltTotGer,
                           fltTotGer,
                           fltTotCus,
                           fltTotMed,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           strLoginUsuarioLogado,
                           '',
                           0.0,
                           0.0,
                           0.0,
                           copy(VS_strClaVen,1,4),
                           '000',
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           fltTotGer,
                           0.0,
                           0.0,
                           0.0,
                           fltTotPes,
                           0.0,
                           0.0,
                           False,
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           0.0,
                           'NOR',
                           cdsDados.FieldByName('INCPIS').AsString,
                           strLoginUsuarioLogado,
                           strCodConPgt,
                           '',
                           IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0.0,
                           '',
                           '',
                           0,
                           'N',
                           '',
                           0.0,
                           0,
                           0.0,
                           cdsDados.FieldByName('UNITAR').AsFloat,
                           '',
                           0.0,
                           '',
                           '',
                           FALSE,
                           strTabPre,
                           '',
                           '',
                           '',
                           0.0,
                           '',
                           0.0,
                           IIf(fCfgSis('TPITEX') = 'T', 'E', fCfgSis('TPITEX')),
                           '',
                           'N',
                           '',
                           VS_date,
                           fltTotCus,
                           0,
                           0,
                           '',
                           cdsDados.FieldByName('NUMLOT').AsString,
                           '',
                           False,
                           IIF(blnEmpFat, VS_strCodEmp, ''),
                           '',
                           '',
                           '',
                           VS_StrCodEmp,
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           '',
                           '',
                           0,
                           0,
                           cdsDados.FieldByName('PESOIT').AsFloat);
     {$endregion}
  End;
end;

function TGerenciaTransferenciaPedidoCompraMultiLoja.fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt: string): boolean;
var
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  try
    try
      strConPgtMas := '';
      strCodConPgt := '';
      Result := TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veNaoValida, '', False);
      If not Result then
         Exit;

      If fCfgSis('USACND', varBoolean) Then
      begin
        strCodConPgt := fCfgSis('CCONPG');
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('SELECT SQL_NO_CACHE CND_CNDPAG FROM CADCND   ');
        qryGen.SQL.Add(' WHERE CND_CODIGO = "' + fCfgSis('CCONPG') + '"');
        qryGen.SQL.Add(' ORDER BY CND_CODIGO             ');
        qryGen.Open;
        strConPgtMas := qryGen.FieldByName('CND_CNDPAG').AsString;
      end
      Else
      Begin
        strCodConPgt := '';
        strConPgtMas := fCfgSis('CNDORP');
      End;
    Except
      on e: exception do
      begin
        Result := False;
        pMensagensErro(e.message, '[TGerenciaTransferenciaPedidoCompraMultiLoja.fCarregarConfigParaGerarOrcamento]');
      end;
    end;
  finally
     FreeAndNil(qryGen);
  end;
end;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fDocumentoDeEntradaJaUtilizado(Documento: TDocumento; blnFinalizacao: Boolean = False): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT  FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP ,COUNT(FATDOR.AUTOINCREM) AS QTDPRO  ');
    qryConsulta.SQL.Add('  FROM PEDTRA');
    qryConsulta.SQL.Add(' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = TRA_FATGOR ');
    qryConsulta.SQL.Add(' WHERE TRA_NUMDOC = "' + Documento.strNumDoc + '"');
    qryConsulta.SQL.Add('   AND TRA_CODFOR = "' + Documento.strCodFor + '"');
    qryConsulta.SQL.Add('   AND TRA_ESPDOC = "' + Documento.strEspDoc + '"');
    qryConsulta.SQL.Add('   AND TRA_CODEMP = "' + Documento.strCodEmp + '"');
    qryConsulta.SQL.Add('   AND IFNULL(TRA_SERIE_, "") = "' + Documento.strSerie_ + '"');
    qryConsulta.SQL.Add(' GROUP BY FDO_SEQGER');
    qryConsulta.Open;
    result := Not qryConsulta.IsEmpty;
    If Result then
    begin
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      Try
        If blnFinalizacao Then
          frmMensagemExplicativa.mmoInstru.Lines.Add('Pedidos de Transferência gerados com sucesso !')
        Else
        Begin
          frmMensagemExplicativa.mmoInstru.Lines.Add('Esta Nota Fiscal de Entrada já foi utilizada para');
          frmMensagemExplicativa.mmoInstru.Lines.Add('geração dos Pedidos de Transferência abaixo:');
        End;

        While not qryConsulta.Eof Do
        Begin
          frmMensagemExplicativa.mmoInstru.Lines.Add(qryConsulta.FieldByName('FDO_NUMDOC').AsString + '-' +
                                                     qryConsulta.FieldByName('FDO_ESPDOC').AsString + '-' +
                                                     qryConsulta.FieldByName('FDO_CODEMP').AsString + ' - Qtd. Produtos: ' +
                                                     qryConsulta.FieldByName('QTDPRO').AsString);
          qryConsulta.Next;
        End;
        frmMensagemExplicativa.Showmodal;
      Finally
        FreeAndNil(frmMensagemExplicativa);
      End
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
End;


class function TGerenciaTransferenciaPedidoCompraMultiLoja.fTemQueInformarOPedido(Documento: TDocumento): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryConsulta.SQL.Add('  FROM BAIPED');
    qryConsulta.SQL.Add(' WHERE BAI_AUTDET IN (SELECT AUTOINCREM');
    qryConsulta.SQL.Add('                        FROM MOVDET');
    qryConsulta.SQL.Add('                       WHERE DET_NUMDOC = "' + Documento.strNumDoc + '"');
    qryConsulta.SQL.Add('                         AND DET_CODFOR = "' + Documento.strCodFor + '"');
    qryConsulta.SQL.Add('                         AND DET_ESPDOC = "' + Documento.strEspDoc + '"');
    qryConsulta.SQL.Add('                         AND DET_CODEMP = "' + Documento.strCodEmp + '"');
    qryConsulta.SQL.Add('                         AND IFNULL(DET_SERIE_, "") = "' + Documento.strSerie_ + '")');
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsFloat = 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

class function TGerenciaTransferenciaPedidoCompraMultiLoja.fDocumentoExiste(Documento: TDocumento): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT AUTOINCREM');
    qryConsulta.SQL.Add('  FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE GER_NUMDOC = "' + Documento.strNumDoc + '"');
    qryConsulta.SQL.Add('   AND GER_CODFOR = "' + Documento.strCodFor + '"');
    qryConsulta.SQL.Add('   AND GER_ESPDOC = "' + Documento.strEspDoc + '"');
    qryConsulta.SQL.Add('   AND GER_CODEMP = "' + Documento.strCodEmp + '"');
    qryConsulta.SQL.Add('   AND IFNULL(GER_SERIE_, "") = "' + Documento.strSerie_ + '"');
    qryConsulta.Open;

    Result := qryConsulta.RecordCount > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;


class function TGerenciaTransferenciaPedidoCompraMultiLoja.fRetAutoIncremMovGer(Documento: TDocumento): String;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT AUTOINCREM');
    qryConsulta.SQL.Add('  FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE GER_NUMDOC = "' + Documento.strNumDoc + '"');
    qryConsulta.SQL.Add('   AND GER_CODFOR = "' + Documento.strCodFor + '"');
    qryConsulta.SQL.Add('   AND GER_ESPDOC = "' + Documento.strEspDoc + '"');
    qryConsulta.SQL.Add('   AND GER_CODEMP = "' + Documento.strCodEmp + '"');
    qryConsulta.SQL.Add('   AND IFNULL(GER_SERIE_, "") = "' + Documento.strSerie_ + '"');
    qryConsulta.Open;

    Result := qryConsulta.FieldByname('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

{ TCancelaTransferenciaPedidoCompraMultiLoja }

constructor TCancelaTransferenciaPedidoCompraMultiLoja.Create;
begin
  qryDoc := fCriaQuery;
end;

destructor TCancelaTransferenciaPedidoCompraMultiLoja.Destroy;
begin
  FreeAndNil(qryDoc)
end;

function TCancelaTransferenciaPedidoCompraMultiLoja.fTemTransferencia: Boolean;
begin
  Result := Not (qryDoc.IsEmpty);
end;

procedure TCancelaTransferenciaPedidoCompraMultiLoja.pCancelaTransferencias;
var qryComand : TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Clear;
    qryComand.SQL.Add('DELETE FROM PEDTRA WHERE AUTOINCREM = :AUTINC;');
    qryComand.SQL.Add('DELETE FROM FATGOR WHERE AUTOINCREM = :AUTGOR;');
    qryDoc.First;
    while not qryDoc.Eof Do
    Begin
      qryComand.ParamByName('AUTINC').AsString := qryDoc.FieldByName('INCTRA').AsString;
      qryComand.ParamByName('AUTGOR').AsString := qryDoc.FieldByName('FGOINC').AsString;
      qryComand.ExecSQL;
      qryDoc.Next;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
end;

function TCancelaTransferenciaPedidoCompraMultiLoja.fTemDocumentoDeTransferenciaFaturado: Boolean;
var strDocs: TArray<String>;
    intContador: integer;
    frmCancelamentoDocResumo: TfrmCancelamentoDocResumo;
begin
  Result := False;
  qryDoc.First;
  intContador := 0;
  while not qryDoc.Eof Do
  Begin
    If qryDoc.FieldByName('FGO_JAFATU').AsInteger > 0 Then
    begin
      inc(intContador);
      Result := True;
      SetLength(strDocs, intContador);
      strDocs[intContador -1] := 'Documento: ' +  qryDoc.FieldByName('FGO_NUMDOC').AsString  + ' ' +
                                 'Especie: ' +  qryDoc.FieldByName('FGO_ESPDOC').AsString  + ' ' +
                                 'Cliente: ' +  qryDoc.FieldByName('FGO_CODCLI').AsString;
    end;
    qryDoc.Next;
  End;
  If Result Then
  Begin
    pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);
    frmCancelamentoDocResumo.memResumo.Font.Name := 'Courier New';
    frmCancelamentoDocResumo.memResumo.Font.Size := 10;
    frmCancelamentoDocResumo.memResumo.Lines.Add('Este documento possui Pedidos de Transferência já faturados. Não será possível cancelar.');
    frmCancelamentoDocResumo.memResumo.Lines.Add('Documentos:');
    frmCancelamentoDocResumo.memResumo.Lines.AddStrings(strDocs);
    frmCancelamentoDocResumo.Showmodal;

    pFreeAndNil(frmCancelamentoDocResumo);
  End;
end;

class function TCancelaTransferenciaPedidoCompraMultiLoja.fCarregaDocumentoCancelamento(
    strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp: string):TCancelaTransferenciaPedidoCompraMultiLoja;
begin
  Result := TCancelaTransferenciaPedidoCompraMultiLoja.Create;



  Result.FNumDoc := strNumDoc;
  Result.FEspDoc := strEspDoc;
  Result.FCodFor := strCodFor;
  Result.FSerie  := strSerie;
  Result.FCodEmp := strCodEmp;

  Result.qryDoc.SQL.Add('SELECT FATGOR.*,FATGOR.AUTOINCREM AS  FGOINC,');
  Result.qryDoc.SQL.Add('       PEDTRA.AUTOINCREM INCTRA FROM MOVGER');
  Result.qryDoc.SQL.Add(' INNER JOIN PEDTRA ON TRA_NUMDOC = GER_NUMDOC');
  Result.qryDoc.SQL.Add('                  AND TRA_CODFOR = GER_CODFOR');
  Result.qryDoc.SQL.Add('                  AND TRA_SERIE_ = GER_SERIE_');
  Result.qryDoc.SQL.Add('                  AND GER_ESPDOC = GER_ESPDOC');
  Result.qryDoc.SQL.Add('                  AND TRA_CODEMP = GER_CODEMP');
  Result.qryDoc.SQL.Add('  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = TRA_FATGOR');
  Result.qryDoc.SQL.Add(' WHERE GER_NUMDOC = "' + strNumDoc + '"');
  Result.qryDoc.SQL.Add('   AND GER_ESPDOC = "' + strEspDoc + '"');
  Result.qryDoc.SQL.Add('   AND GER_CODFOR = "' + strCodFor + '"');
  Result.qryDoc.SQL.Add('   AND GER_SERIE_ = "' + strSerie + '"');
  Result.qryDoc.SQL.Add('   AND GER_CODEMP = "' + strCodEmp + '"');
  Result.qryDoc.Open;
end;

end.


