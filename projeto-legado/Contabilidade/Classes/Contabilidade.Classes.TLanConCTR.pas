unit Contabilidade.Classes.TLanConCTR;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls, Contabilidade.SQL,
  System.Generics.Collections;

type
  TLanConCTR = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    blnCFG_EXCREP_Existe : Boolean;
    FblnCFG_EXCREP: Boolean;
    blnContaNaBandeiraExiste : Boolean;
    blnBanNcoExiste : boolean;
    blnTitPDDExiste : boolean;
    blnCtrCreditExiste: boolean;
    blnCfgCreCtr: boolean;
    FblnDtaBanExiste: Boolean;
    FblnAdtCliExiste: Boolean;
    FblnValCobExiste: Boolean;
    fltDinhei: Double;
    fltCredit: Double;
    fltCrePag: Double;
    fltRatDin: Double;
    fltRatCre: Double;
    fltDifDin: Double;
    fltDifCre: Double;
    fltChqPre: Double;
    fltRatChP: Double;
    fltDifChP: Double;
    fltChqAvi: Double;
    fltRatChA: Double;
    fltDifChA: Double;
    fltCartao: Double;
    fltRatCar: Double;
    fltDifCar: Double;
    fltOrdPag: Double;
    fltRatOrP: Double;
    fltDifOrP: Double;
    fltValOriDin: Double;
    fltValOriCha: Double;
    fltValOriChp: Double;
    fltValOriCar: Double;
    fltValOriOrP: Double;
    fltValOriCre: Double;
    fltRatOriDin: Double;
    fltRatOriCha: Double;
    fltRatOriChp: Double;
    fltRatOriCar: Double;
    fltRatOriOrP: Double;
    fltRatOriCre: Double;
    fltDifOriDin: Double;
    fltDifOriCha: Double;
    fltDifOriChp: Double;
    fltDifOriCar: Double;
    fltDifOriOrP: Double;
    fltDifOriCre: Double;
    fltJurosDin: Double;
    fltJurosCha: Double;
    fltJurosChp: Double;
    fltJurosCar: Double;
    fltJurosOrP: Double;
    fltJurosCre: Double;
    fltRatJurDin: Double;
    fltRatJurCha: Double;
    fltRatJurChp: Double;
    fltRatJurCar: Double;
    fltRatJurOrP: Double;
    fltRatJurCre: Double;
    fltDifJurDin: Double;
    fltDifJurCha: Double;
    fltDifJurChp: Double;
    fltDifJurCar: Double;
    fltDifJurOrP: Double;
    fltDifJurCre: Double;
    fltCobrancaDin: Double;
    fltCobrancaCha: Double;
    fltCobrancaChp: Double;
    fltCobrancaCar: Double;
    fltCobrancaOrP: Double;
    fltCobrancaCre: Double;
    fltRatCobDin: Double;
    fltRatCobCha: Double;
    fltRatCobChp: Double;
    fltRatCobCar: Double;
    fltRatCobOrP: Double;
    fltRatCobCre: Double;
    fltDifCobDin: Double;
    fltDifCobCha: Double;
    fltDifCobChp: Double;
    fltDifCobCar: Double;
    fltDifCobOrP: Double;
    fltDifCobCre: Double;
    fltDescontoDin: Double;
    fltDescontoCha: Double;
    fltDescontoChp: Double;
    fltDescontoCar: Double;
    fltDescontoOrP: Double;
    fltDescontoCre: Double;
    fltRatDesDin: Double;
    fltRatDesCha: Double;
    fltRatDesChp: Double;
    fltRatDesCar: Double;
    fltRatDesOrP: Double;
    fltRatDesCre: Double;
    fltDifDesDin: Double;
    fltDifDesCha: Double;
    fltDifDesChp: Double;
    fltDifDesCar: Double;
    fltDifDesOrP: Double;
    fltDifDesCre: Double;
    strCTRInc: string;
    fltRatDes2: Double;
    fltDifDes2: Double;
    fltRatJur2: Double;
    fltDifJur2: Double;
    cdsCtrAgg: TUniClientDataSet;
    cdsCtrCred: TUniClientDataSet;
    FcdsCtrCredUtilSintetico: TUniClientDataSet;
    FcdsCtrCredUtilAnalitico: TUniClientDataSet;
    FstrCentroCustoDefault : String ;
    FcdsOrigemCtr: TUniClientDataSet ;
    FcdsDadosAdtTransformadoEmCC: TUniClientDataSet ;
    FcdsDadosCCTransformadoEmAdt: TUniClientDataSet;
    FcdsCreditoSeqCon: TUniClientDataSet ;
    FcdsParConAVistaSAI: TUniClientDataSet;
    FcdsCtrLancadosPeriodoFechado: TUniClientDataSet;

    function fCgcEmpAdt(const AstrCodEmpAdt: String): string ;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pSomarValores;
    procedure pZerarValores;
    procedure pAlterarValores;
    function fEmpresaDoCadastroDiferenteDaBaixa(const AEmpresaCadastro, AEmpresaDaBaixa: string): boolean;
    function fDeletaLacamentosGeradosParaOutraEmpresa(const AblnTemControle: Boolean): boolean;
    function fTituloComDescontoTotal: boolean;
    function fEmpresaDoCadastroAdtDiferenteDaBaixa(const AEmpresaAdt,
      AEmpresaDaBaixa: string): boolean;
    function fCarregaDadosCadRecValorAgrupado(recParams: TParamsContasReceber):boolean;
    function fCarregaDadosCadRecCreditoUtil(recParams: TParamsContasReceber):boolean;
    function fCarregaDadosAdtTransformadoEmCC(recParams: TParamsContasReceber):boolean;
    procedure pCarregaDadosCadRecLancadosPeriodoFechado(recParams: TParamsContasReceber);
    procedure pAjustaDadosCadRecCreditoDinheiro ;
    procedure pCarregaDadosCCTransformadoEmAdt(recParams: TParamsContasReceber);
    function fEhCCTransformadoEmAdt(const strAutoInc, AstrEspDoc: string): Boolean;
    function fGetCadRecValorAgrupado(const strAutoInc:string; const AJurDes: boolean):double ;
    function fTrataValorProporcional(const fltValorProporcional:double; const AModoJurDes: boolean = False):double ;
    procedure pCarregaDadosAcertoInformacaoCredito(recParams: TParamsContasReceber);
    procedure pAjustaInformacaoCredito;
    procedure pAjustaAdtTransformadoEmCC;
    function fRecalculaValorJur(const AValor:double):double;
    function fRecalculaValorOri(const AValor:double):double;
    function fRecalculaValorDes(const AValor:double):double;
    function fRecalculaValorCob(const AValor:double):double;
    function fDeletaLanConCTR: Boolean;
    function fTemFormaPagamento: Boolean;
    function fRetornaEventoDescontoJuros(const AstrCodigoEvento, AstrDescricaoValor: String): String ;
    procedure pCarregaOrigemCTR(ARecParams: TParamsContasReceber);
    function fRetPagamentoPcr: string;
    procedure pCriaCreditoSeqcon;
    function fFormaPagamentoZeradaTransfCred: boolean;
    function fFormaPagamentoZeradaTransfCredESemValOri: boolean;
    procedure pAcertaArredondamentoTotalAgrupadas(var AqryCTR: TUniQuery);
    procedure pAcertaArredondamentoTotalAgrupadasInterno(var   AqryCTR: TUniQuery;
                                                         const AarrModalidade: TArrayModalidadesCTR;
                                                         const AstrCampoAnalitico: String);
    function fEhAgrupamentoCTR(const AqryCTR: TUniQuery): Boolean;
    function fUsaColunaCreditoArredondamentoAgrupadas(const AstrColuna: String): Boolean;
    procedure pCarregaParconAVistaSAI;
  public
    class function fFiltroCCOriginadoAdt(const AblnDtaBanExiste: Boolean; const AstrAliasLancon: string = ''): string;
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    function fTemControleDelLanconOutrasEmpresasCTR(const ATipLan: string): Boolean ;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
   untConstantes, Contabilidade.Classes.TEventoContabil,
   Contabilidade.Classes.TTrataIncDoc;

const
  VALOR_ORIGINAL: TArrayModalidadesCTR = ('CTR_DINORI', 'CTR_CHAORI', 'CTR_CREORI', 'CTR_CHPORI', 'CTR_CARORI', 'CTR_ORDORI') ;
  JUROS: TArrayModalidadesCTR = ('CTR_DINJUR', 'CTR_CHAJUR', 'CTR_CREJUR', 'CTR_CHPJUR', 'CTR_CARJUR', 'CTR_ORDJUR') ;
  DESCONTOS: TArrayModalidadesCTR = ('CTR_DINDES', 'CTR_CHADES', 'CTR_CREDES', 'CTR_CHPDES', 'CTR_CARDES', 'CTR_ORDDES') ;
  VALOR_COBRANCA: TArrayModalidadesCTR = ('CTR_DINCOB', 'CTR_CHACOB', 'CTR_CRECOB', 'CTR_CHPCOB', 'CTR_CARCOB', 'CTR_ORDCOB') ;
  CREDITOS: array[0..2] of string = ('CTR_CREORI', 'CTR_CREJUR', 'CTR_CREDES') ;

{ TLanConCTR }

constructor TLanConCTR.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnCFG_EXCREP_Existe := fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_EXCREP', VS_strCodEmp], False) > 0;
  FblnCFG_EXCREP := False ;
  if blnCFG_EXCREP_Existe then
    FblnCFG_EXCREP := fCfgSis('EXCREP', varBoolean) ;
  blnContaNaBandeiraExiste := fCampoExiste('CADBAN', 'BAN_PLANCO');
  blnBanNcoExiste := fTabelaExiste('BANNCO');
  blnTitPDDExiste := fCampoExiste('PARCON', 'CON_TITPDD');
  blnCtrCreditExiste := fCampoExiste('CADREC', 'CTR_CREDIT');
  blnCfgCreCtr := fCfgDescCreditoDinheiroMesmoSeqCon = 'S';
  FblnDtaBanExiste := fCampoExiste('CADREC', 'CTR_DTABAN') ;
  FblnValCobExiste := fCampoExiste('CADREC', 'CTR_VALCOB') ;
  FblnAdtCliExiste:= fTabelaExiste('ADTCLI');
  cdsCtrAgg  := nil ;
  cdsCtrCred := nil ;
  FcdsCtrCredUtilSintetico := nil ;
  FcdsCtrCredUtilAnalitico := nil ;
  FcdsDadosAdtTransformadoEmCC := nil ;
  FcdsDadosCCTransformadoEmAdt := nil ;
  FcdsCtrLancadosPeriodoFechado := nil ;
  FCdsCreditoSeqCon := nil ;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConCTR.Destroy;
begin
  lblGravando := Nil;
  if Assigned(cdsCtrAgg) then
    FreeAndNil(cdsCtrAgg) ;

  if Assigned(cdsCtrCred) then
    FreeAndNil(cdsCtrCred) ;

  if Assigned(FcdsCtrCredUtilSintetico) then
    FreeAndNil(FcdsCtrCredUtilSintetico) ;

  if Assigned(FcdsCtrCredUtilAnalitico) then
    FreeAndNil(FcdsCtrCredUtilAnalitico) ;

  if Assigned(FcdsOrigemCtr) then
    FreeAndNil(FcdsOrigemCtr);

  if Assigned(FcdsDadosAdtTransformadoEmCC) then
    FreeAndNil(FcdsDadosAdtTransformadoEmCC) ;

  if Assigned(FcdsDadosCCTransformadoEmAdt) then
    FreeAndNil(FcdsDadosCCTransformadoEmAdt);

  if Assigned(FcdsCtrLancadosPeriodoFechado) then
    FreeAndNil(FcdsCtrLancadosPeriodoFechado);

  if Assigned(FCdsCreditoSeqCon) then
    FreeAndNil(FCdsCreditoSeqCon) ;

  if Assigned(FcdsParConAVistaSAI) then
    FreeAndNil(FcdsParConAVistaSAI) ;

  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCTR.fCarregaDados: Boolean;
Var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := recParCon.strCodEmp;
  recParams.blnContaNaBandeiraExiste := blnContaNaBandeiraExiste;
  recParams.blnBanNcoExiste := blnBanNcoExiste;
  recParams.blnCFG_EXCREP_Existe := blnCFG_EXCREP_Existe;
  recParams.blnCFG_EXCREP := FblnCFG_EXCREP;
  recParams.blnCTR_RETBAN_Existe := fCampoExiste('CADREC', 'CTR_RETBAN');
  recParams.blnCTR_DTABAN_Existe := fCampoExiste('CADREC', 'CTR_DTABAN');
  recParams.blnCTR_HISBAI_Existe := fCampoExiste('CADREC', 'CTR_HISBAI');
  recParams.blnCTR_CREDIT_Existe := blnCtrCreditExiste;
  recParams.blnPOR_TITPDD_Existe := fCampoExiste('CADPOR', 'POR_TITPDD') and (fCfgLigPdd = 'S');
  recParams.dtaDtaIni := recParCon.dtaDtaIni;
  recParams.dtaDtaFin := recParCon.dtaDtaFin;
  recParams.strIncDoc := recParCon.strIncDoc;
  recParams.arrIncDoc := recParCon.arrIncDoc;
  recParams.blnDesabilitaAgrupamento := (fCfgCAgrDp = 'S') ;
  recParams.blnDesconsiderarFiltroDataFaturaCTR := fDesconsiderarFiltroDataFaturaCTR ;
  recParams.blnCfgCtrAgr := (fCfgCtrAgr = 'S') ;
  recParams.blnUsarCtrDescontoCobranca := FblnValCobExiste and fContabilizarDespesasCobrancaCTR;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fGetSQLMovimentoContasReceber(recParams) );

  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;

  pCarregaDadosCadRecLancadosPeriodoFechado(recParams) ;

  fCarregaDadosCadRecValorAgrupado(recParams) ;

  pCarregaDadosAcertoInformacaoCredito(recParams) ;

  fCarregaDadosCadRecCreditoUtil(recParams) ;

  fCarregaDadosAdtTransformadoEmCC(recParams) ;

  pCarregaDadosCCTransformadoEmAdt(recParams);

  pCarregaOrigemCTR(recParams) ;

  pCriaCreditoSeqcon ;

  pCarregaParconAVistaSAI;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCTR.fCarregaDadosAdtTransformadoEmCC(
  recParams: TParamsContasReceber): boolean;
var
  LstrDtaRec: String ;
  LqryCtrConsulta: TUniQuery ;
begin

  If (recParams.blnCTR_DTABAN_Existe) Then
    LstrDtaRec := 'IFNULL(CTR_DTABAN, CTR_DTAREC)'
  else
    LstrDtaRec := 'CTR_DTAREC' ;

  If Assigned(FcdsDadosAdtTransformadoEmCC) Then
    FreeAndNil(FcdsDadosAdtTransformadoEmCC);

  LqryCtrConsulta := fCriaQuery() ;
  try
    LqryCtrConsulta.Close ;
    LqryCtrConsulta.SQL.Clear ;
    LqryCtrConsulta.SQL.Add(' SELECT ') ;
    LqryCtrConsulta.SQL.Add('   AUTOINCREM, ') ;
    LqryCtrConsulta.SQL.Add('   CTR_EMPBAI, ') ;
    LqryCtrConsulta.SQL.Add('   CTR_SEQCON, ') ;
    LqryCtrConsulta.SQL.Add('   ' + LstrDtaRec + ' AS CTR_DTAREC, ') ;
    LqryCtrConsulta.SQL.Add('   CTR_DINHEI ') ;
    LqryCtrConsulta.SQL.Add(' FROM CADREC ') ;
    LqryCtrConsulta.SQL.Add(' WHERE CTR_ESPDOC = "CC" AND CTR_ADTCLI = "S" AND CTR_SEQCON <> 0 ') ;

    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      LqryCtrConsulta.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      LqryCtrConsulta.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryCtrConsulta.SQL.Add('    AND ' + LstrDtaRec + ' BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCtrConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryCtrConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryCtrConsulta)
      .fExecute ;

    LqryCtrConsulta.Open ;

    FcdsDadosAdtTransformadoEmCC := fCriaClientDatset(LqryCtrConsulta);
    FcdsDadosAdtTransformadoEmCC.IndexFieldNames := 'AUTOINCREM;CTR_EMPBAI;CTR_SEQCON;CTR_DTAREC' ;
    FcdsDadosAdtTransformadoEmCC.Open;

  finally
    FreeAndNil(LqryCtrConsulta) ;
  end ;

  Result := True ;
end;

procedure TLanConCTR.pAcertaArredondamentoTotalAgrupadas(var AqryCTR: TUniQuery);
begin
  AqryCTR.First ;
  while not AqryCTR.Eof do
  begin
    if fEhAgrupamentoCTR(AqryCTR) then
    begin
      pAcertaArredondamentoTotalAgrupadasInterno(AqryCTR,
                                                 VALOR_ORIGINAL,
                                                 'CTR_VALORI') ;

      pAcertaArredondamentoTotalAgrupadasInterno(AqryCTR,
                                                 JUROS,
                                                 'CTR_VALJUR') ;

      pAcertaArredondamentoTotalAgrupadasInterno(AqryCTR,
                                                 DESCONTOS,
                                                 'CTR_VALDES') ;

      pAcertaArredondamentoTotalAgrupadasInterno(AqryCTR,
                                                 VALOR_COBRANCA,
                                                 'CTR_VALCOB') ;
    end ;
    AqryCTR.Next ;
  end ;
end;

procedure TLanConCTR.pAcertaArredondamentoTotalAgrupadasInterno(
  var AqryCTR: TUniQuery;
  const AarrModalidade: TArrayModalidadesCTR;
  const AstrCampoAnalitico: String);
var
  LfltValor: Double ;
  LfltDiferenca: Double ;
  LintCnt: Integer ;
begin
  LfltValor := 0.00 ;
  for LintCnt := Low(AarrModalidade) to High(AarrModalidade) do
  begin
    if not fUsaColunaCreditoArredondamentoAgrupadas(AarrModalidade[LintCnt]) then
      Continue ;
    LfltValor := LfltValor + AqryCTR.FieldByName(AarrModalidade[LintCnt]+'_CONF').AsFloat ;
  end ;
  LfltDiferenca := fFormataFloat(AqryCTR.FieldByName(AstrCampoAnalitico).AsFloat, 2) - fFormataFloat(LfltValor, 2) ;
  if fFormataFloat(LfltDiferenca, 2) <> 0.00 then
  begin
    AqryCTR.Edit ;
    for LintCnt := Low(AarrModalidade) to High(AarrModalidade) do
    begin
      if not fUsaColunaCreditoArredondamentoAgrupadas(AarrModalidade[LintCnt]) then
        Continue ;

      if AqryCTR.FieldByName(AarrModalidade[LintCnt]).AsFloat <> 0.00 then
      begin
        AqryCTR.FieldByName(AarrModalidade[LintCnt]+'_CONF').AsFloat := AqryCTR.FieldByName(AarrModalidade[LintCnt]+'_CONF').AsFloat + fFormataFloat(LfltDiferenca, 2) ;
        break ;
      end ;
    end ;
    AqryCTR.Post ;
  end ;
end;

procedure TLanConCTR.pAjustaAdtTransformadoEmCC;
var
  LlstControleSeqCon: TStringList ;
  LstrValor: String ;
begin
  if not blnCtrCreditExiste then
    exit ;

  LlstControleSeqCon := TStringList.Create ;
  try
    LlstControleSeqCon.Sorted := True ;
    qryDados.First;
    While Not qryDados.Eof Do
    Begin

      if qryDados.FieldByName('CTR_DINHEI').AsFloat > 0.00 then
      begin
        qryDados.Next ;
        Continue ;
      end ;

      if FcdsDadosAdtTransformadoEmCC.FindKey([qryDados.FieldByName('CTRINC').AsString, qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsString, qryDados.FieldByName('DTAENT').AsDateTime]) then
      begin
        qryDados.Edit ;
        LstrValor := qryDados.FieldByName('CTRINC').AsString + qryDados.FieldByName('EMPBAI').AsString + qryDados.FieldByName('CTR_SEQCON').AsString + qryDados.FieldByName('DTAENT').AsString ;
        if LlstControleSeqCon.IndexOf(LstrValor) = -1 then
        begin
          qryDados.FieldByName('CTR_CREDIT').AsFloat := abs(FcdsDadosAdtTransformadoEmCC.FieldByName('CTR_DINHEI').AsFloat) ;
          qryDados.FieldByName('CTR_CREORI').AsFloat := abs(FcdsDadosAdtTransformadoEmCC.FieldByName('CTR_DINHEI').AsFloat) ;
          qryDados.FieldByName('CTR_DINHEI').AsFloat := 0.00 ;
          qryDados.FieldByName('CTR_DINORI').AsFloat := 0.00 ;
          qryDados.FieldByName('TIPO_PAGAMENTO_CREDITO').AsString := 'Pagamentos Avulsos' ;
          qryDados.FieldByName('CTR_ADTCLI').AsString := 'N' ;
          LlstControleSeqCon.Add(LstrValor) ;
        end ;
        qryDados.Post ;
      end ;
      qryDados.Next ;
    End ;

  finally
    FreeAndNil(LlstControleSeqCon) ;
  end ;

end;

procedure TLanConCTR.pAjustaDadosCadRecCreditoDinheiro;
begin
  if fCfgDescCreditoDinheiroMesmoSeqCon = 'N' then
    Exit ;

  FcdsCtrCredUtilSintetico.DisableControls ;
  FcdsCtrCredUtilAnalitico.DisableControls ;
  try
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      //pula o crédito
      if qryDados.FieldByName('CTR_DINHEI').AsFloat < 0.00 then
      begin
        qryDados.Next ;
        Continue ;
      end ;

      if FcdsDadosAdtTransformadoEmCC.FindKey([qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsString, qryDados.FieldByName('DTAENT').AsDateTime]) then
      begin
        qryDados.Next ;
        Continue ;
      end ;

      if FcdsCtrCredUtilSintetico.FindKey([qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsString, qryDados.FieldByName('DTAENT').AsDateTime, qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString]) then
      begin
        // quando tem rateio
        if FcdsCtrCredUtilSintetico.FieldByName('CNT_POSITIVO').AsInteger > 1 then
        begin
          if FcdsCtrCredUtilAnalitico.FindKey([FcdsCtrCredUtilSintetico.FieldByName('CTR_EMPBAI').AsString,
                                               FcdsCtrCredUtilSintetico.FieldByName('CTR_SEQCON').AsString,
                                               FcdsCtrCredUtilSintetico.FieldByName('CTR_DTAREC').AsDateTime,
                                               FcdsCtrCredUtilSintetico.FieldByName('CTR_CODCLI').AsString
                                              ]) then
          begin
            while (not FcdsCtrCredUtilAnalitico.Eof) and
                (FcdsCtrCredUtilSintetico.FieldByName('CTR_EMPBAI').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_EMPBAI').AsString) and
                (FcdsCtrCredUtilSintetico.FieldByName('CTR_SEQCON').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_SEQCON').AsString) and
                (FcdsCtrCredUtilSintetico.FieldByName('CTR_DTAREC').AsDateTime = FcdsCtrCredUtilAnalitico.FieldByName('CTR_DTAREC').AsDateTime) and
                (FcdsCtrCredUtilSintetico.FieldByName('CTR_CODCLI').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_CODCLI').AsString) do
            begin
              if FcdsCtrCredUtilAnalitico.FieldByName('AUTOINCREM').AsString = qryDados.FieldByName('CTRINC').AsString then
              begin
                qryDados.Edit ;
                qryDados.FieldByName('CTR_CREDIT').AsFloat := abs(qryDados.FieldByName('CTR_DINHEI').AsFloat) - abs(FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat) ;
                qryDados.FieldByName('CTR_DINHEI').AsFloat := FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat ;

                qryDados.FieldByName('CTR_PGTCRE').AsFloat := abs(qryDados.FieldByName('CTR_PGTDIN').AsFloat) - abs(FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat) ;
                qryDados.FieldByName('CTR_PGTDIN').AsFloat := FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat ;

                qryDados.FieldByName('CTR_DINORI').AsFloat := qryDados.FieldByName('CTR_DINORI').AsFloat - abs(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;

                qryDados.FieldByName('CTR_DINORI_CONF').AsFloat := qryDados.FieldByName('CTR_DINORI_CONF').AsFloat - abs(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
                qryDados.FieldByName('CTR_CREDIT').AsFloat := 0.00;
                qryDados.Post ;
                break ;
              end ;
              FcdsCtrCredUtilAnalitico.Next ;
            end ;
          end ;
        end
        else
        begin
          qryDados.Edit ;
          qryDados.FieldByName('CTR_CREDIT').AsFloat := abs(qryDados.FieldByName('CTR_DINHEI').AsFloat) - abs(FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI').AsFloat) ;
          qryDados.FieldByName('CTR_DINHEI').AsFloat := FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI').AsFloat ;

          qryDados.FieldByName('CTR_PGTCRE').AsFloat := abs(qryDados.FieldByName('CTR_PGTDIN').AsFloat) - abs(FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI').AsFloat) ;
          qryDados.FieldByName('CTR_PGTDIN').AsFloat := FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI').AsFloat ;

          qryDados.FieldByName('CTR_DINORI').AsFloat := qryDados.FieldByName('CTR_DINORI').AsFloat - abs(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;

          qryDados.FieldByName('CTR_DINORI_CONF').AsFloat := qryDados.FieldByName('CTR_DINORI_CONF').AsFloat - abs(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
          qryDados.FieldByName('CTR_CREDIT').AsFloat := 0.00;
          qryDados.Post ;
        end ;
      end ;

      if qryDados.FieldByName('CTR_DINHEI').AsFloat = 0 then
      begin
        if not FCdsCreditoSeqcon.FindKey([qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsInteger, qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString]) then
        begin
          FCdsCreditoSeqcon.Append;
            FCdsCreditoSeqcon.FieldByName('CODEMP').AsString := qryDados.FieldByName('EMPBAI').AsString;
            FCdsCreditoSeqcon.FieldByName('SEQCON').AsInteger := qryDados.FieldByName('CTR_SEQCON').AsInteger;
            FCdsCreditoSeqcon.FieldByName('CODCLI').AsString := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString;
            FCdsCreditoSeqcon.FieldByName('DINORI').AsBoolean := qryDados.FieldByName('CTR_DINORI').AsFloat <> 0;
          FCdsCreditoSeqcon.Post;
        end
        else if (not FCdsCreditoSeqcon.FieldByName('DINORI').AsBoolean) and (qryDados.FieldByName('CTR_DINORI').AsFloat <> 0) then
        begin
          FCdsCreditoSeqcon.Edit;
            FCdsCreditoSeqcon.FieldByName('DINORI').AsBoolean := True;
          FCdsCreditoSeqcon.Post;
        end;
      end;

      qryDados.Next ;
    End ;
  finally
    FcdsCtrCredUtilSintetico.EnableControls ;
    FcdsCtrCredUtilAnalitico.EnableControls ;
  end ;
end;

function TLanConCTR.fCarregaDadosCadRecCreditoUtil(
  recParams: TParamsContasReceber): boolean;
var
  LqryCtrSintetico: TUniQuery ;
  LqryCtrAnalitico: TUniQuery ;
  LstrDtaRec: String ;
  LfltIndiceRateioCredito: Double ;
  LfltCreditoRateado: Double ;
  LfltSomaCreditoRateado: Double ;
  LfltDifCreditoRateado: Double ;
begin

  if fCfgDescCreditoDinheiroMesmoSeqCon = 'N' then
    Exit(True) ;

  If Assigned(FcdsCtrCredUtilSintetico) Then
    FreeAndNil(FcdsCtrCredUtilSintetico);

  If Assigned(FcdsCtrCredUtilAnalitico) Then
    FreeAndNil(FcdsCtrCredUtilAnalitico);

  If (recParams.blnCTR_DTABAN_Existe) Then
    LstrDtaRec := 'IFNULL(CADREC.CTR_DTABAN, CADREC.CTR_DTAREC)'
  else
    LstrDtaRec := 'CADREC.CTR_DTAREC' ;

  LqryCtrSintetico := fCriaQuery ;
  LqryCtrAnalitico := fCriaQuery ;
  try
    LqryCtrSintetico.Close;
    LqryCtrSintetico.SQL.Clear;
    LqryCtrSintetico.SQL.Add(' SELECT CTR_EMPBAI, ');
    LqryCtrSintetico.SQL.Add('       CTR_SEQCON, ');
    LqryCtrSintetico.SQL.Add('       CTR_CODCLI, ');
    LqryCtrSintetico.SQL.Add('       ' + LstrDtaRec + ' AS CTR_DTAREC, ');
    LqryCtrSintetico.SQL.Add('       SUM(CASE WHEN CTR_DINHEI < 0.00 THEN 1 ELSE 0.00 END) AS TEM_CREDITO, ');
    LqryCtrSintetico.SQL.Add('       COUNT(*) AS CNT, ');
    LqryCtrSintetico.SQL.Add('       SUM(CASE WHEN CTR_DINHEI > 0.00 THEN 1 ELSE 0.00 END) AS CNT_POSITIVO, ');
    LqryCtrSintetico.SQL.Add('       CASE WHEN SUM(CTR_DINHEI) < 0.00 THEN 0.00 ELSE SUM(CTR_DINHEI) END AS CTR_DINHEI, ');
    LqryCtrSintetico.SQL.Add('       SUM(CASE WHEN CTR_DINHEI < 0.00 THEN 0.00 ELSE CTR_DINHEI END) AS CTR_DINHEI_TOT, ');
    LqryCtrSintetico.SQL.Add('       SUM(CASE WHEN CTR_DINHEI < 0.00 THEN CTR_DINHEI ELSE 0.00 END) AS CTR_CREDITO ');
    LqryCtrSintetico.SQL.Add(' FROM CADREC  ');
    if fCfgCAgrDp = 'S' then
    begin
      LqryCtrSintetico.SQL.Add(' WHERE FALSE ');
    end
    else
    begin
      LqryCtrSintetico.SQL.Add(' WHERE TRUE AND CADREC.CTR_ESPDOC NOT IN ("FF","TR","DV","MI") ');
    end;
    LqryCtrSintetico.SQL.Add('     AND CTR_SEQCON <> 0 ');
    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      LqryCtrSintetico.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      LqryCtrSintetico.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryCtrSintetico.SQL.Add('    AND ' + LstrDtaRec + ' BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCtrSintetico.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryCtrSintetico.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryCtrSintetico)
      .fExecute ;

    LqryCtrSintetico.SQL.Add(' GROUP BY CTR_EMPBAI, CTR_SEQCON, IFNULL(CTR_DTABAN, CTR_DTAREC), CTR_CODCLI ');
    LqryCtrSintetico.SQL.Add(' HAVING SUM(CASE WHEN CTR_DINHEI < 0 THEN 1 ELSE 0 END) > 0 AND COUNT(*) > 1 ');

    LqryCtrSintetico.Open ;

    FcdsCtrCredUtilSintetico := fCriaClientDatset(LqryCtrSintetico);
    FcdsCtrCredUtilSintetico.IndexFieldNames := 'CTR_EMPBAI;CTR_SEQCON;CTR_DTAREC;CTR_CODCLI' ;
    FcdsCtrCredUtilSintetico.Open;

    LqryCtrAnalitico.Close;
    LqryCtrAnalitico.SQL.Clear;
    LqryCtrAnalitico.SQL.Add(' SELECT CTR_EMPBAI, ');
    LqryCtrAnalitico.SQL.Add('       CTR_SEQCON, ');
    LqryCtrAnalitico.SQL.Add('       CTR_CODCLI, ');
    LqryCtrAnalitico.SQL.Add('       ' + LstrDtaRec + ' AS CTR_DTAREC, ');
    LqryCtrAnalitico.SQL.Add('       AUTOINCREM, ');
    LqryCtrAnalitico.SQL.Add('       CTR_DINHEI ');
    LqryCtrAnalitico.SQL.Add(' FROM CADREC   ');
    if fCfgCAgrDp = 'S' then
    begin
      LqryCtrAnalitico.SQL.Add(' WHERE FALSE ');
    end
    else
    begin
      LqryCtrAnalitico.SQL.Add(' WHERE TRUE AND CADREC.CTR_ESPDOC NOT IN ("FF","TR","DV","MI") ');
    end;
    LqryCtrAnalitico.SQL.Add('     AND CTR_SEQCON <> 0 AND CTR_DINHEI > 0 ');
    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      LqryCtrAnalitico.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      LqryCtrAnalitico.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryCtrAnalitico.SQL.Add('    AND ' + LstrDtaRec + ' BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCtrAnalitico.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryCtrAnalitico.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryCtrAnalitico)
      .fExecute ;

    LqryCtrAnalitico.SQL.Add(' ORDER BY CTR_EMPBAI, CTR_SEQCON, IFNULL(CTR_DTABAN, CTR_DTAREC), CTR_CODCLI, AUTOINCREM ');
    LqryCtrAnalitico.Open ;

    FcdsCtrCredUtilAnalitico := fCriaClientDatset(LqryCtrAnalitico);
    FcdsCtrCredUtilAnalitico.IndexFieldNames := 'CTR_EMPBAI;CTR_SEQCON;CTR_DTAREC;CTR_CODCLI' ;
    FcdsCtrCredUtilAnalitico.Open;

    //ajusta a proporcionalidade do dinheiro
    FcdsCtrCredUtilSintetico.First ;
    while not FcdsCtrCredUtilSintetico.Eof do
    begin
      if (FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI').AsFloat = 0.00) and
         (FcdsCtrCredUtilSintetico.FieldByName('CNT_POSITIVO').AsInteger < 2)  then
      begin
        FcdsCtrCredUtilSintetico.Next ;
        Continue ;
      end ;

      if FcdsCtrCredUtilSintetico.FieldByName('CNT_POSITIVO').AsInteger < 2 then
      begin
        FcdsCtrCredUtilSintetico.Next ;
        Continue ;
      end ;

      if FcdsCtrCredUtilAnalitico.FindKey([FcdsCtrCredUtilSintetico.FieldByName('CTR_EMPBAI').AsString,
                                           FcdsCtrCredUtilSintetico.FieldByName('CTR_SEQCON').AsString,
                                           FcdsCtrCredUtilSintetico.FieldByName('CTR_DTAREC').AsDateTime,
                                           FcdsCtrCredUtilSintetico.FieldByName('CTR_CODCLI').AsString
                                          ]) then
      begin
        LfltSomaCreditoRateado := 0.00 ;
        while (not FcdsCtrCredUtilAnalitico.Eof) and
              (FcdsCtrCredUtilSintetico.FieldByName('CTR_EMPBAI').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_EMPBAI').AsString) and
              (FcdsCtrCredUtilSintetico.FieldByName('CTR_SEQCON').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_SEQCON').AsString) and
              (FcdsCtrCredUtilSintetico.FieldByName('CTR_DTAREC').AsDateTime = FcdsCtrCredUtilAnalitico.FieldByName('CTR_DTAREC').AsDateTime) and
              (FcdsCtrCredUtilSintetico.FieldByName('CTR_CODCLI').AsString = FcdsCtrCredUtilAnalitico.FieldByName('CTR_CODCLI').AsString) do
        begin
          LfltIndiceRateioCredito := ((FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat*100)/FcdsCtrCredUtilSintetico.FieldByName('CTR_DINHEI_TOT').AsFloat)/100 ;
          LfltCreditoRateado := fFormataFloat(FcdsCtrCredUtilSintetico.FieldByName('CTR_CREDITO').AsFloat*LfltIndiceRateioCredito, 2);
          LfltSomaCreditoRateado := LfltSomaCreditoRateado + LfltCreditoRateado ;
          FcdsCtrCredUtilAnalitico.Edit ;
          FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat := FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat + LfltCreditoRateado ;
          FcdsCtrCredUtilAnalitico.Post ;
          FcdsCtrCredUtilAnalitico.Next ;
        end ;

        if LfltSomaCreditoRateado <> FcdsCtrCredUtilSintetico.FieldByName('CTR_CREDITO').AsFloat then
        begin
          FcdsCtrCredUtilAnalitico.Prior ;
          LfltDifCreditoRateado := fFormataFloat(LfltSomaCreditoRateado - FcdsCtrCredUtilSintetico.FieldByName('CTR_CREDITO').AsFloat, 2) ;
          FcdsCtrCredUtilAnalitico.Edit ;
          FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat := FcdsCtrCredUtilAnalitico.FieldByName('CTR_DINHEI').AsFloat - LfltDifCreditoRateado ;
          FcdsCtrCredUtilAnalitico.Post ;
        end ;

      end ;

      FcdsCtrCredUtilSintetico.Next ;
    end ;

    Result := True;

  finally
    FreeAndNil(LqryCtrSintetico);
    FreeAndNil(LqryCtrAnalitico);
  end ;

end;

procedure TLanConCTR.pCarregaDadosCadRecLancadosPeriodoFechado(recParams: TParamsContasReceber);
var
  Lqry: TUniQuery;

begin
  if Assigned(FcdsCtrLancadosPeriodoFechado) then
    FreeAndNil(FcdsCtrLancadosPeriodoFechado);

  Lqry := fCriaQuery(nil);
  try
    Lqry.SQL.Clear;
    Lqry.SQL.Add(fGetSQLMovimentoContasReceberPeriodoFechado(recParams));

    if (not recParams.strCodEmp.IsEmpty) then
      Lqry.ParamByName('CODEMP').AsString := recParams.strCodEmp;

    if (recParams.dtaDtaIni > 0) then
    begin
      Lqry.ParamByName('DTAINI').AsDate := recParams.dtaDtaIni;
      Lqry.ParamByName('DTAFIN').AsDate := recParams.dtaDtaFin;
    end;

    Lqry.Open;

    FcdsCtrLancadosPeriodoFechado := fCriaClientDatset(Lqry, False);
    FcdsCtrLancadosPeriodoFechado.IndexFieldNames := 'CON_INCDOC';
    FcdsCtrLancadosPeriodoFechado.Open;
  finally
    FreeAndNil(Lqry);
  end;
end;

function TLanConCTR.fCarregaDadosCadRecValorAgrupado(recParams: TParamsContasReceber): boolean;
Var
  qryAgg : TUniQuery;
begin

  If Assigned(cdsCtrAgg) Then
    FreeAndNil(cdsCtrAgg);

  qryAgg := fCriaQuery(nil);
  Try
    qryAgg.Close;
    qryAgg.SQL.Clear;
    qryAgg.SQL.Add(' SELECT CADREC.AUTOINCREM, ');
    qryAgg.SQL.Add('      COALESCE(SUM( ');
    qryAgg.SQL.Add('             IF(AGR3.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('               ((COALESCE(AGR3.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR3.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR2.CTR_NUMDUP AND CTR_EMPAGR = AGR2.CTR_EMPAGR AND CTR_CODCLI = AGR2.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP,0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('               IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('             ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP,0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('             ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryAgg.SQL.Add('             ) ');
    qryAgg.SQL.Add('               ) ');
    qryAgg.SQL.Add('          ),1)    AS VAL_PROPORCIONAL, ');
    qryAgg.SQL.Add('      COALESCE(SUM( ');
    qryAgg.SQL.Add('           IF(AGR3.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('             (((CASE WHEN COALESCE(AGR3.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR3.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(IF(AGR3.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR2.CTR_NUMDUP AND CTR_EMPAGR = AGR2.CTR_EMPAGR AND CTR_CODCLI = AGR2.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP,0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('             IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('               (((CASE WHEN COALESCE(AGR2.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR2.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP,0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('               (((CASE WHEN COALESCE(AGR.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryAgg.SQL.Add('               ) ');
    qryAgg.SQL.Add('             ) ');
    qryAgg.SQL.Add('        ),1)    AS VAL_PROPORCIONAL_DESJUR ');
    qryAgg.SQL.Add(' FROM CADREC INNER JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CADREC.CTR_NUMDUP ');
    qryAgg.SQL.Add(' 		      AND AGR.CTR_EMPAGR = CADREC.CTR_CODEMP ');
    qryAgg.SQL.Add(' 		      AND AGR.CTR_CODCLI = CADREC.CTR_CODCLI AND CADREC.CTR_ESPDOC = "AG" ');
    qryAgg.SQL.Add('             LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
    qryAgg.SQL.Add(' 		       AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
    qryAgg.SQL.Add(' 		       AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');

    qryAgg.SQL.Add('             LEFT JOIN DUPAGR AGR3 ON AGR3.CTR_NUMAGR = AGR2.CTR_NUMDUP ');
    qryAgg.SQL.Add('           AND AGR3.CTR_EMPAGR = AGR2.CTR_CODEMP ');
    qryAgg.SQL.Add('           AND AGR3.CTR_CODCLI = AGR2.CTR_CODCLI ');

    if fCfgCAgrDp = 'S' then
    begin
      qryAgg.SQL.Add(' WHERE FALSE ');
    end
    else
    begin
      qryAgg.SQL.Add(' WHERE TRUE AND CADREC.CTR_ESPDOC NOT IN ("FF","TR","DV","MI") ');
    end;
    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      qryAgg.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      qryAgg.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      If (recParams.blnCTR_DTABAN_Existe) Then
        qryAgg.SQL.Add('    AND IFNULL(CADREC.CTR_DTABAN, CADREC.CTR_DTAREC) BETWEEN :DTAINI AND :DTAFIN ')
      Else
        qryAgg.SQL.Add('    AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
      qryAgg.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      qryAgg.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryAgg)
      .fExecute ;

    qryAgg.SQL.Add(' GROUP BY CADREC.AUTOINCREM');
    qryAgg.Open ;

    cdsCtrAgg := fCriaClientDatset(qryAgg, false);
    cdsCtrAgg.IndexFieldNames := 'AUTOINCREM' ;
    cdsCtrAgg.Open;

    Result := True;
  Finally
    FreeAndNil(qryAgg);
  End;
end;

procedure TLanConCTR.pCarregaDadosCCTransformadoEmAdt(recParams: TParamsContasReceber);
var
  LqryCtrConsulta: TUniQuery ;
begin
  if not FblnAdtCliExiste then
    Exit;

  if fPermiteContabilizarCCtransfAdtnoCtr then
    Exit ;

  If Assigned(FcdsDadosCCTransformadoEmAdt) Then
    FreeAndNil(FcdsDadosCCTransformadoEmAdt);

  LqryCtrConsulta := fCriaQuery() ;
  try
    LqryCtrConsulta.Close ;
    LqryCtrConsulta.SQL.Clear ;
    LqryCtrConsulta.SQL.Add('SELECT ') ;
    LqryCtrConsulta.SQL.Add('  CADREC.AUTOINCREM AS CTRINC ');
    LqryCtrConsulta.SQL.Add('FROM CADREC ') ;
    LqryCtrConsulta.SQL.Add('JOIN ADTCLI ON TRUE ') ;
    LqryCtrConsulta.SQL.Add('  AND ADT_SEQCON = CTR_SEQCON ');
    LqryCtrConsulta.SQL.Add('  AND ADT_CODEMP = CTR_EMPBAI ') ;
    LqryCtrConsulta.SQL.Add('  AND ADT_CODCLI = CTR_CODCLI ') ;
    LqryCtrConsulta.SQL.Add('  AND ADT_DTALAN = CTR_DTAREC ') ;
    LqryCtrConsulta.SQL.Add('  AND ADT_TIPLAN = "C" ') ;
    LqryCtrConsulta.SQL.Add('WHERE TRUE   ') ;
    LqryCtrConsulta.SQL.Add('  AND CTR_ESPDOC = "CC" ');
    LqryCtrConsulta.SQL.Add('  AND CTR_SEQCON <> 0 ');
    LqryCtrConsulta.SQL.Add('  AND IFNULL(ADT_ESTORN, "") <> "S" ');
    LqryCtrConsulta.SQL.Add('  AND IFNULL(CADREC.CTR_ADTCLI, "") <> "S" ');


    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      LqryCtrConsulta.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      LqryCtrConsulta.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryCtrConsulta.SQL.Add('  AND ' + IfThen(FblnDtaBanExiste, 'IFNULL(CTR_DTABAN, CTR_DTAREC)', 'CTR_DTAREC') + ' BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCtrConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryCtrConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryCtrConsulta)
      .fExecute ;

    LqryCtrConsulta.Open ;

    FcdsDadosCCTransformadoEmAdt := fCriaClientDatset(LqryCtrConsulta);
    FcdsDadosCCTransformadoEmAdt.IndexFieldNames := 'CTRINC' ;
    FcdsDadosCCTransformadoEmAdt.Open;

  finally
    FreeAndNil(LqryCtrConsulta) ;
  end ;
end;

procedure TLanConCTR.pCarregaOrigemCTR(ARecParams: TParamsContasReceber);
var
  LqryConsulta : TUniQuery ;
begin
  if Assigned(FcdsOrigemCtr) then
    FreeAndNil(FcdsOrigemCtr);

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT CTR_NUMDUP, CTR_PARCEL, CTR_CODCLI, CTR_CODEMP ') ;
    LqryConsulta.SQL.Add(' FROM LOGCTR ') ;
    LqryConsulta.SQL.Add(' WHERE CTR_NOMFRM = "frmCadCtaReceber" ') ;
    LqryConsulta.SQL.Add('       AND CTR_DESCRI LIKE "INCLUSAO%" ') ;

    if Length(ARecParams.arrIncDoc) > 0 then
    begin
      LqryConsulta.SQL.Add('   AND (CTR_NUMDUP, CTR_PARCEL, CTR_CODCLI, CTR_CODEMP, CTR_DTACAD) IN ') ;
      LqryConsulta.SQL.Add('       (SELECT CTR_NUMDUP, CTR_PARCEL, CTR_CODCLI, CTR_CODEMP, CTR_DTACAD FROM CADREC WHERE AUTOINCREM IN (' + fArrIncDocToString(ARecParams.arrIncDoc) + ') ) ') ;
    end
    else
    begin
      if (not ARecParams.strIncDoc.IsEmpty) then
      begin
        LqryConsulta.SQL.Add('   AND (CTR_NUMDUP, CTR_PARCEL, CTR_CODCLI, CTR_CODEMP, CTR_DTACAD) IN ') ;
        LqryConsulta.SQL.Add('       (SELECT CTR_NUMDUP, CTR_PARCEL, CTR_CODCLI, CTR_CODEMP, CTR_DTACAD FROM CADREC WHERE AUTOINCREM = :INCDOC) ') ;
        LqryConsulta.ParamByName('INCDOC').AsString := ARecParams.strIncDoc;
      end;
    end ;

    if (ARecParams.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('   AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryConsulta.ParamByName('DTAINI').AsDateTime := ARecParams.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDateTime := ARecParams.dtaDtaFin;
    end;

    if (not fEmptyStr(ARecParams.strCodEmp)) then
    begin
      LqryConsulta.SQL.Add('   AND CTR_CODEMP = :CODEMP ') ;
      LqryConsulta.ParamByName('CODEMP').AsString := ARecParams.strCodEmp;
    end;

    LqryConsulta.Open ;

    FcdsOrigemCtr := fCriaClientDatset(LqryConsulta) ;
    FcdsOrigemCtr.IndexFieldNames := 'CTR_NUMDUP;CTR_PARCEL;CTR_CODCLI;CTR_CODEMP' ;
    FcdsOrigemCtr.Open;
  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

procedure TLanConCTR.pCarregaParconAVistaSAI;
begin
  if Assigned(FcdsParConAVistaSAI) then
    FreeAndNil(FcdsParConAVistaSAI) ;

  FcdsParConAVistaSAI := fCarregaParconAvista('SAI');
end;

procedure TLanConCTR.pCriaCreditoSeqcon;
var
  LField: TFieldDef;
begin
  if Assigned(FcdsCreditoSeqcon) then
    FreeAndNil(FcdsCreditoSeqcon) ;

  FcdsCreditoSeqcon := TUniClientDataset.Create(nil);

  LField := FcdsCreditoSeqcon.FieldDefs.AddFieldDef;
  LField.Name := 'CODEMP';
  LField.DataType := ftString;
  LField.Size := 3;

  LField := FcdsCreditoSeqcon.FieldDefs.AddFieldDef;
  LField.Name := 'SEQCON';
  LField.DataType := ftInteger;

  LField := FcdsCreditoSeqcon.FieldDefs.AddFieldDef;
  LField.Name := 'CODCLI';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FcdsCreditoSeqcon.FieldDefs.AddFieldDef;
  LField.Name := 'DINORI';
  LField.DataType := ftBoolean;

  FcdsCreditoSeqcon.CreateDataSet;
  FcdsCreditoSeqcon.Open;
  FcdsCreditoSeqcon.IndexFieldNames := 'CODEMP;SEQCON;CODCLI';
end;

function TLanConCTR.fCgcEmpAdt(const AstrCodEmpAdt: String): string;
begin
  Result := '' ;
  if fEmptyStr(AstrCodEmpAdt) then
    Exit ;

  Result := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [AstrCodEmpAdt], False) ;
end;

function TLanConCTR.fDeletaLacamentosGeradosParaOutraEmpresa(const AblnTemControle: Boolean): boolean;
begin
  if not Generico.fEfetuaDelecaoLanCon then
    Exit(True);

  if not AblnTemControle then
    Exit(True);

  result := fDeletaLacamentosGeradosParaOutraEmpresaExec(recParCon.dtaDtaIni,
                                                            recParCon.dtaDtaFin,
                                                            recParCon.strCodEmp,
                                                            recParCon.strIncDoc,
                                                            recParCon.arrIncDoc,
                                                            pSetaTextoProgresso,
                                                            pgbProgresso);
end;

function TLanConCTR.fDeletaLanCon: Boolean;
begin
  Result := fDeletaLanConCTR;
end;

function TLanConCTR.fDeletaLanConCTR: Boolean;
Var
  qryDel: TUniQuery;
  LTipLan : string ;
  LblnTemControle: Boolean ;
begin
  if not Generico.fEfetuaDelecaoLanCon then
    Exit(True);

  LTipLan := 'CTR' ;

  LblnTemControle := fTemControleDelLanconOutrasEmpresasCTR(LTipLan) ;

  qryDel := fCriaQuery(Nil);
  Try

    // Req. 470760: no reprocesso so de documentos o check list do periodo fica.
    if (not recParCon.blnModoRobo) and (not recParCon.blnReprocessaErros) then
      Generico.pGravarCheckList(LTipLan) ;

    fDeletaLacamentosGeradosParaOutraEmpresa(LblnTemControle) ;

    if LblnTemControle then
    begin
      if not FblnDtaBanExiste then
      begin
        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
        qryDel.SQL.Add('               INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ') ;
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;
      end
      else
      begin
        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
        qryDel.SQL.Add('               INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ') ;
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;

        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
        qryDel.SQL.Add('               INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ') ;
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN  AND CADREC.CTR_DTABAN IS NULL ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;

      end ;

      //não tem cadrec mas tem lancon
      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(' DELETE LANCON ');
      qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
      qryDel.SQL.Add('               LEFT JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ') ;
      qryDel.SQL.add('    AND CADREC.AUTOINCREM IS NULL ') ;
      if (recParCon.dtaDtaIni > 0) then
        qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      If Not fEmptyStr(recParCon.strCodEmp) Then
        qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(qryDel)
        .fExecute ;

      pSetaParametrosGerLanCon(recParCon, qryDel);
      qryDel.ExecSQL;

      //cadrec estornado
      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(' DELETE LANCON ');
      qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
      qryDel.SQL.Add('               INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ') ;
      qryDel.SQL.Add('    AND CADREC.CTR_DTAREC IS NULL ');
      if (recParCon.dtaDtaIni > 0) then
        qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      If Not fEmptyStr(recParCon.strCodEmp) Then
        qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(qryDel)
        .fExecute ;

      pSetaParametrosGerLanCon(recParCon, qryDel);
      qryDel.ExecSQL;
    end
    else
    begin

      if not FblnDtaBanExiste then
      begin
        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;
      end
      else
      begin
        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;

        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE LANCON ');
        qryDel.SQL.Add('   FROM LANCON INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
        qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
        qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +')');
        if (recParCon.dtaDtaIni > 0) then
          qryDel.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND CADREC.CTR_DTABAN IS NULL ');

        If Not fEmptyStr(recParCon.strCodEmp) Then
          qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

        TTrataIncDocContabil
          .New
          .fColunaIncDoc('LANCON.CON_INCDOC')
          .fIncDoc(recParCon.strIncDoc)
          .fArrIncDoc(recParCon.arrIncDoc)
          .fQuerySql(qryDel)
          .fExecute ;

        pSetaParametrosGerLanCon(recParCon, qryDel);
        qryDel.ExecSQL;

      end ;

      //não tem cadrec mas tem lancon
      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(' DELETE LANCON ');
      qryDel.SQL.Add('   FROM LANCON LEFT JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      qryDel.SQL.Add('    AND CADREC.AUTOINCREM IS NULL ');
      if (recParCon.dtaDtaIni > 0) then
        qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      If Not fEmptyStr(recParCon.strCodEmp) Then
        qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(qryDel)
        .fExecute ;

      pSetaParametrosGerLanCon(recParCon, qryDel);
      qryDel.ExecSQL;

      //cadrec estornado
      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(' DELETE LANCON ');
      qryDel.SQL.Add('   FROM LANCON INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      qryDel.SQL.Add('    AND CADREC.CTR_DTAREC IS NULL ');
      if (recParCon.dtaDtaIni > 0) then
        qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      If Not fEmptyStr(recParCon.strCodEmp) Then
        qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(qryDel)
        .fExecute ;

      pSetaParametrosGerLanCon(recParCon, qryDel);
      qryDel.ExecSQL;
    end ;

    // apaga quando gerado pela dtacad
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' DELETE LANCON ');
    qryDel.SQL.Add('   FROM LANCON INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
    qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
    qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
    qryDel.SQL.Add('    AND ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) );

    if (recParCon.dtaDtaIni > 0) then
      qryDel.SQL.Add('  AND CADREC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN  ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
      qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryDel)
      .fExecute ;

    pSetaParametrosGerLanCon(recParCon, qryDel);
    qryDel.ExecSQL;

    if (not recParCon.blnModoRobo) and (not recParCon.blnReprocessaErros) then
      Result := Generico.fDeletaLotInc
    else
      Result := True;
  Finally
    FreeAndNil(qryDel);
  End;
end;

class function TLanConCTR.fFiltroCCOriginadoAdt(const AblnDtaBanExiste: Boolean; const AstrAliasLancon: string = ''): string;
var
  LstrAlias: string;
  LstrDtaBaixa: string;
begin
  LstrAlias := IfThen(AstrAliasLancon = '', 'LANCON', AstrAliasLancon);
  LstrDtaBaixa := IfThen(AblnDtaBanExiste, 'IFNULL(CADREC.CTR_DTABAN, CADREC.CTR_DTAREC)', 'CADREC.CTR_DTAREC');

  // A utilizacao parcial do credito transforma a linha original em baixa (SEQBAI > 0) e cria
  // outra de saldo com SEQBAI = 0. O lancamento de criacao gerado ANTES da utilizacao continua
  // apontando para a linha original, e se reconhece pela data: DTACAD, diferente da data em que
  // o lancamento da baixa e gerado (a mesma do DTAENT do fGetSQLMovimentoContasReceber).
  // Sem isso, a geracao do periodo da baixa apaga o lancamento de criacao (Req. 464593).
  Result := ' (CADREC.CTR_ESPDOC = "CC" AND CADREC.CTR_GRVORI < 0.0 AND CADREC.CTR_ADTCLI = "S"' +
            ' AND CADREC.CTR_DTACAD = ' + LstrAlias + '.CON_DTALAN' +
            ' AND (CADREC.CTR_SEQBAI = 0 OR ' + LstrAlias + '.CON_DTALAN <> ' + LstrDtaBaixa + ')) ';
end;

function TLanConCTR.fFormaPagamentoZeradaTransfCred: boolean;
begin
  Result := False;

  if not blnCfgCreCtr then
    Exit;

  Result := FcdsCreditoSeqCon.FindKey([qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsInteger, qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString]);
end;

function TLanConCTR.fFormaPagamentoZeradaTransfCredESemValOri: boolean;
var
  LblnFpgZerada: Boolean;
begin
  Result := False;

  LblnFpgZerada := fFormaPagamentoZeradaTransfCred;

  if not LblnFpgZerada then
    Exit;

  Result := not FcdsCreditoSeqCon.FieldByName('DINORI').AsBoolean;
end;

function TLanConCTR.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPagAux : string;
    strPlaCta : String;
    strCodCta: String;
    strEveNec: string;
    strCodEve: string;
    recParGrava : TParametrosGravaLanCon;
    fltValorProporcionalAgrupado : double ;
    fltValorProporcionalAgrupadoJurDes : double ;
    blnFlagCreditoDesconto : boolean ;
    blnFlagCreditoJuro : boolean ;
    strPagameCredito : String;
    fltAlqPisRf, fltAlqCofinsRf: double;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;
  strCTRInc := '';

  fltAlqPisRf := fAlqPisRF;
  fltAlqCofinsRf := fAlqCofinsRF;

  qryDados.BeforeScroll := nil ;
  try
    pAjustaDadosCadRecCreditoDinheiro ;
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      if (not fTemFormaPagamento) and (not fFormaPagamentoZeradaTransfCred) then
      begin
        Generico.pAdicionarWarning('Título sem forma de pagamento preenchido',
                                     qryDados,
                                     '',
                                     '',
                                     Generico.strTipoLancamento,
                                     '',
                                     '',
                                     '',
                                     False
                                     );
      end ;

      fltValorProporcionalAgrupado := fGetCadRecValorAgrupado(qryDados.FieldByName('CTRINC').AsString, False) ;
      fltValorProporcionalAgrupadoJurDes := fGetCadRecValorAgrupado(qryDados.FieldByName('CTRINC').AsString, True) ;
      qryDados.Edit ;
      qryDados.FieldByName('CTR_AGRORI').AsFloat := qryDados.FieldByName('CTR_AGRORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;

      qryDados.FieldByName('CTR_VALDE2').AsFloat := qryDados.FieldByName('CTR_VALDE2').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_VALJU2').AsFloat := qryDados.FieldByName('CTR_VALJU2').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      qryDados.FieldByName('CTR_DINJUR').AsFloat := qryDados.FieldByName('CTR_DINJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_DINORI').AsFloat := qryDados.FieldByName('CTR_DINORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
      qryDados.FieldByName('CTR_DINDES').AsFloat := qryDados.FieldByName('CTR_DINDES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_DINCOB').AsFloat := qryDados.FieldByName('CTR_DINCOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      qryDados.FieldByName('CTR_CHAJUR').AsFloat := qryDados.FieldByName('CTR_CHAJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CHAORI').AsFloat := qryDados.FieldByName('CTR_CHAORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
      qryDados.FieldByName('CTR_CHADES').AsFloat := qryDados.FieldByName('CTR_CHADES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CHACOB').AsFloat := qryDados.FieldByName('CTR_CHACOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      qryDados.FieldByName('CTR_CHPJUR').AsFloat := qryDados.FieldByName('CTR_CHPJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CHPORI').AsFloat := qryDados.FieldByName('CTR_CHPORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
      qryDados.FieldByName('CTR_CHPDES').AsFloat := qryDados.FieldByName('CTR_CHPDES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CHPCOB').AsFloat := qryDados.FieldByName('CTR_CHPCOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      qryDados.FieldByName('CTR_CARJUR').AsFloat := qryDados.FieldByName('CTR_CARJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CARORI').AsFloat := qryDados.FieldByName('CTR_CARORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
      qryDados.FieldByName('CTR_CARDES').AsFloat := qryDados.FieldByName('CTR_CARDES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_CARCOB').AsFloat := qryDados.FieldByName('CTR_CARCOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      qryDados.FieldByName('CTR_ORDJUR').AsFloat := qryDados.FieldByName('CTR_ORDJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_ORDORI').AsFloat := qryDados.FieldByName('CTR_ORDORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
      qryDados.FieldByName('CTR_ORDDES').AsFloat := qryDados.FieldByName('CTR_ORDDES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
      qryDados.FieldByName('CTR_ORDCOB').AsFloat := qryDados.FieldByName('CTR_ORDCOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

      if blnCtrCreditExiste then
      begin
        qryDados.FieldByName('CTR_CREJUR').AsFloat := qryDados.FieldByName('CTR_CREJUR').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
        qryDados.FieldByName('CTR_CREORI').AsFloat := qryDados.FieldByName('CTR_CREORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
        qryDados.FieldByName('CTR_CREDES').AsFloat := qryDados.FieldByName('CTR_CREDES').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;
        qryDados.FieldByName('CTR_CRECOB').AsFloat := qryDados.FieldByName('CTR_CRECOB').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL_DESJUR').AsFloat, qryDados.FieldByName('ESPDOC').AsString = 'AG')/fltValorProporcionalAgrupadoJurDes) ;

        qryDados.FieldByName('CTR_CREDIT').AsFloat := qryDados.FieldByName('CTR_CREORI').AsFloat + qryDados.FieldByName('CTR_CREJUR').AsFloat - qryDados.FieldByName('CTR_CREDES').AsFloat ;
      end;

      qryDados.FieldByName('CTR_DINHEI').AsFloat := qryDados.FieldByName('CTR_DINORI').AsFloat + qryDados.FieldByName('CTR_DINJUR').AsFloat - qryDados.FieldByName('CTR_DINDES').AsFloat + qryDados.FieldByName('CTR_DINCOB').AsFloat;
      qryDados.FieldByName('CTR_CHQPRE').AsFloat := qryDados.FieldByName('CTR_CHPORI').AsFloat + qryDados.FieldByName('CTR_CHPJUR').AsFloat - qryDados.FieldByName('CTR_CHPDES').AsFloat + qryDados.FieldByName('CTR_CHPCOB').AsFloat;
      qryDados.FieldByName('CTR_CHQAVI').AsFloat := qryDados.FieldByName('CTR_CHAORI').AsFloat + qryDados.FieldByName('CTR_CHAJUR').AsFloat - qryDados.FieldByName('CTR_CHADES').AsFloat + qryDados.FieldByName('CTR_CHACOB').AsFloat;
      qryDados.FieldByName('CTR_CARTAO').AsFloat := qryDados.FieldByName('CTR_CARORI').AsFloat + qryDados.FieldByName('CTR_CARJUR').AsFloat - qryDados.FieldByName('CTR_CARDES').AsFloat + qryDados.FieldByName('CTR_CARCOB').AsFloat;
      qryDados.FieldByName('CTR_ORDPAG').AsFloat := qryDados.FieldByName('CTR_ORDORI').AsFloat + qryDados.FieldByName('CTR_ORDJUR').AsFloat - qryDados.FieldByName('CTR_ORDDES').AsFloat + qryDados.FieldByName('CTR_ORDCOB').AsFloat;
      qryDados.FieldByName('EMP_CGCADT').AsString := fCgcEmpAdt(qryDados.FieldByName('EMPADT').AsString) ;

      strPagAux := fRetPagamentoPcr;
      strPagAux := IfThen(fEmptyStr(strPagAux), qryDados.FieldByName('TIPO_PAGAMENTO').AsString, strPagAux);
      qryDados.FieldByName('TIPO_PAGAMENTO').AsString := strPagAux;

      qryDados.FieldByName('CTR_VPISRF').AsFloat := fFormataFloat(qryDados.FieldByName('CTR_VPISRF').AsFloat * fltAlqPisRf, 2);
      qryDados.FieldByName('CTR_VCOFRF').AsFloat := fFormataFloat(qryDados.FieldByName('CTR_VCOFRF').AsFloat * fltAlqCofinsRf, 2);

      qryDados.post ;
      qryDados.Next;
    End;

    ////ajusta as informações de credito. (caso tenha a coluna)
    pAjustaInformacaoCredito ;
    ////

    pAjustaAdtTransformadoEmCC ;

    pAcertaArredondamentoTotalAgrupadas(qryDados) ;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      pgbProgresso.Position := qryDados.RecNo;
      pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "CTR": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

      strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString;
      strPagameCredito := qryDados.FieldByName('TIPO_PAGAMENTO_CREDITO').AsString;

      if Assigned(FcdsCtrLancadosPeriodoFechado) and
         FcdsCtrLancadosPeriodoFechado.FindKey([qryDados.FieldByName('CTRINC').AsString]) then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento,
                                                             'O título do Contas a Receber, foi lançado originalmente na contabilidade no dia ' +
                                                              DateToStr(FcdsCtrLancadosPeriodoFechado.FieldByName('CON_DTALAN').AsDateTime) + '. ' +
                                                              'Para reprocessar esse título, o fechamento do período ' +
                                                              DateToStr(FcdsCtrLancadosPeriodoFechado.FieldByName('CON_FECINI').AsDateTime) + ' a ' +
                                                              DateToStr(FcdsCtrLancadosPeriodoFechado.FieldByName('CON_FECFIN').AsDateTime) + ' ' +
                                                              'para a empresa ' + FcdsCtrLancadosPeriodoFechado.FieldByName('CON_CODEMP').AsString + ' deverá ser excluído!' ),
                                     qryDados,
                                     '',
                                     '',
                                     Generico.strTipoLancamento,
                                     '',
                                     '',
                                     '',
                                     False);
        qryDados.Next;
        Continue;
      end;

      if fEhCCTransformadoEmAdt(qryDados.FieldByName('CTRINC').AsString, qryDados.FieldByName('ESPDOC').AsString) then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Documento "CC" transformado em Adiantamento, não contabiliza pelo CTR'), qryDados);
        qryDados.Next;
        Continue;
      end;

      if (strPagame = 'Pagamentos Avulsos') and (qryDados.FieldByName('POR_EXPAUT').AsString = 'N') then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Portador do título com o código '+qryDados.FieldByName('CODIGO_PORTADOR_TIT').AsString+', configurado para não exportar [Exportar pelo Autsi]!'), qryDados);
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

      if (strPagame = 'Pagamentos Fatura') and
         (fStatusCndPag(qryDados.FieldByName('CONDICAO_PAGTO').AsString) = A_VISTA) and
         (fParametrizouTipoAVista(FcdsParConAVistaSAI, qryDados.FieldByName('DTAENT').AsDateTime, qryDados.FieldByName('CLASSIFICACAO_FISCAL').AsString)) and
         (fCfgCtrpvi = 'N') and
         (qryDados.FieldByName('ESPDOC').AsString <> 'AG') then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'CTR - A Vista não exportado, pois há configuração nos parametros da contabilidade para SAI - A Vista!'), qryDados);
        qryDados.Next;
        Continue;
      end;

      if (not fTemFormaPagamento) and fFormaPagamentoZeradaTransfCredESemValOri then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Nenhum valor atende aos parâmetros da PARCON!'), qryDados);
        qryDados.Next;
        Continue;
      end;

      strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString).fConsultaEvento(FstrCentroCustoDefault) ;
      fltDinhei   := qryDados.FieldByName('CTR_PGTDIN').AsFloat;
      fltCredit := 0 ;
      fltValOriCre := 0 ;
      fltJurosCre := 0 ;
      fltDescontoCre := 0 ;
      fltCobrancaCre := 0;
      if blnCtrCreditExiste then
      begin
        fltCredit   := qryDados.FieldByName('CTR_PGTCRE').AsFloat;
        fltValOriCre   := qryDados.FieldByName('CTR_CREORI_CONF').AsFloat;
        fltJurosCre    := qryDados.FieldByName('CTR_CREJUR_CONF').AsFloat;
        fltDescontoCre    := qryDados.FieldByName('CTR_CREDES_CONF').AsFloat;
        fltCobrancaCre    := qryDados.FieldByName('CTR_CRECOB_CONF').AsFloat;
      end;
      fltChqPre   := qryDados.FieldByName('CTR_PGTCHP').AsFloat;
      fltChqAvi   := qryDados.FieldByName('CTR_PGTCHA').AsFloat;
      fltCartao   := qryDados.FieldByName('CTR_PGTCAR').AsFloat;
      fltOrdPag   := qryDados.FieldByName('CTR_PGTORP').AsFloat;
      fltValOriDin   := qryDados.FieldByName('CTR_DINORI_CONF').AsFloat;
      fltValOriCha   := qryDados.FieldByName('CTR_CHAORI_CONF').AsFloat;
      fltValOriChp   := qryDados.FieldByName('CTR_CHPORI_CONF').AsFloat;
      fltValOriCar   := qryDados.FieldByName('CTR_CARORI_CONF').AsFloat;
      fltValOriOrP   := qryDados.FieldByName('CTR_ORDORI_CONF').AsFloat;
      fltJurosDin    := qryDados.FieldByName('CTR_DINJUR_CONF').AsFloat;
      fltJurosCha    := qryDados.FieldByName('CTR_CHAJUR_CONF').AsFloat;
      fltJurosChp    := qryDados.FieldByName('CTR_CHPJUR_CONF').AsFloat;
      fltJurosCar    := qryDados.FieldByName('CTR_CARJUR_CONF').AsFloat;
      fltJurosOrP    := qryDados.FieldByName('CTR_ORDJUR_CONF').AsFloat;
      fltCobrancaDin    := qryDados.FieldByName('CTR_DINCOB_CONF').AsFloat;
      fltCobrancaCha    := qryDados.FieldByName('CTR_CHACOB_CONF').AsFloat;
      fltCobrancaChp    := qryDados.FieldByName('CTR_CHPCOB_CONF').AsFloat;
      fltCobrancaCar    := qryDados.FieldByName('CTR_CARCOB_CONF').AsFloat;
      fltCobrancaOrP    := qryDados.FieldByName('CTR_ORDCOB_CONF').AsFloat;
      fltDescontoDin    := qryDados.FieldByName('CTR_DINDES_CONF').AsFloat;
      fltDescontoCha    := qryDados.FieldByName('CTR_CHADES_CONF').AsFloat;
      fltDescontoChp    := qryDados.FieldByName('CTR_CHPDES_CONF').AsFloat;
      fltDescontoCar    := qryDados.FieldByName('CTR_CARDES_CONF').AsFloat;
      fltDescontoOrP    := qryDados.FieldByName('CTR_ORDDES_CONF').AsFloat;

      if fEhAgrupamentoCTR(qryDados) then
      begin
        if qryDados.FieldByName('CTRINC').AsString <> strCTRInc then
        begin
          strCTRInc := qryDados.FieldByName('CTRINC').AsString;
          pZerarValores;
        end;
        pSomarValores;

        qryDados.Next;
        if (qryDados.FieldByName('CTRINC').AsString <> strCTRInc) or (qryDados.Eof) then
        begin
          if not qryDados.Eof then
            qryDados.Prior;

          fltDifOriDin := fFormataFloat(fltValOriDin - fltRatOriDin, 2);
          fltDifOriCha := fFormataFloat(fltValOriCha - fltRatOriCha, 2);
          fltDifOriChp := fFormataFloat(fltValOriChp - fltRatOriChp, 2);
          fltDifOriCar := fFormataFloat(fltValOriCar - fltRatOriCar, 2);
          fltDifOriOrP := fFormataFloat(fltValOriOrP - fltRatOriOrP, 2);
          fltDifOriCre := fFormataFloat(fltValOriCre - fltRatOriCre, 2);
          fltDifJurDin := fFormataFloat(fltJurosDin - fltRatJurDin, 2);
          fltDifJurCha := fFormataFloat(fltJurosCha - fltRatJurCha, 2);
          fltDifJurChp := fFormataFloat(fltJurosChp - fltRatJurChp, 2);
          fltDifJurCar := fFormataFloat(fltJurosCar - fltRatJurCar, 2);
          fltDifJurOrP := fFormataFloat(fltJurosOrP - fltRatJurOrP, 2);
          fltDifJurCre := fFormataFloat(fltJurosCre - fltRatJurCre, 2);
          fltDifCobDin := fFormataFloat(fltCobrancaDin - fltRatCobDin, 2);
          fltDifCobCha := fFormataFloat(fltCobrancaCha - fltRatCobCha, 2);
          fltDifCobChp := fFormataFloat(fltCobrancaChp - fltRatCobChp, 2);
          fltDifCobCar := fFormataFloat(fltCobrancaCar - fltRatCobCar, 2);
          fltDifCobOrP := fFormataFloat(fltCobrancaOrP - fltRatCobOrP, 2);
          fltDifCobCre := fFormataFloat(fltCobrancaCre - fltRatCobCre, 2);
          fltDifDesDin := fFormataFloat(fltDescontoDin - fltRatDesDin, 2);
          fltDifDesCha := fFormataFloat(fltDescontoCha - fltRatDesCha, 2);
          fltDifDesChp := fFormataFloat(fltDescontoChp - fltRatDesChp, 2);
          fltDifDesCar := fFormataFloat(fltDescontoCar - fltRatDesCar, 2);
          fltDifDesOrP := fFormataFloat(fltDescontoOrP - fltRatDesOrP, 2);
          fltDifDesCre := fFormataFloat(fltDescontoCre - fltRatDesCre, 2);

          fltDifDes2 := fFormataFloat((fltDescontoDin+fltDescontoCha+fltDescontoChp+fltDescontoCar+fltDescontoOrP+fltDescontoCre) - fltRatDes2, 2);
          fltDifJur2 := fFormataFloat((fltJurosDin+fltJurosCha+fltJurosChp+fltJurosCar+fltJurosOrP+fltJurosCre) - fltRatJur2, 2);

          fltDifDin := fFormataFloat(fltDinhei - fltRatDin, 2);
          fltDifCre := fFormataFloat(fltCredit - fltRatCre, 2);
          fltDifChP := fFormataFloat(fltChqPre - fltRatChP, 2);
          fltDifChA := fFormataFloat(fltChqAvi - fltRatChA, 2);
          fltDifCar := fFormataFloat(fltCartao - fltRatCar, 2);
          fltDifOrP := fFormataFloat(fltOrdPag - fltRatOrP, 2);
          fltDifCre := fFormataFloat(fltCrePag - fltRatCre, 2);

          if (fltDifJurOrP <> 0) or (fltDifJurCar <> 0) or (fltDifJurChp <> 0) or (fltDifJurCha <> 0) or (fltDifJurDin <> 0) or (fltDifJurCre <> 0)
             or (fltDifCobOrP <> 0) or (fltDifCobCar <> 0) or (fltDifCobChp <> 0) or (fltDifCobCha <> 0) or (fltDifCobDin <> 0) or (fltDifCobCre <> 0)
             or (fltDifDesOrP <> 0) or (fltDifDesCar <> 0) or (fltDifDesChp <> 0) or (fltDifDesCha <> 0) or (fltDifDesDin <> 0) or (fltDifDesCre <> 0)
             or (fltDifDin <> 0) or (fltDifChP <> 0)
             or (fltDifChA <> 0) or (fltDifCar <> 0) or (fltDifOrP <> 0) or (fltDifOriDin <> 0)
             or (fltDifOriCha <> 0) or (fltDifOriChp <> 0) or (fltDifOriCar <> 0) or (fltDifOriOrP <> 0) or (fltDifOriCre <> 0)
             or (fltDifDes2 <> 0) or (fltDifJur2 <> 0) or (fltDifCre <> 0) or (fltDifCre <> 0) then
          begin
            pAlterarValores;
          end;
        end
        else
        begin
          qryDados.Prior;
        end;
      end;

      strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
      strCodCta := qryDados.FieldByName('CODIGO_PLANO_CONTA_BAIXA').AsString;

      FillChar(recParGrava, SizeOf(recParGrava), #0);
      recParGrava.blnAdiantamento := (qryDados.FieldByName('CTR_ADTCLI').AsString = 'S');
      recParGrava.blnEmpresaDoCadastroDiferenteDaBaixa := fEmpresaDoCadastroDiferenteDaBaixa(qryDados.FieldByName('EMPCAD').AsString, qryDados.FieldByName('EMPBAI').AsString);
      recParGrava.strEmpresaCadastro := qryDados.FieldByName('EMPCAD').AsString;
      recParGrava.strEmpresaBaixa := qryDados.FieldByName('EMPBAI').AsString;
      ///Titulos PDD
      if blnTitPDDExiste then
      begin
        recParGrava.strTituloPDD := qryDados.FieldByName('POR_TITPDD').AsString ;
      end
      else
      begin
        recParGrava.strTituloPDD := '' ;
      end;
      recParGrava.strEmpresaAdt := qryDados.FieldByName('EMPADT').AsString;
      recParGrava.blnEmpresaDoCadastroAdtDiferenteDaBaixa := fEmpresaDoCadastroAdtDiferenteDaBaixa(qryDados.FieldByName('EMPADT').AsString, qryDados.FieldByName('EMPBAI').AsString);
      recParGrava.strEspDoc := qryDados.FieldByName('ESPDOC').AsString ;
      recParGrava.strAdtTransformadoCC := qryDados.FieldByName('ADT_CC').AsString ;
      recParGrava.blnCFG_EXCREP := FblnCFG_EXCREP ;
      Generico.pSetaParametrosGravacao(recParGrava);

      blnFlagCreditoDesconto := False ;
      blnFlagCreditoJuro := False ;

      //CRÉDITO
      if (Generico.blnParametrizouCreditoNaFormaDePagto) and (qryDados.FieldByName('CTR_DINHEI').AsFloat < 0) and (qryDados.FieldByName('CTR_DINORI').AsFloat < 0) then
      begin
        Generico.pGravaLancto('CTR_DINHEI', DES_VALOR_RECEBIDO, strPlaCta, FPG_CREDITO, strCodEve, strPagame, '', '', '', '', strCodCta) ;

        if qryDados.FieldByName('CTR_DINJUR').AsFloat <> 0.00 then
        begin
          blnFlagCreditoJuro := True ;
          Generico.pGravaLancto('CTR_DINJUR', DES_VALOR_JUROS,    strPlaCta, FPG_CREDITO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta) ;
        end;
        if qryDados.FieldByName('CTR_DINDES').AsFloat <> 0.00 then
        begin
          blnFlagCreditoDesconto := True ;
          Generico.pGravaLancto('CTR_DINDES', DES_VALOR_DESCONTO, strPlaCta, FPG_CREDITO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta) ;
        end;
      end
      else
      begin
        //DINHEIRO
        Generico.pGravaLancto('CTR_DINHEI', DES_VALOR_RECEBIDO, strPlaCta, FPG_DINHEIRO, strCodEve, strPagame, '', '', '', '', strCodCta) ;
      end;
      Generico.pGravaLancto('CTR_DINHEI', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      if (Generico.blnParametrizouCreditoNaFormaDePagto) and (qryDados.FieldByName('CTR_DINHEI').AsFloat < 0) and (qryDados.FieldByName('CTR_DINORI').AsFloat < 0) then
      begin
        Generico.pGravaLancto('CTR_DINORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_CREDITO, strCodEve, strPagame, '', '', '', '', strCodCta) ;
      end
      else
      begin
        Generico.pGravaLancto('CTR_DINORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_DINHEIRO, strCodEve, strPagame, '', '', '', '', strCodCta) ;
      end;

      Generico.pGravaLancto('CTR_DINORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      //CRÉDITO
      if blnCtrCreditExiste then
      begin
        Generico.pGravaLancto('CTR_CREDIT', DES_VALOR_RECEBIDO, strPlaCta, FPG_CREDITO, strCodEve, strPagameCredito, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CREORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_CREDITO, strCodEve, strPagameCredito, '', '', '', '', strCodCta);
        If (qryDados.FieldByName('CTR_VALJUR').AsFloat > 0) Then
        Begin
          Generico.pGravaLancto('CTR_CREJUR', DES_VALOR_JUROS, strPlaCta, FPG_CREDITO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagameCredito, '', '', '', '', strCodCta);
        End;
        If (qryDados.FieldByName('CTR_VALDES').AsFloat > 0) Then
        Begin
          Generico.pGravaLancto('CTR_CREDES', DES_VALOR_DESCONTO, strPlaCta, FPG_CREDITO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagameCredito, '', '', '', '', strCodCta);
        End;
        If (qryDados.FieldByName('CTR_VALCOB').AsFloat > 0) Then
        Begin
          Generico.pGravaLancto('CTR_CRECOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_CREDITO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagameCredito, '', '', '', '', strCodCta);
        End;
      end;

      //CHEQUE A VISTA
      Generico.pGravaLancto('CTR_CHQAVI', DES_VALOR_RECEBIDO, strPlaCta, FPG_CHEQUE_VISTA, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHAORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_CHEQUE_VISTA, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHQAVI', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHAORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      //CHEQUE PRÉ
      Generico.pGravaLancto('CTR_CHQPRE', DES_VALOR_RECEBIDO, strPlaCta, FPG_CHEQUE_PRE, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHPORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_CHEQUE_PRE, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHQPRE', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CHPORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      //CARTÃO
      Generico.pGravaLancto('CTR_CARTAO', DES_VALOR_RECEBIDO, strPlaCta, FPG_CARTAO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CARORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_CARTAO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CARTAO', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_CARORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      //ORDEM DE PAGAMENTO
      Generico.pGravaLancto('CTR_ORDPAG', DES_VALOR_RECEBIDO, strPlaCta, FPG_ORDPAG, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_ORDORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ORDPAG, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_ORDPAG', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);
      Generico.pGravaLancto('CTR_ORDORI', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, strCodEve, strPagame, '', '', '', '', strCodCta);

      If (qryDados.FieldByName('CTR_VALJUR').AsFloat > 0) Then
      Begin
        if not blnFlagCreditoJuro then
        begin
          Generico.pGravaLancto('CTR_DINJUR', DES_VALOR_JUROS,    strPlaCta, FPG_DINHEIRO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        end;
        Generico.pGravaLancto('CTR_CHAJUR', DES_VALOR_JUROS,    strPlaCta, FPG_CHEQUE_VISTA, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPJUR', DES_VALOR_JUROS,    strPlaCta, FPG_CHEQUE_PRE, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARJUR', DES_VALOR_JUROS,    strPlaCta, FPG_CARTAO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ORDPAG, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);

        Generico.pGravaLancto('CTR_DINJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHAJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDJUR', DES_VALOR_JUROS,    strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);

        Generico.pGravaLancto('CTR_VPISRF', DES_VALOR_PIS_RF,   strPlaCta, FPG_DINHEIRO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_VCOFRF', DES_VALOR_COF_RF,   strPlaCta, FPG_DINHEIRO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_JUROS), strPagame, '', '', '', '', strCodCta);
      End;

      If (qryDados.FieldByName('CTR_VALDES').AsFloat > 0) Then
      Begin
        if not blnFlagCreditoDesconto then
        begin
          Generico.pGravaLancto('CTR_DINDES', DES_VALOR_DESCONTO, strPlaCta, FPG_DINHEIRO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        end;
        Generico.pGravaLancto('CTR_CHADES', DES_VALOR_DESCONTO, strPlaCta, FPG_CHEQUE_VISTA, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPDES', DES_VALOR_DESCONTO, strPlaCta, FPG_CHEQUE_PRE, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARDES', DES_VALOR_DESCONTO, strPlaCta, FPG_CARTAO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDDES', DES_VALOR_DESCONTO, strPlaCta, FPG_ORDPAG, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);

        Generico.pGravaLancto('CTR_DINDES', DES_VALOR_DESCONTO, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHADES', DES_VALOR_DESCONTO, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPDES', DES_VALOR_DESCONTO, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARDES', DES_VALOR_DESCONTO, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDDES', DES_VALOR_DESCONTO, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESCONTO), strPagame, '', '', '', '', strCodCta);
      End;

      If (qryDados.FieldByName('CTR_VALCOB').AsFloat > 0) Then
      Begin
        if not blnFlagCreditoDesconto then
        begin
          Generico.pGravaLancto('CTR_DINCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_DINHEIRO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        end;
        Generico.pGravaLancto('CTR_CHACOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_CHEQUE_VISTA, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_CHEQUE_PRE, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_CARTAO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ORDPAG, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);

        Generico.pGravaLancto('CTR_DINCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHACOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CHPCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_CARCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
        Generico.pGravaLancto('CTR_ORDCOB', DES_VALOR_DESPESAS_COBRANCA, strPlaCta, FPG_ADIANTAMENTO, fRetornaEventoDescontoJuros(strCodEve, DES_VALOR_DESPESAS_COBRANCA), strPagame, '', '', '', '', strCodCta);
      End;

      if fTituloComDescontoTotal then
      begin
        if qryDados.FieldByName('CTR_VALORI').AsFloat >= 0  then
        begin
          Generico.pGravaLancto('CTR_VALDE2', DES_VALOR_ORIGINAL, strPlaCta, FPG_DESCONTO_TOTAL, strCodEve, strPagame, '', '', '', '', strCodCta);
        end
        else
        begin
          Generico.pGravaLancto('CTR_VALJU2', DES_VALOR_ORIGINAL, strPlaCta, FPG_DESCONTO_TOTAL_CREDITO, strCodEve, strPagame, '', '', '', '', strCodCta);
        end;
      end;

      qryDados.Next;
    End;
    qryDados.First ;
  finally
    qryDados.BeforeScroll := Generico.pBeforeScroll ;
  end;
  //////valida o credito - debito = resultado zero pelo evento pBeforeScroll
  while not qryDados.Eof do
  begin
    qryDados.Next;
  end;
  Result := True;
end;

function TLanConCTR.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCTR.fEhAgrupamentoCTR(const AqryCTR: TUniQuery): Boolean;
begin
  Result := AqryCTR.FieldByName('ESPDOC').AsString = 'AG' ;
end;

function TLanConCTR.fEhCCTransformadoEmAdt(const strAutoInc, AstrEspDoc: string): Boolean;
begin
  Result := False;

  if AstrEspDoc <> 'CC' then
    Exit;

  if not FblnAdtCliExiste then
    Exit;

  if not Assigned(FcdsDadosCCTransformadoEmAdt) then
    Exit;

  Result := FcdsDadosCCTransformadoEmAdt.FindKey([strAutoInc]) ;
end;

function TLanConCTR.fEmpresaDoCadastroDiferenteDaBaixa(const AEmpresaCadastro,
  AEmpresaDaBaixa: string): boolean;
begin
  Result := False;

  if AEmpresaCadastro.IsEmpty then
    Exit;

  if AEmpresaDaBaixa.IsEmpty then
    Exit;

  Result := (AEmpresaCadastro <> AEmpresaDaBaixa);
end;

function TLanConCTR.fGetCadRecValorAgrupado(const strAutoInc: string; const AJurDes: boolean): double;
begin
  if fCfgCAgrDp = 'S' then
  begin
    result := 100 ;
    exit ;
  end;
  result := 1 ;
  if cdsCtrAgg.FindKey([strAutoInc]) then
  begin
    if not AJurDes then
    begin
      result := cdsCtrAgg.FieldByName('VAL_PROPORCIONAL').AsFloat ;
    end
    else
    begin
      if cdsCtrAgg.FieldByName('VAL_PROPORCIONAL_DESJUR').AsFloat <> 0.00 then
      begin
        result := cdsCtrAgg.FieldByName('VAL_PROPORCIONAL_DESJUR').AsFloat ;
      end;
    end;
  end;
end;

function TLanConCTR.fRecalculaValorCob(const AValor: double): double;
begin
  result :=  0.00 ;
  if qryDados.FieldByName('CTR_VALREC').AsFloat = 0.00 then
  begin
    exit ;
  end;
  result := fFormataFloat((AValor/qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALCOB').AsFloat, 2) ;
end;

function TLanConCTR.fRecalculaValorDes(const AValor: double): double;
begin
  result :=  0.00 ;
  if qryDados.FieldByName('CTR_VALREC').AsFloat = 0.00 then
  begin
    exit ;
  end;
  result := fFormataFloat((AValor/qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALDES').AsFloat, 2) ;
end;

function TLanConCTR.fRecalculaValorJur(const AValor: double): double;
begin
  result :=  0.00 ;
  if qryDados.FieldByName('CTR_VALREC').AsFloat = 0.00 then
  begin
    exit ;
  end;
  result := fFormataFloat((AValor/qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALJUR').AsFloat, 2) ;
end;

function TLanConCTR.fRecalculaValorOri(const AValor: double): double;
begin
  result :=  0.00 ;
  if qryDados.FieldByName('CTR_VALREC').AsFloat = 0.00 then
  begin
    exit ;
  end;
  result := fFormataFloat((AValor
                           - ((AValor / qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALJUR').AsFloat)
                           - ((AValor / qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALCOB').AsFloat)
                           + ((AValor / qryDados.FieldByName('CTR_VALREC').AsFloat) * qryDados.FieldByName('CTR_VALDES').AsFloat)), 2) ;
end;

function TLanConCTR.fRetornaEventoDescontoJuros(const AstrCodigoEvento,
  AstrDescricaoValor: String): String;
begin
  result := TFactoryEventoContabil.New.fConfiguraEvento(AstrCodigoEvento, 'CTR', '', AstrDescricaoValor).fConsultaEvento(FstrCentroCustoDefault) ;
end;

function TLanConCTR.fRetPagamentoPcr: string;
begin
  Result := '';

  if not Assigned(FCdsOrigemCtr) then
    Exit ;

  if not Assigned(qryDados) or (qryDados.RecordCount = 0) then
    Exit ;

  if qryDados.FieldByName('TIPO_PAGAMENTO').AsString <> 'Pagamentos Avulsos' then
    Exit ;

  if qryDados.FieldByName('CTA_PROCON').AsString <> '1' then
    Exit ;

  if FCdsOrigemCtr.FindKey([qryDados.FieldByName('NUMDOC').AsString,
                            qryDados.FieldByName('PARCEL').AsString,
                            qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString,
                            qryDados.FieldByName('EMPCAD').AsString]) then
    Result := PGT_PAGAMENTO_PCR ;
end;

function TLanConCTR.fEmpresaDoCadastroAdtDiferenteDaBaixa(const AEmpresaAdt,
  AEmpresaDaBaixa: string): boolean;
begin
  Result := False;

  if AEmpresaAdt.IsEmpty then
    Exit;

  if AEmpresaDaBaixa.IsEmpty then
    Exit;

  Result := (AEmpresaAdt <> AEmpresaDaBaixa);
end;

function TLanConCTR.fTemControleDelLanconOutrasEmpresasCTR(const ATipLan: string): Boolean;
var
  LqryConsulta: TUniQuery ;
begin

  LqryConsulta := fCriaQuery(Nil);
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;

    if not FblnDtaBanExiste then
    begin
      //DTAREC
      LqryConsulta.SQL.Add('SELECT 1  ' );
      LqryConsulta.SQL.Add('FROM LANCON ' );
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS CONTRO ON LANCON.AUTOINCREM = CONTRO.CNT_CONTRO ');
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS ORIGEM ON LANCON.AUTOINCREM = ORIGEM.CNT_ORIGEM ');
      LqryConsulta.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      LqryConsulta.SQL.Add('WHERE TRUE ');
      LqryConsulta.SQL.Add('AND LANCON.CON_TIPLAN = "' + ATipLan + '" ');
      LqryConsulta.SQL.Add('AND LANCON.CON_AUTOMA = 1 ' );
      LqryConsulta.SQL.Add('AND ((CONTRO.CNT_CONTRO IS NOT NULL) OR (ORIGEM.CNT_CONTRO IS NOT NULL)) ');
      LqryConsulta.SQL.Add('AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +') ');

      if (recParCon.dtaDtaIni > 0) then
      begin
        LqryConsulta.SQL.Add('AND CADREC.CTR_DTAREC BETWEEN :DTAINI  AND :DTAFIN ');
        LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
        LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
      end;

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(LqryConsulta)
        .fExecute ;
    end
    else
    begin
      //DTABAN
      LqryConsulta.SQL.Add('SELECT 1  ' );
      LqryConsulta.SQL.Add('FROM LANCON ');
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS CONTRO ON LANCON.AUTOINCREM = CONTRO.CNT_CONTRO ');
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS ORIGEM ON LANCON.AUTOINCREM = ORIGEM.CNT_ORIGEM ');
      LqryConsulta.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      LqryConsulta.SQL.Add('WHERE TRUE ');
      LqryConsulta.SQL.Add('AND LANCON.CON_TIPLAN = "' + ATipLan + '" ');
      LqryConsulta.SQL.Add('AND LANCON.CON_AUTOMA = 1 ');
      LqryConsulta.SQL.Add('AND ((CONTRO.CNT_CONTRO IS NOT NULL) OR (ORIGEM.CNT_CONTRO IS NOT NULL)) ');
      LqryConsulta.SQL.Add('AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +') ');

      if (recParCon.dtaDtaIni > 0) then
      begin
        LqryConsulta.SQL.Add('AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN  ');
        LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
        LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
      end;

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(LqryConsulta)
        .fExecute ;

      LqryConsulta.SQL.Add('UNION ');

      //DTAREC
      LqryConsulta.SQL.Add('SELECT 1  ' );
      LqryConsulta.SQL.Add('FROM LANCON ');
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS CONTRO ON LANCON.AUTOINCREM = CONTRO.CNT_CONTRO ');
      LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS ORIGEM ON LANCON.AUTOINCREM = ORIGEM.CNT_ORIGEM ');
      LqryConsulta.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      LqryConsulta.SQL.Add('WHERE TRUE ' );
      LqryConsulta.SQL.Add('AND LANCON.CON_TIPLAN = "' + ATipLan + '" ');
      LqryConsulta.SQL.Add('AND LANCON.CON_AUTOMA = 1 ');
      LqryConsulta.SQL.Add('AND ((CONTRO.CNT_CONTRO IS NOT NULL) OR (ORIGEM.CNT_CONTRO IS NOT NULL)) ');
      LqryConsulta.SQL.Add('AND (NOT ' + fFiltroCCOriginadoAdt(FblnDtaBanExiste) +') ');

      if (recParCon.dtaDtaIni > 0) then
      begin
        LqryConsulta.SQL.Add('AND CADREC.CTR_DTAREC BETWEEN :DTAINI  AND :DTAFIN ');
        LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
        LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
      end;
      LqryConsulta.SQL.Add('AND CADREC.CTR_DTABAN IS NULL ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(LqryConsulta)
        .fExecute ;
    end;

    LqryConsulta.SQL.Add('UNION ');

    //SEM CADREC
    LqryConsulta.SQL.Add('SELECT 1  ');
    LqryConsulta.SQL.Add('FROM LANCON ');
    LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS CONTRO ON LANCON.AUTOINCREM = CONTRO.CNT_CONTRO ');
    LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS ORIGEM ON LANCON.AUTOINCREM = ORIGEM.CNT_ORIGEM ');
    LqryConsulta.SQL.Add('LEFT JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
    LqryConsulta.SQL.Add('WHERE TRUE ');
    LqryConsulta.SQL.Add('AND LANCON.CON_TIPLAN = "' + ATipLan + '" ');
    LqryConsulta.SQL.Add('AND LANCON.CON_AUTOMA = 1 ');
    LqryConsulta.SQL.Add('AND ((CONTRO.CNT_CONTRO IS NOT NULL) OR (ORIGEM.CNT_CONTRO IS NOT NULL)) ');
    LqryConsulta.SQL.Add('AND CADREC.AUTOINCREM IS NULL ');

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('AND LANCON.CON_DTALAN BETWEEN :DTAINI  AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.SQL.Add('UNION ');

    //CADREC ESTORNADO
    LqryConsulta.SQL.Add('SELECT 1  ');
    LqryConsulta.SQL.Add('FROM LANCON ');
    LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS CONTRO ON LANCON.AUTOINCREM = CONTRO.CNT_CONTRO ');
    LqryConsulta.SQL.Add('LEFT JOIN LANCNT AS ORIGEM ON LANCON.AUTOINCREM = ORIGEM.CNT_ORIGEM ');
    LqryConsulta.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
    LqryConsulta.SQL.Add('WHERE TRUE ');
    LqryConsulta.SQL.Add('AND LANCON.CON_TIPLAN = "' + ATipLan + '" ');
    LqryConsulta.SQL.Add('AND LANCON.CON_AUTOMA = 1 ');
    LqryConsulta.SQL.Add('AND ((CONTRO.CNT_CONTRO IS NOT NULL) OR (ORIGEM.CNT_CONTRO IS NOT NULL)) ');
    LqryConsulta.SQL.Add('AND CADREC.CTR_DTAREC IS NULL ');

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('AND LANCON.CON_DTALAN BETWEEN :DTAINI  AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.Open;

    Result := LqryConsulta.RecordCount > 0;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

function TLanConCTR.fTemFormaPagamento: Boolean;
begin
  Result := False ;

  if (qryDados.FieldByName('CTR_VALREC').AsFloat > 0.00)
         and ((qryDados.FieldByName('CTR_DINHEI').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_DINHEI').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_CHQPRE').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_CHQAVI').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_CARTAO').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_ORDPAG').AsFloat = 0.00)
                and (qryDados.FieldByName('CTR_CREDIT').AsFloat = 0.00)) then
  begin
    if (blnCtrCreditExiste) then
    begin
      if qryDados.FieldByName('CTR_CREDIT').AsFloat = 0.00 then
      begin
        Exit ;
      end ;
      ///segue até fim da proc
    end
    else
    begin
      Exit ;
    end ;
  end ;

  Result := True ;
end;

function TLanConCTR.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCTR.fTituloComDescontoTotal: boolean;
begin
  if qryDados.FieldByName('CTR_VALORI').AsFloat >= 0  then
  begin
    Result := (fFormataFloat(qryDados.FieldByName('CTR_VALORI').AsFloat, 2) = fFormataFloat(qryDados.FieldByName('CTR_VALDES').AsFloat, 2)) and
              (fFormataFloat(qryDados.FieldByName('CTR_VALREC').AsFloat, 2) = 0);
  end
  else
  begin
    Result := (fFormataFloat(abs(qryDados.FieldByName('CTR_VALORI').AsFloat), 2) = fFormataFloat(abs(qryDados.FieldByName('CTR_VALJUR').AsFloat), 2)) and
              (fFormataFloat(qryDados.FieldByName('CTR_VALREC').AsFloat, 2) = 0);
  end;
end;

function TLanConCTR.fTrataValorProporcional(
  const fltValorProporcional: double; const AModoJurDes: boolean = False): double;
begin
  result := 1 ;
  if (fltValorProporcional <> 0.00) or (AModoJurDes) then
  begin
    result := fltValorProporcional ;
  end;
end;

function TLanConCTR.fUsaColunaCreditoArredondamentoAgrupadas(
  const AstrColuna: String): Boolean;
var
  LintCnt: Integer ;
begin
  Result := True ;
  if blnCtrCreditExiste then
    Exit ;

  for LintCnt := Low(CREDITOS) to High(CREDITOS) do
    if CREDITOS[LintCnt] = AstrColuna then
      Exit(False) ;

end;

function TLanConCTR.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCTR.pAjustaInformacaoCredito;
var
  flt_credit: double ;
  flt_dif: double ;
  bmLoop: TBookMark;
  bmFim: TBookMark;
begin
  if fCfgDescCreditoDinheiroMesmoSeqCon = 'S' then
    Exit ;

  if not blnCtrCreditExiste then
  begin
    exit ;
  end;

  qryDados.First ;
  while not qryDados.Eof do
  begin
    if qryDados.FieldByName('CTR_VALORI').AsFloat < 0.00 then
    begin
      qryDados.Next ;
      Continue ;
    end;

    /// ignora linhas sem dinheiro
    if qryDados.FieldByName('CTR_DINHEI').AsFloat = 0.00 then
    begin
      qryDados.Next ;
      Continue ;
    end;

    /// ignora linhas sem crédito
    if qryDados.FieldByName('CTR_CREDIT').AsFloat = 0.00 then
    begin
      qryDados.Next ;
      Continue ;
    end;

    if FcdsDadosAdtTransformadoEmCC.FindKey([qryDados.FieldByName('EMPBAI').AsString, qryDados.FieldByName('CTR_SEQCON').AsString, qryDados.FieldByName('DTAENT').AsDateTime]) then
    begin
      qryDados.Next ;
      Continue ;
    end ;

    if cdsCtrCred.FindKey([qryDados.FieldByName('CTR_SEQCON').AsString,qryDados.FieldByName('EMPBAI').AsString]) then
    begin
      ////copia o valor do dinheiro para o credito, depois zera o dinheiro
      if cdsCtrCred.FieldByName('CTR_DINHEI').AsFloat <= cdsCtrCred.FieldByName('CREDITO_LANCADO').AsFloat then
      begin
        qryDados.Edit ;
        qryDados.FieldByName('CTR_CREDIT').AsFloat := qryDados.FieldByName('CTR_DINHEI').AsFloat ;
        qryDados.FieldByName('CTR_DINHEI').AsFloat := 0.00 ;
        qryDados.FieldByName('CTR_PGTCRE').AsFloat := qryDados.FieldByName('CTR_PGTDIN').AsFloat ;
        qryDados.FieldByName('CTR_PGTDIN').AsFloat := 0.00 ;
        qryDados.Post ;
      end
      else if cdsCtrCred.FieldByName('CTR_DINHEI').AsFloat > cdsCtrCred.FieldByName('CREDITO_LANCADO').AsFloat then
      begin
        /// em um segundo momento acerta o valor do dinheiro e credito para corrigir divergencia de arredondamento.
        qryDados.Edit ;
        qryDados.FieldByName('CTR_DINHEI').AsFloat := qryDados.FieldByName('CTR_DINHEI').AsFloat - qryDados.FieldByName('CTR_CREDIT').AsFloat ;
        qryDados.FieldByName('CTR_PGTDIN').AsFloat := qryDados.FieldByName('CTR_PGTDIN').AsFloat - qryDados.FieldByName('CTR_PGTCRE').AsFloat ;
        qryDados.Post ;
      end ;
      //else if cdsCtrCred.FieldByName('CTR_DINHEI').AsFloat < cdsCtrCred.FieldByName('CREDITO_LANCADO').AsFloat then
      //begin
      //  /// zera o dinheiro e mantem o valor do crédito rateado
      //  /// em um segundo momento acerta o valor do credito para corrigir divergencia de arredondamento.
      //  qryDados.Edit ;
      //  qryDados.FieldByName('CTR_DINHEI').AsFloat := 0.00 ;
      //  qryDados.FieldByName('CTR_PGTDIN').AsFloat := 0.00 ;
      //  qryDados.Post ;
      //end;
    end;
    qryDados.Next ;
  end;
  ////corrige o arredondamento
  qryDados.First ;
  while not qryDados.Eof do
  begin
    if cdsCtrCred.FindKey([qryDados.FieldByName('CTR_SEQCON').AsString,qryDados.FieldByName('EMPBAI').AsString]) then
    begin
      flt_credit := 0.00 ;
      while (qryDados.FieldByName('CTR_SEQCON').AsString = cdsCtrCred.FieldByName('CTR_SEQCON').AsString) and
            (qryDados.FieldByName('EMPBAI').AsString = cdsCtrCred.FieldByName('CTR_EMPBAI').AsString) and
            (not qryDados.Eof) do
      begin
        if qryDados.FieldByName('CTR_VALORI').AsFloat < 0.00 then
        begin
          qryDados.Next ;
          Continue ;
        end;

        if (qryDados.FieldByName('CTR_DINHEI').AsFloat <> 0.00) and (qryDados.FieldByName('CTR_CREDIT').AsFloat = 0.00) then
        begin
          qryDados.Next ;
          Continue ;
        end;

        flt_credit := flt_credit + fFormataFloat(qryDados.FieldByName('CTR_CREDIT').AsFloat, 2) ;
        bmLoop := qryDados.GetBookmark ;
        qryDados.Next ;
      end;
      if cdsCtrCred.FieldByName('CTR_DINHEI').AsFloat < cdsCtrCred.FieldByName('CREDITO_LANCADO').AsFloat then
      begin
        flt_dif := flt_credit - fFormataFloat(cdsCtrCred.FieldByName('CTR_DINHEI').AsFloat, 2) ;
      end
      else
      begin
        flt_dif := flt_credit - fFormataFloat(cdsCtrCred.FieldByName('CREDITO_LANCADO').AsFloat, 2) ;
      end;

      if fFormataFloat(flt_dif,2) <> 0.00 then
      begin
        bmFim := qryDados.GetBookmark ;
        qryDados.Bookmark := bmLoop ;
        qryDados.Edit ;
        /// desconta do crédito
        qryDados.FieldByName('CTR_CREDIT').AsFloat := qryDados.FieldByName('CTR_CREDIT').AsFloat - flt_dif;
        qryDados.FieldByName('CTR_PGTCRE').AsFloat := qryDados.FieldByName('CTR_PGTCRE').AsFloat - flt_dif ;

        /// soma no dinheiro
        if qryDados.FieldByName('CTR_DINHEI').AsFloat <> 0.00 then
        begin
          qryDados.FieldByName('CTR_DINHEI').AsFloat := qryDados.FieldByName('CTR_DINHEI').AsFloat + flt_dif ;
          qryDados.FieldByName('CTR_PGTDIN').AsFloat := qryDados.FieldByName('CTR_PGTDIN').AsFloat + flt_dif ;
        end;

        qryDados.Post ;
        qryDados.Bookmark := bmFim ;
      end;
      continue ;
    end;
    qryDados.Next ;
  end;

  /// recalcula as funções que era do SQL e precisam ser refeitas no Delphi.
  qryDados.First ;
  while not qryDados.Eof do
  begin
    if qryDados.FieldByName('CTR_VALORI').AsFloat < 0.00 then
    begin
      qryDados.Next ;
      Continue ;
    end;

    //recalcula somente se for crédito.
    if cdsCtrCred.FindKey([qryDados.FieldByName('CTR_SEQCON').AsString,qryDados.FieldByName('EMPBAI').AsString]) then
    begin
      qryDados.Edit ;
      qryDados.FieldByName('CTR_DINJUR').AsFloat := fRecalculaValorJur(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINORI').AsFloat := fRecalculaValorOri(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINDES').AsFloat := fRecalculaValorDes(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINCOB').AsFloat := fRecalculaValorCob(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINJUR_CONF').AsFloat := fRecalculaValorJur(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINORI_CONF').AsFloat := fRecalculaValorOri(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINDES_CONF').AsFloat := fRecalculaValorDes(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;
      qryDados.FieldByName('CTR_DINCOB_CONF').AsFloat := fRecalculaValorCob(qryDados.FieldByName('CTR_DINHEI').AsFloat) ;

      qryDados.FieldByName('CTR_CREJUR').AsFloat := fRecalculaValorJur(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CREORI').AsFloat := fRecalculaValorOri(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CREDES').AsFloat := fRecalculaValorDes(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CRECOB').AsFloat := fRecalculaValorCob(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CREJUR_CONF').AsFloat := fRecalculaValorJur(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CREORI_CONF').AsFloat := fRecalculaValorOri(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CREDES_CONF').AsFloat := fRecalculaValorDes(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.FieldByName('CTR_CRECOB_CONF').AsFloat := fRecalculaValorCob(qryDados.FieldByName('CTR_CREDIT').AsFloat) ;
      qryDados.Post ;
    end;

    qryDados.Next ;
  end;
end;

procedure TLanConCTR.pAlterarValores;
begin
  qryDados.Edit;
  if fltDifOriCha <> 0 then
    qryDados.FieldByName('CTR_CHAORI').AsFloat := qryDados.FieldByName('CTR_CHAORI').AsFloat + fltDifOriCha ;
  if fltDifOriChp <> 0 then
    qryDados.FieldByName('CTR_CHPORI').AsFloat := qryDados.FieldByName('CTR_CHPORI').AsFloat + fltDifOriChp ;
  if fltDifOriCar <> 0 then
    qryDados.FieldByName('CTR_CARORI').AsFloat := qryDados.FieldByName('CTR_CARORI').AsFloat + fltDifOriCar ;
  if fltDifOriOrP <> 0 then
    qryDados.FieldByName('CTR_ORDORI').AsFloat := qryDados.FieldByName('CTR_ORDORI').AsFloat + fltDifOriOrP ;
  if fltDifOriDin <> 0 then
    qryDados.FieldByName('CTR_DINORI').AsFloat := qryDados.FieldByName('CTR_DINORI').AsFloat + fltDifOriDin ;
  if (blnCtrCreditExiste) and (fltDifOriCre <> 0) then
    qryDados.FieldByName('CTR_CREORI').AsFloat := qryDados.FieldByName('CTR_CREORI').AsFloat + fltDifOriCre ;

  if fltDifJurCha <> 0 then
    qryDados.FieldByName('CTR_CHAJUR').AsFloat := qryDados.FieldByName('CTR_CHAJUR').AsFloat + fltDifJurCha ;
  if fltDifJurChp <> 0 then
    qryDados.FieldByName('CTR_CHPJUR').AsFloat := qryDados.FieldByName('CTR_CHPJUR').AsFloat + fltDifJurChp ;
  if fltDifJurCar <> 0 then
    qryDados.FieldByName('CTR_CARJUR').AsFloat := qryDados.FieldByName('CTR_CARJUR').AsFloat + fltDifJurCar ;
  if (blnCtrCreditExiste) and (fltDifJurCre <> 0) then
    qryDados.FieldByName('CTR_CREJUR').AsFloat := qryDados.FieldByName('CTR_CREJUR').AsFloat + fltDifJurCre ;
  if fltDifJurOrP <> 0 then
    qryDados.FieldByName('CTR_ORDJUR').AsFloat := qryDados.FieldByName('CTR_ORDJUR').AsFloat + fltDifJurOrP ;
  if fltDifJurDin <> 0 then
    qryDados.FieldByName('CTR_DINJUR').AsFloat := qryDados.FieldByName('CTR_DINJUR').AsFloat + fltDifJurDin ;

  if fltDifCobCha <> 0 then
    qryDados.FieldByName('CTR_CHACOB').AsFloat := qryDados.FieldByName('CTR_CHACOB').AsFloat + fltDifCobCha ;
  if fltDifCobChp <> 0 then
    qryDados.FieldByName('CTR_CHPCOB').AsFloat := qryDados.FieldByName('CTR_CHPCOB').AsFloat + fltDifCobChp ;
  if fltDifCobCar <> 0 then
    qryDados.FieldByName('CTR_CARCOB').AsFloat := qryDados.FieldByName('CTR_CARCOB').AsFloat + fltDifCobCar ;
  if (blnCtrCreditExiste) and (fltDifCobCre <> 0) then
    qryDados.FieldByName('CTR_CRECOB').AsFloat := qryDados.FieldByName('CTR_CRECOB').AsFloat + fltDifCobCre ;
  if fltDifCobOrP <> 0 then
    qryDados.FieldByName('CTR_ORDCOB').AsFloat := qryDados.FieldByName('CTR_ORDCOB').AsFloat + fltDifCobOrP ;
  if fltDifCobDin <> 0 then
    qryDados.FieldByName('CTR_DINCOB').AsFloat := qryDados.FieldByName('CTR_DINCOB').AsFloat + fltDifCobDin ;

  if fltDifDesCha <> 0 then
    qryDados.FieldByName('CTR_CHADES').AsFloat := qryDados.FieldByName('CTR_CHADES').AsFloat + fltDifDesCha ;
  if fltDifDesChp <> 0 then
    qryDados.FieldByName('CTR_CHPDES').AsFloat := qryDados.FieldByName('CTR_CHPDES').AsFloat + fltDifDesChp ;
  if fltDifDesCar <> 0 then
    qryDados.FieldByName('CTR_CARDES').AsFloat := qryDados.FieldByName('CTR_CARDES').AsFloat + fltDifDesCar ;
  if (blnCtrCreditExiste) and (fltDifDesCre <> 0) then
    qryDados.FieldByName('CTR_CREDES').AsFloat := qryDados.FieldByName('CTR_CREDES').AsFloat + fltDifDesCre ;
  if fltDifDesOrP <> 0 then
    qryDados.FieldByName('CTR_ORDDES').AsFloat := qryDados.FieldByName('CTR_ORDDES').AsFloat + fltDifDesOrP ;
  if fltDifDesDin <> 0 then
    qryDados.FieldByName('CTR_DINDES').AsFloat := qryDados.FieldByName('CTR_DINDES').AsFloat + fltDifDesDin ;

  if fltDifDes2 <> 0 then
  begin
    if qryDados.FieldByName('CTR_VALDE2').AsFloat <> 0 then
      qryDados.FieldByName('CTR_VALDE2').AsFloat := qryDados.FieldByName('CTR_VALDE2').AsFloat + fltDifDes2 ;
  end;

  if fltDifJur2 <> 0 then
  begin
    if qryDados.FieldByName('CTR_VALJU2').AsFloat <> 0 then
      qryDados.FieldByName('CTR_VALJU2').AsFloat := qryDados.FieldByName('CTR_VALJU2').AsFloat + fltDifJur2 ;
  end;

  if (fltDifDin <> 0) then
    qryDados.FieldByName('CTR_DINHEI').AsFloat := qryDados.FieldByName('CTR_DINHEI').AsFloat + fltDifDin;

  if (fltDifChP <> 0) then
    qryDados.FieldByName('CTR_CHQPRE').AsFloat := qryDados.FieldByName('CTR_CHQPRE').AsFloat + fltDifChP;

  if (fltDifChA <> 0) then
    qryDados.FieldByName('CTR_CHQAVI').AsFloat := qryDados.FieldByName('CTR_CHQAVI').AsFloat + fltDifChA;

  if (fltDifCar <> 0) then
    qryDados.FieldByName('CTR_CARTAO').AsFloat := qryDados.FieldByName('CTR_CARTAO').AsFloat + fltDifCar;

  if (fltDifOrP <> 0) then
    qryDados.FieldByName('CTR_ORDPAG').AsFloat := qryDados.FieldByName('CTR_ORDPAG').AsFloat + fltDifOrP;

  if (blnCtrCreditExiste) and (fltDifCre <> 0) then
    qryDados.FieldByName('CTR_CREDIT').AsFloat := qryDados.FieldByName('CTR_CREDIT').AsFloat + fltDifCre;

  qryDados.Post;
end;

procedure TLanConCTR.pCarregaDadosAcertoInformacaoCredito(recParams: TParamsContasReceber);
Var
  qryCred : TUniQuery;
begin
  if fCfgDescCreditoDinheiroMesmoSeqCon = 'S' then
    Exit ;

  if not blnCtrCreditExiste then
  begin
    exit ;
  end;

  If Assigned(cdsCtrCred) Then
  begin
    FreeAndNil(cdsCtrCred);
  end;

  qryCred := fCriaQuery(nil);
  Try
    qryCred.Close;
    qryCred.SQL.Clear;
    qryCred.SQL.Add(' SELECT SEL.*, ');
    qryCred.SQL.Add('       (SELECT SUM(ABS(CTR_VALORI)) FROM CADREC WHERE CADREC.CTR_SEQCON = SEL.CTR_SEQCON AND CADREC.CTR_EMPBAI = SEL.CTR_EMPBAI AND CTR_VALORI < 0.00) AS CREDITO_LANCADO ');
    qryCred.SQL.Add('   FROM ( ');
    qryCred.SQL.Add('	SELECT CTR_SEQCON, ');
    qryCred.SQL.Add('	       CTR_EMPBAI, ');
    qryCred.SQL.Add('	       ROUND(SUM(CTR_CREDIT),2) CTR_CREDIT_RATEADO, ');
    If recParams.blnCTR_RETBAN_Existe Then
    begin
      qryCred.SQL.Add(' SUM(ROUND((IFNULL(CTR_DINHEI, 0) + IFNULL(CTR_RETBAN, 0)), 2)) AS CTR_DINHEI ') ;
    end
    Else
    begin
      qryCred.SQL.Add(' SUM(ROUND((IFNULL(CTR_DINHEI, 0)), 2)) AS CTR_DINHEI ') ;
    end;
    qryCred.SQL.Add('	FROM CADREC ');
    qryCred.SQL.Add('	WHERE CTR_VALORI > 0 AND CTR_CREDIT > 0 ');
    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      qryCred.SQL.Add('  AND ' + fEmpresaGeracao('CADREC.', recParams) + ' = :CODEMP ');
      qryCred.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      If (recParams.blnCTR_DTABAN_Existe) Then
        qryCred.SQL.Add('    AND IFNULL(CADREC.CTR_DTABAN, CADREC.CTR_DTAREC) BETWEEN :DTAINI AND :DTAFIN ')
      Else
        qryCred.SQL.Add('    AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
      qryCred.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      qryCred.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryCred)
      .fExecute ;

    qryCred.SQL.Add('	GROUP BY CTR_SEQCON, CTR_EMPBAI ');
    qryCred.SQL.Add(') AS SEL ');
    qryCred.Open ;

    cdsCtrCred := fCriaClientDatset(qryCred, false);
    cdsCtrCred.IndexFieldNames := 'CTR_SEQCON;CTR_EMPBAI' ;
    cdsCtrCred.Open;

  Finally
    FreeAndNil(qryCred);
  End;

end;

procedure TLanConCTR.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Contas a Receber Concluído!', ['&OK']);
end;

procedure TLanConCTR.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCTR.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCTR.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TLanConCTR.pSomarValores;
begin
  fltRatOriDin := fltRatOriDin + qryDados.FieldByName('CTR_DINORI').AsFloat ;
  fltRatOriCha := fltRatOriCha + qryDados.FieldByName('CTR_CHAORI').AsFloat ;
  fltRatOriChp := fltRatOriChp + qryDados.FieldByName('CTR_CHPORI').AsFloat ;
  fltRatOriCar := fltRatOriCar + qryDados.FieldByName('CTR_CARORI').AsFloat ;
  fltRatOriOrP := fltRatOriOrP + qryDados.FieldByName('CTR_ORDORI').AsFloat ;

  fltRatJurDin := fltRatJurDin + qryDados.FieldByName('CTR_DINJUR').AsFloat ;
  fltRatJurCha := fltRatJurCha + qryDados.FieldByName('CTR_CHAJUR').AsFloat ;
  fltRatJurChp := fltRatJurChp + qryDados.FieldByName('CTR_CHPJUR').AsFloat ;
  fltRatJurCar := fltRatJurCar + qryDados.FieldByName('CTR_CARJUR').AsFloat ;
  fltRatJurOrP := fltRatJurOrP + qryDados.FieldByName('CTR_ORDJUR').AsFloat ;

  fltRatCobDin := fltRatCobDin + qryDados.FieldByName('CTR_DINCOB').AsFloat ;
  fltRatCobCha := fltRatCobCha + qryDados.FieldByName('CTR_CHACOB').AsFloat ;
  fltRatCobChp := fltRatCobChp + qryDados.FieldByName('CTR_CHPCOB').AsFloat ;
  fltRatCobCar := fltRatCobCar + qryDados.FieldByName('CTR_CARCOB').AsFloat ;
  fltRatCobOrP := fltRatCobOrP + qryDados.FieldByName('CTR_ORDCOB').AsFloat ;

  fltRatDesDin := fltRatDesDin + qryDados.FieldByName('CTR_DINDES').AsFloat ;
  fltRatDesCha := fltRatDesCha + qryDados.FieldByName('CTR_CHADES').AsFloat ;
  fltRatDesChp := fltRatDesChp + qryDados.FieldByName('CTR_CHPDES').AsFloat ;
  fltRatDesCar := fltRatDesCar + qryDados.FieldByName('CTR_CARDES').AsFloat ;
  fltRatDesOrP := fltRatDesOrP + qryDados.FieldByName('CTR_ORDDES').AsFloat ;

  fltRatDin := fltRatDin + qryDados.FieldByName('CTR_DINHEI').AsFloat;
  fltRatChP := fltRatChP + qryDados.FieldByName('CTR_CHQPRE').AsFloat;
  fltRatChA := fltRatChA + qryDados.FieldByName('CTR_CHQAVI').AsFloat;
  fltRatCar := fltRatCar + qryDados.FieldByName('CTR_CARTAO').AsFloat;
  fltRatOrP := fltRatOrP + qryDados.FieldByName('CTR_ORDPAG').AsFloat;

  fltRatDes2 := fltRatDes2 + qryDados.FieldByName('CTR_VALDE2').AsFloat;
  fltRatJur2 := fltRatJur2 + qryDados.FieldByName('CTR_VALJU2').AsFloat;
  if blnCtrCreditExiste then
  begin
    fltRatOriCre := fltRatOriCre + qryDados.FieldByName('CTR_CREORI').AsFloat ;
    fltRatJurCre := fltRatJurCre + qryDados.FieldByName('CTR_CREJUR').AsFloat ;
    fltRatDesCre := fltRatDesCre + qryDados.FieldByName('CTR_CREDES').AsFloat ;
    fltRatCobCre := fltRatCobCre + qryDados.FieldByName('CTR_CRECOB').AsFloat ;
  end;
end;

procedure TLanConCTR.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon ;
end;

procedure TLanConCTR.pZerarValores;
begin
  fltRatDin := 0;
  fltRatCre := 0;
  fltDifDin := 0;
  fltDifCre := 0;
  fltRatChP := 0;
  fltDifChP := 0;
  fltRatChA := 0;
  fltDifChA := 0;
  fltRatCar := 0;
  fltDifCar := 0;
  fltRatOrP := 0;
  fltDifOrP := 0;
  fltRatOriDin := 0;
  fltRatOriCha := 0;
  fltRatOriChp := 0;
  fltRatOriCar := 0;
  fltRatOriOrP := 0;
  fltRatOriCre := 0;
  fltDifOriDin := 0;
  fltDifOriCha := 0;
  fltDifOriChp := 0;
  fltDifOriCar := 0;
  fltDifOriOrP := 0;
  fltDifOriCre := 0;
  fltRatJurDin := 0;
  fltRatJurCha := 0;
  fltRatJurChp := 0;
  fltRatJurCar := 0;
  fltRatJurOrP := 0;
  fltRatJurCre := 0;
  fltDifJurDin := 0;
  fltDifJurCha := 0;
  fltDifJurChp := 0;
  fltDifJurCar := 0;
  fltDifJurOrP := 0;
  fltDifJurCre := 0;
  fltRatCobDin := 0;
  fltRatCobCha := 0;
  fltRatCobChp := 0;
  fltRatCobCar := 0;
  fltRatCobOrP := 0;
  fltRatCobCre := 0;
  fltDifCobDin := 0;
  fltDifCobCha := 0;
  fltDifCobChp := 0;
  fltDifCobCar := 0;
  fltDifCobOrP := 0;
  fltDifCobCre := 0;
  fltRatDesDin := 0;
  fltRatDesCha := 0;
  fltRatDesChp := 0;
  fltRatDesCar := 0;
  fltRatDesOrP := 0;
  fltRatDesCre := 0;
  fltDifDesDin := 0;
  fltDifDesCha := 0;
  fltDifDesChp := 0;
  fltDifDesCar := 0;
  fltDifDesOrP := 0;

  fltRatDes2 := 0;
  fltDifDes2 := 0;
  fltRatJur2 := 0;
  fltDifJur2 := 0;
end;

end.
