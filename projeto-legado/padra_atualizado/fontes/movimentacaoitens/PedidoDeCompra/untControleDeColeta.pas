unit untControleDeColeta;

interface

Uses
  Classes,
  DB,
  UniClientDataSet,
  untZClient,
  CxProgressBar,
  untTypesSistema;

Type
  TDataEntrega = (denDataEntreaVenda, denDataEntregaCompra, denDataAlteracao, denSemData);
  TStatusColeta = (stcBaixados, stcAbertos, stcTodos);

  TControleDeColeta = Class(TZClient)
  Private
    intDeqTpc: Integer;
    Procedure pAtualizaCamposBaixa(blnBaixar: Boolean;  strBaixa,
     strStatus: String);

    Procedure pSetaStatus(blnBaixar: Boolean;
         Var intRecNo: Integer;
         Var strBaixaFilter,
         strBaixa,
         strStatus,
         strMensagem,
         strAutInc: String);

    Function fSQLConsulta(strCodEmp,
                          strCodFor,
                          strLinGru,
                          strCodMar,
                          strCodCli,
                          strCodIte: String;

                          arrCodEmp,
                          arrLinGru,
                          arrCodFor,
                          arrCodMar,
                          arrCodCli,
                          arrCodIte: TConsultasArray;

                          denEntrega: TDataEntrega;
                          dtaDtaIni,
                          dtaDtaFin: TDate;
                          stcStatus: TStatusColeta): String;

     Procedure pBeforePost(dataSet: TDataSet);

  Public

    cdsBaixaColeta: TZClient;

    constructor Create(Owner: TComponent); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaDados(strCodEmp,
                           strCodFor,
                           strLinGru,
                           strCodMar,
                           strCodCli,
                           strCodIte: String;

                           arrCodEmp,
                           arrLinGru,
                           arrCodFor,
                           arrCodMar,
                           arrCodCli,
                           arrCodIte: TConsultasArray;

                           denEntrega: TDataEntrega;
                           dtaDtaIni,
                           dtaDtaFin: TDate;
                           stcStatus: TStatusColeta): Boolean;

    procedure pMarcaDesmarcaRegistro;
    procedure pMarcaTodos(blnMarcar: Boolean);

    Function fSalvaDataEntregaPedidoVenda: Boolean;

    Function fBaixaColeta(blnBaixar: Boolean): Boolean;

    Procedure pPosicionaPrimeiroMarcado;

    Function fCopiaMarcados: Boolean;

    Function fCarregaBaixa(strAutInc: String): Boolean;

    Function fExcluiBaixa: Boolean;

    Function fIncluiColeta(dtaDtaCol: TDateTime; fltQtdBai: Double): Boolean;

    Function fGetUltimaQuantidadeColetada: Double;
  End;

implementation

Uses
  Uni,
  SysUtils,
  untGravando,
  untFuncoesConsulta,
  untFuncoesSimples;

constructor TControleDeColeta.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
  Self.pCriaSoma('TOTBRU', 'SUM_TOTBRU');
  Self.pCriaSoma('TOTLIQ', 'SUM_TOTLIQ');
  Self.pCriaSoma('TOTMET', 'SUM_TOTMET');
  Self.pCriaSoma('INTMAR', 'SUM_QTDMAR');

  cdsBaixaColeta := TZClient.Create(Owner, 'SELECT * FROM CONBAI WHERE CON_SEQGER = :SEQGER');
  cdsBaixaColeta.pCriaSoma('CON_QTDBAI', 'TOTCOL');
  cdsBaixaColeta.IndexFieldNames := 'CON_DTACOL;AUTOINCREM';
End;

Destructor TControleDeColeta.Destroy;
Begin

  Inherited;
End;

Function TControleDeColeta.fSQLConsulta(strCodEmp,
                                        strCodFor,
                                        strLinGru,
                                        strCodMar,
                                        strCodCli,
                                        strCodIte: String;

                                        arrCodEmp,
                                        arrLinGru,
                                        arrCodFor,
                                        arrCodMar,
                                        arrCodCli,
                                        arrCodIte: TConsultasArray;

                                        denEntrega: TDataEntrega;
                                        dtaDtaIni,
                                        dtaDtaFin: TDate;
                                        stcStatus: TStatusColeta): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SET @QTDITE_CALC := 0.0000; ';
  strSQL := strSQL + ' SET @QTDITE := 0.0000; ';
  strSQL := strSQL + ' SELECT           ';
  strSQL := strSQL + '  @NUMFAT := FGO_NUMFAT AS NUMFAT,';
  strSQL := strSQL + '  @SERFAT := FGO_TIPFAT AS SERFAT,';
  strSQL := strSQL + '  @EMPFAT := FGO_EMPFAT AS EMPFAT,';
  strSQL := strSQL + '  @CODITE := FDO_CODITE AS CODITE,';
  strSQL := strSQL + '  @UNITAR := FDO_UNITAR AS UNITAR,';
  strSQL := strSQL + '   CC.*,          ';

  strSQL := strSQL + '   PCG_ORDCON AS ORDCON, ';

  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';

  strSQL := strSQL + '   "N" AS MARCAD, ';

  strSQL := strSQL + '   @QTDCOL:=(SELECT SUM(B.CON_QTDBAI) FROM CONBAI B WHERE B.CON_SEQGER = CC.AUTOINCREM) AS QTDCOL, ';

  strSQL := strSQL + '   (SELECT B.CON_QTDBAI FROM CONBAI B WHERE B.CON_SEQGER = CC.AUTOINCREM ORDER BY B.CON_DTACOL DESC, B.AUTOINCREM DESC LIMIT 1) AS ULTQTDCOL, ';

  strSQL := strSQL + '   IF(CC.CON_BAIXAD = "S", "Baixada", IF(IFNULL(@QTDCOL, 0) > 0, "Baixa Parcial", "Aberta")) AS STATUS, ';

  strSQL := strSQL + '   PCD_DTAENT AS ENTCOM, ';

  strSQL := strSQL + '   @NOTAS:=CAST(IFNULL((SELECT GROUP_CONCAT(CONCAT(M.DET_ESPDOC, "-", M.DET_NUMDOC, "-", M.DET_CODEMP)) ';
  strSQL := strSQL + '                   FROM BAIPED ';
  strSQL := strSQL + '                   INNER JOIN MOVDET M ON M.AUTOINCREM = BAI_AUTDET                              ';
  strSQL := strSQL + '                   WHERE BAI_AUTPED = PD.AUTOINCREM), ';

  strSQL := strSQL + '   (SELECT GROUP_CONCAT(CONCAT("NF-", B08_NNF, "-", GER_CODEMP)) FROM DEFBAI ';
  strSQL := strSQL + '    INNER JOIN GERELE ON GERELE.AUTOINCREM = DEF_GERELE ';
  strSQL := strSQL + '    WHERE DEF_AUTPCD = PD.AUTOINCREM)) AS CHAR(255))AS NOTENT, ';

  strSQL := strSQL + '   IF(@NOTAS IS NULL, "Não", "Sim") AS FATFOR, ';

  strSQL := strSQL + '   @DTAEMI := CAST(IFNULL((SELECT GROUP_CONCAT(DATE_FORMAT(DET_DTADOC,"%d/%m/%y")) ';
  strSQL := strSQL + '                   FROM BAIPED ';
  strSQL := strSQL + '                   INNER JOIN MOVDET M ON M.AUTOINCREM = BAI_AUTDET                              ';
  strSQL := strSQL + '                   WHERE BAI_AUTPED = PD.AUTOINCREM), ';

  strSQL := strSQL + '   (SELECT GROUP_CONCAT(DATE_FORMAT(B09_DEMI,"%d/%m/%y")) FROM DEFBAI ';
  strSQL := strSQL + '    INNER JOIN GERELE ON GERELE.AUTOINCREM = DEF_GERELE ';
  strSQL := strSQL + '    WHERE DEF_AUTPCD = PD.AUTOINCREM)) AS CHAR(255)) AS DTAEMI1, ';
  strSQL := strSQL + '    CAST(REPLACE(@DTAEMI,",","-") AS CHAR(255))  AS DTAEMI, ';

  strSQL := strSQL + '   REPLACE(CAST((SELECT GROUP_CONCAT(M.DET_NUMDOC) FROM BAIPED     ';
  strSQL := strSQL + '     INNER JOIN MOVDET M ON M.AUTOINCREM = BAI_AUTDET  ';
  strSQL := strSQL + '     WHERE BAI_AUTPED = PD.AUTOINCREM) AS CHAR(255)),",","-") AS ENTREA, ';

  strSQL := strSQL + '   LOC_DESCRI AS DESLOC, ';

  strSQL := strSQL + '   CAST(CONCAT(RCD_DOCPDV, "-", RCD_ESPPDV, "-", RCD_EMPPDV) AS CHAR(255))AS PEDVEN, ';
  strSQL := strSQL + '   E.FDO_DTENTR  AS ENTVEN, ';
  strSQL := strSQL + '   E.FDO_SEQFDO  AS EXTAUT, ';

  strSQL := strSQL + '   CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '   @NMECLI := IF(CLI_CODCLI IS NULL, "ESTOQUE", CLI_NOMCLI) AS NOMCLI, ';

  strSQL := strSQL + '   ITE_MLTVEN AS MLTVEN, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '   IF(PCD_BAIXAD, "SIM", "NÃO") AS BAIXAD, ';

  strSQL := strSQL + '   MAR_DESMAR AS MARCA, ';

  strSQL := strSQL + '   (PCD_QTDITE * PCD_EMBALA) AS QTDPED, '; // QUANTIDADE TOTAL
  strSQL := strSQL + '   (PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA AS QTDPEN, '; // QUANTIDADE EM ABERTO

  strSQL := strSQL + '  (SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = CC.CON_AUTREQ) AS QTDRBA, '; // QUANTIDADE BAIXADA REQUISIÇÃO

  strSQL := strSQL + '  (PCD_QTDITE * PCD_EMBALA) - IFNULL((SELECT SUM(RCD_QTDITE) FROM MOVRCD MX ';
  strSQL := strSQL + '                WHERE                                              ';
  strSQL := strSQL + '                  MX.RCD_SEQPCD = CC.CON_AUTDET), 0) AS QTDDIS, '; // QUANTIDADE DIPONÍVEL
  //SE A COLETA NÃO TEM REQUISÇÃO ENTAO
  // QUANTIDADE  = PCD_QTDITE - AS OUTRAS REQUISIÇÕES QUEO PEDIDO PODE TER
  //SENÃO
  // QUANTIDADE DA REQUISICAO DA COLETA
  strSQL := strSQL + '   @QTDITE:=IF(CON_AUTREQ IS NULL, ';
  strSQL := strSQL + '               (PCD_QTDITE * PCD_EMBALA) - IFNULL((SELECT SUM(ROUND(RCD_QTDITE,fCfgSis("CFG_DEQTPC",CON_CODEMP))) FROM MOVRCD MX ';
  strSQL := strSQL + '                WHERE                                              ';
  strSQL := strSQL + '                  MX.RCD_SEQPCD = CC.CON_AUTDET), 0),              ';  // QUANTIDADE ESTOQUE
  strSQL := strSQL + '               RCD_QTDITE) AS QTDITE1, '; // QUANTIDADE DA REQUISIÇÃO

  strSQL := strSQL + '  @QTDDEV := ';
  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '   SUM(DV2.DET_QTDITE) ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' PCMDET PD2 ';
  strSQL := strSQL + ' INNER JOIN CONCOL CC2 ON CC2.CON_AUTDET  = PD2.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN MOVRCD M2 ON M2.AUTOINCREM = CC2.CON_AUTREQ ';
  strSQL := strSQL + ' INNER JOIN MOVRCG MG2 ON MG2.RCG_CODIGO = M2.RCD_CODIGO AND MG2.RCG_CODEMP = M2.RCD_CODEMP ';
  strSQL := strSQL + ' INNER JOIN FATGOR FG2 ON FG2.FGO_NUMDOC = M2.RCD_DOCPDV AND FG2.FGO_ESPDOC = M2.RCD_ESPPDV AND FG2.FGO_CODEMP = M2.RCD_EMPPDV ';
  strSQL := strSQL + ' INNER JOIN MOVDET D2 ON  D2.DET_DOCFUT = FG2.FGO_NUMFAT ';
  strSQL := strSQL + '                      AND D2.DET_ESPFUT = FG2.FGO_TIPFAT ';
  strSQL := strSQL + '                      AND D2.DET_EMPFUT = FG2.FGO_EMPFAT ';
  strSQL := strSQL + '                      AND D2.DET_CODITE =  M2.RCD_CODITE ';
  strSQL := strSQL + '                      AND RIGHT(D2.DET_CLAFIS, 3) <> "999" ';
  strSQL := strSQL + ' INNER JOIN MOVDET DV2  ON DV2.DET_DOCDEV = D2.DET_NUMDOC ';
  strSQL := strSQL + '                       AND DV2.DET_ESPDEV = D2.DET_ESPDOC ';
  strSQL := strSQL + '                       AND DV2.DET_EMPDEV = D2.DET_CODEMP ';
  strSQL := strSQL + '                       AND DV2.DET_CODITE = D2.DET_CODITE ';
  strSQL := strSQL + '                       AND DV2.DET_UNITAR = D2.DET_UNITAR ';
  strSQL := strSQL + ' WHERE PD2.AUTOINCREM = PD.AUTOINCREM ';
  strSQL := strSQL + '   AND FG2.AUTOINCREM = FG.AUTOINCREM ';
  strSQL := strSQL + ')  AS QTDDEV, ';
  strSQL := strSQL + ' @QTDFUT := ';
  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '   SUM(DET_QTDITE) AS DESUNI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' PCMDET PD2 ';
  strSQL := strSQL + ' INNER JOIN CONCOL CC2 ON CC2.CON_AUTDET  = PD2.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN MOVRCD M2 ON M2.AUTOINCREM = CC2.CON_AUTREQ ';
  strSQL := strSQL + ' INNER JOIN MOVRCG MG2 ON MG2.RCG_CODIGO = M2.RCD_CODIGO AND MG2.RCG_CODEMP = M2.RCD_CODEMP ';
  strSQL := strSQL + ' INNER JOIN FATGOR FG2 ON FG2.FGO_NUMDOC = M2.RCD_DOCPDV AND FG2.FGO_ESPDOC = M2.RCD_ESPPDV AND FG2.FGO_CODEMP = M2.RCD_EMPPDV ';
  strSQL := strSQL + ' INNER JOIN MOVDET D2 ON  D2.DET_DOCFUT = FG2.FGO_NUMFAT ';
  strSQL := strSQL + ' AND D2.DET_ESPFUT = FG2.FGO_TIPFAT ';
  strSQL := strSQL + '   AND D2.DET_EMPFUT = FG2.FGO_EMPFAT ';
  strSQL := strSQL + '   AND D2.DET_CODITE = PD2.PCD_CODITE ';
  strSQL := strSQL + '   AND RIGHT(D2.DET_CLAFIS, 3) <> "999" ';
  strSQL := strSQL + ' WHERE PD2.AUTOINCREM = PD.AUTOINCREM ';
  strSQL := strSQL + '   AND FG2.AUTOINCREM = FG.AUTOINCREM ';
  strSQL := strSQL + '   ) AS QTDFUT, ';

  strSQL := strSQL + ' @QTDITE_CALC := IFNULL(@QTDITE, 0) + IF(@NMECLI = "ESTOQUE", 1, - 1) * (IFNULL(@QTDFUT, 0) /*+ IFNULL(@QTDDEV, 0)*/) AS QTDITE_CALC,  ';
  strSQL := strSQL + ' @QTDITE := IF(@QTDITE_CALC < 0, 0, @QTDITE_CALC ) AS QTDITE,  ';

  strSQL := strSQL + '   GREATEST(@QTDITE - IFNULL(@QTDCOL, 0), 0) AS QTDPENCOL, ';

  strSQL := strSQL + '   @QTDITE / ITE_MLTVEN AS QTDCAI, ';

  strSQL := strSQL + '   @QTDITE * ITE_PESOIT AS PESBRU, ';
  strSQL := strSQL + '   @QTDITE * ITE_PESLIQ AS PESLIQ, ';

  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12,3)) AS TOTBRU, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12,3)) AS TOTLIQ, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12,3)) AS TOTMET, ';

  strSQL := strSQL + '   0 AS INTMAR, ';

  strSQL := strSQL + '   IFNULL(EC.ETC_ENDENT, IF(CLI_CIDENT IS NULL, CLI_ENDERE, CLI_ENDENT)) AS ENDENT, ';
  strSQL := strSQL + '   IFNULL(EC.ETC_BAIENT, IF(CLI_CIDENT IS NULL, CLI_BAIRRO, CLI_BAIENT)) AS BAIENT, ';
  strSQL := strSQL + '   IFNULL(EC.ETC_CEPENT, IF(CLI_CIDENT IS NULL, CLI_C_E_P_, CLI_CEPENT)) AS CEPENT, ';

  strSQL := strSQL + '   IFNULL(CCD.CID_NOMCID,CADCID.CID_NOMCID)                                               AS CIDENT, ';
  strSQL := strSQL + '   IFNULL(CCD.CID_ESTADO,CADCID.CID_ESTADO)                                               AS ESTENT, ';

  strSQL := strSQL + '   OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '   CONCAT(IFNULL(FG.FGO_MENEXP,""),IFNULL(FG.FGO_MENEX2,""), IFNULL(FG.FGO_MENEX3,""), IFNULL(FG.FGO_MENEX4,"")) AS OBSVEN ';
  strSQL := strSQL + ' FROM CONCOL CC   ';

  strSQL := strSQL + '   INNER JOIN PCMDET PD ON PD.AUTOINCREM = CC.CON_AUTDET ';

  strSQL := strSQL + '   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED ';
  strSQL := strSQL + '                    AND PCG_CODEMP = PCD_CODEMP ';
  strSQL := strSQL + '                    AND PCG_ESPDOC = PCD_ESPDOC ';

  strSQL := strSQL + '   INNER JOIN CADFOR F ON FOR_CODFOR = PCG_CODFOR ';

  strSQL := strSQL + '   LEFT JOIN MOVRCD M ON M.AUTOINCREM = CC.CON_AUTREQ ';

  strSQL := strSQL + '   LEFT JOIN MOVRCG ON RCG_CODIGO = RCD_CODIGO AND RCG_CODEMP = RCD_CODEMP ';

  strSQL := strSQL + '   INNER JOIN CADITE C ON C.ITE_CODITE = PD.PCD_CODITE  ';

  strSQL := strSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR  ';

  strSQL := strSQL + '   LEFT JOIN CADOPE ON OPE_CODOPE = CON_CODOPE  ';

  strSQL := strSQL + '  LEFT JOIN FATGOR FG ON FGO_NUMDOC = RCD_DOCPDV ';
  strSQL := strSQL + '                     AND FGO_ESPDOC = RCD_ESPPDV ';
  strSQL := strSQL + '                     AND FGO_CODEMP = RCD_EMPPDV ';

  strSQL := strSQL + '  LEFT JOIN FATDOR FD ON FD.FDO_SEQGER = FG.AUTOINCREM AND FDO_CODITE = RCD_CODITE ';

  strSQL := strSQL + '  LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN AUXGOR AX  ON AX.AUX_SEQGER = FG.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = IFNULL(CLI_CIDENT, CLI_CODCID) ';

  strSQL := strSQL + '  LEFT JOIN LOCMER L ON L.LOC_CODLOC = CC.CON_CODLOC  ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI EC ON EC.AUTOINCREM = AX.AUX_ENTGER ';
  strSQL := strSQL + '  LEFT JOIN CADCID CCD ON CCD.CID_CODCID = EC.ETC_CIDENT';
  strSQL := strSQL + ' WHERE  ';

  strSQL := strSQL + '   TRUE ';

  strSQL := strSQL + fStrLocate( strCodCli, arrCodCli, 'RCG_CODCLI', 'CODCLI' );
  strSQL := strSQL + fStrLocate( strCodFor, arrCodFor, 'PCG_CODFOR', 'CODFOR' );
  strSQL := strSQL + fStrLocate( strCodMar, arrCodMar, 'ITE_CODMAR', 'CODMAR' );
  strSQL := strSQL + fStrLocateLinGru(arrLinGru, 'ITE_CODGRU');
  strSQL := strSQL + fStrLocate( strCodIte, arrCodIte, 'CON_CODITE', 'CODITE' );
  strSQL := strSQL + fStrLocate( strCodEmp, arrCodEmp, 'CON_EMPDES', 'CODEMP' );

  If (dtaDtaFin > 0) Then
  If (denEntrega <> denSemData) Then
  Begin

     Case denEntrega Of
       denDataEntreaVenda  : strSQL := strSQL + '  AND FDO_DTENTR ';
       denDataEntregaCompra: strSQL := strSQL + '  AND PCD_DTAENT ';
       denDataAlteracao    : strSQL := strSQL + '  AND CON_ULTALT ';
     End;

     If dtaDtaIni > 0 Then
       strSQL := strSQL + ' BETWEEN :DTAINI AND :DTAFIN '
     Else
       strSQL := strSQL + ' <= :DTAFIN ';

  End;

  Case stcStatus Of
    stcBaixados: strSQL := strSQL + ' AND CC.CON_BAIXAD = "S" ';
    stcAbertos:  strSQL := strSQL + ' AND CC.CON_BAIXAD = "N" ';
  End;

  strSQL := strSQL + ' GROUP BY CC.AUTOINCREM, PD.AUTOINCREM  ';
  strSQL := strSQL + ' HAVING QTDITE1 > 0 ';

  Result := strSQL;
End;

Function TControleDeColeta.fCarregaDados(strCodEmp,
                                         strCodFor,
                                         strLinGru,
                                         strCodMar,
                                         strCodCli,
                                         strCodIte: String;

                                         arrCodEmp,
                                         arrLinGru,
                                         arrCodFor,
                                         arrCodMar,
                                         arrCodCli,
                                         arrCodIte: TConsultasArray;

                                         denEntrega: TDataEntrega;
                                         dtaDtaIni,
                                         dtaDtaFin: TDate;
                                         stcStatus: TStatusColeta): Boolean;
Begin
  qryQuery.SQL.Text := fSQLConsulta(strCodEmp,
                                    strCodFor,
                                    strLinGru,
                                    strCodMar,
                                    strCodCli,
                                    strCodIte,

                                    arrCodEmp,
                                    arrLinGru,
                                    arrCodFor,
                                    arrCodMar,
                                    arrCodCli,
                                    arrCodIte,

                                    denEntrega,
                                    dtaDtaIni,
                                    dtaDtaFin,
                                    stcStatus);

  pSetaParam(strCodEmp, arrCodEmp, strCodEmp, 'CODEMP', qryQuery);
  pSetaParam(strLinGru, arrLinGru, strLinGru, 'CODGRU', qryQuery);
  pSetaParam(strCodFor, arrCodFor, strCodFor, 'CODFOR', qryQuery);
  pSetaParam(strCodMar, arrCodMar, strCodMar, 'CODMAR', qryQuery);
  pSetaParam(strCodCli, arrCodCli, strCodCli, 'CODCLI', qryQuery);
  pSetaParam(strCodIte, arrCodIte, strCodIte, 'CODITE', qryQuery);

  If Assigned(qryQuery.FindParam('DTAINI')) Then
    qryQuery.ParamByName('DTAINI').AsDate := dtaDtaIni;

  If Assigned(qryQuery.FindParam('DTAFIN')) Then
    qryQuery.ParamByName('DTAFIN').AsDate := dtaDtaFin;

  Result := fLeDados('TControleDeColeta.fCarregaDados', True, 'Carregando consulta, aguarde...');

  If Result Then
  Begin
    Self.BeforePost := pBeforePost;


    TFloatField(FieldByName('QTDPED')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('QTDPEN')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('ULTQTDCOL')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('QTDDIS')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('QTDCOL')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    TFloatField(FieldByName('QTDPENCOL')).DisplayFormat := fMskDigitos(intDeqTpc, true);

    pAlinhaCampoCentro('CON_NUMPED');
    pAlinhaCampoCentro('FATFOR');
    pAlinhaCampoCentro('ENTCOM');
    pAlinhaCampoCentro('NOTENT');
    pAlinhaCampoCentro('DTAEMI');
    pAlinhaCampoCentro('ENTREA');
    pAlinhaCampoCentro('PEDVEN');
    pAlinhaCampoCentro('CON_CODITE');
    pAlinhaCampoCentro('ESTENT');
    pAlinhaCampoCentro('CON_ULTALT');
    pAlinhaCampoCentro('STATUS');
  End;
End;

Procedure TControleDeColeta.pBeforePost(dataSet: TDataSet);
Begin
  If dataSet.FieldByName('MARCAD').AsString = 'S' Then
  Begin
    dataSet.FieldByName('TOTBRU').AsFloat := dataSet.FieldByName('PESBRU').AsFloat;
    dataSet.FieldByName('TOTLIQ').AsFloat := dataSet.FieldByName('PESLIQ').AsFloat;
    dataSet.FieldByName('TOTMET').AsFloat := dataSet.FieldByName('QTDITE').AsFloat;
  End Else
  Begin
    dataSet.FieldByName('TOTBRU').AsFloat := 0;
    dataSet.FieldByName('TOTLIQ').AsFloat := 0;
    dataSet.FieldByName('TOTMET').AsFloat := 0;
  End;

  dataSet.FieldByName('QTDPENCOL').AsFloat := dataSet.FieldByName('QTDITE').AsFloat - dataSet.FieldByName('QTDCOL').AsFloat;

  If dataSet.FieldByName('QTDPENCOL').AsFloat < 0 Then
    dataSet.FieldByName('QTDPENCOL').AsFloat := 0;

End;

procedure TControleDeColeta.pMarcaDesmarcaRegistro;
Begin
  If Self.IsEmpty Then
    Exit;

  Self.Edit;

  If Self.FieldByName('MARCAD').AsString = 'S' Then
    Self.FieldByName('MARCAD').AsString := 'N'
  Else
    Self.FieldByName('MARCAD').AsString := 'S';
  Self.FieldByName('INTMAR').AsInteger := IIf(Self.FieldByName('MARCAD').AsString = 'S', 1, 0);
  Self.Post;
End;

procedure TControleDeColeta.pMarcaTodos(blnMarcar: Boolean);
Begin
  Self.DisableControls;

  Self.First;

  While Not Self.Eof Do
  Begin
    Self.Edit;

    If blnMarcar Then
      Self.FieldByName('MARCAD').AsString := 'S'
    Else
      Self.FieldByName('MARCAD').AsString := 'N';
    Self.FieldByName('INTMAR').AsInteger := IIf(Self.FieldByName('MARCAD').AsString = 'S', 1, 0);
    Self.Post;

    Self.Next;
  End;

  Self.EnableControls;
End;

Function TControleDeColeta.fSalvaDataEntregaPedidoVenda: Boolean;
  Var
    qryFatDor: TUniQuery;
Begin
  Try
    qryFatDor := fCriaQuery;

    qryFatDor.SQL.Text := 'UPDATE EXTDOR SET FDO_DTENTR = :ENTVEN WHERE FDO_SEQFDO = :AUTINC';
    qryFatDor.ParamByName('ENTVEN').Value    := Self.FieldByName('ENTVEN').Value;
    qryFatDor.ParamByName('AUTINC').AsString := Self.FieldByName('EXTAUT').AsString;
    qryFatDor.Execute;

    FreeAndNil(qryFatDor);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmConsultaControleDeColeta.fSalvaDataEntregaPedidoVenda');
    End;
  End;
End;

Procedure TControleDeColeta.pSetaStatus(blnBaixar: Boolean;
    Var intRecNo: Integer;
    Var strBaixaFilter,
     strBaixa,
     strStatus,
     strMensagem,
     strAutInc: String);
Begin
      If blnBaixar Then
      Begin
        strBaixa       := 'S';
        strBaixaFilter := 'N';
        strMensagem    := 'em aberto';
        strStatus      := 'Baixada';
      End Else
      Begin
        strBaixa       := 'N';
        strBaixaFilter := 'S';
        strMensagem    := 'baixado';
        strStatus      := 'Aberta';
      End;
End;

Procedure TControleDeColeta.pAtualizaCamposBaixa(blnBaixar: Boolean;  strBaixa,
     strStatus: String);
Begin
  Self.Edit;

  If blnBaixar Then
  Begin

    If (Self.FieldByName('QTDPENCOL').AsCurrency = 0) Then
    Begin
      Self.FieldByName('CON_BAIXAD').AsString := strBaixa;
      Self.FieldByName('STATUS').AsString := strStatus;
    End;

  End Else
  Begin
    Self.FieldByName('CON_BAIXAD').AsString := 'N';

    If (Self.FieldByName('QTDPENCOL').AsCurrency = 0) Then
      Self.FieldByName('STATUS').AsString := 'Baixa Parcial'
    Else
      Self.FieldByName('STATUS').AsString := strStatus;
  End;

  Self.FieldByName('CON_ULTALT').AsDateTime := VS_Date;
  Self.FieldByName('CON_HORALT').AsDateTime := fTime();
  Self.Post;
End;

Function TControleDeColeta.fBaixaColeta(blnBaixar: Boolean): Boolean;
  Var
     intRecNo: Integer;
     strBaixaFilter,
     strBaixa,
     strStatus,
     strMensagem,
     strAutInc: String;
Begin
  Result := False;

  If Self.IsEmpty Then
    Exit;

  intRecNo := Self.RecNo;

  Try
    Try
      pSetaStatus(blnBaixar,
                  intRecNo,
                  strBaixaFilter,
                  strBaixa,
                  strStatus,
                  strMensagem,
                  strAutInc);

      Self.DisableControls;

      Self.Filter := Concat('MARCAD = ', QuotedStr('S'), ' AND CON_BAIXAD = ', QuotedStr(strBaixaFilter));
      Self.Filtered := True;

      If Self.RecordCount = 0 Then
      Begin
        pMensagemOk(Concat('Nenhum registro ', strMensagem, ' foi marcado para a operação!'));
        Exit;
      End;

      Self.First;

      While Not Self.Eof Do
      Begin
        strAutInc := Self.FieldByName('AUTOINCREM').AsString;

        pAtualizaCamposBaixa(blnBaixar, strBaixa, strStatus);

        If strAutInc = Self.FieldByName('AUTOINCREM').AsString Then
          Self.Next;
      End;

      Self.Filtered := False;

      Result := Self.fSalva;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmConsultaControleDeColeta.fBaixaColeta');
      End;
    End;

  Finally
    Self.Filtered := False;
    Self.RecNo := intRecNo;
    Self.EnableControls;
  End;
End;

Procedure TControleDeColeta.pPosicionaPrimeiroMarcado;
  Var
    intRecNo: Integer;
Begin
  If Self.IsEmpty Then
    Exit;

  intRecNo := Self.RecNo;

  If Self.FieldByName('MARCAD').AsString <> 'S' Then
  Begin
    If Not Self.Locate('MARCAD', 'S', []) Then
      Self.RecNo := intRecNo;
  End;
End;

Function TControleDeColeta.fCopiaMarcados: Boolean;
  Var
    strCodLoc,
    strDesLoc,
    strObserv: String;
    dtaPreFat: TDate;
Begin
  Result := True;

  Try
    Try
      Self.DisableControls;

      strCodLoc := Self.FieldByName('CON_CODLOC').AsString;
      strDesLoc := Self.FieldByName('DESLOC').AsString;
      strObserv := Self.FieldByName('CON_OBSERV').AsString;
      dtaPreFat := Self.FieldByName('CON_PREFAT').AsDateTime;

      Self.Filter := Concat('MARCAD = ', QuotedStr('S'));
      Self.Filtered := True;

      Self.First;

      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('DESLOC').AsString     := strDesLoc;

        If dtaPreFat = 0 Then
          Self.FieldByName('CON_PREFAT').Clear
        Else
          Self.FieldByName('CON_PREFAT').AsDateTime := dtaPreFat;

        If strCodLoc.IsEmpty Then
          Self.FieldByName('CON_CODLOC').Clear
        Else
          Self.FieldByName('CON_CODLOC').AsString   := strCodLoc;

        Self.FieldByName('CON_OBSERV').AsString   := strObserv;
        Self.FieldByName('CON_ULTALT').AsDateTime := VS_Date;
        Self.FieldByName('CON_HORALT').AsDateTime := fTime();
        Self.Post;

        Self.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmConsultaControleDeColeta.fBaixaColeta');
      End;
    End;

  Finally
    Self.Filtered := False;
    Self.EnableControls;
  End;

End;

Function TControleDeColeta.fCarregaBaixa(strAutInc: String): Boolean;
Begin
  cdsBaixaColeta.qryQuery.ParamByName('SEQGER').AsString := strAutInc;
  Result := cdsBaixaColeta.fLeDados('TControleDeColeta.fCarregaBaixa');
End;

Function TControleDeColeta.fExcluiBaixa: Boolean;
Begin
  Result := False;

  If cdsBaixaColeta.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão da coleta da data ' + cdsBaixaColeta.FieldByName('CON_DTABAI').AsString + '?') Then
  Begin
    cdsBaixaColeta.Delete;
    Result := True;
  End;
End;

Function TControleDeColeta.fIncluiColeta(dtaDtaCol: TDateTime; fltQtdBai: Double): Boolean;
Begin
  cdsBaixaColeta.Append;
  cdsBaixaColeta.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CONBAI', VS_strCodEmp);
  cdsBaixaColeta.FieldByName('CON_SEQGER').AsString   := Self.FieldByName('AUTOINCREM').AsString;

  cdsBaixaColeta.FieldByName('CON_DTACOL').AsDateTime := dtaDtaCol;
  cdsBaixaColeta.FieldByName('CON_QTDBAI').AsFloat    := fltQtdBai;

  cdsBaixaColeta.FieldByName('CON_OPEBAI').AsString   := strLoginUsuarioLogado;
  cdsBaixaColeta.FieldByName('CON_DTABAI').AsDateTime := VS_Date;
  cdsBaixaColeta.FieldByName('CON_HORBAI').AsDateTime := fTime();

  cdsBaixaColeta.Post;

  Result := True;
End;

Function TControleDeColeta.fGetUltimaQuantidadeColetada: Double;
Begin
  If cdsBaixaColeta.IsEmpty Then
  Begin
    Result := 0;
  End Else
  Begin
    cdsBaixaColeta.Last;
    Result := cdsBaixaColeta.FieldByName('CON_QTDBAI').AsFloat;
  End;
End;

end.


