unit untEntFreConLista;

interface

Uses

  Controls,
  Classes,
  Contnrs,
  SysUtils,
  cxProgressBar,
  Uni,
  Math,
  untEntFreCon,
  untEntIcmsAntecipado,
  untZClient,
  untGravando,
  untParCalculaPrecoCusto,
  untTypesSistema,
  untPreAlt_Trigger;


Type
   TFreConLista = Class(TZClient)
    Private
      FEspNot: String;

      FFreIpi: Boolean;

      FDecUni,
      FPerFre: Integer;

      strMedEmp,
      strEmpMeds: String;

      FMaxIVA,
      FVlrCon,
      FTotLiq,
      FTotIte: Double;
      FIndexFrete: Integer;

      strForFil,
      FCodOpe: String;
      FCodPor: String;

      FVarNot,
      FEntMer: Boolean;

      blnPerRep,
      blnAtuMed,
      blnAtuUlt,
      blnAtpRen,
      blnLotSim: Boolean;

      arrFreCon: TObjectList;

      cdsNotEnt,
      cdsTotNot: TZClient;

      objIteAnt: TIcmsAntecipado;
      qryCTEMOV: TUniQuery;

      cpcParams: TParCalculaPrecoCusto;

      blnATPVMB: array[1..7] of Boolean;
      FRPAFre: Double;
      FtipRatFreteRPA: TTipoRateioFrete;
      Function getAntIcT: Double;
      Function getBasAnT: Double;
      Function getValCon: Double;
      Function getValFre: Double;
      Function getValIcm: Double;
      procedure pGravaValorMovDetReferenteFreteEntrada(strSeqCadFis: String; ArrCteMov: TArrCteMov);


      Function fSQLFreConRel(strEspDoc: String): String;
      Function fSQLFreCon(strChaveCTE: string = ''): String;
      function fSqlNotas: String;
      Function fRetTotItensAntFrete: Double;
      function fIncluiConFre(strSeqGer, strSeqFis: String; arrSeqPag: TArrAutInc): Boolean;
      Function fIncsNotasEntrada: String;

      Function fSQLMovTri(strChaves: string = ''): String;

      Function fSQLFromNotas(strChaves: string = ''): String;
      Function fRetFreteRateio(var fltAlqIcmFrete: Double): Double;

      Function fAtualizaFreteIteger(strCodIte: String; fltFreEnt, fltValFre: Double; blnPermiteReducaoPreco: Boolean): Boolean;
      Function fAtualizaPrecomIteger(strCodIte: String; fltPreCom: Double; blnPermiteReducaoPreco: Boolean): Boolean;

      Function fIncluiConFreVariasNotas(strAutFis: String; arrSeqPag: TArrAutInc): Boolean;
      Function fVerificaPesoDosItens: Boolean;
      Function fEspecie: String;

      Procedure pCalculaUltAntRepresentatividade(cdsMovTri: TZClient);
      function fAtualizaPrecoMedio(blnForFil: Boolean): Boolean;
      function fAtualizaUltimaCompra(blnForFil: Boolean): Boolean;
      function fAtualizaComposicaoPreco(blnForFil: Boolean): Boolean;

      Procedure pCalculaTotaisPorNota;

      Procedure pIncluiConhecimento(objFreCon: TFreCon; blnIncluir: Boolean);
      procedure pRateiaConhecimentoFrete;

      Procedure pCriaClientNotas;
      procedure pUpdateMovtri(strAutInc: String; fltConFre, fltBasAnt, fltIcmAnt, fltOutDes, fltImpUlt, fltRpaFre, fltAlqFreIcm, fltValorFreteCalculado, fltValorConhecimentoCalculado: Double);
      Function fUpdateLotePrecos(fltConFre: Double; cdsMovTri: TZClient; fltPreCom: Double = -1): Boolean;
      procedure pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String; fltImpUlt, fltPreMed: Double; blnAtualizaUltimaCompra, blnAtualizaPrecoMedio: Boolean; var blnAtualizouRegistros: Boolean);
      Procedure pCarregaAtpVmb;

      Procedure pRateiaFreteRepresentatividade;
      procedure pRatearRecebimentoPagamentoAutonomo;

    Public
      strEntDoc: String;
      strEntFor: String;
      strEntSer : String;

      cdsRateioProdutos: TZClient;

      tipRatFrete: TTipoRateioFrete;

      constructor Create(Owner: TComponent;
                                blnVariasNotas, blnEntradaMercadorias: Boolean;
                                AobjIteAnt: TIcmsAntecipado = nil;
                                strChaveCTE: string = ''; blnImportacao: Boolean = False);
      Destructor Destroy; override;
      Function fRateiaConhecimentoFreteNotas(fltOutDes, fltValRpa: Double; strChaves: string = ''; strCadFis: String = ''): Boolean;
      procedure pCarregaCTEMOV(strAutInc: String);
//      function fAplicaReducaoIcmsEntradaLocal(fltValorFrete, fltAliquota: Double): Double;
//      function fAplicaReducaoIcmsEntradaPreMedLocal(fltValorFrete, fltAliquota: Double): Double;
//      function fAplicaReducaoIcmsFreteAntLocal(blnImpUlt: Boolean; strAutInc: String): Double;


      Function fExisteConhecimento(   strNumDoc,
                                      strEspDoc,
                                      strSerie_,
                                      strCodTra: String;
                                  Var IntIndice: Integer): Boolean;

      Procedure pExcluiConhecimento;

      Procedure pAlteraConhecimento(blnIncluir: Boolean; arrDuplicata: TarrDuplicataPointer);

      Procedure pGridConhecimento(); overload;
      Procedure pGridConhecimento(strEntDoc, strEntFor, strEntSer: String; arrDuplicata: TarrDuplicataPointer); overload;

      Function fRetConhecimento(strNumDoc, strEspDoc, strSerie_, strCodTra: String): TFreCon;

     function fConfirmaFreConhecimento(strPorBai, strNomForm, strSeqGer: String; ArrCteMov: TArrCteMov  = []; AstrHistoricoEntrada: String = ''; strClaFisEnt: String = ''): Boolean;
     Function fConfirmaFreConhecimentoVariasNotas: Boolean;
     Function fCarregaConhecimento(strAutGer, strEspDoc: String): Boolean;
     function fGetAliquotaFrete: Double;
     procedure pGravaValorMovDetReferenteFrete(strSeqMovDet, strSeqCadFis: String; fltConFre: Double; fltAlqIcmFre: Double);

     procedure pSetValorRpa(Value: Double; ptipRatFre: TTipoRateioFrete);
     function fGetPrevis : String ;
     property tipRatFreteRPA: TTipoRateioFrete read FtipRatFreteRPA;
     property fltRPAFre: Double  Read FRPAFre;
    published
      property fltMaxIVA: Double  Read FMaxIVA Write FMaxIVA;
      property fltTotIte: Double  Read FTotIte Write FTotIte;
      property fltTotLiq: Double  Read FTotLiq Write FTotLiq;
      property fltVlrCon: Double  Read FVlrCon Write FVlrCon;


      property fltAntIcT: Double  Read getAntIcT;
      property fltBasAnT: Double  Read getBasAnT;
      property fltValCon: Double  Read getValCon;
      property fltValFre: Double  Read getValFre;
      property fltValIcm: Double  Read getValIcm;

      property strCodOpe: String  Read FCodOpe Write FCodOpe;
      property strCodPor: String  Read FCodPor Write FCodPor;

      property strEspNot: String  Read FEspNot Write FEspNot;

      property blnVarNot: Boolean Read FVarNot;
      property blnEntMer: Boolean Read FEntMer;

   End;

implementation

Uses
  Forms,
  untConstantes,untFuncoesSimples,untFuncoes, Data.DB,
  untPreAlt,untEntFreConGrid, untCadPag, untEntFreConhecimento, untTConfiguracao,
  untCalculoUltimaCompraImpostos,
  System.Types, untPcmger, untFuncoesRel, untFuncoesRel2;

constructor TFreConLista.Create(Owner: TComponent;
                                blnVariasNotas, blnEntradaMercadorias: Boolean;
                                AobjIteAnt: TIcmsAntecipado = nil;
                                strChaveCTE: string = ''; blnImportacao: Boolean = False);
Begin
  qryCTEMOV := fCriaQuery;
  blnPerRep := fCfgSis('PERCTE', varBoolean);
  blnAtuMed := fCfgSis('ATUMED', varBoolean);
  blnAtuUlt := fCfgSis('ATUULT', varBoolean);
  blnAtpRen := fCfgSis('ATPREN', varBoolean);
  blnLotSim := fCfgSis('LOTSIM', varBoolean);
  If blnImportacao Then
    blnPerRep := False;
  If blnPerRep Then
    cdsTotNot := TZClient.Create(Self);

  strEmpMeds := fEmpresasMedEmp;
  strMedEmp  := fCfgSis('MEDEMP', varString);

  strForFil := fRetForFilialTodos;

  Inherited Create(Owner, fSQLFreCon(strChaveCTE) );


  tipRatFrete := trfIndefinido;

  case fCfgSis('RATFRE', varInteger) Of
    1 : tipRatFrete := trfPropValorItem;
    2 : tipRatFrete := trfPropPesoItem;
    3 : tipRatFrete := trfDefinirEntrada;
    4 : tipRatFrete := trfPropQtdItem;
    5 : tipRatFrete := trfInformarPercentuais;
  end;

  FFreIpi := fRateioFreteValorContabil(tipRatFrete);

  FPerFre := fCfgSis('PERFRE', VarInteger);

  FDecUni := fCfgSis('DECUNI', VarInteger);

  FEspNot := '';
  FVarNot := blnVariasNotas;
  FEntMer := blnEntradaMercadorias;

  FMaxIVA := 0;
  FTotIte := 0;
  FVlrCon := 0;
  FIndexFrete := -1;

  FCodOpe := strLoginUsuarioLogado;

  pCriaSoma('VALANT', 'TOT_VALANT');
  pCriaSoma('BASANT', 'TOT_BASANT');
  pCriaSoma('VALFRE', 'TOT_VALFRE');
  pCriaSoma('VALICM', 'TOT_VALICM');
  pCriaSoma('VALCON', 'TOT_VALCON');
  pCriaSoma('OUTDES', 'TOT_OUTDES');
  pCriaSoma('VALRPA', 'TOT_TOTRPA');

  fAbreClient(True, 'TFreConLista.Create');

  arrFreCon := TObjectList.Create(False);

  If FVarNot Then
    pCriaClientNotas
  Else
    cdsNotEnt := Nil;

  TFreCon.fCriaCdsRateioProdutos(cdsRateioProdutos);

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  pCarregaAtpVmb;

  If fTemAntecipacaoIcms and  (Not assigned(AobjIteAnt)) Then
    objIteAnt := TIcmsAntecipado.Create(Self, FEntMer)
  Else If not Assigned(AobjIteAnt) Then
    objIteAnt := Nil
  Else
    objIteAnt := AobjIteAnt;
  FRPAFre := 0;

  case fCfgSis('RATFRE', varInteger) of
    1: FTipRatFreteRPA := TTipoRateioFrete.trfPropValorItem;
    2: FTipRatFreteRPA := TTipoRateioFrete.trfPropPesoItem;
    3: FTipRatFreteRPA := TTipoRateioFrete.trfDefinirEntrada;
    4: FTipRatFreteRPA := TTipoRateioFrete.trfPropQtdItem;
    5: FTipRatFreteRPA := TTipoRateioFrete.trfInformarPercentuais;
  end;
End;

Procedure TFreConLista.pCarregaAtpVmb;
  Var
    intCont: Integer;
Begin
  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');
End;

procedure TFreConLista.pCarregaCTEMOV(strAutInc: String);
begin
  qryCTEMOV.SQL.Text := 'SELECT MOV_CONFRE,MOV_ALQFRE FROM CTEMOV WHERE MOV_MOVDET = "'+strAutInc+'"';
  qryCTEMOV.Open;

end;

function TFreConLista.fSqlNotas: String;
Begin
  Result := '/* untEntFreCon.fSqlNotas */ ';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   G.AUTOINCREM AS AUTINC, ';
  Result := Result + '   GER_DTAENT   AS DTAENT, ';
  Result := Result + '   GER_NUMDOC   AS NUMDOC, ';
  Result := Result + '   GER_ESPDOC   AS ESPDOC, ';
  Result := Result + '   GER_SERIE_   AS SERIE_, ';
  Result := Result + '   GER_CODFOR   AS CODFOR, ';
  Result := Result + '   GER_VLRCON   AS VLRCON, ';
  Result := Result + '   FOR_NOMFOR   AS NOMFOR, ';
  Result := Result + '   0.00         AS OUTDES, ';
  Result := Result + '   0.00         AS VALRPA, ';
  Result := Result + '   0.00         AS PERREP, ';
  Result := Result + '   0.00         AS TOTFRE, ';
  Result := Result + '   0.00         AS BASANT, ';
  Result := Result + '   0.00         AS ICMANT, ';
  Result := Result + '   0.00         AS FRERES, ';
  Result := Result + '   0.00         AS BASRES, ';
  Result := Result + '   0.00         AS ICMRES, ';
  Result := Result + '   ""           AS MATREV  ';
  Result := Result + ' FROM ';
  Result := Result + '   MOVGER G ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  Result := Result + ' WHERE FALSE ';
End;

Procedure TFreConLista.pCriaClientNotas;
Begin
  If Not Assigned(cdsNotEnt) Then
  Begin
    cdsNotEnt := TZClient.Create(Self, fSqlNotas);
    cdsNotEnt.pCriaSoma('PERREP', 'TOTREP');
    cdsNotEnt.pCriaSoma('VLRCON', 'TOTCON');

    If cdsNotEnt.fAbreClient(True, 'TFreConLista.pCriaClientNotas') Then
    Begin
      cdsNotEnt.pFormataDecimal('VLRCON');
    End;
  End;
End;

Destructor TFreConLista.Destroy;
Begin
  FreeAndNil(qryCTEMOV);
  FreeAndNil(arrFreCon);

  inherited;
End;

Function TFreConLista.fSQLFreCon(strChaveCTE: string = ''): String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   FIS_NUMDOC AS NUMDOC, ';
  Result := Result + '   FIS_ESPDOC AS ESPDOC, ';
  Result := Result + '   FIS_SERIE_ AS SERIE_, ';
  Result := Result + '   FIS_DTAENT AS DTAENT, ';
  Result := Result + '   FIS_CODEMP AS CODEMP, ';
  Result := Result + '   FIS_DTADOC AS DTADOC, ';
  Result := Result + '   FOR_CODFOR AS CODTRA, ';
  Result := Result + '   FOR_NOMFOR AS NOMTRA, ';
  If fEmptyStr(strChaveCTE) Then
  Begin
    Result := Result + '   0.00 AS VALFRE, ';
    Result := Result + '   0.00 AS VALICM, ';
    Result := Result + '   0.00 AS VALANT, ';
    Result := Result + '   0.00 AS BASANT, ';
    Result := Result + '   0.00 AS VALCON, ';
    Result := Result + '   0.00 AS OUTICM, ';
    Result := Result + '   0.00 AS OUTDES, ';
    Result := Result + '   0.00 AS VALRPA, ';
  End
  Else
  Begin
    Result := Result + '   IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS VALFRE,';
    Result := Result + '   IFNULL(FIS_VLRIC1, 0) + IFNULL(FIS_VLRIC2, 0) + IFNULL(FIS_VLRIC3, 0) + IFNULL(FIS_VLRIC4, 0) + IFNULL(FIS_VLRIC5, 0) AS VALICM,';
    Result := Result + '   IFNULL(FIS_ANTIC1, 0) + IFNULL(FIS_ANTIC2, 0) + IFNULL(FIS_ANTIC3, 0) + IFNULL(FIS_ANTIC4, 0) + IFNULL(FIS_ANTIC5, 0) AS VALANT,';
    Result := Result + '   IFNULL(FIS_BASAN1, 0) + IFNULL(FIS_BASAN2, 0) + IFNULL(FIS_BASAN3, 0) + IFNULL(FIS_BASAN4, 0) + IFNULL(FIS_BASAN5, 0) AS BASANT,';
    Result := Result + '   IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS VALCON,';
    Result := Result + '   IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS OUTCIM,';
    Result := Result + '   0.00 AS OUTDES, ';
    Result := Result + '   0.00 AS VALRPA, ';
  End;
  Result := Result + '   CAST("" AS CHAR(100)) AS CONPAG            ';
  Result := Result + ' FROM                                         ';
  Result := Result + '   CADFIS                                     ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';
  If fEmptyStr(strChaveCTE) Then
    Result := Result + ' WHERE FALSE                                  '
  Else
    Result := Result + ' WHERE CADFIS.AUTOINCREM =  ' + fQuotedStr(strChaveCTE);

End;

Function TFreConLista.fSQLFreConRel(strEspDoc: String): String;
Begin
  Result := '';

  If Pos(strEspDoc, 'NF_IF_IV_') > 0 Then
  Begin
    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   FIS_NUMDOC AS NUMDOC, ';
    Result := Result + '   FIS_ESPDOC AS ESPDOC, ';
    Result := Result + '   FIS_SERIE_ AS SERIE_, ';
    Result := Result + '   FIS_DTAENT AS DTAENT, ';
    Result := Result + '   FIS_DTADOC AS DTADOC, ';
    Result := Result + '   FIS_CODEMP AS CODEMP, ';
    Result := Result + '   FOR_CODFOR AS CODTRA, ';
    Result := Result + '   FOR_NOMFOR AS NOMTRA, ';
    Result := Result + '   0.00       AS VALFRE, ';
    Result := Result + '   IFNULL(FIS_VLRIC1, 0) + IFNULL(FIS_VLRIC2, 0) + IFNULL(FIS_VLRIC3, 0) + IFNULL(FIS_VLRIC4, 0) + IFNULL(FIS_VLRIC5, 0) AS VALICM, ';
    Result := Result + '   0.00       AS VALANT, ';
    Result := Result + '   0.00       AS BASANT, ';
    Result := Result + '   IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS VALCON, ';

    Result := Result + '  (SELECT SUM(G.GER_TOTPRO) FROM MOVGER G ';
    Result := Result + '   , CONFRE C  ';
    Result := Result + '   WHERE C.CON_SEQFIS = F.AUTOINCREM AND ';
    Result := Result + '   G.AUTOINCREM = C.CON_SEQGER) AS  VALTOT, ';

    Result := Result + '   0.00       AS OUTDES, ';
    Result := Result + '   0.00       AS VALRPA, ';
    Result := Result + '   CAST("" AS CHAR(100)) AS CONPAG ';
    Result := Result + ' FROM                                               ';
    Result := Result + '   CADFIS F                                         ';
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI       ';
    Result := Result + ' INNER JOIN CONFRE ON CON_SEQFIS = F.AUTOINCREM AND ';
    Result := Result + '                      CON_SEQGER = :SEQGER          ';

    Result := Result + ' UNION ALL ';

    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   FIS_NUMDOC AS NUMDOC, ';
    Result := Result + '   FIS_ESPDOC AS ESPDOC, ';
    Result := Result + '   FIS_SERIE_ AS SERIE_, ';
    Result := Result + '   FIS_DTAENT AS DTAENT, ';
    Result := Result + '   FIS_DTADOC AS DTADOC, ';
    Result := Result + '   FIS_CODEMP AS CODEMP, ';
    Result := Result + '   FOR_CODFOR AS CODTRA, ';
    Result := Result + '   FOR_NOMFOR AS NOMTRA, ';
    Result := Result + '   0.00       AS VALFRE, ';
    Result := Result + '   IFNULL(FIS_VLRIC1, 0) + IFNULL(FIS_VLRIC2, 0) + IFNULL(FIS_VLRIC3, 0) + IFNULL(FIS_VLRIC4, 0) + IFNULL(FIS_VLRIC5, 0) AS VALICM, ';
    Result := Result + '   0.00       AS VALANT, ';
    Result := Result + '   0.00       AS BASANT, ';
    Result := Result + '   IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS VALCON, ';

    Result := Result + '  (SELECT SUM(G.GER_TOTPRO) FROM MOVGER G ';
    Result := Result + '   , RECTNF C  ';
    Result := Result + '   WHERE C.REC_CTESEQ = F.AUTOINCREM AND ';
    Result := Result + '   G.AUTOINCREM = C.REC_MOVSEQ) AS  VALTOT, ';

    Result := Result + '   0.00       AS OUTDES, ';
    Result := Result + '   0.00       AS VALRPA, ';
    Result := Result + '   CAST("" AS CHAR(100)) AS CONPAG ';
    Result := Result + ' FROM                                               ';
    Result := Result + '   CADFIS F                                         ';
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI       ';
    Result := Result + ' INNER JOIN RECTNF ON REC_CTESEQ = F.AUTOINCREM AND ';
    Result := Result + '                      REC_MOVSEQ = :SEQGER          ';
  End Else
  Begin
    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   RIGHT(CTP_NUMDUP, ' + IntToStr(fTamNumDoc) + ') AS NUMDOC, ';
    Result := Result + '   "CT"       AS ESPDOC, ';
    Result := Result + '   CTP_SERIE_ AS SERIE_, ';
    Result := Result + '   CTP_DTACAD AS DTAENT, ';
    Result := Result + '   CTP_DTACAD AS DTADOC, ';
    Result := Result + '   CTP_CODEMP AS CODEMP, ';
    Result := Result + '   CTP_CODFOR AS CODTRA, ';
    Result := Result + '   FOR_NOMFOR AS NOMTRA, ';
    Result := Result + '   0.00       AS VALFRE, ';
    Result := Result + '   0.00       AS VALICM, ';
    Result := Result + '   0.00       AS VALANT, ';
    Result := Result + '   0.00       AS BASANT, ';
    Result := Result + '   SUM(CTP_VALORI) AS VALCON, ';

    Result := Result + '  (SELECT SUM(G.GER_TOTPRO) FROM MOVGER G ';
    Result := Result + '   , CONFRE F ';
    Result := Result + '   WHERE F.CON_SEQPAG = C.AUTOINCREM AND ';
    Result := Result + '   G.AUTOINCREM = F.CON_SEQGER) AS  VALTOT, ';

    Result := Result + '   0.00       AS OUTDES,                             ';
    Result := Result + '   0.00       AS VALRPA, ';
    Result := Result + '   CAST("" AS CHAR(100)) AS CONPAG,                  ';
    Result := Result + '   CTP_NUMDUP AS NUMDUP ';
    Result := Result + ' FROM                                                ';
    Result := Result + '   CADPAG C                                         ';
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR       ';
    Result := Result + ' INNER JOIN CONFRE ON CON_SEQPAG = C.AUTOINCREM AND ';
    Result := Result + '                      CON_SEQGER = :SEQGER          ';
    Result := Result + ' GROUP BY          ';
    Result := Result + '   CTP_NUMDUP ';
  End;

End;

Function TFreConLista.fCarregaConhecimento(strAutGer, strEspDoc: String): Boolean;
Begin
  qryQuery.SQL.Text := fSQLFreConRel(strEspDoc);

  qryQuery.ParamByName('SEQGER').AsString := strAutGer;

  Result := fAbreClient(True, 'TFreConLista.pCarregaConhecimento');
End;

Procedure TFreConLista.pIncluiConhecimento(objFreCon: TFreCon; blnIncluir: Boolean);
Begin
  If blnIncluir Then
    arrFreCon.Add(objFreCon);

  With objFreCon Do
  Begin
    If blnIncluir Then
      Insert
    Else
      Edit;

    FieldByName('NUMDOC').AsString   := strNumDoc;
    FieldByName('ESPDOC').AsString   := strEspDoc;
    FieldByName('SERIE_').AsString   := strSerie_;
    FieldByName('CODEMP').AsString   := VS_strCodEmp;
    FieldByName('CODTRA').AsString   := strCodTra;
    FieldByName('NOMTRA').AsString   := fRetNomFornecedor(strCodTra);
    FieldByName('DTAENT').AsDateTime := strToDate(strDtaEnt);
    FieldByName('VALFRE').AsFloat    := fStrToFloat(strValDoc);
    FieldByName('VALICM').AsFloat    := fStrToFloat(strValIcT);
    FieldByName('VALANT').AsFloat    := fStrToFloat(strAntIcT);
    FieldByName('BASANT').AsFloat    := fStrToFloat(strBasAnT);

    If fltValTot = 0 Then {Caixa 2}
      FieldByName('VALCON').AsFloat    := fStrToFloat(strValDoc)
    Else
      FieldByName('VALCON').AsFloat    := fltValTot;

    FieldByName('CONPAG').AsString   := fFormataCondPag(strCndPag);

    If Assigned(objOutDes) Then
    begin
      FieldByName('OUTDES').AsFloat  := objOutDes.fltValOut;
      FieldByName('VALRPA').AsFloat  := objOutDes.fltValRPA;
    End
    Else
    begin
      FieldByName('OUTDES').AsFloat  := 0;
      FieldByName('VALRPA').AsFloat  := 0;
    End;

    Post;

  End;
End;

Function TFreConLista.fExisteConhecimento(    strNumDoc,
                                              strEspDoc,
                                              strSerie_,
                                              strCodTra: String;
                                          Var intIndice: Integer): Boolean;
  Var
    intContador: Integer;
    objFreCon: TFreCon;
Begin
  Result := False;

  For intContador := 0 To arrFreCon.Count - 1 Do
  Begin
    objFreCon := TFreCon(arrFreCon.Items[intContador]);

    If (objFreCon.strNumDoc = strNumDoc) And
       (objFreCon.strEspDoc = strEspDoc) And
       (objFreCon.strSerie_ = strSerie_) And
       (objFreCon.strCodTra = strCodTra) Then
    Begin
      Result    := True;
      intIndice := intContador;
      Exit;
    End;
  End;

End;

function TFreConLista.fGetAliquotaFrete: Double;
var i: integer;
begin
  Result := -1;
  If arrFreCon.Count > 0 Then
  Begin
    Result := 0;
    For i := 0 To arrFreCon.Count -1 Do
     Result :=  Result + fStrToFloat(TFreCon(arrFreCon[i]).strAlqIc1);
     Result := RoundTo(Result/(arrFreCon.Count), -2);
  End;
end;

function TFreConLista.fGetPrevis: String;
begin
  Try
    Result := TFreCon(arrFreCon.Items[0]).strPrevis ;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFreConLista.fGetPrevis]');
    End;
  End;
end;

Procedure TFreConLista.pExcluiConhecimento;
  Var
    intIndice: Integer;
Begin
  If IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do conhecimento ' + FieldByName('NUMDOC').AsString + '?') And
    fExisteConhecimento(FieldByName('NUMDOC').AsString,
                        FieldByName('ESPDOC').AsString,
                        FieldByName('SERIE_').AsString,
                        FieldByName('CODTRA').AsString,
                        intIndice) Then
  Begin
    arrFreCon.Remove(arrFreCon.Items[intIndice]);
    Delete;
  End;
End;

Function TFreConLista.fEspecie: String;
Begin
  If Assigned(cdsNotEnt) And (Not cdsNotEnt.IsEmpty) Then
    Result := cdsNotEnt.FieldByName('ESPDOC').AsString
  Else
    Result := FEspNot;
End;

procedure TFreConLista.pSetValorRpa(Value: Double; ptipRatFre: TTipoRateioFrete);
begin
  if ((FRpaFre = Value) and (FtipRatFreteRPA = ptipRatFre))
     or ((FtipRatFreteRPA <> ptipRatFre) and (FRpaFre = Value) and (FRpaFre =0))  then
    Exit;
  FRpaFre := Value;
  FtipRatFreteRPA := ptipRatFre;
  pRatearRecebimentoPagamentoAutonomo;
end;

Procedure TFreConLista.pAlteraConhecimento(blnIncluir: Boolean; arrDuplicata: TarrDuplicataPointer);
  Var
    intIndice: Integer;
    objFreCon: TFreCon;
Begin
  If (Not blnIncluir) And IsEmpty Then
    Exit;

  objFreCon := Nil;

  If blnIncluir Then
  Begin
    objFreCon := TFreCon.Create(Self, FVarNot);
    objFreCon.fltVlrConNota := fltVlrCon;
    objFreCon.cdsNotEnt := cdsNotEnt;
    objFreCon.cdsRateioProdutos := cdsRateioProdutos;
    objFreCon.objIteAnt := objIteAnt;
    objFreCon.strCodPor := self.strCodPor;
    objFreCon.strCodOpe := strLoginUsuarioLogado;
    objFreCon.strEntDoc := strEntDoc;
    objFreCon.strEntFor := strEntFor;
    objFreCon.strEntSer := strEntSer;

  End

  Else If fExisteConhecimento(FieldByName('NUMDOC').AsString,
                         FieldByName('ESPDOC').AsString,
                         FieldByName('SERIE_').AsString,
                         FieldByName('CODTRA').AsString,
                         intIndice) Then
  Begin
    objFreCon := TFreCon(arrFreCon.Items[intIndice]);
  End;

  If Not Assigned(objFreCon) Then
    Exit;

  Try
    objFreCon.fltTotTodosFretes := fltValFre;

    pCriarFormularios(TfrmEntFreConhecimento, frmEntFreConhecimento);
    frmEntFreConhecimento.blnAlteracao := Not blnIncluir;
    frmEntFreConhecimento.fltMaxIVA := fltMaxIVA;
    frmEntFreConhecimento.objFreCon := objFreCon;
    frmEntFreConhecimento.pnlClassificacoes.Enabled := SameText(fEspecie, 'NF');
    frmEntFreConhecimento.cbbTipFre.Visible := (fCfgSis('RATFRE', varInteger) = 3);
    frmEntFreConhecimento.lblTipFre.Visible := frmEntFreConhecimento.cbbTipFre.Visible;

    If frmEntFreConhecimento.cbbTipFre.Visible Then
    Begin
      If FIndexFrete = -1 Then
      Begin
        case tipRatFrete of
          trfPropValorItem : FIndexFrete := 0;
          trfPropPesoItem  : FIndexFrete := 1;
          trfPropQtdItem   : FIndexFrete := 2;
          trfInformarPercentuais: FIndexFrete := 3;
        end;
      End;
      frmEntFreConhecimento.cbbTipFre.ItemIndex := FIndexFrete;

    End;
    If frmEntFreConhecimento.ShowModal = mrOk Then
    Begin
      If frmEntFreConhecimento.cbbTipFre.Visible Then
      Begin
        case frmEntFreConhecimento.cbbTipFre.ItemIndex Of
          0 : tipRatFrete := trfPropValorItem;
          1 : tipRatFrete := trfPropPesoItem;
          2 : tipRatFrete := trfPropQtdItem;
          3 : tipRatFrete := trfInformarPercentuais;
        end;
        FIndexFrete := frmEntFreConhecimento.cbbTipFre.ItemIndex;
      End;
      pIncluiConhecimento(objFreCon, blnIncluir);
    End;


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFreConLista.pAlteraConhecimento]');
    End;
  End;

  pFreeAndNil(frmEntFreConhecimento);
End;

procedure TFreConLista.pGravaValorMovDetReferenteFrete(strSeqMovDet, strSeqCadFis: String; fltConFre: Double; fltAlqIcmFre: Double);
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery;
  Try
    qryInsert.sql.text := 'INSERT INTO CTEMOV (MOV_CADFIS, MOV_MOVDET, MOV_CONFRE, MOV_ALQFRE) VALUES (:CADFIS, :MOVDET, :CONFRE, :ALQFRE )';
    qryInsert.ParamByName('CADFIS').AsString := strSeqCadFis;
    qryInsert.ParamByName('MOVDET').AsString := strSeqMovDet;
    qryInsert.ParamByName('CONFRE').AsFloat  := fltConFre;
    qryInsert.ParamByName('ALQFRE').AsFloat  := fltAlqIcmFre;
    qryInsert.execSQL;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

Procedure TFreConLista.pGridConhecimento();
begin
  pGridConhecimento('', '', '', nil);
end;

Procedure TFreConLista.pGridConhecimento(strEntDoc, strEntFor, strEntSer: String; arrDuplicata: TarrDuplicataPointer);
  Var
    frmEntFreConGrid: TfrmEntFreConGrid;
Begin
  frmEntFreConGrid := nil;

  Try
    Try
      pCriarFormularios(TfrmEntFreConGrid, frmEntFreConGrid);
      frmEntFreConGrid.arrDuplicata := arrDuplicata;
      frmEntFreConGrid.objLisFre := Self;
      frmEntFreConGrid.objLisFre.strEntDoc := strEntDoc;
      frmEntFreConGrid.objLisFre.strEntFor := strEntFor;
      frmEntFreConGrid.objLisFre.strEntSer := strEntSer;

      frmEntFreConGrid.ShowModal;

      If Not FVarNot Then
      Begin
        pRateiaConhecimentoFrete;
      End;
    Finally
      pFreeAndNil(frmEntFreConGrid);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFreConLista.pGridConhecimento]');
    End;
  End;

End;

Function TFreConLista.fRetTotItensAntFrete: Double;
  Var
    qryLeitura: TUniQuery;
Begin
  qryLeitura := fCriaQuery;

  With qryLeitura Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT  ');

    If FFreIpi Then
      SQL.Add('   SUM(ENT_VLRCON) AS TOTITE')
    Else
      SQL.Add('   SUM(ENT_TOTITE - ENT_DESESP) AS TOTITE ');

    SQL.Add(' FROM TMP_ENTMER');
    SQL.Add(' WHERE ENT_ANTFRE = "S" ');
    Open;

    Result := FieldByName('TOTITE').AsFloat;
  End;

  FreeAndNil(qryLeitura);
End;

procedure TFreConLista.pRatearRecebimentoPagamentoAutonomo;
  const
    SQL_UPDATE_ENT_MER: String = ' UPDATE TMP_ENTMER SET ENT_FRERPA = :FRERPA WHERE AUTOINCREM = :AUTINC ';
  Var
    qryGenMer: TUniQuery;
    qryLeitura: TUniQuery;
    intNumReg,
    intQtdReg: Integer;



    strUltAutDetComPercentual,
    strUltIncAntFrete: String;


    fltPesTot,
    fltQtdTot,
    fltQtdTotAnt,
    fltPesTotAnt,
    fltFatorAlocacaoRateioRpaFre,
    fltRpaFreRestante: Double;

    Function fUltimoRegistroComFreteInformarPercentuais: String;
    Begin
      Result := '';

      qryLeitura.Last;

      While Not qryLeitura.Bof Do
      Begin
        If cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) And
           (cdsRateioProdutos.FieldByName('PERFRE').AsFloat > 0)  Then
        Begin
          Result := qryLeitura.FieldByName('AUTOINCREM').AsString;
          Exit;
        End;

        qryLeitura.Prior;
      End;

      qryLeitura.First;
    End;

    Function fSomaPercentualAntecipado: Double;
    Begin
      Result := 0;

      qryLeitura.First;

      While Not qryLeitura.Eof Do
      Begin
        If (qryLeitura.FieldByName('ENT_ANTFRE').AsString = 'S') And
            cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) Then
          Result := Result + cdsRateioProdutos.FieldByName('PERFRE').AsFloat;

        qryLeitura.Next;
      End;

      qryLeitura.First;
    End;

    Function fUltimoRegistro: Boolean;
    Begin
      If tipRatFrete = trfInformarPercentuais Then
        Result := strUltAutDetComPercentual = qryLeitura.FieldByName('AUTOINCREM').AsString
      Else
        Result := intNumReg = intQtdReg
    End;

begin
  Try
    fltPesTot := 0;
    fltQtdTot := 0;

    fltRpaFreRestante := fltRpaFre;

    case tipRatFreteRPA of
      trfPropPesoItem: fltPesTot := fRetornaPesoEntrada(fltPesTotAnt);
      trfPropQtdItem : fltQtdTot := fRetornaQtdeEntrada(fltQtdTotAnt);
      Else
      Begin
        fltPesTot    := 0;
        fltPesTotAnt := 0;
      End;
    End;


    qryGenMer  := fCriaQuery;
    qryLeitura := fCriaQuery;

    With qryLeitura Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT  ');
      SQL.Add('   TMP_ENTMER.AUTOINCREM, ');
      SQL.Add('   ENT_ANTFRE, ');
      SQL.Add('   ENT_TOTITE, ');
      SQL.Add('   ENT_QTDITE, ');
      SQL.Add('   ENT_DESESP, ');
      SQL.Add('   ENT_VLRCON  ');

      If tipRatFreteRPA = trfPropPesoItem Then
        SQL.Add(' , ENT_QTDITE * ITE_PESOIT AS PESITE ');

      SQL.Add(' FROM TMP_ENTMER');

      If tipRatFreteRPA = trfPropPesoItem Then
        SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE');

      Open;
    End;

    If tipRatFreteRPA = trfInformarPercentuais Then
    Begin
      cdsRateioProdutos.IndexFieldNames := 'AUTDET';

      strUltAutDetComPercentual := fUltimoRegistroComFreteInformarPercentuais;


    End;

    strUltIncAntFrete := '';

    intNumReg := 0;
    intQtdReg := qryLeitura.RecordCount;

    QryGenMer.Close;
    QryGenMer.SQL.clear;
    QryGenMer.Sql.Add(SQL_UPDATE_ENT_MER);

    qryLeitura.First;
    While Not qryLeitura.Eof Do
    Begin
      inc(intNumReg);
      fltFatorAlocacaoRateioRpaFre := 0;
      If fUltimoRegistro Then
      Begin
        qryGenMer.ParamByName('FRERPA').AsFloat := fltRpaFreRestante;
      End
      else if FVlrCon > 0 Then
      Begin
        case tipRatFreteRPA of
          trfPropPesoItem : Begin
                              If fltPesTot > 0 Then
                                fltFatorAlocacaoRateioRpaFre := (qryLeitura.FieldByName('PESITE').AsFloat/fltPesTot);
                            End;

          trfPropQtdItem  : fltFatorAlocacaoRateioRpaFre := qryLeitura.FieldByName('ENT_QTDITE').AsFloat / fltQtdTot;


          trfInformarPercentuais: begin
                                    If cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) Then
                                      fltFatorAlocacaoRateioRpaFre := cdsRateioProdutos.FieldByName('PERFRE').AsFloat / 100;
                                  end;

          Else
          Begin
            If FFreIpi Then
              fltFatorAlocacaoRateioRpaFre := qryLeitura.FieldByName('ENT_VLRCON').AsFloat /FVlrCon
            Else
              fltFatorAlocacaoRateioRpaFre
                := (qryLeitura.FieldByName('ENT_TOTITE').AsFloat - qryLeitura.FieldByName('ENT_DESESP').AsFloat)/ FTotLiq;
          End;
        End;

        qryGenMer.ParamByName('FRERPA').AsFloat := roundTo(fltRpaFre * fltFatorAlocacaoRateioRpaFre, -2);
        fltRpaFreRestante := fltRpaFreRestante - qryGenMer.ParamByName('FRERPA').AsFloat;
      End;
      qryGenMer.ParamByName('AUTINC').AsString := qryLeitura.FieldByName('AUTOINCREM').AsString;

      qryGenMer.ExecSQL;

      qryLeitura.Next;
    end;

    FreeAndNil(qryGenMer);
    FreeAndNil(qryLeitura);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[pRatearRecebimentoPagamentoAutonomo]');
    End;
  End;
end;

procedure TFreConLista.pRateiaConhecimentoFrete;
  Var
    qryGenMer: TUniQuery;
    qryLeitura: TUniQuery;
    intNumReg,
    intQtdReg: Integer;
    fltFreRes,
    fltBaFranRes,
    fltVaFranRes,
    fltTotAnt: Double;

    strUltAutDetComPercentual,
    strUltIncAntFrete: String;

    fltFreRat,
    fltPesTot,
    fltQtdTot,
    fltQtdTotAnt,
    fltPesTotAnt,
    fltPercentualTotAnt: Double;
    strCnvEmb: String;
    blnCnvEmb: boolean;

    Function fUltimoRegistroComFreteInformarPercentuais: String;
    Begin
      Result := '';

      qryLeitura.Last;

      While Not qryLeitura.Bof Do
      Begin
        If cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) And
           (cdsRateioProdutos.FieldByName('PERFRE').AsFloat > 0)  Then
        Begin
          Result := qryLeitura.FieldByName('AUTOINCREM').AsString;
          Exit;
        End;

        qryLeitura.Prior;
      End;

      qryLeitura.First;
    End;

    Function fSomaPercentualAntecipado: Double;
    Begin
      Result := 0;

      qryLeitura.First;

      While Not qryLeitura.Eof Do
      Begin
        If (qryLeitura.FieldByName('ENT_ANTFRE').AsString = 'S') And
            cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) Then
          Result := Result + cdsRateioProdutos.FieldByName('PERFRE').AsFloat;

        qryLeitura.Next;
      End;

      qryLeitura.First;
    End;

    Function fUltimoRegistro: Boolean;
    Begin
      If tipRatFrete = trfInformarPercentuais Then
        Result := strUltAutDetComPercentual = qryLeitura.FieldByName('AUTOINCREM').AsString
      Else
        Result := intNumReg = intQtdReg
    End;

begin
  Try
    strCnvEmb := fCfgSis('CNVEMB');
    blnCnvEmb := fCfgSis('CNVEMB') <> 'N';
    fltPesTot := 0;
    fltQtdTot := 0;
    fltPercentualTotAnt := 0;

    case tipRatFrete of
      trfPropPesoItem: fltPesTot := fRetornaPesoEntrada(fltPesTotAnt, blnCnvEmb);
      trfPropQtdItem : fltQtdTot := fRetornaQtdeEntrada(fltQtdTotAnt);
      Else
      Begin
        fltPesTot    := 0;
        fltPesTotAnt := 0;
      End;
    End;

    fltTotAnt := fRetTotItensAntFrete;

    qryGenMer  := fCriaQuery;
    qryLeitura := fCriaQuery;

    With qryLeitura Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT  ');
      SQL.Add('   TMP_ENTMER.AUTOINCREM, ');
      SQL.Add('   ENT_ANTFRE, ');
      SQL.Add('   ENT_TOTITE, ');
      If (strCnvEmb <> 'N') And (tipRatFrete = trfPropPesoItem) Then
        SQL.Add('   ROUND(ENT_QTDITE * ENT_EMBALA, ' + fCfgSis('DEQTEM') + ') AS ENT_QTDITE, ')
      Else
        SQL.Add('   ENT_QTDITE, ');
      SQL.Add('   ENT_DESESP, ');
      SQL.Add('   ENT_VLRCON  ');

      If tipRatFrete = trfPropPesoItem Then
      Begin
        If (strCnvEmb <> 'N') Then
          SQL.Add(' , ROUND(ENT_QTDITE * ENT_EMBALA, ' + fCfgSis('DEQTEM') + ') * ITE_PESOIT AS PESITE ')
        Else
          SQL.Add(' , ENT_QTDITE * ITE_PESOIT AS PESITE ');
       End;

      SQL.Add(' FROM TMP_ENTMER');

      If tipRatFrete = trfPropPesoItem Then
        SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE');

      Case tipRatFrete of
        trfPropPesoItem: SQL.Add(' ORDER BY PESITE DESC ');
        Else
          SQL.Add(' ORDER BY ENT_TOTITE DESC ');
      End;

      Open;
    End;

    If tipRatFrete = trfInformarPercentuais Then
    Begin
      cdsRateioProdutos.IndexFieldNames := 'AUTDET';

      strUltAutDetComPercentual := fUltimoRegistroComFreteInformarPercentuais;

      fltPercentualTotAnt := fSomaPercentualAntecipado;
    End;

    strUltIncAntFrete := '';
    qryLeitura.Last;

    While Not qryLeitura.Bof Do
    Begin

      If qryLeitura.FieldByName('ENT_ANTFRE').AsString = 'S' Then
      Begin
        strUltIncAntFrete := qryLeitura.FieldByName('AUTOINCREM').AsString;
        Break;
      End;

      qryLeitura.Prior;
    End;

    intNumReg := 0;
    intQtdReg := qryLeitura.RecordCount;

    fltFreRat    := fltValFre;


    fltFreRes    := fltFreRat;
    fltBaFrAnRes := fltBasAnT;
    fltVaFrAnRes := fltAntIcT;

    qryLeitura.First;
    While Not qryLeitura.Eof Do
    Begin
      inc(intNumReg);

      With qryGenMer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE TMP_ENTMER SET      ');
        SQL.Add('   ENT_FRECON = :VALFRE,    ');
        SQL.Add('   ENT_BAFRAN = :BAFRAN,    ');
        SQL.Add('   ENT_VAFRAN = :VAFRAN     ');

        SQL.Add(' WHERE AUTOINCREM = :AUTINC ');

        If fUltimoRegistro Then
        Begin
          ParamByName('VALFRE').AsFloat := fltFreRes;
        End Else
        Begin

          If FVlrCon > 0 Then
          Begin
            case tipRatFrete of
              trfPropPesoItem : Begin
                                  If fltPesTot > 0 Then
                                    ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltFreRat / fltPesTot), -2)
                                  Else
                                    ParamByName('VALFRE').AsFloat := 0;

                                End;
              trfPropQtdItem  : ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltFreRat / fltQtdTot), -2);

              trfInformarPercentuais: If cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) Then
                                        ParamByName('VALFRE').AsFloat := RoundTo(fltFreRat * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / 100 , -2)
                                      Else
                                        ParamByName('VALFRE').AsFloat := 0;

              Else
              Begin
                If FFreIpi Then
                  ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_VLRCON').AsFloat * (fltFreRat / FVlrCon), -2)
                Else
                  ParamByName('VALFRE').AsFloat := RoundTo((qryLeitura.FieldByName('ENT_TOTITE').AsFloat - qryLeitura.FieldByName('ENT_DESESP').AsFloat) * (fltFreRat / FTotLiq), -2);
              End;
            End;
          End Else
          Begin
            ParamByName('VALFRE').AsFloat := 0;
          End;
          fltFreRes := (fltFreRes - ParamByName('VALFRE').AsFloat);
          If fltFreRes < 0 Then
            fltFreRes := 0;
        End;

        If qryLeitura.FieldByName('ENT_ANTFRE').AsString = 'S' Then
        Begin

          If qryLeitura.FieldByName('AUTOINCREM').AsString = strUltIncAntFrete Then
          Begin

            ParamByName('BAFRAN').AsFloat := fltBaFrAnRes;
            ParamByName('VAFRAN').AsFloat := fltVaFrAnRes;

          End Else
          Begin

            If fltTotAnt > 0 Then
            Begin
              case tipRatFrete of
                trfPropPesoItem : Begin
                                    If fltPesTotAnt > 0 Then
                                    Begin
                                      ParamByName('BAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltBasAnT / fltPesTotAnt), -2);
                                      ParamByName('VAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltAntIcT / fltPesTotAnt), -2);
                                    End
                                    Else
                                    Begin
                                      ParamByName('BAFRAN').AsFloat := 0;
                                      ParamByName('VAFRAN').AsFloat := 0;
                                    End;
                                  End;

                trfPropQtdItem :  Begin
                                    ParamByName('BAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltBasAnT / fltQtdTotAnt), -2);
                                    ParamByName('VAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltAntIcT / fltQtdTotAnt), -2);
                                  End;

                trfInformarPercentuais: If (fltPercentualTotAnt > 0) And cdsRateioProdutos.FindKey([qryLeitura.FieldByName('AUTOINCREM').AsString]) Then
                                        Begin
                                          ParamByName('BAFRAN').AsFloat := RoundTo(fltBasAnT * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / fltPercentualTotAnt, -2);
                                          ParamByName('VAFRAN').AsFloat := RoundTo(fltAntIcT * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / fltPercentualTotAnt, -2);
                                        End Else
                                        Begin
                                          ParamByName('BAFRAN').AsFloat := 0;
                                          ParamByName('VAFRAN').AsFloat := 0;
                                        End;

                Else
                begin
                  If FFreIpi Then
                  Begin
                    ParamByName('BAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_VLRCON').AsFloat * (fltBasAnT / fltTotAnt), -2);
                    ParamByName('VAFRAN').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_VLRCON').AsFloat * (fltAntIcT / fltTotAnt), -2);
                  End Else
                  Begin
                    ParamByName('BAFRAN').AsFloat := RoundTo((qryLeitura.FieldByName('ENT_TOTITE').AsFloat - qryLeitura.FieldByName('ENT_DESESP').AsFloat) * (fltBasAnT / fltTotAnt), -2);
                    ParamByName('VAFRAN').AsFloat := RoundTo((qryLeitura.FieldByName('ENT_TOTITE').AsFloat - qryLeitura.FieldByName('ENT_DESESP').AsFloat) * (fltAntIcT / fltTotAnt), -2);
                  End;
                End;
              End;
            End
            Else
            Begin
              ParamByName('BAFRAN').AsFloat := 0;
              ParamByName('VAFRAN').AsFloat := 0;
            End;

            fltBaFrAnRes := fltBaFrAnRes - ParamByName('BAFRAN').AsFloat;
            fltVaFrAnRes := fltVaFrAnRes - ParamByName('VAFRAN').AsFloat;
          End;

        End Else
        Begin
          ParamByName('BAFRAN').AsFloat := 0;
          ParamByName('VAFRAN').AsFloat := 0;
        End;

        ParamByName('AUTINC').AsString := qryLeitura.FieldByName('AUTOINCREM').AsString;

        ExecSQL;
        Close;
      End;

      qryLeitura.Next;

    End;

    FreeAndNil(qryGenMer);
    FreeAndNil(qryLeitura);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[pRateiaConhecimentoFrete]');
    End;
  End;

end;

function TFreConLista.fIncluiConFre(strSeqGer, strSeqFis: String; arrSeqPag: TArrAutInc): Boolean;
  Var
    qryConFre: TUniQuery;
    intContador: Integer;
Begin
  Try
    qryConFre := fCriaQuery(Self);

    If SameText(fEspecie, 'NF') Then
    Begin

      With qryConFre, SQL Do
      Begin
        Clear;
        Add('INSERT INTO CONFRE');
        Add('(CON_SEQGER, CON_SEQFIS)');
        Add('VALUES');
        Add('(:SEQGER, :SEQFIS)');

        ParamByName('SEQGER').AsString  := strSeqGer;
        ParamByName('SEQFIS').AsString  := strSeqFis;

        ExecSQL;
      End;

    End Else
    Begin

      With qryConFre, SQL Do
      Begin
        Clear;
        Add('INSERT INTO CONFRE ');
        Add('(CON_SEQGER, CON_SEQPAG)');
        Add('VALUES');
        Add('(:SEQGER, :SEQPAG)');

        For intContador := Low(arrSeqPag) To High(arrSeqPag) Do
        Begin
          Close;
          ParamByName('SEQGER').AsString  := strSeqGer;
          ParamByName('SEQPAG').AsString  := arrSeqPag[intContador];
          ExecSQL;
        End;

      End;

    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreConLista.fIncluiConFre]');
    End;
  End;

  FreeAndNil(qryConFre);
End;

function TFreConLista.fConfirmaFreConhecimento(strPorBai, strNomForm, strSeqGer: String; ArrCteMov: TArrCteMov = []; AstrHistoricoEntrada: String = ''; strClaFisEnt: String = ''): Boolean;
  Var
    intContador: Integer;
    objFreCon: TFreCon;
Begin
  Result := True;

  For intContador := 0 To arrFreCon.Count - 1 Do
  Begin
    objFreCon := TFreCon(arrFreCon.Items[intContador]);
    objFreCon.strCodOpe := FCodOpe;
    objFreCon.tpFrete := tpfEntrada;
    objFreCon.strClaFisEnt := strClaFisEnt;

    Result := objFreCon.fConfirmaFreConhecimento(objFreCon.blnImprCp,
                                                 IIF(fEmptyStr(objFreCon.strCodPor), strPorBai, objFreCon.strCodPor),
                                                 strNomForm,
                                                 fEspecie,
                                                 AstrHistoricoEntrada) And
              fIncluiConFre(strSeqGer, objFreCon.strAutFis, objFreCon.arrSeqPag);
    If intContador = 0 Then
     If Result And (High(ArrCteMov) > -1) Then
       pGravaValorMovDetReferenteFreteEntrada(objFreCon.strAutFis, ArrCteMov);
    If Not Result Then
      Break;
  End;






End;

Function TFreConLista.fIncsNotasEntrada: String;
  Var
    sltLista: TStringList;
Begin
  sltLista := TStringList.Create;
  {********************************************************
   * Quando não tem cdsNotEnt é porque não foi relacionada*
   * nenhuma nota de entrada com o CTE.                   *
   * então a função vai devolver Vazio("") para a chamada *
   *****************************************************WG*}
  If Not Assigned(cdsNotEnt) Then
  Begin
    Result := '""';
    Exit;
  End;

  With cdsNotEnt Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      sltLista.Add(QuotedStr(FieldByName('AUTINC').AsString));

      Next;
    End;

    EnableControls;
  End;

  Result := sltLista.CommaText;

  FreeAndNil(sltLista);
End;

Procedure TFreConLista.pCalculaTotaisPorNota;
  Var
    strSQL: String;
Begin
  strSQL := '/* untFreCon.pCalculaTotaisPorNota */ ';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   D.DET_SEQGER           AS GERINC, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(20)) AS ULTANT, ';
  strSQL := strSQL + '   COUNT(*)               AS NUMREC, ';
  strSQL := strSQL + '   0                      AS POSREC, ';

  strSQL := strSQL + '   SUM(IF(T.DET_ANTFRE = "S", D.DET_QTDITE, 0)) AS QTDANT, ';

  If FFreIpi Then
  Begin
    strSQL := strSQL + '   SUM(D.DET_VLRCON)                            AS VLRCON, ';
    strSQL := strSQL + '   SUM(IF(T.DET_ANTFRE = "S", D.DET_VLRCON, 0)) AS TOTANT, '
  End Else
  Begin
    strSQL := strSQL + '   SUM(D.DET_TOTITE - D.DET_DESESP)                            AS VLRCON, ';
    strSQL := strSQL + '   SUM(IF(T.DET_ANTFRE = "S", D.DET_TOTITE - D.DET_DESESP, 0)) AS TOTANT, ';
  End;

  strSQL := strSQL + '   SUM(D.DET_TOTITE)      AS TOTITE, ';
  strSQL := strSQL + '   SUM(DET_QTDITE) AS QTDITE, ';

  strSQL := strSQL + '   SUM(ITE_PESOIT * DET_QTDITE)                            AS PESITE, ';
  strSQL := strSQL + '   SUM(IF(T.DET_ANTFRE = "S", ITE_PESOIT * DET_QTDITE, 0)) AS PESITEANT ';

  strSQL := strSQL + fSQLFromNotas;

  strSQL := strSQL + ' GROUP BY D.DET_SEQGER';

  cdsTotNot.qryQuery.SQL.Text := strSQL;

  cdsTotNot.fAbreClient(True);
  cdsTotNot.IndexFieldNames := 'GERINC';
End;

Function TFreConLista.fSQLFromNotas(strChaves: string = ''): String;
Begin
  Result := '';
  Result := Result + ' FROM MOVTRI T';
  Result := Result + ' INNER JOIN MOVDET D ON D.AUTOINCREM = T.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADITE C ON D.DET_CODITE = C.ITE_CODITE ';
  Result := Result + ' INNER JOIN ITEGER I ON D.DET_CODITE = I.ITE_CODITE AND D.DET_CODEMP = I.ITE_CODEMP ';
  Result := Result + ' LEFT JOIN MOVICD V ON ICD_SEQGER = D.AUTOINCREM ';
  Result := Result + 'WHERE ';
  If fEmptyStr(strChaves) Then
    Result := Result + '  D.DET_SEQGER IN (' + fIncsNotasEntrada + ') '
  Else
    Result := Result + '  D.DET_SEQGER IN (' + strChaves + ') ';End;

Function TFreConLista.fSQLMovTri(strChaves: string = ''): String;
Begin
  Result := '/* untFreCon.fSQLMovTri */ ';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   D.AUTOINCREM AS DET_AUTINC, ';

  Result := Result + '   D.DET_SEQGER AS GERINC, ';
  Result := Result + '   D.DET_CODFOR, ';
  Result := Result + '   D.DET_DTAENT, ';
  Result := Result + '   D.DET_CODITE, ';
  Result := Result + '   D.DET_CODEMP, ';
  Result := Result + '   D.DET_NUMDOC, ';
  Result := Result + '   D.DET_ESPDOC, ';
  Result := Result + '   D.DET_SERIE_, ';
  Result := Result + '   D.DET_ORIDOC, ';
  Result := Result + '   D.DET_INCPIS, ';

  Result := Result + '   D.DET_NUMLOT, ';

  Result := Result + '   D.DET_TOTITE, ';

  If FFreIpi Then
  Begin
    Result := Result + '   D.DET_VLRCON                            AS VLRCON, ';
    Result := Result + '   IF(T.DET_ANTFRE = "S", D.DET_VLRCON, 0) AS TOTANT, '
  End Else
  Begin
    Result := Result + '   D.DET_TOTITE - D.DET_DESESP                            AS VLRCON, ';
    Result := Result + '   IF(T.DET_ANTFRE = "S", D.DET_TOTITE - D.DET_DESESP, 0) AS TOTANT, ';
  End;

  Result := Result + '   D.DET_VALICM, ';
  Result := Result + '   IFNULL(T.DET_SISCOM, 0) AS DET_SISCOM, ';
  Result := Result + '   D.DET_VALIPI, ';
  Result := Result + '   D.DET_VALRET, ';
  Result := Result + '   D.DET_TOTFRE, ';
  Result := Result + '   D.DET_DESACE, ';
  Result := Result + '   D.DET_DESESP, ';
  Result := Result + '   D.DET_QTDITE, ';
  Result := Result + '   (SELECT  SUM(D2.DET_QTDITE) FROM MOVDET D2 WHERE D2.DET_CODITE = D.DET_CODITE AND D2.DET_SEQGER = D.DET_SEQGER) QTDTOT, ';
  Result := Result + '   D.DET_QTDITE AS QTDITE, ';
  Result := Result + '   IF(T.DET_ANTFRE = "S", D.DET_QTDITE, 0) AS QTDANT, ';



  Result := Result + '   T.DET_SEQGER AS TRIINC, ';
  Result := Result + '   T.DET_RPAFRE, ';

  Result := Result + '   D.DET_CODFIS, ';
  Result := Result + '   D.DET_CLAFIS, ';
  Result := Result + '   D.DET_TOTMED, ';
  Result := Result + '   ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 4) AS DET_UNITAR, ';
  Result := Result + '   D.DET_ALQICM, ';
  Result := Result + '   D.DET_PERBAS, ';

  Result := Result + '   C.ITE_INCPIS, ';
  Result := Result + '   I.ITE_PRECOM, ';
  Result := Result + '   I.ITE_SALDOS, ';

  Result := Result + '   T.DET_TOTULT, ';
  Result := Result + '   T.DET_ALQPIS, ';
  Result := Result + '   T.DET_ALQCOF, ';
  Result := Result + '   T.DET_VAEIPI, ';
  Result := Result + '   T.DET_VAERET, ';
  Result := Result + '   T.DET_OUTDES, ';
  Result := Result + '   T.DET_VENDOR, ';
  Result := Result + '   T.DET_ICMANT, ';
  Result := Result + '   T.DET_VLGNRE, ';
  Result := Result + '   T.DET_VALTCI, ';
  Result := Result + '   T.DET_VAL_TS, ';
  Result := Result + '   IFNULL((SELECT SUM(MOV_CONFRE) FROM CTEMOV WHERE MOV_MOVDET = D.AUTOINCREM), 0) AS ANT_CONFRE, ';
  Result := Result + '   T.DET_ANTFRE, ';
  Result := Result + '   T.DET_VFCPST, ';
  Result := Result + '   IFNULL(V.ICD_PERFCP, 0) AS ICD_PERFCP, ';
  Result := Result + '   IFNULL(V.ICD_VALFCP, 0) AS ICD_VALFCP, ';


  Result := Result + '   IFNULL(T.DET_CFRETE, 0) AS DET_CFRETE, ';
  Result := Result + '   IFNULL(T.DET_CFRECO, 0) AS DET_CFRECO, ';

  Result := Result + '   IFNULL(T.DET_ICMNCR, 0) AS DET_ICMNCR, ';
  Result := Result + '   IFNULL(T.DET_FCPNCR, 0) AS DET_FCPNCR, ';

  Result := Result + '   I.ITE_VALFRE, ';

  Result := Result + '     ITE_RPRENT, ';
  Result := Result + '   DET_ALQFRE, ';

  Result := Result + '   ITE_PESOIT * DET_QTDITE AS PESITE, ';
  Result := Result + '   IF(T.DET_ANTFRE = "S", ITE_PESOIT * DET_QTDITE, 0) AS PESITEANT ';

  Result := Result + fSQLFromNotas(strChaves);
End;

Function TFreConLista.fRetFreteRateio(var fltAlqIcmFrete: Double): Double;
Begin
  Result := RoundTo(fltValFre, -2);
  fltAlqIcmFrete := ((fltValIcm / fltValFre) * 100)
End;

Procedure TFreConLista.pRateiaFreteRepresentatividade;
  Var
    fltTotFre,
    fltBasAntTot,
    fltIcmAntTot,
    fltTotRes,
    fltBasAntRes,
    fltIcmAntRes: Double;
    intContador: Integer;
    fltAlqIcmFrete: Double;
Begin
  fltTotFre    := fRetFreteRateio(fltAlqIcmFrete);
  fltBasAntTot := fltBasAnt;
  fltIcmAntTot := fltAntIcT;

  fltTotRes    := fltTotFre;
  fltBasAntRes := fltBasAnt;
  fltIcmAntRes := fltAntIcT;

  If Not Assigned(cdsNotEnt) Then
    Exit;
  cdsNotEnt.First;

  intContador := 0;

  While Not cdsNotEnt.Eof Do
  Begin
    Inc(intContador);

    cdsNotEnt.Edit;

    If intContador = cdsNotEnt.RecordCount Then
    Begin
      cdsNotEnt.FieldByName('TOTFRE').AsFloat := fltTotRes;
      cdsNotEnt.FieldByName('BASANT').AsFloat := fltBasAntRes;
      cdsNotEnt.FieldByName('ICMANT').AsFloat := fltIcmAntRes;
    End Else
    Begin
      cdsNotEnt.FieldByName('TOTFRE').AsFloat := RoundTo(fltTotFre    * cdsNotEnt.FieldByName('PERREP').AsFloat / 100, -2);
      cdsNotEnt.FieldByName('BASANT').AsFloat := RoundTo(fltBasAntTot * cdsNotEnt.FieldByName('PERREP').AsFloat / 100, -2);
      cdsNotEnt.FieldByName('ICMANT').AsFloat := RoundTo(fltIcmAntTot * cdsNotEnt.FieldByName('PERREP').AsFloat / 100, -2);
    End;

    cdsNotEnt.FieldByName('FRERES').AsFloat := cdsNotEnt.FieldByName('TOTFRE').AsFloat;
    cdsNotEnt.FieldByName('BASRES').AsFloat := cdsNotEnt.FieldByName('BASANT').AsFloat;
    cdsNotEnt.FieldByName('ICMRES').AsFloat := cdsNotEnt.FieldByName('ICMANT').AsFloat;

    cdsNotEnt.Post;

    fltTotRes    := fltTotRes    - cdsNotEnt.FieldByName('TOTFRE').AsFloat;
    fltBasAntRes := fltBasAntRes - cdsNotEnt.FieldByName('BASANT').AsFloat;
    fltIcmAntRes := fltIcmAntRes - cdsNotEnt.FieldByName('ICMANT').AsFloat;

    If fltTotRes < 0 Then
      fltTotRes := 0;

    If fltBasAntRes < 0 Then
      fltBasAntRes := 0;

    If fltIcmAntRes < 0 Then
      fltIcmAntRes := 0;

    cdsNotEnt.Next;
  End;

End;

Procedure TFreConLista.pCalculaUltAntRepresentatividade(cdsMovTri: TZClient);
Begin
  With cdsMovTri Do
  Begin

    cdsTotNot.First;

    While Not cdsTotNot.Eof Do
    Begin
      Filter   := 'GERINC = ' + QuotedStr(cdsTotNot.FieldByName('GERINC').AsString);
      Filtered :=  True;

      Last;
      While Not Bof Do
      Begin

        If FieldByName('DET_ANTFRE').AsString = 'S' Then
        Begin
          cdsTotNot.Edit;
          cdsTotNot.FieldByName('ULTANT').AsString := FieldByName('TRIINC').AsString;
          cdsTotNot.Post;
          Break;
        End;

        Prior;
      End;

      cdsTotNot.Next;
    End; {While cdsTotNot.Eof Do}

    Filtered :=  False;
  End;
End;


function TFreConLista.fAtualizaUltimaCompra(blnForFil: Boolean): Boolean;
begin
  Result := False;
  If Not blnForFil Then
    Exit(True);
  If blnForFil and blnAtuUlt then
    Exit(True);
End;

function TFreConLista.fAtualizaPrecomedio(blnForFil: Boolean): Boolean;
begin
  Result := False;
  If Not blnForFil Then
    Exit(True);
  If blnForFil and blnAtuMed then
    Exit(True);
End;

function TFreConLista.fAtualizaComposicaoPreco(blnForFil: Boolean): Boolean;
begin
  Result := False;
  If Not blnForFil Then
    Exit(True);
  If blnForFil And blnAtpRen then
    Exit(True);
end;

Function TFreConLista.fRateiaConhecimentoFreteNotas(fltOutDes, fltValRpa: Double; strChaves: string = ''; strCadFis: String = ''): Boolean;
  Var
    cdsMovTri: TZClient;
    intNumReg: Integer;
    fltFreRes,
    fltTotIte,
    fltTotAnt,
    fltConFre,
    fltBasAntIte,
    fltIcmAntIte,
    fltBasAntTot,
    fltIcmAntTot,
    fltBasAntRes,
    fltIcmAntRes,

    fltOutDesIte,
    fltOutDesRes,
    fltValRpaIte,
    fltValRpaRes,

    fltSaldosAnt,
    fltImpUlt,
    fltPreMedAnt,
    fltPreMed,
    fltFreteCalc,
    fltFreConCalc,

    fltPercentualTotAnt,
    fltQtdTot,
    fltQtdTotAnt,
    fltAlqIcmFrete,
    fltOutDesPre: Double;
    blnGravaPreMed,
    blnTemLote,
    blnDedIcm,
    blnUltPis,
    blnAtuFre,
    blnForFilial,
    blnAtualizaPrecoMedio,
    blnAtualizaUltimaCompra,
    blnAtualizaComposicaoPreco: Boolean;
    strAtuNmd,
    strCodFor: string;
    blnNotaImp: Boolean;

    strUltAutDetComPercentual,
    strAutUltAnt: String;

    fltIcmMed,
    fltFreRat,
    fltPesTot,
    fltPesTotAnt: Double;

    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;

    objImpUlt: TCalculoUltimaCompraImpostos;
    blnZeraIPI: Boolean;

    Function fGetTotIte: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('TOTITE').AsFloat
      Else
        Result := fltTotIte;
    End;

    Function fGetVlrCon: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('VLRCON').AsFloat
      Else
        Result := fltVlrCon;
    End;

    Function fGetTotAnt: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('TOTANT').AsFloat
      Else
        Result := fltTotAnt;
    End;

    Function fGetPesTot: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('PESITE').AsFloat
      Else
        Result := fltPesTot;
    End;

    Function fGetQtdTot: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('QTDITE').AsFloat
      Else
        Result := fltQtdTot;
    End;

    Function fGetQtdTotAnt: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('QTDANT').AsFloat
      Else
        Result := fltQtdTotAnt;
    End;

    Function fGetPesTotAnt: Double;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('PESITEANT').AsFloat
      Else
        Result := fltPesTotAnt;
    End;

    Function fGetFreRat: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('TOTFRE').AsFloat
      Else
        Result := fltFreRat;
    End;

    Function fGetFreRes: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('FRERES').AsFloat
      Else
        Result := fltFreRes;
    End;

    Function fGetBasAntRes: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('BASRES').AsFloat
      Else
        Result := fltBasAntRes;
    End;

    Function fGetIcmAntRes: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('ICMRES').AsFloat
      Else
        Result := fltIcmAntRes;
    End;

    Function fGetBasAntTot: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('BASANT').AsFloat
      Else
        Result := fltBasAntTot;
    End;

    Function fGetIcmAntTot: Double;
    Begin
      If blnPerRep Then
        Result := cdsNotEnt.FieldByName('ICMANT').AsFloat
      Else
        Result := fltIcmAntTot;
    End;

    Function fGetAutUltAnt: String;
    Begin
      If blnPerRep Then
        Result := cdsTotNot.FieldByName('ULTANT').AsString
      Else
        Result := strAutUltAnt;
    End;

    Procedure pAtualizaFreRes(fltConFre: Double);
    Begin
      If blnPerRep Then
      Begin
        cdsNotEnt.Edit;
        cdsNotEnt.FieldByName('FRERES').AsFloat :=  RoundTo(cdsNotEnt.FieldByName('FRERES').AsFloat - fltConFre, -2);
        cdsNotEnt.Post;
      End Else
      Begin
        fltFreRes := RoundTo(fltFreRes - fltConFre, -2);
      End;
    End;

    Procedure pAtualizaBasAntFreRes(fltBasAntIte: Double);
    Begin
      If blnPerRep Then
      Begin
        cdsNotEnt.Edit;
        cdsNotEnt.FieldByName('BASRES').AsFloat :=  RoundTo(cdsNotEnt.FieldByName('BASRES').AsFloat - fltBasAntIte, -2);
        cdsNotEnt.Post;
      End Else
      Begin
        fltBasAntRes := fltBasAntRes - fltBasAntIte;
      End;
    End;

    Procedure pAtualizaIcmAntFreRes(fltIcmAntIte: Double);
    Begin
      If blnPerRep Then
      Begin
        cdsNotEnt.Edit;
        cdsNotEnt.FieldByName('ICMRES').AsFloat :=  RoundTo(cdsNotEnt.FieldByName('ICMRES').AsFloat - fltIcmAntIte, -2);
        cdsNotEnt.Post;
      End Else
      Begin
        fltIcmAntRes := fltIcmAntRes - fltIcmAntIte;
      End;
    End;

    Procedure pIncNumReg;
    Begin
      If blnPerRep Then
      Begin
        cdsTotNot.Edit;
        cdsTotNot.FieldByName('POSREC').AsInteger := cdsTotNot.FieldByName('POSREC').AsInteger + 1;
        cdsTotNot.Post;
      End Else
      Begin
        inc(intNumReg);
      End;
    End;

    Function fRecordCount: Integer;
    Begin
      If blnPerRep Then
      Begin
        Result := cdsTotNot.FieldByName('NUMREC').AsInteger;
      End Else
      Begin
        Result := cdsMovTri.RecordCount;
      End;
    End;

    Function fNumReg: Integer;
    Begin
      If blnPerRep Then
      Begin
        Result := cdsTotNot.FieldByName('POSREC').AsInteger;
      End Else
      Begin
        Result := intNumReg;
      End;
    End;

    Function fUltimoRegistroComFreteInformarPercentuais: String;
    Begin
      Result := '';

      cdsMovTri.Last;

      While Not cdsMovTri.Bof Do
      Begin
        If cdsRateioProdutos.FindKey([cdsMovTri.FieldByName('DET_AUTINC').AsString]) And
           (cdsRateioProdutos.FieldByName('PERFRE').AsFloat > 0)  Then
        Begin
          Result := cdsMovTri.FieldByName('DET_AUTINC').AsString;
          Exit;
        End;

        cdsMovTri.Prior;
      End;

      cdsMovTri.First;
    End;

    Function fEhUltimoRegistro: Boolean;
    Begin
      If tipRatFrete = trfInformarPercentuais Then
        Result := strUltAutDetComPercentual = cdsMovTri.FieldByName('DET_AUTINC').AsString
      Else
        Result := fNumReg = fRecordCount
    End;

    Function fSomaPercentualAntecipado: Double;
    Begin
      Result := 0;

      cdsMovTri.First;

      While Not cdsMovTri.Eof Do
      Begin
        If (cdsMovTri.FieldByName('DET_ANTFRE').AsString = 'S') And
            cdsRateioProdutos.FindKey([cdsMovTri.FieldByName('DET_AUTINC').AsString]) Then
          Result := Result + cdsRateioProdutos.FieldByName('PERFRE').AsFloat;

        cdsMovTri.Next;
      End;

      cdsMovTri.First;
    End;

begin
  Result := False;
  blntemlote := False;

  {Condição adicionada pois a alteração feita no revisao. 233600
  estava gerando o erro ao Incluir um conhecimento de frete.
  o sistema carrega neste DataSet os Itens de Rateio portanto não
  pode aplicar o FreeAndNil sem verificar se ha informação no cdsRateioProdutos}
  If cdsRateioProdutos.RecordCount = 0 Then
  Begin
    If Assigned(cdsRateioProdutos) Then
      FreeAndNil(cdsRateioProdutos);

    TFreCon.fCriaCdsRateioProdutos(cdsRateioProdutos, strChaves);
  End;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;

  Try
    If blnPerRep Then
    Begin
      pRateiaFreteRepresentatividade;
      pCalculaTotaisPorNota;
    End;

    blnAtuFre := fCfgSis('ATUFRE', varBoolean) And fCfgSis('ATPRAU', varBoolean);

    strAtuNmd := fCfgSis('ATUNMD');

    strCodFor := '';

    If Assigned(objIteAnt) Then
      objIteAnt.pSalvaAntFre;

    cdsMovTri := TZClient.Create(Self, fSQLMovTri(strChaves));

    With cdsMovTri Do
    Begin
      pCriaSoma('DET_TOTITE');
      pCriaSoma('VLRCON');
      pCriaSoma('TOTANT');
      pCriaSoma('PESITE');
      pCriaSoma('QTDITE');
      pCriaSoma('QTDANT');
      pCriaSoma('PESITEANT');

      fltPercentualTotAnt := 0;

      If fAbreClient(True, 'TFreCon.pRateiaConhecimentoFreteNotas') Then
      Begin
        IndexFieldNames := 'DET_CODITE;DET_DTAENT';

        If tipRatFrete = trfInformarPercentuais Then
        Begin
          cdsRateioProdutos.IndexFieldNames := 'AUTDET';

          strUltAutDetComPercentual := fUltimoRegistroComFreteInformarPercentuais;

          fltPercentualTotAnt := fSomaPercentualAntecipado;
        End;

        Result := True;

        fltOutDesRes := fltOutDes;
        fltValRpaRes := fltValRpa;

        intNumReg := RecordCount;

        If blnPerRep Then
        Begin
          pCalculaUltAntRepresentatividade(cdsMovTri);
        End Else
        Begin
          strAutUltAnt := '';
          Last;
          While intNumReg > 0 Do
          Begin

            If FieldByName('DET_ANTFRE').AsString = 'S' Then
            Begin
              strAutUltAnt := FieldByName('TRIINC').AsString;
              Break;
            End;

            Dec(intNumReg);
            Prior;
          End;
        End;

        intNumReg := 0;
        First;

        fltTotIte    := RoundTo(fRetSoma('SUM_DET_TOTITE'), -2);
        fltVlrCon    := RoundTo(fRetSoma('SUM_VLRCON'), -2);
        fltTotAnt    := fRetSoma('SUM_TOTANT');
        fltPesTot    := fRetSoma('SUM_PESITE');
        fltPesTotAnt := fRetSoma('SUM_PESITEANT');
        fltQtdTot    := fRetSoma('SUM_QTDITE');
        fltQtdTotAnt := fRetSoma('SUM_QTDANT');

        fltFreRat    := fRetFreteRateio(fltAlqIcmFrete);
        fltBasAntTot := fltBasAnt;
        fltIcmAntTot := fltAntIcT;

        fltFreRes    := fltFreRat;
        fltBasAntRes := fltBasAntTot;
        fltIcmAntRes := fltIcmAntTot;

        While Not Eof Do
        Begin
          strCodFor := FieldByName('DET_CODFOR').AsString;
          blnForFilial := (Pos(strCodFor, strForFil) > 0);

          blnAtualizaPrecoMedio := fAtualizaPrecoMedio(blnForFilial);
          blnAtualizaUltimaCompra := fAtualizaUltimaCompra(blnForFilial);
          blnAtualizaComposicaoPreco := fAtualizaComposicaoPreco(blnForFilial);

          If blnPerRep Then
          Begin
            If (Not cdsTotNot.FindKey([FieldByName('GERINC').AsString])) Or
               (Not cdsNotEnt.Locate('AUTINC', FieldByName('GERINC').AsString, [])) Then
             pRaise('Erro interno - Nota não econtrada!');
          End;

          If (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0) Then
            blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, FieldByName('DET_CODFOR').AsString)
          Else
            blnUltPis := fCfgSis('ULTPIS', VarBoolean);

          If (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0) Then
            blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, FieldByName('DET_CODFOR').AsString)
          Else
            blnDedIcm := fCfgSis('DEDICM', VarBoolean);

          pIncNumReg;

          If fEhUltimoRegistro Then
          Begin

            fltConFre    := fGetFreRes;
            fltOutDesIte := fltOutDesRes;
            fltVAlRpaIte := fltValRpaRes;

          End Else
          Begin

            If fGetVlrCon > 0 Then
            Begin

              case tipRatFrete of
                trfPropPesoItem: Begin
                                   If fGetPesTot > 0 Then
                                     fltConFre    := RoundTo(FieldByName('PESITE').AsFloat * (fGetFreRat / fGetPesTot), -2)
                                   Else
                                     fltConFre    := 0;
                                 End;

                trfPropQtdItem : Begin
                                   fltConFre    := RoundTo(FieldByName('QTDITE').AsFloat * (fGetFreRat / fGetQtdTot), -2);
                                 End;

               trfInformarPercentuais: If cdsRateioProdutos.FindKey([FieldByName('DET_AUTINC').AsString]) Then
                                       Begin
                                         fltConFre := RoundTo(fGetFreRat * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / 100 , -2)
                                       End Else
                                       Begin
                                         fltConFre := 0;
                                         Result := False;
                                         pRaise('Erro interno - Produto não econtrado - Chave: ' + FieldByName('DET_AUTINC').AsString + '!');
                                       End;


                Else
                  fltConFre    := RoundTo(FieldByName('VLRCON').AsFloat * (fGetFreRat / fGetVlrCon), -2);
              End;

              If fltConFre > fGetFreRes Then
                fltConFre := fGetFreRes;

              fltOutDesIte := RoundTo(FieldByName('DET_TOTITE').AsFloat * (fltOutDes / fGetTotIte), -2);
              fltValRpaIte := RoundTo(FieldByName('DET_TOTITE').AsFloat * (fltValRpa / fGetTotIte), -2);

              If fltOutDesIte > fltOutDesRes Then
                fltOutDesIte := fltOutDesRes;

              If fltValRpaIte > fltValRpaRes Then
                fltValRpaIte := fltValRpaRes;
            End Else
            Begin

              fltConFre    := 0;
              fltOutDesIte := 0;
              fltValRpaIte := 0;

            End;

            pAtualizaFreRes(fltConFre);

            fltOutDesRes := RoundTo(fltOutDesRes - fltOutDesIte, -2);

          End;

          If FieldByName('DET_ANTFRE').AsString = 'S' Then
          Begin

            If FieldByName('TRIINC').AsString = fGetAutUltAnt Then
            Begin

              fltBasAntIte := fltBasAntRes;
              fltIcmAntIte := fltIcmAntRes;

            End Else
            Begin

              If fGetTotIte > 0 Then
              Begin

                case tipRatFrete of
                  trfPropPesoItem: Begin
                                     If fGetPesTotAnt > 0 Then
                                     Begin
                                       fltBasAntIte := RoundTo(FieldByName('PESITE').AsFloat * (fGetBasAntTot / fGetPesTotAnt), -2);
                                       fltIcmAntIte := RoundTo(FieldByName('PESITE').AsFloat * (fGetIcmAntTot / fGetPesTotAnt), -2);
                                     End Else
                                     Begin
                                       fltBasAntIte := 0;
                                       fltIcmAntIte := 0;
                                     End;
                                   End;

                  trfPropQtdItem : Begin
                                     fltBasAntIte := RoundTo(FieldByName('QTDITE').AsFloat * (fGetBasAntTot / fGetQtdTotAnt), -2);
                                     fltIcmAntIte := RoundTo(FieldByName('QTDITE').AsFloat * (fGetIcmAntTot / fGetQtdTotAnt), -2);
                                   End;

                 trfInformarPercentuais: If (fltPercentualTotAnt > 0) And cdsRateioProdutos.FindKey([FieldByName('DET_AUTINC').AsString]) Then
                                         Begin
                                           fltBasAntIte := RoundTo(fGetBasAntTot * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / fltPercentualTotAnt, -2);
                                           fltIcmAntIte := RoundTo(fGetIcmAntTot * cdsRateioProdutos.FieldByName('PERFRE').AsFloat / fltPercentualTotAnt, -2);
                                         End Else
                                         Begin
                                           fltBasAntIte := 0;
                                           fltIcmAntIte := 0;
                                         End;

                  Else
                  Begin
                    fltBasAntIte := RoundTo(FieldByName('VLRCON').AsFloat * (fGetBasAntTot / fGetTotAnt), -2);
                    fltIcmAntIte := RoundTo(FieldByName('VLRCON').AsFloat * (fGetIcmAntTot / fGetTotAnt), -2);
                  End;
                End;


              End Else
              Begin

                fltBasAntIte := 0;
                fltIcmAntIte := 0;

              End;

              pAtualizaBasAntFreRes(fltBasAntIte);
              pAtualizaIcmAntFreRes(fltIcmAntIte);

            End;

          End Else
          Begin

            fltBasAntIte := 0;
            fltIcmAntIte := 0;

          End;

          If strCadFis <> '' Then
          Begin
            pCarregaCTEMOV(cdsMovTri.FieldByName('DET_AUTINC').AsString);
            pGravaValorMovDetReferenteFrete(FieldByName('DET_AUTINC').AsString, strCadFis,fltConFre, fltAlqIcmFrete);
          End;

          If fltOutDesIte > 0 Then
            fltOutDesPre := fltOutDesIte
          Else
            fltOutDesPre := FieldByName('DET_OUTDES').AsFloat;

          objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt
            .TotalItem(cdsMovTri.FieldByName('DET_TOTITE').AsFloat)
            .DescontoEspecial(cdsMovTri.FieldByName('DET_DESESP').AsFloat);

          If blnUltPis Then
          Begin
            objImpUlt.AliquotaPis(cdsMovTri.FieldByName('DET_ALQPIS').AsFloat).AliquotaCofins(cdsMovTri.FieldByName('DET_ALQCOF').AsFloat);
          End
          Else
          Begin
            objImpUlt.AliquotaPis(0).AliquotaCofins(0);
          End;

          blnZeraIPI := fZeraIPI(cdsMovTri.FieldByName('DET_CODITE').AsString);
          objImpUlt.blnUltPis := blnUltPis;
          blnNotaImp := Copy(FieldByName('DET_CLAFIS').AsString, 1 , 1) = '3';
          objImpUlt
            .ValorIpi(IIf(blnZeraIPI, 0, cdsMovTri.FieldByName('DET_VALIPI').AsFloat))
            .ValorIpiNaoCreditado(IIf(blnZeraIPI, 0, cdsMovTri.FieldByName('DET_VAEIPI').AsFloat))

            .Frete(cdsMovTri.FieldByName('DET_TOTFRE').AsFloat)
            .ConhecimentoFrete(fltConFre + cdsMovTri.FieldByName('ANT_CONFRE').AsFloat)
            .AliquotaICMSdoFrete(fltAlqIcmFrete)

            .fRecebimentoPagamentoAutonomoFrete(fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat)
            .OutrasDespesas(fltOutDesPre)
            .Vendor(cdsMovTri.FieldByName('DET_VENDOR').AsFloat)
            .DespesaAcessoria(cdsMovTri.FieldByName('DET_DESACE').AsFloat)

            .ValorIcms(IIF(blnDedIcm and (not blnNotaImp), cdsMovTri.FieldByName('DET_VALICM').AsFloat + cdsMovTri.FieldByName('ICD_VALFCP').AsFloat, 0))

            .ValorIcmsNaoCreditado(IIF(blnDedIcm and (not blnNotaImp), IIF((cdsMovTri.FieldByName('DET_VALICM').AsFloat + cdsMovTri.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                                      0,
                                                      cdsMovTri.FieldByName('DET_ICMNCR').AsFloat) + cdsMovTri.FieldByName('DET_FCPNCR').AsFloat, 0))

            .ValorIcmsAntecipado(cdsMovTri.FieldByName('DET_ICMANT').AsFloat + fltIcmAntIte)
            .ValorIcmsAntecipadoFrete(0)
            .ValorGNRE(cdsMovTri.FieldByName('DET_VLGNRE').AsFloat)
            .ValorTCIF(cdsMovTri.FieldByName('DET_VALTCI').AsFloat)
            .ValorTS(cdsMovTri.FieldByName('DET_VAL_TS').AsFloat)
            .ValorRetido(cdsMovTri.FieldByName('DET_VALRET').AsFloat)
            .ValorRetidoNaoCreditado(cdsMovTri.FieldByName('DET_VAERET').AsFloat)
            .ValorFundoCombateAPobreza(cdsMovTri.FieldByName('DET_VFCPST').AsFloat)
            .FornecedorFilial(blnForFilial)
            .ItemIncidePis(cdsMovTri.FieldByName('DET_INCPIS').AsString)
            .ValorSiscomex(IIf(blnNotaImp, FieldByName('DET_SISCOM').AsFloat, 0))
            .ValorIcmsNotaImportacao(IIf(blnNotaImp, FieldByName('DET_VALICM').AsFloat, 0));

          fltImpUlt := objImpUlt.fUnitario(cdsMovTri.FieldByName('DET_QTDITE').AsFloat);

          fltFreteCalc := fFormataFloat(objImpUlt.ValorFreteCalculado, 4);
          fltFreConCalc := fFormataFloat(objImpUlt.ValorConhecimentoCalculado, 4);

          FreeAndNil(objImpUlt);

          pUpdateMovtri(FieldByName('TRIINC').AsString, fltConFre + FieldByName('ANT_CONFRE').AsFloat, fltBasAntIte, fltIcmAntIte,
                        fltOutDesIte, (fltImpUlt * FieldByName('DET_QTDITE').AsFloat),
                        fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat, fltAlqIcmFrete, fltFreteCalc, fltFreConCalc);

          If strMedEmp = '1' Then
            fltSaldosAnt := fSaldoEmpresas(FieldByName('DET_CODITE').AsString, strEmpMeds)
          Else
            fltSaldosAnt := FieldByName('ITE_SALDOS').AsFloat;

          fltSaldosAnt := fltSaldosAnt - cdsMovTri.FieldByName('QTDTOT').AsFloat;

          If (CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('DET_CODITE').AsString, FieldByName('GERINC').AsString].blnEncontrado) Then
            fltSaldosAnt := CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('DET_CODITE').AsString, FieldByName('GERINC').AsString].SaldoAnterior;

          fltPreMedAnt := FieldByName('DET_TOTMED').AsFloat / FieldByName('DET_QTDITE').AsFloat;

          {*************************************************************}
          {* CONFIGURAÇÃO QUE PERMITE UTILIZAR O ÚLTIMO PRECO DE       *}
          {* COMPRA PARA FORMAÇÃO DO PRECO MÉDIO DO PRODUTO            *}
          {**************************** 22/07/09**************** AM ****}
          fltPreMed := 0.00;

          If (Pos(FieldByName('DET_CODFOR').AsString, strForFil) <= 0) OR ((Pos(strCodFor, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
            fltIcmMed := IIF((Pos(FieldByName('DET_CODFIS').AsString, CST_REDUCAO) > 0) ,
                                              fFormataFloat((FieldByName('DET_ALQICM').AsFloat * FieldByName('DET_PERBAS').AsFloat) / 100, 2),
                                               FieldByName('DET_ALQICM').AsFloat + FieldByName('ICD_PERFCP').AsFloat)
          Else
            fltIcmMed := 0;

          CalculoPrecoMediAgrup.strCodIteAtual :=  FieldByName('DET_CODITE').AsString;
          CalculoPrecoMediAgrup.strSeqGerAtual :=  FieldByName('GERINC').AsString;

          If (fCfgSis('BASMED') <> 'S') And (FieldByName('DET_ORIDOC').AsString <> 'D') Then
            fltPreMed := fCalculaPrecoMedio( FieldByName('DET_CODFIS').AsString,               // Código Fiscal
                                             FieldByName('DET_CLAFIS').AsString,        // ClassificacaoFiscal
                                             fltPreMedAnt,                                     // Preço medio anterior
                                             fltSaldosAnt,                                     // Saldo anterior
                                             FieldByName('DET_QTDITE').AsFloat,                // Quantidade de entrada
                                             FieldByName('DET_UNITAR').AsFloat,                // Unitario sem impostos

                                             fltIcmMed,                // Aliquota de ICMS do Item

                                             FieldByName('DET_VALIPI').AsFloat +
                                             FieldByName('DET_VAEIPI').AsFloat,                // Valor do IPI

                                             FieldByName('DET_VALRET').AsFloat +
                                             FieldByName('DET_VAERET').AsFloat,               // Valor de Substituição

                                             FieldByName('DET_ICMANT').AsFloat + fltIcmAntIte, // Valor ICMS Antecipado

                                             FieldByName('DET_VLGNRE').AsFloat,
                                             FieldByName('DET_VALTCI').AsFloat,
                                             FieldByName('DET_VAL_TS').AsFloat,

                                             fCfgSis('CONIPI', varBoolean),                    // Contribuinte de IPI?
                                             (Pos(FieldByName('DET_CODFOR').AsString, strForFil) > 0), // Fornec Filial
                                             FieldByName('ITE_INCPIS').AsString,               // Indice se incide Pis
                                             FieldByName('DET_TOTFRE').AsFloat +               // VALOR DO FRETE
                                             fltConFre + fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat +  FieldByName('ANT_CONFRE').AsFloat,
                                             FieldByName('DET_DESACE').AsFloat +
                                             FieldByName('DET_VENDOR').AsFloat +
                                             fltOutDesPre,
 
                                             FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat,

                                             IIF((FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat) > 0, 0, FieldByName('DET_ICMNCR').AsFloat + FieldByName('DET_FCPNCR').AsFloat),

                                             FieldByName('DET_VFCPST').AsFloat,
                                             fltAlqIcmFrete,
                                             CalculoPrecoMediAgrup,
                                             FieldByName('DET_VAEIPI').AsFloat > 0);

          If (FieldByName('DET_ORIDOC').AsString <> 'D') And blnAtualizaComposicaoPreco Then
          Begin
            If (strAtuNmd = 'I') Then
              blnTemLote := fUpdateLotePrecos(fltConFre + fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat, cdsMovTri, fltImpUlt)
            Else If (strAtuNmd = 'M') And (fCfgSis('BASMED') <> 'S') And (FieldByName('DET_ORIDOC').AsString <> 'D') Then
              blnTemLote := fUpdateLotePrecos(fltConFre +  fltValRpaIte +  cdsMovTri.FieldByName('DET_RPAFRE').AsFloat, cdsMovTri, fltPreMed)
            Else
              blnTemLote := fUpdateLotePrecos(fltConFre +  fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat, cdsMovTri);
          end;


          If (Pos(FieldByName('DET_CLAFIS').AsString, '1922_2922_') <= 0) And (FieldByName('DET_ORIDOC').AsString <> 'D') Then
          Begin
            pUpdateCadIte(FieldByName('DET_CODITE').AsString,
                          FieldByName('DET_CODFOR').AsString,
                          fCodificaChaveNota(FieldByName('DET_NUMDOC').AsString,
                                             FieldByName('DET_ESPDOC').AsString,
                                             FieldByName('DET_CODEMP').AsString,
                                             FieldByName('DET_SERIE_').AsString,
                                             FieldByName('DET_CODFOR').AsString),
                          fltImpUlt,
                          fltPreMed,
                          blnAtualizaUltimaCompra,
                          blnAtualizaPrecoMedio,
                          blnGravaPreMed);

            If blnAtualizaUltimaCompra Then
              pAtualizaUltimaCompraCadLot(FieldByName('DET_CODITE').AsString,
                                          FieldByName('DET_NUMLOT').AsString,
                                          FieldByName('DET_CODFOR').AsString,
                                          fCodificaChaveNota(FieldByName('DET_NUMDOC').AsString,
                                                             FieldByName('DET_ESPDOC').AsString,
                                                             FieldByName('DET_CODEMP').AsString,
                                                             FieldByName('DET_SERIE_').AsString,
                                                             FieldByName('DET_CODFOR').AsString),
                                          FieldByName('DET_CODEMP').AsString,
                                          fFormataFloat(FieldByName('DET_TOTULT').AsFloat / FieldByName('DET_QTDITE').AsFloat, 4),
                                          fltImpUlt,
                                          VS_Date,
                                          True);

            If (fltPreMed > 0) and blnAtualizaPrecoMedio And blnGravaPreMed Then
              fGravaCalcPreMed(FieldByName('TRIINC').AsString, 'TFreConLista.fRateiaConhecimentoFreteNotas','', True);

            If Not blnAtualizaComposicaoPreco Then
              Result := True
            Else
            Begin
              If blnAtuFre And (Not blnTemLote) And (FieldByName('VLRCON').AsFloat > 0) Then
              Begin
                Result := fAtualizaFreteIteger(FieldByName('DET_CODITE').AsString,
                                               RoundTo(((fltConFre + fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat + FieldByName('ANT_CONFRE').AsFloat) / FieldByName('VLRCON').AsFloat) * 100, -2),
                                               RoundTo((fltConFre + fltValRpaIte + cdsMovTri.FieldByName('DET_RPAFRE').AsFloat + FieldByName('ANT_CONFRE').AsFloat) / FieldByName('DET_QTDITE').AsFloat, - FDecUni),
                                               FieldByName('ITE_RPRENT').AsString = 'S');

                If Not Result Then
                  Break;
              End
              Else If ((strAtuNmd = 'I') Or (strAtuNmd = 'M'))And (Not blnTemLote) And (FieldByName('VLRCON').AsFloat > 0) Then
              Begin
                If (strAtuNmd = 'M') And (fCfgSis('BASMED') <> 'S') And (FieldByName('DET_ORIDOC').AsString <> 'D') Then
                  Result := fAtualizaPrecomIteger(FieldByName('DET_CODITE').AsString,
                                                  fltPreMed,
                                                  FieldByName('ITE_RPRENT').AsString = 'S');
                If (strAtuNmd = 'I') Then
                  Result := fAtualizaPrecomIteger(FieldByName('DET_CODITE').AsString,
                                                  fltImpUlt,
                                                  FieldByName('ITE_RPRENT').AsString = 'S');
                If Not Result Then
                  Break;
              End;
            End;
          End;

          Next;

        End; {While Not Eof Do}

      End; {If fAbreClient...}

    End; {With cdsMovTri Do}

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fRateiaConhecimentoFreteNotas]');
    End;
  End;

  FreeAndNil(cdsMovTri);
  FreeAndNil(CalculoPrecoMediAgrup);
end;

Function TFreConLista.fUpdateLotePrecos(fltConFre: Double; cdsMovTri: TZClient; fltPreCom: Double = -1): Boolean;
  Var
    qryLotPre: TUniQuery;
    intOpcAtu,
    intContador: Integer;
    srtCamAtu: String;
Begin
  qryLotPre := fCriaQuery(Self);

  With qryLotPre, SQL Do
  Begin
    Add('SELECT * FROM LOTPRE ');
    Add('WHERE');
    Add('  LTP_ATUALI = "N" AND');
    Add('  LTP_CODITE = :CODITE AND');
    Add('  LTP_NUMDOC = :NUMDOC AND');
    Add('  LTP_CODEMP = :CODEMP AND');
    Add('  LTP_ESPDOC = :ESPDOC AND');
    Add('  LTP_CODFOR = :CODFOR AND');
    Add('  LTP_SEQDET = :AUTINC AND');
    Add('  IFNULL(LTP_SERIE_, "") = :SERIE_');

    ParamByName('NUMDOC').AsString := cdsMovTri.FieldByName('DET_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsMovTri.FieldByName('DET_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsMovTri.FieldByName('DET_CODEMP').AsString;
    ParamByName('CODFOR').AsString := cdsMovTri.FieldByName('DET_CODFOR').AsString;
    ParamByName('SERIE_').AsString := cdsMovTri.FieldByName('DET_SERIE_').AsString;
    ParamByName('CODITE').AsString := cdsMovTri.FieldByName('DET_CODITE').AsString;
    ParamByName('AUTINC').AsString := cdsMovTri.FieldByName('TRIINC').AsString;

    Open;

    If (Not IsEmpty) Then
    Begin

      If (cdsMovTri.FieldByName('VLRCON').AsFloat > 0) Then
      Begin
        Edit;

        If FPerFre = 2 Then
        Begin
          FieldByName('LTP_VALFRE').AsFloat := RoundTo(fltConFre / cdsMovTri.FieldByName('DET_QTDITE').AsFloat, - FDecUni);
          FieldByName('LTP_FREENT').AsFloat := 0;
        End Else
        Begin
          FieldByName('LTP_FREENT').AsFloat := ( ( ( cdsMovTri.FieldByName('DET_TOTFRE').AsFloat + fltConFre) /
                                                  cdsMovTri.FieldByName('VLRCON').AsFloat) * 100 );
        End;

        If fltPreCom > -1 Then
          FieldByName('LTP_PRECOM').AsFloat := fltPreCom;

        With cpcParams Do
        Begin
          curPreCom := FieldByName('LTP_PRECOM').AsFloat;
          curDesF01 := FieldByName('LTP_DESF01').AsFloat;
          curDesF02 := FieldByName('LTP_DESF02').AsFloat;
          curDesF03 := FieldByName('LTP_DESF03').AsFloat;
          curDesF04 := FieldByName('LTP_DESF04').AsFloat;
          curDesF05 := FieldByName('LTP_DESF05').AsFloat;
          curDesF06 := FieldByName('LTP_DESF06').AsFloat;
          curICMSEnt:= FieldByName('LTP_ICMENT').AsFloat;
          curIPIEnt := FieldByName('LTP_IPIENT').AsFloat;
          curFrete  := FieldByName('LTP_FREENT').AsFloat;
          curValFre := FieldByName('LTP_VALFRE').AsFloat;
          curAcrFin := FieldByName('LTP_ACRFIN').AsFloat;
          curSubsti := FieldByName('LTP_SUBSTI').AsFloat;
          curDesAdb := FieldByName('LTP_DESADB').AsFloat;
          curSubFed := FieldByName('LTP_SUBFED').AsFloat;

          if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
          begin
            curTCIFCu := FieldByName('LTP_TCIFCU').AsFloat;
            curTSCust := FieldByName('LTP_TSCUST').AsFloat;
            curDePiCo := FieldByName('LTP_DEPICO').AsFloat;
            curDeICMS := FieldByName('LTP_DEICMS').AsFloat;
            curFatReg := FieldByName('LTP_FATREG').AsFloat;
          end
          else
          begin
            curTCIFCu := 0;
            curTSCust := 0;
            curDePiCo := 0;
            curDeICMS := 0;
            curFatReg := 0;
          end;

          FieldByName('LTP_PRECUS').AsFloat := fCalculaPrecoCusto;
        End;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'LTP_PREVE', 'LTP_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                       FieldByName('LTP_PRECUS').AsFloat + FieldByName('LTP_OUTVAL').AsFloat,
                                                                       FieldByName('LTP_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                       FieldByName('LTP_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                       FieldByName('LTP_ICMSAI').AsFloat,
                                                                       FieldByName('LTP_IMPFED').AsFloat,
                                                                       FieldByName('LTP_DESOPE').AsFloat,
                                                                       FieldByName('LTP_COMTB' + IntToStr(intContador) ).AsFloat);

        End;

        Post;
      End;

      Result := True;

    End

    Else Result := False;

  End;

  FreeAndNil(qryLotPre);
End;

procedure TFreConLista.pUpdateMovtri(strAutInc: String; fltConFre, fltBasAnt, fltIcmAnt, fltOutDes, fltImpUlt, fltRpaFre, fltAlqFreIcm, fltValorFreteCalculado, fltValorConhecimentoCalculado: Double);
  Var
    qryMovTri: TUniQuery;
Begin
  qryMovTri := fCriaQuery(Self);
  With qryMovTri, SQL Do
  Begin
    Add('UPDATE MOVTRI ');
    Add('SET ');
    Add('  DET_CONFRE = :CONFRE, ');

    If fltOutDes > 0 Then
      Add('  DET_OUTDES = :OUTDES, ');

    Add('  DET_BASANT = IFNULL(DET_BASANT, 0) + :BASANT, ');
    Add('  DET_ICMANT = IFNULL(DET_ICMANT, 0) + :ICMANT, ');


    Add('  DET_CFRETE = :CFRETE,');
    Add('  DET_CFRECO = :CFRECO, ');
    Add('  DET_ALQFRE = :ALQFRE, ');



    Add('  DET_IMPULT = :IMPULT,  ');
    Add('  DET_RPAFRE = :RPAFRE   ');
    Add('WHERE');
    Add('  DET_SEQGER = :AUTINC ');

    ParamByName('CONFRE').AsFloat  := fltConFre;
    ParamByName('BASANT').AsFloat  := fltBasAnt;
    ParamByName('ICMANT').AsFloat  := fltIcmAnt;
    ParamByName('IMPULT').AsFloat  := fltImpUlt;
    ParamByName('ALQFRE').AsFloat  := fltAlqFreIcm;
    ParamByName('RPAFRE').AsFloat  := fltRpaFre;

    ParamByName('CFRETE').AsFloat  := fltValorFreteCalculado;
    ParamByName('CFRECO').AsFloat  := fltValorConhecimentoCalculado;

    If fltOutDes > 0 Then
      ParamByName('OUTDES').AsFloat  := fltOutDes;

    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;
  End;
  FreeAndNil(qryMovTri);
End;

procedure TFreConLista.pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String; fltImpUlt, fltPreMed: Double; blnAtualizaUltimaCompra, blnAtualizaPrecoMedio: Boolean; var blnAtualizouRegistros: Boolean);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery(Self);

  If blnAtualizaUltimaCompra Or ((fltPreMed > 0) And blnAtualizaPrecoMedio) Then
  Begin
    With qryIteger, SQL Do
    Begin
      Add('UPDATE ITEGER');
      Add('SET ');

      If blnAtualizaUltimaCompra Then
      Begin
        Add('  ITE_IMPULT = :IMPULT, ');
        Add('  ITE_FORULT = :CODFOR, ');
        Add('  ITE_DTAULT = :DTAULT  ');
      End;

      If (fltPreMed > 0) And blnAtualizaPrecoMedio Then
        Add(' ' + IIf(blnAtualizaUltimaCompra, ',' , '') + 'ITE_PREMED = :PREMED ');

      Add('WHERE');
      Add('  ITE_CODITE = :CODITE AND');
      Add('  ITE_CODEMP = :CODEMP AND');
      Add('  ITE_NOTULT = :NOTULT    ');

      If blnAtualizaUltimaCompra Then
      Begin
        ParamByName('IMPULT').AsFloat  := fltImpUlt;
        ParamByName('CODFOR').AsString := strCodFor;
        ParamByName('DTAULT').AsDate   := VS_Date;
      End;

      If (fltPreMed > 0) And blnAtualizaPrecoMedio Then
        ParamByName('PREMED').AsFloat  := fltPreMed;

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NOTULT').AsString := strNotUlt;

      ExecSQL;

      qryIteger.SQL.Clear;

      qryIteger.SQL.Add('SELECT COUNT(1) QTD FROM ITEGER');
      qryIteger.SQL.Add('WHERE');
      qryIteger.SQL.Add('  ITE_CODITE = :CODITE AND');
      qryIteger.SQL.Add('  ITE_CODEMP = :CODEMP AND');
      qryIteger.SQL.Add('  ITE_NOTULT = :NOTULT    ');

      qryIteger.ParamByName('CODITE').AsString := strCodIte;
      qryIteger.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryIteger.ParamByName('NOTULT').AsString := strNotUlt;


      qryIteger.Open;

      blnAtualizouRegistros := qryIteger.FieldByName('QTD').AsInteger > 0;
    End;
  End;

  FreeAndNil(qryIteger);

  If (fltPreMed > 0) And blnAtualizaPrecoMedio Then
    pAtualizaPrecoMedioEmpreas(strCodIte, strEmpMeds, fltPreMed);
End;

Function TFreConLista.fAtualizaFreteIteger(strCodIte: String; fltFreEnt, fltValFre: Double; blnPermiteReducaoPreco: Boolean): Boolean;
  Var
    qryIteger: TUniQuery;
    intOpcAtu,
    intContador: Integer;
    strAgrupadorPreAlt: String;

    strEmpresas,
    srtCamAtu: String;

    arrPreVen: Array[1..7] Of Double;
    arrMarBru: Array[1..7] Of Double;
    fltPreCus: Double;

    Function fSQLIteger: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ITEGER ';
      strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
      strSQL := strSQL + '   AND LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
      Result := strSQL;
    End;

Begin
  Result := True;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryIteger := fCriaQuery(Self);

  pPreAltDefineVariaveisAltPre(fNow, 'ENTRADA DE MERCADORIAS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  With qryIteger, SQL Do
  Begin
    Close;

    SQL.Text := fSQLIteger;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strEmpresas;

    Open;

    While Not Eof Do
    Begin

      fltPreCus := FieldByName('ITE_PRECUS').AsFloat;

      For intContador := 1 To 7 Do
      Begin
        arrPreVen[intContador] := FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat;
        arrMarBru[intContador] := FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat;
      End;

      Edit;

      If FPerFre = 2 Then
      Begin
        FieldByName('ITE_VALFRE').AsFloat := fltValFre;
        FieldByName('ITE_FREENT').AsFloat := 0;
      End Else
      Begin
        FieldByName('ITE_FREENT').AsFloat := fltFreEnt;
      End;

      With cpcParams Do
      Begin
        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
          curTSCust := FieldByName('ITE_TSCUST').AsFloat;
          curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
          curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
          curFatReg := FieldByName('ITE_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;

        FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto();
        FieldByName('ITE_PREALT').AsString:= strAgrupadorPreAlt;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'ITE_PREVE', 'ITE_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                                        FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                                        FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_ICMSAI').AsFloat,
                                                                                        FieldByName('ITE_IMPFED').AsFloat,
                                                                                        FieldByName('ITE_DESOPE').AsFloat,
                                                                                        FieldByName('ITE_COMTB' + IntToStr(intContador) ).AsFloat);
        End;

        If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then
        Begin
          Post;
          If (Not VS_blnPreAltViaTrigger) Then
            Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,

                               fltPrecus,
                               FieldByName('ITE_PRECUS').AsFloat,

                               arrPreVen[1],
                               FieldByName('ITE_PREVE1').AsFloat,

                               arrMarBru[1],
                               FieldByName('ITE_MARBR1').AsFloat,

                               arrPreVen[2],
                               FieldByName('ITE_PREVE2').AsFloat,

                               arrMarBru[2],
                               FieldByName('ITE_MARBR2').AsFloat,

                               arrPreVen[3],
                               FieldByName('ITE_PREVE3').AsFloat,

                               arrMarBru[3],
                               FieldByName('ITE_MARBR3').AsFloat,

                               arrPreVen[4],
                               FieldByName('ITE_PREVE4').AsFloat,

                               arrMarBru[4],
                               FieldByName('ITE_MARBR4').AsFloat,

                               arrPreVen[5],
                               FieldByName('ITE_PREVE5').AsFloat,

                               arrMarBru[5],
                               FieldByName('ITE_MARBR5').AsFloat,

                               arrPreVen[6],
                               FieldByName('ITE_PREVE6').AsFloat,

                               arrMarBru[6],
                               FieldByName('ITE_MARBR6').AsFloat,

                               arrPreVen[7],
                               FieldByName('ITE_PREVE7').AsFloat,

                               arrMarBru[7],
                               FieldByName('ITE_MARBR7').AsFloat,

                               FieldByName('ITE_PRECOM').AsFloat,
                               FieldByName('ITE_PRECOM').AsFloat,

                               'ENTRADA DE MERCADORIAS',

                               Nil,
                               '',
                               strLoginUsuarioLogado);

        End {If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then}

        Else Cancel;

      End; {With cpcParams Do}

      Next;
    End; {While Not Eof Do}

  End;
  strAgrupadorPreAlt := '';
  FreeAndNil(qryIteger);
End;

Function TFreConLista.fAtualizaPrecomIteger(strCodIte: String; fltPreCom: Double; blnPermiteReducaoPreco: Boolean): Boolean;
  Var
    qryIteger: TUniQuery;
    intOpcAtu,
    intContador: Integer;

    strEmpresas,
    srtCamAtu: String;

    arrPreVen: Array[1..7] Of Double;
    arrMarBru: Array[1..7] Of Double;
    fltPreCus: Double;

    Function fSQLIteger: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ITEGER ';
      strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
      strSQL := strSQL + '   AND LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
      Result := strSQL;
    End;

Begin
  Result := True;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryIteger := fCriaQuery(Self);

  With qryIteger, SQL Do
  Begin
    Close;

    SQL.Text := fSQLIteger;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strEmpresas;

    Open;

    While Not Eof Do
    Begin

      For intContador := 1 To 7 Do
      Begin
        arrPreVen[intContador] := FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat;
        arrMarBru[intContador] := FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat;
      End;

      Edit;
      FieldByName('ITE_PRECOM').AsFloat := fltPreCom;

      With cpcParams Do
      Begin
        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
          curTSCust := FieldByName('ITE_TSCUST').AsFloat;
          curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
          curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
          curFatReg := FieldByName('ITE_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;

        fltPreCus := fCalculaPrecoCusto;
        FieldByName('ITE_PRECUS').AsFloat := fltPreCus;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'ITE_PREVE', 'ITE_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                                        FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                                        FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_ICMSAI').AsFloat,
                                                                                        FieldByName('ITE_IMPFED').AsFloat,
                                                                                        FieldByName('ITE_DESOPE').AsFloat,
                                                                                        FieldByName('ITE_COMTB' + IntToStr(intContador) ).AsFloat);
        End;

        If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then
        Begin
          Post;

          Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,

                               fltPrecus,
                               FieldByName('ITE_PRECUS').AsFloat,

                               arrPreVen[1],
                               FieldByName('ITE_PREVE1').AsFloat,

                               arrMarBru[1],
                               FieldByName('ITE_MARBR1').AsFloat,

                               arrPreVen[2],
                               FieldByName('ITE_PREVE2').AsFloat,

                               arrMarBru[2],
                               FieldByName('ITE_MARBR2').AsFloat,

                               arrPreVen[3],
                               FieldByName('ITE_PREVE3').AsFloat,

                               arrMarBru[3],
                               FieldByName('ITE_MARBR3').AsFloat,

                               arrPreVen[4],
                               FieldByName('ITE_PREVE4').AsFloat,

                               arrMarBru[4],
                               FieldByName('ITE_MARBR4').AsFloat,

                               arrPreVen[5],
                               FieldByName('ITE_PREVE5').AsFloat,

                               arrMarBru[5],
                               FieldByName('ITE_MARBR5').AsFloat,

                               arrPreVen[6],
                               FieldByName('ITE_PREVE6').AsFloat,

                               arrMarBru[6],
                               FieldByName('ITE_MARBR6').AsFloat,

                               arrPreVen[7],
                               FieldByName('ITE_PREVE7').AsFloat,

                               arrMarBru[7],
                               FieldByName('ITE_MARBR7').AsFloat,

                               FieldByName('ITE_PRECOM').AsFloat,
                               FieldByName('ITE_PRECOM').AsFloat,

                               'ENTRADA DE MERCADORIAS',

                               Nil,
                               '',
                               strLoginUsuarioLogado);

        End {If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then}

        Else Cancel;

      End; {With cpcParams Do}

      Next;
    End; {While Not Eof Do}

  End;

  FreeAndNil(qryIteger);
End;


Function TFreConLista.fIncluiConFreVariasNotas(strAutFis: String; arrSeqPag: TArrAutInc): Boolean;
Begin
  Result := False;

  With cdsNotEnt Do
  Begin
    First;
    While Not Eof Do
    Begin
      Result := fIncluiConFre(FieldByName('AUTINC').AsString, strAutFis, arrSeqPag);

      If Not Result Then
        Break;

      Next;
    End;
  End;
End;

Function TFreConLista.fVerificaPesoDosItens: Boolean;
Begin

  If not (tipRatFrete = trfPropPesoItem) Then
  Begin
    Result := True;
    Exit;
  End;

  pCriaTabelaEntradaMercadorias(False);

  Result := (not fncExecutaRelatorio(202, 7584, [],
                                        ['OPCREL','NOTENT'],
                                        ['2', fIncsNotasEntrada],
                                        nil,
                                        nil,
                                        True,
                                        False));

  if not Result then
  begin
    pMensagemOk('O Sistema está configurado para ratear o frete proporcionalmente ao Peso do Item,' + #$A#$D +
                'dessa forma itens com peso igual a zero não serão permitidos.' + #$A#$D +
                'Informe no Cadastro de Produtos o peso dos itens.');
  end;

End;

Function TFreConLista.fConfirmaFreConhecimentoVariasNotas: Boolean;
  Var
    intContador: Integer;
    objFreCon: TFreCon;
    strChaveCadFis: String;

Begin
  Result := False;

  If ((tipRatFrete = trfPropPesoItem)) And (Not fVerificaPesoDosItens) Then
    Exit;

  Try
    fStartTransaction;

    For intContador := 0 To arrFreCon.Count - 1 Do
    Begin
      objFreCon := TFreCon(arrFreCon.Items[intContador]);
      objFreCon.strCodOpe := FCodOpe;

      Result := objFreCon.fConfirmaFreConhecimentoVariasNotas And
                fIncluiConFreVariasNotas(objFreCon.strAutFis, objFreCon.arrSeqPag);

      strChaveCadFis := objFreCon.strAutFis;
      If Not Result Then
        Break;
    End;

    Result := Result And fRateiaConhecimentoFreteNotas(fRetSoma('TOT_OUTDES'), fRetSoma('TOT_TOTRPA'), '', strChaveCadFis);

    If Result Then
    Begin
      fCommit;
      pImprimeCPs;
    End Else
    Begin
      fRollBack;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TFreConLista.fConfirmaFreConhecimentoVariasNotas]');
    End;
  End;

End;

Function TFreConLista.fRetConhecimento(strNumDoc, strEspDoc, strSerie_, strCodTra: String): TFreCon;
  Var intIndice: Integer;
Begin

  If fExisteConhecimento(strNumDoc,
                         strEspDoc,
                         strSerie_,
                         strCodTra,
                         intIndice) Then
    Result := TFreCon(arrFreCon.Items[intIndice])
  Else
    Result := Nil;
End;

Function TFreConLista.getAntIcT: Double;
Begin
  Result := fRetSoma('TOT_VALANT');
End;

Function TFreConLista.getBasAnT: Double;
Begin
  Result := fRetSoma('TOT_BASANT')
End;

Function TFreConLista.getValCon: Double;
Begin
  Result := fRetSoma('TOT_VALCON')
End;

Function TFreConLista.getValFre: Double;
Begin
  Result := fRetSoma('TOT_VALFRE')
End;

Function TFreConLista.getValIcm: Double;
Begin
  Result := fRetSoma('TOT_VALICM')
End;


procedure TFreConLista.pGravaValorMovDetReferenteFreteEntrada(strSeqCadFis: String; ArrCteMov: TArrCteMov);
var
  qryInsert: TUniQuery;
  CteMov: TCteMov;
begin
  qryInsert := fCriaQuery;
  Try
    qryInsert.sql.text := 'INSERT INTO CTEMOV (MOV_CADFIS, MOV_MOVDET, MOV_CONFRE, MOV_ALQFRE) VALUES (:CADFIS, :MOVDET, :CONFRE, :ALQFRE )';
    For CteMov in ArrCteMov do
    Begin
      qryInsert.ParamByName('CADFIS').AsString := strSeqCadFis;
      qryInsert.ParamByName('MOVDET').AsString := CteMov.strMOV_MOVDET;
      qryInsert.ParamByName('CONFRE').AsFloat  := CteMov.fltMOV_CONFRE;
      qryInsert.ParamByName('ALQFRE').AsFloat  := CteMov.fltMOV_ALQFRE;
      qryInsert.execSQL;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;

end;

end.


