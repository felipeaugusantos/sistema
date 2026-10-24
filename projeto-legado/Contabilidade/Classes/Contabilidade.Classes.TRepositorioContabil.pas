unit Contabilidade.Classes.TRepositorioContabil;

interface

uses System.Generics.Collections,
     System.Generics.Defaults,
     Contabilidade.Classes.TParametroContabil,
     Contabilidade.Classes.TDadosAbertura,
     Contabilidade.Model.ContasPagar,
     Uni,
     Contabilidade.Funcoes,
     Data.DB,
     Datasnap.DBClient,
     UniClientDataSet,
     Contabilidade.Interfaces;

type
  TValCtp = record
    fltValPag: Double;
    fltDinhei: Double;
    fltChqPre: Double;
    fltChqAvi: Double;
    fltCartao: Double;
    fltOrdPag: Double;
    fltValOri: Double;
    fltJuros: Double;
    fltMulta: Double;
    fltVendor: Double;
    fltDesconto: Double;
  end;

  TDictValCtp = TDictionary<string, TValCtp>;
  TDictFisInc = TDictionary<string, string>;
  TSetFisInc = TDictionary<string, Byte>;
  TDictCtpFisSet = TDictionary<string, TSetFisInc>;

  TAjustaConsultaCadPagAntecipado = (acaDefault, acaFaturaComAgr, acaFaturaSemAgr, acaAvulso) ;

  TRepositorioContabil = class
  private
    FListaParametrosContabil: TObjectList<TParametroContabil>;
    //FListaRecebimentos: TObjectList<TContasReceber>;
    FListaPagamentos: TObjectList<TContasPagar>;
    FDadosAbertura: TDadosAbertura;

  	fltValPag: Double;
    fltRatPag: Double;
    fltDifPag: Double;
    fltDinhei: Double;
    fltRatDin: Double;
    fltDifDin: Double;
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
    fltValOri: Double;
    fltRatOri: Double;
    fltDifOri: Double;
    fltJuros: Double;
    fltRatJur: Double;
    fltDifJur: Double;
    fltMulta: Double;
    fltRatMul: Double;
    fltDifMul: Double;
    fltVendor: Double;
    fltRatVendor: Double;
    fltDifVendor: Double;
    fltDesconto: Double;
    fltRatDes: Double;
    fltDifDes: Double;
    strCTPInc: string;
    strTipoPagamento: string;
    blnTipCtp: boolean;
    FstrCentroCustoDefault: String ;
    FblnContabilizarPelaEmpBai: Boolean ;
    FCtpIncFisExiste: Boolean ;
    FcdsCtpLancadosPeriodoFechado: TUniClientDataSet;

    //procedure pOrdenaListaCadRecData(blnCrescente: Boolean);

    //function fRetSqlTodosCadRecPorPeriodo: string;

    // Ao alterar a clausula Where deste metodo, deve ser alterado tambem o do metodo fRetSqlCtpLancadosPeriodoFechadoDtaPag porque ambos devem ser identicos
    function fRetSqlTodosCadPagPorPeriodoDtaPag(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): string;
    // Ao alterar a clausula Where deste metodo, deve ser alterado tambem o do metodo fRetSqlCtpLancadosPeriodoFechadoDtaCad porque ambos devem ser identicos
    function fRetSqlTodosCadPagPorPeriodoDtaCad: string;
    function fRetSqlParametrosContabil: string;
    function fFatorDupAgp(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): String;
    procedure pSomarValores(qryDados: TUniQuery);
    procedure pZerarValores;
    function fRetSqlTodosCadPagPorPeriodoAgrupadoCTP(
      strSqlTodosCadPagPorPeriodoDtaPag:string): string;
    function fRetSqlTodosCadPagPorPeriodoAgrupadoPCP(
      strSqlTodosCadPagPorPeriodoDtaPag: string): string;
    function fCfgCtpAgr: boolean;
    function fColunaTipCtp(const ATabela:string): string;
    function fCarregaPortadorFormaPagamento(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
    function fCarregaOrigemCTP(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;

    function fCarregaLogCtpAntecipado(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
    function fCarregaCtpBanmcaTax(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
    procedure pAjustaLogCtpAntecipado(var AqryPagar: TUniQuery; AcdsInfo: TUniClientDataSet) ;

    function fRetPagamentoPCP(const AcdsOrigemCtp: TUniClientDataSet; const AqryCTP: TUniQuery): String ;
    procedure pAjustaJurosCtpDet(var AcpLancamento: TContasPagar) ;
    procedure pAjustaDescontosCtpDet(var AcpLancamento: TContasPagar) ;
    function fCarregaCtpMovban(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
    function fCarregaCtpAnt(const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
    function fDescartarPrevisaoPCP(const AblnProvisao:boolean; const AstrPrevisao: string):boolean ;
    function fAjustarArredondamento(const AqryDados: TUniQuery): boolean ;
    function fCondicaoUsarVeioNFQuandoValorEmCodVel: string ;
    function fPagamentoEhTaxa(const AcdsCtpBanmcaTax: TUniClientDataSet; const AqryDados: TUniQuery): boolean;
    function fRetConsultaCadPagAntecipado: TUniQuery ;
    function fAjustaColunaDataPagamento(const AConfAntecipado: TAjustaConsultaCadPagAntecipado): String ;
    procedure pProcessaDataSet(AqryConsulta: TUniQuery;
                               AcdsPortadorFormaPagamento: TUniClientDataSet ;
                               AcdsCtpMovBan: TUniClientDataSet ;
                               AcdsOrigemCtp: TUniClientDataSet ;
                               AcdsLogCtpAnt: TUniClientDataSet ;
                               AcdsCtpBanmcaTax: TUniClientDataset;
                               AcdsParconAvistaEnt: TUniClientDataset;
                               AcdsCtpAnt: TUniClientDataset;
                               AdictDifArrCtp: TDictValCtp;
                               AdictFisInc: TDictFisInc) ;
   function fUsaCondicaoTipoPagamentoNoArredamento(AqryConsulta: TUniQuery): Boolean ;
   function fDescartaCptComRegistroNoCtpAntAvulso(const AqryConsulta: TUniQuery; const AcdsCtpAnt: TUniClientDataset): Boolean ;
   procedure pAjustarArredondamentoCtp(const ADadosAbertura: TDadosAbertura; AlstPagamentos: TObjectList<TContasPagar>; AdictDif: TDictValCtp);
   function fAjustaTipoPagamentoSql(const AConfAntecipado: TAjustaConsultaCadPagAntecipado; const ACondicaoBase: string): string;
   function fSqlRetornaColunaCtpIncFis(): String ;
   function fDescartaCtpComCadFisDuplicado(const AConsulta: TUniQuery; const ADictCtpFisSet: TDictCtpFisSet; const ADictFisIncRef: TDictFisInc): Boolean;
   procedure pMontaReferenciaDuplicacaoCtpComCadFis(const AConsulta: TUniQuery; const ADictCtpFisSet: TDictCtpFisSet; const ADictFisIncRef: TDictFisInc) ;
   procedure pLiberaDictCtpFisSet(const ADict: TDictCtpFisSet);
  public
    function fRetParametrosContabil(strTipo: String): TObjectList<TParametroContabil>;
    //function fRetCadRecPorPeriodo: TObjectList<TContasReceber>;
    function fRetCadPagPorPeriodo: TObjectList<TContasPagar>;
    function fRetSqlCtpLancadosPeriodoFechadoDtaPag(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): string;
    function fRetSqlCtpLancadosPeriodoFechadoDtaCad: string;
    function fRetCdsCtpLancadosPeriodoFechado: TUniClientDataSet;

    constructor create(dadosAbertura: TDadosAbertura);
    destructor Destroy; override;
  end;

implementation

{ TRepositorioContabil }

uses untFuncoesSimples, untConstantes,
  Contabilidade.Classes.THashParCon, SysUtils, Contabilidade.Model.Portador,
  Classes, JSon, strUtils, Contabilidade.Classes.TEventoContabil,
  Contabilidade.Classes.TTrataIncDoc, DateUtils;

constructor TRepositorioContabil.create(dadosAbertura: TDadosAbertura);
begin
  inherited create;
  FblnContabilizarPelaEmpBai := fGerarPelaEmpresaBaixaCTP ;
  FListaParametrosContabil := TObjectList<TParametroContabil>.Create;
  //FListaRecebimentos := TObjectList<TContasReceber>.Create;
  FListaPagamentos := TObjectList<TContasPagar>.Create;
  FDadosAbertura := dadosAbertura;
  blnTipCtp := fCampoExiste('CADPAG', 'CTP_TIPCTP');
  FCtpIncFisExiste := fCampoExiste('CADPAG', 'CTP_INCFIS') ;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TRepositorioContabil.Destroy;
begin
  //FListaRecebimentos.Free;
  FListaParametrosContabil.Free;
  FListaPagamentos.Free;
  if Assigned(FcdsCtpLancadosPeriodoFechado) then
    FreeAndNil(FcdsCtpLancadosPeriodoFechado);
  inherited;
end;

function TRepositorioContabil.fFatorDupAgp(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): String;
begin
  if AConfAntecipado = acaFaturaSemAgr then
  begin
    Result := '1' ;
    exit ;
  end ;

  Result := '';
  Result := Result + '  (IF(AGR.CTP_NUMAGR IS NULL, 1, ';
  Result := Result + '    IFNULL( AGR.CTP_VALDUP / (  ';
  Result := Result + '      IFNULL((SELECT SUM(SUBAGR.CTP_VALDUP) ';
  Result := Result + '                FROM DUPAGP SUBAGR ';
  Result := Result + '               WHERE SUBAGR.CTP_NUMAGR = P.CTP_NUMDUP ';
  Result := Result + '                 AND SUBAGR.CTP_EMPAGR = P.CTP_CODEMP ';
  Result := Result + '                 AND SUBAGR.CTP_CODFOR = P.CTP_CODFOR ';
  Result := Result + '                                                     ) , 0)), 0))) ';
end;

function TRepositorioContabil.fPagamentoEhTaxa(
  const AcdsCtpBanmcaTax: TUniClientDataSet;
  const AqryDados: TUniQuery): boolean;
begin
  Result := True ;

  if not Assigned(AcdsCtpBanmcaTax) then
    Exit ;

  Result := AcdsCtpBanmcaTax.FindKey([AqryDados.FieldByName('CTP_NUMDUP').AsString,
                            AqryDados.FieldByName('CTP_PARCEL').AsString,
                            AqryDados.FieldByName('FOR_CODFOR').AsString,
                            AqryDados.FieldByName('CTP_CODEMP').AsString,
                            AqryDados.FieldByName('SERIE_').AsString]);
end;

function TRepositorioContabil.fRetCadPagPorPeriodo: TObjectList<TContasPagar>;
  var
    qryAux: TUniQuery;
    strSql : string ;
    cdsPortadorFormaPagamento: TUniClientDataSet ;
    LcdsCtpMovBan: TUniClientDataSet ;
    LcdsCtpAnt: TUniClientDataSet ;
    LcdsOrigemCtp: TUniClientDataSet ;
    LcdsLogCtpAnt: TUniClientDataSet ;
    LcdsCtpBanmcaTax: TUniClientDataset ;
    LcdsParconAvistaEnt: TUniClientDataset ;
    LqryCadPagAntecipado: TUniQuery ;
    LdictDifArrCtp: TDictValCtp;
    LdictFisInc: TDictFisInc;
begin
  FListaPagamentos.Clear;
  Result := FListaPagamentos;

  cdsPortadorFormaPagamento := fCarregaPortadorFormaPagamento(FDadosAbertura) ;
  LcdsCtpMovBan := fCarregaCtpMovban(FDadosAbertura) ;
  LcdsCtpAnt := fCarregaCtpAnt(FDadosAbertura) ;
  LcdsOrigemCtp := fCarregaOrigemCTP(FDadosAbertura) ;
  LcdsLogCtpAnt := fCarregaLogCtpAntecipado(FDadosAbertura) ;
  LcdsCtpBanmcaTax := fCarregaCtpBanmcaTax(FDadosAbertura) ;
  LcdsParconAvistaEnt := fCarregaParconAvista('ENT');
  LdictDifArrCtp := TDictValCtp.Create();
  LdictFisInc := TDictFisInc.Create;

  qryAux := fCriaQuery(Nil);
  try
    qryAux.CachedUpdates := True;
    qryAux.Options.SetFieldsReadOnly := False;
    qryAux.Close;
    qryAux.SQL.Clear;
    if FDadosAbertura.blnProvisao then
    begin
      strSql := fRetSqlTodosCadPagPorPeriodoDtaCad;
      if fCfgCtpAgr then
        strSql := fRetSqlTodosCadPagPorPeriodoAgrupadoPCP(strSql) ;
    end
    else
    begin
      strSql := fRetSqlTodosCadPagPorPeriodoDtaPag ;
      if fCfgCtpAgr then
        strSql := fRetSqlTodosCadPagPorPeriodoAgrupadoCTP(strSql) ;
    end;
    qryAux.SQL.Add(strSql) ;

    if (not FDadosAbertura.strIncrementoCadPag.IsEmpty) and (Length(FDadosAbertura.arrIncDoc) = 0)  then
      qryAux.ParamByName('INCDOC').AsString := FDadosAbertura.strIncrementoCadPag;

    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      qryAux.ParamByName('DTAINI').AsDateTime := FDadosAbertura.dtaDataInicial;
      qryAux.ParamByName('DTAFIN').AsDateTime := FDadosAbertura.dtaDataFinal;
    end;

    if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
      qryAux.ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;

    qryAux.Open;

    pProcessaDataSet(qryAux,
                     cdsPortadorFormaPagamento,
                     LcdsCtpMovBan,
                     LcdsOrigemCtp,
                     LcdsLogCtpAnt,
                     LcdsCtpBanmcaTax,
                     LcdsParconAvistaEnt,
                     LcdsCtpAnt,
                     LdictDifArrCtp,
                     LdictFisInc) ;


    LqryCadPagAntecipado := fRetConsultaCadPagAntecipado ;
    if Assigned(LqryCadPagAntecipado) then
    begin
      try
        pProcessaDataSet(LqryCadPagAntecipado,
                         cdsPortadorFormaPagamento,
                         LcdsCtpMovBan,
                         LcdsOrigemCtp,
                         LcdsLogCtpAnt,
                         LcdsCtpBanmcaTax,
                         LcdsParconAvistaEnt,
                         LcdsCtpAnt,
                         LdictDifArrCtp,
                         LdictFisInc) ;
      finally
        FreeAndNil(LqryCadPagAntecipado) ;
      end ;
    end ;

  finally
    qryAux.Free;
    FreeAndNil(cdsPortadorFormaPagamento) ;
    if Assigned(LcdsCtpMovBan) then
      FreeAndNil(LcdsCtpMovBan) ;

    if Assigned(LcdsCtpAnt) then
      FreeAndNil(LcdsCtpAnt) ;

    if Assigned(LcdsOrigemCtp) then
      FreeAndNil(LcdsOrigemCtp) ;

    FreeAndNil(LcdsLogCtpAnt) ;
    FreeAndNil(LcdsCtpBanmcaTax);
    FreeAndNil(LcdsParconAvistaEnt);
    FreeandNil(LdictDifArrCtp);
    FreeAndNil(LdictFisInc);
  end;
end;

// Esta funcao retorna o SQL para encontrar os titulos do contas a pagar que estao contabilizados na LanCon com fechamento contabil realizado para o lancamento
function TRepositorioContabil.fRetSqlCtpLancadosPeriodoFechadoDtaPag(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): string;
var
  strSQL: string;
  strDesabilitaAGR: string;

begin
  strDesabilitaAGR := '' ;
  if (AConfAntecipado in [acaFaturaSemAgr, acaFaturaComAgr]) and (fCfgCAgrDp = 'S') then
  begin
    strDesabilitaAGR := ' AND FALSE ';
  end ;

  strSQL := '';

  strSQL:= strSQL + 'SELECT                                                        ';
  strSQL:= strSQL + '  LC.CON_INCDOC,                                              ';
  strSQL:= strSQL + '  LC.AUTOINCREM,                                              ';
  strSQL:= strSQL + '  LC.CON_DTALAN,                                              ';
  strSQL:= strSQL + '  FC.CON_CODEMP,                                              ';
  strSQL:= strSQL + '  FC.CON_FECINI,                                              ';
  strSQL:= strSQL + '  FC.CON_FECFIN                                               ';
  strSQL:= strSQL + 'FROM CADPAG P                                                 ';
  strSQL:= strSQL + 'JOIN LANCON LC                                                ';
  strSQL:= strSQL + '  ON  LC.CON_INCDOC = P.AUTOINCREM                            ';
  strSQL:= strSQL + '  AND LC.CON_TIPLAN = ''CTP''                                 ';
  strSQL:= strSQL + 'JOIN FECCON FC                                                ';
  strSQL:= strSQL + '  ON  FC.CON_CODEMP = LC.CON_EMPLAN                           ';
  strSQL:= strSQL + '  AND LC.CON_DTALAN BETWEEN FC.CON_FECINI AND FC.CON_FECFIN   ';

  if AConfAntecipado = acaDefault then
    strSQL:= strSQL + ' WHERE P.CTP_PAGANT <> "S"                                  '
  else
    strSQL:= strSQL + ' WHERE P.CTP_PAGANT = "S"                                   ';

  if (FDadosAbertura.dtaDataInicial > 0) AND (fAjustaColunaDataPagamento(AConfAntecipado) <> 'CADFIS.FIS_DTAENT') then
    strSQL:= strSQL + ' AND ' + fAjustaColunaDataPagamento(AConfAntecipado) + ' BETWEEN :DTAINI AND :DTAFIN ';

  if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
    strSQL:= strSQL + ' AND ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' = :CODEMP ';

  if (not FDadosAbertura.blnExportaUsoConsumo) then
    strSQL:= strSQL + ' AND P.CTP_USOCON = ''N'' ';

  if AConfAntecipado in [acaFaturaSemAgr, acaFaturaComAgr] then
  begin
    strSQL:= strSQL + ' AND EXISTS (                                         ';
    strSQL:= strSQL + '  SELECT 1                                            ';
    strSQL:= strSQL + '  FROM CADFIS                                         ';

    if AConfAntecipado <> acaFaturaSemAgr then
    begin
      strSQL:= strSQL + '  LEFT JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = FIS_NUMDOC ';
      strSQL:= strSQL + '                      AND AGR.CTP_EMPAGR = FIS_CODEMP ';
      strSQL:= strSQL + '                      AND AGR.CTP_CODFOR = FIS_FORCLI ';
    end;
    strSQL:= strSQL + ' WHERE FIS_NUMDOC = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_NUMDUP, P.CTP_NUMDUP) ', 'P.CTP_NUMDUP') + ' ';
    strSQL:= strSQL + '  AND FIS_CODEMP = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_CODEMP, P.CTP_CODEMP) ', 'P.CTP_CODEMP') + ' ';
    strSQL:= strSQL + '  AND FIS_FORCLI = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_CODFOR, P.CTP_CODFOR) ', 'P.CTP_CODFOR') + ' ';
    strSQL:= strSQL + '  AND FIS_TIP_FC = "F" ';
    if (FDadosAbertura.dtaDataInicial > 0) AND (fAjustaColunaDataPagamento(AConfAntecipado) = 'CADFIS.FIS_DTAENT') then
      strSQL:= strSQL + ' AND ' + fAjustaColunaDataPagamento(AConfAntecipado) + ' BETWEEN :DTAINI AND :DTAFIN ';
    strSQL:= strSQL + '  AND ((FIS_SERIE_ = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_SERIE_, P.CTP_SERIE_)', 'P.CTP_SERIE_') + ') ';
    strSQL:= strSQL + '    OR (FIS_SERIE_ IS NULL AND ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_SERIE_ IS NULL, P.CTP_SERIE_ IS NULL)', 'P.CTP_SERIE_ IS NULL') + ')) ';
    strSQL:= strSQL + '   )   ';
  end;

  strSQL:= strSQL + TTrataIncDocContabil
                .New
                .fColunaIncDoc('P.AUTOINCREM')
                .fIncDoc(FDadosAbertura.strIncrementoCadPag)
                .fArrIncDoc(FDadosAbertura.arrIncDoc)
                .fQuerySql(Nil)
                .fExecute;

  Result := strSQL;
end;

// Esta funcao retorna o SQL para encontrar os titulos do contas a pagar que estao contabilizados na LanCon com fechamento contabil realizado para o lancamento
function TRepositorioContabil.fRetSqlCtpLancadosPeriodoFechadoDtaCad: string;
var
  strSQL: string;
begin
  strSQL := '';

  strSQL:= strSQL + 'SELECT LC.CON_INCDOC,             ';
  strSQL:= strSQL + '       LC.AUTOINCREM,             ';
  strSQL:= strSQL + '       LC.CON_DTALAN,             ';
  strSQL:= strSQL + '       FC.CON_CODEMP,             ';
  strSQL:= strSQL + '       FC.CON_FECINI,             ';
  strSQL:= strSQL + '       FC.CON_FECFIN              ';
  strSQL:= strSQL + 'FROM LANCON LC                    ';
  strSQL:= strSQL + 'JOIN FECCON FC                    ';
  strSQL:= strSQL + '  ON FC.CON_CODEMP = LC.CON_EMPLAN                         ';
  strSQL:= strSQL + ' AND LC.CON_DTALAN BETWEEN FC.CON_FECINI AND FC.CON_FECFIN ';
  strSQL:= strSQL + 'WHERE LC.CON_TIPLAN = ''CTP''                              ';
  strSQL:= strSQL + ' AND LC.CON_INCDOC IN (                                    ';
  strSQL:= strSQL + '     SELECT P.AUTOINCREM                                   ';
  strSQL:= strSQL + '       FROM CADPAG P                                       ';
  strSQL:= strSQL + '       LEFT JOIN DUPAGP AGR                                ';
  strSQL:= strSQL + '              ON AGR.CTP_NUMAGR = P.CTP_NUMDUP             ';
  strSQL:= strSQL + '             AND AGR.CTP_EMPAGR = P.CTP_CODEMP             ';
  strSQL:= strSQL + '             AND AGR.CTP_CODFOR = P.CTP_CODFOR             ';
  strSQL:= strSQL + '             AND AGR.CTP_PARCEL = P.CTP_PARCEL             ';
  strSQL:= strSQL + '       LEFT JOIN CTPDET D                                  ';
  strSQL:= strSQL + '              ON D.CTP_CODFOR = P.CTP_CODFOR               ';
  strSQL:= strSQL + '             AND D.CTP_NUMDUP = P.CTP_NUMDUP               ';
  strSQL:= strSQL + '             AND D.CTP_PARCEL = P.CTP_PARCEL               ';
  strSQL:= strSQL + '             AND D.CTP_EMPORI = P.CTP_CODEMP               ';
  strSQL:= strSQL + '             AND ( (P.CTP_SERIE_ = D.CTP_SERIE_)           ';
  strSQL:= strSQL + '                OR (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = ""))    ';
  strSQL:= strSQL + '                AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = ""))) ) ';
  strSQL:= strSQL + '       INNER JOIN CADCTA CTACAD                                        ';
  strSQL:= strSQL + '              ON CTACAD.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ';
  strSQL:= strSQL + '              AND CTACAD.CTA_PROCON = 1                                                   ';
  strSQL:= strSQL + '      WHERE TRUE                                                                          ';

  if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
    strSQL:= strSQL + '      AND P.CTP_CODEMP = :CODEMP                                                        ';

  if (not FDadosAbertura.blnExportaUsoConsumo) then
    strSQL:= strSQL + '      AND P.CTP_USOCON = "N"                                                            ';

  if (FDadosAbertura.dtaDataInicial > 0) then
    strSQL:= strSQL + '        AND P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN                                    ';

  strSQL := strSQL  +  TTrataIncDocContabil
                         .New
                         .fColunaIncDoc('P.AUTOINCREM')
                         .fIncDoc(FDadosAbertura.strIncrementoCadPag)
                         .fArrIncDoc(FDadosAbertura.arrIncDoc)
                         .fQuerySql(Nil)
                         .fExecute ;

  strSQL:= strSQL + '        AND NOT EXISTS (                                                                  ';
  strSQL:= strSQL + '            SELECT 1                                                                      ';
  strSQL:= strSQL + '              FROM CADFIS F                                                               ';
  strSQL:= strSQL + '             WHERE F.FIS_TIP_FC = "F"                                                     ';
  strSQL:= strSQL + '               AND F.FIS_NUMDOC = IF(SUBSTRING(P.CTP_NUMDUP,1,2) = "AG", AGR.CTP_NUMDUP, P.CTP_NUMDUP)         ';
  strSQL:= strSQL + '               AND F.FIS_CODEMP = IF(SUBSTRING(P.CTP_NUMDUP,1,2) = "AG", AGR.CTP_CODEMP, P.CTP_CODEMP)         ';
  strSQL:= strSQL + '               AND F.FIS_FORCLI = IF(SUBSTRING(P.CTP_NUMDUP,1,2) = "AG", AGR.CTP_CODFOR, P.CTP_CODFOR)         ';
  strSQL:= strSQL + '               AND IFNULL(F.FIS_SERIE_, "") =                                                                  ';
  strSQL:= strSQL + '                   IF(SUBSTRING(P.CTP_NUMDUP,1,2) = "AG", IFNULL(AGR.CTP_SERIE_,""), IFNULL(P.CTP_SERIE_,""))  ';
  strSQL:= strSQL + '        )     ';
  strSQL:= strSQL + ' )            ';

  Result := strSQL;
end;

function TRepositorioContabil.fRetCdsCtpLancadosPeriodoFechado: TUniClientDataSet;
var
  Lqry: TUniQuery;
  LstrPagPeriodoFechadoSemAntecipacao: string;
  LstrPagPeriodoFechadoFatSemAgr: string;
  LstrPagPeriodoFechadoFatComAgr: string;
  LstrPagPeriodoFechadoAdtAvulso: string;

begin
  if Assigned(FcdsCtpLancadosPeriodoFechado) then
    FreeAndNil(FcdsCtpLancadosPeriodoFechado);

  Lqry := fCriaQuery(nil);
  try
    if FDadosAbertura.blnProvisao then
      LstrPagPeriodoFechadoSemAntecipacao := fRetSqlCtpLancadosPeriodoFechadoDtaCad
    else
      LstrPagPeriodoFechadoSemAntecipacao := fRetSqlCtpLancadosPeriodoFechadoDtaPag ;

    LstrPagPeriodoFechadoFatSemAgr      := fRetSqlCtpLancadosPeriodoFechadoDtaPag(acaFaturaSemAgr) ;
    LstrPagPeriodoFechadoFatComAgr      := fRetSqlCtpLancadosPeriodoFechadoDtaPag(acaFaturaComAgr) ;
    LstrPagPeriodoFechadoAdtAvulso      := fRetSqlCtpLancadosPeriodoFechadoDtaPag(acaAvulso) ;

    Lqry.Close ;
    Lqry.SQL.Clear ;
    if FDadosAbertura.blnProvisao then
      Lqry.SQL.Add(LstrPagPeriodoFechadoSemAntecipacao)
    else
    begin
      Lqry.SQL.Add('(') ;
      Lqry.SQL.Add(LstrPagPeriodoFechadoSemAntecipacao) ;
      Lqry.SQL.Add(') ') ;
      Lqry.SQL.Add(' UNION ') ;
      Lqry.SQL.Add('(') ;
      Lqry.SQL.Add(LstrPagPeriodoFechadoFatSemAgr) ;
      Lqry.SQL.Add(') ') ;
      Lqry.SQL.Add(' UNION ') ;
      Lqry.SQL.Add('(') ;
      Lqry.SQL.Add(LstrPagPeriodoFechadoFatComAgr) ;
      Lqry.SQL.Add(') ') ;
      Lqry.SQL.Add(' UNION ') ;
      Lqry.SQL.Add('(') ;
      Lqry.SQL.Add(LstrPagPeriodoFechadoAdtAvulso) ;
      Lqry.SQL.Add(') ') ;
    end;

    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      Lqry.ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
      Lqry.ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
    end;

    if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
      Lqry.ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;

    Lqry.Open;

    FcdsCtpLancadosPeriodoFechado := fCriaClientDatset(Lqry, False);
    FcdsCtpLancadosPeriodoFechado.IndexFieldNames := 'CON_INCDOC';
    FcdsCtpLancadosPeriodoFechado.Open;
    Result := FcdsCtpLancadosPeriodoFechado;
  finally
    FreeAndNil(Lqry);
  end;

end;

function TRepositorioContabil.fRetConsultaCadPagAntecipado: TUniQuery;
var
  LqryConsulta: TUniQuery ;
  LstrConsultaAdtFaturaSemAgr: String ;
  LstrConsultaAdtFaturaComAgr: String ;
  LstrConsultaAdtAvulso: String ;
begin
  Result := Nil ;
  if FDadosAbertura.blnProvisao then
    Exit ;

  LstrConsultaAdtFaturaSemAgr := fRetSqlTodosCadPagPorPeriodoDtaPag(acaFaturaSemAgr) ;
  LstrConsultaAdtFaturaComAgr := fRetSqlTodosCadPagPorPeriodoDtaPag(acaFaturaComAgr) ;
  LstrConsultaAdtAvulso       := fRetSqlTodosCadPagPorPeriodoDtaPag(acaAvulso) ;

  LqryConsulta := fCriaQuery() ;
  LqryConsulta.CachedUpdates := True;
  LqryConsulta.Options.SetFieldsReadOnly := False;
  LqryConsulta.Close ;
  LqryConsulta.SQL.Clear ;
  LqryConsulta.SQL.Add('(') ;
  LqryConsulta.SQL.Add(LstrConsultaAdtFaturaSemAgr) ;
  LqryConsulta.SQL.Add(') ') ;
  LqryConsulta.SQL.Add(' UNION ALL ') ;
  LqryConsulta.SQL.Add('(') ;
  LqryConsulta.SQL.Add(LstrConsultaAdtFaturaComAgr) ;
  LqryConsulta.SQL.Add(') ') ;
  LqryConsulta.SQL.Add(' UNION ALL ') ;
  LqryConsulta.SQL.Add('(') ;
  LqryConsulta.SQL.Add(LstrConsultaAdtAvulso) ;
  LqryConsulta.SQL.Add(') ') ;

  if (not FDadosAbertura.strIncrementoCadPag.IsEmpty) and (Length(FDadosAbertura.arrIncDoc) = 0)  then
    LqryConsulta.ParamByName('INCDOC').AsString := FDadosAbertura.strIncrementoCadPag;

  if (FDadosAbertura.dtaDataInicial > 0) then
  begin
    LqryConsulta.ParamByName('DTAINI').AsDateTime := FDadosAbertura.dtaDataInicial;
    LqryConsulta.ParamByName('DTAFIN').AsDateTime := FDadosAbertura.dtaDataFinal;
  end;

  if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
    LqryConsulta.ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;

  LqryConsulta.Open ;

  Result := LqryConsulta ;
end;

function TRepositorioContabil.fRetPagamentoPCP(
  const AcdsOrigemCtp: TUniClientDataSet; const AqryCTP: TUniQuery): String;
begin
  Result := '' ;
  if not Assigned(AcdsOrigemCtp) then
    Exit ;

  if AqryCTP.FieldByName('TIPO_PAGAMENTO').AsString <> 'Pagamentos Avulsos' then
    Exit ;

  if AqryCTP.FieldByName('CTA_PROCON').AsString <> '1' then
    Exit ;

  if AcdsOrigemCtp.FindKey([AqryCTP.FieldByName('CTP_NUMDUP').AsString,
                            AqryCTP.FieldByName('CTP_PARCEL').AsString,
                            AqryCTP.FieldByName('FOR_CODFOR').AsString,
                            AqryCTP.FieldByName('CTP_CODEMP').AsString,
                            AqryCTP.FieldByName('SERIE_').AsString]) then
    Result := PGT_PAGAMENTO_PCP ;
end;

function TRepositorioContabil.fRetParametrosContabil(strTipo: String): TObjectList<TParametroContabil>;
  var
    qryAux: TUniQuery;
    parametroContabil: TParametroContabil;
begin
  FListaParametrosContabil.Clear;

  Result := FListaParametrosContabil;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSqlParametrosContabil;
      ParamByName('TIPO').AsString := strTipo;
      Open;

      First;
      while not Eof do
      begin
        parametroContabil := TParametroContabil.Create;

        parametroContabil.strSequenciaParametro := FieldByName('CON_SEQPAR').AsString;
        parametroContabil.strTipoLancamento := FieldByName('CON_TIPLAN').AsString;
        parametroContabil.strFormaPagamento := FieldByName('CON_FORPGO').AsString;
        parametroContabil.strNaturezaOperacao := FieldByName('CON_NATOPE').AsString;
        parametroContabil.strDescricaoValor := FieldByName('CON_DESVAL').AsString;
        parametroContabil.strCfop := FieldByName('CON_CLAFIS').AsString;
        parametroContabil.strContaCredito := FieldByName('CON_CONCRE').AsString;
        parametroContabil.blnCreditoClienteFornecedor := FieldByName('CON_CFCRED').AsInteger = 1;
        parametroContabil.blnCreditoPlanoContas := FieldByName('CON_PCCRED').AsInteger = 1;
        parametroContabil.blnCreditoPortador := FieldByName('CON_PORCRE').AsInteger = 1;
        parametroContabil.strContaDebito := FieldByName('CON_CONDEB').AsString;
        parametroContabil.blnDebitoClienteFornecedor := FieldByName('CON_CFDEBI').AsInteger = 1;
        parametroContabil.blnDebitoPlanoContas := FieldByName('CON_PCDEBI').AsInteger = 1;
        parametroContabil.blnDebitoPortador := FieldByName('CON_PORDEB').AsInteger = 1;
        parametroContabil.strComplementoDebito := FieldByName('CON_CMPDEB').AsString;
        parametroContabil.strComplementosParametro := FieldByName('COMPLEMENTOS').AsString;
        parametroContabil.strCodigoHistoricoPadrao := FieldByName('PAD_CODIGO').AsString;
        parametroContabil.strDescricaoHistoricoPadrao := FieldByName('PAD_DESCRI').AsString;
        parametroContabil.strDescricaoPagamento := FieldByName('CON_PAGAME').AsString;
        parametroContabil.strBaixaCadastroDebito := FieldByName('CON_TIPPCD').AsString;
        parametroContabil.strBaixaCadastroCredito := FieldByName('CON_TIPPCC').AsString;
        parametroContabil.blnPagamentoAntecipado := FieldByName('CON_PAGANT').AsString = 'Sim';
        parametroContabil.dtaVigenciaInicio := FieldByName('VIGINI').AsDateTime;
        parametroContabil.dtaVigenciaFinal := FieldByName('VIGFIN').AsDateTime;

        if (not parametroContabil.fParametrizouCredito) or
           (not parametroContabil.fParametrizouDebito) then
          parametroContabil.strHashParCon := FieldByName('CON_MD5CLA').AsString ;

        FListaParametrosContabil.Add(parametroContabil);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioContabil.fRetSqlParametrosContabil: string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CON_SEQPAR, ';
  strSQL := strSQL + '  CON_TIPLAN, ';
  strSQL := strSQL + '  CON_FORPGO, ';
  strSQL := strSQL + '  CON_NATOPE, ';
  strSQL := strSQL + '  CON_DESVAL, ';
  strSQL := strSQL + '  CON_PAGAME, ';
  strSQL := strSQL + '  CON_CLAFIS, ';
  strSQL := strSQL + '  CON_DTAHRA, ';
  strSQL := strSQL + '  CON_CONCRE, ';
  strSQL := strSQL + '  CON_CFCRED, ';
  strSQL := strSQL + '  CON_PORCRE, ';
  strSQL := strSQL + '  CON_HISCRE, ';
  strSQL := strSQL + '  CON_CMPCRE, ';
  strSQL := strSQL + '  CON_CONDEB, ';
  strSQL := strSQL + '  CON_CFDEBI, ';
  strSQL := strSQL + '  CON_PORDEB, ';
  strSQL := strSQL + '  CON_HISDEB, ';
  strSQL := strSQL + '  CON_CMPDEB, ';
  strSQL := strSQL + '  CON_PCCRED, ';
  strSQL := strSQL + '  CON_PCDEBI, ';
  strSQL := strSQL + '  CON_TIPPCD, ';
  strSQL := strSQL + '  CON_TIPPCC, ';
  strSQL := strSQL + '  PAD_DESCRI, ';
  strSQL := strSQL + '  COALESCE(PAD_CODIGO,0) AS PAD_CODIGO, ';
  strSQL := strSQL + '  CON_MD5CLA, ';
  strSQL := strSQL + '  CON_NATCFO, ';
  strSQL := strSQL + '  CON_VIGINI, ';
  strSQL := strSQL + '  CON_VIGFIN, ';
  strSQL := strSQL + '  CAST(COALESCE(CON_VIGINI, "2000-01-01") AS DATE) AS VIGINI, ';
  strSQL := strSQL + '  CAST(COALESCE(CON_VIGFIN, "3000-01-01") AS DATE) AS VIGFIN, ';

  if (FDadosAbertura.blnCON_PAGANT) then
    strSQL := strSQL + '  CON_PAGANT, '
  else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CON_PAGANT, ';

  if (FDadosAbertura.blnUsaCheckListComplemento) and (FDadosAbertura.blnConSeqParExiste) then
    strSQL := strSQL + ' CAST((SELECT GROUP_CONCAT(PAR_COMPLE SEPARATOR "_") FROM CMPPAR WHERE PAR_SEQPAR = CON_SEQPAR) AS CHAR(255)) AS COMPLEMENTOS '
  else
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS COMPLEMENTOS ';

  strSQL := strSQL + 'FROM';
  strSQL := strSQL + '  PARCON ';
  strSQL := strSQL + '  LEFT JOIN HISPAD ON PAD_CODIGO = CON_HISCRE ';
  if fCfgHisTpl then
    strSQL := strSQL + ' AND PAD_TPLACO = ' + fRetTplacoEmpresaLogada.QuotedString
  else
    strSQL := strSQL + ' AND IFNULL(PAD_TPLACO, "") = "" ';
  strSQL := strSQL + ' WHERE CON_TIPLAN = :TIPO ';
  if fCfgConEmp = 'S' then
  begin
    strSQL := strSQL + ' AND PARCON.CON_CODEMP = ' + VS_strCodEmp.QuotedString ;
  end
  else
  begin
    strSQL := strSQL + ' AND PARCON.CON_CODEMP IS NULL ' ;
  end ;
  Result := strSQL;
end;

// Ao alterar a clausula Where deste metodo, deve ser alterado tambem o do metodo fRetSqlCtpLancadosPeriodoFechadoDtaPag porque ambos devem ser identicos
function TRepositorioContabil.fRetSqlTodosCadPagPorPeriodoDtaPag(const AConfAntecipado: TAjustaConsultaCadPagAntecipado = acaDefault): string;
  var
    strSQL: string;
    strDesabilitaAGR: string;
    LstrUsarVeioNFQuandoValorEmCodVel: string ;
begin
  LstrUsarVeioNFQuandoValorEmCodVel := fCondicaoUsarVeioNFQuandoValorEmCodVel ;
  strDesabilitaAGR := '' ;
  if fCfgCAgrDp = 'S' then
  begin
    strDesabilitaAGR := ' AND FALSE ';
  end ;
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  P.CTP_CODFOR, ';
  strSQL := strSQL + '  P.CTP_SEQCON, ';
  strSQL := strSQL + '  P.CTP_EMPBAI, ';
  strSQL := strSQL + '  ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' AS CTP_CODEMP, ';
  strSQL := strSQL + '  P.CTP_CODEMP AS EMPCAD, ';
  strSQL := strSQL + '  P.CTP_NUMDUP, ';
  strSQL := strSQL + '  P.CTP_PARCEL, ';
  strSQL := strSQL + '  P.CTP_COMPET, ';
  strSQL := strSQL + '  ' + fAjustaColunaDataPagamento(AConfAntecipado) + ' AS CTP_DTAPAG, ';
  strSQL := strSQL + '  P.CTP_DTACAD, ';
  strSQL := strSQL + '  P.CTP_PAGANT, ';

  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_VALPAG, ROUND(P.CTP_VALPAG*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VALPAG, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_DINHEI, ROUND(P.CTP_DINHEI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_DINHEI, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CHQPRE, ROUND(P.CTP_CHQPRE*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_CHQPRE, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CHQAVI, ROUND(P.CTP_CHQAVI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_CHQAVI, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CARTAO, ROUND(P.CTP_CARTAO*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_CARTAO, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_ORDPAG, ROUND(P.CTP_ORDPAG*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_ORDPAG, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, P.CTP_VALJUR, ROUND(P.CTP_VALJUR*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VALJUR, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, ' + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + ', ROUND(' + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + '*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VALMUL, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, ' + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + ', ROUND(' + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + '*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VENDOR, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDES, ROUND(P.CTP_VALDES*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VALDES, ';
  strSQL := strSQL + '  IF(D.CTP_CODEVE IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CTP_CODEVE, ';

  strSQL := strSQL + '  P.CTP_VALPAG AS CTP_PGTVAL, ';
  strSQL := strSQL + '  P.CTP_DINHEI AS CTP_PGTDIN, ';
  strSQL := strSQL + '  P.CTP_CHQPRE AS CTP_PGTCHP, ';
  strSQL := strSQL + '  P.CTP_CHQAVI AS CTP_PGTCHA, ';
  strSQL := strSQL + '  P.CTP_CARTAO AS CTP_PGTCAR, ';
  strSQL := strSQL + '  P.CTP_ORDPAG AS CTP_PGTORP, ';
  strSQL := strSQL + '  P.CTP_VALORI AS CTP_PGTORI, ';
  strSQL := strSQL + '  P.CTP_VALJUR AS CTP_PGTJUR, ';
  strSQL := strSQL + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + ' AS CTP_PGTMUL, ';
  strSQL := strSQL + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + ' AS CTP_PGTVENDOR, ';
  strSQL := strSQL + '  P.CTP_VALDES AS CTP_PGTDES, ';
  strSQL := strSQL + '  P.CTP_VALDES AS CTP_VPISRF, P.CTP_VALDES AS CTP_VCOFRF, ';
  strSQL := strSQL + '  P.CTP_SERIE_ AS SERIE_, ';

  strSQL := strSQL + '  FOR_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  FOR_C_G_C_, ';
  strSQL := strSQL + '  IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS CONTA_FORNECEDOR, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCON, CTACAD.CTA_PLANCO) AS PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCTA, CTACAD.CTA_CODCTA) AS CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '  IFNULL(CTANCO_BAI.NCO_CODCON, CTABAI.CTA_PLANCO) AS PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '  IFNULL(CTANCO_BAI.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTAS_BAIXA, ';

  strSQL := strSQL + '  IFNULL(PORNCO.NCO_CODCON, PORBAI.POR_PLANCO) AS CONTA_PORBAI, ';
  strSQL := strSQL + '  IFNULL(PORNCO.NCO_CODPOR, PORBAI.POR_CODPOR) AS CODIGO_PORTADOR_BAIXA, ';

  strSQL := strSQL + '  ' + fAjustaTipoPagamentoSql(AConfAntecipado, 'IF('+LstrUsarVeioNFQuandoValorEmCodVel+', IF(P.CTP_CODVEL IS NOT NULL, IF(P.CTP_VEIONF = "S", "Pagamentos Fatura", "Pagamentos Avulsos"),'+' IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura")),'+' IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura"))') + ' AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CTA_PLARES, ';
  strSQL := strSQL + '  CADEMP.EMP_NOMEMP, ';

  //Buscar Cheque Emitido
  strSQL := strSQL + '  ( SELECT GROUP_CONCAT(CHQEMI.EMI_NUMCHQ) ';
  strSQL := strSQL + '      FROM CHQEMI ';
  strSQL := strSQL + '     WHERE CHQEMI.EMI_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '       AND CHQEMI.EMI_NUMDUP = P.CTP_NUMDUP ';
  strSQL := strSQL + '       AND CHQEMI.EMI_PARCEL = P.CTP_PARCEL ';
  strSQL := strSQL + '       AND CHQEMI.EMI_CODEMP = P.CTP_CODEMP ) AS EMI_NUMCHQ, ';

  strSQL := strSQL + '  P.AUTOINCREM AS CTPINC, ';
  strSQL := strSQL + '  P.CTP_HISBAI, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_VALORI, ROUND(P.CTP_VALORI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp(AConfAntecipado) + ', 2) AS CTP_VALORI, ';

  strSQL := strSQL + ' IFNULL(' + IfThen( AConfAntecipado = acaFaturaSemAgr, '""',  'AGR.CTP_NUMDUP' ) + ',"") AS DOCORI, ';
  strSQL := strSQL + ' "" AS ESPORI, P.CTP_HIST01 AS HIST01, ';

  strSQL := strSQL + ' PORBAI.POR_EXPAUT AS BAI_EXPAUT, ';
  strSQL := strSQL + ' PORCAD.POR_EXPAUT AS CAD_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CONPAG, NOTGER.GER_CONPAG) AS CONDICAO_PAGTO, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CLAFIS, NOTGER.GER_CLAFIS) AS CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + ' CADFIS.FIS_DTAENT, ';

  strSQL := strSQL + ' CAST(NULL AS CHAR(12)) AS CTP_NUMADT, ';

  strSQL := strSQL + fColunaTipCtp('P') + ', ';
  strSQL := strSQL + ' D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  if fCfgDesMva = 'S' then
  begin
    strSQL := strSQL + ' D.CTP_CODEMP AS CDE_CODEMP, ';
    strSQL := strSQL + ' ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    strSQL := strSQL + ' ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end
  else
  begin
    strSQL := strSQL + ' CAST("" AS CHAR(3)) AS CDE_CODEMP, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CDE_NOMEMP, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CDE_C_G_C_, ';
  end ;
  strSQL := strSQL + ' P.CTP_SEQBAI, ';

  strSQL := strSQL + ' CAST(0 AS UNSIGNED) AS UTILIZACAO_CREDITOS, ';

  strSQL := strSQL + ' (P.CTP_VALPAG < 0.00 AND COALESCE(P.CTP_CARTAO, 0.00) = 0.00 AND COALESCE(P.CTP_CHQAVI, 0.00) = 0.00 AND COALESCE(P.CTP_CHQPRE, 0.00) = 0.00 AND COALESCE(P.CTP_DINHEI, 0.00) = 0.00 AND COALESCE(P.CTP_ORDPAG, 0.00) = 0.00 ) AS ORIGEM_CREDITOS, ';
  strSQL := strSQL + ' P.CTP_PREVIS, ';
  strSQL := strSQL + ' EB.EMP_NOMEMP AS BAI_NOMEMP, ';
  strSQL := strSQL + ' EB.EMP_C_G_C_ AS BAI_C_G_C_, ';
  strSQL := strSQL + ' CADEMP.EMP_C_G_C_ AS EMP_C_G_C_, ';
  strSQL := strSQL + ' CAST(IFNULL(CTACAD.CTA_PROCON, "0") AS CHAR(1)) AS CTA_PROCON, ';
  strSQL := strSQL + ' EMPC.EMP_C_G_C_ AS CAD_C_G_C_, ';
  strSQL := strSQL + ' EMPC.EMP_NOMEMP AS CAD_NOMEMP, ';
  strSql := strsql + ' '+ fSqlRetornaColunaCtpIncFis + ', ' ;
  strSQL := strSQL + ' CADFIS.AUTOINCREM AS FISINC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG P ';
  strSQL := strSQL + '  JOIN CADEMP ON ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + '  JOIN CADEMP AS EMPC ON P.CTP_CODEMP = EMPC.EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  strSQL := strSQL + '                        P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  strSQL := strSQL + '                      ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  strSQL := strSQL + '                     (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADEMP EB ON P.CTP_EMPBAI = EB.EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = P.CTP_CODFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORBAI ';
  strSQL := strSQL + '    ON PORBAI.POR_CODPOR = P.CTP_PORBAI ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORCAD ';
  strSQL := strSQL + '    ON PORCAD.POR_CODPOR = P.CTP_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN CADCTA CTACAD ON CTACAD.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ';
  strSQL := strSQL + '  LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CTABAI, D.CTP_CODCTA) ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORBAI.POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' ';

  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' ';

  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO_CAD ON CTANCO_CAD.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ';
  strSQL := strSQL + '                              AND CTANCO_CAD.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ', D.CTP_CODEMP)', fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai)) ;

  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO_BAI ON CTANCO_BAI.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CTABAI, D.CTP_CODCTA) ';
  strSQL := strSQL + '                              AND CTANCO_BAI.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ', D.CTP_CODEMP)', fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai)) ;

  if AConfAntecipado <> acaFaturaSemAgr then
  begin
    strSQL := strSQL + '  ' + ifThen(AConfAntecipado in [acaFaturaComAgr], 'INNER', 'LEFT') + ' JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = P.CTP_NUMDUP ';
    strSQL := strSQL + '                      AND AGR.CTP_EMPAGR = P.CTP_CODEMP ';
    strSQL := strSQL + '                      AND AGR.CTP_CODFOR = P.CTP_CODFOR ' + strDesabilitaAGR;
  end ;

  strSQL := strSQL + '  ' + ifThen(AConfAntecipado in [acaFaturaSemAgr, acaFaturaComAgr], 'INNER', 'LEFT') + ' JOIN CADFIS ' ;
  strSQL := strSQL + '                  ON  FIS_NUMDOC = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_NUMDUP, P.CTP_NUMDUP) ', 'P.CTP_NUMDUP') + ' ';
  strSQL := strSQL + '                  AND FIS_CODEMP = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_CODEMP, P.CTP_CODEMP) ', 'P.CTP_CODEMP') + ' ';
  strSQL := strSQL + '                  AND FIS_FORCLI = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', AGR.CTP_CODFOR, P.CTP_CODFOR) ', 'P.CTP_CODFOR') + ' ';
  strSQL := strSQL + '                  AND FIS_TIP_FC = "F" ';
  strSQL := strSQL + '                  AND IFNULL(FIS_SERIE_,"") = ' + ifThen( AConfAntecipado <> acaFaturaSemAgr, ' IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ' + strDesabilitaAGR + ', IFNULL(AGR.CTP_SERIE_,""), IFNULL(P.CTP_SERIE_,""))', 'IFNULL(P.CTP_SERIE_, "")') + ' ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                  AND MOVGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND MOVGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                  AND NOTGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND NOTGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + ' WHERE TRUE ';


  strSQL := strSQL  +  TTrataIncDocContabil
                         .New
                         .fColunaIncDoc('P.AUTOINCREM')
                         .fIncDoc(FDadosAbertura.strIncrementoCadPag)
                         .fArrIncDoc(FDadosAbertura.arrIncDoc)
                         .fQuerySql(Nil)
                         .fExecute ;

  if (FDadosAbertura.dtaDataInicial > 0) then
    strSQL := strSQL + '   AND ' + fAjustaColunaDataPagamento(AConfAntecipado) + ' BETWEEN :DTAINI AND :DTAFIN ';

  if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
    strSQL := strSQL + '   AND ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' = :CODEMP ';

  if (not FDadosAbertura.blnExportaUsoConsumo) then
    strSQL := strSQL + '   AND P.CTP_USOCON = "N" ';

  if AConfAntecipado = acaDefault then
  begin
    strSQL := strSQL + '  AND TRIM(COALESCE(P.CTP_PAGANT, "")) <> "S" ';
  end
  else
  begin
    strSQL := strSQL + '  AND P.CTP_PAGANT = "S" ';
    case AConfAntecipado of
      acaFaturaSemAgr:
                     begin
                       strSQL := strSQL + '  AND SUBSTRING(P.CTP_NUMDUP, 1, 2) <> "AG" ';
                     end ;
      acaFaturaComAgr:
                     begin
                       strSQL := strSQL + '  AND SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG" ';
                     end ;
    end ;
  end ;

   strSQL := strSQL + ' ORDER BY P.AUTOINCREM, CADFIS.FIS_DTAENT DESC, D.CTP_FATCAL DESC ';

  Result := strSQL;
end;

function TRepositorioContabil.fSqlRetornaColunaCtpIncFis: String;
begin
  if FCtpIncFisExiste then
    Result := ' P.CTP_INCFIS '
  else
    Result := ' CAST(NULL AS CHAR(1)) AS CTP_INCFIS ' ;
end;

function TRepositorioContabil.fUsaCondicaoTipoPagamentoNoArredamento(
  AqryConsulta: TUniQuery): Boolean;
begin
  Result := False ;

  if AqryConsulta.FieldByName('CTP_PAGANT').AsString <> 'S' then
    Exit ;

  Result := AqryConsulta.FieldByName('TIPO_PAGAMENTO').AsString <> strTipoPagamento ;
end;

function TRepositorioContabil.fRetSqlTodosCadPagPorPeriodoAgrupadoCTP(
  strSqlTodosCadPagPorPeriodoDtaPag: string): string;
var
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTP_CODFOR, ';
  strSQL := strSQL + '   CTP_SEQCON, ';
  strSQL := strSQL + '   CTP_EMPBAI, ';
  strSQL := strSQL + '   CTP_CODEMP, ';
  strSQL := strSQL + '   EMPCAD,     ';
  strSQL := strSQL + '   CTP_NUMDUP, ';
  strSQL := strSQL + '   CTP_PARCEL, ';
  strSQL := strSQL + '   CTP_COMPET, ';
  strSQL := strSQL + '   CTP_DTAPAG, ';
  strSQL := strSQL + '   CTP_DTACAD, ';
  strSQL := strSQL + '   CTP_PAGANT, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VALPAG,0.00)) AS CTP_VALPAG, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_DINHEI,0.00)) AS CTP_DINHEI, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_CHQPRE,0.00)) AS CTP_CHQPRE, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_CHQAVI,0.00)) AS CTP_CHQAVI, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_CARTAO,0.00)) AS CTP_CARTAO, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_ORDPAG,0.00)) AS CTP_ORDPAG, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VALJUR,0.00)) AS CTP_VALJUR, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VALMUL,0.00)) AS CTP_VALMUL, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VENDOR,0.00)) AS CTP_VENDOR, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VALDES,0.00)) AS CTP_VALDES, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VPISRF,0.00)) AS CTP_VPISRF, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VCOFRF,0.00)) AS CTP_VCOFRF, ';
  strSQL := strSQL + '   CTP_CODEVE, ';
  strSQL := strSQL + '   CTP_PGTVAL, ';
  strSQL := strSQL + '   CTP_PGTDIN, ';
  strSQL := strSQL + '   CTP_PGTCHP, ';
  strSQL := strSQL + '   CTP_PGTCHA, ';
  strSQL := strSQL + '   CTP_PGTCAR, ';
  strSQL := strSQL + '   CTP_PGTORP, ';
  strSQL := strSQL + '   CTP_PGTORI, ';
  strSQL := strSQL + '   CTP_PGTJUR, ';
  strSQL := strSQL + '   CTP_PGTMUL, ';
  strSQL := strSQL + '   CTP_PGTVENDOR, ';
  strSQL := strSQL + '   CTP_PGTDES, ';
  strSQL := strSQL + '   SERIE_, ';
  strSQL := strSQL + '   FOR_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   FOR_C_G_C_, ';
  strSQL := strSQL + '   CONTA_FORNECEDOR, ';
  strSQL := strSQL + '   PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '   CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '   PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '   CODIGO_PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '   CONTA_PORBAI, ';
  strSQL := strSQL + '   CODIGO_PORTADOR_BAIXA, ';
  strSQL := strSQL + '   TIPO_PAGAMENTO, ';
  strSQL := strSQL + '   CTA_PLARES, ';
  strSQL := strSQL + '   EMP_NOMEMP, ';
  strSQL := strSQL + '   EMI_NUMCHQ, ';
  strSQL := strSQL + '   CTPINC, ';
  strSQL := strSQL + '   CTP_HISBAI, ';
  strSQL := strSQL + '   SUM(COALESCE(CTP_VALORI, 0.00)) AS  CTP_VALORI, ';
  strSQL := strSQL + '   DOCORI, ';
  strSQL := strSQL + '   HIST01, ';
  strSQL := strSQL + '   BAI_EXPAUT, ';
  strSQL := strSQL + '   CAD_EXPAUT, ';
  strSQL := strSQL + '   CONDICAO_PAGTO, ';
  strSQL := strSQL + '   CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   ESPORI, ';
  strSQL := strSQL + '   CTP_NUMADT, ';
  strSQL := strSQL + '   CTP_TIPCTP, ';
  strSQL := strSQL + '   IS_CTPDET, ';
  strSQL := strSQL + '   CDE_CODEMP, ';
  strSQL := strSQL + '   CDE_NOMEMP, ';
  strSQL := strSQL + '   CDE_C_G_C_, ';
  strSQL := strSQL + '   CTP_SEQBAI, ';
  strSQL := strSQL + '   UTILIZACAO_CREDITOS, ';
  strSQL := strSQL + '   ORIGEM_CREDITOS, ';
  strSQL := strSQL + '   CTP_PREVIS, ';
  strSQL := strSQL + '   BAI_NOMEMP, ';
  strSQL := strSQL + '   BAI_C_G_C_, ';
  strSQL := strSQL + '   EMP_C_G_C_, ';
  strSQL := strSQL + '   CTA_PROCON, ';
  strSQL := strSQL + '   CAD_C_G_C_, ';
  strSQL := strSQL + '   CAD_NOMEMP,  ';
  strSQL := strSQL + '   CTP_INCFIS,  ';
  strSQL := strSQL + '   FISINC  ';
  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + strSqlTodosCadPagPorPeriodoDtaPag ;

  strSQL := strSQL + '   ) AS SEL ';
  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   CTP_CODFOR, ';
  strSQL := strSQL + '   CTP_SEQCON, ';
  strSQL := strSQL + '   CTP_EMPBAI, ';
  strSQL := strSQL + '   CTP_CODEMP, ';
  strSQL := strSQL + '   EMPCAD,     ';
  strSQL := strSQL + '   CTP_NUMDUP, ';
  strSQL := strSQL + '   CTP_PARCEL, ';
  strSQL := strSQL + '   CTP_COMPET, ';
  strSQL := strSQL + '   CTP_DTAPAG, ';
  strSQL := strSQL + '   CTP_DTACAD, ';
  strSQL := strSQL + '   CTP_PAGANT, ';
  strSQL := strSQL + '   CTP_CODEVE, ';
  strSQL := strSQL + '   CTP_PGTVAL, ';
  strSQL := strSQL + '   CTP_PGTDIN, ';
  strSQL := strSQL + '   CTP_PGTCHP, ';
  strSQL := strSQL + '   CTP_PGTCHA, ';
  strSQL := strSQL + '   CTP_PGTCAR, ';
  strSQL := strSQL + '   CTP_PGTORP, ';
  strSQL := strSQL + '   CTP_PGTORI, ';
  strSQL := strSQL + '   CTP_PGTJUR, ';
  strSQL := strSQL + '   CTP_PGTMUL, ';
  strSQL := strSQL + '   CTP_PGTVENDOR, ';
  strSQL := strSQL + '   CTP_PGTDES, ';
  strSQL := strSQL + '   SERIE_, ';
  strSQL := strSQL + '   FOR_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   FOR_C_G_C_, ';
  strSQL := strSQL + '   CONTA_FORNECEDOR, ';
  strSQL := strSQL + '   PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '   CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '   PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '   CODIGO_PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '   CONTA_PORBAI, ';
  strSQL := strSQL + '   CODIGO_PORTADOR_BAIXA, ';
  strSQL := strSQL + '   TIPO_PAGAMENTO, ';
  strSQL := strSQL + '   CTA_PLARES, ';
  strSQL := strSQL + '   EMP_NOMEMP, ';
  strSQL := strSQL + '   EMI_NUMCHQ, ';
  strSQL := strSQL + '   CTPINC, ';
  strSQL := strSQL + '   CTP_HISBAI, ';
  strSQL := strSQL + '   DOCORI, ';
  strSQL := strSQL + '   HIST01, ';
  strSQL := strSQL + '   BAI_EXPAUT, ';
  strSQL := strSQL + '   CAD_EXPAUT, ';
  strSQL := strSQL + '   CONDICAO_PAGTO, ';
  strSQL := strSQL + '   CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   ESPORI, ';
  strSQL := strSQL + '   CTP_NUMADT, ';
  strSQL := strSQL + '   CTP_TIPCTP, ';
  strSQL := strSQL + '   IS_CTPDET, ';
  strSQL := strSQL + '   CDE_CODEMP, ';
  strSQL := strSQL + '   CDE_NOMEMP, ';
  strSQL := strSQL + '   CDE_C_G_C_, ';
  strSQL := strSQL + '   CTP_SEQBAI, ';
  strSQL := strSQL + '   UTILIZACAO_CREDITOS, ';
  strSQL := strSQL + '   ORIGEM_CREDITOS, ';
  strSQL := strSQL + '   CTP_PREVIS, ';
  strSQL := strSQL + '   BAI_NOMEMP, ';
  strSQL := strSQL + '   BAI_C_G_C_, ';
  strSQL := strSQL + '   EMP_C_G_C_, ';
  strSQL := strSQL + '   CTA_PROCON, ';
  strSQL := strSQL + '   CAD_C_G_C_, ';
  strSQL := strSQL + '   CAD_NOMEMP,  ';
  strSQL := strSQL + '   CTP_INCFIS,  ';
  strSQL := strSQL + '   FISINC  ';
  strSQL := strSQL + ' ORDER BY CTPINC, FIS_DTAENT DESC ';
  result := strSQL ;
end;

function TRepositorioContabil.fRetSqlTodosCadPagPorPeriodoAgrupadoPCP(
  strSqlTodosCadPagPorPeriodoDtaPag: string): string;
var
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' CTP_CODFOR, ';
  strSQL := strSQL + ' CTP_SEQCON, ';
  strSQL := strSQL + ' CTP_EMPBAI, ';
  strSQL := strSQL + ' CTP_CODEMP, ';
  strSQL := strSQL + ' EMPCAD,     ';
  strSQL := strSQL + ' CTP_NUMDUP, ';
  strSQL := strSQL + ' CTP_PARCEL, ';
  strSQL := strSQL + ' CTP_COMPET, ';
  strSQL := strSQL + ' CTP_DTAPAG, ';
  strSQL := strSQL + ' CTP_DTACAD, ';
  strSQL := strSQL + ' CTP_PAGANT, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VALPAG,0.00)) AS CTP_VALPAG, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_DINHEI,0.00)) AS CTP_DINHEI, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_CHQPRE,0.00)) AS CTP_CHQPRE, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_CHQAVI,0.00)) AS CTP_CHQAVI, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_CARTAO,0.00)) AS CTP_CARTAO, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_ORDPAG,0.00)) AS CTP_ORDPAG, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VALORI,0.00)) AS CTP_VALORI, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VALJUR,0.00)) AS CTP_VALJUR, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VALMUL,0.00)) AS CTP_VALMUL, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VENDOR,0.00)) AS CTP_VENDOR, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VALDES,0.00)) AS CTP_VALDES, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VPISRF,0.00)) AS CTP_VPISRF, ';
  strSQL := strSQL + ' SUM(COALESCE(CTP_VCOFRF,0.00)) AS CTP_VCOFRF, ';
  strSQL := strSQL + ' CTP_CODEVE, ';
  strSQL := strSQL + ' CTP_PGTVAL, ';
  strSQL := strSQL + ' CTP_PGTDIN, ';
  strSQL := strSQL + ' CTP_PGTCHP, ';
  strSQL := strSQL + ' CTP_PGTCHA, ';
  strSQL := strSQL + ' CTP_PGTCAR, ';
  strSQL := strSQL + ' CTP_PGTORP, ';
  strSQL := strSQL + ' CTP_PGTORI, ';
  strSQL := strSQL + ' CTP_PGTJUR, ';
  strSQL := strSQL + ' CTP_PGTMUL, ';
  strSQL := strSQL + ' CTP_PGTVENDOR, ';
  strSQL := strSQL + ' CTP_PGTDES, ';
  strSQL := strSQL + ' SERIE_, ';
  strSQL := strSQL + ' FOR_CODFOR, ';
  strSQL := strSQL + ' FOR_NOMFOR, ';
  strSQL := strSQL + ' FOR_C_G_C_, ';
  strSQL := strSQL + ' CONTA_FORNECEDOR, ';
  strSQL := strSQL + ' PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + ' CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + ' PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + ' CODIGO_PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + ' CONTA_CADASTRO, ';
  strSQL := strSQL + ' CODIGO_PORTADOR_CADASTRO, ';
  strSQL := strSQL + ' TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' CTA_PLARES, ';
  strSQL := strSQL + ' EMP_NOMEMP, ';
  strSQL := strSQL + ' EMI_NUMCHQ, ';
  strSQL := strSQL + ' CTPINC, ';
  strSQL := strSQL + ' CTP_HISBAI, ';
  strSQL := strSQL + ' DOCORI, ';
  strSQL := strSQL + ' ESPORI, ';
  strSQL := strSQL + ' HIST01, ';
  strSQL := strSQL + ' CAD_EXPAUT, ';
  strSQL := strSQL + ' CONDICAO_PAGTO, ';
  strSQL := strSQL + ' CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + ' FIS_DTAENT, ';
  strSQL := strSQL + ' CTP_NUMADT, ';
  strSQL := strSQL + ' CTP_TIPCTP, ';
  strSQL := strSQL + ' IS_CTPDET, ';
  strSQL := strSQL + ' CDE_CODEMP, ';
  strSQL := strSQL + ' CDE_NOMEMP, ';
  strSQL := strSQL + ' CDE_C_G_C_, ';
  strSQL := strSQL + ' CTP_SEQBAI, ';
  strSQL := strSQL + ' UTILIZACAO_CREDITOS, ';
  strSQL := strSQL + ' ORIGEM_CREDITOS, ';
  strSQL := strSQL + ' CTP_PREVIS, ';
  strSQL := strSQL + ' BAI_NOMEMP, ';
  strSQL := strSQL + ' BAI_C_G_C_, ';
  strSQL := strSQL + ' EMP_C_G_C_, ';
  strSQL := strSQL + ' CTA_PROCON, ';
  strSQL := strSQL + ' CTP_INCFIS, ';
  strSQL := strSQL + ' FISINC ';
  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + strSqlTodosCadPagPorPeriodoDtaPag ;

  strSQL := strSQL + '   ) AS SEL ';
  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + ' CTP_CODFOR, ';
  strSQL := strSQL + ' CTP_SEQCON, ';
  strSQL := strSQL + ' CTP_EMPBAI, ';
  strSQL := strSQL + ' CTP_CODEMP, ';
  strSQL := strSQL + ' EMPCAD,     ';
  strSQL := strSQL + ' CTP_NUMDUP, ';
  strSQL := strSQL + ' CTP_PARCEL, ';
  strSQL := strSQL + ' CTP_COMPET, ';
  strSQL := strSQL + ' CTP_DTAPAG, ';
  strSQL := strSQL + ' CTP_DTACAD, ';
  strSQL := strSQL + ' CTP_PAGANT, ';
  strSQL := strSQL + ' CTP_CODEVE, ';
  strSQL := strSQL + ' CTP_PGTVAL, ';
  strSQL := strSQL + ' CTP_PGTDIN, ';
  strSQL := strSQL + ' CTP_PGTCHP, ';
  strSQL := strSQL + ' CTP_PGTCHA, ';
  strSQL := strSQL + ' CTP_PGTCAR, ';
  strSQL := strSQL + ' CTP_PGTORP, ';
  strSQL := strSQL + ' CTP_PGTORI, ';
  strSQL := strSQL + ' CTP_PGTJUR, ';
  strSQL := strSQL + ' CTP_PGTMUL, ';
  strSQL := strSQL + ' CTP_PGTVENDOR, ';
  strSQL := strSQL + ' CTP_PGTDES, ';
  strSQL := strSQL + ' SERIE_, ';
  strSQL := strSQL + ' FOR_CODFOR, ';
  strSQL := strSQL + ' FOR_NOMFOR, ';
  strSQL := strSQL + ' FOR_C_G_C_, ';
  strSQL := strSQL + ' CONTA_FORNECEDOR, ';
  strSQL := strSQL + ' PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + ' CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + ' PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + ' CODIGO_PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + ' CONTA_CADASTRO, ';
  strSQL := strSQL + ' CODIGO_PORTADOR_CADASTRO, ';
  strSQL := strSQL + ' TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' CTA_PLARES, ';
  strSQL := strSQL + ' EMP_NOMEMP, ';
  strSQL := strSQL + ' EMI_NUMCHQ, ';
  strSQL := strSQL + ' CTPINC, ';
  strSQL := strSQL + ' CTP_HISBAI, ';
  strSQL := strSQL + ' DOCORI, ';
  strSQL := strSQL + ' ESPORI, ';
  strSQL := strSQL + ' HIST01, ';
  strSQL := strSQL + ' CAD_EXPAUT, ';
  strSQL := strSQL + ' CONDICAO_PAGTO, ';
  strSQL := strSQL + ' CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + ' FIS_DTAENT, ';
  strSQL := strSQL + ' CTP_NUMADT, ';
  strSQL := strSQL + ' CTP_TIPCTP, ';
  strSQL := strSQL + ' IS_CTPDET, ';
  strSQL := strSQL + ' CDE_CODEMP, ';
  strSQL := strSQL + ' CDE_NOMEMP, ';
  strSQL := strSQL + ' CDE_C_G_C_, ';
  strSQL := strSQL + ' CTP_SEQBAI, ';
  strSQL := strSQL + ' UTILIZACAO_CREDITOS, ';
  strSQL := strSQL + ' ORIGEM_CREDITOS, ';
  strSQL := strSQL + ' CTP_PREVIS, ';
  strSQL := strSQL + ' BAI_NOMEMP, ';
  strSQL := strSQL + ' BAI_C_G_C_, ';
  strSQL := strSQL + ' EMP_C_G_C_, ';
  strSQL := strSQL + ' CTA_PROCON, ';
  strSQL := strSQL + ' CTP_INCFIS, ';
  strSQL := strSQL + ' FISINC ';
  strSQL := strSQL + ' ORDER BY CTPINC, FIS_DTAENT DESC ';
  result := strSQL ;
end;

procedure TRepositorioContabil.pAjustaDescontosCtpDet(
  var AcpLancamento: TContasPagar);
var
  LlstPlanoContas: TObjectList<TDictionary<string,string>> ;
  LdictItem: TDictionary<string,string> ;
  LblnParametrizado: boolean ;
  LitemPagar: TContasPagar ;
begin
  if not AcpLancamento.IsCtpDet then
  begin
    exit ;
  end;

  LlstPlanoContas := fCfgPCDeDt ;
  if not Assigned(LlstPlanoContas) then
  begin
    exit ;
  end;

  try
    LblnParametrizado := False ;
    for LdictItem in LlstPlanoContas do
    begin
      if LdictItem['JDT_TPCDPG'] = CONTA_DO_CADASTRO then
      begin
        LblnParametrizado := LdictItem['JDT_CODCTA'] = AcpLancamento.planoContasCadastro.strCodigo ;
      end
      else if LdictItem['JDT_TPCDPG'] = CONTA_DA_BAIXA then
      begin
        LblnParametrizado := LdictItem['JDT_CODCTA'] = AcpLancamento.planoContasBaixa.strCodigo ;
      end;

      if LblnParametrizado then
      begin
        break ;
      end;

    end;
  finally
    FreeAndNil(LlstPlanoContas) ;
  end;

  if LblnParametrizado then
  begin
    ///ajusta os valores
    AcpLancamento.fltValorDesconto := abs(AcpLancamento.fltValorPago) ;
    AcpLancamento.blnDescJurAjustado := True ;
    AcpLancamento.fltValorPago := abs(AcpLancamento.fltValorPago) ;
    AcpLancamento.fltValorOriginal := abs(AcpLancamento.fltValorPago) ;
    AcpLancamento.fltValorDinheiro := abs(AcpLancamento.fltValorDinheiro) ;
    AcpLancamento.fltValorChequePre := abs(AcpLancamento.fltValorChequePre) ;
    AcpLancamento.fltValorChequeVista := abs(AcpLancamento.fltValorChequeVista) ;
    AcpLancamento.fltValorCartao := abs(AcpLancamento.fltValorCartao) ;
    AcpLancamento.fltValorOrdemPagamento := abs(AcpLancamento.fltValorOrdemPagamento) ;
    ///ajusta os valores do lançamento com maior rateio
    for LitemPagar in FListaPagamentos do
    begin
      if LitemPagar.strAutoincrem = AcpLancamento.strAutoincrem then
      begin
        LitemPagar.fltValorPago := LitemPagar.fltValorPago - AcpLancamento.fltValorDesconto ;
        LitemPagar.fltValorDinheiro := IIF(LitemPagar.fltValorDinheiro <> 0.00, LitemPagar.fltValorDinheiro - AcpLancamento.fltValorDesconto, 0.00) ;
        LitemPagar.fltValorChequePre := IIF(LitemPagar.fltValorChequePre <> 0.00, LitemPagar.fltValorChequePre - AcpLancamento.fltValorDesconto, 0.00) ;
        LitemPagar.fltValorChequeVista := IIF(LitemPagar.fltValorChequeVista <> 0.00, LitemPagar.fltValorChequeVista - AcpLancamento.fltValorDesconto, 0.00) ;
        LitemPagar.fltValorCartao := IIF(LitemPagar.fltValorCartao <> 0.00, LitemPagar.fltValorCartao - AcpLancamento.fltValorDesconto, 0.00) ;
        LitemPagar.fltValorOrdemPagamento := IIF(LitemPagar.fltValorOrdemPagamento <> 0.00, LitemPagar.fltValorOrdemPagamento - AcpLancamento.fltValorDesconto, 0.00) ;
        break ;
      end;
    end;
  end;

end;

procedure TRepositorioContabil.pAjustaJurosCtpDet(
  var AcpLancamento: TContasPagar);
var
  LlstPlanoContas: TObjectList<TDictionary<string,string>> ;
  LdictItem: TDictionary<string,string> ;
  LblnParametrizado: boolean ;
  LitemPagar: TContasPagar ;
begin
  if not AcpLancamento.IsCtpDet then
  begin
    exit ;
  end;

  LlstPlanoContas := fCfgPCJuDt ;
  if not Assigned(LlstPlanoContas) then
  begin
    exit ;
  end;

  try
    LblnParametrizado := False ;
    for LdictItem in LlstPlanoContas do
    begin
      if LdictItem['JDT_TPCDPG'] = CONTA_DO_CADASTRO then
      begin
        LblnParametrizado := LdictItem['JDT_CODCTA'] = AcpLancamento.planoContasCadastro.strCodigo ;
      end
      else if LdictItem['JDT_TPCDPG'] = CONTA_DA_BAIXA then
      begin
        LblnParametrizado := LdictItem['JDT_CODCTA'] = AcpLancamento.planoContasBaixa.strCodigo ;
      end;

      if LblnParametrizado then
      begin
        break ;
      end;

    end;
  finally
    FreeAndNil(LlstPlanoContas) ;
  end;

  if LblnParametrizado then
  begin
    ///ajusta os valores
    AcpLancamento.fltValorJuros := AcpLancamento.fltValorPago ;
    AcpLancamento.blnDescJurAjustado := True ;
    ///ajusta os valores do lançamento com maior rateio
    for LitemPagar in FListaPagamentos do
    begin
      if LitemPagar.strAutoincrem = AcpLancamento.strAutoincrem then
      begin
        LitemPagar.fltValorOriginal := LitemPagar.fltValorOriginal - AcpLancamento.fltValorJuros ;
        break ;
      end;
    end;
  end;


end;

procedure TRepositorioContabil.pAjustaLogCtpAntecipado(var AqryPagar: TUniQuery;
  AcdsInfo: TUniClientDataSet);
begin
  if AcdsInfo.FindKey([AqryPagar.FieldByName('CTP_CODFOR').AsString,
                       AqryPagar.FieldByName('CTP_PARCEL').AsString,
                       AqryPagar.FieldByName('CTP_CODEMP').AsString,
                       AqryPagar.FieldByName('CTP_DTACAD').AsDateTime]) then
  begin
    AqryPagar.Edit ;
    AqryPagar.FieldByName('CTP_NUMADT').AsString := AcdsInfo.FieldByName('CTP_NUMDUP').AsString ;
    AqryPagar.Post ;
  end ;
end;

procedure TRepositorioContabil.pAjustarArredondamentoCtp(
  const ADadosAbertura: TDadosAbertura;
  AlstPagamentos: TObjectList<TContasPagar>;
  AdictDif: TDictValCtp);
var
  contasPagar: TContasPagar;
  strChave: string;
  recValDif: TValCtp;
  blnValorRestante: boolean;
begin
  if AlstPagamentos.Count <= 0 then
    Exit;

  if AdictDif.Count <= 0 then
    Exit;

  strChave := '';
  blnValorRestante := false;
  for contasPagar in AlstPagamentos do
  begin
    if (not contasPagar.IsCtpDet) and (contasPagar.strSerie <> 'AG') then
      continue;

    if strChave <> contasPagar.strAutoincrem + contasPagar.strTipoPagamento then
    begin
      strChave := contasPagar.strAutoincrem + contasPagar.strTipoPagamento;
      blnValorRestante := AdictDif.TryGetValue(strChave, recValDif);
    end;

    if not blnValorRestante then
      continue;

    blnValorRestante := false;

    if recValDif.fltValPag <> 0 then
    begin
      if ((contasPagar.fltValorPago >= 0) and ((contasPagar.fltValorPago + recValDif.fltValPag) >= 0))
        or ((contasPagar.fltValorPago <= 0) and ((contasPagar.fltValorPago + recValDif.fltValPag) <= 0)) then
      begin
        contasPagar.fltValorPago := contasPagar.fltValorPago + recValDif.fltValPag;
        recValDif.fltValPag := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltDinhei <> 0 then
    begin
      if ((contasPagar.fltValorDinheiro >= 0) and ((contasPagar.fltValorDinheiro + recValDif.fltDinhei) >= 0))
        or ((contasPagar.fltValorDinheiro <= 0) and ((contasPagar.fltValorDinheiro + recValDif.fltDinhei) <= 0)) then
      begin
        contasPagar.fltValorDinheiro := contasPagar.fltValorDinheiro + recValDif.fltDinhei;
        recValDif.fltDinhei := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltChqPre <> 0 then
    begin
      if ((contasPagar.fltValorChequePre >= 0) and ((contasPagar.fltValorChequePre + recValDif.fltChqPre) >= 0))
        or ((contasPagar.fltValorChequePre <= 0) and ((contasPagar.fltValorChequePre + recValDif.fltChqPre) <= 0)) then
      begin
        contasPagar.fltValorChequePre := contasPagar.fltValorChequePre + recValDif.fltChqPre;
        recValDif.fltChqPre := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltChqAvi <> 0 then
    begin
      if ((contasPagar.fltValorChequeVista >= 0) and ((contasPagar.fltValorChequeVista + recValDif.fltChqAvi) >= 0))
        or ((contasPagar.fltValorChequeVista <= 0) and ((contasPagar.fltValorChequeVista + recValDif.fltChqAvi) <= 0)) then
      begin
        contasPagar.fltValorChequeVista := contasPagar.fltValorChequeVista + recValDif.fltChqAvi;
        recValDif.fltChqAvi := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltCartao <> 0 then
    begin
      if ((contasPagar.fltValorCartao >= 0) and ((contasPagar.fltValorCartao + recValDif.fltCartao) >= 0))
        or ((contasPagar.fltValorCartao <= 0) and ((contasPagar.fltValorCartao + recValDif.fltCartao) <= 0)) then
      begin
        contasPagar.fltValorCartao := contasPagar.fltValorCartao + recValDif.fltCartao;
        recValDif.fltCartao := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltOrdPag <> 0 then
    begin
      if ((contasPagar.fltValorOrdemPagamento >= 0) and ((contasPagar.fltValorOrdemPagamento + recValDif.fltOrdPag) >= 0))
        or ((contasPagar.fltValorOrdemPagamento <= 0) and ((contasPagar.fltValorOrdemPagamento + recValDif.fltOrdPag) <= 0)) then
      begin
        contasPagar.fltValorOrdemPagamento := contasPagar.fltValorOrdemPagamento + recValDif.fltOrdPag;
        recValDif.fltOrdPag := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltValOri <> 0 then
    begin
      if ((contasPagar.fltValorOriginal >= 0) and ((contasPagar.fltValorOriginal + recValDif.fltValOri) >= 0))
        or ((contasPagar.fltValorOriginal <= 0) and ((contasPagar.fltValorOriginal + recValDif.fltValOri) <= 0)) then
      begin
        contasPagar.fltValorOriginal := contasPagar.fltValorOriginal + recValDif.fltValOri;
        recValDif.fltValOri := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltJuros <> 0 then
    begin
      if ((contasPagar.fltValorJuros >= 0) and ((contasPagar.fltValorJuros + recValDif.fltJuros) >= 0))
        or ((contasPagar.fltValorJuros <= 0) and ((contasPagar.fltValorJuros + recValDif.fltJuros) <= 0)) then
      begin
        contasPagar.fltValorJuros := contasPagar.fltValorJuros + recValDif.fltJuros;
        recValDif.fltJuros := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltMulta <> 0 then
    begin
      if ((contasPagar.fltValorMulta >= 0) and ((contasPagar.fltValorMulta + recValDif.fltMulta) >= 0))
        or ((contasPagar.fltValorMulta <= 0) and ((contasPagar.fltValorMulta + recValDif.fltMulta) <= 0)) then
      begin
        contasPagar.fltValorMulta := contasPagar.fltValorMulta + recValDif.fltMulta;
        recValDif.fltMulta := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltVendor <> 0 then
    begin
      if ((contasPagar.fltValorVendor >= 0) and ((contasPagar.fltValorVendor + recValDif.fltVendor) >= 0))
        or ((contasPagar.fltValorVendor <= 0) and ((contasPagar.fltValorVendor + recValDif.fltVendor) <= 0)) then
      begin
        contasPagar.fltValorVendor := contasPagar.fltValorVendor + recValDif.fltVendor;
        recValDif.fltVendor := 0;
      end
      else
        blnValorRestante := true;
    end;

    if recValDif.fltDesconto <> 0 then
    begin
      if ((contasPagar.fltValorDesconto >= 0) and ((contasPagar.fltValorDesconto + recValDif.fltDesconto) >= 0))
        or ((contasPagar.fltValorDesconto <= 0) and ((contasPagar.fltValorDesconto + recValDif.fltDesconto) <= 0)) then
      begin
        contasPagar.fltValorDesconto := contasPagar.fltValorDesconto + recValDif.fltDesconto;
        recValDif.fltDesconto := 0;
      end
      else
        blnValorRestante := true;
    end;
  end;
end;

procedure TRepositorioContabil.pLiberaDictCtpFisSet(
  const ADict: TDictCtpFisSet);
var
  LFisSet: TSetFisInc;
begin
  for LFisSet in ADict.Values do
    LFisSet.Free;

  ADict.Free;
end;

procedure TRepositorioContabil.pMontaReferenciaDuplicacaoCtpComCadFis(
  const AConsulta: TUniQuery; const ADictCtpFisSet: TDictCtpFisSet;
  const ADictFisIncRef: TDictFisInc);
var
  LCtpInc, LFisInc, LCtpIncFis: string;
  LFisSet: TSetFisInc;
begin
  AConsulta.First;
  while not AConsulta.Eof do
  begin
    // desconsidera os registros de agrupamento
    if copy(AConsulta.FieldByName('CTP_NUMDUP').AsString, 1, 2) = 'AG' then
    begin
      AConsulta.Next ;
      Continue ;
    end ;

    LCtpInc     := AConsulta.FieldByName('CTPINC').AsString;
    LFisInc     := AConsulta.FieldByName('FISINC').AsString;
    LCtpIncFis  := AConsulta.FieldByName('CTP_INCFIS').AsString;

    if not ADictCtpFisSet.TryGetValue(LCtpInc, LFisSet) then
    begin
      LFisSet := TSetFisInc.Create;
      ADictCtpFisSet.Add(LCtpInc, LFisSet);
    end;

    if not LFisSet.ContainsKey(LFisInc) then
      LFisSet.Add(LFisInc, 0);

    if (LCtpIncFis <> '') and (LFisInc = LCtpIncFis) then
      ADictFisIncRef.AddOrSetValue(LCtpInc, LFisInc);

    AConsulta.Next;
  end;
end;

procedure TRepositorioContabil.pProcessaDataSet(AqryConsulta: TUniQuery;
                                                AcdsPortadorFormaPagamento: TUniClientDataSet ;
                                                AcdsCtpMovBan: TUniClientDataSet ;
                                                AcdsOrigemCtp: TUniClientDataSet ;
                                                AcdsLogCtpAnt: TUniClientDataSet ;
                                                AcdsCtpBanmcaTax: TUniClientDataset;
                                                AcdsParconAvistaEnt: TUniClientDataset;
                                                AcdsCtpAnt: TUniClientDataset;
                                                AdictDifArrCtp: TDictValCtp;
                                                AdictFisInc: TDictFisInc);
var
  strEveNec: String ;
  blnParametrizouTaxaNoCartao: Boolean ;
  contasPagar: TContasPagar;
  LstrTipoPagamento: String ;
  itemPortadorFormaPagamento: TPortador ;
  fltAlqPisRF, fltAlqCofinsRF: Double;
  recValDifArrCtp: TValCtp;
  strChaveCtp: string;
  LDictCtpFisSet: TDictCtpFisSet ;
begin
  strEveNec := fRetornaEventosNaoExportar;
  blnParametrizouTaxaNoCartao := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_DESVAL'], ['CAR', DES_VALOR_CARTAO_TAXA]) > 0;
  strCTPInc := '';
  strTipoPagamento := '';
  AqryConsulta.First;
  fltAlqPisRF := fAlqPisRF;
  fltAlqCofinsRF := fAlqCofinsRF;
  AdictDifArrCtp.Clear;
  AdictFisInc.Clear;
  LDictCtpFisSet := TDictCtpFisSet.Create() ;

  AqryConsulta.First() ;
  pMontaReferenciaDuplicacaoCtpComCadFis(AqryConsulta, LDictCtpFisSet, AdictFisInc) ;

  AqryConsulta.First() ;
  while not AqryConsulta.Eof do
  begin
    if fDescartaCtpComCadFisDuplicado(AqryConsulta, LDictCtpFisSet, AdictFisInc) then
    begin
      AqryConsulta.Next;
      Continue;
    end ;

    if fDescartaCptComRegistroNoCtpAntAvulso(AqryConsulta, AcdsCtpAnt) then
    begin
      AqryConsulta.Next;
      Continue;
    end ;

    pAjustaLogCtpAntecipado(AqryConsulta, AcdsLogCtpAnt);

    if fDescartarPrevisaoPCP(FDadosAbertura.blnProvisao, AqryConsulta.FieldByName('CTP_PREVIS').AsString) then
    begin
      AqryConsulta.Next;
      Continue;
    end ;
    //Ignora o registro identificado como origem de credito, para não cair na trava "sem forma de pagamento"
    if AqryConsulta.FieldByName('ORIGEM_CREDITOS').AsInteger = 1 then
    begin
      AqryConsulta.Next;
      Continue;
    end ;

    if (not fEmptyStr(strEveNec)) and (not AqryConsulta.FieldByName('CTP_CODEVE').IsNull)
       and (Pos(AqryConsulta.FieldByName('CTP_CODEVE').AsString, strEveNec) > 0) then
    begin
      AqryConsulta.Next;
      Continue;
    end;

    if (Assigned(AcdsCtpMovBan)) and AcdsCtpMovBan.FindKey([AqryConsulta.FieldByName('FOR_CODFOR').AsString,
                                                            AqryConsulta.FieldByName('CTP_NUMDUP').AsString,
                                                            AqryConsulta.FieldByName('CTP_PARCEL').AsString,
                                                            AqryConsulta.FieldByName('CTP_CODEMP').AsString,
                                                            AqryConsulta.FieldByName('CTP_SEQBAI').AsInteger,
                                                            AqryConsulta.FieldByName('SERIE_').AsString
                                                           ]) then
    begin
      if (AcdsCtpMovBan.FieldByName('BAIXA_MULTIPLA').AsInteger = 1)
         and (AcdsCtpMovBan.FieldByName('TEM_ESTORNO').AsInteger = 1)
         and (AcdsCtpMovBan.FieldByName('CTP_PAGANT').AsString <> 'S') then
      begin
        AqryConsulta.Next;
        Continue;
      end ;
    end;

    if (blnParametrizouTaxaNoCartao) and
       (AqryConsulta.FieldByName('SERIE_').AsString = 'CRT') and
       (fPagamentoEhTaxa(AcdsCtpBanmcaTax, AqryConsulta)) then
    begin
      AqryConsulta.Next;
      Continue;
    end;

    if (AqryConsulta.FieldByName('TIPO_PAGAMENTO').AsString = 'Pagamentos Fatura') and
       (fStatusCndPag(AqryConsulta.FieldByName('CONDICAO_PAGTO').AsString) = A_VISTA) and
       (fParametrizouTipoAVista(AcdsParconAvistaEnt, AqryConsulta.FieldByName('CTP_DTAPAG').AsDateTime, AqryConsulta.FieldByName('CLASSIFICACAO_FISCAL').AsString)) and
       (fCfgCtrpvi = 'N') then
    begin
      AqryConsulta.Next;
      Continue;
    end;

    fltValPag   := AqryConsulta.FieldByName('CTP_PGTVAL').AsFloat;
    fltDinhei   := AqryConsulta.FieldByName('CTP_PGTDIN').AsFloat;
    fltChqPre   := AqryConsulta.FieldByName('CTP_PGTCHP').AsFloat;
    fltChqAvi   := AqryConsulta.FieldByName('CTP_PGTCHA').AsFloat;
    fltCartao   := AqryConsulta.FieldByName('CTP_PGTCAR').AsFloat;
    fltOrdPag   := AqryConsulta.FieldByName('CTP_PGTORP').AsFloat;
    fltValOri   := AqryConsulta.FieldByName('CTP_PGTORI').AsFloat;
    fltJuros    := AqryConsulta.FieldByName('CTP_PGTJUR').AsFloat;
    fltMulta    := AqryConsulta.FieldByName('CTP_PGTMUL').AsFloat;
    fltVendor   := AqryConsulta.FieldByName('CTP_PGTVENDOR').AsFloat;
    fltDesconto := AqryConsulta.FieldByName('CTP_PGTDES').AsFloat;

    if fAjustarArredondamento(AqryConsulta) then
    begin
      if (AqryConsulta.FieldByName('CTPINC').AsString <> strCTPInc) or
         fUsaCondicaoTipoPagamentoNoArredamento(AqryConsulta) then
      begin
        strCTPInc := AqryConsulta.FieldByName('CTPINC').AsString;
        strTipoPagamento := AqryConsulta.FieldByName('TIPO_PAGAMENTO').AsString;
        pZerarValores;
      end;
      pSomarValores(AqryConsulta);

      AqryConsulta.Next;
      if (AqryConsulta.FieldByName('CTPINC').AsString <> strCTPInc) or
         fUsaCondicaoTipoPagamentoNoArredamento(AqryConsulta) or
         (AqryConsulta.Eof) then
      begin
        if not AqryConsulta.Eof then
          AqryConsulta.Prior;

        fltDifOri := fltValOri - fltRatOri;
        fltDifJur := fltJuros - fltRatJur;
        fltDifMul := fltMulta - fltRatMul;
        fltDifVendor := fltVendor - fltRatVendor;
        fltDifDes := fltDesconto - fltRatDes;

        fltDifPag := fltValPag - fltRatPag;
        fltDifDin := fltDinhei - fltRatDin;
        fltDifChP := fltChqPre - fltRatChP;
        fltDifChA := fltChqAvi - fltRatChA;
        fltDifCar := fltCartao - fltRatCar;
        fltDifOrP := fltOrdPag - fltRatOrP;

        if (fltDifJur <> 0) or (fltDifMul <> 0) or (fltDifDes <> 0) or (fltDifDin <> 0) or (fltDifChP <> 0)
           or (fltDifChA <> 0) or (fltDifCar <> 0) or (fltDifOrP <> 0) or (fltDifPag <> 0) or (fltDifVendor <> 0)
           or ((fltDifOri <> 0) and (not FDadosAbertura.blnProvisao)) then
        begin
          strChaveCtp := strCTPInc + strTipoPagamento;

          recValDifArrCtp.fltJuros    := fltDifJur;
          recValDifArrCtp.fltMulta    := fltDifMul;
          recValDifArrCtp.fltDesconto := fltDifDes;
          recValDifArrCtp.fltDinhei   := fltDifDin;
          recValDifArrCtp.fltChqPre   := fltDifChP;
          recValDifArrCtp.fltChqAvi   := fltDifChA;
          recValDifArrCtp.fltCartao   := fltDifCar;
          recValDifArrCtp.fltOrdPag   := fltDifOrP;
          recValDifArrCtp.fltValPag   := fltDifPag;
          recValDifArrCtp.fltVendor   := fltDifVendor;
          if (not FDadosAbertura.blnProvisao) then
            recValDifArrCtp.fltValOri   := fltDifOri
          else
            recValDifArrCtp.fltValOri   := 0;
          AdictDifArrCtp.AddOrSetValue(strChaveCtp, recValDifArrCtp);
        end;
      end
      else
      begin
        AqryConsulta.Prior;
      end;
    end;

    contasPagar := TContasPagar.Create;

    //dados duplicata
    contasPagar.strTipCtp := AqryConsulta.FieldByName('CTP_TIPCTP').AsString;
    contasPagar.strHistoricoBaixa := AqryConsulta.FieldByName('CTP_HISBAI').AsString;
    contasPagar.strHist01 := AqryConsulta.FieldByName('HIST01').AsString;
    contasPagar.strAutoincrem := AqryConsulta.FieldByName('CTPINC').AsString;
    contasPagar.strParcela := AqryConsulta.FieldByName('CTP_PARCEL').AsString;
    contasPagar.strNumero := AqryConsulta.FieldByName('CTP_NUMDUP').AsString;
    contasPagar.strNumeroAdt := AqryConsulta.FieldByName('CTP_NUMADT').AsString;
    contasPagar.LancamentoDuploEmpDif := fEfetuarLancamentoDuploEmpresasDiferentesCTP(AqryConsulta.FieldByName('EMPCAD').AsString, AqryConsulta.FieldByName('CTP_EMPBAI').AsString, IfThen(FDadosAbertura.blnProvisao, 'PCP', 'CTP'), FblnContabilizarPelaEmpBai ) ;
    if contasPagar.LancamentoDuploEmpDif then
    begin
      contasPagar.empresaCadastro.strCodigo := AqryConsulta.FieldByName('CTP_EMPBAI').AsString;
      contasPagar.empresaCadastro.strDescricao := AqryConsulta.FieldByName('BAI_NOMEMP').AsString;
      contasPagar.empresaCadastro.strC_G_C := AqryConsulta.FieldByName('BAI_C_G_C_').AsString;
      contasPagar.empresaBaixa.strCodigo := AqryConsulta.FieldByName('EMPCAD').AsString;
      contasPagar.empresaBaixa.strDescricao := AqryConsulta.FieldByName('CAD_NOMEMP').AsString;
      contasPagar.empresaBaixa.strC_G_C := AqryConsulta.FieldByName('CAD_C_G_C_').AsString;
    end
    else
    begin
      contasPagar.empresaBaixa.strCodigo := AqryConsulta.FieldByName('CTP_CODEMP').AsString;
      contasPagar.empresaBaixa.strDescricao := AqryConsulta.FieldByName('EMP_NOMEMP').AsString;
      contasPagar.empresaBaixa.strC_G_C := AqryConsulta.FieldByName('EMP_C_G_C_').AsString;
    end ;
    contasPagar.empresaCtpDet.strCodigo := AqryConsulta.FieldByName('CDE_CODEMP').AsString;
    contasPagar.empresaCtpDet.strDescricao := AqryConsulta.FieldByName('CDE_NOMEMP').AsString;
    contasPagar.empresaCtpDet.strC_G_C := AqryConsulta.FieldByName('CDE_C_G_C_').AsString;
    contasPagar.fltValorPago := AqryConsulta.FieldByName('CTP_VALPAG').AsFloat;
    contasPagar.fltValorOriginal := AqryConsulta.FieldByName('CTP_VALORI').AsFloat;
    contasPagar.fltValorDinheiro := AqryConsulta.FieldByName('CTP_DINHEI').AsFloat;
    contasPagar.fltValorChequePre := AqryConsulta.FieldByName('CTP_CHQPRE').AsFloat;
    contasPagar.fltValorChequeVista := AqryConsulta.FieldByName('CTP_CHQAVI').AsFloat;
    contasPagar.fltValorCartao := AqryConsulta.FieldByName('CTP_CARTAO').AsFloat;
    contasPagar.fltValorOrdemPagamento := AqryConsulta.FieldByName('CTP_ORDPAG').AsFloat;
    contasPagar.fltValorJuros := AqryConsulta.FieldByName('CTP_VALJUR').AsFloat;
    contasPagar.fltValorMulta := AqryConsulta.FieldByName('CTP_VALMUL').AsFloat;
    contasPagar.fltValorVendor := AqryConsulta.FieldByName('CTP_VENDOR').AsFloat;
    contasPagar.fltValorDesconto := AqryConsulta.FieldByName('CTP_VALDES').AsFloat;
    contasPagar.fltValorPisRF := fFormataFloat(abs(AqryConsulta.FieldByName('CTP_VPISRF').AsFloat) * fltAlqPisRF, 2);
    contasPagar.fltValorCofinsRF := fFormataFloat(abs(AqryConsulta.FieldByName('CTP_VCOFRF').AsFloat) * fltAlqCofinsRF, 2);
    contasPagar.dtaDataPagamento := AqryConsulta.FieldByName('CTP_DTAPAG').AsDateTime;
    contasPagar.dtaDataCadastro := AqryConsulta.FieldByName('CTP_DTACAD').AsDateTime;
    contasPagar.dtaDataEntradaFiscal := AqryConsulta.FieldByName('FIS_DTAENT').AsDateTime;
    LstrTipoPagamento := fRetPagamentoPCP(AcdsOrigemCtp, AqryConsulta) ;
    contasPagar.strTipoPagamento := ifThen(fEmptyStr(LstrTipoPagamento), AqryConsulta.FieldByName('TIPO_PAGAMENTO').AsString, LstrTipoPagamento) ;
    contasPagar.strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(AqryConsulta.FieldByName('CTP_CODEVE').AsString).fConsultaEvento(FstrCentroCustoDefault);
    contasPagar.strCompetencia := AqryConsulta.FieldByName('CTP_COMPET').AsString;
    contasPagar.strCodCtaResultado := AqryConsulta.FieldByName('CTA_PLARES').AsString;
    contasPagar.blnPagamentoAntecipado := AqryConsulta.FieldByName('CTP_PAGANT').AsString = 'S';
    contasPagar.strDocumentoOriginal := AqryConsulta.FieldByName('DOCORI').AsString;
    contasPagar.strEspecieOriginal := AqryConsulta.FieldByName('ESPORI').AsString;

    //dados participante
    contasPagar.participante.strContaContabil := AqryConsulta.FieldByName('CONTA_FORNECEDOR').AsString;
    contasPagar.participante.strCodigo := AqryConsulta.FieldByName('FOR_CODFOR').AsString;
    contasPagar.participante.strNome := AqryConsulta.FieldByName('FOR_NOMFOR').AsString;
    contasPagar.participante.strCgcCpf := AqryConsulta.FieldByName('FOR_C_G_C_').AsString;

    //dados plano de contas
    if FDadosAbertura.blnProvisao then
    begin
      contasPagar.planoContasCadastro.strCodigo := AqryConsulta.FieldByName('CODIGO_PLANO_CONTAS_CADASTRO').AsString;
      contasPagar.planoContasCadastro.strContaContabil := AqryConsulta.FieldByName('PLANO_CONTAS_CADASTRO').AsString;

      contasPagar.planoContasBaixa.strCodigo := AqryConsulta.FieldByName('CODIGO_PLANO_CONTAS_BAIXA').AsString;
      contasPagar.planoContasBaixa.strContaContabil := AqryConsulta.FieldByName('PLANO_CONTAS_BAIXA').AsString;
    end
    else
    begin
      contasPagar.planoContasCadastro.strCodigo := AqryConsulta.FieldByName('CODIGO_PLANO_CONTAS_CADASTRO').AsString;
      contasPagar.planoContasCadastro.strContaContabil := AqryConsulta.FieldByName('PLANO_CONTAS_CADASTRO').AsString;

      contasPagar.planoContasBaixa.strCodigo := AqryConsulta.FieldByName('CODIGO_PLANO_CONTAS_BAIXA').AsString;
      contasPagar.planoContasBaixa.strContaContabil := AqryConsulta.FieldByName('PLANO_CONTAS_BAIXA').AsString;
    end;

    //dados portador
    if FDadosAbertura.blnProvisao then
    begin
      contasPagar.portador.strCodigo := AqryConsulta.FieldByName('CODIGO_PORTADOR_CADASTRO').AsString;
      contasPagar.portador.strContaContabil := AqryConsulta.FieldByName('CONTA_CADASTRO').AsString;
      contasPagar.portador.blnExportarPeloAutsi := (AqryConsulta.FieldByName('CAD_EXPAUT').AsString = 'S');
    end
    else
    begin
      contasPagar.portador.strCodigo := AqryConsulta.FieldByName('CODIGO_PORTADOR_BAIXA').AsString;
      contasPagar.portador.strContaContabil := AqryConsulta.FieldByName('CONTA_PORBAI').AsString;
      contasPagar.portador.blnExportarPeloAutsi := (IIF(not fEmptyStr(AqryConsulta.FieldByName('BAI_EXPAUT').AsString), AqryConsulta.FieldByName('BAI_EXPAUT').AsString, AqryConsulta.FieldByName('CAD_EXPAUT').AsString) = 'S');
      ///pesquisa os portadores da forma de pagamento.
      if AcdsPortadorFormaPagamento.FindKey([contasPagar.strAutoincrem]) then
      begin
        while (AcdsPortadorFormaPagamento.FieldByName('CTP_AUTOINC').AsString = contasPagar.strAutoincrem) and (not AcdsPortadorFormaPagamento.Eof) do
        begin
          if (AcdsPortadorFormaPagamento.FieldByName('CTP_DINHEI').AsFloat <> 0.00) and (not contasPagar.portador.PortadorFormaPagamento.ContainsKey(pfpDinheiro)) then
          begin
            itemPortadorFormaPagamento := TPortador.Create ;
            itemPortadorFormaPagamento.strCodigo := AcdsPortadorFormaPagamento.FieldByName('CODIGO_PORTADOR_BAIXA').AsString;
            itemPortadorFormaPagamento.strContaContabil := AcdsPortadorFormaPagamento.FieldByName('CONTA_PORBAI').AsString;
            contasPagar.portador.PortadorFormaPagamento.Add(pfpDinheiro, itemPortadorFormaPagamento);
          end;
          if (AcdsPortadorFormaPagamento.FieldByName('CTP_CHQEMI').AsFloat <> 0.00) and (not contasPagar.portador.PortadorFormaPagamento.ContainsKey(pfpChequeAVista)) then
          begin
            itemPortadorFormaPagamento := TPortador.Create ;
            itemPortadorFormaPagamento.strCodigo := AcdsPortadorFormaPagamento.FieldByName('CODIGO_PORTADOR_BAIXA').AsString;
            itemPortadorFormaPagamento.strContaContabil := AcdsPortadorFormaPagamento.FieldByName('CONTA_PORBAI').AsString;
            contasPagar.portador.PortadorFormaPagamento.Add(pfpChequeAVista, itemPortadorFormaPagamento);
          end;
          if (AcdsPortadorFormaPagamento.FieldByName('CTP_ORDPAG').AsFloat <> 0.00) and (not contasPagar.portador.PortadorFormaPagamento.ContainsKey(pfpOrdemPagamento)) then
          begin
            itemPortadorFormaPagamento := TPortador.Create ;
            itemPortadorFormaPagamento.strCodigo := AcdsPortadorFormaPagamento.FieldByName('CODIGO_PORTADOR_BAIXA').AsString;
            itemPortadorFormaPagamento.strContaContabil := AcdsPortadorFormaPagamento.FieldByName('CONTA_PORBAI').AsString;
            contasPagar.portador.PortadorFormaPagamento.Add(pfpOrdemPagamento, itemPortadorFormaPagamento);
          end;
          if (AcdsPortadorFormaPagamento.FieldByName('CTP_CHQREP').AsFloat <> 0.00) and (not contasPagar.portador.PortadorFormaPagamento.ContainsKey(pfpChequePre)) then
          begin
            itemPortadorFormaPagamento := TPortador.Create ;
            itemPortadorFormaPagamento.strCodigo := AcdsPortadorFormaPagamento.FieldByName('CODIGO_PORTADOR_BAIXA').AsString;
            itemPortadorFormaPagamento.strContaContabil := AcdsPortadorFormaPagamento.FieldByName('CONTA_PORBAI').AsString;
            contasPagar.portador.PortadorFormaPagamento.Add(pfpChequePre, itemPortadorFormaPagamento);
          end;
          AcdsPortadorFormaPagamento.Next ;
        end;
      end;
    end;

    contasPagar.strNumChq := AqryConsulta.FieldByName('EMI_NUMCHQ').asString;
    contasPagar.IsCtpDet := AqryConsulta.FieldByName('IS_CTPDET').asString = '1' ;
    contasPagar.strSerie := AqryConsulta.FieldByName('SERIE_').asString;

    pAjustaJurosCtpDet(contasPagar) ;
    pAjustaDescontosCtpDet(contasPagar) ;

    FListaPagamentos.Add(contasPagar);

    AqryConsulta.Next;
  end;
  pLiberaDictCtpFisSet(LDictCtpFisSet) ;
  pAjustarArredondamentoCtp(FDadosAbertura, FListaPagamentos, AdictDifArrCtp);
end;

procedure TRepositorioContabil.pSomarValores(qryDados: TUniQuery);
begin
  fltRatOri := fltRatOri + qryDados.FieldByName('CTP_VALORI').AsFloat;
  fltRatJur := fltRatJur + qryDados.FieldByName('CTP_VALJUR').AsFloat;
  fltRatMul := fltRatMul + qryDados.FieldByName('CTP_VALMUL').AsFloat;
  fltRatVendor := fltRatVendor + qryDados.FieldByName('CTP_VENDOR').AsFloat;
  fltRatDes := fltRatDes + qryDados.FieldByName('CTP_VALDES').AsFloat;
  fltRatPag := fltRatPag + qryDados.FieldByName('CTP_VALPAG').AsFloat;
  fltRatDin := fltRatDin + qryDados.FieldByName('CTP_DINHEI').AsFloat;
  fltRatChP := fltRatChP + qryDados.FieldByName('CTP_CHQPRE').AsFloat;
  fltRatChA := fltRatChA + qryDados.FieldByName('CTP_CHQAVI').AsFloat;
  fltRatCar := fltRatCar + qryDados.FieldByName('CTP_CARTAO').AsFloat;
  fltRatOrP := fltRatOrP + qryDados.FieldByName('CTP_ORDPAG').AsFloat;
end;

procedure TRepositorioContabil.pZerarValores;
begin
  fltRatPag := 0;
  fltDifPag := 0;
  fltRatDin := 0;
  fltDifDin := 0;
  fltRatChP := 0;
  fltDifChP := 0;
  fltRatChA := 0;
  fltDifChA := 0;
  fltRatCar := 0;
  fltDifCar := 0;
  fltRatOrP := 0;
  fltDifOrP := 0;
  fltRatOri := 0;
  fltDifOri := 0;
  fltRatJur := 0;
  fltDifJur := 0;
  fltRatMul := 0;
  fltRatVendor := 0;
  fltDifMul := 0;
  fltDifVendor := 0;
  fltRatDes := 0;
  fltDifDes := 0;
end;

// Ao alterar a clausula Where deste metodo, deve ser alterado tambem o do metodo fRetSqlCtpLancadosPeriodoFechadoDtaCad porque ambos devem ser identicos
function TRepositorioContabil.fRetSqlTodosCadPagPorPeriodoDtaCad: string;
  var
    strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  P.CTP_CODFOR, ';
  strSQL := strSQL + '  P.CTP_SEQCON, ';
  strSQL := strSQL + '  P.CTP_EMPBAI, ';
  strSQL := strSQL + '  P.CTP_CODEMP, ';
  strSQL := strSQL + '  P.CTP_CODEMP AS EMPCAD, ';
  strSQL := strSQL + '  P.CTP_NUMDUP, ';
  strSQL := strSQL + '  P.CTP_PARCEL, ';
  strSQL := strSQL + '  P.CTP_COMPET, ';
  strSQL := strSQL + '  P.CTP_DTAPAG, ';
  strSQL := strSQL + '  P.CTP_DTACAD, ';
  strSQL := strSQL + '  P.CTP_PAGANT, ';

  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_VALPAG, ROUND(P.CTP_VALPAG*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VALPAG, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_DINHEI, ROUND(P.CTP_DINHEI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_DINHEI, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CHQPRE, ROUND(P.CTP_CHQPRE*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_CHQPRE, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CHQAVI, ROUND(P.CTP_CHQAVI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_CHQAVI, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_CARTAO, ROUND(P.CTP_CARTAO*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_CARTAO, ';
  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_ORDPAG, ROUND(P.CTP_ORDPAG*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_ORDPAG, ';

  strSQL := strSQL + '  ROUND(IF(D.CTP_FATCAL IS NULL, P.CTP_VALORI, ROUND(P.CTP_VALORI*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VALORI, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, P.CTP_VALJUR, ROUND(P.CTP_VALJUR*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VALJUR, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, ' + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + ', ROUND(' + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + '*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VALMUL, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, ' + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + ', ROUND(' + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + '*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VENDOR, ';
  strSQL := strSQL + '  TRUNCATE(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDES, ROUND(P.CTP_VALDES*D.CTP_FATCAL,2)) * ' + fFatorDupAgp + ', 2) AS CTP_VALDES, ';
  strSQL := strSQL + '  IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CTP_CODEVE, ';

  strSQL := strSQL + '  P.CTP_VALPAG AS CTP_PGTVAL, ';
  strSQL := strSQL + '  P.CTP_DINHEI AS CTP_PGTDIN, ';
  strSQL := strSQL + '  P.CTP_CHQPRE AS CTP_PGTCHP, ';
  strSQL := strSQL + '  P.CTP_CHQAVI AS CTP_PGTCHA, ';
  strSQL := strSQL + '  P.CTP_CARTAO AS CTP_PGTCAR, ';
  strSQL := strSQL + '  P.CTP_ORDPAG AS CTP_PGTORP, ';
  strSQL := strSQL + '  P.CTP_VALORI AS CTP_PGTORI, ';
  strSQL := strSQL + '  P.CTP_VALJUR AS CTP_PGTJUR, ';
  strSQL := strSQL + ifthen(fTemCampoMultaCTP, 'P.CTP_VALMUL', 'CAST(0.00 AS DECIMAL(14,2))') + ' AS CTP_PGTMUL, ';
  strSQL := strSQL + ifthen(fCfgCtpVnd = 'S', 'P.CTP_VENDOR', 'CAST(0.00 AS DECIMAL(14,2))') + ' AS CTP_PGTVENDOR, ';
  strSQL := strSQL + '  P.CTP_VALDES AS CTP_PGTDES, ';
  strSQL := strSQL + '  P.CTP_VALDES AS CTP_VPISRF, P.CTP_VALDES AS CTP_VCOFRF, ';
  strSQL := strSQL + '  P.CTP_SERIE_ AS SERIE_, ';

  strSQL := strSQL + '  FOR_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  FOR_C_G_C_, ';
  strSQL := strSQL + '	IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS CONTA_FORNECEDOR, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCON, CTACAD.CTA_PLANCO) AS PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCTA, CTACAD.CTA_CODCTA) AS CODIGO_PLANO_CONTAS_CADASTRO, ';
  strSQL := strSQL + '  IFNULL(CTANCO_BAI.NCO_CODCON, CTABAI.CTA_PLANCO) AS PLANO_CONTAS_BAIXA, ';
  strSQL := strSQL + '  IFNULL(CTANCO_BAI.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTAS_BAIXA, ';

  strSQL := strSQL + '  IFNULL(PORNCO.NCO_CODCON, PORCAD.POR_PLANCO) AS CONTA_CADASTRO, ';
  strSQL := strSQL + '  IFNULL(PORNCO.NCO_CODPOR, PORCAD.POR_CODPOR) AS CODIGO_PORTADOR_CADASTRO, ';

  strSQL := strSQL + '  IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") AS TIPO_PAGAMENTO, ';

  if FDadosAbertura.blnCTA_PLARES then
    strSQL := strSQL + '  IFNULL(CTABAI.CTA_PLARES, CTACAD.CTA_PLARES) AS CTA_PLARES, '
  else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CTA_PLARES, ';

  strSQL := strSQL + '  CADEMP.EMP_NOMEMP, ';

  //Buscar Cheque Emitido
  strSQL := strSQL + '  ( SELECT GROUP_CONCAT(CHQEMI.EMI_NUMCHQ) ';
  strSQL := strSQL + '      FROM CHQEMI ';
  strSQL := strSQL + '     WHERE CHQEMI.EMI_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '       AND CHQEMI.EMI_NUMDUP = P.CTP_NUMDUP ';
  strSQL := strSQL + '       AND CHQEMI.EMI_PARCEL = P.CTP_PARCEL ';
  strSQL := strSQL + '       AND CHQEMI.EMI_CODEMP = P.CTP_CODEMP ) AS EMI_NUMCHQ, ';
  strSQL := strSQL + '  P.AUTOINCREM AS CTPINC, ';
  strSQL := strSQL + '  P.CTP_HISBAI, ';

  strSQL := strSQL + ' IFNULL(AGR.CTP_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' "" AS ESPORI, P.CTP_HIST01 AS HIST01, ';
  strSQL := strSQL + ' PORCAD.POR_EXPAUT AS CAD_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CONPAG, NOTGER.GER_CONPAG) AS CONDICAO_PAGTO, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CLAFIS, NOTGER.GER_CLAFIS) AS CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + ' CADFIS.FIS_DTAENT, ';
  strSQL := strSQL + ' CADFIS.AUTOINCREM AS FISINC, ';
  strSQL := strSQL + ' CAST( NULL AS CHAR(12)) AS CTP_NUMADT, ';
  strSQL := strSQL + fColunaTipCtp('P') + ', ';
  strSQL := strSQL + '  FALSE AS IS_CTPDET, ';
  strSQL := strSQL + ' D.CTP_CODEMP AS CDE_CODEMP, ';
  strSQL := strSQL + ' ED.EMP_NOMEMP AS CDE_NOMEMP, ';
  strSQL := strSQL + ' ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  strSQL := strSQL + ' P.CTP_SEQBAI, ';
  strSQL := strSQL + ' 0 AS UTILIZACAO_CREDITOS, ';
  strSQL := strSQL + ' 0 AS ORIGEM_CREDITOS, ';
  strSQL := strSQL + ' P.CTP_PREVIS, ';
  strSQL := strSQL + ' CAST("" AS CHAR(1)) AS BAI_NOMEMP , ';
  strSQL := strSQL + ' CAST("" AS CHAR(1)) AS BAI_C_G_C_, ';
  strSQL := strSQL + ' CAST("" AS CHAR(1)) AS EMP_C_G_C_, ';
  strSql := strsql + ' '+ fSqlRetornaColunaCtpIncFis + ', ' ;
  strSQL := strSQL + ' CAST("0" AS CHAR(1)) AS CTA_PROCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG P ';
  strSQL := strSQL + '  JOIN CADEMP ON P.CTP_CODEMP = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  strSQL := strSQL + '                        P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  strSQL := strSQL + '                      ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  strSQL := strSQL + '                     (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = P.CTP_CODFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORCAD ';
  strSQL := strSQL + '    ON PORCAD.POR_CODPOR = P.CTP_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN CADCTA CTACAD ON CTACAD.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ';
  strSQL := strSQL + '  LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CTABAI, D.CTP_CODCTA) ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORCAD.POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = P.CTP_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = P.CTP_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO_CAD ON CTANCO_CAD.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ';
  strSQL := strSQL + '                              AND CTANCO_CAD.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'P.CTP_CODEMP') ;

  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO_BAI ON CTANCO_BAI.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CTABAI, D.CTP_CODCTA) ';
  strSQL := strSQL + '                              AND CTANCO_BAI.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'P.CTP_CODEMP') ;

  strSQL := strSQL + '  LEFT JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = P.CTP_NUMDUP ';
  strSQL := strSQL + '                      AND AGR.CTP_EMPAGR = P.CTP_CODEMP ';
  strSQL := strSQL + '                      AND AGR.CTP_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '                      AND AGR.CTP_PARCEL = P.CTP_PARCEL ';

  strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG", AGR.CTP_NUMDUP, P.CTP_NUMDUP) ';
  strSQL := strSQL + '                  AND FIS_CODEMP = IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG", AGR.CTP_CODEMP, P.CTP_CODEMP) ';
  strSQL := strSQL + '                  AND FIS_FORCLI = IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG", AGR.CTP_CODFOR, P.CTP_CODFOR) ';
  strSQL := strSQL + '                  AND FIS_TIP_FC = "F" ';
  strSQL := strSQL + '                  AND IFNULL(FIS_SERIE_,"") = IF(SUBSTRING(P.CTP_NUMDUP, 1, 2) = "AG", IFNULL(AGR.CTP_SERIE_,""), IFNULL(P.CTP_SERIE_,"")) ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                  AND MOVGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND MOVGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                  AND NOTGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND NOTGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + '  WHERE CTACAD.CTA_PROCON = 1 ';


  strSQL := strSQL  +  TTrataIncDocContabil
                         .New
                         .fColunaIncDoc('P.AUTOINCREM')
                         .fIncDoc(FDadosAbertura.strIncrementoCadPag)
                         .fArrIncDoc(FDadosAbertura.arrIncDoc)
                         .fQuerySql(Nil)
                         .fExecute ;

  if (FDadosAbertura.dtaDataInicial > 0) then
    strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  if (not fEmptyStr(FDadosAbertura.empresa.strCodigo)) then
    strSQL := strSQL + '  AND P.CTP_CODEMP = :CODEMP ';

  if (not FDadosAbertura.blnExportaUsoConsumo) then
    strSQL := strSQL + '  AND P.CTP_USOCON = "N" ';

  strSQL := strSQL + ' HAVING TIPO_PAGAMENTO = "Pagamentos Avulsos" ';

  strSQL := strSQL + ' ORDER BY P.AUTOINCREM, FIS_DTAENT DESC ';

  Result := strSQL;
end;

function TRepositorioContabil.fCarregaPortadorFormaPagamento(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  qryConsulta : TUniQuery ;
  LqryBanCtp: TUniQuery ;
  LcdsBanCtp: TUniClientDataSet ;
  LlstSeqLan: TStringList ;
  LarrCodigos: TJSONArray ;
  LstrCodigos: String ;
  LlstControle: TStringList ;
begin
  qryConsulta := fCriaQuery ;
  LqryBanCtp := fCriaQuery ;
  LlstSeqLan := TStringList.Create() ;
  LarrCodigos := TJSONArray.Create ;
  try
    LlstSeqLan.Sorted := True ;
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(' SELECT ') ;
    qryConsulta.SQL.Add('   P.AUTOINCREM AS CTP_AUTOINC, ') ;
    qryConsulta.SQL.Add('   MOVBAN.CTB_PAGCON, ') ;
    qryConsulta.SQL.Add('   MOVBAN.CTB_CODEMP, ') ;
    qryConsulta.SQL.Add('   MOVBAN.CTB_SEQLAN, ') ;
    qryConsulta.SQL.Add('   IFNULL(PORNCO.NCO_CODCON, PORBAI.POR_PLANCO) AS CONTA_PORBAI, ') ;
    qryConsulta.SQL.Add('   IFNULL(PORNCO.NCO_CODPOR, PORBAI.POR_CODPOR) AS CODIGO_PORTADOR_BAIXA, ') ;
    qryConsulta.SQL.Add('   MOVBAN.CTB_VALLAN, ') ;
    qryConsulta.SQL.Add('   CAST(0.00 AS DECIMAL(12,2)) AS CTP_DINHEI, ') ;
    qryConsulta.SQL.Add('   CAST(0.00 AS DECIMAL(12,2)) AS CTP_CHQEMI, ') ;
    qryConsulta.SQL.Add('   CAST(0.00 AS DECIMAL(12,2)) AS CTP_CHQREP, ') ;
    qryConsulta.SQL.Add('   CAST(0.00 AS DECIMAL(12,2)) AS CTP_ORDPAG, ') ;
    qryConsulta.SQL.Add('   CAST(0 as UNSIGNED) AS CONTROLE ') ;
    qryConsulta.SQL.Add(' FROM MOVBAN ') ;
    qryConsulta.SQL.Add('   INNER JOIN BANCTP ') ;
    qryConsulta.SQL.Add('     ON  MOVBAN.CTB_SEQLAN = BANCTP.CTB_SEQLAN ') ;
    qryConsulta.SQL.Add('     AND MOVBAN.CTB_CODEMP = BANCTP.CTP_CODEMP ') ;
    qryConsulta.SQL.Add('     AND MOVBAN.CTB_ORIGEM = "CTP" ') ;
    qryConsulta.SQL.Add('   INNER JOIN CADPAG P ') ;
    qryConsulta.SQL.Add('     ON  P.CTP_SEQCON = MOVBAN.CTB_PAGCON ') ;
    qryConsulta.SQL.Add('     AND P.CTP_EMPBAI = MOVBAN.CTB_CODEMP ') ;
    qryConsulta.SQL.Add('     AND CASE WHEN COALESCE(P.CTP_SERIE_, "") = "CRT" THEN COALESCE(P.CTP_DOCBAI, "") = COALESCE(MOVBAN.CTB_SEQLAN, "") ELSE TRUE END ') ;
    qryConsulta.SQL.Add('     AND P.CTP_CODFOR = BANCTP.CTP_CODFOR ') ;    
    qryConsulta.SQL.Add('     AND P.CTP_PARCEL = BANCTP.CTP_PARCEL ') ;
    qryConsulta.SQL.Add('     AND P.CTP_SEQBAI = BANCTP.CTP_SEQBAI ') ;
    qryConsulta.SQL.Add('     AND P.CTP_CODEMP = BANCTP.CTP_CODEMP ') ;
    qryConsulta.SQL.Add('     AND P.CTP_NUMDUP = BANCTP.CTP_NUMDUP ') ;
    qryConsulta.SQL.Add('     AND P.CTP_SERIE_ = BANCTP.CTP_SERIE_ ') ;
    qryConsulta.SQL.Add('   LEFT JOIN CADPOR PORBAI ') ;
    qryConsulta.SQL.Add('     ON  PORBAI.POR_CODPOR = MOVBAN.CTB_CODPOR ') ;
    qryConsulta.SQL.Add('   LEFT JOIN PORNCO ') ;
    qryConsulta.SQL.Add('     ON  PORNCO.NCO_CODPOR = PORBAI.POR_CODPOR ') ;
    qryConsulta.SQL.Add('     AND PORNCO.NCO_CODEMP = MOVBAN.CTB_CODEMP ') ;
    qryConsulta.SQL.Add(' WHERE TRUE ') ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('P.AUTOINCREM')
      .fIncDoc(ADadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(ADadosAbertura.arrIncDoc)
      .fQuerySql(qryConsulta)
      .fExecute ;

    if (ADadosAbertura.dtaDataInicial > 0) then
    begin
      qryConsulta.SQL.Add('   AND P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ') ;
      qryConsulta.ParamByName('DTAINI').AsDateTime := ADadosAbertura.dtaDataInicial;
      qryConsulta.ParamByName('DTAFIN').AsDateTime := ADadosAbertura.dtaDataFinal;
    end;

    if (not fEmptyStr(ADadosAbertura.empresa.strCodigo)) then
    begin
      qryConsulta.SQL.Add('   AND ' + fEmpresaGeracaoCtp('P.', FblnContabilizarPelaEmpBai) + ' = :CODEMP ') ;
      qryConsulta.ParamByName('CODEMP').AsString := ADadosAbertura.empresa.strCodigo;
    end;

    if (not ADadosAbertura.blnExportaUsoConsumo) then
    begin
      qryConsulta.SQL.Add('   AND P.CTP_USOCON = "N" ') ;
    end;
    qryConsulta.SQL.Add(' ORDER BY P.AUTOINCREM, MOVBAN.CTB_SEQLAN ') ;
    qryConsulta.Open ;

    /// separa as seqlans
    qryConsulta.DisableControls ;
    try
      qryConsulta.First ;
      while not qryConsulta.Eof do
      begin
        if LlstSeqLan.IndexOf(qryConsulta.FieldByName('CTB_SEQLAN').AsString) = -1 then
        begin
          LlstSeqLan.Add(qryConsulta.FieldByName('CTB_SEQLAN').AsString) ;
          LarrCodigos.AddElement(TJSONString.Create(qryConsulta.FieldByName('CTB_SEQLAN').AsString));
        end ;
        qryConsulta.Next ;
      end ;
      qryConsulta.First ;
    finally
      qryConsulta.EnableControls ;
    end ;

    Result := fCriaClientDatset(qryConsulta) ;
    Result.IndexFieldNames := 'CTP_AUTOINC;CTB_SEQLAN' ;

    LstrCodigos := trim(ReplaceStr(ReplaceStr(LarrCodigos.ToString, '[', ''), ']', '')) ;
    if not fEmptyStr(LstrCodigos) then
    begin
      LqryBanCtp.Close ;
      LqryBanCtp.SQL.Clear ;
      LqryBanCtp.SQL.Add(' SELECT DISTINCT CTB_SEQLAN, CTP_DINHEI, CTP_CHQEMI, CTP_CHQREP, CTP_ORDPAG ') ;
      LqryBanCtp.SQL.Add(' FROM BANCTP ') ;
      LqryBanCtp.SQL.Add(' WHERE CTB_SEQLAN IN (' + LstrCodigos + ') ') ;
      LqryBanCtp.Open ;
      LcdsBanCtp := fCriaClientDatset(LqryBanCtp) ;
      LcdsBanCtp.IndexFieldNames := 'CTB_SEQLAN' ;

      Result.DisableControls ;
      LlstControle := TStringList.Create ;
      try
        LlstControle.Sorted := True ;
        Result.First ;
        while not Result.Eof do
        begin
          if LcdsBanCtp.FindKey([Result.FieldByName('CTB_SEQLAN').AsString]) then
          begin
            Result.Edit ;
            while (Result.FieldByName('CTB_SEQLAN').AsString = LcdsBanCtp.FieldByName('CTB_SEQLAN').AsString)
                  and (not LcdsBanCtp.Eof) do
            begin
              if (Result.FieldByName('CTB_VALLAN').AsFloat = LcdsBanCtp.FieldByName('CTP_DINHEI').AsFloat) and (LlstControle.IndexOf(Result.FieldByName('CTB_SEQLAN').AsString)=-1) then
              begin
                Result.FieldByName('CTP_DINHEI').AsFloat := LcdsBanCtp.FieldByName('CTP_DINHEI').AsFloat ;
                LlstControle.Add(Result.FieldByName('CTB_SEQLAN').AsString);
              end
              else if (Result.FieldByName('CTB_VALLAN').AsFloat = LcdsBanCtp.FieldByName('CTP_CHQEMI').AsFloat) and (LlstControle.IndexOf(Result.FieldByName('CTB_SEQLAN').AsString)=-1) then
              begin
                Result.FieldByName('CTP_CHQEMI').AsFloat := LcdsBanCtp.FieldByName('CTP_CHQEMI').AsFloat ;
                LlstControle.Add(Result.FieldByName('CTB_SEQLAN').AsString);
              end
              else if (Result.FieldByName('CTB_VALLAN').AsFloat = LcdsBanCtp.FieldByName('CTP_CHQREP').AsFloat) and (LlstControle.IndexOf(Result.FieldByName('CTB_SEQLAN').AsString)=-1) then
              begin
                Result.FieldByName('CTP_CHQREP').AsFloat := LcdsBanCtp.FieldByName('CTP_CHQREP').AsFloat ;
                LlstControle.Add(Result.FieldByName('CTB_SEQLAN').AsString);
              end
              else if (Result.FieldByName('CTB_VALLAN').AsFloat = LcdsBanCtp.FieldByName('CTP_ORDPAG').AsFloat) and (LlstControle.IndexOf(Result.FieldByName('CTB_SEQLAN').AsString)=-1) then
              begin
                Result.FieldByName('CTP_ORDPAG').AsFloat := LcdsBanCtp.FieldByName('CTP_ORDPAG').AsFloat ;
                LlstControle.Add(Result.FieldByName('CTB_SEQLAN').AsString);
              end ;
              LcdsBanCtp.Next ;
            end ;
            Result.Post ;
          end ;
          Result.Next ;
        end ;
        Result.First ;
      finally
        Result.EnableControls ;
        FreeAndNil(LcdsBanCtp) ;
        FreeAndNil(LlstControle);
      end ;

    end ;

  finally
    FreeAndNil(qryConsulta) ;
    FreeAndNil(LqryBanCtp) ;
    FreeAndNil(LlstSeqLan) ;
    FreeAndNil(LarrCodigos) ;
  end;
end;

function TRepositorioContabil.fAjustaColunaDataPagamento(
  const AConfAntecipado: TAjustaConsultaCadPagAntecipado): String;
begin
  Result := 'P.CTP_DTAPAG' ;
  if not (AConfAntecipado in [acaFaturaComAgr, acaFaturaSemAgr]) then
    Exit ;

  if fCfgCtpAdf = '1' then
    Exit ;

  Result := 'CADFIS.FIS_DTAENT' ;
end;

function TRepositorioContabil.fAjustarArredondamento(const AqryDados: TUniQuery): boolean;
begin
  Result := True ;

  if AqryDados.FieldByName('SERIE_').AsString = 'AG' then
    Exit ;

  if AqryDados.FieldByName('IS_CTPDET').AsInteger = 1 then
    Exit ;

  Result := False ;
end;

function TRepositorioContabil.fAjustaTipoPagamentoSql(
  const AConfAntecipado: TAjustaConsultaCadPagAntecipado;
  const ACondicaoBase: string): string;
begin
  Result := ACondicaoBase;

  if AConfAntecipado = acaAvulso then
    Result := '"Pagamentos Avulsos"';

  if fCampoExiste('CADPAG', 'CTP_INCFIS') and (fCfgCtpUif = 'F') then
    Result := 'IF(IFNULL(P.CTP_INCFIS, "") <> "", "Pagamentos Fatura", ' + Result + ')'
end;

function TRepositorioContabil.fCarregaCtpAnt(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  LqryConsulta : TUniQuery ;
begin
  Result := Nil ;

  if ADadosAbertura.blnProvisao then
    exit ;

  if not fTabelaExiste('PAGANT') then
    exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   CTP_CODFOR_DEB AS CTP_CODFOR, ') ;
    LqryConsulta.SQL.Add('   CTP_NUMDUP_DEB AS CTP_NUMDUP, ') ;
    LqryConsulta.SQL.Add('   CTP_PARCEL_DEB AS CTP_PARCEL, ') ;
    LqryConsulta.SQL.Add('   CTP_CODEMP_DEB AS CTP_CODEMP, ') ;
    LqryConsulta.SQL.Add('   CTP_SEQBAI_DEB AS CTP_SEQBAI, ') ;
    LqryConsulta.SQL.Add('   CTP_SERIE_DEB  AS CTP_SERIE_ ') ;
    LqryConsulta.SQL.Add(' FROM PAGANT ') ;
    LqryConsulta.SQL.Add(' WHERE CTP_CREDEB = "D" ') ;
    if (ADadosAbertura.dtaDataInicial > 0) then
    begin
      LqryConsulta.SQL.Add(' AND CTP_DTAPAG_CRE BETWEEN :PAGINI AND :PAGFIN  ') ;
      LqryConsulta.ParamByName('PAGINI').AsDateTime := ADadosAbertura.dtaDataInicial;
      LqryConsulta.ParamByName('PAGFIN').AsDateTime := ADadosAbertura.dtaDataFinal;
    END ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('PAGANT.CTP_INCCTP')
      .fIncDoc(ADadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(ADadosAbertura.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.Open ;

    Result := fCriaClientDatset(LqryConsulta) ;
    Result.IndexFieldNames := 'CTP_CODFOR;CTP_NUMDUP;CTP_PARCEL;CTP_CODEMP;CTP_SEQBAI;CTP_SERIE_' ;
  finally
    FreeAndNil(LqryConsulta) ;
  end;

end;

function TRepositorioContabil.fCarregaCtpBanmcaTax(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  LqryConsulta : TUniQuery ;
begin
  result := Nil ;

  // somente CTP
  if ADadosAbertura.blnProvisao then
    exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, ' + fEmpresaGeracaoCtp('', FblnContabilizarPelaEmpBai) + ' AS CTP_CODEMP, IFNULL(CTP_SERIE_, "") AS CTP_SERIE_ ') ;
    LqryConsulta.SQL.Add(' FROM CADPAG ') ;
    LqryConsulta.SQL.Add(' INNER JOIN BANMCA ON CTB_SEQLAN = CTP_DOCBAI ') ;
    LqryConsulta.SQL.Add(' WHERE MCA_IDENTI = "VALTAX" ') ;

    TTrataIncDocContabil
     .New
     .fColunaIncDoc('CADPAG.AUTOINCREM')
     .fIncDoc(ADadosAbertura.strIncrementoCadPag)
     .fArrIncDoc(ADadosAbertura.arrIncDoc)
     .fQuerySql(LqryConsulta)
     .fExecute ;

    if (ADadosAbertura.dtaDataInicial > 0) then
    begin
      LqryConsulta.SQL.Add('   AND CADPAG.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryConsulta.ParamByName('DTAINI').AsDateTime := ADadosAbertura.dtaDataInicial;
      LqryConsulta.ParamByName('DTAFIN').AsDateTime := ADadosAbertura.dtaDataFinal;
    end;

    if (not fEmptyStr(ADadosAbertura.empresa.strCodigo)) then
    begin
      LqryConsulta.SQL.Add('   AND ' + fEmpresaGeracaoCtp('CADPAG.', FblnContabilizarPelaEmpBai) + ' = :CODEMP ') ;
      LqryConsulta.ParamByName('CODEMP').AsString := ADadosAbertura.empresa.strCodigo;
    end;

    LqryConsulta.Open ;

    Result := fCriaClientDatset(LqryConsulta) ;
    Result.IndexFieldNames := 'CTP_NUMDUP;CTP_PARCEL;CTP_CODFOR;CTP_CODEMP;CTP_SERIE_' ;
  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

function TRepositorioContabil.fCarregaCtpMovban(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  qryConsulta : TUniQuery ;
begin
  result := Nil ;

  If Not fConsideraCTP_AS_NaGeracaoDoCtp Then
    Exit;

  if fCfgCtp_as = 'A' then
  begin
    exit ;
  end;
  //
  qryConsulta := fCriaQuery ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(' SELECT BANCTP.AUTOINCREM, BANCTP.CTP_CODFOR, BANCTP.CTP_NUMDUP, BANCTP.CTP_PARCEL, BANCTP.CTP_CODEMP, BANCTP.CTP_SEQBAI, BANCTP.CTP_SERIE_, ') ;
    qryConsulta.SQL.Add('  (SELECT COUNT(*) > 1 ') ;
    qryConsulta.SQL.Add('   FROM BANCTP A INNER JOIN MOVBAN B ON A.CTB_SEQLAN = B.CTB_SEQLAN ') ;
    qryConsulta.SQL.Add('   WHERE A.CTB_SEQLAN = BANCTP.CTB_SEQLAN) AS BAIXA_MULTIPLA, ') ;
    qryConsulta.SQL.Add('  (SELECT SUM(CASE WHEN C.CTB_CREDEB = "C" THEN A.CTP_VALPAG ELSE -A.CTP_VALPAG END) <> 0 ') ;
    qryConsulta.SQL.Add('  FROM BANCTP B ') ;
    qryConsulta.SQL.Add('     LEFT JOIN BANCTP A ON ') ;
    qryConsulta.SQL.Add('        B.CTP_CODFOR = A.CTP_CODFOR AND ') ;
    qryConsulta.SQL.Add('        B.CTP_NUMDUP = A.CTP_NUMDUP AND ') ;
    qryConsulta.SQL.Add('        B.CTP_PARCEL = A.CTP_PARCEL AND ') ;
    qryConsulta.SQL.Add('        B.CTP_CODEMP = A.CTP_CODEMP AND ') ;
    qryConsulta.SQL.Add('        B.CTP_SEQBAI = A.CTP_SEQBAI AND ') ;
    qryConsulta.SQL.Add('        COALESCE(B.CTP_SERIE_, "") = COALESCE(A.CTP_SERIE_, "") ') ;
    qryConsulta.SQL.Add('      INNER JOIN MOVBAN C ON A.CTB_SEQLAN = C.CTB_SEQLAN ') ;
    qryConsulta.SQL.Add('  WHERE COALESCE(C.CTB_ORIGEM, "") <> "CTP" AND B.CTB_SEQLAN = BANCTP.CTB_SEQLAN ) AS TEM_ESTORNO, ') ;
    qryConsulta.SQL.Add('  CADPAG.CTP_PAGANT ') ;
    qryConsulta.SQL.Add(' FROM BANCTP ') ;
    qryConsulta.SQL.Add('     INNER JOIN CADPAG ON BANCTP.CTP_CODFOR = CADPAG.CTP_CODFOR AND ') ;
    qryConsulta.SQL.Add('                          BANCTP.CTP_NUMDUP = CADPAG.CTP_NUMDUP AND ') ;
    qryConsulta.SQL.Add('                          BANCTP.CTP_PARCEL = CADPAG.CTP_PARCEL AND ') ;
    qryConsulta.SQL.Add('                          BANCTP.CTP_CODEMP = CADPAG.CTP_CODEMP AND ') ;
    qryConsulta.SQL.Add('                          BANCTP.CTP_SEQBAI = CADPAG.CTP_SEQBAI AND ') ;
    qryConsulta.SQL.Add('                          COALESCE(BANCTP.CTP_SERIE_, "") = COALESCE(CADPAG.CTP_SERIE_, "") ') ;

    qryConsulta.SQL.Add('     INNER JOIN MOVBAN ON BANCTP.CTB_SEQLAN = MOVBAN.CTB_SEQLAN ') ;

    qryConsulta.SQL.Add(' WHERE MOVBAN.CTB_CREDEB <> "C" ') ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADPAG.AUTOINCREM')
      .fIncDoc(ADadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(ADadosAbertura.arrIncDoc)
      .fQuerySql(qryConsulta)
      .fExecute ;

    if (ADadosAbertura.dtaDataInicial > 0) then
    begin
      qryConsulta.SQL.Add('   AND CADPAG.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ') ;
      qryConsulta.ParamByName('DTAINI').AsDateTime := ADadosAbertura.dtaDataInicial;
      qryConsulta.ParamByName('DTAFIN').AsDateTime := ADadosAbertura.dtaDataFinal;
    end;

    if (not fEmptyStr(ADadosAbertura.empresa.strCodigo)) then
    begin
      qryConsulta.SQL.Add('   AND ' + fEmpresaGeracaoCtp('CADPAG.', FblnContabilizarPelaEmpBai) + ' = :CODEMP ') ;
      qryConsulta.ParamByName('CODEMP').AsString := ADadosAbertura.empresa.strCodigo;
    end;

    if (not ADadosAbertura.blnExportaUsoConsumo) then
    begin
      qryConsulta.SQL.Add('   AND CADPAG.CTP_USOCON = "N" ') ;
    end;

    qryConsulta.SQL.Add(' ORDER BY BANCTP.CTP_NUMDUP, BANCTP.CTP_CODFOR, BANCTP.CTP_CODEMP, BANCTP.CTP_PARCEL, BANCTP.CTP_SEQBAI, BANCTP.CTP_SERIE_, BANCTP.AUTOINCREM DESC ') ;

    qryConsulta.Open ;

    Result := fCriaClientDatset(qryConsulta) ;
    Result.IndexFieldNames := 'CTP_CODFOR;CTP_NUMDUP;CTP_PARCEL;CTP_CODEMP;CTP_SEQBAI;CTP_SERIE_' ;
  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

function TRepositorioContabil.fCarregaLogCtpAntecipado(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  LqryConsulta : TUniQuery ;
begin
  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT CTP_CODFOR, CTP_PARCEL, ' + fEmpresaGeracaoCtp('', FblnContabilizarPelaEmpBai) + ' AS CTP_CODEMP, CTP_DTACAD, CTP_NUMDUP ') ;
    LqryConsulta.SQL.Add(' FROM LOGCTP ') ;
    LqryConsulta.SQL.Add(' WHERE CTP_PAGANT  = "S" AND CTP_DTABAI IS NOT NULL ') ;

    if (not fEmptyStr(ADadosAbertura.empresa.strCodigo)) then
    begin
      LqryConsulta.SQL.Add('   AND ' + fEmpresaGeracaoCtp('', FblnContabilizarPelaEmpBai) + ' = :CODEMP ') ;
      LqryConsulta.ParamByName('CODEMP').AsString := ADadosAbertura.empresa.strCodigo;
    end;

    LqryConsulta.Open ;

    Result := fCriaClientDatset(LqryConsulta) ;
    Result.IndexFieldNames := 'CTP_CODFOR;CTP_PARCEL;CTP_CODEMP;CTP_DTACAD' ;
  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

function TRepositorioContabil.fCarregaOrigemCTP(
  const ADadosAbertura: TDadosAbertura): TUniClientDataSet;
var
  LqryConsulta : TUniQuery ;
begin
  result := Nil ;

  // somente CTP
  if ADadosAbertura.blnProvisao then
    exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP, IFNULL(CTP_SERIE_, "") AS CTP_SERIE_ ') ;
    LqryConsulta.SQL.Add(' FROM LOGCTP ') ;
    LqryConsulta.SQL.Add(' WHERE CTP_NOMFRM IN ("frmCadCtaPagar", "frmGerAutCtaPagar") ') ;
    LqryConsulta.SQL.Add('       AND CTP_DESCRI LIKE "INCLUSAO%" ') ;

    if Length(ADadosAbertura.arrIncDoc) > 0 then
    begin
      LqryConsulta.SQL.Add('   AND (CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP, CTP_DTACAD) IN ') ;
      LqryConsulta.SQL.Add('       (SELECT CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP, CTP_DTACAD FROM CADPAG WHERE AUTOINCREM IN (' + fArrIncDocToString(ADadosAbertura.arrIncDoc) + ') ) ') ;
    end
    else
    begin
      if (not ADadosAbertura.strIncrementoCadPag.IsEmpty) then
      begin
        LqryConsulta.SQL.Add('   AND (CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP, CTP_DTACAD) IN ') ;
        LqryConsulta.SQL.Add('       (SELECT CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP, CTP_DTACAD FROM CADPAG WHERE AUTOINCREM = :INCDOC) ') ;
        LqryConsulta.ParamByName('INCDOC').AsString := ADadosAbertura.strIncrementoCadPag;
      end;
    end ;

    if (ADadosAbertura.dtaDataInicial > 0) then
    begin
      LqryConsulta.SQL.Add('   AND LOGCTP.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryConsulta.ParamByName('DTAINI').AsDateTime := IncMonth(ADadosAbertura.dtaDataInicial, -12);
      LqryConsulta.ParamByName('DTAFIN').AsDateTime := IncMonth(ADadosAbertura.dtaDataFinal, 6);
    end;

    if (not fEmptyStr(ADadosAbertura.empresa.strCodigo)) then
    begin
      LqryConsulta.SQL.Add('   AND LOGCTP.CTP_CODEMP = :CODEMP ') ;
      LqryConsulta.ParamByName('CODEMP').AsString := ADadosAbertura.empresa.strCodigo;
    end;

    LqryConsulta.Open ;

    Result := fCriaClientDatset(LqryConsulta) ;
    Result.IndexFieldNames := 'CTP_NUMDUP;CTP_PARCEL;CTP_CODFOR;CTP_CODEMP;CTP_SERIE_' ;
  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

function TRepositorioContabil.fCfgCtpAgr: boolean;
begin
  result := False ; ///valor padrão
  if fConfiguracaoExiste('CTPAGR') then
  begin
    result := fCfgSis('CTPAGR', VarBoolean) ;
  end;
end;

function TRepositorioContabil.fColunaTipCtp(const ATabela:string): string;
begin
  result := '(CAST("001" AS CHAR(3))) AS CTP_TIPCTP' ;
  if not blnTipCtp then
  begin
    exit ;
  end;
  result := ATabela+'.CTP_TIPCTP' ;
end;

function TRepositorioContabil.fCondicaoUsarVeioNFQuandoValorEmCodVel: string;
begin
  if fUsarVeioNFQuandoValorEmCodVel = 'S' then
    result := 'TRUE'
  else
    result := 'FALSE' ;
end;

function TRepositorioContabil.fDescartaCptComRegistroNoCtpAntAvulso(
  const AqryConsulta: TUniQuery; const AcdsCtpAnt: TUniClientDataset): Boolean;
begin
  Result := False ;
  if AqryConsulta.FieldByName('TIPO_PAGAMENTO').AsString <> 'Pagamentos Avulsos' then
    Exit ;

  if AqryConsulta.FieldByName('CTP_PAGANT').AsString <> 'S' then
    Exit ;

  if not Assigned(AcdsCtpAnt) then
    Exit ;

  if not AcdsCtpAnt.FindKey([AqryConsulta.FieldByName('FOR_CODFOR').AsString,
                             AqryConsulta.FieldByName('CTP_NUMDUP').AsString,
                             AqryConsulta.FieldByName('CTP_PARCEL').AsString,
                             AqryConsulta.FieldByName('CTP_CODEMP').AsString,
                             AqryConsulta.FieldByName('CTP_SEQBAI').AsInteger,
                             AqryConsulta.FieldByName('SERIE_').AsString
                            ]) then
    Exit ;

  Result := True ;
end;

function TRepositorioContabil.fDescartaCtpComCadFisDuplicado(
  const AConsulta: TUniQuery;
  const ADictCtpFisSet: TDictCtpFisSet;
  const ADictFisIncRef: TDictFisInc
): Boolean;
var
  LCtpInc, LFisInc, LFisValido: string;
  LFisSet: TSetFisInc;
begin
  Result := False;

  if AConsulta.FieldByName('TIPO_PAGAMENTO').AsString <> 'Pagamentos Fatura' then
    Exit;

  LCtpInc := AConsulta.FieldByName('CTPINC').AsString;

  if not ADictCtpFisSet.TryGetValue(LCtpInc, LFisSet) then
    Exit;

  if LFisSet.Count <= 1 then
    Exit;

  LFisInc := AConsulta.FieldByName('FISINC').AsString;

  if not ADictFisIncRef.TryGetValue(LCtpInc, LFisValido) then
  begin
    Result := True;
    Exit;
  end;

  Result := LFisInc <> LFisValido;
end;

function TRepositorioContabil.fDescartarPrevisaoPCP(const AblnProvisao: boolean;
  const AstrPrevisao: string): boolean;
begin
  result := AblnProvisao and (fConsiderarPrevisoesDeContasAPagar = 'N') and (AstrPrevisao = 'S') ;
end;

end.
